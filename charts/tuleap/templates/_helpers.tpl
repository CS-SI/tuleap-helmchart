{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "tuleap.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "tuleap.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "tuleap.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
  Create a default fully qualified mailhog name.
  We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "mailhog.fullname" -}}
{{- printf "%s-%s" .Release.Name "mailhog" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
  Create a default fully qualified mysql name.
  We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "mysql.fullname" -}}
{{- printf "%s-%s" .Release.Name "mysql" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
  Determine the hostname to use for mySQL.
*/}}
{{- define "mysql.hostname" -}}
{{- if .Values.mysql.enabled -}}
{{- printf "%s-%s" .Release.Name "mysql" | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s" .Values.mysql.mysqlServer -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "tuleap.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "tuleap.labels" -}}
helm.sh/chart: {{ template "tuleap.chart" . }}
{{ template "tuleap.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "tuleap.selectorLabels" -}}
app.kubernetes.io/name: {{ template "tuleap.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "tuleap.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "tuleap.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the secret with Tuleap credentials
*/}}
{{- define "tuleap.secretName" -}}
    {{- if .Values.auth.existingSecret -}}
        {{- printf "%s" .Values.auth.existingSecret -}}
    {{- else -}}
        {{- printf "%s" (include "tuleap.fullname" .) -}}
    {{- end -}}
{{- end -}}

{{/*
Returns the available value for certain key in an existing secret (if it exists),
otherwise it generates a random value.
*/}}
{{- define "getValueFromSecret" }}
    {{- $len := (default 16 .Length) | int -}}
    {{- $obj := (lookup "v1" "Secret" .Namespace .Name).data -}}
    {{- if $obj }}
        {{- index $obj .Key | b64dec -}}
    {{- else -}}
        {{- randAlphaNum $len -}}
    {{- end -}}
{{- end }}

{{/*
Return true if a secret object should be created for Tuleap
*/}}
{{- define "tuleap.createSecret" -}}
{{- if not .Values.auth.existingSecret }}
    {{- true -}}
{{- end -}}
{{- end -}}


{{- define "tuleap.sys.db.password" -}}
    {{- if not (empty .Values.auth.sysdbPassword) }}
        {{- .Values.auth.sysdbPassword }}
    {{- else if (not .Values.auth.forcePassword) }}
        {{- include "getValueFromSecret" (dict "Namespace" .Release.Namespace "Name" (include "tuleap.fullname" .) "Length" 20 "Key" "tuleap-sys-db-password" ) }}
    {{- else }}
        {{- required "A Tuleap Sysdb Password is required!" .Values.auth.sysdbPassword}}
    {{- end }}
{{- end -}}

{{- define "tuleap.site.admin.password" -}}
    {{- if not (empty .Values.auth.adminPassword) }}
        {{- .Values.auth.adminPassword }}
    {{- else if (not .Values.auth.forcePassword) }}
        {{- include "getValueFromSecret" (dict "Namespace" .Release.Namespace "Name" (include "tuleap.fullname" .) "Length" 20 "Key" "tuleap-site-admin-password" ) }}
    {{- else }}
        {{- required "A Tuleap Site Admin Password is required!" .Values.auth.adminPassword }}
    {{- end }}
{{- end -}}
