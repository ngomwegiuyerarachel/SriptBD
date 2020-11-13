create procedure [dbo].[saveAvenue]
(
@id int,
@designation nvarchar(100),
@refQuartier int 
)as
begin

if @id in (select id from avenue)
begin
update avenue set designation=@designation,ref_quartier=@refQuartier where id=@id
end
else
begin
insert into avenue values (@designation,@refQuartier)
end
end


GO


create procedure [dbo].[saveCategorieExamen]
(
@id int,
@designation nvarchar(100)
) as
begin

if @id in (select id from tCategorieExamen)
begin
update tCategorieExamen set designation=@designation where id=@id
end
else
begin
insert into tCategorieExamen values (@designation)
end

end


GO

create procedure [dbo].[saveCategorieMaladie]
(
@id int,
@designation nvarchar(100)
)as
begin
if @id in (select id from tCategorieMaladie)
begin
update tCategorieMaladie set designation=@designation where id=@id
end
else
begin
insert into tCategorieMaladie values (@designation)
end

end


GO

CREATE procedure [dbo].[saveCategorieAgent]
 (
 @id int,
 @designation nvarchar(100),
 @nombreHeure float,
 @author nvarchar(100)
 )as
 begin
 if @id in (select id from tCategorieAgent)
 begin
 update tCategorieAgent set designation=@designation,nombreHeure=@nombreHeure,author=@author where id=@id
 end
 else
 begin
 insert into tCategorieAgent values (@designation,@nombreHeure,@author)
 end

 end



GO


CREATE procedure [dbo].[saveCatMedicament]
(
@id int,
@designation nvarchar(100),
@author nvarchar(100)
) as
begin

if @id in (select id from tCategorieMedicament)
begin
update tCategorieMedicament set designation=@designation,author=@author where id=@id
end
else
begin
insert into tCategorieMedicament values (@designation,@author)
end

end

GO


create procedure [dbo].[saveCommune]
(
@id int,
@designation nvarchar(100),
@refVille int 
)as
begin
if @id in (select id from commune)
begin
update commune set designation=@designation,ref_ville=@refVille where id=@id
end
else
begin
insert into commune values (@designation,@refVille)
end

end



GO


CREATE procedure [dbo].[saveConsulter]
(
@id int,
@refMedecin int,
@refMouvement int,
@author nvarchar(100)
) as
begin
if @refMouvement in (select tConsulter.refMouvement from tConsulter where cast(tConsulter.DateConsultation as date)=cast(Getdate() as date))
begin
DECLARE @err_message nvarchar(255)
SET @err_message = '!!! Vous ne pouvez pas envoyer une personne 2 fois à la CONSULTATION le même jour!'
	RAISERROR (@err_message, 11,1)
end
else
begin
if @id in (select id from tConsulter)
begin
update tConsulter set refAgent=@refMedecin,
refMouvement=@refMouvement,author=@author where id=@id
end
else
begin
insert into tConsulter values (@refMedecin,@refMouvement,GETDATE(),@author)
end
end
end


GO


CREATE procedure [dbo].[saveDetailConsultation]
(
@id int,
@refConsultation int,
@refTypeConsult int,
@symptome nvarchar(100),
@plainte nvarchar(200),
@diagnostique nvarchar(200),
@conduite nvarchar(200),
@datedetailCons nvarchar(100),
@author nvarchar(100)
) as 
begin

if @id in (select id from tDetailConsultation)
begin
update tDetailConsultation set refConsultation=@refConsultation,
refTypeConsult=@refTypeConsult,symptome=@symptome,plainte=@plainte,
diagnostique=@diagnostique,conduite=@conduite,author=@author where id=@id
end
else
begin

insert into tDetailConsultation values (@refConsultation,@refTypeConsult,@symptome,
@plainte,@diagnostique,@conduite,GETDATE(),@author)

end
end


GO

CREATE procedure [dbo].[savedetailFaireExamen]
(
@id int,
@refExamenAfaire int,
@resultat nvarchar(200),
@Libelle nvarchar(200),
@author nvarchar(100),
@observation nvarchar(100) 
) as
begin

if @id in (select id from tdetailFaireExamen)
begin
update tdetailFaireExamen set refExamenAfaire=@refExamenAfaire,
resultat=@resultat,Libelle=@Libelle,author=@author,observation=@observation where id=@id
end
else
begin
insert into tdetailFaireExamen values (@refExamenAfaire,@resultat,GETDATE(),@Libelle,@author,@observation)
end
end



GO



CREATE procedure [dbo].[saveDetailPaiement]
(
@id int,
@refPaiement int,
@refTypeFrais int,
@montant float,
@author nvarchar(100),
@devise nvarchar(100),
@taux float
) as
begin



	if @id in (select id from tDetailPaiement)
		begin
			update tDetailPaiement set refPaiement=@refPaiement,
			refTypeFrais=@refTypeFrais,montant=@montant,author=@author,devise=@devise,taux=@taux where id=@id
			end
			else
			begin
			insert into tDetailPaiement values (@refPaiement,@refTypeFrais,@montant,@author,@devise,@taux)  
		end

	--declare @refMouvement int;
	--declare @sommedejaPaie decimal(30,2);
	--declare @sommeApayer decimal(30,2);
	--DECLARE @err_message nvarchar(255);

	--declare @totalFacture decimal(30,2);
	
	--select @refMouvement= refMouvement from tPaiment where tPaiment.id=@refPaiement
	--select @sommedejaPaie= ISNULL(sum(montant),0) from vRapportPaiement 
	--where vRapportPaiement.refMouvement=@refMouvement and vRapportPaiement.refTypeFrais=@refTypeFrais

	--set @sommeApayer=@sommedejaPaie+@montant;

	--select @totalFacture= Montant from tFacturation 
	--where tFacturation.refMouvement=@refMouvement and tFacturation.refTypeFrais=@refTypeFrais

	--if(@sommeApayer <= @totalFacture)
	--begin
	--	if @id in (select id from tDetailPaiement)
	--	begin
	--	update tDetailPaiement set refPaiement=@refPaiement,
	--	refTypeFrais=@refTypeFrais,montant=@montant,author=@author,devise=@devise,taux=@taux where id=@id
	--	end
	--	else
	--	begin
	--	insert into tDetailPaiement values (@refPaiement,@refTypeFrais,@montant,@author,@devise,@taux) 
	--	end

	--	set @refMouvement=0;
	--	set @sommedejaPaie=0;
	--	set @sommeApayer=0;
	--	set @err_message='';

	--end
	--else
	--begin
	--	SET @err_message = 'Le montant depasse cel de la facture pour ce type de frais'
	--	RAISERROR (@err_message, 11,1)

	--	set @refMouvement=0;
	--	set @sommedejaPaie=0;
	--	set @sommeApayer=0;
	--	set @err_message='';
	--end



end 

GO

CREATE procedure [dbo].[saveExamen]
(
@id int,
@designation nvarchar(100),
@refCategorieExam int,
@author nvarchar(100),
@prix float
) as
begin

if @id in (select id from tExamen)
begin
update tExamen set designation=@designation,
refCategorieExam=@refCategorieExam,author=@author,prix=@prix where id=@id
end
else
begin
insert into tExamen values (@designation,@refCategorieExam,@author,@prix)
end
end


GO


CREATE procedure [dbo].[saveExamenAfaire]
(
@id int,
@refdetailConsultation int,
@refExamen int,
@author nvarchar(100)
) as 
begin

if @id in (select id from tExamenAfaire)
begin
update tExamenAfaire set refdetailConsultation=@refdetailConsultation,
refExamen=@refExamen,author=@author where id=id
end
else
begin
insert into tExamenAfaire values (@refdetailConsultation,@refExamen,@author,GETDATE())
end

end




GO

create procedure [dbo].[saveJoursTravail]
(
@id int ,
@nombreJours float
) as
begin

if @id in (select id from tJoursTravail)
begin
update tJoursTravail set nombreJours=@nombreJours where id=@id
end
else
begin
insert into tJoursTravail values (@nombreJours)
end

end


GO


CREATE procedure [dbo].[saveMaladie]
(
@id int,
@designation nvarchar(100),
@refCategorieMaladie int,
@author nvarchar(100)
) as 
begin
if @id in (select id from tMaladie)
begin
update tMaladie set designation=@designation,
refCategorieMaladie=@refCategorieMaladie,author=@author where id=@id
end
else
begin
insert into tMaladie values (@designation,@refCategorieMaladie,@author)
end

end


GO


