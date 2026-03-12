Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E6E374162;
	Thu, 12 Mar 2026 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347939; cv=fail; b=B6F2kGphg5l/9gUdrHahJQ91TwEWK5zxlFbnEl0QP7XRKaJrV8ZvRbEIhqRDvdYSMYL3RE4vY739BNBQR5SsuSMcgHdl4XEhoXkcdhOQzFd+7Nm5oAe7x8GxgLRZqJybnNoUX20xcygaAWGp9teVKLm3AOnNYsljroMDFdOiPi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347939; c=relaxed/simple;
	bh=byfkoMfdThkgLlMqD5yWyyERF9V1W/rjnPRL7RVqL4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLEfwms0gQ7PR4cgmL5B2kb4ZYUAvdKnA16sSug62g5iOZHMAYNz8YTIs8nT7ikQ2qCXdETLGpXMql2ijChLrh62qI4rTXK5KC5BQHRxj3sWD7/5vg5SyfiOQ0/qm4QIXl0IhZasIuUXraFbvFwkYP9JOiyW7IN4ZDvamoQuxqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G2LitSch; arc=fail smtp.client-ip=52.101.46.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G2LitSch"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7DOGitCemonroXlu6yZG6TUxwYNjU/Zgz7OeCZ8oeYqdwHZXuihXWtgUX2H9cOYudzmChtSM4Gka9hJPP36kZm3cO1ebqhMlvwBARGgvNfMx5Ig8E7xf/xOfZiKD0o9NLQgJmioH9nFNjzmjPcn6K/3UbnlDV2r7z0n3UiKnQlm9s+KFZbrkq7LdLarOrOq2wv6wILYuONOWtdrurgXiNwaqcE83SFS69SROTrAazTJ0hcL0mrzFLH1019QVknTVYKUrc6WtBtvO0joLyAxaL5JMSkR6X8lelnVWXz4PTlt4LtpRLMQiEJIaQxrDXMOzEs6bXm+SNwq/UkyEwsmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4x3iomhI1/T6l6KqKO84DrAMGB0518CCwUXBD8DfCQI=;
 b=fjfLB/JDWIxs6tpQkN7q/lyNkZxiOTLbzbSkOrWALFsieFBj1+5vN7239QAm6HJzVfp+vEIUVHH2SWi+lPI0t2AMwys6Uy/9u1N2os2aj3zFZ3VmG2MQgnv/NOq347ZzSomZcIctGmi4uJFlFleA2MogUBZlBPp66VdPuImx/Ua2ftc1NQQsaQpdsp4v5FAlefWDT3y2YQdIs2Q4bQ+A/tOjEsdPi8EbhoaalI6I/5NFLD4aOsCJq9kC7puRzKczkuQAybZCKusvb4WqdMcwA9R2iCuT4ftu7rbtOhWeSVdhzlamoJXw8pFrjrm6FSv1EBcCg3j47lGkn2VBKCCNug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x3iomhI1/T6l6KqKO84DrAMGB0518CCwUXBD8DfCQI=;
 b=G2LitSchL6GioWv4NR8T6A/u5hdTgyjLG8izHOazSDcjEycOg6K8MC3QzwuOjv/seEV8gnLU++vyNtzyyXgUnWLNAsM3cpOtcDqB4yi/brXCaLKb/NB5yzmoQWXwedoayMxlMb0gu6jfxsjGEszR3EWqm1LVbMdm93hxjbuv82w=
