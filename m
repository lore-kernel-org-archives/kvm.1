Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010034.outbound.protection.outlook.com [52.101.193.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F564522F03;
	Thu,  1 Oct 2026 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867518; cv=fail; b=KWsyaotrQTykKv7pP2qlC1mzsnCdjzOiV6YtTvR9+bn8b3AxzNcVuYDAk3fi6+dx36JJOauohD8x1KZlxo+KiWDR0j6H0tTjd8r+ZQoyQXIjadD1v7NhgCdVikwUZ5syJs+A89Stz9GIvvWzk1aJGey0Gg07CGe74JnPN/DYGFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867518; c=relaxed/simple;
	bh=8O6Z0srJddzK3PJ1YY2toowMf9Fttyoeeh45JzRVy/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EN6ulz/GAmBXDz6uPWIF+uvkKWFJMOI3IdaoN2UKcN0pagBQhZ5FGFAV+uMc+RtmLd05nava/9c9C9C+lOOjF47ZGaZ2OfJanHNc0NBOJMSqGQi0MyitLSOXKsgRQx6IcoDJps7L6Sr4p4auMUhbk7JWI3ZlT6xmlhW9jMcdViI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zW2yl548; arc=fail smtp.client-ip=52.101.193.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zW2yl548"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiK48La7pQq9hjm3e9ho2DhFwMTW3PDHwZJl+1oZshdPLsB7BivthMqAcMtErcvfeHyQmUspHZHcxWiIOESs0wpobIrHgAQTfAT3ibWyPFpNQ2WjojKNPoGRHUpuV89D0O40wWIuONfPpyqGBnRXnHNCMxQLAoCtQGLxEIIO1lZ5M1cQ2UFexiuK88X9oShXxUEuP37B4U9UhZnjW3c8nVfDaozMgIu7PRsz92VKs//tHFwg3f90m8Ru/5Hb2GP1M2hp7ePMFUF5ZahaHw4OXmQ8svar47Z3J8tcY1S67J4DXQxoDT8Tc9Efci27BcwY020LgRsqEdguiG2l+7C0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WONvssURH2e1kgOMlV3zN3Z4yLQUaMWS5vwe+RlvB6s=;
 b=hK3NezGg4ftQjvJclQtV5ll1cWnhGryX4Z2VKGcKxhcfLZhWU9vBAAAFxUnadwLwPxjbYmXKgAxxIxiLiAgSYubg9p1F/s7dzzsC+gX1dHl6woBvy409SHMWK6KvkqmjFlOGgVc7Waejev7Gehteyl3Fmz41dak02WEhpGwkEpCnB0gm6KMRFGVAo94RFvqffTBVDLR9quojbBqMMiZbdpz6vouW9EgSaiBpsPNP/A4xvaDZ1sBMIAXwvwu5KQYPP2Sxc8S70F4CgPbbFQaxyWHNLPSKSgFHipaQmYs1RAx64dmbjU/GHLm1bh4c0/7cK6B0c5Wr3mZWkWQglzUw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WONvssURH2e1kgOMlV3zN3Z4yLQUaMWS5vwe+RlvB6s=;
 b=zW2yl548hvWgX6QZbMGtHrZuhWGsXeV2zOHoOV3ckZvZLzIzUPpyuDyYiVl1NliGlM9CZoLIJ4Vq//LKxn8owT7sNrhl2X/Rnw51DEtCWKMdoCVLaYaG+pV30JzeXW5qrbOr6A7J0lDMIh8yjBU+1khlXFJGa7xhe+57S3IyUAw=
Received: from BN0PR08CA0025.namprd08.prod.outlook.com (2603:10b6:408:142::10)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 15:11:52 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::52) by BN0PR08CA0025.outlook.office365.com
 (2603:10b6:408:142::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:11:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:11:51 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:11:49 -0500
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <tglx@kernel.org>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <fenghuay@nvidia.com>,
	<kas@kernel.org>, <rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>,
	<rppt@kernel.org>, <dapeng1.mi@linux.intel.com>, <elver@google.com>,
	<enelsonmoore@gmail.com>, <jlayton@kernel.org>, <kuba@kernel.org>,
	<ebiggers@kernel.org>, <seanjc@google.com>, <ewanhai-oc@zhaoxin.com>,
	<binbin.wu@linux.intel.com>, <peterz@infradead.org>, <ashish.kalra@amd.com>,
	<superm1@kernel.org>, <chang.seok.bae@intel.com>,
	<prathyushi.nangia@amd.com>, <kim.phillips@amd.com>,
	<ackerleytng@google.com>, <elena.reshetova@intel.com>, <naveen@kernel.org>,
	<darwi@linutronix.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <eranian@google.com>, <peternewman@google.com>
Subject: [PATCH v6 07/18] fs/resctrl: Introduce resctrl_set_kmode_support() to register supported modes
Date: Thu, 1 Oct 2026 10:10:30 -0500
Message-ID: <50333925a56037a0ea82c49f25e76be6271d299a.1790867441.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790867441.git.babu.moger@amd.com>
References: <cover.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: b315e1b0-f809-4987-c0e2-08df1fce52a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|7416014|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hZHzmz7y7/0LtPS0DDm8zJX1SD81wOLDuQnULFaZHzBqNy9pwVzFpJBnQUvoFYo6QBq1DO2leSqdnsjUYs3m6IVMAywkepW2oBITpurFHDN1+eXHXlH3Cw4IwRKoUcsD9Et8Zvpk4NbzUcV0VumNyUpPnJSu8FlMy8mevB/ydYlWUpFvVLbYq1kMxpHsH7aHmLzN/Nuu41QJe++HW1EzPkO+P8VacSmo+mp3sL6ssC8eaxQFME57dAqkEqSdcLN+F61fESo9T5TqERbVIVsC5AH2sjCTMaNcMck7mvygGDMph+IexExvcLSAz8MfYTOf7WLGNayzWAdGxCT1V3e+Ynhm6fMb0mnKFaLHaks76bhR3Cct8N5qZZfjoVqgIOTBxRzLMCxJEE2KTgafkLLdpxB3t6tylJWfWM9piyhhkMubz34PJuF0FUein/6yYJnWvh0mU5IVLGseuUp4f5jryScbt4eGCFHpe95twIBSHm+W5tTtzswKJcd0hUcX6uiLr1p+pmjxVqEMKn+g4jyt5F27dmrUIrMkmKn5ZeMef9y1TVLRuo4fMkopf7xgfbwoKE4f8oBRciqXGU0WyDHYw/5Crc0bWrMtTQr7qwC1JZtmXtEenvyWgC+0yf9CBtQtTntn2Ao6eSdEMU2u7lQ2hLbbHGWzJFuMuhcG/xPKfq+5Cl5fXKWE/zfc+Cy3AUY8/BY4rdw3dS/urn348vLEUg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3ZAg/WdDmjjMRBQCT1gZFWpC9+M2Rg4VPUYvc1LY45otTT948VIpn4dpTrf0hLP3566hlPTea+4H7fgg1WWspxIuMd7eEfBlUecq4Yr0Bhp1L0vZAZ2rphkc8etfMGUWZsONuDjDexz4ul9LF3MT4e0qSE8t0ra9uQ2CBe4ciQeqFjAqaALoi/EvgAcTBf//q98r2gH7QGxEXGGylWYTnQoKhCXfI5xU3gk9KxL0NZB/JmyBrfAu0bO6DjsJqrYE40LUNxjuyiG6QdjPxWS9cEyeKGX34YmQXKNTkqLZv5UGzLcj8JJfDFRlu8BwAVeS99LkUiLrksnWYfpocm4kdthNg2n0HpY93zsf5qPESQLbYqOL0q6nTDMEwcwYBgSi3vg+JRrmJ1NRNKgImxxXzMnGi1Wtd3qI9DcKfSnEagLCFA/FGjHCuBaXmMl+BXgz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:11:51.9434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b315e1b0-f809-4987-c0e2-08df1fce52a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180

The resctrl subsystem tracks kernel mode configuration. Architectures need
to register the supported kernel modes.

Add resctrl_set_kmode_support() so an architecture can register supported
kernel modes.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Use resctrl_kmode.kmode_sup after the struct flatten. Drop duplicate
    kernel-doc from the .c definition and place the function next to
    resctrl_kmode_init(). Rewrite changelog (not a bugfix).

v5: New patch split from resctrl_kmode_cfg initialization. Register modes
    in resctrl_kmode_cfg.caps.kmode_sup using RESCTRL_INHERIT_USER and
    RESCTRL_ASSIGN_GLOBAL_ENABLE_PER_CPU. Ignore out-of-range mode values.

v4: New patch to initialize supported kernel modes.
    https://lore.kernel.org/lkml/737a4228-52fb-4583-ac64-8efe79c107e6@intel.com/
---
 fs/resctrl/rdtgroup.c   |  6 ++++++
 include/linux/resctrl.h | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 7c39792be1fa..75b81d07a247 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2320,6 +2320,12 @@ static void resctrl_kmode_init(void)
 	resctrl_kmode.mon = KMODE_ASSIGN;
 }
 
