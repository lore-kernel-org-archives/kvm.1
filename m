Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC94F37B013;
	Thu, 12 Mar 2026 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347862; cv=fail; b=rh9fJ/yZMuhNZCXyW3BTd/f9Li7sF1uS50gISYrp7NZC7GxYa+nes4dJsfhJCP8xq1TjIADkJCT07wXeIZpSrvkTgs+VvqXFXejCwqNYWFOz8QdETgQKyAc5vpgvOeF3TpTKSK31rF4D+jctJf8fWp5QDr6geoC1Ep6f4nJDRpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347862; c=relaxed/simple;
	bh=lQlHA+tYh7aB5m63qTcRxiidIQ47742oAA4LEVqTU7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ud63tJDed6/xKoZB8QEB7eZDGH9NZKuxQfLpqUJkrXWeBWAtn4WV+HZSq451zf1dMqirQm+SSXPe2hJ6i0iB/KvAu5fyKYhc+eMk+DFgkAp65+7FSSY4OUaHPYkHmuUKzqCghEZcKmnLymz+kJgYGdFYwpqvc7W9U2Qqlu9GxxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l7jYldmr; arc=fail smtp.client-ip=52.101.53.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l7jYldmr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG90va/cuFWGd3/uPKYz1Dw6+CX369vWQCy5e33vu4339IIoW4WfxVEwNL4rS5nK+1RSHoE9pupezofTnZ0AST5ITMlSr0DRxgSwCqIq3iWC8IH1kmSKckLF93tFiCgL59J+jHlDh1KFpku+4PagVH726+0tVoGLnIHRUCN3xyHcjajJhn5k9u1fyE1f6X+fQT03Xt8NuLnzByBhdGIJYKgK0FvLRwWZ25TkLOG7qnvPNPjrZicjOKp7TS9XOqOfwYysrMTf5fvI1+Cok8zb7S28LkWpHlQuJxE6sd8uYNjbijQGwXQ+EaTJAmba6PW+RYjgvTqdVH6xMQ6PquXGCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4Zuz4ABXU7O82CH0BPJ1azoN0PWrBLZeoKDLzfGPWo=;
 b=EOudl9ybAAFmbPwr/LVJpUaiAIzuRH0LnBA7s2ZTURPLzAKmG9vH2FLfUWhKsjsdW5HH6Xd63qds9e3SKSn3FUNUilEY4FAhNgJhxeDRGF42fiIOGdkrF8cmrZm9M7U6OZKEdi0kgcDdNhRhU/8vEILEOAtEUuvfB83MGCp1cHpoCmQP4cDpZ+V2SxctNuSZad0Vs/59THLV8C99dZr49hW6W4WcHOYVwo+XlAGk1LpqMhe2LlAgfABIA1FSrYr15MmwfsX9fQvAdbhN01mlgRJmMOx0h0+eI7s58YzMlosYO+I09XQqu1Fr8Y6MksKnSd2w6VT5k6ar2M358X5o3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4Zuz4ABXU7O82CH0BPJ1azoN0PWrBLZeoKDLzfGPWo=;
 b=l7jYldmrxI9KpH45fRtqtWLbV80w4ROXOYes2KPdXWZuq5BJRw+6bwenaxRif86eoYnogbS25TybRuW8qS0eB1cGBJ/rJwaOLkOQguWH19AEZumsgubbkgITTPRQhgtq3KKS0LIXKFOAlG6a/vxMpfkwzY4Byx0Ui0hcq5ksWCI=
