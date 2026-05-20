
CREATE OR REPLACE MACRO path_input() AS 
(
	'D:/Master 1 Toulouse Capitole/Analyse et visualisation de données/Projet Data/OPEN_DAMIR_05_2015_2025/parquet/'
);

SELECT 
	filename, 
	(size/1024/1024)::int AS size_nb
FROM read_text(path_input() || '**');

SELECT sum((size/1024/1024)::int) AS size_nb
FROM read_text(path_input() || '**');


SELECT 
	-- Bénéficiaire
	AGE_BEN_SNDS,
	BEN_QLT_COD,
	BEN_RES_REG,
	BEN_SEX_COD,
	-- Prestation
	ASU_NAT,
	CPL_COD,
	DRG_AFF_NAT,
	PRS_FJH_TYP,
	PRS_NAT,
	PRS_PDS_QCP,
	PRS_PPU_SEC,
	PRS_REM_TAU,
	-- Exécutant
	DDP_SPE_COD,
	ETE_CAT_SNDS,
	ETE_TYP_SNDS,
	EXE_INS_REG,
	MFT_COD,
	PSE_ACT_CAT,
	PSE_ACT_SNDS,
	PSE_SPE_SNDS,
	PSE_STJ_SNDS,
	-- Prescripteur
	ETP_REG_COD,
	PRE_INS_REG,
	PSP_ACT_CAT,
	PSP_ACT_SNDS,
	PSP_SPE_SNDS,
	PSP_STJ_SNDS,
	-- Période
	SOI_ANN,
	SOI_MOI,
	-- Période de traitement
	FLX_ANN_MOI,
	-- Indicateurs bruts
	PRS_ACT_COG,
	PRS_ACT_NBR,
	PRS_ACT_QTE,
	PRS_DEP_MNT,
	PRS_PAI_MNT,
	PRS_REM_BSE,
	PRS_REM_MNT
FROM read_parquet(path_input() || '*.parquet', union_by_name = true)
LIMIT 1000;


COPY
(
	SELECT 
		-- Bénéficiaire
	AGE_BEN_SNDS,
	BEN_QLT_COD,
	BEN_RES_REG,
	BEN_SEX_COD,
	-- Prestation
	ASU_NAT,
	CPL_COD,
	DRG_AFF_NAT,
	PRS_FJH_TYP,
	PRS_NAT,
	PRS_PDS_QCP,
	PRS_PPU_SEC,
	PRS_REM_TAU,
	-- Exécutant
	DDP_SPE_COD,
	ETE_CAT_SNDS,
	ETE_TYP_SNDS,
	EXE_INS_REG,
	MFT_COD,
	PSE_ACT_CAT,
	PSE_ACT_SNDS,
	PSE_SPE_SNDS,
	PSE_STJ_SNDS,
	-- Prescripteur
	ETP_REG_COD,
	PRE_INS_REG,
	PSP_ACT_CAT,
	PSP_ACT_SNDS,
	PSP_SPE_SNDS,
	PSP_STJ_SNDS,
	-- Période
	SOI_ANN,
	SOI_MOI,
	-- Période de traitement
	FLX_ANN_MOI,
	-- Indicateurs bruts
	PRS_ACT_COG,
	PRS_ACT_NBR,
	PRS_ACT_QTE,
	PRS_DEP_MNT,
	PRS_PAI_MNT,
	PRS_REM_BSE,
	PRS_REM_MNT,
	-- Indicateurs préfiltrés
	FLT_ACT_COG,
	FLT_ACT_NBR,
	FLT_ACT_QTE,
	FLT_DEP_MNT,
	FLT_PAI_MNT,
	FLT_REM_MNT
	FROM read_parquet(path_input() || '*.parquet', union_by_name = true)
) to 'D:/Master 1 Toulouse Capitole/Analyse et visualisation de données/Projet Data/OPEN_DAMIR_05_2015_2025/open damir 2015-2025/data_05_2015_2025_opendamir.parquet';

-- Dans la table de fait il doit y avoir que des identifiants

DESCRIBE
SELECT 
-- Bénéficiaire
	AGE_BEN_SNDS,
	BEN_QLT_COD,
	BEN_RES_REG,
	BEN_SEX_COD,
	-- Prestation
	ASU_NAT,
	CPL_COD,
	DRG_AFF_NAT,
	PRS_FJH_TYP,
	PRS_NAT,
	PRS_PDS_QCP,
	PRS_PPU_SEC,
	PRS_REM_TAU,
	-- Exécutant
	DDP_SPE_COD,
	ETE_CAT_SNDS,
	ETE_TYP_SNDS,
	EXE_INS_REG,
	MFT_COD,
	PSE_ACT_CAT,
	PSE_ACT_SNDS,
	PSE_SPE_SNDS,
	PSE_STJ_SNDS,
	-- Prescripteur
	ETP_REG_COD,
	PRE_INS_REG,
	PSP_ACT_CAT,
	PSP_ACT_SNDS,
	PSP_SPE_SNDS,
	PSP_STJ_SNDS,
	-- Période
	SOI_ANN,
	SOI_MOI,
	-- Période de traitement
	FLX_ANN_MOI,
	-- Indicateurs bruts
	PRS_ACT_COG,
	PRS_ACT_NBR,
	PRS_ACT_QTE,
	PRS_DEP_MNT,
	PRS_PAI_MNT,
	PRS_REM_BSE,
	PRS_REM_MNT
FROM read_parquet(path_input() || '*.parquet');