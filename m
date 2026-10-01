Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B092A52F279;
	Thu,  1 Oct 2026 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867509; cv=fail; b=gjgNmpDJqfi+11kJy6E2JlWTuzgBXk36iGza7yNWrDrxCfv+/aBwyIora1x6r4rpbVz8hHwe7GqkUOdDL2C8p9LOCVveGysbsVLoQiV1J2ofZ9oX3siqzVteqSp1Wz5dfQL1Kzr3MBnZ63e/CK6Ff1HHPg700cwUPIl04L9uu3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867509; c=relaxed/simple;
	bh=OD8krowbh7U4ZP1eP6gP/9JI4kVLuTgBxhZSrnRAsfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7EpBat0AyULgERN52v8vLGOpHlw1zjgxxQrk4DsfjjBGHYn57hIBQDZx7cSSCFiG79RHWPmRbNfh5TXRDiLDBjdNcY7XULeAEGmpo5cvRfVrbXDor7FJBOudPDzpdhIFO8GTZwbbQKSH46lArvQQORB+iiFEV60HVpzus2MK14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gn+WGxzX; arc=fail smtp.client-ip=52.101.52.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gn+WGxzX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdFdBTS6ZY/VPWdsTKn7rXRSJZ8yVTZgRYgEpd31BM/qDfbDiZpQZaXVJi9osuu/qRQkIt0B6tz1Q3aKSMxVzwdPdItmCVILns/4DQ3YDb8prtOShq1YOA/CSk2+C/IO5zi2Iu9jwtRMoVaKvgRK6CtMfxshNGDLLl2AR3H1ghLs8pJkhAqGx0xQxy105T5TOsfcYYo7yA1Rfl2uSUSx+67fS7K0dlGrB17nuw3OC5A1Zu1wpY/wNRrzRiJane0ORcPWbjZ9k+Ixh8lROwAliRwbyi/0wjDUM1Rrsft3muqxThFUuD6oObP2+1aNkqNsME+g6bh3GR2wJYaQpjGwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn5HWG30qhKLEF2lf2x4inCmmA7s8y3jSmfL6VsRq1M=;
 b=m5bLI2iWFFtV9zHNNWUHj17OgoURK7hvp8vuJyVvQniLKGFEY0HPS48boTLCgUFK5ReJA+5f0WhQoXdBN7DPn6bAna6e1spUVYVsZWRPf1jg/DWFTLSynOo3JbIsXUtOe4vzw7aiTvR12hvhCV/no33dORxO0EC2rpbssDjcfADP/RU68zWNzacO1Yiu94niQUvhRyyLPaQ2a79zZBtpnnpRjFs5CKebACP8BjVNU7S2L5Rl4wjUm0PyJJBZAY12lrQD86UIDXPQj0G3g++GKv8Uz8KkC7onUsXav+JtFh/ZOyIC9fi6v2x2ZKQVPnFhLODhCZbTaHoD4XJ4K9SjTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn5HWG30qhKLEF2lf2x4inCmmA7s8y3jSmfL6VsRq1M=;
 b=gn+WGxzXVcUWybA4xOgOe5CopBgoNn5APuGd2jRP5leYGQLbigpVz99sRH9j8ZlWqBe1xZ8vm1hMg0/rj2/meCAuUhDjwFepn1Jil5w+lXImgcvf2uB3sFv0MKPhCEavKQ0FtIR1+KRHhTL5GckjUDX/gqHLJYuhi1P802vXbqU=