Received: from BY3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:a03:254::25)
 by SA5PPFE91247D15.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 20:37:32 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::be) by BY3PR05CA0020.outlook.office365.com
 (2603:10b6:a03:254::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Thu,
 12 Mar 2026 20:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:37:31 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:37:29 -0500
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
Subject: [PATCH v2 02/16] fs, x86/resctrl: Add architecture routines for kernel mode initialization
Date: Thu, 12 Mar 2026 15:36:47 -0500
Message-ID: <72315f83ddf35b0de53fb911f46623782d95f507.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SA5PPFE91247D15:EE_
X-MS-Office365-Filtering-Correlation-Id: 8462bf6e-63f6-450c-7d5b-08de80772f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xrC5lDuK0PV5vXFYRMtyNBz9k1MPi+irTTqoa82NUZXhEB0gg/PRpjCPWn7l8l8nF3wSP9C3ncyzbO/3mq0bLRMHVfjkJrBYMPDX4f8MMYblsP1NK4yUP6bPqR4hAxGJ6+fjtrSNVN96iQfvt4/M52vBUyJC3Pn0NhnZFuOmCPyAQocAnSrWZw7S3Bjrf3dQRXmW2s7RENa5KFqIG9CmPy55Fuu6/lLYI/Ad+OpBaw47p/8e6o/KkmrSv/VtOVQWYV6CzeZ5jlqOlmvKRi3l6EUkB+q0sWLZyAvuoF3X+pqSQtAkLWNJfMQjmmttkiwcudcKmebLjzREhIoBMJgDiztEM6oH0ZwE+f+L5aCqD1T+HfEOtsSyv250TCFN65oiS0lAbEsroppZtm9+9YBLAkI9q01qNhWyGmlOb5frHw98fSjPffMCZm/5YaN+xGf6xGSTsUoO2jgOnBhy+42KCQkiMuqIhQBzZdF9c8k2lXy4jBFSOFgXb3rODPlFsd2ErYCjfzAoDpi0RvDEMMs6qEUEFWDdXjc7k1JIBmappzolSkS5vPnV9J/bGT4MOhe03BOVAXBuvQLkeugHqWXh+jfLDotwp1+YEsBP7Olsj1IRCfPV6RfNvOxTnwfxPov9AyvqdEVA5z3bMes2F9tIGD83+QmnJs+qpNRHheK8hIkoOvwwgzCP1oAf/mPsS8TsQmtXivY/2JLYwBdPr3UjyhWNA6Nhz0vKIj7VIaL+d7g=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BZGcBKJumsMMGjdd4Ko38Tfe+KNJbRNgEix3ld98q2z4EzxYX+woCyCCUStxQPaEXXixyYzX7B8YBMM73ilwQYIvjHS0uTWkFXHSyKwDzuXJMh9yvgINjw7pQxaUaK8oeEOpZ9NTH2L0o9Iu0KK1fzXSiGHj6yLki5/2To/ykeeFcLchNhWaEUvgaKob0rMxd+391ubc2pYGoCqd/Jig985CnRSklKGNzXaEK30ct5VaDthaVcUyauCyS3yFMoLKVLI+GqUM/Ft4EYbCvawINECkV7RJHztznJaB0vxkAImLcidKcBgQnD5MUvMIllNcPY5jwwKmzn/FIH4Oz1qfa/7nh70WCm4u6punE/6gzx2DIHc18UKxKs7Gqk5980hU+1BivNgwjX0HyGw8JtYT4j0bTsOXzbrU0ZlhnM6Z4bsyEV9/k7GTTeWFfFKlac4D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:37:31.8793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8462bf6e-63f6-450c-7d5b-08de80772f88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE91247D15

Implement the resctrl kernel mode (kmode) arch initialization.

- Add resctrl_arch_get_kmode_cfg() to fill the default kernel mode
  (INHERIT_CTRL_AND_MON). This can be extended later (e.g. for PLZA) to set
  additional modes.

- Add global resctrl_kcfg and resctrl_kmode_init() to initialize default
  values.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: New patch to handle PLZA interfaces with /sys/fs/resctrl/info/ directory.
    https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
---
 arch/x86/kernel/cpu/resctrl/core.c |  7 +++++++
 fs/resctrl/rdtgroup.c              | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 7667cf7c4e94..4c3ab2d93909 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -892,6 +892,13 @@ bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
 	}
 }
 
+void resctrl_arch_get_kmode_cfg(struct resctrl_kmode_cfg *kcfg)
+{
+	kcfg->kmode = INHERIT_CTRL_AND_MON;
+	kcfg->kmode_cur = INHERIT_CTRL_AND_MON;
+	kcfg->k_rdtgrp = NULL;
+}
+
 static __init bool get_mem_config(void)
 {
 	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_MBA];
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 5da305bd36c9..9d6d74af4874 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -76,6 +76,9 @@ static void rdtgroup_destroy_root(void);
 
 struct dentry *debugfs_resctrl;
 
+/* Current resctrl kernel mode config (kmode, kmode_cur, k_rdtgrp). */
+struct resctrl_kmode_cfg resctrl_kcfg;
+
 /*
  * Memory bandwidth monitoring event to use for the default CTRL_MON group
  * and each new CTRL_MON group created by the user.  Only relevant when
@@ -2204,6 +2207,11 @@ static void io_alloc_init(void)
 	}
 }
 
+static void resctrl_kmode_init(void)
+{
+	resctrl_arch_get_kmode_cfg(&resctrl_kcfg);
+}
+
 void resctrl_file_fflags_init(const char *config, unsigned long fflags)
 {
 	struct rftype *rft;
@@ -4554,6 +4562,8 @@ int resctrl_init(void)
 
 	io_alloc_init();
 
+	resctrl_kmode_init();
+
 	ret = resctrl_l3_mon_resource_init();
 	if (ret)
 		return ret;
-- 
2.43.0