Received: from BY3PR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:39b::13)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 20:38:50 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::8e) by BY3PR05CA0038.outlook.office365.com
 (2603:10b6:a03:39b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Thu,
 12 Mar 2026 20:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:38:50 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:38:47 -0500
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
Subject: [PATCH v2 11/16] fs/resctrl: Add write handler for info/kernel_mode
Date: Thu, 12 Mar 2026 15:36:56 -0500
Message-ID: <6cc46ecf2a9ba759cd4de12bed3e9b898468d976.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb7985d-13a4-441b-85b1-08de80775e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|18082099003|22082099003|56012099003|18092099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Wbm867VqgpcJbAYMxfj9jsmrhE7uRz2zW9QEuOGZKpsTHPGjn57SFB/MXCnIYnFnHhzH3IT1xFoVGA2/qCT4aUV6Lurs8YpsJIeGxHK7pIgXf0t4ljkIwSw5emIwNeJ8WVnoUZ5DbjGPboxr0DowqrVtVGowJ/XxCAL/aJ2JgfZi3hjJUf2U/pCIF+XPYdlExZUR98DeJSuVXMEK/DTASblf+Y5MSqeUiJP0+i/pDjeZkBnJGBZU5slPe5tAqlcFsBDj1rlAgOuRoj9sXlbJ6YHTo38CkUajLtABxQrwQA0Rk7CBQ5FXLNEug7dRaIMXFyz2UANxAAGTR2S2i9jZFwkHGrASZiutyEgEXJ4FUs41owH/Y2+wPTMV8+YtLYpneAUBU6lDUdkxSuhZU9mmZnmk7DGGUWC3hzKztPts1+kbIduhceqGV1wtdealLx9G940nd2z9pd6r0AoGK/OiZRk1o2XqF5L9ed7FQ5tjBtPrVW1eEo07TMz6m4rFVTE72lTKZ0bF+Nows04AT+fizXRijN3CsIc5tDEbsOnlYrOSnGV8VamFT69CicIHl6TGy/CfDf4Hz1rNpenIU2S7cRZBhtH/ExMb4TeQOn83lNb4d+sR+UuoejlIjbxksC+WZiS7ohD7EDUkzOt6y5BcciGyK6Yn2675HpZXzULObmEkrJkfuhXANLd3s/rk8qr/lxKG7RSo5U//BD9NqjGH2lJfGR0aBxuy6qCJy4mIQdv3dBW/r+qfRfGnsnovIaJNHzFGAjOTf6bm0FO0n7Levg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(18082099003)(22082099003)(56012099003)(18092099006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J8nr6Kprt41qLDovbgEvKQBaRab01RzKCISuovKqFh27FG8wmmTSbK650g+fdFBgePTqfQeTMWH9U0xwiQV/H4t80mrqG043xovj2iV4D8h22GHYfh6mF2AmbUN5joz6pgJs/XZVmE5op/r3+MS7rBjPTJq//EyUx/W8AiHJaw6laKOMYo+c9rxStqRL1cxJM1khDLT/IzqmFjUyUMmKI2JuhDRtMZ2Z9qLBNtgepCfgbHrJ7kw5OsrjUV5EtFejfeHIH3SQqtBXX48xrs91I4OXnyTnZ4/fPIw83HehG+OWNewtmYfLxGdMpVH1ltcq13eIyNV9vL9vztABv8IjT1530jT9egGEomoqmtG4+1akk6lRbbLoYe/nPbrQTZKDe9Er9v0QET9vjLpgcspHK0GRexi66s9aXQXaOTwuKifFKqYa64CMYByLfSxML724
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:38:50.0948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb7985d-13a4-441b-85b1-08de80775e27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255

Add resctrl_kernel_mode_write() so users can set the current kernel
mode by writing a mode name to info/kernel_mode. Unsupported or invalid
names are rejected; errors are reported in info/last_cmd_status.

Add rdtgroup_config_kmode() to assign or clear a group for kernel mode
(e.g. PLZA), and extend struct rdtgroup with a kmode flag. Update
Documentation/filesystems/resctrl.rst to describe the kernel_mode file.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: New patch to handle PLZA interfaces with /sys/fs/resctrl/info/ directory.
    https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
---
 Documentation/filesystems/resctrl.rst |  34 +++++++++
 fs/resctrl/internal.h                 |   2 +
 fs/resctrl/rdtgroup.c                 | 101 +++++++++++++++++++++++++-
 3 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index ba609f8d4de5..2107dd4b3649 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -514,6 +514,40 @@ conveyed in the error returns from file operations. E.g.
 	# cat info/last_cmd_status
 	mask f7 has non-consecutive 1-bits
 
+"kernel_mode":
+	In the top level of the "info" directory, "kernel_mode" controls how
+	resource allocation and monitoring work in kernel mode. This is used on
+	some platforms to assign a dedicated CLOSID and/or RMID to kernel threads.
+
+	Reading the file lists supported kernel modes, one per line. The
+	currently active mode is shown in square brackets; other modes supported
+	by the platform are shown without brackets. Example::
+
+	  # cat info/kernel_mode
+	  [inherit_ctrl_and_mon]
+	  global_assign_ctrl_inherit_mon
+	  global_assign_ctrl_assign_mon
+
+	Writing a mode name (followed by a newline) sets the current kernel mode.
+	The name must match one of the supported mode names exactly. Modes not
+	supported by the platform (e.g. not advertised when reading the file)
+	cannot be set. Errors are reported in "info/last_cmd_status". Example::
+
+	  # echo "global_assign_ctrl_assign_mon" > info/kernel_mode
+	  # cat info/kernel_mode
+	  inherit_ctrl_and_mon
+	  global_assign_ctrl_inherit_mon
+	  [global_assign_ctrl_assign_mon]
+
+	Modes:
+
+	- "inherit_ctrl_and_mon": Kernel uses the same CLOSID and RMID as the
+	  current user-space task (default).
+	- "global_assign_ctrl_inherit_mon": One CLOSID is assigned for all
+	  kernel work; RMID is still inherited from user space.
+	- "global_assign_ctrl_assign_mon": One resource group (CLOSID and RMID)
+	  is assigned for all kernel work.
+
 Resource alloc and monitor groups
 =================================
 
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 1a9b29119f88..b5999d8079d6 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -216,6 +216,7 @@ struct mongroup {
  * @mon:			mongroup related data
  * @mode:			mode of resource group
  * @mba_mbps_event:		input monitoring event id when mba_sc is enabled
+ * @kmode:			true if this group is assigned for kernel mode (e.g. PLZA)
  * @plr:			pseudo-locked region
  */
 struct rdtgroup {
@@ -229,6 +230,7 @@ struct rdtgroup {
 	struct mongroup			mon;
 	enum rdtgrp_mode		mode;
 	enum resctrl_event_id		mba_mbps_event;
+	bool				kmode;
 	struct pseudo_lock_region	*plr;
 };
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index bb775afc78f5..6cd928fabaa2 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1019,6 +1019,104 @@ static int resctrl_kernel_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/**
+ * rdtgroup_config_kmode() - Enable or disable kernel mode (e.g. PLZA) for a group
+ * @rdtgrp:	The rdtgroup to assign or unassign for kernel work.
+ * @enable:	True to assign this group for kernel mode; false to clear.
+ *
+ * Programs arch state via resctrl_arch_configure_kmode() and
+ * resctrl_arch_set_kmode(), and updates resctrl_kcfg.k_rdtgrp. Only one group
+ * may have kmode at a time. Pseudo-locked groups cannot be used for kernel mode.
+ *
+ * Return: 0 on success, or -EINVAL if the group is pseudo-locked.
+ */
+static int rdtgroup_config_kmode(struct rdtgroup *rdtgrp, bool enable)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	u32 closid;
+
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
+		rdt_last_cmd_puts("Resource group is pseudo-locked\n");
+		return -EINVAL;
+	}
+
+	if (rdtgrp->type == RDTMON_GROUP)
+		closid = rdtgrp->mon.parent->closid;
+	else
+		closid = rdtgrp->closid;
+
+	resctrl_arch_configure_kmode(r, &resctrl_kcfg, closid, rdtgrp->mon.rmid);
+
+	resctrl_arch_set_kmode(&rdtgrp->cpu_mask, &resctrl_kcfg, closid,
+			       rdtgrp->mon.rmid, enable);
+	rdtgrp->kmode = enable;
+	if (enable)
+		resctrl_kcfg.k_rdtgrp = rdtgrp;
+	else
+		resctrl_kcfg.k_rdtgrp = NULL;
+
+	return 0;
+}
+
+/**
+ * resctrl_kernel_mode_write() - Set current kernel mode via info/kernel_mode
+ * @of:	kernfs file handle.
+ * @buf:	Mode name string (e.g. "inherit_ctrl_and_mon"); must end with newline.
+ * @nbytes:	Length of buf.
+ * @off:	File offset (unused).
+ *
+ * Accepts one of the names in kmodes[]. The mode must be supported by the
+ * platform (resctrl_kcfg.kmode). On success updates resctrl_kcfg.kmode_cur.
+ * Errors are reported in last_cmd_status.
+ *
+ * Return: nbytes on success, or -EINVAL with last_cmd_status set on error.
+ */
+static ssize_t resctrl_kernel_mode_write(struct kernfs_open_file *of,
+					 char *buf, size_t nbytes, loff_t off)
+{
+	int ret = 0;
+	u32 kmode;
+	int i;
+
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+	buf[nbytes - 1] = '\0';
+
+	mutex_lock(&rdtgroup_mutex);
+	rdt_last_cmd_clear();
+
+	for (i = 0; i < RESCTRL_KERNEL_MODES_NUM; i++) {
+		if (strcmp(buf, kmodes[i].name) != 0)
+			continue;
+		/* Mode name matched; reject if not supported by this platform. */
+		if (!(resctrl_kcfg.kmode & kmodes[i].val)) {
+			rdt_last_cmd_puts("Kernel mode not available\n");
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+		if (resctrl_kcfg.kmode_cur != kmodes[i].val) {
+			kmode = resctrl_kcfg.kmode_cur;
+			resctrl_kcfg.kmode_cur = kmodes[i].val;
+			if (resctrl_kcfg.k_rdtgrp) {
+				ret = rdtgroup_config_kmode(resctrl_kcfg.k_rdtgrp, true);
+				if (ret) {
+					/* Revert to the previous mode. */
+					resctrl_kcfg.kmode_cur = kmode;
+					rdt_last_cmd_puts("Kernel mode change failed\n");
+				}
+			}
+			goto out_unlock;
+		}
+	}
+
+	rdt_last_cmd_puts("Unknown or unsupported kernel mode\n");
+	ret = -EINVAL;
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	return ret ?: nbytes;
+}
+
 void *rdt_kn_parent_priv(struct kernfs_node *kn)
 {
 	/*
@@ -1922,9 +2020,10 @@ static struct rftype res_common_files[] = {
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

