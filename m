Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF0530DE3;
	Thu,  1 Oct 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867522; cv=fail; b=tKbQV8eBTEKGsLmpE4tXYQoSCcVdljB1fMZ3yPIvH3HxO10fEi+ZoLJDC8RaL7zhJaOuqOVL6TBx8jqA5iBo85NEeby/2/qMN/ns0KIOOTg8IMKrqH0zcT4/a96VmLdv4ezPiOrip3Iv9qmTghIF70X5mM1hiQeifinhUulxuNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867522; c=relaxed/simple;
	bh=2yMEkZJSEPUJhZ+Mb1ULvxnNckcwXdrRsBBwpKfuoNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5uXvCbInEFigtVz5W3225W0j6gVM+t/I4Nr8x2dgPaXDkdeXLKoMcjJYWn7gxqmclMGV9uRzLOyMveVVtavsPb6jORpFr+tBZdh545W+Fdav1XaIfEYtAU/RZkfXDuFc0lFCrxMR7jm9E0S+OEV2Pkx2yWT6KLBk8dStNFXWqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ErQ3E9v4; arc=fail smtp.client-ip=52.101.46.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ErQ3E9v4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlgJiPLkcEl2Go0U3F8vCuKCniG32jhD2PN3AW5onVcTWr+AOkObRHaA3OoeVb1v0euDeCg6WtxJgdKq3L/1fhGxrGjaK6xj3qSApcnocg4mFSvO3NcUxQZZCFciAqraaT1tUeay85vzX7PWxl4w4hVVbBkXeMZM61s2dsl6a7T++5KLLjq8ntLmPbSETymw90x6vBISGVDzch3Pca1DzFkKFgNOrwZXpvY/80BeZ3UjOA1jrwES+w4iESMNfu+IH4PzDdZIOANiug1GEy46VthnFtxvYjQHr2nnUDMitJO3/ALJ9qQ3Aj+or0dRVvotd+sBlw78h7ynXM7iDvwpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2h61g0W6tBbWoO10bp0eyoGsrw37CSxI69yXs4oUpo=;
 b=m5zE48wDlcxoPmOQNKbYhKFTVH4sdaaM4smI+vaC5zYr3/KMfRYdkluhAsfkltwGOtfvvCj1XexBKyc99fxKJQQ9HcrMfiJUUNZs1MD/tloVGvfwBzZaY8PPnd3JMc9Q5jukK/mIp3cTfopv7XG67IKqY0oOgGMrbnNV00BPEkhHpCYHHv+ITO5UqYDPt0w0PzfR5LuhWxxIIraosUELvD6Sp9C9ET+ObUOh+f6GYHEoHU4CQMEXftowJZta0Apk4SeisBuH57+pU65VqyKVBxP3EuQj7UQjOnuixgKbMATkz/XAgqoLUr1UUd7ZxKQBF3z3GkHZHnlgiRybZK5AUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2h61g0W6tBbWoO10bp0eyoGsrw37CSxI69yXs4oUpo=;
 b=ErQ3E9v4KOjXAxJeNVZVzOOE1wYMW+UgSSg2AdMz08XDO93iDqUmGO1gMe3n5uGkckfawgwvm2X461SX9NdVNYrZGsjcjT67YoDLDe4nXPKY0AfUMWRK4fTuxGV5RhOBWsNW0L0fBn+bAiaWSj44ERAM2foteBUxmQDfKuNFA1k=
