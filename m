Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191515237AA;
	Thu,  1 Oct 2026 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867558; cv=fail; b=pY8CllZ1vmYOx1dVhQp0hKa0jvD6pnLVDBONQjO8PjP8UIDWhzbXrJKAzmy+xGcTaIty0j/QdyuzsTEI5psscZ75HnbIyqSCUaWdgEZrXw+7hF7Aloy4+xb8k/lLzfECHjmPZvNkQzEOnrq/g3LnUyBzsE+3OGrobOScnQqvE6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867558; c=relaxed/simple;
	bh=sfm9L5h+vsH4qUk+sEvNVMYtZgfguDycF8l/x6eZEtQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVFMV00snsB5dFAem99vQ/aJJ27W8PepjyyJtrye102mPKIxPWVwjDWx5z5/fI+hTadX/UdVN6vJ6yvnhxF6brB2i6yBcyyR5WxUXoHfh6hQwSJRgYYdpRkBCug6oIHQEShSWTDUQiNbB8xBnmQ8aYfZfHfVE9fspHNW7Meou3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zt0Jbsy0; arc=fail smtp.client-ip=52.101.56.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zt0Jbsy0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDX5b0ahwLRWfjNroom8oeEF8pkHHsuys6GtJF9bHfGA8P8vjVxAUz0mNL2ePBWlimwoff8GaZMJMaAICR1WCYbabN6nLdnTveqeeAP5fmW0VuIpf7s3NC4ElcxPd60JyqUSv4uFJs31xdCD9MhdxEQgboXT4y5xzjmls9UuAtCrLI4zQONRNEWqB+aA3zeWKp3SCfrU82i5X9kEd6rf91RXdtBvTFp+gHD559OG8zZ954sVEtm3ByfL2ylsHyU9ippjSq2Py40Xwu1rw4XhjkJvxJMuFCFY/4c5HVJfnJNiNWPeUD3YW+MLRJlztoz7g56VbKj3Ze4b2Wz09LGOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xzz5jiEkg7ynLpZK4HTh4K8ITgb/gqrutdJV0uuxdPc=;
 b=AFRLtzycJ9RqZFa49y4N1c2bpCDqM4UGEGE7irEy9WaINnI5FsRewujJNJ3HyGcj+wpQbSyb/ij5nBuK2XVDG4Pru15TftHNxbaQF25pLMlkzx3CBhzzbzmJWfXtiQLpza0BW8UUmfAcl3h3aRJsFMXZZzTaknz5MYM6infvSUa3wu9qYCO2itkz8ahYQKIfNbqCL/PxRZRZsLhAUfy6OVIhcDXvUvx9NxASydd/nY171pO75Oy416Pi+1XBtmCOSKldvb2tcDDs/3nHbb7fUNIVbjqv34dcvffFzmu95pSK1X8xemP9VALtgD+oKwDupeVE2AJ0VMmBEC6Vt4iCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xzz5jiEkg7ynLpZK4HTh4K8ITgb/gqrutdJV0uuxdPc=;
 b=zt0Jbsy09wq6OET778mVBOjhxL55iUoBE9BVQvkZDib5/ee9OLp+iRkqCfyCcffg6bWHcolofaV0WGjaIJgMVictPvErljG04KwXohJe9uhUC5WVjrWjG2uUByLsITPcTKSBGNLj2l1XNgIK6UbV4SFpuoCxCxIEyJY+FNZWKkM=
