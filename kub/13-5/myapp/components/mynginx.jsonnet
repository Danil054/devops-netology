
local p = import '../params.libsonnet';
local params = p.components.mynginx;

[
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: 'myapp',
      labels: {
        app: 'myapp',
      },
    },
    spec: {
      replicas: params.replicas,
      selector: {
        matchLabels: {
          app: 'myapp',
        },
      },
      template: {
        metadata: {
          labels: {
            app: 'myapp',
          },
        },
        spec: {
          containers: [
            {
              name: 'mynginx',
              image: params.img,
              imagePullPolicy: 'Always'
            }
          ]
        }
      }
    }
  },
  {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
      "name": "myappsvc"
    },
    "spec": {
      "selector": {
        "app": "myapp"
      },
      "ports": [
        {
          "port": 80
        }
      ]
    }
  }

]
