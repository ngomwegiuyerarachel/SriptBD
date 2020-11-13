create database Gestion_Suivi_Patient1

CREATE TABLE avenue(
	id int IDENTITY(1,1) NOT NULL,
	designation nvarchar(100) NULL,
	ref_quartier int Null,
	constraint pk_avenue primary key(id),
	constraint fk_quartier foreign key(ref_quartier)
	references quartier (id), 
	
)



CREATE TABLE quartier(
	id int IDENTITY(1,1) NOT NULL,
	designation nvarchar(100) NULL,
	ref_commune int Null,
	constraint pk_quartier primary key(id),
	constraint fk_commune foreign key(ref_commune)
	references commune (id), 
	
	
)


CREATE TABLE commune(
	id int IDENTITY(1,1) NOT NULL,
	designation nvarchar(100) NULL,
	ref_ville int Null,
	constraint pk_commune primary key(id),
	constraint fk_ville foreign key(ref_ville)
	references ville (id), 
	
)

go

CREATE TABLE ville(
            id int IDENTITY(1,1)NOT NULL,
            Designation nvarchar(50)NULL,
			ref_province int NULL,
            constraint pk_ville_1 primary key(id),
			constraint fk_province foreign key(ref_province)
			references province (id), 
)

go
CREATE TABLE province(
            id int IDENTITY(1,1)NOT NULL,
            Designation nvarchar(50)NULL,
			ref_pays int NULL,
            constraint pk_ville primary key(id),
			constraint fk_pays foreign key(ref_pays)
			references pays (id), 
)


go
CREATE TABLE pays(
            id int IDENTITY(1,1)NOT NULL,
            Designation nvarchar(50)NULL,
            constraint pk_pays primary key(id)
)
go

CREATE TABLE tMalade(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[noms] [nvarchar](100) NULL,
	[sexe] [varchar](10) NULL,
	[datenaissance] [date] NULL,
	[etatcivil] [nvarchar](100) NULL,
	[refAvenue] [int] NULL,
	[numeromaison] [nvarchar](100) NULL,
	[CategorieMalade] [nvarchar](100) NULL,
	[Fonction] [nvarchar](100) NULL,
	[Contact] [nvarchar](20) NULL,
	[Personneref] [nvarchar](100) NULL,
	[FonctionPresRef] [nvarchar](100) NULL,
	[ContactPersRef] [nvarchar](20) NULL,
	[photo] [image] NULL,
	[author] [nvarchar](100) NULL,
	[organisation] [nvarchar](100) NULL,
	[numerobon] [nvarchar](100) NULL,
	constraint pk_categorie_patient primary key(id),
	)
	go

	ALTER TABLE [dbo].[tMalade]  WITH CHECK ADD  CONSTRAINT [refAvenue] FOREIGN KEY([refAvenue])
REFERENCES [dbo].avenue ([id])
GO

ALTER TABLE [dbo].[tMalade] CHECK CONSTRAINT [refAvenue]
GO

CREATE TABLE [dbo].[tCategorieAgent](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
	[nombreHeure] [float] NULL,
	[author] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniqueCatAgent] UNIQUE NONCLUSTERED 
