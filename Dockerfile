# Etapa responsável por compilar a aplicação
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build

WORKDIR /source

# Copia primeiro o arquivo do projeto para aproveitar o cache
COPY ["src/DevOps.Api/DevOps.Api.csproj", "src/DevOps.Api/"]

# Restaura as dependências
RUN dotnet restore "src/DevOps.Api/DevOps.Api.csproj"

# Copia o restante do repositório
COPY . .

# Publica a aplicação
RUN dotnet publish "src/DevOps.Api/DevOps.Api.csproj" \
    --configuration Release \
    --output /app/publish \
    --no-restore \
    /p:UseAppHost=false

# Etapa final contendo somente o runtime
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime

WORKDIR /app

ENV ASPNETCORE_URLS=http://+:8080

EXPOSE 8080

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "DevOps.Api.dll"]