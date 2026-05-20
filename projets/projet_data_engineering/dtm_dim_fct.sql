set variable path_input = 'D:/Master 1 Toulouse Capitole/Analyse et visualisation de données/Projet Data/OPEN_DAMIR_05_2015_2025/open damir 2015-2025/';

SUMMARIZE FROM read_parquet(getvariable('path_input') || 'data_05_2015_2025_opendamir.parquet');

CREATE schema IF NOT EXISTS stg;
CREATE schema IF NOT EXISTS dtm;
CREATE schema IF NOT EXISTS dwh;


-- Création du dtm dim_beneficiare
CREATE OR REPLACE TABLE dtm.dim_beneficiare AS
WITH stg_beneficiaire AS 
(
	SELECT
		distinct
		AGE_BEN_SNDS,
		BEN_QLT_COD,
		BEN_RES_REG,
		BEN_SEX_COD,
		t.LIB_AGE_BEN_SNDS tranche_age_ben,
		bsc.LIB_BEN_SEX_COD sexe_ben,
		bq.LIB_BEN_QLT_COD qualite_ben,
		brr.LIB_BEN_RES_REG region_resi_ben
	FROM 
		read_parquet(getvariable('path_input') || 'data_05_2015_2025_opendamir.parquet') ben,
		descriptifs.AGE_BEN_SNDS t,
		descriptifs.BEN_SEX_COD bsc,
		descriptifs.BEN_QLT bq,
		descriptifs.BEN_RES_REG brr
	WHERE 
		ben.AGE_BEN_SNDS = t.CODE_AGE_BEN_SNDS
		AND ben.BEN_SEX_COD = bsc.CODE_BEN_SEX_COD
		AND ben.BEN_QLT_COD = bq.CODE_BEN_QLT_COD
		AND ben.BEN_RES_REG = brr.CODE_BEN_RES_REG
)
SELECT
	md5(concat_ws('-', AGE_BEN_SNDS, BEN_QLT_COD, BEN_RES_REG, BEN_SEX_COD)) code_ben,
	tranche_age_ben,
	sexe_ben,
	qualite_ben,
	region_resi_ben
FROM stg_beneficiaire;

SELECT db.code_ben,  count(1)
FROM dtm.dim_beneficiare db 
GROUP BY db.code_ben 
HAVING count(1) > 1;

-- Création du parquet dim_beneficiaire
COPY 
(
	FROM dtm.dim_beneficiare
) 
to 'D:/Master 1 Toulouse Capitole/Analyse et visualisation de données/open damir 2015-2025/dtm_dim_beneficiare.parquet' (FORMAT PARQUET);



-- Création du dtm prestataire
CREATE OR REPLACE TABLE dtm.dim_prestation AS
WITH stg_prestation AS 
(
	SELECT 
		distinct 
		ASU_NAT,
		CPL_COD,
		DRG_AFF_NAT,
		PRS_FJH_TYP,
		PRS_NAT,
		PRS_PDS_QCP,
		PRS_PPU_SEC,
		COALESCE(PRS_REM_TAU, 0) PRS_REM_TAU,
		asn.LIB_ASU_NAT as nature_assu_pres,
		cc.LIB_CPL_COD as comp_acte_pres,
		dan.LIB_DRG_AFF_NAT as nature_dest_pres,
		pft.LIB_PRS_FJH_TYP as type_prise_ch_pres,
		pn.LIB_PRS_NAT as nature_presta,
		ppq.LIB_PRS_PDS_QCP as qualif_parcours_soin_pres,
		pps.LIB_PRS_PPU_SEC as secteur_pres,
		pres.PRS_REM_TAU as taux_prestation
	FROM 
		read_parquet(getvariable('path_input') || 'data_05_2015_2025_opendamir.parquet') AS pres
	LEFT JOIN descriptifs.ASU_NAT asn 
		ON pres.ASU_NAT = asn.CODE_ASU_NAT
	LEFT JOIN descriptifs.CPL_COD cc
		ON pres.CPL_COD = cc.CODE_CPL_COD
	LEFT JOIN descriptifs.DRG_AFF_NAT dan
		ON pres.DRG_AFF_NAT = dan.CODE_DRG_AFF_NAT
	LEFT JOIN descriptifs.PRS_FJH_TYP pft
		ON pres.PRS_FJH_TYP = pft.CODE_PRS_FJH_TYP
	LEFT JOIN descriptifs.PRS_NAT pn
		ON pres.PRS_NAT = pn.CODE_PRS_NAT
	LEFT JOIN descriptifs.PRS_PDS_QCP ppq
		ON pres.PRS_PDS_QCP = ppq.CODE_PRS_PDS_QCP
	LEFT JOIN descriptifs.PRS_PPU_SEC pps 
		ON pres.PRS_PPU_SEC = pps.CODE_PRS_PPU_SEC 
)
SELECT
	md5(concat_ws('-',
		ASU_NAT,
		CPL_COD,
		DRG_AFF_NAT,
		PRS_FJH_TYP,
		PRS_NAT,
		PRS_PDS_QCP,
		PRS_PPU_SEC,
		CAST(PRS_REM_TAU AS VARCHAR)
	)) code_pres,
	nature_assu_pres,
	comp_acte_pres,
	nature_dest_pres,
	type_prise_ch_pres,
	nature_presta,
	qualif_parcours_soin_pres,
	secteur_pres,
	taux_prestation
