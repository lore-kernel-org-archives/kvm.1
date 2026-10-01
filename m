Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC744343EC;
	Thu,  1 Oct 2026 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867535; cv=fail; b=MoNfSY1HwTYQyxSrvRzePOmFLnofLVZlfztmyXQKS5P9o5fVLkX976JOIFyiiL4qKREED62gTFXN4sJVhWDp+DDHr6NWuu5voGIdlT63LTCDv54lbqVUKxgRR+3/2WeM/XL2RgjcUNI0Rm3sQr7oMjoHGGZYGdtnBpYxQmq8mrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867535; c=relaxed/simple;
	bh=0dj44qR3+6TOpdyCKBpxdwYY2lJ0YjKnZpaM20RoZdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsX7lZWoMV6A3t0FBb7JExIiYckhzuk+kJH3BATiz41rrc+MRv7ucLkHZYSAw4Fks0bBxagq8R0UqeejhEPnRjrd0cMACSquBE+P7ZFhXBzrbUdXx/3QVOiNDcbBkJFc/60+VZFjWFViK8mlmybjTULnwQM95+r6Iu1M4ttsSwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kjc8XglC; arc=fail smtp.client-ip=52.101.61.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kjc8XglC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILqoeLCtjZ3oiQ4Sg8sXkBZNB5xATmDeIquy7ssHZA3sw981CYdlruhsgpqfn++mOZsfqqj26TW9xrOMfh48PcjwapZ6F/aGBH4SDmICA5e8jQ1Tse3bmo2yWN5BOczy+/pLzVIU1ge4bxqoqQmVV8UU+Y/ezlnIOWuI9fkKAqoluBMyidG1hvPYvKryQ4wsw5T3KDiXCY9/ZFPV4MpN5dOCCLZ5wWATign28mV5pBisPmeGZzwZa/xxe9WKmfJsWQQkyUFCoyemNxXkYaDaR6JEiTY/AYW5+Ww5fxX78w5kKS8Sib+DuqItuve1o1WOP/at12Eu1VglBNDJKk8zPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90zWcHnPK0xFTkruBxkivFa/UqdZNM1zOFqiSpGVObQ=;
 b=hSmrb/eXG8Gy5IGS5fj2jENZM+C+oDf2yq/FD1JplfBWDryq/BSQYFIUJ+GqIzNpDi05+ek4CZfIQM54OWiZCR0qKTChbJvHGKJTyQs8gmgDWqcMNcHxNxCFspEzSe/gpyeWUXbHN8tXPYi56lnarE8TZ2Mp0xfxy+LCNnISW5vzYfxDcvMZRsuEK0eilzc65P/FZwBef7JOFkwWbd6HhrMyMhylv/OY5Y7qJ7fg9vPp5OCDtDW1CoMKgrjguXs/BNK/dPjLigysGSpQ8iavKuW58e2X+J05s3mRE8WOMZ6XVoj9pk3bIbFWvcIasdBciLuVtEJGNyrnQEkkqDMGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90zWcHnPK0xFTkruBxkivFa/UqdZNM1zOFqiSpGVObQ=;
 b=Kjc8XglCxVLltAStOFldJmwSjc0odBEKUWNsRnJfY3GiRQ+t19DU/fZUExihPNui7yz+kPnsYkAi8ZJbqyWQYw1TnoKP5NS6i2I5BCnPkSbZ5+zWOll81mtltONn751fOWYqX7DNTXxXfGKSUNAxuIEfDLciro/LJkmKe8JYaZg=
