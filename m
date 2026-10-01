Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013024.outbound.protection.outlook.com [40.93.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D38535FA8;
	Thu,  1 Oct 2026 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867610; cv=fail; b=ft6hzruz21yLY5UooePpJ05d9y1+DhF3e9gf5ez6hLPc8TrVOYPA+kLGIuLR8zOZjH9lawuHtun15AkAOzqpPcICNAWOk1bMCA7DOWZIh80lbAcm68hfk73tmpSOQuepa9skoWq+mMiHu6s9l5sinawENj8u6CNHzGt8PXbPb1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867610; c=relaxed/simple;
	bh=Hc9XZ8YcPc2C5XVNMOvCauvs8XB8fljkIN7TCbWI6iU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dY84D9mskMqipASkg9P5qaAwGv+EQ6K/GC7SLSeopgo9TLAxTPFV9ejh8cexUfLGA5z3ZBO8mUT+ACwiKzby4S4Ug8qvCDGjCJW6uSskShy4HjJf6ERUceRX+jGi8T8Er0C4r5SIggT5Rc/yKU4zOK0gXNjUr/bW2BCof1Xv3+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QvFpSR7O; arc=fail smtp.client-ip=40.93.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QvFpSR7O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/QdOBYX5Cd3g1jhJ42e0gi4t5Zn2gJJMHmL9GeRKZghcjcPkOVfgxz0phrZSgikYiXDVx5+GUUPKVFnnPo6LkWL+KGK1dmMXpLoxD6ZQjmGCLB3WcdWLgs0JztQy8UMA3Bbs8X8uClepvi7qCtGCWYvThbe3RViILOmmNWwZtXSPGNqANO/077SG7iTNHOrfG6BK78oEmhLrF8LhCBn7CZt5xkCarcIRvGGdnoAsdtKQphpXITq1j1BFBIeravd7F35NQ1UIwEK08SsHFdgtlK5BHGQahqOcfZ8IPFF3kRydk/ic8P6rt/+VS0KdUivBMyFeBw2iWGPqWVxiAO0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/eFRDmeyNTS5bU5jLEex9QKDepvVBVlcoPwx9mOwI8=;
 b=oenJ3o2tEb1OMAnpD2GtSfVnpB4XNAyzjQRo7xQTSb8sK9dPQ8KkKO1A0W4ERMWodpbBKXHGW9Oki/0josQ/jTvm53lbMt2+wBCJXePzq0rMnGggrtlgyEUpvT4/CONAp8cGG++hfm7ZZU0AMB2ykN8h1NB0YvSndDeNhzNdwSuIHAmrbIOc0zzXvYmrY3yOjqEaHouVGnwa+yQ4XCOJTo9ptJH6vP3/XEezryMil8IkCsPAYzAHzgCMJJUBNUHaPSqcG7JoeMjLwrOjv308yNlvstbnYaisCZKvvWwKDjNB8NBeBOrs6Jigg0UeZD1D7xqTU+MQ1noVHiKjPcjJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/eFRDmeyNTS5bU5jLEex9QKDepvVBVlcoPwx9mOwI8=;
 b=QvFpSR7OO5B24Dg6840XYUAJ3WpyiQIvxC9luiQqdXlOA+uBriBfOpTMG4e9+6ux3JBJC2bJp+TjoOFGwOirV0YwcIWPZDePjpIczxik4H+Wvi/NA+3Yy4SKcarUjTW94+uHdkMfcx/yoHf8g2lgmJ+WH2moA/hvddCavgXFVg4=
Received: from CH0PR03CA0197.namprd03.prod.outlook.com (2603:10b6:610:e4::22)
 by DS5PPF922753E5F.namprd12.prod.outlook.com (2603:10b6:f:fc00::65a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 15:13:07 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::11) by CH0PR03CA0197.outlook.office365.com
 (2603:10b6:610:e4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:13:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:13:07 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:13:04 -0500
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
Subject: [PATCH v6 15/18] fs/resctrl: Reject mode changes for groups backing kernel mode
Date: Thu, 1 Oct 2026 10:10:38 -0500
Message-ID: <d0392cc08e4bf28998a4815943525a0461003801.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DS5PPF922753E5F:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f99edf2-81a7-4417-17fe-08df1fce7f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|10067099003|260925021311599003|11063799006|260925021911599003|260925022911599003|56012099006|3023799007|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	YqBfCYRp27PB8hpFDFl7v23bmaWJGNlg8P9IEpdKJ7++plrbQ96Wf6/0VVsxbLOnu449BfTb+N3xUIwHGx+LIPiT27KvBwZBd2hAGxYXk/umbSgj74bpwvfMkssYjv/LUpRLHy++qatj9kPRlliPIIb1z+VFDPuwr+75dE6kKyxwDzeREQ6zgSwJgc5sNaN80QFhvDJB2FeHWKZ0U5VTJS5fjHTJDesbu/9JI5fGe6NxQfsqPvf/xV4e2Fje+B1ASmvTLpwU7eiaPEZ7d5EoSGJbp/kXUPE1MlgDPIjYXVsE0UA7ItTiKIGaaiYIEVe5Dcyr/LvaOk27nw4Hu4Ed1Pus9G1IJaDCzuxy1dvx/BWdO66hT4Ysy2k6cU47CzcdxNx5/1f+B9iqd2Grn0QTGNGsE/s4b7eoOgX6uD2Lj5aJ7tNpx69DN6eAM07BrmVRu0px8gl9LJxvdiqA2nGotRJ4D7FLvZVFizQWd40yW8fV04GNAXKQlVrKZxiDESgswiOeyXwFPYURQJE6o59lw7StG6m/Z2sw4VZJEJ5kOkHGUEJ+an6PyGfMDU9dO/U2d3zkU8dOuWcwnwIPNyS1bYdgNMlaoN1v+uN7aTvGHBtPMZNav3rOzJQeQAo6tELwx2OBDuzFvJWAT58+tSu1Pw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(10067099003)(260925021311599003)(11063799006)(260925021911599003)(260925022911599003)(56012099006)(3023799007)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v+mQbycEjPGHYdE/yDlfAlZmD8Hu8OBgzTF65W1Pj85UDdYIOSKfegAg1tCDqGtCxCnenSXltn0+JhORDj2keUCL4oCCSG+tUfU7mRlRBHMomLX3azNAXXsmYLqza47iLaI+AhaJRoEB/1PsiGwD8+huuBI5jn1LNqlg+x3rEOfQJgENwEtGbRvpboFaLzkgF5xcflCIK/Oxk5iVPaUWysG01JFWOYkoqaCSPEYhVgmHgtqeNnc/SAsuHkmf0cTJqBbhycOCLgI35iSiABiSxApN+0mTEGtXSEwsJ473aAufsQSWz2A31vbKnkWGWIJ8M+qVq0D9TwUeMPtV4qhRkT+qyUlo76T8+WcaL98r3WrC2GWwAsDmeSV318yQ6s9w17ggMJBH6uaA7hGA1z7lXq2iqwZk56UCQZmAH2w2Ai5B3HEaIFvraPDImZN9+xXz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:13:07.0630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f99edf2-81a7-4417-17fe-08df1fce7f67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF922753E5F

The RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode can be backed by only one
resource group at a time. The active kernel-mode association depends on
the group's mode and, for a monitor group, its parent control group.

Prevent mode changes for a resource group that backs the active kernel
mode. Also prevent mode changes to the parent control group of a backing
monitor group, and prevent a backing monitor group from being moved to a
different parent. These restrictions ensure that the active kernel-mode
association remains valid and consistent.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: New patch to fix sashiko feedback.
    https://sashiko.dev/#/patchset/cover.1787772750.git.babu.moger%40amd.com
---
 fs/resctrl/internal.h |  2 ++
 fs/resctrl/rdtgroup.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 6b8d14c4bd83..84238e9e8e15 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -462,6 +462,8 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
 void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_node *l3_mon_kn,
 			     bool show);
 
+bool rdtgroup_has_kmode_global(struct rdtgroup *rdtgrp);
+
 int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s, void *v);
 
 int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s,
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 98451b417fe3..dcf9f26540d6 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1738,6 +1738,27 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 	return true;
 }
 
