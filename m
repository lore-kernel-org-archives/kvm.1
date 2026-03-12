Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012061.outbound.protection.outlook.com [40.93.195.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0453803EF;
	Thu, 12 Mar 2026 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347872; cv=fail; b=eW9YjhvI3SlC2lKzjbW82soThvuOyuBbWkNpvQZ6IeDwkXNZOFIxDleJiG2LqenNZww18duJs64TuFiAiu1CKnNO11Eaa+byGhny0HzZIN+uVplHOb5o7mALN/pW6mhZVSfL7t5rzag5/m/2+0jpcC9TeBhDHY4a+6UdugTe450=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347872; c=relaxed/simple;
	bh=lnTY3kkmEaCkyOAHiFNhdh00uLrz8OqtfJ2jQ5/BcUY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOHVZpBtSI8x4k2NYzT/U3Jbe9CaHBSAOV8kCnM6HBIjKXWN6sxFHObJLDIvwmeHHRZJdcgwW6BuK5m9uuMfuHl6WJRt69bZ8wRW7z1JTmyt7Nla8CobP+vCqCnmzFsiiMGfsf+znMBZYso8HUmSb8nskX253rKNp5gcEk3Imss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I5UaLQna; arc=fail smtp.client-ip=40.93.195.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I5UaLQna"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arWZ1yYbgP8nPmwwdz3jeUTZBKO57kF5K0S/zq0z3PuB+aKWXNpWiFEG0862R3g6+qPbHpg0XhxkXfrhNQiXkUpglVIACs2fFCKMWPaKgX9ZaN9PP5Bba+vC61d5g8osiAFv4XqbEE151EKeEy+kBgjByeZV4pCq6JVO+EdANBaFLUdZWfpIU53/WgdJ6JDCzAFaEptebp5fpul7WOixZ4VjEdar8zqXZhVYLpyL/HXNgc6p13fi/dGtoBRxNInaOi975OKpSnw6olP84bRMO9HfRQ6z2nl+DQMZbZyYHn3M+wi5vXndCXEhlcipPmz5GVctPpzGRhhV/GIlvm8RqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXWoKmaPcXlN0xBcfcw2U+P48Je1gIL9YCUmGE+ziqQ=;
 b=nucrll3ZhAdJFEIIexxsN1fVWA24TtTxI/sl+gj8As0aov0jJTADigoHp7r7IIWYtW01NSStTBWlLu9MMEEbCxxVloBdEHHhUol3QxjwJUKUEg+DqoRabMWVMSxrPlrvVGea86Cqgvp6GrjUVCTdKuYcAk3zGf/EKon35RBaYZ+5Xf9IVEl1qo0A5aafyODx9LwDrzSiqwmaW3Hw3JCsqiuK10adflp97EZoU39b9J0WFbU7kH0YoeMPscY+YQGyla3G2BcTAr91dnKar9cWPKz/NJQRcWHf7YanClVopwAzy+auAGAERguSbxvIwGEq7g/dtKKGmOoUmSp4kW8sTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXWoKmaPcXlN0xBcfcw2U+P48Je1gIL9YCUmGE+ziqQ=;
 b=I5UaLQna5eQu8huEjxh6pDQfqrGGGLqL9rny/KQyDvTGR8Dk7uWN/uxoNASLKhhM/ykfHcEBcUrOTxfCMU8Dm2TY6PaFEJlRa4vk+weryQ6CRkOoR6syHHn7xL7nQ6bMA7jIDwe7usxPZbCEfxL3CT2cHeSzAtqwLlfF/urAVv8=
Received: from SJ0PR13CA0126.namprd13.prod.outlook.com (2603:10b6:a03:2c6::11)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 20:37:45 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::b9) by SJ0PR13CA0126.outlook.office365.com
 (2603:10b6:a03:2c6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Thu,
 12 Mar 2026 20:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:37:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:37:42 -0500
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
Subject: [PATCH v2 03/16] fs/resctrl: Add info/kernel_mode file to show kernel mode options
Date: Thu, 12 Mar 2026 15:36:48 -0500
Message-ID: <aaff7cfd9baf3a090599c20f7c9cb110b1b93554.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 74334464-fb8c-45a4-7379-08de8077375d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|18002099003|56012099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	cVDl6mCRswX6h9a/2GgFHW0u+4qtM5+kdS3feb7UfGebFO/9dJtS7p5ab0ISTK+h8eAp8OpS7iSXY12PCnEDBUZese+kx+DnH2Pn+fkY9MFF8gKyTvJrq/WEtinALVgMwqiwmRK2o3FRy8yOQ5Mkw6CKqaw8CNxJ7IbYhjKCCoXsIFEzer6znJwWxTjuPAhTuI/YlfokIaajZH7NDyISHLo9Z42aYa7APa/yInd5N9tDNWsneHK5tr9Ru2nPw9KCmjY5nBqQ0U9Lv/S/CMAsWaz/4Q1nN/lRQd4Hu/NnsU5R+8pBhp1JfeQX2AEjtL2dX/y4tNvxW8rVFgsIv9M8J4lsSHrZffFRVlgFY1VgsLZYT9JwGMZuNd68/TMte4WoqrXkzitBNJ1eG9xxAIE5ghzDeT0ur/0q4qecU5iIOEA9SyvzAM1GGDd5t6GnjapT3NxdkhxpaQJPG+smBdv8jedbBp7U/kQSqciUkZbDU/il1OzfmT3h2A3x/du4lOjlSaff3jpaNoqLa3B/Q1TCuXozI6JSbhyLIz3+Re5I0gcwTTjU7TK7VhQ9z3LUOKbYqaDN2Hfg1MydS+b3p6jehOFLc7REEcvj9K7QSM734ZB+q1arCAaSr/z9DF85b0GWNxW6ljU+/6InDigm1vKbOh2UUBimqLPwOqBIh7KJVTzP00iJvDFH5dmvhMv/lDO+0zsgNvddjy2jha2oF3oC17rTUGGqs7avD+xRccuJLy8qYkQlcQsHo63tl571o310MkOGG1rqs0PvQFrABg7RMA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jP+Qa8pibyIC3nIvU0UAdoTUypRyXzNvmIFx7Q0hy/xgpiLdiswMkW4RrHTZYGfXj1myOCvgr5KEgoN5W0bYaVHblOqoHm8myMY7IE36GtQ46USdmKpskViUQhIIdl36oWDxuGstfmbCNYuAU6sgJJOPZwyzvKAWxnLFlgs+E+5hCluR3r8YFUw/kFZ/4kGjbVYJHtM6Zog+7Ee0HlJDI9G0DQUSlyzooGIoTgWNCK01LYK3eCxQJWIFx7J/toOBb+srpwTlFay6k552i9wYjZKs5rbP8297Rzio7dDd7/X+xFUqP0UTM5HpszaOBBgHrRacRUb9eAjvJH6QedAZJOr24Oz09y0tZIoNTuQl9GuabS+ABLVhG/EqzBT8c+u58Pmro2s8DjrdYK8USUoaX1CdfVbbo/t/hSTC1403t8J/FO/+gqZioboJ7P7ZW5aF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:37:45.0185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74334464-fb8c-45a4-7379-08de8077375d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254

Add resctrl_kernel_mode_show() and the "kernel_mode" info file to
display supported kernel modes and the current one (e.g. for PLZA).

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: New patch to handle PLZA interfaces with /sys/fs/resctrl/info/ directory.
    https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
---
 fs/resctrl/rdtgroup.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 9d6d74af4874..081da61bfe84 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -984,6 +984,41 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/*
+ * Supported resctrl kernel modes for info/kernel_mode. Names match
+ * user-visible strings.
+ */
+static struct resctrl_kmode kmodes[RESCTRL_KERNEL_MODES_NUM] = {
+	{"inherit_ctrl_and_mon", INHERIT_CTRL_AND_MON},
+	{"global_assign_ctrl_inherit_mon", GLOBAL_ASSIGN_CTRL_INHERIT_MON},
+	{"global_assign_ctrl_assign_mon", GLOBAL_ASSIGN_CTRL_ASSIGN_MON},
+};
+
+/**
+ * resctrl_kernel_mode_show() - Show supported and current resctrl kernel modes
+ * @of:	kernfs file handle.
+ * @s:	seq_file to write to.
+ * @v:	unused.
+ *
+ * Writes one line per supported mode. The currently active mode is shown as
+ * [name]; other supported modes are shown as name.
+ */
+static int resctrl_kernel_mode_show(struct kernfs_open_file *of,
+				    struct seq_file *s, void *v)
+{
+	int i;
+
+	mutex_lock(&rdtgroup_mutex);
+	for (i = 0; i < RESCTRL_KERNEL_MODES_NUM; i++) {
+		if (resctrl_kcfg.kmode_cur & kmodes[i].val)
+			seq_printf(s, "[%s]\n", kmodes[i].name);
+		else if (resctrl_kcfg.kmode & kmodes[i].val)
+			seq_printf(s, "%s\n", kmodes[i].name);
+	}
+	mutex_unlock(&rdtgroup_mutex);
+	return 0;
+}
+
 void *rdt_kn_parent_priv(struct kernfs_node *kn)
 {
 	/*
@@ -1885,6 +1920,13 @@ static struct rftype res_common_files[] = {
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

