Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD34238F635;
	Thu, 12 Mar 2026 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347979; cv=fail; b=LnQyqv8LO8nNRJ2F48C0Ey9tN/vGxV08BGwsCJYkgUS6ndwjUtViSyJzuIntpD2/CKyAEI42evqqHcdJHaIM3j8cYEV2hxv0dTJAdnp1Njqr2rwc92Tx++vyb5zTu9mkGbKG5qOKD5DEt+JaKopk5AHo2sYjZelBGPQrpKj1pKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347979; c=relaxed/simple;
	bh=tOGw8Tn50vbd+rMdlntrVzkX09iDG1Hr8j1WyZWA1g0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwjTEz7y9m2NLggV5KJh/sGiMBuIsxeqOQnPRXFncCh7TZpRU300nMDvDPZpugV5MqBWbLZyBb9V7o9Pd0x+00iGWB0/OsQgVCdt1VKOyJ4bFBQIJWXeksF5tMs5ixtG7ud4OuQTjlu4mNlyyJfWv8n1EsEM1xt02m+a3bu08ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yA6yoSy/; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yA6yoSy/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4VdImZHlWQ/UPoB+v82xNxIcPHnpyXhb0DEXR4BrRv/jKnOgYLLsyb9pKYAQEO4qR6g6YkDM0UCEQG8cWatFv3b1AkmBi0EPv4qDPEYVRwE7QsQnIhKW0rQyFPFCcUeNUqwhZcgJHtguPHV4fWG4Y5Y+9CpEy0AkfUXv1WputdEtIl+hRVTnY7sSvMq1Fxs0g8UTm15W2ZvwFVo3gsDrSehkFuzr6/8bJWpFx3oRkvksKOuHe4X1P50BibuDrfOSKie9sgChKF0pQYX0OWiWlrHVMhLspSOsF2SOTw+qxtwW6mlTCo08QdGzCs5DCgUYCE4VL/KMPARVWUbYjjFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Zki1nSKWAsipsfU1RtyxFlO0b0CQaDiFM0NkK+8ZIM=;
 b=YobGXOg06XqnxwX9WBa0qF5n+5iu8V3Ud6F84DigYrEfyG0FMnAVURhwyUJoAeQIl2oUvGwo1qz5VPf5sqzFJu0i3Iu3oFb5Fy18Fa9iSOj/kep9nqlMix0sQsguUsT7QfvKTm6QL5AbNz2AZncHxKNKsR5HlocLcT+lQJ2olV9BKlWMaCzLLaEDuoHiIMEPK2hzX57hQiNCPoz5OOPs97RbHD9GwKPrXzELsmp/lEJFT8nhDMafgLeYkqJV55Zb1vq3CO3lq1AEbJQIwbIzSoI2b7Pv55ZE/BSyOf4UgJ2RxzE68WJIVM8VhaYt3C1H0hhbkXpVPuNcs1KyAF5usQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Zki1nSKWAsipsfU1RtyxFlO0b0CQaDiFM0NkK+8ZIM=;
 b=yA6yoSy/IqVG5CrG+LYSmPvpPQZb8H34P0LYVaeuEN1enwHV3PPiZVI3UYYWJocQyoQXdOvegjM5FW8dTlzcwwXJxj4BkF9WIWK0zL5CN5hzzNXgEJ1CVLiElTexmMTKaVMNBHghgrgjdZwUZpBKMe+pPSVPg1AD0PIwSLKMULQ=
