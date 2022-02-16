# Tuleap Helm Chart

## About this Repo

This is the Git repo of the CS GROUP - France Helm Chart for [Tuleap](https://tuleap.org).  
The actual chart can be found in the [charts](charts/tuleap) directory and see the README of the chart for more information. 

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

  helm repo add tuleap https://CS-SI.github.io/tuleap-helmchart

If you had already added this repo earlier, run `helm repo update` to retrieve the latest versions of the packages.
You can then run `helm search repo tuleap` to see the charts.

To install the Tuleap chart:

    helm install my-tuleap tuleap/tuleap

To uninstall the chart:

    helm delete my-tuleap

# License

Copyright 2022, CS GROUP - France, https://www.csgroup.eu/

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
