# Etapa de build com .NET 8
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia o .csproj e restaura as dependências
COPY helloWorld/helloWorld.csproj ./helloWorld/
RUN dotnet restore helloWorld/helloWorld.csproj

# Copia o restante do projeto
COPY . .

# Publica o projeto
RUN dotnet publish helloWorld/helloWorld.csproj -c Release -o /app/publish

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "helloWorld.dll"]
