# # Build stage
# FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
# WORKDIR /app

# # Copy csproj file and restore dependencies
# COPY *.csproj ./
# RUN dotnet restore

# # Copy the rest of the application and publish
# COPY . ./
# RUN dotnet publish -c Release -o /app/bin /p:PublishSingleFile=true /p:PublishTrimmed=true /p:PublishReadyToRun=true PlatformService.csproj

# # Final stage
# FROM mcr.microsoft.com/dotnet/aspnet:8.0
# WORKDIR /app
# COPY --from=build-env /app/bin ./
# EXPOSE 8080
# ENTRYPOINT [ "dotnet", "PlatformService.dll" ]




FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o /app/bin /p:PublishSingleFile=true /p:PublishTrimmed=true /p:PublishReadyToRun=true PlatformService.csproj

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out ./
ENTRYPOINT [ "dotnet", "PlatformService.dll" ]