FROM stg_prestation;


SELECT dp.code_pres,  count(*)
FROM dtm.dim_prestation dp 
GROUP BY dp.code_pres 
HAVING count(*) > 1;

-- Création du parquet dim_prestataire
COPY 
(
	FROM dtm.dim_prestation
) 
to 'D:/Master 1 Toulouse Capitole/Analyse et visualisation de données/Projet Data/OPEN_DAMIR_05_2015_2025/open damir 2015-2025/dtm_dim_prestation.parquet' (FORMAT PARQUET);

-- Création du dtm professionnel_executant
CREATE OR REPLACE TABLE dtm.dim_professionnel_executant AS
WITH stg_professionnel_executant AS 
(
	SELECT 
		distinct
		DDP_SPE_COD,
		--ETE_CAT_SNDS,
		ETE_TYP_SNDS,
		EXE_INS_REG,
		MFT_COD,
		PSE_ACT_CAT,
		PSE_ACT_SNDS,
		PSE_SPE_SNDS,
		PSE_STJ_SNDS,
		dspe.LIB_DDP_SPE_COD as specialite_executant,
		--ecs.LIB_ETE_CAT_SNDS as categorie_etablissement,
		ets.LIB_ETE_TYP_SNDS as type_etablissement,
		eir.LIB_EXE_INS_REG as region_executant,
		mft.LIB_MFT_COD as mode_fonctionnement,
		pac.LIB_PSE_ACT_CAT as categorie_activite_pro,
		pas.LIB_PSE_ACT_SNDS as activite_pro,
		pss.LIB_SE_SPE_SNDS as specialite_pro,
		pst.LIB_PSE_STJ_SNDS as statut_juridique
	FROM 
		read_parquet(getvariable('path_input') || 'data_05_2015_2025_opendamir.parquet') AS pro_exe
	LEFT JOIN descriptifs.DDP_SPE_COD dspe
		ON pro_exe.DDP_SPE_COD = dspe.CODE_DDP_SPE_COD
	/*LEFT JOIN descriptifs.ETE_CAT_SNDS ecs
		ON pro_exe.ETE_CAT_SNDS = ecs.CODE_ETE_CAT_SNDS*/
	LEFT JOIN descriptifs.ETE_TYP_SNDS ets
		ON pro_exe.ETE_TYP_SNDS = ets.CODE_ETE_TYP_SNDS
	LEFT JOIN descriptifs.EXE_INS_REG eir
		ON pro_exe.EXE_INS_REG = eir.CODE_EXE_INS_REG
	LEFT JOIN descriptifs.MFT_COD mft
		ON pro_exe.MFT_COD = mft.CODE_MFT_COD
	LEFT JOIN descriptifs.PSE_ACT_CAT pac
		ON pro_exe.PSE_ACT_CAT = pac.CODE_PSE_ACT_CAT
	LEFT JOIN descriptifs.PSE_ACT_SNDS pas
		ON pro_exe.PSE_ACT_SNDS = pas.CODE_PSE_ACT_SNDS
	LEFT JOIN descriptifs.PSE_SPE_SNDS pss
		ON pro_exe.PSE_SPE_SNDS = pss.CODE_PSE_SPE_SNDS
	LEFT JOIN descriptifs.PSE_STJ_SNDS pst
		ON pro_exe.PSE_STJ_SNDS = pst.CODE_PSE_STJ_SNDS
)
SELECT distinct
	md5(concat_ws('-',
		DDP_SPE_COD,
		--concat(ETE_CAT_SNDS, categorie_etablissement),
		ETE_TYP_SNDS,
		EXE_INS_REG,
		MFT_COD,
		PSE_ACT_CAT,
		PSE_ACT_SNDS,
		PSE_SPE_SNDS,
		PSE_STJ_SNDS
	)) code_pro_executant,
	specialite_executant,
	--code_cat_etb,
	--categorie_etablissement,
	type_etablissement,
	region_executant,
	mode_fonctionnement,
	categorie_activite_pro,
	activite_pro,
	specialite_pro,
	statut_juridique
