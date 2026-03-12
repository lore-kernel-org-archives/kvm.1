Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8551537DE88;
	Thu, 12 Mar 2026 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347965; cv=fail; b=FGvp7Lgzfiyg655oET4QOL8xIk0HkLWCexT/AF+gSdBcmkZ+bFt783SZEKxnbTcJFCoBFdhC2CjVYBJikX6IPc+7ZlsPZeXsB6PxfXGsVff6mDRal1Ci7BQavojT8C+F8JROBePmSAmYIsoe+9/EZ8PARy2pr0ShRPq3RuHXuh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347965; c=relaxed/simple;
	bh=yvtWXScegmXC80B4UzEVP2ppK7P6DlS4XTp4M2+ot/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5tDp7jFWhIeYQHxccGiLq4FDR65e5taPJfTBwgqeDMHNGn8WZDMRqmQsIu0BR5l2WCFWLG70Wi9tBrFu3F1uhuV+hsEdWkrNGXP412CyLMiHngbuU8ogZr3haFu7dFE5EeFZm0VAnX5Sy7ifG0hqhVlQOsFwSB5pCUKHx5Io2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DA6xeygb; arc=fail smtp.client-ip=40.93.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DA6xeygb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJvtppbGaHR7sgEgz0zguiwtM4vlh7+UXVkwXXZY5BEZsUal1DfVSWynM//eBd9bC7eUb/yR9mXeLhP5GPo+0j6PkgaO0WrSemZUzsTRpggR967Y2WOJ18Yex+nJxrH7Q96pXA0nsZOSeLjeRo5XjjRqZBdBCbcXjphYkYlno/eZf+j2S1aLqY/5Zs2cdgDkzkzHzbjhYoRaDbFCvBGl81cKoQH9hF1gvabTGE+zjdx+V7m8/lAWTmloCatsVQ0iKczIoqwLVTT9xD3vT3kMU4lJYtvAiiTz8wtlHl282upa4ZyGZjz7dLn+877c8ZfdtScJTKsxq6zttyOgH0Hzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHIY+UgSAwrUxNAT+DrY3bGGc18TjffqKt2fxTSKoWY=;
 b=KzAsRzt5dT+p4X2fGrdEIEy8WwURCY0nG1BNi/z0hc3rEgm08J7HSkElhtfaMNixs6+Ta3rbaSGoqVKO2OPobeGcQFiVnx3JSznqPbF6VPjqrJ96+BgQUYFprjEL2LeScz9Asl8DHFe3Q8ZBa9LcRo6iiJol/meDPJpi6WSHTUiWzt78nX7FWetc/ryhFkRN6sXk/x5YSFKHcSV+ofE8YZrT2F/wtFTI4mxJslxgxsopfbeELHWwgQiUWYPaZxRP71wKYo6fhXkqEFsYE/upGft6XYhO7RLCqxg0fOqkk2mGSoEN4z9eRw7LsS30vJTyvHQi0mtxvJj2WN54InK7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHIY+UgSAwrUxNAT+DrY3bGGc18TjffqKt2fxTSKoWY=;
 b=DA6xeygbaxAUIPJnLilMDnNgfbW03qA4mpahBFllvXzr/gcKR0K+ivCS8p8ZHPICyBPhAJhyFCDelLr8GxK7S9mxc25pWBMR9NTpJ494zRno1b3OQ5rsLyX/tp7Xvpk/9iKT1CGgclnvfFPEazBI7kBsooTuL+R3tYA39VpB+aE=
