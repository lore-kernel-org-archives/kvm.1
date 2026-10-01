Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D75226AF;
	Thu,  1 Oct 2026 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867552; cv=fail; b=h81LmVOYFriepPpfQOUyShKqHo5ncqjrLXQh3TX0Sp0Awhap1TG2wqqXoBm9XLtLPYsq5T62K2ucO0hsrZfdYv61lMGygvXtaHDsT13A2hf1v0kYG/oY08/lJF0yw3dmqVvoXIwsYZvVHlrHYGfS+ZvSUa5wEsbysGE0zzjCZgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867552; c=relaxed/simple;
	bh=gr1KnB5e6xaDBxGm1IRSjMpV5XdbIBUYGRbCRFAX5nA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyPqEZLxsZbpYcGwsiQAO2RFyyDN0e2CR6nD/OtNvZiEACpElRM2hu/HpgbRdFWwBkHp1hcpH7xa8VQHwHYc7JUtbAfpl37gXcdxXY1o7c0Gw0vTZI4m3j6BG+Mmsm2Cd8bZxfRXE2YJBFNneKPzihZTjw8VX/dXq5oK90JnEe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E3NC00YP; arc=fail smtp.client-ip=52.101.43.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E3NC00YP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouP5KPxdnkGWeOa2Tp15l9veD5gsuBaG3KArug8q4Im2bWpyV4j3W+WqBVKK0PXnif/uTFmQVKwWgEaOg4bAxQhJ5zmAenbIrizyRwS1iFoVoyipsIGD2IzZvy8pG1L9W8XALSfa+lrFbhG04unjZ5th4F8+FboDlUugnxaEtO0mziuWLvLGIO6N/mzRTjd/yvGfJoBs68dOe4x8Dstjc/M0x7VLlxbZFPLeyY9xWVIRpfFstp9K09NrOaH5RrzwC6H1nzxOSrgFm+xmeITfJgyUvgkTy8+mrqkP/cGd+yeOkQsAjvnKDUReohpFlAn2quOAd/Yo9iUbj/PYMVGdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV6h1ujkqyiIeFnfKNSD5PkmjpFUXMHTX/KQ0bkbirU=;
 b=q2/UDtuqqet4NpG16ZES7loyoYZ0IUiYypH0W7GtiM8lA2p0utjHZWcPsw3V7o/tR6edbTTFDIsbcwbt2qYTfRE6LAtiaHG8jkH28pyFWgQ/WmzWJm60OEmGDqKRuW/M5MJX9VoQoeiRv/j02OHv0VbF4eYNLp2fHADI1ff539LQBW4eOaV5Pmz6vEA0oilVfIiAaVrMPhXG8qb3Y4Kh6ufa6WnfpGgyHsSQ1uRHf+mpgO1Sj037jAL2bMLoTO/pHDHMQinD4iamUWTFaRoz7/q2evY6WTb5yjZPrKtwOpEW9/8JWhEf4sccMgkYLWAX5/z9JkBqdJChe1c9iC0fLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV6h1ujkqyiIeFnfKNSD5PkmjpFUXMHTX/KQ0bkbirU=;
 b=E3NC00YPWuGQVoreigqFdy+1Ljix11CnjwDNOoBK+tMweY6HMWUQk/taX1bQRQl2taGbxN6kHegZrwWW3Mwqmb15ILm7UCvwnV+jnPWpRYXvZrOQNqZCgJKWDn7+aMt5nxVaepDS1nfzgDO6JVUMVOYZuseXqAgaJG4oqZu1SG8=