FROM stg_professionnel_executant;

SELECT * FROM dtm.dim_professionnel_executant
ORDER BY code_pro_executant;

SELECT 
    dpe.code_pro_executant,
    COUNT(*) OVER (PARTITION BY dpe.code_pro_executant) AS nb
FROM dtm.dim_professionnel_executant dpe
QUALIFY COUNT(*) OVER (PARTITION BY dpe.code_pro_executant) > 1
ORDER BY dpe.code_pro_executant;

SELECT 
    dpe.code_pro_executant,
    COUNT(*)  AS nb
FROM dtm.dim_professionnel_executant dpe
GROUP BY dpe.code_pro_executant
HAVING COUNT(*) > 1
ORDER BY dpe.code_pro_executant;


-- Création du parquet dim_professionnel_executant
COPY 
(
	FROM dtm.dim_professionnel_executant
) 
to 'D:/Master 1 Toulouse Capitole/Analyse et visualisation de données/Projet Data/OPEN_DAMIR_05_2015_2025/open damir 2015-2025/dtm_dim_professionnel_executant.parquet' (FORMAT PARQUET);


-- Création du dtm professionnel_prescripteur
CREATE OR REPLACE TABLE dtm.dim_professionnel_prescripteur AS
WITH stg_professionnel_prescripteur AS 
(
	SELECT
		distinct
		ETP_REG_COD,
		PRE_INS_REG,
		PSP_ACT_CAT,
		PSP_ACT_SNDS,
		PSP_SPE_SNDS,
		PSP_STJ_SNDS,
		erc.CODE_ETP_REG_COD code_region_ets,
		pir.LIB_PRE_INS_REG region_presc,
		pac.LIB_PSP_ACT_CAT cat_presc,
		pas.LIB_PSP_ACT_SNDS nat_act_presc,
		pss.LIB_PSP_SPE_SNDS spe_mde_presc,
		pss2.LIB_PSP_STJ_SNDS statut_presc
	FROM 
		read_parquet(getvariable('path_input') || 'data_05_2015_2025_opendamir.parquet') AS pro_pres
	LEFT JOIN descriptifs.ETP_REG_COD erc
		ON pro_pres.ETP_REG_COD = erc.CODE_ETP_REG_COD
	LEFT JOIN descriptifs.PRE_INS_REG pir
		ON pro_pres.PRE_INS_REG = pir.CODE_PRE_INS_REG
	LEFT JOIN descriptifs.PSP_ACT_CAT pac
		ON pro_pres.PSP_ACT_CAT = pac.CODE_PSP_ACT_CAT
	LEFT JOIN descriptifs.PSP_ACT_SNDS pas 
		ON pro_pres.PSP_ACT_SNDS = pas.CODE_PSP_ACT_SNDS
	LEFT JOIN descriptifs.PSP_SPE_SNDS pss
		ON pro_pres.PSP_SPE_SNDS = pss.CODE_PSP_SPE_SNDS
	LEFT JOIN descriptifs.PSP_STJ_SNDS pss2 
		ON pro_pres.PSP_STJ_SNDS = pss2.CODE_PSP_STJ_SNDS 
)
SELECT
	--distinct
	md5(concat_ws('-',
		ETP_REG_COD,
		PRE_INS_REG,
		PSP_ACT_CAT,
		PSP_ACT_SNDS,
		PSP_SPE_SNDS,
		PSP_STJ_SNDS
	)) code_prescripteur,
	code_region_ets,
	region_presc,
	cat_presc,
	nat_act_presc,
	spe_mde_presc,
	statut_presc
FROM stg_professionnel_prescripteur;

SELECT dpp.code_prescripteur,  count(*)
FROM dtm.dim_professionnel_prescripteur dpp 
GROUP BY dpp.code_prescripteur
HAVING count(*) > 1;

-- Création du parquet dim_professionnel_prescripteur
COPY 
(
	FROM dtm.dim_professionnel_prescripteur
) 
to 'D:/Master 1 Toulouse Capitole/Analyse et visualisation de données/Projet Data/OPEN_DAMIR_05_2015_2025/open damir 2015-2025/dtm_dim_professionnel_prescripteur.parquet' (FORMAT PARQUET);