Received: from BL0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:91::13)
 by LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 15:11:49 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::ac) by BL0PR05CA0003.outlook.office365.com
 (2603:10b6:208:91::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 15:11:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:11:49 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:11:41 -0500
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
Subject: [PATCH v6 06/18] fs/resctrl: Introduce kernel mode states for resctrl
Date: Thu, 1 Oct 2026 10:10:29 -0500
Message-ID: <d98872b26051bfad280f72da3bcddea1e978b37c.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|LV3PR12MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aeff731-5bb6-4a33-49b8-08df1fce50e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|7416014|376014|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oPr3eE7kdKPT6xu1QIp/mlUnUvSbJ9gnObDDl+Kq3bhVnM6+fk2C0kezG+SYP+krn+o2LxRV86eJh7fRs+zZBP1g5UiZ9Tbf4AZPosdWdCZTQiM5A9DjKkHZNVbE0BVdZsz4i/O4X4mrZPoiFxYdhyzHcEVlY7CWp2kIurEsS2pP4tlp68kwcAMk17ODjz9SeMPy4LJVbwGoXF7hp8CTtH5+P8ys7935A2w1qiAqQCzf8DV67WJJNgK3fw7tFVGj37DAyXYNalLp98XRq6932Qb4QtmR4lUYECNhh+YsjfZhxhyozzP6JEjdkVVVOHyrIlfVSplAdEMYDFkaHUkAapL/DFyjjUfRdPaMDYmCOWhBwqeWf77SbE7WWD/FEbKaAcWuH/6nvnds2oMH6/LjJq2gDrAEwGO+ioyI2d4Dw6VVxTfnO8IaAmuQVt+qtVrvEdI8NXySQqEuivzDIvL3OKZP5Fr4EtgaBO8REAaTEDslvFIcSleJjzhA+hGyp7bWx0XZxrJiyIiago7STe8Ez/kM6SEFLvAoAn1hFZBZppZ6Yye9JdFUweoGt67dwaf02hPlak0HPFv03xCuEeezkzCP6ngLPABNHJuIr1ykgMX7aL5abAgN/DMYUwZxPN9tqCitSoCIZbFDjR3HrGK5MRsovFiQxtYvXDvAIHQa7jAO/YOlkgAlrB26hkTK6bDfMmJq0wnm6Z0qkWZxhaN4mQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(7416014)(376014)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DEIUswMyqdYDA3t0D3oJVlLWznnAeYhnietxiAtIxdqtMC+6VzZCI28tvper2Ef6VsrKDQj6jpDTMYGABhZywnd9HAE7v1S5/ymfWj2Q5ekz3hyBoaxW0OLYK+xFi6zWCC55G+aeDZFnPtgyZ1fnhgdOww/ZkBOMj74ZrRfF1gnS8POL1va8gAEt3/4eMCtLR3hBftEaKF5tirr1Y9ZexeSVHwJNfxung/UYTNTAHLAU8gUm2lJiZAVuMAL8wgb7H+js3fMJ2PqcSMynb2bBy0OYzTtTqC0R6EzJr0IVYKW2Pqbz0mCBW+DyoS1m6bZTaMdxOUQIpbrIQNw/tdlyE3xdeApTGO0nq3iXsOupzMO72YEwODgf88AiuALPEvqlDJXreJc2eN2D2WG2ccmCFD5l0bY8IEe7nrObT0bEHfYsARL4duGIpff2enaGo31y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:11:49.0636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeff731-5bb6-4a33-49b8-08df1fce50e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267

The filesystem tracks supported kernel modes, the active mode, and the
control and monitoring association for the assigned group.

Introduce struct resctrl_kmode_cfg and initialize the default configuration
from the platform's capabilities.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Drop ctrl_en/mon_en and use resctrl_arch_alloc_capable() /
    resctrl_arch_mon_capable() directly. Flatten caps/active into
    resctrl_kmode_cfg. Rename resctrl_kcfg to resctrl_kmode, ctrl_mode
    to ctrl, mon_mode to mon, and k_rdtgrp to rdtgrp. Comments describe
    the objects, not a member list. Rewrite changelog.

v5: Replace per-mode registration helpers with a single resctrl_kmode_cfg
    structure. Derive ctrl_en and mon_en from resctrl_arch_alloc_capable()
    and resctrl_arch_mon_capable() during filesystem init. Update code
    comments and changelog.

v4: New patch to initialize supported kernel modes.
    https://lore.kernel.org/lkml/737a4228-52fb-4583-ac64-8efe79c107e6@intel.com/
    Changed the kmode_cur to enum resctrl_kernel_mode in resctrl_kmode_cfg.
    Moved the resctrl_kmode_cfg to filesystem code.
---
 fs/resctrl/internal.h | 29 +++++++++++++++++++++++++++++
 fs/resctrl/rdtgroup.c | 25 +++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index e62a277dee85..98f04a2a762b 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -314,6 +314,35 @@ struct mbm_state {
 	u32	prev_bw;
 };
 
+/**
+ * enum kmode_state - Control or monitoring association
+ * @KMODE_INHERIT: Inherit from the user-space task.
+ * @KMODE_ASSIGN: Use the backing group's CLOSID or RMID.
+ */
+enum kmode_state {
+	KMODE_INHERIT,
+	KMODE_ASSIGN
+};
+
+/**
+ * struct resctrl_kmode_cfg - Kernel mode configuration
+ * @kmode_sup:	Bitmap of supported kernel modes.
+ * @kmode_cur:	Currently selected kernel mode.
+ * @ctrl:	Control association for %RESCTRL_GLOBAL_ENABLE_PER_CPU.
+ *		Kept while %RESCTRL_INHERIT_USER is selected.
+ * @mon:	Monitoring association for %RESCTRL_GLOBAL_ENABLE_PER_CPU.
+ *		Kept while %RESCTRL_INHERIT_USER is selected.
+ * @rdtgrp:	Resource group backing %RESCTRL_GLOBAL_ENABLE_PER_CPU.
+ *		%NULL while that mode is not selected.
+ */
+struct resctrl_kmode_cfg {
+	DECLARE_BITMAP(kmode_sup, RESCTRL_NUM_KERNEL_MODES);
+	enum resctrl_kernel_mode	kmode_cur;
+	enum kmode_state		ctrl;
+	enum kmode_state		mon;
+	struct rdtgroup			*rdtgrp;
+};
+
 extern struct mutex rdtgroup_mutex;
 
 static inline const char *rdt_kn_name(const struct kernfs_node *kn)
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 68be9b903ac6..7c39792be1fa 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -76,6 +76,9 @@ static void rdtgroup_destroy_root(void);
 
 struct dentry *debugfs_resctrl;
 
+/* Kernel mode for this system. */
+static struct resctrl_kmode_cfg resctrl_kmode;
+
 /*
  * Memory bandwidth monitoring event to use for the default CTRL_MON group
  * and each new CTRL_MON group created by the user.  Only relevant when
@@ -2297,6 +2300,26 @@ static void io_alloc_init(void)
 	}
 }
 
+/*
+ * Set RESCTRL_INHERIT_USER as the default when the platform supports
+ * allocation or monitoring. Otherwise leave kernel mode unsupported.
+ */
+static void resctrl_kmode_init(void)
+{
+	if (!resctrl_arch_alloc_capable() && !resctrl_arch_mon_capable())
+		return;
+
+	resctrl_kmode.kmode_cur = RESCTRL_INHERIT_USER;
+	__set_bit(RESCTRL_INHERIT_USER, resctrl_kmode.kmode_sup);
+
+	/*
+	 * Defaults used when RESCTRL_GLOBAL_ENABLE_PER_CPU mode is
+	 * activated without new values.
+	 */
+	resctrl_kmode.ctrl = KMODE_ASSIGN;
+	resctrl_kmode.mon = KMODE_ASSIGN;
+}
+
 void resctrl_file_fflags_init(const char *config, unsigned long fflags)
 {
 	struct rftype *rft;
@@ -4814,6 +4837,8 @@ int resctrl_init(void)
 	if (ret)
 		return ret;
 
+	resctrl_kmode_init();
+
 	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
 	if (ret) {
 		resctrl_l3_mon_resource_exit();
-- 
2.43.0

