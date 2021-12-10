# Docker functions
- running Azure functions in docker container
- tutorial here https://docs.microsoft.com/en-us/azure/azure-functions/create-first-function-cli-csharp?tabs=azure-cli%2Cin-process


## Build an image
```bash
docker build --pull -t dotnetfunctions:v1 .
docker run --rm -it -p 8000:80 dotnetfunctions:v1

```