-- Création du parquet fct_depense
CREATE OR REPLACE TABLE dwh.dw_depenses AS
(
	SELECT
		AGE_BEN_SNDS,
		BEN_QLT_COD,
		BEN_RES_REG,
		BEN_SEX_COD,
		ASU_NAT,
		CPL_COD,
		DRG_AFF_NAT,
		PRS_FJH_TYP,
		PRS_NAT,
		PRS_PDS_QCP,
		PRS_PPU_SEC,
		COALESCE(PRS_REM_TAU, 0) PRS_REM_TAU,
		DDP_SPE_COD,
		--ETE_CAT_SNDS,
		ETE_TYP_SNDS,
		EXE_INS_REG,
		MFT_COD,
		PSE_ACT_CAT,
		PSE_ACT_SNDS,
		PSE_SPE_SNDS,
		PSE_STJ_SNDS,
		ETP_REG_COD,
		PRE_INS_REG,
		PSP_ACT_CAT,
		PSP_ACT_SNDS,
		PSP_SPE_SNDS,
		PSP_STJ_SNDS,
		FLX_ANN_MOI AS periode,
		SUM(PRS_ACT_QTE) AS total_qte,
		SUM(PRS_DEP_MNT) AS mnt_tot_depass,
		SUM(PRS_PAI_MNT) AS mnt_tot_depense,
		SUM(PRS_REM_BSE) AS tot_base_rem,
		SUM(PRS_REM_MNT) AS mnt_tot_rem
	FROM read_parquet(getvariable('path_input') || 'data_05_2015_2025_opendamir.parquet')
	GROUP BY ALL
);

SELECT periode, SUM(mnt_tot_depense)
FROM dwh.dw_depenses
WHERE periode='202505'
GROUP BY periode;

CREATE OR REPLACE TABLE dtm.fct_depenses AS
WITH f_depenses AS 
(
	SELECT 
		md5(concat_ws('-',
			AGE_BEN_SNDS,
			BEN_QLT_COD,
			BEN_RES_REG,
			BEN_SEX_COD)
		) code_ben,
		md5(concat_ws('-',
			ASU_NAT,
			CPL_COD,
			DRG_AFF_NAT,
			PRS_FJH_TYP,
			PRS_NAT,
			PRS_PDS_QCP,
			PRS_PPU_SEC,
			CAST(PRS_REM_TAU AS VARCHAR)
		)) code_pres,
		md5(concat_ws('-',
			DDP_SPE_COD,
			--concat(ETE_CAT_SNDS, categorie_etablissement),
			ETE_TYP_SNDS,
			EXE_INS_REG,
			MFT_COD,
			PSE_ACT_CAT,
			PSE_ACT_SNDS,
			PSE_SPE_SNDS,
			PSE_STJ_SNDS
		)) code_pro_exe,
		md5(concat_ws('-',
			ETP_REG_COD,
			PRE_INS_REG,
			PSP_ACT_CAT,
			PSP_ACT_SNDS,
			PSP_SPE_SNDS,
			PSP_STJ_SNDS
		)) code_prescripteur,
		periode,
		strftime(strptime(CAST(periode AS VARCHAR), '%Y%m'), '%Y-%m') annee_mois,
		total_qte,
		mnt_tot_depass,
		mnt_tot_depense,
		tot_base_rem,
		mnt_tot_rem
	FROM dwh.dw_depenses dd
)
SELECT * FROM f_depenses;

SELECT periode, SUM(mnt_tot_depense)
FROM dtm.fct_depenses
WHERE periode='202505'
GROUP BY periode;


COPY 
(
	FROM dtm.fct_depenses
) 
to 'D:/Master 1 Toulouse Capitole/Analyse et visualisation de données/Projet Data/OPEN_DAMIR_05_2015_2025/open damir 2015-2025/dtm_fct_depense.parquet' (FORMAT PARQUET);

CREATE OR REPLACE TABLE dtm.dim_temps AS
SELECT distinct 
	strftime(strptime(CAST(FLX_ANN_MOI AS VARCHAR), '%Y%m'), '%Y-%m') annee_mois,
    year(strptime(CAST(FLX_ANN_MOI AS VARCHAR), '%Y%m')) AS annee,
    month(strptime(CAST(FLX_ANN_MOI AS VARCHAR), '%Y%m')) AS mois,
	CAST(FLX_ANN_MOI AS VARCHAR) AS periode
FROM read_parquet(getvariable('path_input') || 'data_05_2015_2025_opendamir.parquet');


COPY 
(
	FROM dtm.dim_temps
) 
to 'D:/Master 1 Toulouse Capitole/Analyse et visualisation de données/Projet Data/OPEN_DAMIR_05_2015_2025/open damir 2015-2025/dtm_dim_temps.parquet' (FORMAT PARQUET);


PRAGMA max_temp_directory_size='500GB';