+/* True when @rdtgrp or one of its monitor groups backs the kernel mode. */
+bool rdtgroup_has_kmode_global(struct rdtgroup *rdtgrp)
+{
+	struct rdtgroup *child;
+
+	if (!resctrl_kmode.rdtgrp)
+		return false;
+
+	if (resctrl_kmode.rdtgrp == rdtgrp)
+		return true;
+
+	if (rdtgrp->type != RDTCTRL_GROUP)
+		return false;
+
+	list_for_each_entry(child, &rdtgrp->mon.crdtgrp_list, mon.crdtgrp_list)
+		if (child == resctrl_kmode.rdtgrp)
+			return true;
+
+	return false;
+}
+
 /*
  * rdtgroup_mode_write - Modify the resource group's mode
  */
@@ -1778,6 +1799,12 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 		goto out;
 	}
 
+	if (rdtgroup_has_kmode_global(rdtgrp)) {
+		rdt_last_cmd_puts("Cannot change mode for kernel-mode assigned group\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!strcmp(buf, "shareable")) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 			ret = rdtgroup_locksetup_exit(rdtgrp);
@@ -4697,6 +4724,14 @@ static int rdtgroup_rename(struct kernfs_node *kn,
 		goto out;
 	}
 
+	/* Reject moving to different parent if group backs kernel-mode */
+	if (rdtgrp == resctrl_kmode.rdtgrp &&
+	    rdtgrp->mon.parent != new_prdtgrp) {
+		rdt_last_cmd_puts("Cannot move a group that backs kernel mode\n");
+		ret = -EPERM;
+		goto out;
+	}
+
 	/*
 	 * Allocate the cpumask for use in mongrp_reparent() to avoid the
 	 * possibility of failing to allocate it after kernfs_rename() has
-- 
2.43.0