CREATE procedure [dbo].[saveMalade]
(
@id int,
@noms nvarchar(100),
@sexe varchar(10),
@datenaissance date,
@etatcivil nvarchar(100),
@refAdresse int,
@numeromaison nvarchar(100),
@CategorieMalade nvarchar(100),
@Fonction nvarchar(100),
@Contact nvarchar(20),
@Personneref nvarchar(100),
@FonctionPresRef nvarchar(100),
@ContactPersRef nvarchar(20),
@photo image,
@author nvarchar(100),
@organisation nvarchar(100),
@numerobon nvarchar(100)
)as 
begin
if @id in (select id from tMalade)
begin
--==========CPN OPERATION JUST WHEN UPDATE===================
if((select noms from tMalade where id=@id) in (select NomsMere from tMere))
 begin
 update tMere set NomsMere=@noms,RefAvenue=@refAdresse,TelephoneMere=@Contact,EtatCivil=@etatcivil,Occupation=@Fonction,
 DateNaissance=@datenaissance,TypeMere='Mère',Photo=null,NumFiche=@id 
 WHERE NomsMere=(select noms from tMalade where id=@id)
 if(((select Personneref+' '+cast(@id as nvarchar(50)) from tMalade where id=@id) in (select Noms from tPere)) OR ((select Personneref from tMalade where id=@id) in (select Noms from tPere)))
 begin
 update tPere set Noms=@Personneref+' '+cast(@id as nvarchar(50)),TelephonePere=@ContactPersRef,FonctionPere=@FonctionPresRef,NumFiche_Associe=@id
 where tPere.Noms=(select Personneref from tMalade where id=@id) OR tPere.Noms=(select Personneref+' '+cast(tMalade.id as nvarchar(20)) from tMalade where id=@id)
 end
 else
 begin
insert into tPere(Noms,TelephonePere,FonctionPere,NumFiche_Associe) select tMalade.Personneref+' '+cast(@id as nvarchar(50)),
 tMalade.ContactPersRef,tMalade.FonctionPresRef,tMalade.id 
 from tMalade where tMalade.id=@id
 end
 end
 --=========================================
update tMalade set noms=@noms,sexe=@sexe,datenaissance=@datenaissance,
etatcivil=@etatcivil,refAvenue=@refAdresse,numeromaison=@numeromaison,CategorieMalade=@CategorieMalade,
Fonction=@Fonction,Contact=@Contact,Personneref=@Personneref,
FonctionPresRef=@FonctionPresRef,ContactPersRef=@ContactPersRef,
photo=@photo,author=@author,organisation=@organisation,numerobon=@numerobon where id=@id
end
else
begin
insert into tMalade values (@noms,@sexe,@datenaissance,@etatcivil,@refAdresse,@numeromaison,
@CategorieMalade,@Fonction,@Contact,@Personneref,@FonctionPresRef,@ContactPersRef,@photo,
@author,@organisation,@numerobon)
end

end





GO

CREATE procedure [dbo].[saveMedecin]
(
@id int,
@Matricule nvarchar(100),
@noms nvarchar(100),
@sexe varchar(10),
@datenaissance date,
@etatcivil nvarchar(100),
@refAdresse int,
@Grade nvarchar(100),
@Fonction nvarchar(100),
@Contact nvarchar(20),
@Specialite nvarchar(100),
@refCategorie int,
@author nvarchar(100),
@refFonction int,
@mail nvarchar(100),
@photo image,
@niveauEtude nvarchar(100),
@ProvinceOrigine nvarchar(100),
@lieunaissance nvarchar(100),
@Ecole nvarchar(100),
@AnneefinEtude nvarchar(100) 
) as
begin

if @id in (select id from tAgent)
begin
update tAgent set Matricule=@Matricule,noms=@noms,
sexe=@sexe,datenaissance=@datenaissance,etatcivil=@etatcivil,
refAvenue=@refAdresse,Grade=@Grade,Fonction=@Fonction,Contact=@Contact,
Specialite=@Specialite,refCategorie=@refCategorie,author=@author,
refFonction=@refFonction,mail=@mail,photo=@photo,niveauEtude=@niveauEtude,
ProvinceOrigine=@ProvinceOrigine,lieunaissance=@lieunaissance,Ecole=@Ecole,AnneefinEtude=@AnneefinEtude where id=@id
end
else
begin
insert into tAgent values (@Matricule,@noms,@sexe,@datenaissance,
@etatcivil,@refAdresse,@Grade,@Fonction,@Contact,@Specialite,@refCategorie,@author,
@refFonction,@mail,@photo,@niveauEtude,@ProvinceOrigine,@lieunaissance,@Ecole,@AnneefinEtude)
end
end


GO

CREATE procedure [dbo].[saveMedicament]
(
@id int,
@designation nvarchar(100),
--@couleur nvarchar(100),
--@dateFabrication date,
@prixUnitaire float,
@author nvarchar(100),
@forme nvarchar(100),
@refCategorie nvarchar(100),
@typeMed nvarchar(100)
) as
begin
if @id in (select id from tMedicament)
begin
update tMedicament set designation=@designation,
--couleur=@couleur,
--dateFabrication=@dateFabrication,
prixUnitaire=@prixUnitaire,author=@author,
forme=@forme,refCategorie=@refCategorie,typeMed=@typeMed
where id=@id
end
else
begin
insert into tMedicament values (@designation,
--@couleur,@dateFabrication,
@prixUnitaire,@author,@forme,@refCategorie,@typeMed)
end

end

--create procedure saveDetailMedicament
--(
--@id int primary key identity(1,1),
--@refMediment int foreign key references tMedicament(id),
--@dateExpiration datetime,
--@quantite float
--)

GO


CREATE procedure [dbo].[saveMouvement]
(
@id int,
@refMalade int,
@refTypemalade int,
@author nvarchar(100)
) as
 begin
 if @refMalade in (select tMouvement.refMalade from tMouvement where tMouvement.refTypemalade=@refTypemalade and cast(tMouvement.DateMouvement as date)=cast(Getdate() as date))
begin
DECLARE @err_message nvarchar(255)
SET @err_message = '!!! Vous ne pouvez pas enregistrer 2 mouvements de même type pour la même personne le même jour!'
	RAISERROR (@err_message, 11,1)
end
else
 begin
 if @id in (select id from tMouvement)
 begin
 update tMouvement set refMalade=@refMalade,
 refTypemalade=@refTypemalade,author=@author where id=@id
 end
 else
 begin
-- insert into tMouvement values (@refMalade,@refTypemalade,GETDATE(),@author)
-- --=================================INSERT FOR CPN and/OR CPS===============================
-- if((select designation from tTypeMalade where id=@refTypemalade)='CPN' 
-- or (select designation from tTypeMalade where id=@refTypemalade)='CPS'
-- or (select designation from tTypeMalade where id=@refTypemalade)='MATERNITE')
-- begin
-- if(select tMalade.noms from tMalade where tMalade.id=@refMalade) in (select NomsMere from tMere)
-- begin
-- print 'ok'
-- end
-- else
-- begin
--insert into tMere(NomsMere,RefAvenue,TelephoneMere,EtatCivil,Occupation,DateNaissance,TypeMere,Photo,NumFiche) select tMalade.noms,tMalade.refAvenue,tMalade.Contact,tMalade.etatcivil,tMalade.Fonction,tMalade.datenaissance,'Mère',null,tMalade.id from tMalade where tMalade.id=@refMalade
-- end
-- --====================test conjoint===============
-- if(select tMalade.Personneref+' '+cast(@refMalade as nvarchar(50)) from tMalade where tMalade.id=@refMalade) in (select Noms from tPere)
-- begin
-- print 'ok'
-- end
-- else
-- begin
-- insert into tPere(Noms,TelephonePere,FonctionPere,NumFiche_Associe) select tMalade.Personneref+' '+cast(@refMalade as nvarchar(50)),
-- tMalade.ContactPersRef,tMalade.FonctionPresRef,tMalade.id 
-- from tMalade where tMalade.id=@refMalade
-- end
-- end
insert into tMouvement values(@id ,@refMalade,@refTypemalade ,@author )
--@couleur,@dateFabrication,
end

end


GO

CREATE proc [dbo].[savePaiementAnnule]
(
@refDetailPaiement int,
@montant decimal(30,2),
@motif nvarchar(500),
@author nvarchar(100)
)as
begin
if @refDetailPaiement in (select refDetailPaiement from PaiementAnnuler)
begin
DECLARE @err_message nvarchar(255)
SET @err_message = 'Ce paiement a été déjà annulé'
	RAISERROR (@err_message, 11,1)
end
else
begin
insert into PaiementAnnuler(refDetailPaiement,montant,typeFrais,noms,motif,author) values (@refDetailPaiement,@montant,(select vDetailPaiement.Type_Frais from vDetailPaiement where vDetailPaiement.id=@refDetailPaiement),(select noms from vDetailPaiement where vDetailPaiement.id=@refDetailPaiement),@motif,@author)
delete from tDetailPaiement where id=@refDetailPaiement
end
end


GO


CREATE procedure [dbo].[savePaiment](
@id int,
@refMouvement int,
@author nvarchar(100)
) as 
begin
if @refMouvement in (select tPaiment.refMouvement from tPaiment where cast(tPaiment.DatePaie as date)=cast(Getdate() as date))
begin
DECLARE @err_message nvarchar(255)
SET @err_message = '!!! Vous ne pouvez pas envoyer une personne 2 fois à la CAISSE le même jour!'
	RAISERROR (@err_message, 11,1)
end
else
begin
if @id in (select id from tPaiment)
begin
update tPaiment set refMouvement=@refMouvement,author=@author where id=@id
end
else
begin
insert into tPaiment values (@refMouvement,GETDATE(),@author)
end
end
end



GO


create procedure [dbo].[savePays]
(
@id int ,
@designation nvarchar(100)
)as
begin

if @id in (select id from pays)
begin
update pays set designation=@designation where id=@id
end 
else
begin
insert into tPays values (@designation)
end
end


GO

create procedure [dbo].[saveProvince]
(
@id int,
@designation nvarchar(100),
@refPays int 
)as
begin

