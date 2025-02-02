# dometrain-url-shortner
This is a code along for building a URL shortner using .NET


## Infrastructure as Code


### Login into Azure
```bash
az login
```

### Create a resource Group

```bash
az group create --name dometrain-urlshortner-dev --location westeurope
```

### Create User for GitHub Actions
```bash
az ad sp create-for-rbac --name "GitHub-Actions-SP" \
                         --role contributor \
                         --scopes /subscriptions/9dd8273e-4f7b-48a7-8d49-c910e17f9622 \
                         --sdk-auth 
```

### Configure a federated identity credential on an app

