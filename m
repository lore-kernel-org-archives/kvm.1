Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012011.outbound.protection.outlook.com [40.107.200.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A138657A
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080405; cv=fail; b=PfjmoZiFHoCXX0IKbbQhp+tNII8Ll9taH2dJFHB1p3fcv6miStFGrokkme9XU3xiHm2KHR4vSC6QPISBLUOu7jUAy2rTWFwV27egFWmcldKAS1YRnLCuE7rBSrzIwMRX8nOjc2X2Ol0Ji6wKV4Tb00ijvYdIktRWfDFEI3lovSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080405; c=relaxed/simple;
	bh=fDlXHOy21axuYBLEscWIKznO19MCsSM8ZMkADtZ1Yj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvTDZ1QPgKxavKQ8f9tBedUegC+cU7s+vganwVz3IVWZuBUL79wWk5KvKhhDo6tNK2U3UW5appiFu47I2EgrrlSVzNVBHnkI9i4J6kbaGVjJsErJTMxQnRNUmgx3TuFCR00jpqf+IyGd3qOyUrm9M3A2kUKvdZvSQBDuK08DTs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=atIeMWia; arc=fail smtp.client-ip=40.107.200.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="atIeMWia"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtrWZMNIJkoTSoDJ8YylUCYMrGXKS9swAxYfxd5QN+uAJSD5c0ZDSYoakTz93A0L2CzaQtx3f0iPSH+nSQPs1PUP9wy0Adsp584//57DyRWtzWk1NMmA/vZc9iLM1iXThDvGdtJTQqA4tf2T9O+MhAILwCKsJvRt/d4GpqNLBlwT7OBqhFE6aJku44EcoIW1sR0xdAs9u/vg1xtbcywQfl2oCgihuSPZtTixGgOP31DTAW8do8gCCMIuRJPLClubn1MwZSIPNNCO6+qEVlw7J+825CEQ59DsbglEbEHMYgT3HFFzVzlVxFHItwyXSzYtnSJmD4jhXSg+9RMNFdl0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9s2wFOljcCSdZaFKqA925QSst6NPQulpTVd9MlQdSs=;
 b=U++kCfYZ5wVUFDUFDOf31NIDal6U+7hCFNUFLUPUUFirXdnj1YFTuuJSSSn/p1MZwpl4hTTd4UqPK2FDIs7AQy632qRWy7ViQ2f+ec+39BP3sIP9IN6jDNvQ1LZPrLu97fm3qYU6W72sZ/rDSZTavJIOg/lzI4pSNJUJL8gB5htaLD3iRFIFSlt8eSpRvq+5fOxiTMIsV+2nR6tc/FCRAP0OLZPtsAiNDwbZHeaPrHaO0NtiTMzzXCAKj6kTOVct4VAruDGOY+eY5ai0wrkSki81CNlS3CXmyzCniCd756vXsKZLX170dI+vLaCn+BFuD0q6N8x3TCgEEPevnaBa4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9s2wFOljcCSdZaFKqA925QSst6NPQulpTVd9MlQdSs=;
 b=atIeMWiafywq776VAtgG6LbpyJUKSAJZC+plw3YN2HWzDgxobhgZTRd/BAa8WKaEXKRtkXhDSxtbwpkcaYVQF6ULWuKaLKDOUDDAFhm739+G7dmhCY2O/nFtUXN1AyfPHr/vB5AgbsMtnR4k8JpPrXowvfjicD0OybrmPmk98C8=
Received: from BLAPR05CA0045.namprd05.prod.outlook.com (2603:10b6:208:335::25)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Mon, 18 May
 2026 05:00:00 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:335:cafe::72) by BLAPR05CA0045.outlook.office365.com
 (2603:10b6:208:335::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Mon, 18
 May 2026 04:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 04:59:59 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 17 May
 2026 23:59:56 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v7 6/7] KVM: SVM: Use BIT_ULL for 64-bit misc_ctl bit definitions