if @id in (select id from province)
begin
update province set designation=@designation,ref_pays=@refPays where id=@id
end
else
begin
insert into province values (@designation,@refPays)
end
end



GO

create procedure [dbo].[saveQuartier]
(
@id int,
@designation nvarchar(100),
@refCommune int 
)as
begin

if @id in (select id from quartier)
begin
update quartier set designation=@designation,ref_commune=@refCommune where id=@id
end
else
begin
insert into quartier values (@designation,@refCommune)
end
end



GO

CREATE procedure [dbo].[saveTypeConsultation]
(
@id int,
@designation nvarchar(100),
@prix float
) as
begin

if @id in (select id from tTypeConsultation)
begin
update tTypeConsultation set designation=@designation,prix=@prix where id=@id
end
else
begin
insert into tTypeConsultation values (@designation,@prix)
end

end



GO


create procedure [dbo].[saveTypeFrais]
(
@id int,
@designation nvarchar(100)
) as
begin
if @id in (select id from tTypeFrais)
begin
update tTypeFrais set designation=@designation where id=@id
end
else
begin
insert into tTypeFrais values (@designation)
end
end


GO



create procedure [dbo].[saveTypeMalade](
@id int,
@designation nvarchar(100)
)
as
begin
if @id in (select id from tTypeMalade)
begin
update tTypeMalade set designation=@designation where id=@id
end 
else
begin
insert into tTypeMalade values (@designation)
end
end


GO

create procedure [dbo].[saveVille]
(
@id int,
@designation nvarchar(100),
@refProvince int 
) as
begin

if @id in (select id from ville)
begin
update ville set designation=@designation,ref_province=@refProvince where id=@id
end

end



GO

CREATE procedure [dbo].[saveUser](@code INT,@nom VARCHAR(50), @pass VARCHAR(50),@niveau VARCHAR(50))AS
	begin
	merge INTo  tutilisateur using(values(@code ,@nom, @pass ,@niveau )) AS nelsON (a,b,c,d) ON tutilisateur.code =nelsON.a
							when matched then
			    update set nom=nelsON.b, niveau=nelsON.d,pass=hAShbytes('sha2_512',nelsON.c)
						when not matched then

				insert  values(b,hAShbytes('sha2_512',nelsON.c),d);
	end



GO


CREATE PROCEDURE [dbo].[SP_Login](@nom VARCHAR(50),@pass VARCHAR(50))
	AS
	BEGIN
		SELECT nom,pass,niveau FROM tUtilisateur WHERE nom=@nom
		 AND pass=HASHBYTES('SHA2_512',@pass)

	END


GO

create procedure [dbo].[sp_getRapportExamenLabo](@date1 date,@date2 date) as
 begin
 select id,designation,vExamen.Categorie,vExamen.refCategorieExam,
 ISNULL(((select _nombre from fn_get_ExamenRealiser(@date1,@date2) where _refexamen=id)),0)  as nombreExamenRealiser,
 ISNULL(((select _nombre from fn_get_ExamenPositif(@date1,@date2) where _refexamen=id)),0)  as nombreExamenPositif 
   from vExamen
 end


GO


CREATE procedure [dbo].[sp_getRapportMedicament](@date1 date,@date2 date) as
 begin
 select id,designation,Categorie,refCategorie,
 ISNULL(((select _nombre from fn_get_SommationMedicamentSI(@date1,@date2) where _refMedicament=id)),0)  as SI,
 ISNULL(((select _nombre from fn_get_SommationMedicamentSortie(@date1,@date2) where _refMedicament=id)),0)  as Sortie,
 ISNULL(((select _nombre from fn_get_SommationMedicamentEntree(@date1,@date2) where _refMedicament=id)),0)  as Entree,
 ISNULL(((select _nombre from fn_get_SommationMedicamentRupture(@date1,@date2) where _refMedicament=id)),0)  as nbrJourRupture,
 ISNULL(((select _nombre from fn_get_SommationMedicamentPerte(@date1,@date2) where _refMedicament=id)),0)  as Perte,
 ((ISNULL(((select _nombre from fn_get_SommationMedicamentSI(@date1,@date2) where _refMedicament=id)),0))+
 (ISNULL(((select _nombre from fn_get_SommationMedicamentEntree(@date1,@date2) where _refMedicament=id)),0))-
 (ISNULL(((select _nombre from fn_get_SommationMedicamentSortie(@date1,@date2) where _refMedicament=id)),0))-
 (ISNULL(((select _nombre from fn_get_SommationMedicamentPerte(@date1,@date2) where _refMedicament=id)),0))) as SF,
 (ISNULL(((select _nombre from fn_get_SommationMedicamentSortie(@date1,@date2) where _refMedicament=id)),0)-
 ISNULL(((select _nombre from fn_get_SommationMedicamentPerte(@date1,@date2) where _refMedicament=id)),0)) as QteAdministre
   from vMedicamentWithCat

 end

 CREATE procedure [dbo].[updateDetailPaiement]
(
@id int,
@refDetailAffectration int,
@refMois int,
@libelle nvarchar(100),
@montant float,
@devise nvarchar(100),
@taux float,
@author nvarchar(100),
@refTypePaiement int
) as
begin

	if @id in (select id from tDetailPaiementSal)
	begin
		update tDetailPaiementSal set 
		refDetailAffectration=@refDetailAffectration,refMois=@refMois,
		libelle=@libelle,montant=@montant,devise=@devise,taux=@taux,author=@author,refTypePaiement=@refTypePaiement where id=@id
	end
	else
	begin
		--insert into tDetailPaiement values (@refEntetePaie,@refDetailAffectration,
		--@refMois,@libelle,@montant,@devise,@taux,@author)
		print ''
	end

end


GO

create procedure [dbo].[updateTraiement]
(
@id int,
@conduite nvarchar(100)
)as
begin
update tDetailConsultation set conduite=@conduite where id=@id
end

GO

CREATE view [dbo].[vAffectationConsultation] AS
select  tConsulter.id,tMalade.noms as Malade,DATEDIFF(year,tMalade.datenaissance,getdate()) as Age,
tMalade.sexe,CategorieMalade,organisation as Organisation,tTypeMalade.designation as TypeMouvement,tConsulter.DateConsultation as DateAffect,tAgent.noms as Medecin,
tConsulter.refAgent,tConsulter.refMouvement,tConsulter.author from tConsulter
inner join tMouvement on tConsulter.refMouvement=tMouvement.id
inner join tMalade on tMalade.id=tMouvement.refMalade
inner join tAgent on tAgent.id=tConsulter.refAgent
inner join tTypeMalade on tTypeMalade.id=tMouvement.refTypemalade
--order by tConsulter.refMouvement desc
--where tConsulter.DateConsultation between cast(getdate()-1 as date) and cast(getdate()+1 as date)



GO


CREATE view [dbo].[vConsultation] as
select tDetailConsultation.id,tMalade.noms,tDetailConsultation.datedetailCons as date_consultation,
tDetailConsultation.plainte,tDetailConsultation.symptome,tDetailConsultation.diagnostique,
tDetailConsultation.conduite,tTypeConsultation.designation as Type_Consultation,
tDetailConsultation.refConsultation,tDetailConsultation.refTypeConsult,tDetailConsultation.author,
CategorieMalade,organisation as Organisation from tDetailConsultation
inner join tConsulter on tDetailConsultation.refConsultation=tConsulter.id
inner join tMouvement on tMouvement.id=tConsulter.refMouvement
inner join tMalade on tMouvement.refMalade=tMalade.id
inner join tTypeConsultation on tDetailConsultation.refTypeConsult=tTypeConsultation.id

GO




CREATE view [dbo].[vAffectationMaladie] as
select tSouffrerMaladie.id,vConsultation.noms,tMaladie.designation as Maladie,tSouffrerMaladie.refdetailConsultation as Numero_Consultation from tSouffrerMaladie
inner join vConsultation on vConsultation.id=tSouffrerMaladie.refdetailConsultation
inner join tMaladie on tMaladie.id=tSouffrerMaladie.refMaladie

GO


CREATE TABLE [dbo].[tSouffrerMaladie](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[refdetailConsultation] [int] NULL,
	[refMaladie] [int] NULL,
	[author] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tSouffrerMaladie]  WITH CHECK ADD FOREIGN KEY([refdetailConsultation])
REFERENCES [dbo].[tDetailConsultation] ([id])
GO

ALTER TABLE [dbo].[tSouffrerMaladie]  WITH CHECK ADD FOREIGN KEY([refdetailConsultation])
REFERENCES [dbo].[tDetailConsultation] ([id])
GO

ALTER TABLE [dbo].[tSouffrerMaladie]  WITH CHECK ADD FOREIGN KEY([refMaladie])
REFERENCES [dbo].[tMaladie] ([id])
GO

create procedure [dbo].[saveSouffrerMaladie]
(
@id int,
@refdetailConsultation int,
@refMaladie int,
@author nvarchar(100)
) as
begin
if @id in (select id from tSouffrerMaladie)
begin
update tSouffrerMaladie set refdetailConsultation=@refdetailConsultation,
refMaladie=@refMaladie,author=@author where id=@id
end
else
begin
insert into tSouffrerMaladie values (@refdetailConsultation,@refMaladie,@author)
end

end


GO

ALTER TABLE [dbo].[tSouffrerMaladie]  WITH CHECK ADD FOREIGN KEY([refMaladie])
REFERENCES [dbo].[tMaladie] ([id])
GO