Received: from BL0PR05CA0002.namprd05.prod.outlook.com (2603:10b6:208:91::12)
 by DS7PR12MB9502.namprd12.prod.outlook.com (2603:10b6:8:250::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 15:11:41 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::a2) by BL0PR05CA0002.outlook.office365.com
 (2603:10b6:208:91::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 15:11:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:11:41 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:11:33 -0500
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
Subject: [PATCH v6 05/18] x86,arm,fs/resctrl: Introduce architecture hook to program global kernel mode
Date: Thu, 1 Oct 2026 10:10:28 -0500
Message-ID: <12063d85972c5a41a95fbded4a01858e5bb04e6e.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DS7PR12MB9502:EE_
X-MS-Office365-Filtering-Correlation-Id: 0597876a-20fb-4d89-a413-08df1fce4c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|7416014|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	D3V839ryH19qgB/iKGgw7+6CSTxtzGlR/f1VbQZkwuiTdh9qKgxOfBEfcmK4L1J5hbMYPoo6QZKz4mBegHU1TDSxL7FIUjz1SEm6GHoAW6gSTrrwkARJJviKTtKjGJ1WB28jjC5S2wJA6vpKgCtq7ZCEaf64RkNINPiPGdYnkN62ZCVHLzTgNagJchGTW0dGplF3HypAu37HjzJkVjcQkvonW1DaE119Fz0b2XgAKGUF+PjbdBepLktcnyM7AuzieGSdh4Gs8kavYXAr/Zcb2DJiWITVbqd490e0dyZrLOR5rfloLQFwsGKlpl24VIhuI4JZ4QHcr9h/xN9s8IlEAQKThB2cG3Xmx9bNUKC5jh3pGF3esfh4tqDCo2qlhcr91wYKHjCe2SBF7EPqSbs/7JshWwOExcbABdW18IAfXlqzaE6QmBDAEifCTrtkhRU/p3m8zu7wgDvHIzbhLo/J6phH1KR16DRJ1Qdw4DNzLhZ4h6CN7r9m2dyBDZS9esq9nW0vuqDyWbFQiyDNTjKbBR6UXAFtyhYM1/1vQGNfVJjwkjcVDRB4bRYdinAQ7Ghq5J62x1wQfW0/o1JXmnoxTOQN5M1IYCffhnUfx1eDn1/WPl7UYNyDt0efpRmHB+DFp8z4fPAq8TfF3ugHtkAY9KDg+tMqaDM3bxKNTbgoocOTUf6tP58LBiZhAlZ97rLzTz4iXx/2v9qiHBn1ZyfvlQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(7416014)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E4Z86Uz5lTg6FWUrUUNKxFI+gY2PyMwYy10sbELf8tN351+DtOuwdAbKtUpVMMA4olN3zlHIpud7bXE72RfFFsklBoxWRPx7XbVohqFiGQWxeRDK/z6uMdpI8nN+Cmp8gNeVDJr7nQ7QfUHHcr55Ecbgin82mKQuhFs01wtvhiaG19xgvLVUzZHbd0I8mR+yo9gCRjk5MxEgvUnFnyXMrHnn36xigsY4vTmLXDXcrudWwczsbCd3CMQ9a1OcIheV8+kifMuKv1GEi0+bpVA5iOpjQZ5D4mR0dpN3ohEDEwfZzChKy16PloRFXhuDf0GaYTBjSrwVVSCszt3DS78nHcXseR+WhhAkDJIO8l/t7B05IDcORJH2bzpairw1Rc5ylPCFIoENTMpiFCZBV//fUWQtS27G4eskcpw2n8zQ6SClQqJEyhNFi823k7C8xyP5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:11:41.2155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0597876a-20fb-4d89-a413-08df1fce4c3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9502

RESCTRL_GLOBAL_ENABLE_PER_CPU mode enables kernel work to use different
allocation and monitoring associations than the originating user task.

The mode is enabled independently on each CPU, so the filesystem must
program hardware when the mode is activated, when CPUs are added or
removed, and when it is deactivated. Allocation and monitoring associations
can be done independently, so the architecture callback takes separate
control and monitoring options.

Add resctrl_arch_configure_kmode_global() with an x86 PLZA implementation
and an empty MPAM stub for ARM systems that do not support this mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Rename to resctrl_arch_configure_kmode_global(). Rewrite changelog
    for RESCTRL_GLOBAL_ENABLE_PER_CPU only (not a bugfix, not a code
    restatement). Add arm to the subject. Document parameters first;
    closid/rmid are always programmed. Split fs/arch contract from
    call scenarios and name the mode explicitly.

v5: Fix kernel-doc for resctrl_arch_configure_kmode(), wire assign_ctrl
    through to PLZA closid_en, and update the changelog.
    Add calling context in API doc.

v4: Added assign_mon parameter in resctrl_arch_configure_kmode() to program the RMID
    as discussed in below.
    https://lore.kernel.org/lkml/20260605100642.1103628-1-qinyuntan@linux.alibaba.com/
    Reintroduce independent monitoring assignment via assign_mon after removing
    the task-based PLZA approach in v3.
    Changed cpumask type to "const struct cpumask *cpu_mask".
    Added MPAM stub to avoid any linking issues when resctrl_arch_configure_kmode()
    is called from FS layer. Thanks to Qinyun.
    Re-wrote the changelog to be generic.
    Updated code comments.
v3: Removed task based PLZA implementation so related changes are removed.
    Per-task RMID handling is replaced by group type selection in the fs layer.
    Updated the change log with details.
    Removed resctrl_arch_set_kmode() as arch only provides the modes supported.
    It is FS which decided which mode to apply.
v2: Updated the commit message to include the sequence of steps to enable PLZA.
    Added mode code comments for clarity.
    Added kmode to function names to be generic.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 38 +++++++++++++++++++++++
 drivers/resctrl/mpam_resctrl.c            |  7 +++++
 include/linux/resctrl.h                   | 37 ++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 62044489b052..a343dc0c71c5 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -137,3 +137,41 @@ int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable)
 
 	return 0;
 }
+
+static void resctrl_kmode_set_one_amd(void *arg)
+{
+	union msr_pqr_plza_assoc *plza = arg;
+
+	wrmsrq(MSR_IA32_PQR_PLZA_ASSOC, plza->full);
+}
+
+/*
+ * resctrl_arch_configure_kmode_global - Program Privilege Level Zero
+ *					 Association (PLZA).
+ * @cpu_mask:	CPUs whose PLZA MSR should be updated.
+ * @closid:	CLOSID programmed into MSR_IA32_PQR_PLZA_ASSOC. Always
+ *		written; required even when @assign_ctrl is false.
+ * @assign_ctrl: Whether PLZA should program the kernel-mode CLOSID.
+ * @rmid:	RMID programmed into MSR_IA32_PQR_PLZA_ASSOC. Always
+ *		written; required even when @assign_mon is false.
+ * @assign_mon:	Whether PLZA should program the kernel-mode RMID.
+ * @enable:	Whether PLZA should program the kernel-mode association.
+ *
+ * Program PLZA on @cpu_mask for %RESCTRL_GLOBAL_ENABLE_PER_CPU. See
+ * union msr_pqr_plza_assoc for the hardware field meanings.
+ */
+void resctrl_arch_configure_kmode_global(const struct cpumask *cpu_mask,
+					 u32 closid, bool assign_ctrl,
+					 u32 rmid, bool assign_mon,
+					 bool enable)
+{
+	union msr_pqr_plza_assoc plza = { 0 };
+
+	plza.split.rmid = rmid;
+	plza.split.rmid_en = assign_mon;
+	plza.split.closid = closid;
+	plza.split.closid_en = assign_ctrl;
+	plza.split.plza_en = enable;
+
+	on_each_cpu_mask(cpu_mask, resctrl_kmode_set_one_amd, &plza, 1);
+}
diff --git a/drivers/resctrl/mpam_resctrl.c b/drivers/resctrl/mpam_resctrl.c
index f2c651e9f6ea..0c8594e98526 100644
--- a/drivers/resctrl/mpam_resctrl.c
+++ b/drivers/resctrl/mpam_resctrl.c
@@ -139,6 +139,13 @@ bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r)
 	return false;
 }
 
+void resctrl_arch_configure_kmode_global(const struct cpumask *cpu_mask,
+					 u32 closid, bool assign_ctrl,
+					 u32 rmid, bool assign_mon,
+					 bool enable)
+{
+}
+
 void resctrl_arch_pre_mount(void)
 {
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f6adff7f4e1f..dcb0beb847b6 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -752,6 +752,43 @@ enum resctrl_kernel_mode {
 
 #define RESCTRL_NUM_KERNEL_MODES (RESCTRL_KMODE_LAST + 1)
 
+/**
+ * resctrl_arch_configure_kmode_global() - Program RESCTRL_GLOBAL_ENABLE_PER_CPU
+ *
+ * @cpu_mask:	CPUs whose kernel-mode association should be updated.
+ * @closid:	CLOSID that matches the RMID to program kernel mode. Depending
+ *		on the architecture, the counter may match traffic of both
+ *		@closid and @rmid, or @rmid only. Always provided; a valid
+ *		CLOSID is required even when @assign_ctrl is false.
+ * @assign_ctrl: true to assign @closid for kernel mode; false to inherit
+ *		association from the user-space task.
+ * @rmid:	RMID to program the kernel mode. Some architectures may use
+ *		CLOSID/RMID separately, others will consider them together.
+ *		Always provided; a valid RMID is required even when
+ *		@assign_mon is false.
+ * @assign_mon:	true to assign @rmid for kernel mode; false to inherit
+ *		monitoring association from the user-space task.
+ * @enable:	true to enable kernel mode association on CPUs in @cpu_mask;
+ *		false to disable kernel mode.
+ *
+ * This callback programs %RESCTRL_GLOBAL_ENABLE_PER_CPU. It is called in
+ * the following scenarios:
+ * - If the mode is active when user space changes the configuration, it is
+ *   first called to deactivate the mode on all CPUs where it is active.
+ * - When user space activates the mode, it is called with cpu_online_mask.
+ * - When user space adds a CPU to the active mode.
+ * - When user space removes a CPU from the active mode.
+ *
+ * Contract between fs and arch: resctrl fs always provides the same
+ * closid, assign_ctrl, rmid, and assign_mon when activating
+ * %RESCTRL_GLOBAL_ENABLE_PER_CPU, during CPU add/remove while the mode is
+ * active, and when deactivating the mode.
+ */
+void resctrl_arch_configure_kmode_global(const struct cpumask *cpu_mask,
+					 u32 closid, bool assign_ctrl,
+					 u32 rmid, bool assign_mon,
+					 bool enable);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-- 
2.43.0

