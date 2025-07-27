# Etapa de build com .NET 9
FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /src

# Copia o .csproj e restaura dependências
COPY helloWorld/*.csproj ./helloWorld/
WORKDIR /src/helloWorld
RUN dotnet restore

# Copia o restante do código
COPY . .

# Publica o projeto
RUN dotnet publish -c Release -o /app/publish

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "helloWorld.dll"]
