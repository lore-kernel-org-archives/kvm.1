Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324AE3803D2;
	Thu, 12 Mar 2026 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347921; cv=fail; b=mgwTYf/6ZlU6gZIKZFTa8CeylRSB6eYy2q9pNhI1PGCcDc/xOFuLc9r5vf10bVN59o640jQ0v1f0KJS9vGKMleS9FJJnPDQVq1ytyb+BsZY/lZeiLYhdhHg0eoSW17wHiStSIOMr4V+tNXcDJqiM4kqmaiTEcLLzproqUhf/L5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347921; c=relaxed/simple;
	bh=4kplOKgmxaYsgGGGI5EUTdsmBiMIqLHDEb3/7Quf3tQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLyl+sB9UX1UUmyEdzeCWRNqEuAz2dui59u+B8JXp4B+uF4BVppTin8mcKB201kCs8DKzmzJ9vqLVZ7ALlq+7go6eqH+ng8gLG572KpFESedBEEBj/E+Z1cDETlDQhz5q4SYOaZ7jmhuCSziXlPo6b2VxoRaRwX0NKamOlTaCbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pR5bjx6n; arc=fail smtp.client-ip=52.101.62.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pR5bjx6n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1U+VEWCXiJ42Wzsl46Or+rI/0pq3ZyqsSvuQvnhQXa2wXO0QDuhYDzZnyhuDB9kwO3o9BVsrpyrTIgAJFzYgLTkYuakvucpK8nJeCGqXm3S0c7TmpfcNW+rJZQf8OCSEe0azLJbZUBFazhRz9+cFTgriFEjR6yQO5Ue0zM+s8+rvrf9jtSAAGTfErzmDdbH74LltiRqUILp/n8XSZyU5FPfrGkkpyGao4445rkmWuZmbk1ddZQQIAxg3AhQgn3cLXcICcxUYb1ZbcgTAMQmsbdLvnif4qAjthSI1hPUShV2YOdI50PDhEzirt/VUHW/sLKr+SN+vnUwHine+6ZGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfxTA5Mw4ICFXbzioVxjIp7XYDZ3+Key5EMPVq0HCi4=;
 b=J24u+KT0OfD85XDFdnNGeZVEN7CE2g7uu36iiPyYOXn5E6ihCrg4p1TOmdsNOPP6bJ+H3uOtF8amE9UFrIsbQNivk9TCgYpccXNPtpmwywNoW5xh3f/TLOB1Cu4Cj9KAdXKiaUeKlAST99P82ApYLp1dvG/Bc3Qr/D5BRgQYMONQ662YjhZ+cdJ8Iv1VfnnOxzluDB91aW4N+SKoqm7WSgg6jZsw9cHl12DVloirxFM6laYvOPI+xu51reQIx5GUWPWztI1/yYra29pjrDZ55d1ZulFlaK1yIctyTpk+10LG5+IEwlP6mdI87YFdTsrxjS+8wUBjzh4Powr6TgXpYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfxTA5Mw4ICFXbzioVxjIp7XYDZ3+Key5EMPVq0HCi4=;
 b=pR5bjx6nMKOLNugnVC5POHpEI9jQcbf5xyvcPisK5jgxiRRJoL3zOFji3cL0wAo335pMFxKttgZJ6c7z7/vrrclmpwPSEtao9hYqMmJCVX1/ol0pcBk6qHZrZDRtRGN9mYyJ9bY3TCuL6Yc77x7YZ7Xprxe3fHZqDLMWgOhJ5Yw=
Received: from BY3PR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:39b::27)
 by LV9PR12MB9757.namprd12.prod.outlook.com (2603:10b6:408:2ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 20:38:36 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::ce) by BY3PR05CA0052.outlook.office365.com
 (2603:10b6:a03:39b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.8 via Frontend Transport; Thu,
 12 Mar 2026 20:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:38:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:38:31 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <skhan@linuxfoundation.org>, <babu.moger@amd.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<akpm@linux-foundation.org>, <pmladek@suse.com>, <rdunlap@infradead.org>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <safinaskar@gmail.com>,
	<fvdl@google.com>, <seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>,
	<xin@zytor.com>, <tiala@microsoft.com>, <Neeraj.Upadhyay@amd.com>,
	<chang.seok.bae@intel.com>, <thomas.lendacky@amd.com>,
	<elena.reshetova@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <eranian@google.com>, <peternewman@google.com>
Subject: [PATCH v2 09/16] x86,fs/resctrl: Add the functionality to configure PLZA
Date: Thu, 12 Mar 2026 15:36:54 -0500
Message-ID: <f3ab034a465877d7f37129e13074a0e4f5d5d735.1773347820.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773347820.git.babu.moger@amd.com>
References: <cover.1773347820.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|LV9PR12MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 5360489c-e6a5-4eda-3675-08de8077558e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|18082099003|18092099006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	SxohJsipPP9jPXGdaO105Cywi/iBgkBmYxzu4XliFWLuvYPYT0qzwZF44c4PJKTTlNZfHvg7WnufSaalv32EiKh3Jyq2bNq3S6mBBV+9KIlI8M9QF7gRLwIZQ9w3ZpuOw5VCh3QeCwgWqlR9wUtRO+Hzvx7DKLY80KIgX5F/fyMqIO1ol/xfea0q+kd6V488IguNwD9MCbuCJFLDK++FsbBc6jVmzhuO2GDQIk1XGRmyozDp6HqukMRHb1j3YvuIZLwVj72mKtTLBhL6DBBbvY2xzm4+BqEjBgmvvUI3Q/qAnZ37u/wp8Muf3nZ5T2rgJ7zsE9ZK8Qmh49ICalYBI/2I2vqaHcGK1Mx3ibP9gsGNN5bW3nwPrwre7NjnombFbNLCzL/O4xIoC16Zz2DEh0tFqUTKIYGN3aBFOu3FDSMuPxyP21qpokHAMFGuDlLPdtrTy8LZTPqHmhVWHM7l/D4a+mNKp00w5+b2RVw9xGu9lg33UcFBuVeQfLHQ4IuOADtVx3ZyXs5Sa3jRkD50xEW51lH7flmVMQDvk9AKYxBaZ6P8uoWE7oT3/OOI4wT4N4gIX9wDxtS/4YTfiFUAVuaj8kb21sSorWE7H/NRnVe5IEgJGCKtiGRl9900K6VH86FvnI8W9k2qHmxKgoLw6YCzNg7wtoeFZG4g5ZL3f3LLfs1mLRvJHlzgZOZMkTqzabDQvWcFxAIiraUjxq2au43SKVKC2UHg6b+h/pGDYgAzDC8tT+04SZJhNjkDcnFDiQoXf5E2EpnxvDhSN+0vLw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(18082099003)(18092099006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w+RumxhUMOO5Y2k3dKy0Jl7o0ApBIH0FUHZwIrJOUuS04N5w7YXWGs1nln+e/kP/L3cYZGt24LdAhKgUI4egeZLdxd+jVnQroFpb53YrsHrH3uzLcKU1IaefkNzhV2hamli5qZ4F2/z9l2tC7lGCHUm6P827Bh9S9PuE3hG/zX/LX3DXPeemX5XDlUZQf64uktzvzsn45h+MhXQkf1uLty1A0LwN1/vyENmqWPijkQzmGJfajpPWG6bsP8GGNOdGsbqNfs49ywhH8o665ocgjvA98k4W/H9j72VGmeOexDAhBqrRI2zlUZpGUL5lRUC7FMngVFjbYOm3zMcw5BaqXe5BRB1AtWTK6DjWK0NJljzIOtnNv75o42kIV+qGwEIeXEEz6vrxx+OO1ENs8udvsy88wfZbH6xvWzwBfv3cpSgit2L75q5Lzswkm6ffufOE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:38:35.6950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5360489c-e6a5-4eda-3675-08de8077558e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9757

Privilege Level Zero Association (PLZA) is configured by writing to
MSR_IA32_PQR_PLZA_ASSOC. PLZA is disabled by default on all logical
processors in the QOS Domain. System software must follow the following
sequence.

1. Set the closid, closid_en, rmid and rmid_en fields of
MSR_IA32_PQR_PLZA_ASSOC to the desired configuration on all logical
processors in the QOS Domain.

2. Set MSR_IA32_PQR_PLZA_ASSOC[PLZA_EN]=1 for
all logical processors in the QOS domain where PLZA should be enabled.

MSR_IA32_PQR_PLZA_ASSOC[PLZA_EN] may have a different value on every
logical processor in the QOS domain. The system software should perform
this as a read-modify-write to avoid changing the value of closid_en,
closid, rmid_en, and rmid fields of MSR_IA32_PQR_PLZA_ASSOC.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: - Updated the commit message to include the sequence of steps to enable PLZA.
      Added mode code comments for clarity.
      Added kmode to functin names to be generic.
---
 arch/x86/include/asm/resctrl.h            | 19 ++++++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 77 +++++++++++++++++++++++
 include/linux/resctrl.h                   | 30 +++++++++
 3 files changed, 126 insertions(+)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index e0a992abaeb4..167be18983c1 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -186,6 +186,25 @@ static inline bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 ignored,
 	return READ_ONCE(tsk->rmid) == rmid;
 }
 
+/**
+ * resctrl_arch_set_cpu_kmode() - Set per-CPU kernel mode state for PLZA programming
+ * @cpu:	Logical CPU to update.
+ * @closid:	CLOSID to use for kernel work on this CPU when kmode is enabled.
+ * @rmid:	RMID to use for kernel work on this CPU when kmode is enabled.
+ * @enable:	1 to enable PLZA on this CPU; 0 to leave disabled. Stored in default_kmode.
+ *
+ * Stores the given CLOSID, RMID, and enable value in per-CPU state (kmode_closid,
+ * kmode_rmid, default_kmode). The actual MSR_IA32_PQR_PLZA_ASSOC write is done
+ * separately (e.g. via on_each_cpu_mask) so that closid/rmid are set on all CPUs
+ * in the domain before PLZA_EN is set, per the PLZA programming sequence.
+ */
+static inline void resctrl_arch_set_cpu_kmode(int cpu, u32 closid, u32 rmid, u32 enable)
+{
+	WRITE_ONCE(per_cpu(pqr_state.default_kmode, cpu), enable);
+	WRITE_ONCE(per_cpu(pqr_state.kmode_closid, cpu), closid);
+	WRITE_ONCE(per_cpu(pqr_state.kmode_rmid, cpu), rmid);
+}
+
 static inline void resctrl_arch_sched_in(struct task_struct *tsk)
 {
 	if (static_branch_likely(&rdt_enable_key))
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b20e705606b8..b5dfe30aca26 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -131,3 +131,80 @@ int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable)
 
 	return 0;
 }
+
+/*
+ * IPI callback: write MSR_IA32_PQR_PLZA_ASSOC on this CPU (AMD PLZA).
+ */
+static void resctrl_kmode_set_one_amd(void *arg)
+{
+	union qos_pqr_plza_assoc *plza = arg;
+
+	wrmsrl(MSR_IA32_PQR_PLZA_ASSOC, plza->full);
+}
+
+/**
+ * resctrl_arch_configure_kmode() - x86/AMD: program PLZA per control domain
+ *
+ * For each control domain, first sets per-CPU state (closid, rmid, enable=0)
+ * on all CPUs in the domain, then writes MSR_IA32_PQR_PLZA_ASSOC on each CPU
+ * so that closid/closid_en (and optionally rmid/rmid_en) are programmed
+ * before PLZA_EN is set, per the PLZA programming sequence.
+ */
+void resctrl_arch_configure_kmode(struct rdt_resource *r, struct resctrl_kmode_cfg *kcfg,
+				  u32 closid, u32 rmid)
+{
+	union qos_pqr_plza_assoc plza = { 0 };
+	struct rdt_ctrl_domain *d;
+	int cpu;
+
+	if (kcfg->kmode_cur & INHERIT_CTRL_AND_MON)
+		return;
+
+	if (kcfg->kmode_cur & GLOBAL_ASSIGN_CTRL_ASSIGN_MON) {
+		plza.split.rmid = rmid;
+		plza.split.rmid_en = 1;
+	}
+	plza.split.closid = closid;
+	plza.split.closid_en = 1;
+
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		for_each_cpu(cpu, &d->hdr.cpu_mask)
+			resctrl_arch_set_cpu_kmode(cpu, closid, rmid, 0);
+		on_each_cpu_mask(&d->hdr.cpu_mask, resctrl_kmode_set_one_amd, &plza, 1);
+	}
+}
+
+/**
+ * resctrl_arch_set_kmode() - x86/AMD: set PLZA enable/disable on a set of CPUs
+ * @cpu_mask:	CPUs to update (e.g. a control domain's cpu_mask).
+ * @kcfg:	Current kernel mode configuration.
+ * @closid:	CLOSID to use for kernel work when a global assign mode is active.
+ * @rmid:	RMID to use for kernel work when GLOBAL_ASSIGN_CTRL_ASSIGN_MON is active.
+ * @enable:	True to set MSR_IA32_PQR_PLZA_ASSOC.PLZA_EN; false to clear it.
+ *
+ * Writes MSR_IA32_PQR_PLZA_ASSOC on each CPU in @cpu_mask (via IPI) and updates
+ * per-CPU state. No-op when kmode_cur is INHERIT_CTRL_AND_MON. Call after
+ * resctrl_arch_configure_kmode() so that closid/rmid are programmed before
+ * PLZA_EN is set.
+ */
+void resctrl_arch_set_kmode(cpumask_var_t cpu_mask, struct resctrl_kmode_cfg *kcfg,
+			    u32 closid, u32 rmid, bool enable)
+{
+	int cpu;
+	union qos_pqr_plza_assoc plza = { 0 };
+
+	if (kcfg->kmode_cur & INHERIT_CTRL_AND_MON)
+		return;
+
+	if (kcfg->kmode_cur & GLOBAL_ASSIGN_CTRL_ASSIGN_MON) {
+		plza.split.rmid = rmid;
+		plza.split.rmid_en = 1;
+	}
+	plza.split.closid = closid;
+	plza.split.closid_en = 1;
+	plza.split.plza_en = enable;
+
+	on_each_cpu_mask(cpu_mask, resctrl_kmode_set_one_amd, &plza, 1);
+	for_each_cpu(cpu, cpu_mask)
+		resctrl_arch_set_cpu_kmode(cpu, closid, rmid, enable);
+}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 2c36d1ac392f..3f3e8c1e549b 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -709,6 +709,36 @@ bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r);
  */
 void resctrl_arch_get_kmode_cfg(struct resctrl_kmode_cfg *kcfg);
 
+/**
+ * resctrl_arch_configure_kmode() - Program kernel mode (e.g. PLZA) for all domains
+ * @r:          The resctrl resource (scope for control domains).
+ * @kcfg:       Current kernel mode configuration.
+ * @closid:     CLOSID to use for kernel work when a global assign mode is active.
+ * @rmid:       RMID to use for kernel work when GLOBAL_ASSIGN_CTRL_ASSIGN_MON is active.
+ *
+ * Programs each control domain so that kernel work uses the given CLOSID/RMID
+ * per the active kernel mode (e.g. MSR_IA32_PQR_PLZA_ASSOC on x86). No-op when
+ * kmode_cur is INHERIT_CTRL_AND_MON. May be called from any CPU.
+ */
+void resctrl_arch_configure_kmode(struct rdt_resource *r, struct resctrl_kmode_cfg *kcfg,
+				  u32 closid, u32 rmid);
+
+/**
+ * resctrl_arch_set_kmode() - Set kernel mode (e.g. PLZA) on a set of CPUs
+ * @cpu_mask:	CPUs to update (e.g. a control domain's cpu_mask).
+ * @kcfg:	Current kernel mode configuration.
+ * @closid:	CLOSID to use for kernel work when a global assign mode is active.
+ * @rmid:	RMID to use for kernel work when GLOBAL_ASSIGN_CTRL_ASSIGN_MON is active.
+ * @enable:	True to set MSR_IA32_PQR_PLZA_ASSOC.PLZA_EN on the CPUs; false to clear it.
+ *
+ * Writes MSR_IA32_PQR_PLZA_ASSOC on each CPU in @cpu_mask and updates per-CPU
+ * state. No-op when kmode_cur is INHERIT_CTRL_AND_MON. Call after
+ * resctrl_arch_configure_kmode() so that closid/rmid are programmed before
+ * PLZA_EN is set. May be called from any CPU.
+ */
+void resctrl_arch_set_kmode(cpumask_var_t cpu_mask, struct resctrl_kmode_cfg *kcfg,
+			    u32 closid, u32 rmid, bool enable);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-- 
2.43.0