Received: from BN9PR03CA0280.namprd03.prod.outlook.com (2603:10b6:408:f5::15)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 15:11:27 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::7a) by BN9PR03CA0280.outlook.office365.com
 (2603:10b6:408:f5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 15:11:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:11:27 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:11:25 -0500
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
Subject: [PATCH v6 04/18] fs/resctrl: Introduce kernel mode enum
Date: Thu, 1 Oct 2026 10:10:27 -0500
Message-ID: <66efcdc1bf71c1cb47c546b1d1299b58594bd30d.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0485de-9192-4946-ba58-08df1fce442d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OlxyklI2ZPEqT90otCD3V/ZIxjNLCEvTTKByKGj71X68cD3vIpa8dv/Aefki3dla/TbCyv1bceKIz+fE9+R9c05oTHuQ6BFYoM01uizzF6fC2UixLInm+Jh59V5pUSTgqY2mdmWTf3x5e9mNZT0WPlLLOHuSrTh676vEjIb76igl2iV6HwWPBsQk0leY5fLiuRZf5KH4SpKhhhs+g3b1KK7JL2Nv1d2VmPIvJuSM+BPAfWdbmzwSeV+bhcqHSAalYyKuItKmQntmwWPNnnKcNl3pBwfMnqJvjObQ5icxSvWF29Iku1GT2jGWeCGB3mdW+uoUei8VIa1Jx9/hF4jKX5Kxeaex9+MXtBZ1gSMtkuvtWv7F9J0pv1H9zHy7KtwxKJ1f/YlNcnGaMthTUVSwA1o3bpIIa2HHPZXoRn+JmgmXt/lkwMfU9hF2fik2EzQ32fiYUIOH+/6mH9vJErlEHOF3iC9kjfq0zl1HYXK3nvFkN1AQQrb8SOl3K9CVlTdkKNgWsy+UUMD7WELy+hdYqau7AAumzwQJ57JW9aD8VsUz9GvF1qBttIcyW6vnfi+vvKZaDH9uNpM0rom6p8zxkuWEr+hInk+TkWXD+m36o2/Ll3n6jSpzYRTWu7vPXI6kNLeT3RONGwV/Fj0+kL7B1qVIDIglxovWCCiwoDlKGeuNW91T8SQvRhlqXTSfibJxpc0FgykCGfc0KUrFvVRN+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UGbTq6Yj81WY1E9rNaprSY4rqw/e56muH4/xg1+1/Q0Lrg3xL8eJ8rfchH1skNSBFCcmEAdzEgYSfru/EH1NpNWLltztq0lF1TzXSqobEi5+TTOWiHAS+cJBb5yA8JX96YtK5yZHUkgORhy+HTDSKqVRFkVqt3FJYM3HmekNElpy56tHkLCwZmTFZ/MFZskFKigJf9SDVYTHNjprXyyejMs1z03As+MswYrhLaU86tQn+Vo+Jk+STQ+IA3mG1sja0hzubaxuoJyH7FnYw5yTc9VG1cp88UPpD2U9XBRpAhp5S5nPLRdaNfy5v3xjxnBZBjLM9wl2FVeZNd+3dCrVPLi/ekZjzleOj6Ec04GrbB1BTRq2D//Tf9L8iNu68L1jOHCg1iN1hylhOCzjKC/4XvVTUOeLwABytjS8x8db/7+wU9RLYE/wXVwuEYHL83f/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:11:27.7040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0485de-9192-4946-ba58-08df1fce442d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728

Kernel mode work can use different allocation and monitoring associations
than the originating user task. On x86, Privilege Level Zero Association
(PLZA) enables the kernel to switch to a different CLOSID and/or RMID when
entering kernel mode.

Architectures need a common way to name kernel modes before resctrl
can report what is active or what the platform supports.

Introduce enum resctrl_kernel_mode:
  - RESCTRL_INHERIT_USER: Kernel mode work inherits allocation and
    monitoring from the user task.
  - RESCTRL_GLOBAL_ENABLE_PER_CPU: Kernel mode work uses allocation and/or
    monitoring associations that differ from the user task.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: changelog update and code comment update.
    Renamed RESCTRL_ASSIGN_GLOBAL_ENABLE_PER_CPU to RESCTRL_GLOBAL_ENABLE_PER_CPU.

v5: Collapse the two global-assign modes into a single
    RESCTRL_ASSIGN_GLOBAL_ENABLE_PER_CPU value. Update the changelog to
    match the enum names and descriptions in the code.

v4: Updated the changelog to be generic as possible.
    Moved the enum resctrl_kernel_mode to include/linux/resctrl.h.
    Updated the code comments to be generic.
    Removed resctrl_kmode_cfg from the code. This definition can be fs
    specific only and architectures dont need to know.
    Changed enum name to resctrl_kernel_mode from resctrl_kernel_modes.

v3: Removed resctrl_kmode definition.
    Changed the kernel mode definitions to enum resctrl_kernel_modes.
    Used BIT() to set/test the features.
    Added details to changelog.

v2: New patch to handle PLZA interfaces with /sys/fs/resctrl/info/ directory.
    https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
---
 include/linux/resctrl.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 10dfdca7f4bf..f6adff7f4e1f 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -723,6 +723,35 @@ int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable);
  */
 bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r);
 
+/**
+ * enum resctrl_kernel_mode - Kernel mode control and monitoring association.
+ *
+ * @RESCTRL_INHERIT_USER:
+ *     Kernel mode inherits both allocation and monitoring associations
+ *     from the user-space task. On x86, the kernel uses the same CLOSID and
+ *     RMID as the user-space task.
+ *
+ * @RESCTRL_GLOBAL_ENABLE_PER_CPU:
+ *     All kernel mode work uses the same allocation and/or monitoring
+ *     association via an assigned CTRL_MON or MON group. The mode can
+ *     be enabled/disabled per-CPU. When the mode is disabled on a CPU
+ *     then the kernel work on that CPU inherits the allocation and
+ *     monitoring association from the user-space task, effectively the
+ *     kernel mode becomes RESCTRL_INHERIT_USER on that CPU.
+ *
+ *     All online CPUs are included by default. A subset may be selected
+ *     through the resctrl group interface, and a CTRL_MON or MON group
+ *     may be assigned to this mode. On x86, CLOSID and RMID are configured
+ *     independently; either or both may differ from the user-space task.
+ */
+enum resctrl_kernel_mode {
+	RESCTRL_INHERIT_USER,
+	RESCTRL_GLOBAL_ENABLE_PER_CPU,
+	RESCTRL_KMODE_LAST = RESCTRL_GLOBAL_ENABLE_PER_CPU
+};
+
+#define RESCTRL_NUM_KERNEL_MODES (RESCTRL_KMODE_LAST + 1)
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-- 
2.43.0

