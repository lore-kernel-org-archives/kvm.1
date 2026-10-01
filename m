Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4C497385;
	Thu,  1 Oct 2026 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867592; cv=fail; b=d80XeTLYYZgozxeHvBAp2y8lh0hrL6fxbncjqrgY6ua+fRojUrYogimC5Xu+uG/Ye0YF8oVlE+NnfkUOscne2OZeEpaasVZvFrvJ98hZr0f6WQ/Mm+NCRsyxTro+Xgo1veu2dK1EOjjvux8TGbhv8hrBaKhkKaVKx2Ukr56zFAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867592; c=relaxed/simple;
	bh=q15j1XDzx14aDt+dzXExuPTINbIPUiVsSLKb4m4z0V8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucdyRRWyGZe2MMrF1BISeLv5VIZcdMVXohE+kLSW4eYEr68NPGzipEZym02gNURt/MCfoQPwFWWxTeUnQlkqmOxkI1WAYAK8xAt66R+Gf2rc99HMQtpB/yyu/L8Pra3p6Hn+V2JSZRpTnhf178zmnvOur+wL+plIEd+H8u4xHAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aHLCpcYd; arc=fail smtp.client-ip=52.101.62.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aHLCpcYd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEvcWO7pLeaGpDbslSZcitD46z6tzD26O8W3G7KhL06KG63vrzzTJ8WOGmaHIR8XL0ksAUaXzagEoF9CTVVlolXaD5DgrppQJf26UNrOJBh6icUH/HdeYrKIK9LJSA4Nb4EHrtJCtpYPD0oabw8JWtZKOHtmFxCuCj8XSnBHX36wTqo0meFdiXsliaZLMs+EBB2xuzFxw5rj7yCOfz9HZyi+TPRPq1MQWWQVCZ49LiFqZYD+YlvBnclxyZr401zm7mJIeuHTn98F3tTBKZ5xlsKi8nlnYBFDilBllqBXdYaQMblW+DKB6IhX7JOzx7U88QOyrTFOXNKk+8l2N3lcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBeiacZSFSik7wGLvnHHrDcNd1AHv5HWIOoEVPL1AE4=;
 b=RnjVWLLPtMUqo38S7IAadWJF4WpauYnyurnbXp17or2iw90vXjiVCUiBr85O3ANpu2D8lxUWIir8g9b7LFuM/PG5xlKD69Sja6inMgJaI2EbYovXG3ztsNGLwiWymxijTZKZAVww9+7XJh4UunhoQZF98DouN9o2KLxJX5Lqf8qW4pQZdyvfUgFzlxtwTXeGTXrw8tLdHE3E8U7lVXEdNTYRRkFobHC46tVHnO9vqFU2+0UN/dyZu+TV4nk0r+rMZjm73CpTM5/Vs/OF5PCA3UlX7uKLG/5HSknxyyaO5Tuo/gDUTQikyn+rNq4QJe8zjqbk4kDw6jNESG8d9KAKOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBeiacZSFSik7wGLvnHHrDcNd1AHv5HWIOoEVPL1AE4=;
 b=aHLCpcYdTFMNMjY5Qu+zcsiS+VJdWk4pT8sIrdDGsSl6OeuILXf7xwpVO2qn3TI9g7y3yJ3kfQg5w71tLuFtTiuwzF84j3n3p1rp0CCn9Hxoe1l2PBuhN1Ma+JqALApvgGmCS0repJRoVJ5JEnlkq/E990IhmK6d3LqfKGxtkZI=