Received: from SJ0PR13CA0144.namprd13.prod.outlook.com (2603:10b6:a03:2c6::29)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 20:39:15 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::23) by SJ0PR13CA0144.outlook.office365.com
 (2603:10b6:a03:2c6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.8 via Frontend Transport; Thu,
 12 Mar 2026 20:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:39:14 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:39:12 -0500
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
Subject: [PATCH v2 14/16] fs/resctrl: Update kmode configuration when cpu_mask changes
Date: Thu, 12 Mar 2026 15:36:59 -0500
Message-ID: <0dc7a082a161c988bf75b125754e8461f4aef0ea.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: 69866f8a-8e4a-49b8-256e-08de80776cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6IE/ZclM/GbYqRdX3THE6UDJPvveJxioN5ZJjejRTdDX540/fgwAEHrM09qCUZ87Fnss1b64lxhpe1ZIGKH2MskHMN4ENEN/4Zz4dq+rlbF6eOyARckV9ZDphaoOuAQ0fmp5ita4mTTbG358GvaykBp9HKoeNGsNHPDh4iJQG2fWResQiEUW1hHDFexO+qhZuLPyRkX14xVpgU5QGRL5K1rz2i6uczBGGPZXXpixeja+AHrp6rb5yrD1uFEOijqsS8a+B8z222Knx0RZUao88ggKxcS7/6FtWUs5qLujwytp8A+kKkIf3OdBQu7+ZjrwdyZWVEEL1wtjcExOov4szN1QVP76l9Rb+KFgS2jf/GSod9q4DS7nJfscSgDsN1E2TynKZPqLWU46+wa2dHx8Qkveb7jMKP5e5k/oescb4sh4WeyVqcuGRUJpbYa7JqUcKwNDPGHA/1EiX7jYWODz15taCqyAs6uQCoT2GTkWyZTZTTvs+WCBA6OMd99Jn/Xp68z9LinZ6b/p2xzVMUPDuRto5/u9SObsW5z96lZRcrbpsiwB6Ox4bMVc6113gpX7h5T1M5Cp9E5GJfiW4+8Q4DX9diZbKI5ofjAnz5gTjBCJ7mDOG3s4MdHTujJQTwCbLASKHQnH6Iy43Fd+RYaeMhhcMyf2CYoHRFfz3weHIfshy2ua52R53H9lkYZFtEYwwnjr0lgnDMWvnY15ORO+C4mW43E0Sphjpwzm9ApmfFckd2LIk7okSrU8L5/iJxjoUBtl7hgGX94DphTVL7bIrw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qHY8uiShNPftDfa0CgjUfkNWjr3UQykeO2+C2rGjuFOsaelD79liKeJ+yRSfMFPblzSTn+viY2zrwdA/fhLkWPCpZaDYDsFjSQq8XnP9W5tzUuA50azQJkVKD9yWXZcQcfyxcePpHQSjLOLqJGlPYvCjjxPJZODdKbzEFg7IoiwEJaHRdVZg8K/ztrxlxPfSwR9vfY5yx+saHQrRq2OYo92gwAy/QgnQK+/6fVjuYCLO0zkc4bE9w4Vv0UTXClFpY1FDjn9VATVAnFcdTbhRkPJN7xFjvNYDAHaoXRHxt3z95TWK0UI0NjjCtJM3NQgg0IK60P1KloP6AglqPy9PImTnDeG/4UMARJDpcIQaSNGgetSBdnCQOR3f0hR0b0jIk3PXeC55XtrY+uNjbS+KodDE5GeE6TefZdCAeXwPkDv5evRNKu+cgIi1aVEmkb16
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:39:14.9425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69866f8a-8e4a-49b8-256e-08de80776cf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C

When kernel mode (e.g. PLZA) is active for a resctrl group, per-CPU
state must stay in sync with the group's cpu_mask. If the user
changes the cpus file, we must enable kmode on newly added CPUs and
disable it on CPUs that left the group.

Add cpus_write_kmode(), which calls cpus_ctrl_write_kmode() for
CTRL_MON groups and cpus_mon_write_kmode() for MON groups.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: Fixed few typos in commit message.
    Added separate functions to handle kmode configuration for CTRL_MON and MON groups.
---
 fs/resctrl/rdtgroup.c | 149 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 1 deletion(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 23e610d59111..31479893633a 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -456,6 +456,150 @@ static void cpumask_rdtgrp_clear(struct rdtgroup *r, struct cpumask *m)
 		cpumask_and(&crgrp->cpu_mask, &r->cpu_mask, &crgrp->cpu_mask);
 }
 
+/**
+ * cpus_mon_write_kmode() - Update per-CPU kmode when a MON group's cpu_mask changes
+ * @rdtgrp:	The MON group whose cpu_mask is being updated.
+ * @newmask:	The new CPU mask requested by the user.
+ * @tmpmask:	Temporary mask for computing CPU set differences.
+ *
+ * When CPUs are dropped from the group, disables kmode on those CPUs and
+ * returns them to the parent. When CPUs are added, removes them from sibling
+ * MON groups and enables kmode on them. Caller must hold rdtgroup_mutex.
+ *
+ * Return: 0 on success, or -EINVAL if newmask contains CPUs outside the parent.
+ */
+static int cpus_mon_write_kmode(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
+				cpumask_var_t tmpmask)
+{
+	struct rdtgroup *prgrp = rdtgrp->mon.parent, *crgrp;
+	struct list_head *head;
+
+	/* Check whether cpus belong to parent ctrl group */
+	cpumask_andnot(tmpmask, newmask, &prgrp->cpu_mask);
+	if (!cpumask_empty(tmpmask)) {
+		rdt_last_cmd_puts("Can only add CPUs to mongroup that belong to parent\n");
+		return -EINVAL;
+	}
+
+	/* Check whether cpus are dropped from this group */
+	cpumask_andnot(tmpmask, &rdtgrp->cpu_mask, newmask);
+	if (!cpumask_empty(tmpmask)) {
+		/* Give any dropped cpus to parent rdtgroup */
+		cpumask_or(&prgrp->cpu_mask, &prgrp->cpu_mask, tmpmask);
+
+		/* Disable kmode on the dropped CPUs */
+		resctrl_arch_set_kmode(tmpmask, &resctrl_kcfg, prgrp->closid,
+				       rdtgrp->mon.rmid, false);
+	}
+
+	/*
+	 * If we added cpus, remove them from previous group that owned them
+	 * and enable kmode on added CPUs.
+	 */
+	cpumask_andnot(tmpmask, newmask, &rdtgrp->cpu_mask);
+	if (!cpumask_empty(tmpmask)) {
+		head = &prgrp->mon.crdtgrp_list;
+		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
+			if (crgrp == rdtgrp)
+				continue;
+			cpumask_andnot(&crgrp->cpu_mask, &crgrp->cpu_mask, tmpmask);
+		}
+		resctrl_arch_set_kmode(tmpmask, &resctrl_kcfg, prgrp->closid,
+				       rdtgrp->mon.rmid, true);
+	}
+
+	/* Done pushing/pulling - update this group with new mask */
+	cpumask_copy(&rdtgrp->cpu_mask, newmask);
+
+	return 0;
+}
+
+/**
+ * cpus_ctrl_write_kmode() - Update per-CPU kmode when a CTRL group's cpu_mask changes
+ * @rdtgrp:	The CTRL_MON group whose cpu_mask is being updated.
+ * @newmask:	The new CPU mask requested by the user.
+ * @tmpmask:	Temporary mask for computing CPU set differences.
+ * @tmpmask1:	Second temporary mask (e.g. for cpumask_rdtgrp_clear).
+ *
+ * When CPUs are dropped from the group, disables kmode on those CPUs (cannot
+ * drop from default group). When CPUs are added, clears them from child groups
+ * that owned them and enables kmode on them. Updates this group's cpu_mask and
+ * intersects child MON group masks with the new parent mask. Caller must hold
+ * rdtgroup_mutex.
+ *
+ * Return: 0 on success, or -EINVAL if dropping CPUs from the default group.
+ */
+static int cpus_ctrl_write_kmode(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
+				 cpumask_var_t tmpmask, cpumask_var_t tmpmask1)
+{
+	struct rdtgroup *crgrp;
+	struct list_head *head;
+
+	/* Check whether cpus are dropped from this group */
+	cpumask_andnot(tmpmask, &rdtgrp->cpu_mask, newmask);
+	if (!cpumask_empty(tmpmask)) {
+		/* Can't drop from default group */
+		if (rdtgrp == &rdtgroup_default) {
+			rdt_last_cmd_puts("Can't drop CPUs from default group\n");
+			return -EINVAL;
+		}
+		/* Disable kmode on the dropped CPUs */
+		resctrl_arch_set_kmode(tmpmask, &resctrl_kcfg, rdtgrp->closid,
+				       rdtgrp->mon.rmid, false);
+	}
+
+	/*
+	 * If we added cpus, remove them from child groups that owned them
+	 * previously.
+	 */
+	cpumask_andnot(tmpmask, newmask, &rdtgrp->cpu_mask);
+	if (!cpumask_empty(tmpmask)) {
+		cpumask_rdtgrp_clear(rdtgrp, tmpmask1);
+		/* Enable kmode on the added CPUs */
+		resctrl_arch_set_kmode(tmpmask, &resctrl_kcfg, rdtgrp->closid,
+				       rdtgrp->mon.rmid, true);
+	}
+
+	/* Done pushing/pulling - update this group with new mask */
+	cpumask_copy(&rdtgrp->cpu_mask, newmask);
+
+	/* Clear child mon group masks since there is a new parent mask now */
+	head = &rdtgrp->mon.crdtgrp_list;
+	list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
+		cpumask_and(tmpmask, &rdtgrp->cpu_mask, &crgrp->cpu_mask);
+	}
+
+	return 0;
+}
+
+/**
+ * cpus_write_kmode() - Update per-CPU kmode for a group's new cpu_mask
+ * @rdtgrp:	The group (CTRL_MON or MON) whose cpu_mask is being updated.
+ * @newmask:	The new CPU mask requested by the user.
+ * @tmpmask:	Temporary mask for computing CPU set differences.
+ * @tmpmask1:	Second temporary mask (only used for CTRL_MON groups).
+ *
+ * Dispatches to cpus_ctrl_write_kmode() or cpus_mon_write_kmode() based on
+ * group type. Used when the group has kmode enabled and the user writes to
+ * the cpus file.
+ *
+ * Return: 0 on success, or -EINVAL on error.
+ */
+static int cpus_write_kmode(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
+			    cpumask_var_t tmpmask, cpumask_var_t tmpmask1)
+{
+	int ret;
+
+	if (rdtgrp->type == RDTCTRL_GROUP)
+		ret = cpus_ctrl_write_kmode(rdtgrp, newmask, tmpmask, tmpmask1);
+	else if (rdtgrp->type == RDTMON_GROUP)
+		ret = cpus_mon_write_kmode(rdtgrp, newmask, tmpmask);
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+
 static int cpus_ctrl_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
 			   cpumask_var_t tmpmask, cpumask_var_t tmpmask1)
 {
@@ -566,7 +710,10 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
 		goto unlock;
 	}
 
-	if (rdtgrp->type == RDTCTRL_GROUP)
+	/* Group has kernel mode: update per-CPU kmode state for new mask. */
+	if (rdtgrp->kmode)
+		ret = cpus_write_kmode(rdtgrp, newmask, tmpmask, tmpmask1);
+	else if (rdtgrp->type == RDTCTRL_GROUP)
 		ret = cpus_ctrl_write(rdtgrp, newmask, tmpmask, tmpmask1);
 	else if (rdtgrp->type == RDTMON_GROUP)
 		ret = cpus_mon_write(rdtgrp, newmask, tmpmask);
-- 
2.43.0

