Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE015221C8;
	Thu,  1 Oct 2026 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867593; cv=fail; b=tDrJXZoW1XeMEFEiIfnFeoELfT+nH/4+xdVfsC4nu1URhAXG52oCpSUx2FsYmu2iLM02xmN09qkFAzBecW/4ZWoDZZAEzi7o5OTUsImhabaubr07EypmsowqMdL0OJXoT7BLFnaD2dPm7RVoi5irjIp9eQ6BsBXKiBRZ7F2vGG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867593; c=relaxed/simple;
	bh=9FyrhZx/+zyfgNiDhpDGWnTObdiG/0msBUzZ7CYYzE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZeLHCI3NX9ipD9hMpOVwKRUetLpZmOXkaNoOS5NlN7O6JG4BSchZcIDUB6gCtre0objQrIB3YA740d9LWJGhm63jbuqQDFK86SMWmp9D7xvO9RqJJYep999m0klc3U4lW/osInG6NiDt/rHamd5mwKK5KcFJ8UodNIIYRSTt74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UrcNDcqg; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UrcNDcqg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lP5Al4mymuGbJk72Oea312KgD6OZ/+Kqg4DpbOsn9TFPEceZl4+BZXbeNeIYLSbYvikbIjqgigFHh9pCwphZOhaVFz5/2soEEdyBSQJ8WJ2/R14YYwzuiZVRf4CCo3RRNysmdI1BRYuvlZQBYwAE26s86rx/k+6/TLSZVpC48KdhPCOsRVwdrD4R232fEQZ18u2m9iw4k2yHIdQO7oaAd5RJeRxEK7khJnM4jAl8EDxFAp8yWLr7uAjvIjRqBhNG4vDb/3AohUoegxdGiRMmjCV2STN7wo6XccbW/Av1vA2tTO/OH/MEG0lx63ALGb0VDmeAWDYB37goujNkK02WSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6I1gfDtWdNQvLV79lUQCjSBM7CmUWBtz+EvvunF7uA=;
 b=ZMUmgk1G4zOoNjabsscwAM3m8foPjyFdJPtArrGfurgMt2yzERs/ZTU8+qCHcp4cNLTlH1OrRG/6NilMksGBt12/Xx/j6SN0fVXoh2D3tOTj50/URdwieCvW/7RusakIOvNjyHIrfC5FkoCAdV8e9f7Jbd5btVQbpQfcoTJmTYg05FtjObr5gNVfHmFPjn+2b9N0w/VnNqaF0UO1jP/UrNE9eDxmuhTt0crVyGLzfDBP3a+weQj0FGvDMOuIZ/h0jM4nykET/RQc4nn29olbN38TI2uJRQwSGEYpfliramNYJF995FjNhbBLmnbXsmD32KGciWLJxHRrlRrigMAGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6I1gfDtWdNQvLV79lUQCjSBM7CmUWBtz+EvvunF7uA=;
 b=UrcNDcqgr+EFhUccW9y5enisKQHzf8rdrl5vuT0ij10h/PR33KJYAcuKb3n4CHb9RE+7cu2Y4XO9QkM+C7/lDATz41JAAJllzz6xfNg4lEzyTIy++Z+BTdESJbqkOyZHUptjoRohGEwEWeqVX2QJsFWTvoit/wAj169ZjArKQSc=