create view [dbo].[vAvenue] as 
select avenue.id as id_p,avenue.designation as design,avenue.ref_quartier,quartier.designation from avenue inner join quartier on avenue.ref_quartier=quartier.id


GO
create view [dbo].[vComptageMedecin] as
 select refCategorie,COUNT(id) as nombre from tAgent
 group by refCategorie

GO

create view [dbo].[vCategorieMedecin] as
 select id,designation,ISNULL(nombre,0) as nombreMedecin from tCategorieAgent
 left join vComptageMedecin on vComptageMedecin.refCategorie=tCategorieAgent.id

GO

create view [dbo].[vCommune] as 
select commune.id as id_p,commune.designation as design,commune.ref_ville,ville.designation from commune inner join ville on ville.id=commune.ref_ville


GO

CREATE view [dbo].[vMouvement] as
select tMouvement.id,tMalade.noms,tMouvement.DateMouvement,tTypeMalade.designation as Type_,
tMouvement.refMalade,tMouvement.refTypemalade from tMouvement
INNER JOIN tMalade on tMalade.id=tMouvement.refMalade
INNER JOIN tTypeMalade on tTypeMalade.id=tMouvement.refTypemalade


GO

create view [dbo].[vConsulter] as
select tConsulter.id,tAgent.noms as Medecin,tAgent.Grade as GradeMedecin,
tAgent.Fonction as FonctionMedecin,tAgent.Contact as ContactMedecin,
tAgent.Specialite as SpecialiteMedecin,vMouvement.noms as Malade,
vMouvement.DateMouvement as DAteMouvement,
vMouvement.Type_ as TypeMalade,DateConsultation,tConsulter.author,
refAgent,refMouvement,vMouvement.refMalade as IdMalade,vMouvement.refTypemalade from tConsulter
inner join tAgent on tAgent.id=tConsulter.refAgent
inner join vMouvement on vMouvement.id=tConsulter.refMouvement

GO



--CREATE view [dbo].[vDetailAffectation] as
--select tDetailAffection.id,nomPres,Bureau,ServiceBureau,
--tRubrique.designation as Rubrique,montant,devise,taux,tDetailAffection.author,
--section1,section2,dateaffect,refService,matricule,niveauEtude,datenaissance,
--ProvinceOrigine,lieunaissance,sexe,etatcivil,adresse,refAffectation,
--refFonction,telephone,mail,vEnteteAffectation.Fonction as Fonction,photo,
--refPersonnel,refRubrique,refBureau,Actenommee,Actecommis,Structure,TypePrime,
--TypeSalaire,SIFA,specialite,Ecole,AnneefinEtude from tDetailAffection
--inner join vEnteteAffectation on vEnteteAffectation.id=tDetailAffection.refAffectation
--inner join tRubrique on tRubrique.id=tDetailAffection.refRubrique

--GO



CREATE view [dbo].[vMalade] as
select tMalade.id,noms,sexe,datenaissance,etatcivil,CategorieMalade,organisation,numerobon,Fonction,
Contact,Personneref,FonctionPresRef,ContactPersRef,avenue.designation as Avenue,
quartier.designation as Quartier,commune.designation as Commune,ville.designation as Ville,
province.designation as Province,pays.designation as Pays,numeromaison,photo,refAvenue,
quartier.id as refQuartier,commune.id as idCommune,ville.id as idVille,
province.id idProvince,pays.id as idPays from tMalade 
 left join avenue on avenue.id=tMalade.refAvenue
 inner join quartier on avenue.ref_quartier=quartier.id
 inner join commune on quartier.ref_commune=commune.id
 inner join ville on commune.ref_ville=ville.id
 inner join province on ville.ref_province=province.id
 inner join pays on province.ref_pays=pays.id



GO

CREATE view [dbo].[vInfoMouvement] as
select tMouvement.id,refMalade,refTypemalade,DateMouvement,author  
,noms as Malade,sexe,datenaissance,etatcivil,CategorieMalade,organisation,numerobon,Fonction,
Contact,Personneref,FonctionPresRef,ContactPersRef,Avenue,
Quartier,Commune,Ville,Province,Pays,numeromaison,photo,refAvenue,
refQuartier,idCommune,idVille, idProvince,idPays,
datediff(YEAR,datenaissance,GETDATE()) as Age,'Q.'+Quartier+', Av.'+Avenue as Adresse,
tTypeMalade.designation as TypeMaladeMvt from tMouvement
inner join vMalade on vMalade.id=tMouvement.refMalade
inner join tTypeMalade on tTypeMalade.id=tMouvement.refTypemalade


GO




CREATE view [dbo].[vDetailCOnsultation] as
select tDetailConsultation.id,refAgent,refMouvement,DateConsultation,tAgent.noms as Medecin,refMalade,refTypemalade,DateMouvement  
,Malade,vInfoMouvement.sexe,vInfoMouvement.datenaissance,vInfoMouvement.etatcivil,
CategorieMalade,organisation,numerobon,vInfoMouvement.Fonction,
vInfoMouvement.Contact,Personneref,FonctionPresRef,ContactPersRef,Avenue,
Quartier,Commune,Ville,Province,Pays,numeromaison,vInfoMouvement.photo,vInfoMouvement.refAvenue,
refQuartier,idCommune,idVille, idProvince,idPays,
Age,Adresse,

  refConsultation,refTypeConsult,tTypeConsultation.designation as TypeConsulation,
  tTypeConsultation.prix as PrixConsulataion,symptome,plainte,diagnostique,conduite as Traitement,
  datedetailCons   from tDetailConsultation

  inner join tTypeConsultation on tTypeConsultation.id=tDetailConsultation.refTypeConsult
  inner join tConsulter on tConsulter.id=tDetailConsultation.refConsultation
  inner join tAgent on tAgent.id=tConsulter.refAgent
  inner join vInfoMouvement on vInfoMouvement.id=tConsulter.refMouvement


GO

CREATE view [dbo].[vDetailMedicament] as
select tDetailMedicament.id,tMedicament.designation as Medicament,tMedicament.forme,tDetailMedicament.quantite,tMedicament.prixUnitaire,tDetailMedicament.dateExpiration,tDetailMedicament.refMediment as refMedicament from tDetailMedicament
inner join tMedicament on tMedicament.id=tDetailMedicament.refMediment


GO


CREATE view [dbo].[vDetailPaiement] as
select tDetailPaiement.id,vMouvement.noms,tPaiment.DatePaie as Date_Affect,tDetailPaiement.montant,tTypeFrais.designation as Type_Frais,tDetailPaiement.refPaiement as ID_entete from tPaiment
INNER JOIN vMouvement on tPaiment.refMouvement=vMouvement.id
LEFT JOIN tDetailPaiement on tDetailPaiement.refPaiement=tPaiment.id
LEFT JOIN tTypeFrais on tDetailPaiement.refTypeFrais=tTypeFrais.id
--where tDetailPaiement.id not in (select refDetailPaiement from PaiementAnnuler)


GO



--CREATE view [dbo].[vDetailPaiementSal] as
--select tDetailPaiementSal.id as datepaiement,
--nomPres,tTypePaiement.designation as TypePaiement,Bureau,ServiceBureau,Rubrique,
--tMois.designation as Mois,libelle,tDetailPaiementSal.montant as montantPaie,
--tDetailPaiementSal.devise as devisePaie,tDetailPaiementSal.taux as tauxpaie,tDetailPaiementSal.author as authorPaie,
--vDetailAffectation.montant as montantPrev,vDetailAffectation.devise as devisePrev,
--vDetailAffectation.taux as tauxPrev,section1,section2,dateaffect,refService,matricule,niveauEtude,datenaissance,
--ProvinceOrigine,lieunaissance,sexe,etatcivil,adresse,refAffectation,
--refFonction,telephone,mail,vDetailAffectation.Fonction as Fonction,photo,refPersonnel,refRubrique,refEntetePaie,refMois,
--refDetailAffectration,idDepense,refTypePaiement,refBureau from tDetailPaiementSal
--inner join vDetailAffectation on vDetailAffectation.id=tDetailPaiementSal.refDetailAffectration
--inner join tMois on tMois.id=tDetailPaiementSal.refMois
--inner join tTypePaiement on tTypePaiement.id=tDetailPaiementSal.refTypePaiement

--GO




--CREATE view [dbo].[vDetailPerteMedicament] as
--select tPerte.id,refArticle,datePerte,tPerte.quantite,typeGaspillage,tPerte.author,
--tMedicament.designation as Medicament,tMedicament.forme,tCategorieMedicament.designation as Categorie,tMedicament.id as IdMedicament from tPerte
--inner join tDetailMedicament on tDetailMedicament.id=tPerte.refArticle
--inner join tMedicament on tMedicament.id=tDetailMedicament.refMediment
--inner join tCategorieMedicament on tCategorieMedicament.id=tMedicament.refCategorie

--GO


CREATE view [dbo].[vDetailTraimenet] as
select conduite as Traitement   from tDetailConsultation
inner join tTypeConsultation on tTypeConsultation.id=tDetailConsultation.refTypeConsult
inner join tConsulter on tConsulter.id=tDetailConsultation.refConsultation
inner join tAgent on tAgent.id=tConsulter.refAgent
inner join vInfoMouvement on vInfoMouvement.id=tConsulter.refMouvement

