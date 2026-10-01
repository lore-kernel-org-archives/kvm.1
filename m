Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE9B5221D4;
	Thu,  1 Oct 2026 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867644; cv=fail; b=H4Fql3i75hKGg1tVC4GgVfBewu6uaJ9Oa9dAKGYFJpua75YL8xzXP8H5b7hD9c2O4WGi8c2z0bABEWQLJRmzvmAVjpjnRWgymNc4XDxRMtjaeZ1elbK8JLMW4pru/DqwQGnoXr8oQTCJUgrXDJP0Sk6Dwio+UfSrKNybJ0nm4Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867644; c=relaxed/simple;
	bh=fqPIepnGbm2bs4DWgLiH9+T1Ba2j6NXqy++5Z0mnCV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjC84RcpTSGyYAqShTg6ORwmncgxt0fsa7xxs6WI1eR37qJGY2InF0/a5CrhdAtyLOzC/cTttLP6nXMeobmFII/JznKCCokQknOErpOajaySTZoz4715ke1AhVIWoqEyiXgdcTqloy4o9+RJrLE4TK0M6RIjbbss7DXSAJf0Dmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mKGIP0CO; arc=fail smtp.client-ip=52.101.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mKGIP0CO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BifF66+hc1b7NshzGY8zF4uSj5JLI1iMGBit5Tj2kSBIDcmckGBVlBBrZjB+4c9E9KS7OE35R2pPB6pu5R8nyf5zll3xNrZ1/yG/idyexRaUl2Wl63wZPxd6UeeFNVffzmY5hf35T3VKyXGT55CY5rEdLRNv9+uICwTVTFY+/JYXYYdaPOwODajjDuco62RawgRX+xb9zpYZZMAGp/TaR1y8MwA8spy+iyorRP7tZDIwZZd/4hO0S/nMs64t2YmRV3OQ+qNJepaKOyCe61eVDDOV9otCNYkr78IpXUmJ3B1TctQklJf6j0emT0cOQ+M3XRSHjYShLl5X4mXpVgR6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aaqb4SCkBsFl2GSGl1HoOgcKwL1vvkImXxWgFhJ5nso=;
 b=nnMuRu2i8c2WXWGapHXOg6ES3XtwhHLVIhwVSLCZPZlsHfGdouum3N0ROt2GD8qf+sR1RQoR0ddU9eZXL9//VerdXkYE2C79gmdNSjCfWqmm++tAHuEnKDLQ6ZLGMxhuVYmeSQcSx/xdHwYgOpMgLyhmgeKS8gvD/UVJk3faBaO4kMI+eyA+MMMN34gQ5PCuj6pFiOfuWcAiDZ0pkO0NRYAuot/u5mgqqMwa4wVnZQhDBc2ZwkLGW576HiO6GanrPYrt8eyea3V8deZFTCElo8OcUI5WXIW+Uli2gORL6IpDtpToxLKNDQjwIpC7z5K3twEynCHtXlbMz4WsEZis7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aaqb4SCkBsFl2GSGl1HoOgcKwL1vvkImXxWgFhJ5nso=;
 b=mKGIP0COgmVXNBhU1tuFxRPKKsSjDB9i83s/Vw9UUnFaeItV1OIb/uuW2RTOZpn3csHR5fufGFOCIBVCUYdfD1NgRt9EgRYiGiVKdnu51h056ao5SeLcbtPOy4XYpFVhHobkybreyt1iesd3xh3tZ0zb/Zmam4ENOVdCWyhdsAA=