Received: from SJ0PR13CA0220.namprd13.prod.outlook.com (2603:10b6:a03:2c1::15)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Thu, 12 Mar 2026 20:39:31 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::b2) by SJ0PR13CA0220.outlook.office365.com
 (2603:10b6:a03:2c1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.15 via Frontend Transport; Thu,
 12 Mar 2026 20:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:39:30 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:39:28 -0500
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
Subject: [PATCH v2 16/16] fs/resctrl: Add per-task kmode enable support via rdtgroup
Date: Thu, 12 Mar 2026 15:37:01 -0500
Message-ID: <0e028deb53a81c1c516898fa688e194cd5d2f661.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: b17e3764-b4cc-4c6f-a423-08de80777647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	amCT+8Xq3pn0cswJ5ZWtltj61Sz/cKnhFpWjRpUIXo+qnuRinacO1+Ikyf4h1HFJ9eJR3LYt1OJnmszfPoCG1HpVoqcUMeRmmeyF+Gpvxb/yBpvkUfcwGOGGL3TjO3uERtGoRtvd02MOTLTJaJ6S3wjDNjFmS9PhdGGWG41XkhIkkFy4SwZbj9W3xNlpg/NHdptbbMRKmbyqoC8U60wk7eIVRlV0PobM6kZKT720RRfDiNagDUGYMOl3TgPTK0rVrJ/RSl0u3kKMcVqPbD3tXaHHQK9+87dAv5ACxUZSY1RLWIJEiAkOXn7OBQCyQt5Q9gRsrLD1LJd1ealurTFjdpeoWCp7zBzZ1xWuooeS8T7lPa/wHn7yISGAZQhMqnQ1adFGCivUMboq8+FDUSb4AfNMRHfNkfGp1LtWeTmaVlX+eW/S4eyrNsJ+bQcrHOW8V4X3keNiLoBUgpGUILIAUKziQVKW5vLrlIwDX0ur5lkscnEq4tgOtWpPrI2GeToSW88z9jGf8LoZHQXhvbQldgXmFVX62TRHee8rW47//N7+sAQ5xIK9TfWIZzDzvxccR3b8EoBrPXgG0UaqEgZENRYcxfS9PO1bKb8zoJE17IsQaVWsr3TBFn2EuwKIooUs3mWFM98SrwW6Swc7cjzw0ocoup5azHUtiOjmD4jRxldccqMNW3P78ELVao8YTtAzwZKY+Sk/TDMgbMYlpiWDXhhmUBX0Ctqxpv2yvpjnBw4kAx3Avxa+ODWYAmywCNP1SmzBmkWKUaUd2EUsAuwzWQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DX0O/a/1KElRnDicdxM0R/jpMkoDHV3oR6RKyTeMoqIViV9OxiLuOYe9UPRYHEWjNZVdF6/dItjiXrgFPttryunrKCVGGiCEq9+HFGTnGxuh/kHvjqGdlisNQ6S2KSWTKd9WFQS6qaDVioetCrrEWHwKMRz+zqU0gIWtCL2663ZxRmm0CC7CIuBy+pPHtzVu8qLummGy3jYhMV6H7g4IZJQFj2y5nqVeIUnjJoZnb9HIyyaXjUdI0bjXi4xlV2POf7KNRlSbiget03Sh5LsppgTkBhQA7AWNOEU8e0YTvCmSxFoSTZ2zjlcY0DdsDRkT9NjBfidRK5QWyTQfZIOMwLE4fTeCsrJoF+9HKIVm2M7rLoqB3wU8Sz8fv8B8lD0rSYKS7RSJddGfIR0E8kVKKwPV9DqXKG+wk1/0BG9Rg/mUwa5SCKY6jFiKeQlJyUqK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:39:30.6237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b17e3764-b4cc-4c6f-a423-08de80777647
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892

Introduce support for enabling kmode on a per-task basis through the
resctrl control-group interface.

Add an architecture helper to set the kmode state in the task structure and
extend the rdtgroup task handling path to apply kmode (e.g. PLZA) when
associating a task with a CTRL_MON or MON group.

Proper memory ordering is enforced to ensure that task closid and rmid
updates are visible before determining whether the task is currently
running. If the task is active on a CPU, the relevant MSRs are updated
immediately; otherwise, PLZA state is programmed on the next context
switch.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: Few name changes to refer PLZA as kmode.
---
 arch/x86/include/asm/resctrl.h | 13 +++++
 fs/resctrl/rdtgroup.c          | 98 +++++++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index ccfd95b98bac..f48d1279e33d 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -238,6 +238,19 @@ static inline void resctrl_arch_set_cpu_kmode(int cpu, u32 closid, u32 rmid, u32
 	WRITE_ONCE(per_cpu(pqr_state.kmode_rmid, cpu), rmid);
 }
 
+/**
+ * resctrl_arch_set_task_kmode() - Set per-task kernel mode (e.g. PLZA) flag
+ * @tsk:	Task to update.
+ * @enable:	1 to enable kmode for this task; 0 to disable.
+ *
+ * When enabled, the task will use the group's CLOSID/RMID for kernel mode
+ * on context switch (see __resctrl_sched_in()).
+ */
+static inline void resctrl_arch_set_task_kmode(struct task_struct *tsk, u32 enable)
+{
+	WRITE_ONCE(tsk->kmode, enable);
+}
+
 static inline void resctrl_arch_sched_in(struct task_struct *tsk)
 {
 	if (static_branch_likely(&rdt_enable_key))
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index b41e681f6922..74fc942e6a4e 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -827,6 +827,31 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	return 0;
 }
 
+/**
+ * __rdtgroup_task_kmode() - Enable kernel mode (e.g. PLZA) for a single task
+ * @tsk:	Task to enable kmode for.
+ * @rdtgrp:	Rdtgroup with kmode enabled (used for context; CLOSID/RMID applied on sched-in).
+ *
+ * Sets t->kmode so that the task uses the group's CLOSID/RMID on context
+ * switch. Memory ordering ensures the store is visible before we check if
+ * the task is current (and thus before any sched-in that may observe it).
+ *
+ * Return: 0.
+ */
+static int __rdtgroup_task_kmode(struct task_struct *tsk, struct rdtgroup *rdtgrp)
+{
+	resctrl_arch_set_task_kmode(tsk, true);
+
+	/*
+	 * Order the task's kmode state stores above before the loads in
+	 * task_curr(). This pairs with the full barrier between the
+	 * rq->curr update and resctrl_arch_sched_in() during context switch.
+	 */
+	smp_mb();
+
+	return 0;
+}
+
 static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
 {
 	return (resctrl_arch_alloc_capable() && (r->type == RDTCTRL_GROUP) &&
@@ -916,6 +941,48 @@ static int rdtgroup_move_task(pid_t pid, struct rdtgroup *rdtgrp,
 	return ret;
 }
 
+/**
+ * rdtgroup_task_kmode() - Enable kernel mode for a task added to a kmode group
+ * @pid:	PID of the task (0 for current).
+ * @rdtgrp:	Rdtgroup with kmode enabled.
+ * @of:		kernfs file (for permission check).
+ *
+ * Called when a task is written to the "tasks" file of a group that has
+ * kernel mode enabled. Enables kmode for that task so it uses the group's
+ * CLOSID/RMID on context switch. If the task is currently running, MSRs are
+ * updated on next sched-in.
+ *
+ * Return: 0 on success, or -ESRCH/-EPERM on error.
+ */
+static int rdtgroup_task_kmode(pid_t pid, struct rdtgroup *rdtgrp,
+			       struct kernfs_open_file *of)
+{
+	struct task_struct *tsk;
+	int ret;
+
+	rcu_read_lock();
+	if (pid) {
+		tsk = find_task_by_vpid(pid);
+		if (!tsk) {
+			rcu_read_unlock();
+			rdt_last_cmd_printf("No task %d\n", pid);
+			return -ESRCH;
+		}
+	} else {
+		tsk = current;
+	}
+
+	get_task_struct(tsk);
+	rcu_read_unlock();
+
+	ret = rdtgroup_task_write_permission(tsk, of);
+	if (!ret)
+		ret = __rdtgroup_task_kmode(tsk, rdtgrp);
+
+	put_task_struct(tsk);
+	return ret;
+}
+
 static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off)
 {
@@ -953,7 +1020,11 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 			break;
 		}
 
-		ret = rdtgroup_move_task(pid, rdtgrp, of);
+		/* Group has kmode: set task kmode; else move task CLOSID/RMID. */
+		if (rdtgrp->kmode)
+			ret = rdtgroup_task_kmode(pid, rdtgrp, of);
+		else
+			ret = rdtgroup_move_task(pid, rdtgrp, of);
 		if (ret) {
 			rdt_last_cmd_printf("Error while processing task %d\n", pid);
 			break;
@@ -1011,6 +1082,28 @@ static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
 	rcu_read_unlock();
 }
 
+/**
+ * rdt_task_set_kmode() - Set or clear kmode for all tasks in the rdtgroup
+ * @r:		Rdtgroup (must have r->kmode set for matching).
+ * @kmode:	True to set t->kmode for each matching task; false to clear.
+ *
+ * Walks all tasks that belong to @r (via rdt_task_match) and updates their
+ * per-task kmode flag. Used when enabling or disabling kernel mode for the
+ * group so existing members get the new state.
+ */
+static void rdt_task_set_kmode(struct rdtgroup *r, bool kmode)
+{
+	struct task_struct *p, *t;
+
+	rcu_read_lock();
+	for_each_process_thread(p, t) {
+		if (!rdt_task_match(t, r, r->kmode))
+			continue;
+		resctrl_arch_set_task_kmode(t, kmode);
+	}
+	rcu_read_unlock();
+}
+
 static int rdtgroup_tasks_show(struct kernfs_open_file *of,
 			       struct seq_file *s, void *v)
 {
@@ -1225,6 +1318,9 @@ static int rdtgroup_config_kmode(struct rdtgroup *rdtgrp, bool enable)
 
 	resctrl_arch_set_kmode(&rdtgrp->cpu_mask, &resctrl_kcfg, closid,
 			       rdtgrp->mon.rmid, enable);
+
+	rdt_task_set_kmode(rdtgrp, enable);
+
 	rdtgrp->kmode = enable;
 	if (enable)
 		resctrl_kcfg.k_rdtgrp = rdtgrp;
-- 
2.43.0