(
	[designation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[tFonction](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniqueFonction] UNIQUE NONCLUSTERED 
(
	[designation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


CREATE TABLE tAgent(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Matricule] [nvarchar](100) NULL,
	[noms] [nvarchar](100) NULL,
	[sexe] [varchar](10) NULL,
	[datenaissance] [date] NULL,
	[etatcivil] [nvarchar](100) NULL,
	[refAvenue] [int] NULL,
	[Grade] [nvarchar](100) NULL,
	[Fonction] [nvarchar](100) NULL,
	[Contact] [nvarchar](20) NULL,
	[Specialite] [nvarchar](100) NULL,
	[refCategorie] [int] NULL,
	[author] [nvarchar](100) NULL,
	[refFonction] [int] NULL,
	[mail] [nvarchar](100) NULL,
	[photo] [image] NULL,
	[niveauEtude] [nvarchar](100) NULL,
	[ProvinceOrigine] [nvarchar](100) NULL,
	[lieunaissance] [nvarchar](100) NULL,
	[Ecole] [nvarchar](100) NULL,
	[AnneefinEtude] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueMatriculeMedecin] UNIQUE NONCLUSTERED 
(
	[Matricule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueMedecin] UNIQUE NONCLUSTERED 
(
	[noms] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE tAgent  WITH CHECK ADD FOREIGN KEY([refCategorie])
REFERENCES [dbo].[tCategorieAgent] ([id])
GO

ALTER TABLE [dbo].tAgent  WITH CHECK ADD FOREIGN KEY([refCategorie])
REFERENCES [dbo].[tCategorieAgent] ([id])
GO

ALTER TABLE [dbo].[tAgent]  WITH CHECK ADD FOREIGN KEY([refFonction])
REFERENCES [dbo].[tFonction] ([id])
GO

ALTER TABLE [dbo].[tAgent]  WITH CHECK ADD  CONSTRAINT [refAvenue_Med] FOREIGN KEY([refAvenue])
REFERENCES [dbo].avenue ([id])
GO

ALTER TABLE [dbo].tAgent CHECK CONSTRAINT [refAvenue_Med]
GO

CREATE TABLE [dbo].[tCategorieMaladie](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniqueCatMaladie] UNIQUE NONCLUSTERED 
(
	[designation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[tMaladie](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
	[refCategorieMaladie] [int] NULL,
	[author] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniqueMaladie] UNIQUE NONCLUSTERED 
(
	[designation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tMaladie]  WITH CHECK ADD FOREIGN KEY([refCategorieMaladie])
REFERENCES [dbo].[tCategorieMaladie] ([id])
GO

ALTER TABLE [dbo].[tMaladie]  WITH CHECK ADD FOREIGN KEY([refCategorieMaladie])
REFERENCES [dbo].[tCategorieMaladie] ([id])
GO

CREATE TABLE [dbo].[tCategorieMedicament](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
	[author] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[tMedicament](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
	[prixUnitaire] [decimal](30, 3) NULL,
	[author] [nvarchar](100) NULL,
	[forme] [nvarchar](100) NULL,
	[refCategorie] [int] NULL,
	[typeMed] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniqueMedicament] UNIQUE NONCLUSTERED 
(
	[designation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniqueMedicementSVP] UNIQUE NONCLUSTERED 
(
	[designation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tMedicament]  WITH CHECK ADD FOREIGN KEY([refCategorie])
REFERENCES [dbo].[tCategorieMedicament] ([id])
GO

ALTER TABLE [dbo].[tMedicament]  WITH CHECK ADD FOREIGN KEY([refCategorie])
REFERENCES [dbo].[tCategorieMedicament] ([id])
GO

CREATE TABLE [dbo].[tTypeMalade](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniqueTypeMalade] UNIQUE NONCLUSTERED 
(
	[designation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[tMouvement](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[refMalade] [int] NULL,
	[refTypemalade] [int] NULL,
	[DateMouvement] [datetime] NULL,
	[author] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tMouvement] ADD  DEFAULT (getdate()) FOR [DateMouvement]
GO

ALTER TABLE [dbo].[tMouvement]  WITH CHECK ADD FOREIGN KEY([refMalade])
REFERENCES [dbo].[tMalade] ([id])
GO

ALTER TABLE [dbo].[tMouvement]  WITH CHECK ADD FOREIGN KEY([refMalade])
REFERENCES [dbo].[tMalade] ([id])
GO

ALTER TABLE [dbo].[tMouvement]  WITH CHECK ADD FOREIGN KEY([refTypemalade])
REFERENCES [dbo].[tTypeMalade] ([id])
GO

ALTER TABLE [dbo].[tMouvement]  WITH CHECK ADD FOREIGN KEY([refTypemalade])
REFERENCES [dbo].[tTypeMalade] ([id])
GO

CREATE TABLE [dbo].[tConsulter](
	[id] [int] IDENTITY(1,1) NOT NULL,
	refAgent [int] NULL,
	[refMouvement] [int] NULL,
	[DateConsultation] [datetime] NULL,
	[author] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tConsulter] ADD  DEFAULT (getdate()) FOR [DateConsultation]
GO

ALTER TABLE [dbo].[tConsulter]  WITH CHECK ADD FOREIGN KEY(refAgent)
REFERENCES [dbo].tAgent ([id])
GO

ALTER TABLE [dbo].[tConsulter]  WITH CHECK ADD FOREIGN KEY(refAgent)
REFERENCES [dbo].tAgent ([id])
GO

ALTER TABLE [dbo].[tConsulter]  WITH CHECK ADD FOREIGN KEY([refMouvement])
REFERENCES [dbo].[tMouvement] ([id])
GO

ALTER TABLE [dbo].[tConsulter]  WITH CHECK ADD FOREIGN KEY([refMouvement])
REFERENCES [dbo].[tMouvement] ([id])
GO

CREATE TABLE [dbo].[tTypeConsultation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
	[prix] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniqueTypeConsultation] UNIQUE NONCLUSTERED 
(
	[designation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[tDetailConsultation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[refConsultation] [int] NULL,
	[refTypeConsult] [int] NULL,
	[symptome] [nvarchar](100) NULL,
	[plainte] [nvarchar](200) NULL,
	[diagnostique] [nvarchar](200) NULL,
	[conduite] [nvarchar](200) NULL,
	[datedetailCons] [nvarchar](100) NULL,
	[author] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tDetailConsultation]  WITH CHECK ADD FOREIGN KEY([refConsultation])
REFERENCES [dbo].[tConsulter] ([id])
GO

ALTER TABLE [dbo].[tDetailConsultation]  WITH CHECK ADD FOREIGN KEY([refConsultation])
REFERENCES [dbo].[tConsulter] ([id])
GO

ALTER TABLE [dbo].[tDetailConsultation]  WITH CHECK ADD FOREIGN KEY([refTypeConsult])
REFERENCES [dbo].[tTypeConsultation] ([id])
GO

ALTER TABLE [dbo].[tDetailConsultation]  WITH CHECK ADD FOREIGN KEY([refTypeConsult])
REFERENCES [dbo].[tTypeConsultation] ([id])
GO

CREATE TABLE [dbo].[tCategorieExamen](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniqueCatExamen] UNIQUE NONCLUSTERED 
(
	[designation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[tExamen](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
	[refCategorieExam] [int] NULL,
	[author] [nvarchar](100) NULL,
	[prix] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tExamen]  WITH CHECK ADD FOREIGN KEY([refCategorieExam])
REFERENCES [dbo].[tCategorieExamen] ([id])
GO

ALTER TABLE [dbo].[tExamen]  WITH CHECK ADD FOREIGN KEY([refCategorieExam])
REFERENCES [dbo].[tCategorieExamen] ([id])
GO

CREATE TABLE [dbo].[tExamenAfaire](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[refdetailConsultation] [int] NULL,
	[refExamen] [int] NULL,
	[author] [nvarchar](100) NULL,
	[dateAffect] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tExamenAfaire] ADD  DEFAULT (getdate()) FOR [dateAffect]
GO

ALTER TABLE [dbo].[tExamenAfaire]  WITH CHECK ADD FOREIGN KEY([refdetailConsultation])
REFERENCES [dbo].[tDetailConsultation] ([id])
GO

ALTER TABLE [dbo].[tExamenAfaire]  WITH CHECK ADD FOREIGN KEY([refdetailConsultation])
REFERENCES [dbo].[tDetailConsultation] ([id])
GO

ALTER TABLE [dbo].[tExamenAfaire]  WITH CHECK ADD FOREIGN KEY([refExamen])
REFERENCES [dbo].[tExamen] ([id])
GO

ALTER TABLE [dbo].[tExamenAfaire]  WITH CHECK ADD FOREIGN KEY([refExamen])
REFERENCES [dbo].[tExamen] ([id])
GO

CREATE TABLE [dbo].[tdetailFaireExamen](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[refExamenAfaire] [int] NULL,
	[resultat] [nvarchar](200) NULL,
	[DateFaireExamen] [datetime] NULL,
	[Libelle] [nvarchar](200) NULL,
	[author] [nvarchar](100) NULL,
	[observation] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tdetailFaireExamen] ADD  DEFAULT (getdate()) FOR [DateFaireExamen]
GO

ALTER TABLE [dbo].[tdetailFaireExamen]  WITH CHECK ADD FOREIGN KEY([refExamenAfaire])
REFERENCES [dbo].[tExamenAfaire] ([id])
GO

ALTER TABLE [dbo].[tdetailFaireExamen]  WITH CHECK ADD FOREIGN KEY([refExamenAfaire])
REFERENCES [dbo].[tExamenAfaire] ([id])
GO

CREATE TABLE [dbo].[tTypeFrais](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniqueTypeFrais] UNIQUE NONCLUSTERED 
(
	[designation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[tPaiment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[refMouvement] [int] NULL,
	[DatePaie] [datetime] NULL,
	[author] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tPaiment] ADD  DEFAULT (getdate()) FOR [DatePaie]
GO

ALTER TABLE [dbo].[tPaiment]  WITH CHECK ADD FOREIGN KEY([refMouvement])
REFERENCES [dbo].[tMouvement] ([id])
GO

ALTER TABLE [dbo].[tPaiment]  WITH CHECK ADD FOREIGN KEY([refMouvement])
REFERENCES [dbo].[tMouvement] ([id])
GO


CREATE TABLE [dbo].[tTypePaiement](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[tPaieDetteMedicament](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[datepaie] [datetime] NULL,
	[montant] [float] NULL,
	[libelle] [nvarchar](100) NULL,
	[author] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[tDetailMedicament](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[refMediment] [int] NULL,
	[dateExpiration] [date] NULL,
	[quantite] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UniqueQuantitePar_date_Expiration] UNIQUE NONCLUSTERED 
(
	[refMediment] ASC,
	[dateExpiration] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tDetailMedicament]  WITH CHECK ADD FOREIGN KEY([refMediment])
REFERENCES [dbo].[tMedicament] ([id])
GO

ALTER TABLE [dbo].[tDetailMedicament]  WITH CHECK ADD FOREIGN KEY([refMediment])
REFERENCES [dbo].[tMedicament] ([id])
GO

CREATE TABLE [dbo].[tDetailPaiement](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[refPaiement] [int] NULL,
	[refTypeFrais] [int] NULL,
	[montant] [decimal](30, 2) NULL,
	[author] [nvarchar](100) NULL,
	[devise] [nvarchar](100) NULL,
	[taux] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tDetailPaiement]  WITH CHECK ADD FOREIGN KEY([refPaiement])
REFERENCES [dbo].[tPaiment] ([id])
GO

ALTER TABLE [dbo].[tDetailPaiement]  WITH CHECK ADD FOREIGN KEY([refPaiement])
REFERENCES [dbo].[tPaiment] ([id])
GO

ALTER TABLE [dbo].[tDetailPaiement]  WITH CHECK ADD FOREIGN KEY([refTypeFrais])
REFERENCES [dbo].[tTypeFrais] ([id])
GO

ALTER TABLE [dbo].[tDetailPaiement]  WITH CHECK ADD FOREIGN KEY([refTypeFrais])
REFERENCES [dbo].[tTypeFrais] ([id])
GO

CREATE TABLE [dbo].[tMois](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[tRubrique](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
	[Titre] [nvarchar](100) NULL,
	[Compte] [nvarchar](100) NULL,
	[Article] [nvarchar](100) NULL,
	[author] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[tDetailAffection](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[refRubrique] [int] NULL,
	[montant] [decimal](20, 2) NULL,
	[devise] [nvarchar](100) NULL,
	[taux] [float] NULL,
	[author] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniqueAffectRubrique] UNIQUE NONCLUSTERED 
(
	
	[refRubrique] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniquedetailRubrique] UNIQUE NONCLUSTERED 
(
	
	[refRubrique] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tDetailAffection]  WITH CHECK ADD FOREIGN KEY([refRubrique])
REFERENCES [dbo].[tRubrique] ([id])
GO

ALTER TABLE [dbo].[tDetailAffection]  WITH CHECK ADD FOREIGN KEY([refRubrique])
REFERENCES [dbo].[tRubrique] ([id])
GO


CREATE TABLE [dbo].[tDetailPaiementSal](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[refDetailAffectration] [int] NULL,
	[refMois] [int] NULL,
	[libelle] [nvarchar](100) NULL,
	[montant] [decimal](30, 2) NULL,
	[devise] [nvarchar](100) NULL,
	[taux] [decimal](30, 2) NULL,
	[author] [nvarchar](100) NULL,
	[refTypePaiement] [int] NULL,
	[idDepense] [bigint] NULL,
	[annee] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniquePaieMensuelPourPersonnel] UNIQUE NONCLUSTERED 
(
	[refDetailAffectration] ASC,
	[refMois] ASC,
	[annee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tDetailPaiementSal]  WITH CHECK ADD FOREIGN KEY([refDetailAffectration])
REFERENCES [dbo].[tDetailAffection] ([id])
GO

ALTER TABLE [dbo].[tDetailPaiementSal]  WITH CHECK ADD FOREIGN KEY([refDetailAffectration])
REFERENCES [dbo].[tDetailAffection] ([id])
GO

ALTER TABLE [dbo].[tDetailPaiementSal]  WITH CHECK ADD FOREIGN KEY([refMois])
REFERENCES [dbo].[tMois] ([id])
GO

ALTER TABLE [dbo].[tDetailPaiementSal]  WITH CHECK ADD FOREIGN KEY([refMois])
REFERENCES [dbo].[tMois] ([id])
GO

ALTER TABLE [dbo].[tDetailPaiementSal]  WITH CHECK ADD FOREIGN KEY([refTypePaiement])
REFERENCES [dbo].[tTypePaiement] ([id])
GO

ALTER TABLE [dbo].[tDetailPaiementSal]  WITH CHECK ADD FOREIGN KEY([refTypePaiement])
REFERENCES [dbo].[tTypePaiement] ([id])
GO

CREATE TABLE [dbo].[tUtilisateur](
	[code] [int] IDENTITY(1,1) NOT NULL,
	[nom] [nvarchar](50) NULL,
	[pass] [nvarchar](100) NULL,
	[niveau] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
create table tFacturation ( 
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[refMouvement] [int] NULL,
	[refTypeFrais] [int] NULL,
	[Montant] [decimal](30, 2) NULL,
	[TypeService] [nvarchar](100) NULL,
	[EstPaye] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tFacturation]  WITH CHECK ADD FOREIGN KEY([refMouvement])
REFERENCES [dbo].[tMouvement] ([id])
GO

ALTER TABLE [dbo].[tFacturation]  WITH CHECK ADD FOREIGN KEY([refMouvement])
REFERENCES [dbo].[tMouvement] ([id])
GO

ALTER TABLE [dbo].[tFacturation]  WITH CHECK ADD FOREIGN KEY([refTypeFrais])
REFERENCES [dbo].[tTypeFrais] ([id])
GO

ALTER TABLE [dbo].[tFacturation]  WITH CHECK ADD FOREIGN KEY([refTypeFrais])
REFERENCES [dbo].[tTypeFrais] ([id])
GO


CREATE TABLE [dbo].[tJours](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[designation] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



CREATE TABLE [dbo].[tJoursTravail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombreJours] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO















