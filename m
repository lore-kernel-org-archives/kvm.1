Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0979052CCF7;
	Thu,  1 Oct 2026 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867594; cv=fail; b=GFp+fWLQJxANLJby9gjxoxhT9sZUYWTkckxkiVklzkOOB5esKKH1ya7kRZGX/bh7JbfkMUVa/8DmkD7B+qxOaBPNu+Wxvj+QVHeuLh03XYOo+XRgKhpxn6VgojF4Tgf2Z5Wrv+FLBnXw3Q4yCB4BQGKrnYpAM7YyL0/w/LqHTCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867594; c=relaxed/simple;
	bh=3sWp2Uoc6lePMVJJx5YXHDXNKmsq+yfNHzkSLxA127c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ufwj+YuasIwKDzonLQYVx5/osK3tfIWrnCw6l1eUYH4lhz7c0c0KyqHIT48RcDt8hgRfXmz6LWnnZ1WN8K/EttNWCXe2HeTPSfHORYi+6WAB2NMDIZgyTYjVvkdDLgHnPV/7CqOITRXW0jqLBboONwNfyjjCbfjNnfzVxCv/Rzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CRrGby3y; arc=fail smtp.client-ip=52.101.62.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CRrGby3y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpgK2kA8/es4rKCiVHILO469frSqnvXW+DI7ligqZZqeixNRmjn4z5MA44zU00VGKeW4qQKjTkPEZcKyF8wtGSqLV0Cu9RLSTytPwAWi7nthrwDpVAsf3OYnEWDF1EbXiFYW4YrneWxL+89Swdsqcl9Rl+z79gJrBciKhBGg6Dx5S9ThWnh331vnE+IsD7QHy29OxMmGsY1qK3+46sPm2emDg95gY5Rxu0EYpgcD0emHX94z8jgXUiDhkOjVzE3WNjix2U+xh0FwTDQWGw1K25BbS27HbpaquBHis2GdFY3aFrup9UQnS7Tchd+eXttEReeyjv8GTrR7NzagA0LEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP5dIpixCJif3Hkkm5EJMjrAJkCh6kDJXR/BPWSuAJk=;
 b=DtP0gqonsGohvMsFjviZP5ksUB2ULDJIn826taAR41DsA8H/Nus2FV1jcyEZ00TFU0T/8UGxSk0DvgDG6t337iauK5xHMgmMkIoqq6aqRd8JW1tptv2f+yrJjSmlbT19aDe7Xo9L2ckDWgMl33Bpfag9V8ftv+86U7eU9a3glD5xTWdjze51O6XzD3vaoEhCSAf/WWyFPRY9j0at28NrZUWG9B/Gf0iuJsHIWFkde4iqXwJgxySRgov5C/ZGWcAUMSdbKc6HXEf8ojiodPqfstgUxvENcI6QaD5yZqsWqtmOPukawzoic9h+c+rtcMICUzkB9uZZHe+vQi2XXhlNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP5dIpixCJif3Hkkm5EJMjrAJkCh6kDJXR/BPWSuAJk=;
 b=CRrGby3yet2HUGbHpm8LPMZsgPRPXJjEJn3cfi16ZPS/c4ml2Vdm16NVqgqK5vg9CQyoy82AIqZ+L5/JXfnLydu3bLYj72To33lAsxl5IFO47BpwPa39Cf6VhOQxLjrVb1kKjE7A7+G83wWIjDIkHIA8WgHdrqAbvOJWy+uhx+A=