Received: from BN0PR08CA0008.namprd08.prod.outlook.com (2603:10b6:408:142::30)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 15:12:46 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::56) by BN0PR08CA0008.outlook.office365.com
 (2603:10b6:408:142::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:12:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:12:46 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:12:43 -0500
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
Subject: [PATCH v6 13/18] fs/resctrl: Deactivate kernel mode associations when a group is removed
Date: Thu, 1 Oct 2026 10:10:36 -0500
Message-ID: <e9a2b05b2322acf51e16571d07bc7ee297613b3c.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: c60d77a9-94e0-45ee-20e6-08df1fce7313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|23010399003|260925021911599003|10067099003|260925021311599003|260925022911599003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bQpvgOshNyuVKoSpKkC3R9AXq5/7knmxGVoJIxM7z4PVxc947DFkWWAPfEVHy3FPnzTngZ7qvDJiYPIlXtSUOrpdB0sj2elzqzspaFnv4ftZ7/HaNSPb7P1q6fWrX/VesNdzF/SpZ0MeXxTfL9TVW7FsMneMHOGXqRyux0LgSss5N6WnaAJzAzEmD/XGVpArrZFHWWoQgTQWQgBxGtZ+Ip3MQisf49kHtHumbQg4eounmEomC7KUdXvw4CZoltoVjT26wzZpjvFFoTr7WlNiZiyRLoS/oWdXs/89x96h5mnHlJwKJ6Xm5AtmlnWPr19bAa+7+uyVb/ZHYuHv21K009R5M3RAytid4JXIi7kQgkeaf8neSiaMKj93zwZCGGavA6qQbJWvW5sJBqrmAhC7FQQsPjEC9wurlJB61q6Np2VC3KhNRM9uKOUnii7b1fYrUPBRXiiU60YDxVtpmzYMdlmRDOikiuHiIUCll6ZfEyWRsfoiCstHeLyiFvXg4h+WUwwU+GAP77bWgIp0DLQ2QI4CxPhJ7zJiyIN79XBLdNTIHa0MeASTz/LTn17SBHbVMN1S3NA6nljEwA6Ra3amHa2YtNqMMGlfaw/sSZFuCvscWRU+DzDI7D8sgqZctE0YXz8v9KFnUd2Eq+zNQl7hvw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(23010399003)(260925021911599003)(10067099003)(260925021311599003)(260925022911599003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1u4bzwptnTF5Mo7sZL6D31Jb6DkNHP9q3MBN1UGak5xU6YC+XEuc4hYaKSb6qInzTLex7DIjhc3TTTSV5AvVGQ2obu2aFb1fnSpoBMgUp9cNvbIiu5mGOQw065UN9XLaiaNiTRYOezJmKvZ3h6y8uIczi5gquQtU2CTwOCRU/l2oHvKBYTS1T/1QwDK+EJIeefWF4xos6zOwctA1aq/RuXIcsa0QqZCI4cKDFHBYROgUmKImQbDhhc8FK6GBrQYn/n49CrX/tYSi/SxrPVmYMgGsvLfGGwTCAOfH3NZfSBpuum0jefVLr8iGGycY70llEN4/NLSaNbXg+AipxTCYNYmYy0t2WzCeRSfN644CJr3y9deHu+YkwZe1rNoHBtoKZ2X9Y1M4v8yxs447ezgLM094HvlrFlqZ4bBfUMFQlepUwiihY68gtPNprFpHpLs1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:12:46.3802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c60d77a9-94e0-45ee-20e6-08df1fce7313
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259

The active kernel mode association is backed by either a CTRL_MON or
MON group.

When the backing group is removed, or when resctrl is unmounted, clear
the programmed association and restore the default settings.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Rewrite changelog (not a bugfix).
    Shorten the code comments.

v5: Took care of couple of Sashiko comments on previous patch.
    https://sashiko.dev/#/patchset/cover.1783461016.git.babu.moger@amd.com?part=10
    Re-wrote the changelog.
    Renamed rdtgroup_config_kmode_reset() to rdtgroup_kmode_deactivate().

v4: Re-wrote the changelog.
    Added the call free_all_child_rdtgrp() and rmdir_all_sub()
    Simplified the code comments.

v3: New patch to handle the kernel_mode clean up.
---
 fs/resctrl/rdtgroup.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index f5c7790f7970..0cdc868a55b1 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1167,6 +1167,36 @@ static void resctrl_kmode_global_offline_cpu(unsigned int cpu)
 	resctrl_configure_kmode_global(cpumask_of(cpu), rdtgrp, false);
 }
 
+/*
+ * Disable the association on @rdtgrp's kmode_cpu_mask, clear the mask, and
+ * hide the group's kmode_cpus files.
+ */
+static void rdtgroup_kmode_global_deactivate(struct rdtgroup *rdtgrp)
+{
+	resctrl_configure_kmode_global(&rdtgrp->kmode_cpu_mask, rdtgrp, false);
+	cpumask_clear(&rdtgrp->kmode_cpu_mask);
+}
+
+/*
+ * rdtgroup_kmode_global_detach() - Detach @rdtgrp from the global per-CPU mode
+ * @rdtgrp: Resctrl group being removed or torn down.
+ *
+ * If @rdtgrp backs the active association, disable it, clear kernel mode
+ * state, and restore RESCTRL_INHERIT_USER.
+ */
+static void rdtgroup_kmode_global_detach(struct rdtgroup *rdtgrp)
+{
+	if (resctrl_kmode.rdtgrp != rdtgrp)
+		return;
+
+	rdtgroup_kmode_global_deactivate(rdtgrp);
+
+	resctrl_kmode.rdtgrp = NULL;
+	resctrl_kmode.kmode_cur = RESCTRL_INHERIT_USER;
+	resctrl_kmode.ctrl = KMODE_ASSIGN;
+	resctrl_kmode.mon = KMODE_ASSIGN;
+}
+
 void *rdt_kn_parent_priv(struct kernfs_node *kn)
 {
 	/*
@@ -3228,6 +3258,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
 
 	head = &rdtgrp->mon.crdtgrp_list;
 	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
+		rdtgroup_kmode_global_detach(sentry);
 		rdtgroup_unassign_cntrs(sentry);
 		free_rmid(sentry->closid, sentry->mon.rmid);
 		list_del(&sentry->mon.crdtgrp_list);
@@ -3265,6 +3296,7 @@ static void rmdir_all_sub(void)
 		cpumask_or(&rdtgroup_default.cpu_mask,
 			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
+		rdtgroup_kmode_global_detach(rdtgrp);
 		rdtgroup_unassign_cntrs(rdtgrp);
 
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
@@ -3360,6 +3392,7 @@ static void resctrl_fs_teardown(void)
 		return;
 
 	rmdir_all_sub();
+	rdtgroup_kmode_global_detach(&rdtgroup_default);
 	rdtgroup_unassign_cntrs(&rdtgroup_default);
 	mon_put_kn_priv();
 	rdt_pseudo_lock_release();
@@ -4395,6 +4428,8 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	u32 closid, rmid;
 	int cpu;
 
+	rdtgroup_kmode_global_detach(rdtgrp);
+
 	/* Give any tasks back to the parent group */
 	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
 
@@ -4442,9 +4477,18 @@ static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
 
 static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
+	struct rdtgroup *sentry;
 	u32 closid, rmid;
 	int cpu;
 
+	/*
+	 * A monitor group uses its parent's CLOSID. Detach a child that
+	 * backs the association before that CLOSID is freed.
+	 */
+	list_for_each_entry(sentry, &rdtgrp->mon.crdtgrp_list, mon.crdtgrp_list)
+		rdtgroup_kmode_global_detach(sentry);
+	rdtgroup_kmode_global_detach(rdtgrp);
+
 	/* Give any tasks back to the default group */
 	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
 
-- 
2.43.0

