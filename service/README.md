# Service Helm Chart

### Package chart
```shell
helm package service --version 0.0.0 -d target
```

### Render chart templates
```shell
helm template service ./service --set image.repository=test --set image.tag=1 --output-dir target/manifests
```
