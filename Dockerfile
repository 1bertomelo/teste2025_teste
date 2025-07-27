# Etapa de build com .NET 8
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia o .csproj e restaura as dependências
COPY helloWorld/*.csproj ./helloWorld/
WORKDIR /src/helloWorld
RUN dotnet restore

# Copia o restante do projeto
COPY . .

# Publica o projeto
RUN dotnet publish -c Release -o /app/publish

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "helloWorld.dll"]
