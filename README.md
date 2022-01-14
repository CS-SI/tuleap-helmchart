# Tuleap Helm Chart

## Introduction

This chart bootstraps a [Tuleap](https://github.com/bitnami/bitnami-docker-sonarqube) cluster on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.7.0
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install my-release cs/tuleap
```

The command deploys Tuleap on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the Tuleap chart and their default values.

### Global

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `deploymentType` | Deployment Type (supported values are `StatefulSet` or `Deployment`) | `Deployment` |
| `replicaCount`   | Number of replicas deployed  | `1` |
| `deploymentStrategy` | Deployment strategy | `{}` |
| `priorityClassName` | Schedule pods on priority (e.g. `high-priority`) | `None` |
| `schedulerName` | Kubernetes scheduler name | `None` |
| `affinity` | Node / Pod affinities | `{}` |
| `tolerations` | List of node taints to tolerate | `[]` |
| `nodeSelector` | Node labels for pod assignment | `{}` |
| `hostAliases` | Aliases for IPs in /etc/hosts | `[]` |
| `podLabels` | Map of labels to add to the pods | `{}` |
| `env` | Environment variables to attach to the pods | `{}`|
| `annotations` | Sonarqube Pod annotations | `{}` |

### Image

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `image.repository` | image repository | `tuleap/tuleap-community-edition` |
| `image.tag` | `sonarqube` image tag. | `latest` |
| `image.pullPolicy` | Image pull policy  | `IfNotPresent` |
| `image.pullSecret` | imagePullSecret to use for private repository | `None` |

### Security

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `securityContext.fsGroup` | Group applied to mounted directories/files | `1000` |
| `containerSecurityContext.runAsUser` | User to run containers in sonarqube pod as, unless overwritten (such as for init-sysctl container) | `1000` |

### Service

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `service.type` | Kubernetes service type | `ClusterIP` |
| `service.labels` | Kubernetes service labels | `None` |
| `service.annotations` | Kubernetes service annotations | `None` |
| `service.loadBalancerSourceRanges` | Kubernetes service LB Allowed inbound IP addresses | `None` |
| `service.loadBalancerIP` | Kubernetes service LB Optional fixed external IP | `None` |

### Ingress

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `ingress.enabled` | Flag to enable Ingress | `false` |
| `ingress.labels` | Ingress additional labels | `{}` |
| `ingress.hosts[0].name` | Hostname to your SonarQube installation | `sonarqube.your-org.com` |
| `ingress.hosts[0].path` | Path within the URL structure | `/` |
| `ingress.hosts[0].serviceName` | Optional field to override the default serviceName of a path | `None` |
| `ingress.hosts[0].servicePort` | Optional field to override the default servicePort of a path | `None` |
| `ingress.tls` | Ingress secrets for TLS certificates | `[]` |
| `ingress.ingressClassName` | Optional field to configure ingress class name | `None` |

### Probes

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `readinessProbe.initialDelaySecond` | ReadinessProbe initial delay for SonarQube checking | `60` |
| `readinessProbe.periodSeconds` | ReadinessProbe period between checking SonarQube | `30` |
| `readinessProbe.failureThreshold` | ReadinessProbe threshold for marking as failed | `6` |
| `livenessProbe.initialDelaySecond` | LivenessProbe initial delay for SonarQube checking | `60` |
| `livenessProbe.periodSeconds` | LivenessProbe period between checking SonarQube | `30` |
| `livenessProbe.failureThreshold` | LivenessProbe threshold for marking as dead | `6` |
| `startupProbe.initialDelaySecond` | StartupProbe initial delay for SonarQube checking | `30` |
| `startupProbe.periodSeconds` | StartupProbe period between checking SonarQube | `30` |
| `startupProbe.failureThreshold` | StartupProbe threshold for marking as failed | `24` |


### Resources

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `resources.requests.memory` | Tuleap memory request | `2Gi` |
| `resources.requests.cpu` | Tuleap cpu request | `400m` |
| `resources.limits.memory` | Tuleap memory limit | `4Gi` |
| `resources.limits.cpu` | Tuleap cpu limit | `800m` |

### Persistence

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `persistence.enabled` | Flag for enabling persistent storage | `false` |
| `persistence.annotations` | Kubernetes pvc annotations | `{}` |
| `persistence.existingClaim` | Do not create a new PVC but use this one | `None` |
| `persistence.storageClass` | Storage class to be used | `""` |
| `persistence.accessMode` | Volumes access mode to be set | `ReadWriteOnce` |
| `persistence.size` | Size of the volume | `5Gi` |
| `persistence.volumes` | Specify extra volumes. Refer to ".spec.volumes" specification | `[]` |
| `persistence.mounts` | Specify extra mounts. Refer to ".spec.containers.volumeMounts" specification | `[]` |
| `emptyDir` | Configuration of resources for `emptyDir` | `{}` |

### SMTP

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `smtpHost` | SMTP server host	| "" |
| `smtpPort` | SMTP server port | "" |
### Bundled Mysql Chart

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `mysql.enabled` | Set to `false` to use external server  | `true` |
| `mysql.auth.existingSecret` | Secret containing the password of the external Mysql server | `null` |
| `mysql.mysqlServer` | Hostname of the external Mysql server | `null` |
| `mysql.auth.rootPassword` | Mysql root password | `""` |
| `mysql.architecture` | MySQL architecture (`standalone` or `replication`) | `standalone` |

### Tests

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `tests.enabled` | Flag that allows tests to be excluded from generated yaml | `true` |
| `tests.image` | Change init test container image | `busybox` |

### ServiceAccount

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `serviceAccount.create` | If set to true, create a serviceAccount | `false` |
| `serviceAccount.name` | Name of the serviceAccount to create/use | `sonarqube-sonarqube` |
| `serviceAccount.annotations` | Additional serviceAccount annotations | `{}` |


You can also configure values for the Mysql database via the Mysql [Chart](https://hub.helm.sh/charts/bitnami/mysql)

For overriding variables see: [Customizing the chart](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing)

# License

Copyright 2022, CS GROUP - France, https://www.csgroup.eu/

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
