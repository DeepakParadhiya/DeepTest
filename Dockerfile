#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

COPY . ./

RUN dotnet publish "GitHubCLI.csproj" -c Release -o /out

ENV PATH="$PATH:$HOME/.dotnet/tools/"

FROM mcr.microsoft.com/dotnet/sdk:6.0
COPY --from=build-env /out .
ENTRYPOINT ["dotnet", "/GitHubCLI.dll"]
