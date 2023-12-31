USE [Bankomat2]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 29/09/2023 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[masterPassword] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Banche]    Script Date: 29/09/2023 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banche](
	[denominazione] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[denominazione] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContiCorrenti]    Script Date: 29/09/2023 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContiCorrenti](
	[iban] [char](27) NOT NULL,
	[saldo] [decimal](8, 2) NOT NULL,
	[loginUtente] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iban] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Funzionalita]    Script Date: 29/09/2023 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Funzionalita](
	[nome] [nvarchar](255) NOT NULL,
	[descrizione] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FunzionalitaBanche]    Script Date: 29/09/2023 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FunzionalitaBanche](
	[nomeFunzionalita] [nvarchar](255) NOT NULL,
	[denominazioneBanca] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nomeFunzionalita] ASC,
	[denominazioneBanca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movimenti]    Script Date: 29/09/2023 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimenti](
	[idOperazione] [int] NOT NULL,
	[banca] [nvarchar](255) NOT NULL,
	[iban] [char](27) NOT NULL,
	[utente] [nvarchar](255) NOT NULL,
	[dataOperazione] [datetime] NOT NULL,
	[ammontare] [decimal](8, 2) NOT NULL,
	[tipo] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idOperazione] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Utenti]    Script Date: 29/09/2023 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Utenti](
	[loginUtente] [nvarchar](255) NOT NULL,
	[passwordUtente] [nvarchar](255) NOT NULL,
	[denominazioneBanca] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[loginUtente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContiCorrenti] ADD  DEFAULT ((0)) FOR [saldo]
GO
ALTER TABLE [dbo].[Movimenti] ADD  DEFAULT (getdate()) FOR [dataOperazione]
GO
ALTER TABLE [dbo].[ContiCorrenti]  WITH CHECK ADD FOREIGN KEY([loginUtente])
REFERENCES [dbo].[Utenti] ([loginUtente])
GO
ALTER TABLE [dbo].[FunzionalitaBanche]  WITH CHECK ADD FOREIGN KEY([denominazioneBanca])
REFERENCES [dbo].[Banche] ([denominazione])
GO
ALTER TABLE [dbo].[FunzionalitaBanche]  WITH CHECK ADD FOREIGN KEY([nomeFunzionalita])
REFERENCES [dbo].[Funzionalita] ([nome])
GO
ALTER TABLE [dbo].[Utenti]  WITH CHECK ADD FOREIGN KEY([denominazioneBanca])
REFERENCES [dbo].[Banche] ([denominazione])
GO
