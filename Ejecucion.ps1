. .\Carga2K.ps1 
###. .\Deprisa.ps1 

$ResourceGroup = @{
    Name= $NombreResourceGroup;
    Location= $Location;
    Tag = $Tags;
}

$Tags = @{
    Proyecto = $Proyecto;
    Ceco = $CeCo;
    Responsable = $Responsable;
    Ambiente = $Ambiente;
    FechaCreacion = $FechaCreacion;
}

$WebApp = @{
    ResourceGroupName = $NombreResourceGroup;
    Name = $NombreWebApp;
    appServicePlan = $NombreASP;
    Location = $Location;
}

$SQLDatabase = @{
    ResourceGroupName = $NombreResourceGroup;
    ServerName = $NombreSQLServer;
    DatabaseName = $NombreDB;
    Edition = $EditionDB;

}

$SQLServer = @{
    ResourceGroupName = $NombreResourceGroup;
    Location = $Location;
    ServerName = $NombreSQLServer;
}

$StorageAccount = @{
    ResourceGroupName = $NombreResourceGroup;
    Location = $Location;
    SKUName = $SkuName;
    Name = $StorageAccountNombre;
}

$Function = @{
    ResourceGroupName = $NombreResourceGroup;
    Location = $Location;
    Name= $NombreFuntion;
    ResourceType = $ResourceTypeNombre;
    Kind = "functionapp"
    Force = $true
}

$ApplicationInsight =@{
    ResourceGroupName = $NombreResourceGroup;
    Location = $Location;
    Name = $NombreApplicationInsight;
}

$ServicePlan = @{
    ResourceGroupName = $NombreResourceGroup;
    Name = $NombreASP;
    Location = $Location;
    Tier = $TierASP;
}

$VirtualMachine =@{
    ResourceGroupName = $NombreResourceGroup;
    Name = $NombreVM;
    Location = $Location;
    #VirtualNetworkName = $VNName;
    #SubNetName = $SNName;
}

$RedisCache = @{
    ResourceGroupName = $NombreResourceGroup;
    Name = $NombreRC;
    Location = $Location;
}

$propertyObj = @{
    Application_Type="web";
}

$resource =  @{
  ResourceName = $NombreApplicationInsight;
  ResourceGroupName = $NombreResourceGroup;
  Tag = $Tags;
  ResourceType = "Microsoft.Insights/components"; 
  Location = $Location;
  PropertyObject = $propertyObj;
  }

Function Start-Main(){
    Write-Host "Logging in...";
    Login-AzureRmAccount;
    
    #Write-Host "Selecting subscription '$subscriptionId'";
    #Select-AzureRmSubscription -SubscriptionID $subscriptionId;

    # Register Providers
    #if($resourceProviders.length) {
    #    Write-Host "Registering resource providers"
    #    foreach($resourceProvider in $resourceProviders) {
    #       RegisterRP($resourceProvider);
    #   }
    #}

    #Create or check for existing resource group
   $NombreResourceGroup = Get-AzureRmResourceGroup -Name $NombreResourceGroup -ErrorAction SilentlyContinue

   Write-Host $NombreResourceGroup
   if(!$NombreResourceGroup)
    {
        Write-Host "Resource group does not exist. We are going to create it on Location." $Location;
      if(!$Location) {
           $Location = Read-Host "resourceGroupLocation";
      }
      Write-Host "Creating resource group in location" $Location;
      New-AzureRmResourceGroup @ResourceGroup;
      
    }
    else{
        Write-Host "Using existing resource group" $NombreResourceGroup;
    }

    Write-Host "Creando ASP"
    #Create or check for existing ServicePlan
    $NombreASP = Get-AzureRmAppServicePlan -Name $NombreASP -ErrorAction SilentlyContinue
    if(!$NombreASP)
    {
        Write-Host "Service plan does not exist. We are going to create it on Location." $Location;
        New-AzureRmAppServicePlan @ServicePlan;
    }
    else{
        Write-Host "Using existing app service plan" $NombreASP;
    }


    #Create or check for existing web App
    $NombreWebApp = Get-AzureRmWebApp -Name $NombreWebApp -ErrorAction SilentlyContinue
    #Write-Host Test-AzureName -Name $NombreWebApp;
    if(!$NombreWebApp)
    #if(!Test-AzureName -Name $NombreWebApp)
    {
        Write-Host "Web App does not exist. We are going to create it on Location." $Location;
        New-azureRMWebApp @WebApp;
    }
    else{
        Write-Host "We cannot create a web app with the same name";
    }

    
    #Create or check for existing Application Insight
    
    $NombreApplicationInsight = Get-AzureRmResource -Name $NombreApplicationInsight -ErrorAction SilentlyContinue
    if(!$NombreApplicationInsight)
    {
        Write-Host "Application insight does not exist. We are going to create it on Location." $Location;
        New-AzureRmResource @resource -Force;
    }
    else{
        Write-Host "Using existing ApplicationInsight" $NombreApplicationInsight;
    }

    #No creamos servidor, porque este ya est· creado
    #New-AzureRmSqlServer @SQLServer;
    
    #Creamos la BD
     
    
    $NombreDB = Get-AzureRmResource -Name $NombreDB -ErrorAction SilentlyContinue
    if(!$NombreDB)
    {
        Write-Host "Database does not exist. We are going to create it on Location." $Location;
        New-AzureRmSqlDatabase @SQLDatabase;  
    }
    else{
        Write-Host "Using existing Database" $NombreApplicationInsight;
    }
    
    break;
}


### ------------------------------------Ejecuci√≥n-------------------------------------
### Excecution

Write-Host "prueba";
#Start Run Functions

try
{	

# Start the deployment
Write-Host "Starting deployment...";

	& Start-Main;
    break;
}
catch [System.Exception]
{
	Write-Error("The Script does not work :" + $_.Exception.Message)
	
}