Date: Mon, 18 May 2026 04:59:15 +0000
Message-ID: <20260518045916.2988667-7-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260518045916.2988667-1-nikunj@amd.com>
References: <20260518045916.2988667-1-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f473d7-a6e7-474a-472c-08deb49a5021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Z8tmislgr8kWuqrv8s6Ju47pmR8Mh4ZodvW54Kv2bpn1Ya0Tdbrlvr/2/p5JSGY+l7oqq//+9kdp9J90+gx6yT9yMHP7pgPUCj8aSqbpumNOQOO0Xupyibfhp4hLmCExgV8Px998dxYVZnRgXfYK9zXYFH19RlyjJbscmaQHNHUOEWC/7OSiDj2DXCHpiY2Zmmx/CX8ZhiunKukzUiemcrXZK1oHXqnxtRCL5M+M+04rb8FpUKBpfqCEVz9bgHV9hWv2nYubVyc6+UqaHOWWupb5WDjVLcMa8pkkuraQSJsUvzf8aAsRk4v/1K4jYPIH9wTY8spn4P3Rum02MapY8WEWnXUUrriYgwIHoOwyKPpGrMDllJyFnZDhEeu8q4zze8a2fCJiLJVokzd36t82qBJO0wSCo7xMRRjuD48sBEWQ/W8K2AZywIGCP4mor8pjYqZ5eXMv6OYVm/SrWC0MadHCgpCiHvh5YJDdffCiMiBzl9I3xybuEHKTQye92/1bXK064SVI3rQyvmUNceefTPF+4Wb6qXPV6weI7ziNvEnjaQCz9NtegVRMpMWpim2fhnQjJvnMCeh6ylCqU9+/9q9PkNeNJsk1jGdN6acw6d005l/fcNHSsF8mYekm/9cOx9SEr86zl35Xaa6L3j005pZrfhq5nE48xMRw2f0UdyxdSvNIfSLNHsmEfLSw270hVxTR9sHV4+6LZWC2gZTleO37UZS9itYnG9PpFcpHyi8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k/+/PcjS87D/m9+6XxP74VXNwhSduW3lF3KjYidOwpCgIa33CJt3ik+FiXy9cYo+hxYFkokwfmYxYmPbqcp6lwRmQiyuFPbNumpYeOsW5NUYHUpTDy+gT1PZKwf3JtKi8T1wdUBB+nyqUaXMTh10oSYkgvCO2gbgOgjx7H6fpagQoUpz60hM5Il7+WedWL0WoIk3trRLnMCqpYMC/dJ2IqBfuGhSsS+PClfbDxT6mdzr+DbBM1klNAeSrJAplm5iIS9mNCMkHFY5RIaS37hB9HkOYHZzB+efcWwg5vqmL1CJ5sOWgQGNsQXJaz0NA6O0ykBSgXhxjhtBu4gRQeHpfJEYrZmLQ1/obn6DipJFUOZPLDFYFe5pV2NAH0iyLe2E1pTwJbbbCiGLABQLM/oqy4nmacdjt7S2zkl9fVowMe77FGps8RIlLj6T2XHVY5U8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 04:59:59.5086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f473d7-a6e7-474a-472c-08deb49a5021
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF

Replace BIT() with BIT_ULL() for SVM nested control bit definitions
since misc_ctl is a 64-bit field in the VMCB control area structure.

No functional change intended.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/svm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index aa63431ba92c3..f199c52709df8 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -240,10 +240,10 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_IOIO_SIZE_MASK (7 << SVM_IOIO_SIZE_SHIFT)
 #define SVM_IOIO_ASIZE_MASK (7 << SVM_IOIO_ASIZE_SHIFT)
 
-#define SVM_MISC_ENABLE_NP		BIT(0)
-#define SVM_MISC_ENABLE_SEV		BIT(1)
-#define SVM_MISC_ENABLE_SEV_ES	BIT(2)
-#define SVM_MISC_ENABLE_GMET	BIT(3)
+#define SVM_MISC_ENABLE_NP		BIT_ULL(0)
+#define SVM_MISC_ENABLE_SEV		BIT_ULL(1)
+#define SVM_MISC_ENABLE_SEV_ES		BIT_ULL(2)
+#define SVM_MISC_ENABLE_GMET		BIT_ULL(3)
 
 #define SVM_MISC2_ENABLE_V_LBR	BIT_ULL(0)
 #define SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE	BIT_ULL(1)
-- 
2.48.1

