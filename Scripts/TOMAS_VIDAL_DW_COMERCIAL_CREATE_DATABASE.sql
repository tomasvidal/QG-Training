CREATE DATABASE [DW_COMERCIAL]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DW_COMERCIAL', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVERXP2019\MSSQL\DATA\DW_COMERCIAL.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DW_COMERCIAL_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVERXP2019\MSSQL\DATA\DW_COMERCIAL_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DW_COMERCIAL] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [DW_COMERCIAL] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET ARITHABORT OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [DW_COMERCIAL] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DW_COMERCIAL] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DW_COMERCIAL] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DW_COMERCIAL] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DW_COMERCIAL] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DW_COMERCIAL] SET  READ_WRITE 
GO
ALTER DATABASE [DW_COMERCIAL] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DW_COMERCIAL] SET  MULTI_USER 
GO
ALTER DATABASE [DW_COMERCIAL] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DW_COMERCIAL] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DW_COMERCIAL] SET DELAYED_DURABILITY = DISABLED 
GO
USE [DW_COMERCIAL]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [DW_COMERCIAL]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [DW_COMERCIAL] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