Received: from BN9PR03CA0847.namprd03.prod.outlook.com (2603:10b6:408:13d::12)
 by IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 15:12:27 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::87) by BN9PR03CA0847.outlook.office365.com
 (2603:10b6:408:13d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:12:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:12:25 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:12:22 -0500
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
Subject: [PATCH v6 11/18] fs/resctrl: Introduce kmode_cpus/kmode_cpus_list per rdtgroup
Date: Thu, 1 Oct 2026 10:10:34 -0500
Message-ID: <54b0c60041902accde067b48bc3178c6756294d6.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 6390aee7-a00b-4a53-a688-08df1fce6665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|7416014|36860700016|6133799003|18002099003|10067099003|22082099003|13003099007|3023799007|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	EaZP7ULeTYCStUmCLaAJ5s6Rqh9XpBZ5p5FaqnJY2cVAUPNDWaNf5JWWoeTlXt256u65PAfieTg29Lo2t0YaixwISUdnH7FGzRmwU56zJOMuj/e2O85Mc9CiaeKs3529fOENa5TZVvnTn5/yWiiu6iMrHjEJxcvdnhAN2UYh/W6X5/t9NfZTkucbtAYkjmQ850cA8ugTB3SsIoyv6suB3bK2oPHceb3xKEKdMqv9seXYw2bS2syiqJsbJR0FcFqnBd+E/48zquxQ/lnqCj15rWh/TjC5Gqhke7jF+7OAIlmyzcihcFkFoLGG1W1zBFbRlMjpMplJGPucAHOTR3FUD9yW+Br66vwTSeBsUo8OICnHy1KemfgVshi745W8y3vvc9Yyc0EovGzJXtTbKyksSOOejGv9LPuuaH7oTyq6Dcw4q8gFb/Edflr/Xd8AuBfoJfLOGQoDwbiZG6FauEM15HkaA8E2DmYOcbJ8P4ZQF+f2fDnXSt8il7ZznEFlNLk2EBk9A+NVSZi0C6U4t84knACfuqbKfzrU5hPCgIlHrP4ECnQIIFf/cptI0B/CZehvngB3TeUR/Vh7kVbwK24d4lMYaxGZOKvDpS1AePMDv0KW034CVHa5hYfGEYQ+pJcK1zK86SiDpcAIeZtCaZi6n62pm9pvWm5W516AJewi+tHSDdGVmRJmTIDH/pY7za8kPfKhqoyNFV1mZbZs+1+gVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(7416014)(36860700016)(6133799003)(18002099003)(10067099003)(22082099003)(13003099007)(3023799007)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GytBvQRawbmIcWL6IQww4UmAPin5npLicddH2RT9hwu6oPRAOmxjZ0ljX2rHKekSZNyXG5NNzn3fGn3EpWSwMw8GF2rT/aS2Qzzsd9PHavoRSjX60LpP2woFoG/I0Pcb0Wgw8k6SDZ3VQj/8rHCKR9bnAIk6b2WNoDbft1sfvM+ikyrHbqdDU6XkejfCOSfudq1JvRMnEPx5F1gHJLhNmjKYAxcP8UBB/bOizWQX3Fs+SYWxb8ms5FdCEfxOE/0WftHUIYF5yDZ4CZnhre6GyvI5Qa5twz7jN9AiPfyzA3cpAqgaC9VVokFw9ZHuaQql/2NCG37LO8e12yinI24dhUQDygW22OnzTUYK2rDWs7kGW+PWoONXT52PcioK04RNl8SK8LHXT0g0V0bJOWKDTz9RG0LloNg2OMXkFGD9Df4F3OH3iBP9+paKXoV1lp6c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:12:25.1113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6390aee7-a00b-4a53-a688-08df1fce6665
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262

The RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode allows tasks to use different
allocation and monitoring associations when transitioning from user mode to
kernel mode. The mode is enabled/disabled on a per-CPU basis.

Add kmode_cpus and kmode_cpus_list to display the CPUs associated with a
kernel mode. These files are exposed only when the global_enable_per_cpu
mode is active.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Drop rdtgrp::kmode. Rewrite changelog (not a bugfix; association).
    https://lore.kernel.org/lkml/ef8804d5-f20c-49a1-87cf-ab39437a5f0d@intel.com/

v5: Updated the changelog.
    Removed the RDT_MODE_PSEUDO_LOCKED check and added rdtgroup->kmode check.
    Files are created hidden.

v4: Rewrote the change to be generic.

v3: New patch to add "kmode_cpus" and "kmode_cpus_list" to support
    kernel_modes.
---
 fs/resctrl/internal.h |  2 ++
 fs/resctrl/rdtgroup.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 986b9c942fb2..6b8d14c4bd83 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -216,6 +216,7 @@ struct mongroup {
  * @mon:			mongroup related data
  * @mode:			mode of resource group
  * @mba_mbps_event:		input monitoring event id when mba_sc is enabled
+ * @kmode_cpu_mask:		CPUs in this group's kernel-mode association
  * @plr:			pseudo-locked region
  */
 struct rdtgroup {
@@ -229,6 +230,7 @@ struct rdtgroup {
 	struct mongroup			mon;
 	enum rdtgrp_mode		mode;
 	enum resctrl_event_id		mba_mbps_event;
+	struct cpumask			kmode_cpu_mask;
 	struct pseudo_lock_region	*plr;
 };
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 46b2cafd9411..0e638dc654c1 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -385,6 +385,31 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+/*
+ * Display CPU masks for the kernel-mode associated resource group.
+ * Supports both "kmode_cpus" (bitmap format) and "kmode_cpus_list"
+ * (range list format); the output format is selected accordingly.
+ *
+ * Returns -ENOENT on error.
+ */
+static int rdtgroup_kmode_cpus_show(struct kernfs_open_file *of,
+				    struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	int ret = 0;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+
+	if (!rdtgrp || rdtgrp != resctrl_kmode.rdtgrp)
+		ret = -ENOENT;
+	else
+		seq_printf(s, is_cpu_list(of) ? "%*pbl\n" : "%*pb\n",
+			   cpumask_pr_args(&rdtgrp->kmode_cpu_mask));
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
 /*
  * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
  *
@@ -2256,6 +2281,23 @@ static struct rftype res_common_files[] = {
 		.flags		= RFTYPE_FLAGS_CPUS_LIST,
 		.fflags		= RFTYPE_BASE,
 	},
+	{
+		.name		= "kmode_cpus",
+		.mode		= 0444,
+		.hidden		= true,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_kmode_cpus_show,
+		.fflags		= RFTYPE_BASE,
+	},
+	{
+		.name		= "kmode_cpus_list",
+		.mode		= 0444,
+		.hidden		= true,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_kmode_cpus_show,
+		.flags		= RFTYPE_FLAGS_CPUS_LIST,
+		.fflags		= RFTYPE_BASE,
+	},
 	{
 		.name		= "tasks",
 		.mode		= 0644,
-- 
2.43.0