GO

create view [dbo].[vExamen] as
select tExamen.id,tExamen.designation,tExamen.prix,tCategorieExamen.designation as Categorie,tExamen.refCategorieExam,tExamen.author from tExamen left join tCategorieExamen on tExamen.refCategorieExam=tCategorieExamen.id

GO

CREATE view [dbo].[vExamenAfaire] as
select tExamenAfaire.id,vConsultation.noms,tExamen.designation as Examen,tExamenAfaire.dateAffect,
tdetailFaireExamen.resultat,tdetailFaireExamen.Libelle,tdetailFaireExamen.DateFaireExamen as DateExamen,tdetailFaireExamen.observation,
tdetailFaireExamen.author as ExaminePar,tExamenAfaire.refdetailConsultation as Numero_Consultation,
tExamenAfaire.refExamen,tdetailFaireExamen.id as ID_labom,tExamenAfaire.author from tExamenAfaire
inner join vConsultation on vConsultation.id=tExamenAfaire.refdetailConsultation
inner join tExamen on tExamen.id=tExamenAfaire.refExamen
left join tdetailFaireExamen on tExamenAfaire.id=tdetailFaireExamen.refExamenAfaire




GO

CREATE TABLE [dbo].[tEntetePaiement](
	[id] [int] NOT NULL,
	[datepaiement] [datetime] NULL,
	[author] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

--CREATE procedure [dbo].[saveEnteteEntree]
--(
--@id int,
--@refFournisseur int,
--@author nvarchar(100),
--@refProvenance int,
--@dateEntree date
--) as 
--begin
--if @id in (select id from tEnteteEntree)
--begin
--update tEnteteEntree set refFournisseur=@refFournisseur,
--author=@author,refProvenance=@refProvenance,dateEntree=@dateEntree where id=@id
--end
--else
--begin
--insert into tEnteteEntree values (@refFournisseur,@dateEntree,@author,@refProvenance)
--end
--end



GO
CREATE view [dbo].[vEntetePaiement] as
select tPaiment.id,vMouvement.noms as Malade,
vMouvement.DateMouvement as DAteMouvement,
vMouvement.Type_ as TypeMalade,DatePaie,tPaiment.author,refMouvement,
vMouvement.refMalade as IdMalade,vMouvement.refTypemalade from tPaiment
inner join vMouvement on vMouvement.id=tPaiment.refMouvement

GO





create view [dbo].[vsommationPaiementparTypeFrais] as
select sum(montant) as TotalparFrais,refMouvement,refTypeFrais from tDetailPaiement
inner join vEntetePaiement on vEntetePaiement.id=tDetailPaiement.refPaiement
inner join tTypeFrais on tTypeFrais.id=tDetailPaiement.refTypeFrais
group by refMouvement,refTypeFrais

GO


CREATE view [dbo].[vFacture] as
select tFacturation.id,noms,DateMouvement,Type_ as TypeMalade,tTypeFrais.designation as TypeFrais,Montant,
TypeService,EstPaye,refMalade,refTypemalade,tFacturation.refMouvement,
tFacturation.refTypeFrais,ISNULL(vsommationPaiementparTypeFrais.TotalparFrais,0) as TotalparFrais,
(Montant-ISNULL(vsommationPaiementparTypeFrais.TotalparFrais,0)) as ResteAPayer,
Case when ((Montant-ISNULL(vsommationPaiementparTypeFrais.TotalparFrais,0)) = 0) then 'OK' 
When ((Montant-ISNULL(vsommationPaiementparTypeFrais.TotalparFrais,0))>0) then 'DETTE' 
When((Montant-ISNULL(vsommationPaiementparTypeFrais.TotalparFrais,0))<0) then 'ERROR' end as Observation from tFacturation
inner join vMouvement on vMouvement.id=tFacturation.refMouvement
inner join tTypeFrais on tTypeFrais.id=tFacturation.refTypeFrais
left join vsommationPaiementparTypeFrais on vsommationPaiementparTypeFrais.refMouvement=tFacturation.refMouvement 
and vsommationPaiementparTypeFrais.refTypeFrais=tFacturation.refTypeFrais


GO


CREATE view [dbo].vAgent as
select tAgent.id,tAgent.Matricule,noms,sexe,datenaissance,etatcivil,Grade,tFonction.designation as Fonction,Contact,
Specialite,tCategorieAgent.designation as Categorie,avenue.designation as Avenue,
quartier.designation as Quartier,commune.designation as Commune,ville.designation as Ville,
province.designation as Province,pays.designation as Pays,refAvenue,refCategorie,tAgent.author
,mail,niveauEtude,ProvinceOrigine,lieunaissance,refFonction,photo,Ecole,AnneefinEtude
 from tAgent
 inner join tCategorieAgent on tCategorieAgent.id=tAgent.refCategorie
 left join avenue on avenue.id=tAgent.refAvenue
 inner join quartier on avenue.ref_quartier=quartier.id
 inner join commune on quartier.ref_commune=commune.id
 inner join ville on commune.ref_ville=ville.id
 inner join province on ville.ref_province=province.id
 inner join pays on province.ref_pays=pays.id
 left join tFonction on tFonction.id=tAgent.refFonction

GO


create view [dbo].[vEnteteConsultation] as
select tConsulter.id,refAgent,vAgent.noms as Medecin,vAgent.Fonction,vAgent.Grade,
vAgent.Matricule,vAgent.Contact,vAgent.Specialite,refMouvement,vMouvement.noms as Malade,vMouvement.refMalade,
vMouvement.refTypemalade,vMouvement.Type_,vMouvement.DateMouvement,DateConsultation,tConsulter.author from tConsulter
inner join vMouvement on vMouvement.id=tConsulter.refMouvement
inner join vAgent on vAgent.id=tConsulter.refAgent

GO

create view [dbo].[vFicheConsulatation] as
select tDetailConsultation.id,Malade,Medecin,tTypeConsultation.designation as TypeConsutation,
tTypeConsultation.prix as PrixConsultation,symptome,plainte,diagnostique,
conduite,datedetailCons,tDetailConsultation.author as authorDetailConsult,refAgent,Fonction,Grade,
Matricule,Contact,Specialite,refMouvement,refMalade,
refTypemalade,Type_,DateMouvement,DateConsultation,vEnteteConsultation.author as authorEntete
--refConsultation,refTypeConsult,nomHop=(select nom from tHopital),adresseHop=(select adresse from tHopital),
--telephoneHop=(select telephone from tHopital),mailHop=(select mail from tHopital),
--photoHop=(select photo from tHopital),sitewebHop=(select siteweb from tHopital),
--boitePostalHop=(select boitePostal from tHopital),rccmHop=(select rccm from tHopital),
--idNatHop=(select idNat from tHopital),NumImpotHop=(select NumImpot from tHopital),
--ZoneHop=(select ZonneSante from tHopital),AireSanteHop=(select AireSante from tHopital),
--provinceHop=(select province from tHopital) 
from tDetailConsultation
inner join tTypeConsultation on tTypeConsultation.id=tDetailConsultation.refTypeConsult
inner join vEnteteConsultation on vEnteteConsultation.id=tDetailConsultation.refConsultation

GO


--CREATE view [dbo].[vFicheMalade] as
--select *,'Q.'+Quartier+', Av.'+Avenue as AdresseComplete
--,nomHop=(select nom from tHopital),adresseHop=(select adresse from tHopital),
--telephoneHop=(select telephone from tHopital),mailHop=(select mail from tHopital),
--photoHop=(select photo from tHopital),sitewebHop=(select siteweb from tHopital),
--boitePostalHop=(select boitePostal from tHopital),rccmHop=(select rccm from tHopital),
--idNatHop=(select idNat from tHopital),NumImpotHop=(select NumImpot from tHopital),
--ZoneHop=(select ZonneSante from tHopital),AireSanteHop=(select AireSante from tHopital),
--provinceHop=(select province from tHopital) from vMalade


--GO


CREATE view [dbo].[vFicheLaboratoireExamen] as
select tExamenAfaire.id,Malade,refdetailConsultation,refExamen,tExamen.designation as Examen,tExamen.prix as PrixExamen,
tExamenAfaire.author,dateAffect,Medecin as MedecinConsult,TypeConsutation,
PrixConsultation,symptome,plainte,diagnostique,
conduite,datedetailCons,authorDetailConsult,refAgent,Fonction,Grade,
Matricule,Contact,Specialite,refMouvement,refMalade,
refTypemalade,Type_,DateMouvement,DateConsultation,authorEntete
--refConsultation,refTypeConsult,nomHop=(select nom from tHopital),adresseHop=(select adresse from tHopital),
--telephoneHop=(select telephone from tHopital),mailHop=(select mail from tHopital),
--photoHop=(select photo from tHopital),sitewebHop=(select siteweb from tHopital),
--boitePostalHop=(select boitePostal from tHopital),rccmHop=(select rccm from tHopital),
--idNatHop=(select idNat from tHopital),NumImpotHop=(select NumImpot from tHopital),
--ZoneHop=(select ZonneSante from tHopital),AireSanteHop=(select AireSante from tHopital),
--provinceHop=(select province from tHopital)
 from tExamenAfaire
inner join vFicheConsulatation on vFicheConsulatation.id=tExamenAfaire.refdetailConsultation
inner join tExamen on tExamen.id=tExamenAfaire.refExamen

GO

CREATE view [dbo].[vFicheResultatExamen] as
select tdetailFaireExamen.id,refExamenAfaire,resultat,DateFaireExamen,Libelle,
tdetailFaireExamen.author,observation,Malade,refdetailConsultation,refExamen,Examen,PrixExamen,
dateAffect,MedecinConsult,TypeConsutation,
PrixConsultation,symptome,plainte,diagnostique,
conduite,datedetailCons,authorDetailConsult,refAgent,Fonction,Grade,
Matricule,Contact,Specialite,refMouvement,refMalade,
refTypemalade,Type_,DateMouvement,DateConsultation,authorEntete
--refConsultation,refTypeConsult,nomHop=(select nom from tHopital),adresseHop=(select adresse from tHopital),
--telephoneHop=(select telephone from tHopital),mailHop=(select mail from tHopital),
--photoHop=(select photo from tHopital),sitewebHop=(select siteweb from tHopital),
--boitePostalHop=(select boitePostal from tHopital),rccmHop=(select rccm from tHopital),
--idNatHop=(select idNat from tHopital),NumImpotHop=(select NumImpot from tHopital),
--ZoneHop=(select ZonneSante from tHopital),AireSanteHop=(select AireSante from tHopital),
--provinceHop=(select province from tHopital) 
from tdetailFaireExamen
inner join vFicheLaboratoireExamen on vFicheLaboratoireExamen.id=tdetailFaireExamen.refExamenAfaire

GO

create view [dbo].[vRapportConsultation] as
select tDetailConsultation.id,Medecin,GradeMedecin,
FonctionMedecin,ContactMedecin,SpecialiteMedecin,Malade,
DAteMouvement,TypeMalade,DateConsultation,tTypeConsultation.designation as TypeConsultation,
tTypeConsultation.prix as PrixConsultation,symptome,plainte,
diagnostique,conduite,datedetailCons,tDetailConsultation.author,refConsultation,refTypeConsult,
refAgent,refMouvement,IdMalade,refTypemalade
--nomHopital=(select nom from tHopital),adresseHopital=(select adresse from tHopital),
--telephoneHopital=(select telephone from tHopital),mailHopital=(select mail from tHopital),
--sitewebHopital=(select siteweb from tHopital),boiteHopital=(select boitePostal from tHopital),
--rccmHopital=(select rccm from tHopital),idNatHopital=(select idNat from tHopital),
--NumImpotHopital=(select NumImpot from tHopital),
--ZoneSanteHopital=(select ZonneSante from tHopital),
--AireSanteHopital=(select AireSante from tHopital),provinceHopital=(select province from tHopital)
 from tDetailConsultation
inner join vConsulter on tDetailConsultation.refConsultation=vConsulter.id
inner join tTypeConsultation on tDetailConsultation.refTypeConsult=tTypeConsultation.id

GO


create view [dbo].[vInfoExamen] as
select tExamenAfaire.id,Medecin,Malade,
DAteMouvement,TypeMalade,DateConsultation,tExamen.designation as Examen,
tExamen.prix as PrixExamen,tCategorieExamen.designation as CategorieExamen,tExamenAfaire.author,dateAffect,TypeConsultation,
PrixConsultation,symptome,plainte,diagnostique,conduite,datedetailCons,refConsultation,refTypeConsult,
refAgent,refMouvement,IdMalade,refTypemalade,tExamen.refCategorieExam,refdetailConsultation,refExamen from tExamenAfaire
inner join vRapportConsultation on vRapportConsultation.id=tExamenAfaire.refdetailConsultation
inner join tExamen on tExamen.id=tExamenAfaire.refExamen
inner join tCategorieExamen on tCategorieExamen.id=tExamen.refCategorieExam

GO

CREATE view [dbo].[vGetExament] as
select id,Malade,Examen,DAteMouvement,Medecin,refMouvement From vInfoExamen


GO

CREATE view [dbo].[vGetMedicament] as
select id,Malade,Traitement,DateMouvement,Medecin,refMouvement from vDetailCOnsultation


GO


create view [dbo].[vInfoDiagnostique] as
select tSouffrerMaladie.id,tSouffrerMaladie.author,  
refAgent,refMouvement,CONVERT(date,DateConsultation) as DateConsultation,tAgent.noms as Medecin,refMalade,refTypemalade,CONVERT(date,DateMouvement) as DateMouvement  
,Malade,vInfoMouvement.sexe,vInfoMouvement.datenaissance,vInfoMouvement.etatcivil,
CategorieMalade,organisation,numerobon,vInfoMouvement.Fonction,
vInfoMouvement.Contact,Personneref,FonctionPresRef,ContactPersRef,Avenue,
Quartier,Commune,Ville,Province,Pays,numeromaison,vInfoMouvement.photo,vInfoMouvement.refAvenue,
refQuartier,idCommune,idVille, idProvince,idPays,
Age,Adresse,

  refConsultation,refTypeConsult,tTypeConsultation.designation as TypeConsulation,
  tTypeConsultation.prix as PrixConsulataion,symptome,plainte,diagnostique,conduite as Traitement,
  datedetailCons,
  
  tDetailConsultation.id as refdetailConsultation,tSouffrerMaladie.refMaladie,
  tMaladie.designation as Maladie,tMaladie.refCategorieMaladie,
  tCategorieMaladie.designation as CategorieMaladie from tSouffrerMaladie

  
  inner join tMaladie on tMaladie.id=tSouffrerMaladie.refMaladie
  inner join tCategorieMaladie on tCategorieMaladie.id=tMaladie.refCategorieMaladie
  right join tDetailConsultation on tDetailConsultation.id=tSouffrerMaladie.refdetailConsultation
  inner join tTypeConsultation on tTypeConsultation.id=tDetailConsultation.refTypeConsult
  right join tConsulter on tConsulter.id=tDetailConsultation.refConsultation
  inner join tAgent on tAgent.id=tConsulter.refAgent
  inner join vInfoMouvement on vInfoMouvement.id=tConsulter.refMouvement

GO






create FUNCTION [dbo].[fn_get_DiagnosticDef](@refConsulation int)
RETURNS @Table TABLE(_refprise INT,_maladie nvarchar(100))
AS
BEGIN
	--- And then select the data ---


declare @maladie nvarchar(100)
declare @valeurCurseur nvarchar(100)
declare cc cursor for select Maladie from vInfoDiagnostique where refConsultation=@refConsulation
open cc
fetch next from cc into @valeurCurseur
while @@FETCH_STATUS=0
begin
	set @maladie= ISNULL(@maladie,'')+' ; '+ISNULL(@valeurCurseur,'')
	
	--set @maladie=''
	fetch next from cc into @valeurCurseur
end
close cc
deallocate cc

	INSERT INTO @Table values (@refConsulation,@maladie)		
		
	Return
END


GO






CREATE view [dbo].[vInfoConsultation] as
select tdetailFaireExamen.id,refExamenAfaire,resultat,
DateFaireExamen,Libelle,tdetailFaireExamen.author,observation,
  
refAgent,refMouvement,DateConsultation,tAgent.noms as Medecin,refMalade,refTypemalade,DateMouvement  
,Malade,vInfoMouvement.sexe,vInfoMouvement.datenaissance,vInfoMouvement.etatcivil,
CategorieMalade,organisation,numerobon,vInfoMouvement.Fonction,
vInfoMouvement.Contact,Personneref,FonctionPresRef,ContactPersRef,Avenue,
Quartier,Commune,Ville,Province,Pays,numeromaison,vInfoMouvement.photo,vInfoMouvement.refAvenue,
refQuartier,idCommune,idVille, idProvince,idPays,
Age,Adresse,

  refConsultation,refTypeConsult,tTypeConsultation.designation as TypeConsulation,
  tTypeConsultation.prix as PrixConsulataion,symptome,plainte,diagnostique,conduite as Traitement,
  datedetailCons,
  
  tExamenAfaire.dateAffect,tExamenAfaire.refdetailConsultation,tExamenAfaire.refExamen,
  tExamen.designation as Examen,tExamen.refCategorieExam,
  tCategorieExamen.designation as CategorieExamen,tExamen.prix as PrixExamen,
  (select _maladie from fn_get_DiagnosticDef(refConsultation)) as DiagnostiqueDef from tdetailFaireExamen

  right join tExamenAfaire on tExamenAfaire.id=tdetailFaireExamen.refExamenAfaire
  inner join tExamen on tExamen.id=tExamenAfaire.refExamen
  inner join tCategorieExamen on tCategorieExamen.id=tExamen.refCategorieExam
  inner join tDetailConsultation on tDetailConsultation.id=tExamenAfaire.refdetailConsultation
  inner join tTypeConsultation on tTypeConsultation.id=tDetailConsultation.refTypeConsult
  inner join tConsulter on tConsulter.id=tDetailConsultation.refConsultation
  inner join tAgent on tAgent.id=tConsulter.refAgent
  inner join vInfoMouvement on vInfoMouvement.id=tConsulter.refMouvement


GO

create view [dbo].[vInforLaboratoire] as
select tdetailFaireExamen.id,refExamenAfaire,resultat,DateFaireExamen,Libelle,tdetailFaireExamen.author,observation,Medecin,Malade,
DAteMouvement,TypeMalade,DateConsultation,Examen,PrixExamen,CategorieExamen,dateAffect,TypeConsultation,
PrixConsultation,symptome,plainte,diagnostique,conduite,datedetailCons,refConsultation,refTypeConsult,
refAgent,refMouvement,IdMalade,refTypemalade,refCategorieExam,refdetailConsultation,refExamen from tdetailFaireExamen
inner join vInfoExamen on vInfoExamen.id=tdetailFaireExamen.refExamenAfaire



GO


create view [dbo].[vMedicament] as
select tMedicament.id,tMedicament.designation as Medicament,tMedicament.forme,tMedicament.prixUnitaire from tMedicament

GO

CREATE view [dbo].[vMedicamentWithCat] as
select tMedicament.id,tMedicament.designation,prixUnitaire,tMedicament.author,forme,
refCategorie,tCategorieMedicament.designation as Categorie,typeMed from tMedicament
left join tCategorieMedicament on tCategorieMedicament.id=tMedicament.refCategorie

GO

create view [dbo].[vnombrePaiePers] as
select count(*) as NombrePaie,refAffectation from vSommationPaieSalire
group by refAffectation


GO

CREATE view [dbo].[vPersonnel] as
select tAgent.id,matricule,noms as nomPres,niveauEtude,datenaissance,
ProvinceOrigine,lieunaissance,sexe,etatcivil,
'V. '+ville.designation+'Com. '+commune.designation+' Q. '+quartier.designation+' Av. '+avenue.designation as adresse,
refFonction,Contact as telephone,mail,tFonction.designation as Fonction,
tCategorieAgent.designation as CategorieMedecin,Grade, Specialite,tAgent.photo as photo,Ecole,AnneefinEtude from tAgent
left join tFonction on tFonction.id=tAgent.refFonction
inner join tCategorieAgent on tCategorieAgent.id=tAgent.refCategorie
left join avenue on avenue.id=tAgent.refAvenue
inner join quartier on avenue.ref_quartier=quartier.id
inner join commune on quartier.ref_commune=commune.id
inner join ville on commune.ref_ville=ville.id
inner join province on ville.ref_province=province.id
inner join pays on province.ref_pays=pays.id



--CREATE view [dbo].[vEnteteAffectation] as
--select tEnteteAffectation.id,nomPres,
--vBureau.designation as Bureau,
--ServiceBureau,section1,section2,dateaffect,tEnteteAffectation.author,
--refService,vBureau.author as authorBureau,matricule,niveauEtude,datenaissance,
--ProvinceOrigine,lieunaissance,sexe,etatcivil,adresse,
--refFonction,telephone,mail,vPersonnel.Fonction as Fonction,photo,
--refPersonnel,refBureau,Actenommee,Actecommis,Structure,TypePrime,TypeSalaire,SIFA,specialite,Ecole,AnneefinEtude from tEnteteAffectation
--inner join vBureau on vBureau.id=tEnteteAffectation.refBureau
--RIGHT join vPersonnel on vPersonnel.id=tEnteteAffectation.refPersonnel


--CREATE view [dbo].[vSommationPaieSalire] as
--select refAffectation,refEntetePaie,sum(montantPaie) as TotalPaie,
--refMois,(select designation from tMois where id=refMois) as Mois,
--(select nomPres from vEnteteAffectation where vEnteteAffectation.id=refAffectation) as Noms
--,(select Fonction from vEnteteAffectation where vEnteteAffectation.id=refAffectation) as Fonction
--,(select ServiceBureau from vEnteteAffectation where vEnteteAffectation.id=refAffectation) as ServiceBureau
--,(select Bureau from vEnteteAffectation where vEnteteAffectation.id=refAffectation) as Bureau
--,(select refService from vEnteteAffectation where vEnteteAffectation.id=refAffectation) as refService
--,(select refBureau from vEnteteAffectation where vEnteteAffectation.id=refAffectation) as refBureau from vDetailPaiementSal
--group by refAffectation,refEntetePaie,refMois


--GO

create view [dbo].[vProvince] as 
select province.id as id_p,province.designation as design,province.ref_pays,pays.designation from province inner join pays on province.ref_pays=pays.id


GO

create view [dbo].[vQuartier] as 
select quartier.id as id_p,quartier.designation as design,quartier.ref_commune,commune.designation from quartier inner join commune on commune.id=quartier.ref_commune


GO





--CREATE view [dbo].[vRapportDetailPaiement] as
----
--select id,datepaiement,
----nomPres,vDetailPaiementSal.refBureau,vDetailPaiementSal.Bureau,vDetailPaiementSal.ServiceBureau,Rubrique,vDetailPaiementSal.Mois,libelle,montantPaie,
----ISNULL((select TotalRet from vSommationDetailRetenu where vSommationDetailRetenu.Annee=DATEPART(YEAR,datepaiement) 
----and vSommationDetailRetenu.refAffectation=vDetailPaiementSal.refAffectation 
----and vSommationDetailRetenu.refMois=vDetailPaiementSal.refMois 
----and vSommationDetailRetenu.refRubrique=vDetailPaiementSal.refRubrique),0) as RetenuParRubrique,
----((montantPaie)-(ISNULL((select TotalRet from vSommationDetailRetenu where vSommationDetailRetenu.Annee=DATEPART(YEAR,datepaiement) 
----and vSommationDetailRetenu.refAffectation=vDetailPaiementSal.refAffectation 
----and vSommationDetailRetenu.refMois=vDetailPaiementSal.refMois 
----and vSommationDetailRetenu.refRubrique=vDetailPaiementSal.refRubrique),0))) as montantPaieAfterRet,
----((select TotalPaie from vSommationPaieSalire where vSommationPaieSalire.refAffectation=vDetailPaiementSal.refAffectation and 
----vSommationPaieSalire.refMois=vDetailPaiementSal.refMois and (DATEPART(YEAR,vDetailPaiementSal.datepaiement)=
----DATEPART(YEAR,(select datepaiement from tEntetePaiement where tEntetePaiement.id=refEntetePaie))))) as MontantBrut,

----ISNULL((select TotalRetenu from vSommationRetenu 
----where vSommationRetenu.refAffectatioPers=vDetailPaiementSal.refAffectation 
----and vSommationRetenu.refMois=vDetailPaiementSal.refMois),0) as Retenu,

--ISNULL((select nombrePresence from vsommationPresence
--where vsommationPresence.refAffectatioPers=vDetailPaiementSal.refAffectation 
--and vsommationPresence.refMois=vDetailPaiementSal.refMois),(select nombreJours from tJoursTravail)) as NbrPresenceActuel,
--(select nombreJours from tJoursTravail) as NbrJoursTravail,

--((select TotalPaie from vSommationPaieSalire where vSommationPaieSalire.refAffectation=vDetailPaiementSal.refAffectation and 
--vSommationPaieSalire.refMois=vDetailPaiementSal.refMois and (DATEPART(YEAR,vDetailPaiementSal.datepaiement)=
--DATEPART(YEAR,(select datepaiement from tEntetePaiement where tEntetePaiement.id=refEntetePaie))))/(select nombreJours from tJoursTravail)) as SalaireJournalier,

--((ISNULL((select nombrePresence from vsommationPresence
--where vsommationPresence.refAffectatioPers=vDetailPaiementSal.refAffectation 
--and vsommationPresence.refMois=vDetailPaiementSal.refMois),(select nombreJours from tJoursTravail)))
--*((((select TotalPaie from vSommationPaieSalire where vSommationPaieSalire.refAffectation=vDetailPaiementSal.refAffectation and 
--vSommationPaieSalire.refMois=vDetailPaiementSal.refMois and (DATEPART(YEAR,vDetailPaiementSal.datepaiement)=
--DATEPART(YEAR,(select datepaiement from tEntetePaiement where tEntetePaiement.id=refEntetePaie)))))/
--(select nombreJours from tJoursTravail)))) as MontantReeelPresence,

--(((((select TotalPaie from vSommationPaieSalire where vSommationPaieSalire.refAffectation=vDetailPaiementSal.refAffectation and 
--vSommationPaieSalire.refMois=vDetailPaiementSal.refMois and (DATEPART(YEAR,vDetailPaiementSal.datepaiement)=
--DATEPART(YEAR,(select datepaiement from tEntetePaiement where tEntetePaiement.id=refEntetePaie)))))-(((ISNULL((select nombrePresence from vsommationPresence
--where vsommationPresence.refAffectatioPers=vDetailPaiementSal.refAffectation 
--and vsommationPresence.refMois=vDetailPaiementSal.refMois),(select nombreJours from tJoursTravail)))
--*((((select TotalPaie from vSommationPaieSalire where vSommationPaieSalire.refAffectation=vDetailPaiementSal.refAffectation and 
--vSommationPaieSalire.refMois=vDetailPaiementSal.refMois and (DATEPART(YEAR,vDetailPaiementSal.datepaiement)=
--DATEPART(YEAR,(select datepaiement from tEntetePaiement where tEntetePaiement.id=refEntetePaie)))))))
--/(select nombreJours from tJoursTravail)))))) as RetenuPresence,

--((ISNULL((select TotalRetenu from vSommationRetenu 
--where vSommationRetenu.refAffectatioPers=vDetailPaiementSal.refAffectation 
--and vSommationRetenu.refMois=vDetailPaiementSal.refMois),0))+
--((((((select TotalPaie from vSommationPaieSalire where vSommationPaieSalire.refAffectation=vDetailPaiementSal.refAffectation and 
--vSommationPaieSalire.refMois=vDetailPaiementSal.refMois and (DATEPART(YEAR,vDetailPaiementSal.datepaiement)=
--DATEPART(YEAR,(select datepaiement from tEntetePaiement where tEntetePaiement.id=refEntetePaie)))))-(((ISNULL((select nombrePresence from vsommationPresence
--where vsommationPresence.refAffectatioPers=vDetailPaiementSal.refAffectation 
--and vsommationPresence.refMois=vDetailPaiementSal.refMois),(select nombreJours from tJoursTravail)))
--*((((((select TotalPaie from vSommationPaieSalire where vSommationPaieSalire.refAffectation=vDetailPaiementSal.refAffectation and 
--vSommationPaieSalire.refMois=vDetailPaiementSal.refMois and (DATEPART(YEAR,vDetailPaiementSal.datepaiement)=
--DATEPART(YEAR,(select datepaiement from tEntetePaiement where tEntetePaiement.id=refEntetePaie)))))/
--(select nombreJours from tJoursTravail)))))))))))) as RetenuTotal,

--((((select TotalPaie from vSommationPaieSalire where vSommationPaieSalire.refAffectation=vDetailPaiementSal.refAffectation and 
--vSommationPaieSalire.refMois=vDetailPaiementSal.refMois and (DATEPART(YEAR,vDetailPaiementSal.datepaiement)=
--DATEPART(YEAR,(select datepaiement from tEntetePaiement where tEntetePaiement.id=refEntetePaie)))))) - 
--(((ISNULL((select TotalRetenu from vSommationRetenu 
--where vSommationRetenu.refAffectatioPers=vDetailPaiementSal.refAffectation 
--and vSommationRetenu.refMois=vDetailPaiementSal.refMois),0))+
--((((((select TotalPaie from vSommationPaieSalire where vSommationPaieSalire.refAffectation=vDetailPaiementSal.refAffectation and 
--vSommationPaieSalire.refMois=vDetailPaiementSal.refMois and (DATEPART(YEAR,vDetailPaiementSal.datepaiement)=
--DATEPART(YEAR,(select datepaiement from tEntetePaiement where tEntetePaiement.id=refEntetePaie)))))-(((ISNULL((select nombrePresence from vsommationPresence
--where vsommationPresence.refAffectatioPers=vDetailPaiementSal.refAffectation 
--and vsommationPresence.refMois=vDetailPaiementSal.refMois),(select nombreJours from tJoursTravail)))
--*((((((select TotalPaie from vSommationPaieSalire where vSommationPaieSalire.refAffectation=vDetailPaiementSal.refAffectation and 
--vSommationPaieSalire.refMois=vDetailPaiementSal.refMois and (DATEPART(YEAR,vDetailPaiementSal.datepaiement)=
--DATEPART(YEAR,(select datepaiement from tEntetePaiement where tEntetePaiement.id=refEntetePaie)))))/
--(select nombreJours from tJoursTravail)))))))))))))) as NetApayer,

--devisePaie,tauxpaie,authorPaie,montantPrev,devisePrev,
--tauxPrev,section1,section2,dateaffect,vDetailPaiementSal.refService,matricule,niveauEtude,datenaissance,
--ProvinceOrigine,lieunaissance,sexe,etatcivil,adresse,vDetailPaiementSal.refAffectation,
--refFonction,telephone,mail,vDetailPaiementSal.Fonction,photo,refPersonnel,
--refRubrique,vDetailPaiementSal.refEntetePaie,vDetailPaiementSal.refMois,
--refDetailAffectration,section1+'-'+section2 as SectionConcat,
--nomEse=(select nom from tHopital),adresseEse=(select adresse from tHopital),
--telephoneEse=(select telephone from tHopital),mailEse=(select mail from tHopital)
--,logoEse=(select photo from tHopital),sitewebEse=(select siteweb from tHopital),
--boitePostbEse=(select boitePostal from tHopital),rccmEse=(select rccm from tHopital),
--idNatEse=(select idNat from tHopital),NumImpotEse=(select NumImpot from tHopital),
-- '00'+''+ CONVERT(nvarchar(100),ROWCOUNT_BIG()) as numeroPaiement,
-- Titre=(select Titre from tRubrique where tRubrique.id=vDetailPaiementSal.refRubrique),
-- Compte=(select Compte from tRubrique where tRubrique.id=vDetailPaiementSal.refRubrique),
-- Article=(select Article from tRubrique where tRubrique.id=vDetailPaiementSal.refRubrique),
-- DATEPART(YEAR,(select datepaiement from tEntetePaiement where tEntetePaiement.id=vDetailPaiementSal.refEntetePaie)) as AnneeEncours,
-- idDepense,((SUBSTRING(CONVERT(NVARCHAR(20),DATEPART(year,datepaiement)),3,2))+'01110'+section1+section2+'0000'+
-- (select Compte from tRubrique where tRubrique.id=vDetailPaiementSal.refRubrique)+
-- (select Article from tRubrique where tRubrique.id=vDetailPaiementSal.refRubrique)+
-- (select Titre from tRubrique where tRubrique.id=vDetailPaiementSal.refRubrique)+'2180000') as Imputation,TypePaiement,
-- ''+vDetailPaiementSal.Mois+''+' '+CONVERT(nvarchar(100),DATEPART(year,datepaiement)) as MoisAnnee,
-- (''+CONVERT(nvarchar(100),idDepense)+' / '+CONVERT(nvarchar(100),DATEPART(year,datepaiement))) as IdDepenseAnnee from vDetailPaiementSal
 

--GO

CREATE view [dbo].[vSearchEntetePaiement] as
select noms as Malade,DatePaie as DateOrientation,Type_ as TypeMouvement,refMouvement as IdMouvement from tPaiment
inner join vMouvement on vMouvement.id=tPaiment.refMouvement

GO

CREATE view [dbo].[vSearchMediacement] as
select refMediment as Id,designation as Medicament,prixUnitaire,quantite as QuantiteDisponible from vSommeMedicament

GO


CREATE view [dbo].[vvTotalEntree] as
select refMediment,sum(quantite) as Entree,dateEntree from tDetailEntree
inner join tEnteteEntree on tEnteteEntree.id=tDetailEntree.refEntete
group by refMediment,dateEntree



GO


--CREATE TABLE [dbo].[tEnteteConsommation](
--	[id] [int] IDENTITY(1,1) NOT NULL,
--	[refMouvement] [int] NULL,
--	[dateConsommation] [datetime] NULL,
--	[author] [nvarchar](100) NULL,
--	[refService] [int] NULL,
--	[libelle] [nvarchar](100) NULL,
--PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]

--GO

--ALTER TABLE [dbo].[tEnteteConsommation] ADD  DEFAULT (getdate()) FOR [dateConsommation]
--GO

--ALTER TABLE [dbo].[tEnteteConsommation]  WITH CHECK ADD FOREIGN KEY([refMouvement])
--REFERENCES [dbo].[tMouvement] ([id])
--GO

--ALTER TABLE [dbo].[tEnteteConsommation]  WITH CHECK ADD FOREIGN KEY([refMouvement])
--REFERENCES [dbo].[tMouvement] ([id])
--GO

--ALTER TABLE [dbo].[tEnteteConsommation]  WITH CHECK ADD FOREIGN KEY([refService])
--REFERENCES [dbo].[tServicePharmacie] ([id])
--GO

--ALTER TABLE [dbo].[tEnteteConsommation]  WITH CHECK ADD FOREIGN KEY([refService])
--REFERENCES [dbo].[tServicePharmacie] ([id])
--GO






--CREATE TABLE [dbo].[tDetailConsommation](
--	[id] [int] IDENTITY(1,1) NOT NULL,
--	[refEntete] [int] NULL,
--	[refDetailMediment] [int] NULL,
--	[quantite] [decimal](30, 3) NULL,
--	[prixUnitaire] [decimal](30, 3) NULL,
--PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]

--GO

--ALTER TABLE [dbo].[tDetailConsommation]  WITH CHECK ADD FOREIGN KEY([refDetailMediment])
--REFERENCES [dbo].[tDetailMedicament] ([id])
--GO

--ALTER TABLE [dbo].[tDetailConsommation]  WITH CHECK ADD FOREIGN KEY([refDetailMediment])
--REFERENCES [dbo].[tDetailMedicament] ([id])
--GO

--ALTER TABLE [dbo].[tDetailConsommation]  WITH CHECK ADD FOREIGN KEY([refEntete])
--REFERENCES [dbo].[tEnteteConsommation] ([id])
--GO

--ALTER TABLE [dbo].[tDetailConsommation]  WITH CHECK ADD FOREIGN KEY([refEntete])
--REFERENCES [dbo].[tEnteteConsommation] ([id])
--GO




--CREATE view [dbo].[vvTotalSortie] as
--select tMedicament.id as refMedicament,sum(tDetailConsommation.quantite) as Sortie,dateConsommation from tDetailConsommation
--inner join tEnteteConsommation on tEnteteConsommation.id=tDetailConsommation.refEntete
--inner join tDetailMedicament on tDetailMedicament.id=tDetailConsommation.refDetailMediment
--inner join tMedicament on tMedicament.id=tDetailMedicament.refMediment
--group by tMedicament.id,dateConsommation

--GO
























