+void resctrl_set_kmode_support(enum resctrl_kernel_mode kmode)
+{
+	if (kmode < RESCTRL_NUM_KERNEL_MODES)
+		__set_bit(kmode, resctrl_kmode.kmode_sup);
+}
+
 void resctrl_file_fflags_init(const char *config, unsigned long fflags)
 {
 	struct rftype *rft;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index dcb0beb847b6..5553f6301bd4 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -752,6 +752,21 @@ enum resctrl_kernel_mode {
 
 #define RESCTRL_NUM_KERNEL_MODES (RESCTRL_KMODE_LAST + 1)
 
+/**
+ * resctrl_set_kmode_support() - Register a supported kernel mode
+ * @kmode:	Kernel mode supported by the architecture.
+ *
+ * RESCTRL_INHERIT_USER is registered by resctrl_kmode_init() and does
+ * not need to be registered again.
+ *
+ * Architectures use this interface during resctrl initialization to
+ * advertise supported kernel modes. Registration of a mode indicates
+ * architectural support only. The final decision to expose and enable
+ * a mode is made by resctrl based on system capabilities and
+ * configuration.
+ */
+void resctrl_set_kmode_support(enum resctrl_kernel_mode kmode);
+
 /**
  * resctrl_arch_configure_kmode_global() - Program RESCTRL_GLOBAL_ENABLE_PER_CPU
  *
-- 
2.43.0

