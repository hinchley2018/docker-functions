#LTS sdk 
# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:6.0 as build
WORKDIR /source

#copy csproj and restore as distinct layers
COPY *.sln .
COPY dotnet-functions/*.csproj ./dotnet-functions/
RUN dotnet restore

#copy everything else and build app
COPY dotnet-functions/. ./dotnet-functions
WORKDIR /source/dotnet-functions
RUN dotnet publish -c release -o /app --no-restore

#final stage image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT [ "dotnet","dotnet-functions.dll" ]