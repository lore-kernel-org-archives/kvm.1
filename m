Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB473822AF;
	Thu, 12 Mar 2026 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347944; cv=fail; b=hqPfPmEQmcpO+Hg8+vZkLPr40ivlFQpVMLBe/kahW4Kb27FCyHao1aW4mco7NzuhsLwujQha4TMFFEBaqmDZ8rpHIE9g6L6mRc5GibRuGk9hcO89EYyeeZCn6aMczwpjl/Z97SWVA+RsHVM6iNbVd24+9oKR/zhVR8DCKgUhABs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347944; c=relaxed/simple;
	bh=Ux+/ENdW5epDfCwmpwh85Uw0mlitG79ai1aMY+V3Yyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqiCwltrhD+a9gdiEWvqE7Ofi3Mr0Axw5iWbXV3o5Nyk47RFOn7B8yB4cPmpNsds8cfIAVgecIM2Ioec1mpgZA5xCr2WFleRww4Y5gjNTZAJZNtRkMZS4uWC70a4LInJh9csQmwrCHFkTD5rpICjL6Xru5tRy9h1lOw5gYZKBSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pfqoucA4; arc=fail smtp.client-ip=52.101.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pfqoucA4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsr3H/40YD1CuP3uOB/rZlSE8/aOgskXx/HnevgL+Ag/peWNVT/zOhWFFEFTRrLs9kxkWgdqkoHbjJWlfra8GbbFoOVU7aJPFkwVLRyWn0D6saINFhcG+wbIrPq90rjIlKddUr+uEf5MDUdTUlkc0V+tUXD3rAhe/+czEp4tfmhwyTm5kxfeuODH/KVRyOCL56N2AmCzCxkQsGS1wceMYPepkd9sdnW7GDiao7Rbirhx8ZQcDBzaAo53muq1/Flmtbpmgawx8AhEk6b50yhGnLjGZ4+EMP4A2xkRJtyZDXq29Ist8DtOgwXadygvL3P9DHBMC6nEJoGl9EXNMuK4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/o4UtSqy4a9K5/cc3YyiKHRba7rQ4dLJ4OR9vyJxYg=;
 b=MIfvx/igB8JVFWN0vTle+GDuR4dNq01hQ9V49fDJqWprOmTQ6AyWUYE2K5dTQtG02FY8IHghK3it0CZ2cXq/+c51UqJ8cP/9vN8Ke0aYDzZPeG56MPls9jKIvMhQf2ML6zV8L04GrvoGimBipwNSBxnJ50BA7p4bk+Q4B6o3lVyXHu/O3LlF8rIdTV8w0qEZaoMLCaB87deodFyfaSuNepf/hpnwIBX1vxhKBa/fJELhrp8/GjAEUCKOyZocP9lFvuqSzPDzxzOAu63xObl5WkA/hHEZh2DDAFf6oM0cPiLOFUwk9SMa/Ka6xwlAaw86J0KiSrmaNxeDOTbhRMn9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/o4UtSqy4a9K5/cc3YyiKHRba7rQ4dLJ4OR9vyJxYg=;
 b=pfqoucA4qiK2V6YDz4cVLgzHVuBauabgK6QLe6sCTOloK2n2HWxlLS5ZH9OuW/1eTYJTFzYqX3HgIGdIeKv2tEs1vUzhzAJh42ancTY/xV4wCqvrhfJZv24B7LN8/PgcxSrtNO3A3vF7v79BAonZ1qkSwQ2ubQ4tzEMWh36GRB8=
