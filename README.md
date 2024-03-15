# kubecon-paris-demos
k0s related demos for KubeCon Paris 2024

## Preparation

Install [Multipass](https://multipass.run/) to run local VMs.

## Demo structure

All demos have been made "airgapped" but to prepare the airgapping we need to "build" the local file server in online mode.

```bash
cd file-server
./download.sh
./file-server
```
