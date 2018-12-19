
### ******************************************************************************
### ***************************** CARGA2K ****************************************
### ******************************************************************************
### WebApp
### ApplicationInsight
### SQLDatabase
### ******************************************************************************


### ---------------------- Componentes a desplegar --------------------------------

###$SuscriptionNombre = "Avianca-dev-qa";
$SuscriptionNombre = "Free Trial";
$NombreResourceGroup = "az-rg-cargue2k-use-dev";
$Location = "East US";

###$nombreASE = "az-ase-use-dev";
$NombreASP = "azasplsusedev";

$NombreWebApp = "azwappcargue2kdev";

### $NombreFuntion = "";

$NombreSQLServer = "az-sql2a-server-dev";
$NombreDB = "az-sql2-bd-cargue2k-use-dev";

#$VersionSQLServer= "2018";
$EditionDB = "Basic";

### $StorageAccountNombre = "";
### $SkuName = "";    

$resourceProviders = @("microsoft.web", "Microsoft.Storage");


$Proyecto = "J2C Replatform";
$CeCo = "00000";
$Responsable = "Maria Fernanda Zuniga";
$Ambiente = "DEV";
$FechaCreacion = "01/12/2018";


$NombreApplicationInsight = "az-ai-cargue2k-use-dev"
###$ResourceTypeNombre      = "Microsoft.Web/Sites"
### $ServerID = "";
$TierASP= "Free";

$nombreVM = "pruebaVM";
$SOImage="CentOS-based 7.5";
$size = "B1s";
$VNName="myVNET";
$SNName="mySubNet";
$nombreRC = "pruebaRC";