Received: from BY3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:254::29)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 20:38:58 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::b0) by BY3PR05CA0024.outlook.office365.com
 (2603:10b6:a03:254::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Thu,
 12 Mar 2026 20:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:38:58 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:38:56 -0500
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
Subject: [PATCH v2 12/16] fs/resctrl: Add info/kernel_mode_assignment to show kernel-mode rdtgroup
Date: Thu, 12 Mar 2026 15:36:57 -0500
Message-ID: <77003a6c87581b23f293c6f75188ebe140c7c022.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 669c1af4-f2cb-4065-4927-08de80776304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|22082099003|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	cNJ2VrchP/raMpvw5Qg+Hk7RUKBFtcfgjlujc/cMpYMI2N6R5Wfs8bC3+/3U6HYqwkj8tmustDc5RwwTyJbX62GykaurikVABCN1veVEFpwVwk0VzMBXTZaju8xWqz6elYhvGBqSaDon/sgOjCKY1OSqU1fzHr2HBXXxD/UWm4V62NB5O/j6jIdghYt9qcJckupT4C5iOz7SCNzfmZP6YeCsxQJV8/CXtjZpe/PBzLGFbR3jZQAdNpL1zA9EuVOE4OHTlmmg3Gz8076DeiL02bKftPIaaNMOzj3pggN6W3I3eB9R6pDgXKoFjG3eEyfa+5M/w/PUo+uP3Ljg81IdyfjCe8ftSjzEMdgnonq9AzXV4rQEPE6DluFv5f0XTRPDVz34qPcGSubtDjUaiHsqFkuLf1fiIzlp3IU9ziH2Um4A3RdVP3JswNvHQWRGVm9zJrluk3krMmj0ytNoWZghlMKXmcQ5BGugBTKdj0Qx2Bgcc/+6TWoiUodbifTTqxmVoTnruIw+lk1FKr9N4mSGqbF/z8G1xpThAYpoXaBzxR5C3E5bsHIVe7cCf0qt7QwrW9x5rBCv4zJoZC8xgpDziGOHAFbunx5xkjamkokaV9rJhPYOjvPnarqs7NJMc8S5MdfWTqwMF6Co34bCmgxHjFJq5E/BV/MEUOiE9qoPIJ+v8cTaNA5VfQTwMo9QqoQ2+kS0UlK1SfzyGzA8ohKIuhsS5Ur1p9r2F42Fr3J29FiXz05RnZo3Ix12p2Z7FKMBxN3EGAMCBWT/em1IDgOgnw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(22082099003)(18002099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WN0S1ai3SSTY3CTloIE0N3FPiGQV5FiuxIAHB0SELXndnsPLjTst1HwQrPqPu/bvdhY1LISkAkZUamBgVwXDx8iM/oAYC/dqUS11Kt2TXZ6MD+BQ8bxTqMgAV0+FKyHgU9zG/56O820xY+UG1BsMd6t6IshggiS+vao5DNcK2Elm0+3TTGY3wgrwS1IW6geQ/eXKh6m5KJtefw/f3E4nhfFmwq9QVhOJ94t3Y519CD2hPvsr+MV6Rl92mGcUl9K/i0TwnAfumBcpyZ8zbhhmKaggDof5kIOcnEt77yVS/t1XJuycWvE5LoYq9o+6AnkysV+GGFRSgT/Vm2M8ZtJ4G8xnwA0PdAw4TN5tvIZaf0fHjVjm5v55BfZgD+kqw1lCDdMpRc/OD22mgz39MBib2drm1/u9yEC+G6Beg5YiNr619G9/ic0m/4/BYaQaBzkK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:38:58.2537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 669c1af4-f2cb-4065-4927-08de80776304
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471

Add the interface info/kernel_mode_assignment file to show the rdtgroup
enabled for kernel mode (e.g. PLZA).

The assigned rdtgroup list is printed in following format:

       "<CTRL_MON group>/<MON group>/"

       Format for specific type of groups:

       * Default CTRL_MON group:
	 "//"

       * Non-default CTRL_MON group:
         "<CTRL_MON group>//"

       * Child MON group of default CTRL_MON group:
         "/<MON group>/"

       * Child MON group of non-default CTRL_MON group:
               "<CTRL_MON group>/<MON group>/"

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: New patch to handle PLZA interfaces with /sys/fs/resctrl/info/ directory.
    https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
---
 fs/resctrl/rdtgroup.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 6cd928fabaa2..c2d6d1995dff 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1117,6 +1117,45 @@ static ssize_t resctrl_kernel_mode_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+/**
+ * resctrl_kernel_mode_assignment_show() - Show rdtgroup assigned to kernel mode
+ * @of:	kernfs file handle.
+ * @s:	seq_file to write to.
+ * @v:	unused.
+ *
+ * Prints the rdtgroup (resctrl_kcfg.k_rdtgrp) used for kernel work when a
+ * kernel mode is active (e.g. PLZA).
+ * Format: "CTRL_MON/MON/\n"
+ * "//" for default CTRL_MON,
+ * "ctrl_name//" for a CTRL_MON group,
+ * "/mon_name/" for a MON group under default,
+ * "ctrl_name/mon_name/" otherwise.
+ *
+ * Prints "Kmode is not configured" if no rdtgroup is assigned.
+ */
+static int resctrl_kernel_mode_assignment_show(struct kernfs_open_file *of,
+					       struct seq_file *s, void *v)
+{
+	mutex_lock(&rdtgroup_mutex);
+	if (!resctrl_kcfg.k_rdtgrp) {
+		seq_puts(s, "Kmode is not configured");
+	} else if (resctrl_kcfg.k_rdtgrp == &rdtgroup_default) {
+		seq_puts(s, "//");
+	} else if (resctrl_kcfg.k_rdtgrp->type == RDTCTRL_GROUP) {
+		seq_printf(s, "%s//", rdt_kn_name(resctrl_kcfg.k_rdtgrp->kn));
+	} else if (resctrl_kcfg.k_rdtgrp->type == RDTMON_GROUP) {
+		if (resctrl_kcfg.k_rdtgrp->mon.parent == &rdtgroup_default)
+			seq_printf(s, "/%s/", rdt_kn_name(resctrl_kcfg.k_rdtgrp->kn));
+		else
+			seq_printf(s, "%s/%s/",
+				   rdt_kn_name(resctrl_kcfg.k_rdtgrp->mon.parent->kn),
+				   rdt_kn_name(resctrl_kcfg.k_rdtgrp->kn));
+	}
+	seq_puts(s, "\n");
+	mutex_unlock(&rdtgroup_mutex);
+	return 0;
+}
+
 void *rdt_kn_parent_priv(struct kernfs_node *kn)
 {
 	/*
@@ -2026,6 +2065,13 @@ static struct rftype res_common_files[] = {
 		.write		= resctrl_kernel_mode_write,
 		.fflags		= RFTYPE_TOP_INFO,
 	},
+	{
+		.name		= "kernel_mode_assignment",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= resctrl_kernel_mode_assignment_show,
+		.fflags		= RFTYPE_TOP_INFO,
+	},
 	{
 		.name		= "mbm_assign_on_mkdir",
 		.mode		= 0644,
-- 
2.43.0

