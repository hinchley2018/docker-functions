#LTS sdk 
# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:6.0 as build
WORKDIR /source

#copy csproj and restore as distinct layers
COPY *.sln .
COPY dockerapi/*.csproj ./dockerapi/
RUN dotnet restore

#copy everything else and build app
COPY dockerapi/. ./dockerapi
WORKDIR /source/dockerapi
RUN dotnet publish -c release -o /app --no-restore

#final stage image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT [ "dotnet","dockerapi.dll" ]