Received: from BN0PR08CA0001.namprd08.prod.outlook.com (2603:10b6:408:142::6)
 by LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 15:13:15 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::15) by BN0PR08CA0001.outlook.office365.com
 (2603:10b6:408:142::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:13:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:13:15 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:13:12 -0500
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
Subject: [PATCH v6 16/18] fs/resctrl: Add interface to modify kernel mode via info/kernel_mode
Date: Thu, 1 Oct 2026 10:10:39 -0500
Message-ID: <e22be68142d869873532f21e42f049414e1cff99.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|LV3PR12MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: 27cd0cee-908d-4dbf-a13f-08df1fce8431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|7416014|376014|10067099003|5023799004|11063799006|56012099006|3023799007|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	48b+HbR37lFl1lxnrlhnXYb7YowrTLmjJEUAzKVzEzHNHv4lA/NdtWNL07UXWB3KS5m9scgnAw7a6yduKSqs9luGaLZusFj2elhT4VO/a7QiVCzAN1qV1x7iN9dV0IFJ6NJ2Q480P7VkkPMc9zf/3ys9uk2po0mzvGa9Rdsj9/VgVVzIphsnqq01CzOPYuRMzJUHEFp+7Q+5wgF+f93iJME71C4k0QDXFCWs9L1RLqkWxbyhiph6AziNa9ou7nic3IpOBLHnwUQcteyJ+mgYVkzKYd2u/WMBSF7QcQ72lqldrnYVSiH5kzr3xGm5WBRSxvGrpc+4QzIoTqDHHVoJ/urTtNCWMOBzrSyAc3wQhpVyQkdUcfnrZCAEaq4JXI9UwNoN4HEH0aYDA0irnV8ed5VRYo5TkZPqY2gi6Nqt+5OjbdDYfEjjltuo3yV5agheTvmG9ysWRXiWSX71afOr3X+tVGajNMcW5AAiIVij54geU/E3nZN5k9LV9JvTPm03Lr3ykdpd27WPKTOJiGWrRu6BfKz+WMQA7NnpoWxCX1x3JUqm/h0cy+mVruGfgxRvVxNQc16MOmRfUtWvv1DAAvMu8ocHF5MB2/JCx7LM6hTUSUjzBmK2DmG4g2lFUcXUzg7LDb1QpHbvkTts5uox6BkpYNKG+0Btt4u4I33q8He04PwOUgBXcQ33cmLn5QdHgO5h0kSUahv9MzPoeE2YmA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(7416014)(376014)(10067099003)(5023799004)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U/Nhd71hi1QE0P+Osv8q8W2wE3A/GGXoFeetRSl3VlYeX/BeCQ93q9MoIKPUCbzmkWlLA9WtN6q7VPJRvJ4f4fFuYPnt0fz9s1oMPccbAv4R0yLG43HFvE9AAwkwdQv27hA5wtpNu7eTCMos3kj9ZlKquIkv0fsnpByVwBClXtyKx2T40glKs6ptfEQwLzyQCK2OWldQb3xZJCggMXJACui7En4cZrOnj6kINYTOhCnwGbJuz+zm9gNwBLCUoPzAcb8Ex+AeqbbMm11c4h/PjoR7vrStcV9EUkKJPSPZk+81hRccB1ftA+hJGGAE8UwopZMAtRcH1xpm2Q0+ORjoOTsdJi+fhJ1HoOvPtd9LJmbJ/0px+rbB5KmDdHd2MD3dgETgGltxcudAu6hNEMOUuCp09HUtU+lsJ85UnpEeNTa6Oolz+iBNa6yEse4yMfgk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:13:15.1016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cd0cee-908d-4dbf-a13f-08df1fce8431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267

Kernel modes determine how resctrl allocation and monitoring associations
are applied when execution transitions between user mode and kernel mode.

Add write support to info/kernel_mode to allow user space to configure the
active kernel mode and any required resource group associations.

Document the interface in Documentation/filesystems/resctrl.rst.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Use flattened resctrl_kmode and global_enable_per_cpu. Omitted
    parameters keep the values shown by reading the file. Drop the
    ctrl=inherit;mon=inherit no-op. Parse options with strsep(), as the
    other resctrl writers do, and split validation out of the write path.
    https://lore.kernel.org/lkml/3bc39dd7-b7b0-4203-a493-0bd872fdc644@intel.com/

v5: Adapt to the resctrl_kcfg caps and active split. Accept
    assign_global_enable_per_cpu:ctrl=;mon=;group=<ctrl>/<mon>/ writes.
    Treat both ctrl=inherit and mon=inherit as a no-op. Use group=// for
    the default control group. Show associated kmode files through
    resctrl_hidden_files_set_visible().
    Added kmode check in rdtgroup_locksetup_enter(), rdtgroup_mode_write()
    and rdtgroup_rename().
    Simplify kernel-doc for write and activate helpers.

v4: Validate input before tearing down the active association so failures
    retain the previous association. Allow assign_mon on CTRL_MON and MON
    groups; require a control group when control assignment is inherit.

v3: New patch to make info/kernel_mode writable.
---
 Documentation/filesystems/resctrl.rst |  28 +++
 fs/resctrl/rdtgroup.c                 | 274 +++++++++++++++++++++++++-
 2 files changed, 301 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 73ccbb9594f5..bf9d34d6a335 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -575,6 +575,34 @@ conveyed in the error returns from file operations. E.g.
 	  [inherit_user]
 	  global_enable_per_cpu:ctrl=assign;mon=assign;group=//
 
+	Writes use the same line format as read, without square brackets and
+	with a trailing newline.
+
+	inherit_user is written without any parameters.
+
+	For global_enable_per_cpu, the parameters are optional. An omitted
+	ctrl=, mon=, or group= keeps the value currently shown. Parameters
+	may appear in any order. Empty values are rejected.
+
+	Selecting a new mode, parameter, or group replaces the active
+	association. A new global_enable_per_cpu association sets that
+	group's kmode_cpus to every online CPU. Errors are reported in
+	"info/last_cmd_status".
+	Example::
+
+	  # mkdir ctrl1
+	  # echo "global_enable_per_cpu:ctrl=assign;mon=assign;group=ctrl1//" \
+	         > info/kernel_mode
+
+	  # cat info/kernel_mode
+	  inherit_user
+	  [global_enable_per_cpu:ctrl=assign;mon=assign;group=ctrl1//]
+
+	  # echo "inherit_user" > info/kernel_mode
+	  # cat info/kernel_mode
+	  [inherit_user]
+	  global_enable_per_cpu:ctrl=assign;mon=assign;group=//
+
 Resource alloc and monitor groups
 =================================
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index dcf9f26540d6..73749e5a4ad0 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1216,6 +1216,277 @@ static void rdtgroup_kmode_global_detach(struct rdtgroup *rdtgrp)
 	resctrl_kmode.mon = KMODE_ASSIGN;
 }
 
+/* Program @rdtgrp on every online CPU and show its kmode_cpus files. */
+static void rdtgroup_kmode_global_activate(struct rdtgroup *rdtgrp)
+{
+	cpumask_copy(&rdtgrp->kmode_cpu_mask, cpu_online_mask);
+	resctrl_configure_kmode_global(&rdtgrp->kmode_cpu_mask, rdtgrp, true);
+	resctrl_kmode_global_files_show(rdtgrp->kn, true);
+}
+
+/**
+ * rdtgroup_by_kmode_path() - Resolve a "<ctrl>/<mon>/" path to an rdtgroup
+ * @ctrl_name:	CTRL_MON group name, or "" for the default control group.
+ * @mon_name:	MON group name, or "" to select the control group itself.
+ *
+ * Matches the path syntax displayed by resctrl_kernel_mode_show():
+ *   "//"            - the default CTRL_MON group
+ *   "<ctrl>//"      - CTRL_MON group @ctrl_name
+ *   "/<mon>/"       - MON group @mon_name under the default control group
+ *   "<ctrl>/<mon>/" - MON group @mon_name under control group @ctrl_name
+ *
+ * Return: Pointer to the matching rdtgroup, or NULL if no such group exists.
+ */
+static struct rdtgroup *rdtgroup_by_kmode_path(const char *ctrl_name,
+					       const char *mon_name)
+{
+	struct rdtgroup *rdtg, *parent = &rdtgroup_default;
+
+	if (*ctrl_name) {
+		parent = NULL;
+		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
+			if (rdtg->type != RDTCTRL_GROUP)
+				continue;
+			if (!strcmp(rdt_kn_name(rdtg->kn), ctrl_name)) {
+				parent = rdtg;
+				break;
+			}
+		}
+	}
+	if (!parent)
+		return NULL;
+
+	if (!*mon_name)
+		return parent;
+
+	list_for_each_entry(rdtg, &parent->mon.crdtgrp_list, mon.crdtgrp_list)
+		if (!strcmp(rdt_kn_name(rdtg->kn), mon_name))
+			return rdtg;
+	return NULL;
+}
+
+static int resctrl_kmode_parse_state(char *val, enum kmode_state *state)
+{
+	if (!strcmp(val, "assign")) {
+		*state = KMODE_ASSIGN;
+		return 0;
+	}
+	if (!strcmp(val, "inherit")) {
+		*state = KMODE_INHERIT;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int resctrl_kmode_parse_group(char *group, struct rdtgroup **rdtgrp)
+{
+	struct rdtgroup *grp;
+	char *mon, *slash;
+
+	slash = strchr(group, '/');
+	if (!slash) {
+		rdt_last_cmd_puts("Group must be <CTRL_MON>/<MON>/\n");
+		return -EINVAL;
+	}
+	*slash = '\0';
+	mon = strim(slash + 1);
+
+	slash = strchr(mon, '/');
+	if (!slash || slash[1] != '\0') {
+		rdt_last_cmd_puts("Group must be <CTRL_MON>/<MON>/\n");
+		return -EINVAL;
+	}
+	*slash = '\0';
+
+	grp = rdtgroup_by_kmode_path(group, mon);
+	if (!grp) {
+		rdt_last_cmd_puts("Group not found\n");
+		return -EINVAL;
+	}
+	*rdtgrp = grp;
+	return 0;
+}
+
+static int resctrl_kmode_parse_parameters(char *params, enum kmode_state *ctrl,
+					  enum kmode_state *mon,
+					  struct rdtgroup **rdtgrp)
+{
+	char *key, *tok;
+
+	while ((tok = strsep(&params, ";"))) {
+		tok = strim(tok);
+		if (!*tok)
+			continue;
+
+		key = strsep(&tok, "=");
+		if (!tok) {
+			rdt_last_cmd_puts("Empty kernel mode parameters\n");
+			return -EINVAL;
+		}
+		key = strim(key);
+		tok = strim(tok);
+		if (!*key || !*tok) {
+			rdt_last_cmd_puts("Empty kernel mode parameters\n");
+			return -EINVAL;
+		}
+
+		if (!strcmp(key, "ctrl")) {
+			if (resctrl_kmode_parse_state(tok, ctrl)) {
+				rdt_last_cmd_puts("Invalid ctrl= parameter\n");
+				return -EINVAL;
+			}
+		} else if (!strcmp(key, "mon")) {
+			if (resctrl_kmode_parse_state(tok, mon)) {
+				rdt_last_cmd_puts("Invalid mon= parameter\n");
+				return -EINVAL;
+			}
+		} else if (!strcmp(key, "group")) {
+			if (resctrl_kmode_parse_group(tok, rdtgrp))
+				return -EINVAL;
+		} else {
+			rdt_last_cmd_puts("Unknown kernel mode parameter\n");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static int resctrl_kmode_global_validate(struct rdtgroup *rdtgrp,
+					 enum kmode_state ctrl,
+					 enum kmode_state mon)
+{
+	if (ctrl == KMODE_ASSIGN && !resctrl_arch_alloc_capable()) {
+		rdt_last_cmd_puts("ctrl=assign is not supported\n");
+		return -EINVAL;
+	}
+	if (mon == KMODE_ASSIGN && !resctrl_arch_mon_capable()) {
+		rdt_last_cmd_puts("mon=assign is not supported\n");
+		return -EINVAL;
+	}
+	if (mon == KMODE_INHERIT && rdtgrp->type == RDTMON_GROUP) {
+		rdt_last_cmd_puts("A monitor group requires mon=assign to use its RMID\n");
+		return -EINVAL;
+	}
+	if (rdtgrp->mode != RDT_MODE_SHAREABLE) {
+		rdt_last_cmd_puts("The group is not in shareable mode\n");
+		return -EINVAL;
+	}
+	if (rdtgrp->type == RDTMON_GROUP &&
+	    rdtgrp->mon.parent->mode != RDT_MODE_SHAREABLE) {
+		rdt_last_cmd_puts("The parent group is not in shareable mode\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void resctrl_kmode_switch(enum resctrl_kernel_mode mode,
+				 struct rdtgroup *rdtgrp,
+				 enum kmode_state ctrl, enum kmode_state mon)
+{
+	if (resctrl_kmode.rdtgrp)
+		rdtgroup_kmode_global_deactivate(resctrl_kmode.rdtgrp);
+
+	resctrl_kmode.kmode_cur = mode;
+	if (mode != RESCTRL_GLOBAL_ENABLE_PER_CPU) {
+		resctrl_kmode.rdtgrp = NULL;
+		resctrl_kmode.ctrl = KMODE_ASSIGN;
+		resctrl_kmode.mon = KMODE_ASSIGN;
+		return;
+	}
+
+	resctrl_kmode.ctrl = ctrl;
+	resctrl_kmode.mon = mon;
+	resctrl_kmode.rdtgrp = rdtgrp;
+	rdtgroup_kmode_global_activate(rdtgrp);
+}
+
+/**
+ * resctrl_kernel_mode_write() - Set the active kernel mode
+ * @of:		kernfs open file
+ * @buf:	write buffer
+ * @nbytes:	length of @buf
+ * @off:	unused
+ *
+ * Return: @nbytes on success, negative errno on error.
+ */
+static ssize_t resctrl_kernel_mode_write(struct kernfs_open_file *of,
+					 char *buf, size_t nbytes, loff_t off)
+{
+	struct rdtgroup *rdtgrp = &rdtgroup_default;
+	enum resctrl_kernel_mode mode;
+	enum kmode_state ctrl, mon;
+	char *params;
+	int ret = 0;
+
+	if (!info_kn_lock(of->kn))
+		return -ENOENT;
+
+	rdt_last_cmd_clear();
+
+	if (nbytes == 0 || buf[nbytes - 1] != '\n') {
+		rdt_last_cmd_puts("kernel_mode: Invalid input\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	buf[nbytes - 1] = '\0';
+	buf = strim(buf);
+
+	params = strchr(buf, ':');
+	if (params)
+		*params++ = '\0';
+
+	for (mode = 0; mode < RESCTRL_NUM_KERNEL_MODES; mode++) {
+		if (!strcmp(buf, resctrl_kmode_str[mode]))
+			break;
+	}
+	if (mode == RESCTRL_NUM_KERNEL_MODES) {
+		rdt_last_cmd_puts("Unknown kernel mode\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	if (!test_bit(mode, resctrl_kmode.kmode_sup)) {
+		rdt_last_cmd_puts("Kernel mode not available\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (mode == RESCTRL_INHERIT_USER) {
+		if (params) {
+			rdt_last_cmd_puts("inherit_user has no parameters\n");
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+		if (resctrl_kmode.kmode_cur != mode)
+			resctrl_kmode_switch(mode, NULL, KMODE_ASSIGN, KMODE_ASSIGN);
+		goto out_unlock;
+	}
+
+	/* Omitted parameters keep the values shown by reading the file. */
+	ctrl = resctrl_arch_alloc_capable() ? resctrl_kmode.ctrl : KMODE_INHERIT;
+	mon = resctrl_arch_mon_capable() ? resctrl_kmode.mon : KMODE_INHERIT;
+	if (resctrl_kmode.rdtgrp)
+		rdtgrp = resctrl_kmode.rdtgrp;
+
+	if (params) {
+		ret = resctrl_kmode_parse_parameters(params, &ctrl, &mon, &rdtgrp);
+		if (ret)
+			goto out_unlock;
+	}
+
+	ret = resctrl_kmode_global_validate(rdtgrp, ctrl, mon);
+	if (ret)
+		goto out_unlock;
+
+	if (resctrl_kmode.kmode_cur != mode || resctrl_kmode.rdtgrp != rdtgrp ||
+	    resctrl_kmode.ctrl != ctrl || resctrl_kmode.mon != mon)
+		resctrl_kmode_switch(mode, rdtgrp, ctrl, mon);
+
+out_unlock:
+	info_kn_unlock(of->kn);
+	return ret ?: nbytes;
+}
+
 void *rdt_kn_parent_priv(struct kernfs_node *kn)
 {
 	/*
@@ -2230,9 +2501,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "kernel_mode",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= resctrl_kernel_mode_show,
+		.write		= resctrl_kernel_mode_write,
 		.fflags		= RFTYPE_TOP_INFO,
 	},
 	{
-- 
2.43.0

