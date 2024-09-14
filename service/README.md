# Service Helm Chart

### Show the chart info
```shell
helm show all oci://ghcr.io/sdobrovolschi/helm-charts/service --version 0.0.1
```

### Download the chart
```shell
helm pull oci://ghcr.io/sdobrovolschi/helm-charts/service --version 0.0.1
```

### Render chart templates
```shell
helm template service oci://ghcr.io/sdobrovolschi/helm-charts/service --version 0.0.1 \
  --set image.repository=service \
  --set image.tag=0.0.1
```
