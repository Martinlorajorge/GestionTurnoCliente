USE [master]
GO
/****** Object:  Database [FaceRace]    Script Date: 30/5/2024 13:28:30 ******/
CREATE DATABASE [FaceRace]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FaceRace', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\FaceRace.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FaceRace_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\FaceRace_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [FaceRace] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FaceRace].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FaceRace] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FaceRace] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FaceRace] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FaceRace] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FaceRace] SET ARITHABORT OFF 
GO
ALTER DATABASE [FaceRace] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FaceRace] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FaceRace] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FaceRace] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FaceRace] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FaceRace] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FaceRace] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FaceRace] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FaceRace] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FaceRace] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FaceRace] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FaceRace] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FaceRace] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FaceRace] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FaceRace] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FaceRace] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FaceRace] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FaceRace] SET RECOVERY FULL 
GO
ALTER DATABASE [FaceRace] SET  MULTI_USER 
GO
ALTER DATABASE [FaceRace] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FaceRace] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FaceRace] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FaceRace] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FaceRace] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FaceRace] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'FaceRace', N'ON'
GO
ALTER DATABASE [FaceRace] SET QUERY_STORE = ON
GO
ALTER DATABASE [FaceRace] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [FaceRace]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 30/5/2024 13:28:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[ClienteId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Apellido] [nvarchar](50) NOT NULL,
	[DNI] [nvarchar](20) NOT NULL,
	[Telefono] [nvarchar](20) NOT NULL,
	[Correo] [nvarchar](100) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ClienteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Turnos]    Script Date: 30/5/2024 13:28:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Turnos](
	[TurnoId] [int] IDENTITY(1,1) NOT NULL,
	[ClienteId] [int] NULL,
	[FechaTurno] [datetime] NOT NULL,
	[Activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TurnoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_FechaTurno]    Script Date: 30/5/2024 13:28:30 ******/
CREATE NONCLUSTERED INDEX [IX_FechaTurno] ON [dbo].[Turnos]
(
	[FechaTurno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Clientes] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Turnos] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Turnos]  WITH CHECK ADD  CONSTRAINT [FK_Turnos_Clientes] FOREIGN KEY([ClienteId])
REFERENCES [dbo].[Clientes] ([ClienteId])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Turnos] CHECK CONSTRAINT [FK_Turnos_Clientes]
GO
ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD  CONSTRAINT [CK_Telefono] CHECK  (([Telefono] like '[0-9]%'))
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [CK_Telefono]
GO
USE [master]
GO
ALTER DATABASE [FaceRace] SET  READ_WRITE 
GO