Received: from BLAPR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:36e::20)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 15:12:38 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::5c) by BLAPR05CA0024.outlook.office365.com
 (2603:10b6:208:36e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Thu, 1
 Oct 2026 15:12:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:12:37 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:12:35 -0500
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
Subject: [PATCH v6 12/18] fs/resctrl: Add CPU hotplug support for kernel mode associations
Date: Thu, 1 Oct 2026 10:10:35 -0500
Message-ID: <553a9ab0695fcb7a0c1e68737582663d6fb3c080.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bcf3a5b-6978-4003-7df8-08df1fce6e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|36860700016|82310400026|11063799006|10067099003|260925022911599003|260925021311599003|260925021911599003|56012099006|5023799004|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Xutn9N+QCWnr3uMp0ES6sBrkrh0Oi4WA5OpLd+clolgM1vWEe3+yHcSDpSuX+A1AZTu9El5T40O3AkoljYYUbfCwkV5C7TNiY3CrzR3zOY3RSmJXjG1Wdki531wgli0wjtm+u3Sg4tDR/w1ebet6Xx+x9WMzSp1jDV2BePZzu1BNyfe+uFTh1n8Jj6rBM+BxkKcQtL7ehrm13IbCpe7IzjTaV2OhjnxzDM6wDHe7Xw6t+27zFrnGK6LzOlRLJsOzPQd58sC3uwhI2d0S3bLY91OBeyq6b3HT+zwzYY4zUtg4ks/TChR0cfjn4DoM3CuSW9lDd9UDviCkn5uMcll0HsuqrrSzlqdFjmNNjJttikdVwlLzD/UAFT0Tq1RBLACdgDb3NMC/tSlOiDdAVsy/pRsATVH4PUGBV24UtWhAbiMxJT6RC2+8OKMqmvVe7aes7wBaHC+v7nnjAdrPd6OSIbrXzLxgFF0ykCsjjMnFGs1oMRMfFYyL6noCjy8xocigUsiii1abyrroiZDlu5rWX0ZuOjmwTpY68tjo55aA5zGNqySYGCMV/TCfoXHLZ+xWpoXpqZmyfPNpP0DkkKFEfkUo0k+59+1azQ1Bw02f5SG4jYHvkEqcMQXZspStiqc2DqXAi1x3bq9qrkCL+W5b1w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(36860700016)(82310400026)(11063799006)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(5023799004)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rchyDLtV7F6WB8wtMp1PJAumToCE73aekah7gzOP+QEvlwzHriFXC0Cl0S6GyjWGtdSbYtcZu8F8VKLg3UDt3lKAX0XjPSz0qSvIgcNCZaYTVnCuuQPLWJ05876VqyR0FUyyHMyK1TybzTZzYA8lzPVy+sfK3TVoqMfomYUqXwBdT53hUG+8v99r7scy7KsePb81Z/WU04i83VffJ4LcwhXUy4OW9r0TuvWTosq6Uwxqgad2QlzYcTl1oDwbSa1pvQbWURMLxpkDaACgX7zF/bNnoLIKEr7UEDPM9CIiOZZCYcUbCFmzAJ0TFhiJ4tEU48rK+TcUyxZ09svkJSj3emy8l2ggBRdixc/6/7MNrzD2IKTdKV5Z9eTAhKIevVbpfDql2nF1rmb6eJFsGT/giAwNS1z+xysZxIap3XFDsIbnf5wlpt3cztEeyPN8hvcu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:12:37.9273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcf3a5b-6978-4003-7df8-08df1fce6e09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974

Kernel mode allocation and monitoring associations are maintained on a
per-CPU basis. Extend the kernel mode infrastructure to integrate with
CPU hotplug handling, allowing kernel mode state to be managed as CPUs
enter or leave the online set.

Introduce resctrl_kmode_global_online_cpu() and
resctrl_kmode_global_offline_cpu(), and hook them into the existing
resctrl_online_cpu() and resctrl_offline_cpu() paths.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Update the changelog in non-bugfix form.
    Update the code to remove rdtgroup->kmode.
    Introduce new wrapper resctrl_configure_kmode_global() to consolidate
    architecture calls.

v5: Added resctrl_kmode_offline_cpu() to disable the kernel mode
    association and update kmode_cpu_mask when an associated CPU goes
    offline.
    This addresses sashiko comments:
    https://sashiko.dev/#/patchset/cover.1783461016.git.babu.moger%40amd.com?part=11
    https://sashiko.dev/#/patchset/cover.1783461016.git.babu.moger%40amd.com?part=10
    Also moved the patch earlier than patch 10.
    [RESEND PATCH v4 10/15] fs/resctrl: Reset the kernel mode binding when an rdtgroup is removed
    That seemed much more clear.

v4: New patch in the series. Patch taken from:
    https://lore.kernel.org/lkml/20260611111706.1981788-5-qinyuntan@linux.alibaba.com/
    Updated the code to enable kernel mode by default whenever a CPU comes
    online when one of global-assign mode is enabled.
---
 fs/resctrl/rdtgroup.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 0e638dc654c1..f5c7790f7970 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -410,6 +410,17 @@ static int rdtgroup_kmode_cpus_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static void resctrl_configure_kmode_global(const struct cpumask *mask,
+					   struct rdtgroup *rdtgrp,
+					   bool enable)
+{
+	resctrl_arch_configure_kmode_global(mask, rdtgrp->closid,
+					    resctrl_kmode.ctrl == KMODE_ASSIGN,
+					    rdtgrp->mon.rmid,
+					    resctrl_kmode.mon == KMODE_ASSIGN,
+					    enable);
+}
+
 /*
  * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
  *
@@ -1114,6 +1125,48 @@ static int resctrl_kernel_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/*
+ * resctrl_kmode_global_online_cpu() - Program kernel mode association for @cpu
+ * @cpu: CPU that has just been brought online
+ *
+ * When global_enable_per_cpu is active, @cpu joins that association and is
+ * programmed on.
+ */
+static void resctrl_kmode_global_online_cpu(unsigned int cpu)
+{
+	struct rdtgroup *rdtgrp = resctrl_kmode.rdtgrp;
+
+	if (resctrl_kmode.kmode_cur != RESCTRL_GLOBAL_ENABLE_PER_CPU || !rdtgrp)
+		return;
+
+	cpumask_set_cpu(cpu, &rdtgrp->kmode_cpu_mask);
+
+	resctrl_configure_kmode_global(cpumask_of(cpu), rdtgrp, true);
+}
+
+/*
+ * resctrl_kmode_global_offline_cpu() - Clear kernel mode association for @cpu
+ * @cpu: CPU being taken offline.
+ *
+ * When global_enable_per_cpu is active and @cpu is in kmode_cpu_mask, the
+ * association is disabled on @cpu and @cpu is removed from that mask. A CPU
+ * outside the mask is left unchanged.
+ */
+static void resctrl_kmode_global_offline_cpu(unsigned int cpu)
+{
+	struct rdtgroup *rdtgrp = resctrl_kmode.rdtgrp;
+
+	if (resctrl_kmode.kmode_cur != RESCTRL_GLOBAL_ENABLE_PER_CPU || !rdtgrp)
+		return;
+
+	if (!cpumask_test_cpu(cpu, &rdtgrp->kmode_cpu_mask))
+		return;
+
+	cpumask_clear_cpu(cpu, &rdtgrp->kmode_cpu_mask);
+
+	resctrl_configure_kmode_global(cpumask_of(cpu), rdtgrp, false);
+}
+
 void *rdt_kn_parent_priv(struct kernfs_node *kn)
 {
 	/*
@@ -4896,6 +4949,7 @@ void resctrl_online_cpu(unsigned int cpu)
 	mutex_lock(&rdtgroup_mutex);
 	/* The CPU is set in default rdtgroup after online. */
 	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
+	resctrl_kmode_global_online_cpu(cpu);
 	mutex_unlock(&rdtgroup_mutex);
 }
 
@@ -4939,6 +4993,9 @@ void resctrl_offline_cpu(unsigned int cpu)
 		}
 	}
 
+	/* Clear any active kernel mode association on this CPU. */
+	resctrl_kmode_global_offline_cpu(cpu);
+
 	if (!l3->mon_capable)
 		goto out_unlock;
 
-- 
2.43.0

