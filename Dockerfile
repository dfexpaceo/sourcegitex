FROM microsoft/aspnetcore-build:2.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./WindowsFormsApp1/WindowsFormsApp1/
RUN dotnet restore

# Copy everything else and build
COPY . ./WindowsFormsApp1/WindowsFormsApp1/
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "aspnetapp.dll"]