Received: from BN9PR03CA0858.namprd03.prod.outlook.com (2603:10b6:408:13d::23)
 by CH1PPF84B7B0C96.namprd12.prod.outlook.com (2603:10b6:61f:fc00::618) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 15:12:19 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::1e) by BN9PR03CA0858.outlook.office365.com
 (2603:10b6:408:13d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 15:12:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:12:18 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:12:05 -0500
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
Subject: [PATCH v6 09/18] fs/resctrl: Add interface to display kernel mode status
Date: Thu, 1 Oct 2026 10:10:32 -0500
Message-ID: <e044c381e0a8720649408bea47f9251a0dfa1693.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CH1PPF84B7B0C96:EE_
X-MS-Office365-Filtering-Correlation-Id: 380f85de-090c-40da-fd5d-08df1fce627a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|18002099003|22082099003|3023799007|6133799003|10067099003|56012099006|11063799006|5023799004|8126099003;
X-Microsoft-Antispam-Message-Info:
	OEqLfYI5FAJaSGOvX6GObGYIgaiKnxdCtkJtuqaGXob4mJUuPsxfU4MMlr7EwJQt8L/X+1GOLx7qvaguiwHPqfuSyA3LfFQBBrEz+pA76fD/6HJ+kpTXvuGzczJrP+2K13VxbU3/R2LRx3MPyJMRfVndTncpKl0MoFZQj+/Udzr1W1MrOOTtAKMnr1dVJDRffZlwu05jJjp7Hxoo/0mCZsGCtZ1ciMRO/igtMdaTNadCJWHluqOYz6Ao8pZYR1jy8tOeKOH8/dzLgvoDd4JHN7IxDGuTms5v5CGmZ4IllA4ZHUPJy5RqxGd2C69fSWM6qDdW7R9z9QRFjK2G7dj6N9CL+GuqGJYPcrPd9pQB8jtwC3LpefYdf2vNqq0dqn2pn/QpjGoh7t/0QBK8UOt7cz2wXi8XDxYxs3NI0xKSgJbEAWtp+FVVmurCH+rbc9YjQOAgrCWzELIqF0oJg42UZXXSw+HJKMWhwBGjolvOtrmS5TpJdfTkLL4jhZFLp3J88CeclkcPrIsVg9ujJgvHnb2+ehSffwFuWWnwApPPTEdRnJwZFT8EC13h2Z88ecbXwh9eaUOjUTOy0BLnzBFwLmKYH525zbMvdBbtxB1oLI7kD+Z3gB1fxQd6NPJlV3frmTodVMMd0J8SvxtRaMwG71F8ahWm6rYYDFjgcbLm9U0dmBP5rwVuTAbaFFX4UnD7bggqA5A+6PCEX78ualgeow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(8126099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0n2YCCKJWYAtNWogD5V+ht9hC+kGH1rbvkiv3JHz+Yl5Zw9xTyGLhsCMG5+mqBKLh6TNA0SM0Iua2xEMcsCVaFuR0b7kz+KYLtUmMnxS9HU5pFnxyOCmU7/VCUEqkq31oBeYDL6Iui/d6Q/nSwAB4uG2GtbF9S5a0c60VVCvNaUYHyhaCSP5/zC+xSta+JLIUPrpegQk1GxQiPTEiZeaJrR6Y65B/5OBoWAju6funjC2NXGHMSf0WjW4LCxWtqt1VA6hNPSK/qrn62x6slcqOE7iVRSqHtYInfFfF/i6hlhvGk7UtRiIQm7C1Xp7FmJh1TdbJ2b5pRUobV7kiUSoBrbQ/G3ogZH7ID7c0h01E7F3kbMlK5MzRGikPkJkWYrY8mbxovObedIvX3CO1oPUU9RzjB2gJnBuHpK0mooOkAr1gbXr6OKPFuLBcySMUaby
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:12:18.5394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 380f85de-090c-40da-fd5d-08df1fce627a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF84B7B0C96

Resctrl kernel modes control how allocation and monitoring associations
are applied in kernel mode relative to user mode.

Add info/kernel_mode to expose the supported and active kernel modes via
the resctrl filesystem. Supported modes are listed one per line, with the
active mode enclosed in square brackets.

Document the interface in Documentation/filesystems/resctrl.rst.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Rewrote the changelog to make it as feature and not as a bug fix.
    Update the code to use the new name "global_enable_per_cpu".
    Display ctrl or mon only when allocation or monitoring is supportd.

v5: Use resctrl_kcfg.caps and resctrl_kcfg.active after the struct split
    from patch 0006. Rename resctrl_kmode_bind_str() to
    resctrl_kmode_state_str() and ctrl_bind/mon_bind to ctrl_state/mon_state.
    Used info_kn_lock()/info_kn_unlock().
    Add documentation update in resctrl.rst.

v4: Fixed the display of inherit_ctrl_and_mon policy. It is not
    associated with any group.
    Added "uninitialized" for the non-active group.
    Rewrote the changelog.

v3: New patch to handle the changed interface file info/kernel_mode.
    Changed the group name to "none" if kmode binding is not done.
    Reinette suggested "uninitialized". "none" seemed more relevent.
---
 Documentation/filesystems/resctrl.rst |  48 +++++++++++++
 fs/resctrl/rdtgroup.c                 | 100 ++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 73bf89d0ac83..73ccbb9594f5 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -527,6 +527,54 @@ conveyed in the error returns from file operations. E.g.
 	# cat info/last_cmd_status
 	mask f7 has non-consecutive 1-bits
 
+"kernel_mode":
+	In the top level of the "info" directory, "kernel_mode" lists the
+	kernel modes supported by the system, one per line, with the active
+	mode enclosed in square brackets. A kernel mode determines the
+	allocation and monitoring associations when a task switches from
+	user mode to kernel mode.
+
+	Possible kernel modes are:
+
+	"inherit_user":
+		Kernel mode work uses the allocation and monitoring associations
+		of the user-space task on whose behalf it runs.
+
+	"global_enable_per_cpu":
+		Kernel mode work uses the allocation and/or monitoring
+		association of a backing CTRL_MON or MON group. The mode can
+		be activated or deactivated per CPU. The line contains group=
+		and whichever of ctrl= and mon= the platform supports::
+
+		  global_enable_per_cpu:ctrl=<assign|inherit>;mon=<assign|inherit>;group=<CTRL_MON>/<MON>/
+
+		"ctrl":
+			"assign" if kernel mode work uses the allocation
+			association of the resource group named by "group",
+			"inherit" if it uses the allocation association of
+			the user-space task. Present only on systems that
+			support allocation.
+		"mon":
+			"assign" if kernel mode work uses the monitoring
+			association of the resource group named by "group",
+			"inherit" if it uses the monitoring association of
+			the user-space task. Present only on systems that
+			support monitoring.
+		"group":
+			Path of the resource group, relative to the resctrl
+			mount point. A CTRL_MON group is shown as <CTRL_MON>//,
+			a MON group as <CTRL_MON>/<MON>/.
+
+		When the mode is not active, the parameters are the defaults
+		used if it is activated without new values.
+
+	Example of a system that supports allocation and monitoring, with
+	default mode inherit_user::
+
+	  # cat info/kernel_mode
+	  [inherit_user]
+	  global_enable_per_cpu:ctrl=assign;mon=assign;group=//
+
 Resource alloc and monitor groups
 =================================
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 75b81d07a247..e82709d64a00 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -993,6 +993,99 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/* Names used in info/kernel_mode; indexed by enum resctrl_kernel_mode */
+static const char * const resctrl_kmode_str[] = {
+	[RESCTRL_INHERIT_USER]		= "inherit_user",
+	[RESCTRL_GLOBAL_ENABLE_PER_CPU]	= "global_enable_per_cpu"
+};
+
+static_assert(ARRAY_SIZE(resctrl_kmode_str) == RESCTRL_NUM_KERNEL_MODES);
+
+static const char *resctrl_kmode_state_str(enum kmode_state state)
+{
+	return state == KMODE_ASSIGN ? "assign" : "inherit";
+}
+
+static void resctrl_kmode_group_path(struct rdtgroup *rdtgrp,
+				     const char **ctrl, const char **mon)
+{
+	*ctrl = "";
+	*mon = "";
+
+	if (rdtgrp->type == RDTMON_GROUP) {
+		*ctrl = rdt_kn_name(rdtgrp->mon.parent->kn);
+		*mon = rdt_kn_name(rdtgrp->kn);
+	} else {
+		*ctrl = rdt_kn_name(rdtgrp->kn);
+	}
+}
+
+/**
+ * resctrl_kernel_mode_show() - Display supported and active kernel modes
+ * @of:		kernfs open file
+ * @seq:	output seq_file
+ * @v:		unused
+ *
+ * Lists one line per mode and brackets the active mode. inherit_user
+ * has no parameters. global_enable_per_cpu prints ctrl= only when
+ * allocation is supported and mon= only when monitoring is supported,
+ * then group=.
+ *
+ * Return: 0 on success, or -ENOENT on error.
+ */
+static int resctrl_kernel_mode_show(struct kernfs_open_file *of,
+				    struct seq_file *seq, void *v)
+{
+	const char *ctrl_grp, *mon_grp;
+	enum resctrl_kernel_mode mode;
+	bool active;
+	char sep;
+
+	if (!info_kn_lock(of->kn))
+		return -ENOENT;
+
+	for (mode = 0; mode < RESCTRL_NUM_KERNEL_MODES; mode++) {
+		if (!test_bit(mode, resctrl_kmode.kmode_sup))
+			continue;
+
+		active = resctrl_kmode.kmode_cur == mode;
+
+		seq_printf(seq, active ? "[%s" : "%s", resctrl_kmode_str[mode]);
+
+		if (mode == RESCTRL_GLOBAL_ENABLE_PER_CPU) {
+			ctrl_grp = "";
+			mon_grp = "";
+			if (active) {
+				if (resctrl_kmode.rdtgrp)
+					resctrl_kmode_group_path(resctrl_kmode.rdtgrp,
+								 &ctrl_grp, &mon_grp);
+				else
+					pr_warn("%s active without a resource group\n",
+						resctrl_kmode_str[mode]);
+			}
+
+			sep = ':';
+			if (resctrl_arch_alloc_capable()) {
+				seq_printf(seq, "%cctrl=%s", sep,
+					   resctrl_kmode_state_str(resctrl_kmode.ctrl));
+				sep = ';';
+			}
+			if (resctrl_arch_mon_capable()) {
+				seq_printf(seq, "%cmon=%s", sep,
+					   resctrl_kmode_state_str(resctrl_kmode.mon));
+				sep = ';';
+			}
+			seq_printf(seq, "%cgroup=%s/%s/", sep, ctrl_grp, mon_grp);
+		}
+
+		seq_puts(seq, active ? "]\n" : "\n");
+	}
+
+	info_kn_unlock(of->kn);
+
+	return 0;
+}
+
 void *rdt_kn_parent_priv(struct kernfs_node *kn)
 {
 	/*
@@ -1978,6 +2071,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_last_cmd_status_show,
 		.fflags		= RFTYPE_TOP_INFO,
 	},
+	{
+		.name		= "kernel_mode",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= resctrl_kernel_mode_show,
+		.fflags		= RFTYPE_TOP_INFO,
+	},
 	{
 		.name		= "mbm_assign_on_mkdir",
 		.mode		= 0644,
-- 
2.43.0