Received: from MN0P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::14)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 15:12:54 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::78) by MN0P221CA0026.outlook.office365.com
 (2603:10b6:208:52a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:12:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:12:54 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:12:51 -0500
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
Subject: [PATCH v6 14/18] fs/resctrl: Control visibility of global per-CPU kernel mode group files
Date: Thu, 1 Oct 2026 10:10:37 -0500
Message-ID: <28d7e4484c93d899ed86ddafa13faccce0dedca9.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: da2a39fb-5246-409a-b1f3-08df1fce779f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|7416014|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oEYRf0DthbYngzrjZcXNorbfV3u4HULJINZNHDiSZRUGPg1wRXRLqGatX6uso8KUBIvlXhovKmKBNNOfzZ2q8x6sVElVm6QHRnWbV+pcB1v5Hc5DoxOegQLdhDqPwQUtaukraDTeH07BM1jpjsuTBjzLSYVYGFw9dphUIdz1oUfLTrRsZ++Xyn+T0apaMZQkhCFOz2DWu1O8h0KPLtqbEvlLHEjWZVWCoU3y2XRil/eBHyC24IXBe5eRTAdbBbgOu3dMAAdBXIWgdk7rp/Uc58gYF7A1BXFV/0p/0EmStewIEdU48B2LZez3pEFw/Fy5Llx0p+C7hFHsQhAV8RY8vaSDxpqtu7yGCBHma8rQz3ZHHR/P1khYDp1ZS4zsMDVeLQ9nann4Pnwcp4PV8zhcM66R2hyJ47Z6A/z79YNlaD8oh2a38BOPTjtcWW6+Zdr68ZzPpbOunHgBt94qO23puluR9DkG1RTO5xcFSLvDvG3r9sL913fB2MGDsfsTqRyWqgxtc7GA8RqgibCPEl0TE61docu1BeVhv0d07Oer8ZCoGHqjkOHAhn3znt7tqRxWlpRzFyEXOc67S/d1tpMuYPgdaVC9GSZ1zd3sunsA7nA0GSB0H3j2DczP3uxJhS13yZFUppOmWY2XAY+imBN7LoK2ngWa82xJ8aDSmwbdRvvdzBeJ78p+a4VIODuBoCJX9I33cdzQEmxra84ei/lwuQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(7416014)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/76y97RWfWmsTPZ/b0RczWTEGjfSiTZvdkxERRO9mj5+8OF4QcfRJAOMK9/tvYfwlH+p0Tz9U4WPoQTbLdzlZZTMhuOmQ7hNc5uouKQYMP7TPLA8JQpuN6toPuTdoVUHhOWARyx2bg+6a624LrftgvIE9fqUekDUl8/JdYl8HeybBXF1RAIPT/v5BdUxt/gXsVNjn7bm2cVl7iuhmYQ49tpm6ivEv9CqM71qsrm6PkwERTxf8qAaAxQ1dBnrDf6jTgNs8wc9jVu6OrizjwNoP/WfKfJ9efkMMTQPfjVSYr/YD0ltnSu3FjDL0/l5u1eNThJQ6evbVdxVT8PDypaBt8ZOQczF6j6P3fVrM58lT2ny1WKNIjmkfZ36Cdq7vifuQWR6eMvZsF6oxi9fv8FoJudcayVTeplaDg7aznrhhaogb8Xt8wI6uCZNDN9Z+FcG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:12:54.0028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da2a39fb-5246-409a-b1f3-08df1fce779f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197

The kmode_cpus and kmode_cpus_list files are specific to the
RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode. These files are created in a
hidden state when an rdtgroup is created.

Introduce resctrl_kmode_global_files_show() to manage the visibility of
these files based on whether the global per-CPU kernel mode is enabled or
disabled.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Helper named for the global per-CPU files instead of unhiding every
    hidden file on the group.
    https://lore.kernel.org/lkml/34aa4824-810b-4c81-8188-f2f37e1dc277@intel.com/
---
 fs/resctrl/rdtgroup.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 0cdc868a55b1..98451b417fe3 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1125,6 +1125,24 @@ static int resctrl_kernel_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/* Show or hide kmode_cpus and kmode_cpus_list on @kn. */
+static void resctrl_kmode_global_files_show(struct kernfs_node *kn, bool show)
+{
+	struct kernfs_node *kn_file;
+
+	kn_file = kernfs_find_and_get(kn, "kmode_cpus");
+	if (kn_file) {
+		kernfs_show(kn_file, show);
+		kernfs_put(kn_file);
+	}
+
+	kn_file = kernfs_find_and_get(kn, "kmode_cpus_list");
+	if (kn_file) {
+		kernfs_show(kn_file, show);
+		kernfs_put(kn_file);
+	}
+}
+
 /*
  * resctrl_kmode_global_online_cpu() - Program kernel mode association for @cpu
  * @cpu: CPU that has just been brought online
@@ -1175,6 +1193,7 @@ static void rdtgroup_kmode_global_deactivate(struct rdtgroup *rdtgrp)
 {
 	resctrl_configure_kmode_global(&rdtgrp->kmode_cpu_mask, rdtgrp, false);
 	cpumask_clear(&rdtgrp->kmode_cpu_mask);
+	resctrl_kmode_global_files_show(rdtgrp->kn, false);
 }
 
 /*
-- 
2.43.0

