Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717973815C8;
	Thu, 12 Mar 2026 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347955; cv=fail; b=ck6+UtYfLRdawBzUvFhCES8eDbxZksqb2XjzIukTf0nYrCA3DOPpIakMp1GVbSSffH1MrBDf4G2lZ3rwvYsaq3hnJdyjgNSppd8FhUmBHftAa0SzSPQDRWuGr08gLNlCou4K6YpemDDO/eISHHV6EghX6958AxW0uiGYhOCutoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347955; c=relaxed/simple;
	bh=3TXPqGLH9Zn/JJSKcY+FcPEf32QkfiUV8qllZw2SqHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EaoT5snE/yWGoHzfaTkFJcOcPVxBErVDEqKUDOrmGhBpGcAZroEs5DHFCCT7xdGcnFO9i56q5s2TucI1L6etq6+CSc+X7kfgkIi9FepLl86goKL2HgcbUh8NmzANcWrkPJRsrlE6bUj4WEkwztuvjw3krmU+KzsciffCO9zr42w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rLJT8ryF; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rLJT8ryF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAwnKx+/Re/6PTYDO1b0hEPC5V1N73JLSBRYFdx1DKQMuOrN+tiOpwbgOqm4dbK+YbwEEFqDBerSxjw6+Xbbm8MX17I3YzVFZTg7VleFRdWxA7dDi+cKwzPtlvQRnXgSxwi+/NsXpOx307jj6HCLAeMxhtRspeSjzSht+77AoJYfaR8SOsDuS3smdNz0DUTmOZzmOswv2N+P2TC81y7DbIS0kZuRmfEmxQjxc1kT0fehI94RSob48fkAjvovSp2CcB0sxmxDOQWKnkEUN1+lTtprOyBAb869+k0NPibcpJLdDvJ2636nEfQwaFXUzF2amW4ut5PkR7jH1IRBc3LTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7K9UVqiyRhAph9qkyuWelvqCrz7HraGUGEf+6LQy7o=;
 b=me4SMUfjIuZqtqE6symoHX4t3UMwqutSAKOOg6f3yEbCLCXF1yJ7S+39OQu90TR6V7iex/B4hilct5zOuXRXYEjVSfKksAneaG/tvAKXj2TUI+wSpF6lLtwUbqokuSc4PLazwp3hhHZVVh+uN4UQ5sQ2UeNkOBSyk2GnWZJuBcWmG/+lAnFTAqHGxHFN7EwmIzGo6OgGiwoeFXVzF2AAKvlaFSrOTZ8tPORf5/RKRp/qVRI8wqD4kBnyaU0leGqflSe0azb303wqn2hFrErf1pD/fQnBODUBnwZDuZcmh7t42BgU/9D+qAm6hwYV3f2goAgxJ05BPRhdux6m/yk6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7K9UVqiyRhAph9qkyuWelvqCrz7HraGUGEf+6LQy7o=;
 b=rLJT8ryFex0btsg/qV+ByekGAdADfYtFqVbjmqk22HaM6gPb45MCt2pzOtXX2/QNYQ512m9Hckgr+rAu0tFK5Oaj3ncG1fHSYNRwNzvmWOstI0pTzX0YAphCOSq1S1KbLG/x7pVvJpDxR0uoYKMmLBbodUoQ7kPQtFJraZRLg58=
Received: from BY3PR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:39b::27)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13; Thu, 12 Mar
 2026 20:39:06 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::bd) by BY3PR05CA0052.outlook.office365.com
 (2603:10b6:a03:39b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.8 via Frontend Transport; Thu,
 12 Mar 2026 20:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:39:06 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:39:04 -0500
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
Subject: [PATCH v2 13/16] fs/resctrl: Add write interface for kernel_mode_assignment
Date: Thu, 12 Mar 2026 15:36:58 -0500
Message-ID: <78de0d6f1f00a44ae99318cf8458fe9b2238c80c.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: c45d870f-df3b-4eef-d19c-08de807767ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|13003099007|7142099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xMZ6pzcuKAyxI/4SQMKHz0fwsw1sckqGGFlTNEoInfUw+p/0e+xoFtFzT1rJZjgA3JTFqIHn/S0lvFee2gjGxITMBPDt6qaheF9GvAEhwx6u2ZNVAIL+05+vX1h/gRlX9tlcsx/Lkb17Qq38+UweCuK2FWygRQmq2FbWgNVSgBOYhtERQFvMB8DpUszVxEzEpGYZdkRSqbH2YMppqPihA0YH9O4P1LLV96qDbjQcvuL2xHsaAxIKJJsd0FOW0wwbUr1uu4qG/C06jn/G89erycmmA0QAb4MOx5+dG3RGW7F6fhGPx3KBImHK8FUcofBBGX8vxzDAblluppx2+SbDWVJFvqZrhQ0l9pXt73iJneNxH5sskiT+S9gB/B3gGsgsnBQR5JVUjDB3BsY+eprxC+ZiGdU+8uP2FZODz7DepLptXE7XlXZXU2Lm3LuebNhN7lETnD8lkZ5/1mgxyEBtt81epTh7pz8RX8TV1dqVUsbyjcLJ3//6lqVn2HcXKp0UjmXLlRZPJByzMb0+kTyFPFr9G/Ra/HC/1c3fGSiyKRDbsklVUv3ZonuK6qNiU/DBeCRyyFKjdbMud5tTyFuj7eOkcDMuqCCl4PE8uaCz/IyI1xwFN3Qv48oTzB2SuAA1MQiRFrKU7fCUEE9DSJs232s525iUu8xyu233CbsEeVfQmPcO2NscXHlYd+NSUp17u7tqsHPxHgN4fXolbC2KmXlbZZmxBqrTn20FZdzSKktIXHGeo2X1ARabnXudXZExWGzvC8g2dabJGcrcvpFW2Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(13003099007)(7142099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DSAzVF8PfOtwD7AQvU/e9gIrTY7n2e5gL9+R+U5bKP8isWUaR3peQtuXf4YzouVh/lw7xpgNACEI7pKChifcXLdpS7YWvP8so8xURHLpgqUUiYSEj84iu3VoiDg05EZ2yavCbwshWWCjIKLmNkjalEwok2k+dtXLIJgiFKJCbMNgwmAm3exPH2DNCG8d8UTY3wPHcKNdru2ARisIK31XS+TCOM2DKP6cxUEyk/WxYSG4HlGPQbCkppO+5/eY9G95KoZftSOug9toNmDDBEV5jglMaaPwfPAEDUQNsv9pFooj3PENNxdnQeCLIXTvxWe/VVEdfvjZgBQny9LfWJt+wncr3XFnufUsA7C9juNeaXuj0q+Av0/5RYlHMklggGyBxYMJNjDd4uSsTAEn8CVFA7AuwmvyS4EPlK31H/1iO/qp9LuSuy8gcOEZ/HN+Po5v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:39:06.5325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c45d870f-df3b-4eef-d19c-08de807767ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338

Allow enabling kernel mode assignment (PLZA) for resctrl groups via the
kernel_mode_assignment sysfs file. Add a kmode flag to struct rdtgroup to
track the state, enforce that only one group has PLZA at a time, and clear
kmode when groups are removed or during rmdir_all_sub teardown.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: New patch to handle PLZA interfaces with /sys/fs/resctrl/info/ directory.
    https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
---
 Documentation/filesystems/resctrl.rst |  35 ++++++
 fs/resctrl/rdtgroup.c                 | 148 +++++++++++++++++++++++++-
 2 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 2107dd4b3649..2b4beedd7207 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -548,6 +548,41 @@ conveyed in the error returns from file operations. E.g.
 	- "global_assign_ctrl_assign_mon": One resource group (CLOSID and RMID)
 	  is assigned for all kernel work.
 
+"kernel_mode_assignment":
+	In the top level of the "info" directory, "kernel_mode_assignment" shows
+	and (when a global-assign kernel mode is active) sets which resctrl group
+	is used for kernel mode. It is only relevant when "kernel_mode" is not
+        "inherit_ctrl_and_mon".
+
+	Reading the file shows the currently assigned group in the form
+	"CTRL_MON/MON/" with a newline::
+
+	  # cat info/kernel_mode_assignment
+	  //
+
+	Possible read formats:
+
+	- "//": Default CTRL_MON group is assigned.
+	- "ctrl_name//": A CTRL_MON group named "ctrl_name" is assigned.
+	- "/mon_name/": A MON group named "mon_name" under the default CTRL_MON
+	  group is assigned.
+	- "ctrl_name/mon_name/": A MON group named "mon_name" under the CTRL_MON
+	  group "ctrl_name" is assigned.
+	- "Kmode is not configured": No group is assigned for kernel mode.
+
+	Writing assigns a group for kernel mode. The write is only allowed when
+	the current kernel mode is not "inherit_ctrl_and_mon". Input format is
+	one or more lines, each of the form "CTRL_MON/MON/" (same as the read
+	format). Examples::
+
+	  # echo "//" > info/kernel_mode_assignment
+	  # echo "mydir//" > info/kernel_mode_assignment
+	  # echo "mydir/mon1/" > info/kernel_mode_assignment
+
+	An empty write (e.g. ``echo >> info/kernel_mode_assignment``) clears the
+	assignment. Only one group can be assigned at a time. Pseudo-locked
+	groups cannot be assigned. Errors are reported in "info/last_cmd_status".
+
 Resource alloc and monitor groups
 =================================
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index c2d6d1995dff..23e610d59111 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1156,6 +1156,137 @@ static int resctrl_kernel_mode_assignment_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/**
+ * rdtgroup_find_grp_by_name() - Find an rdtgroup by type and parent/child names
+ * @rtype:	RDTCTRL_GROUP or RDTMON_GROUP.
+ * @p_grp:	Parent CTRL_MON group name, or "" for the default group.
+ * @c_grp:	Child MON group name (only used when rtype is RDTMON_GROUP).
+ *
+ * Return: The rdtgroup, or NULL if not found.
+ */
+static struct rdtgroup *rdtgroup_find_grp_by_name(enum rdt_group_type rtype,
+						  char *p_grp, char *c_grp)
+{
+	struct rdtgroup *rdtg, *crg;
+
+	if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
+		return &rdtgroup_default;
+	} else if (rtype == RDTCTRL_GROUP) {
+		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
+			if (rdtg->type == RDTCTRL_GROUP && !strcmp(p_grp, rdtg->kn->name))
+				return rdtg;
+	} else if (rtype == RDTMON_GROUP) {
+		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
+			if (rdtg->type == RDTCTRL_GROUP && !strcmp(p_grp, rdtg->kn->name)) {
+				list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
+						    mon.crdtgrp_list) {
+					if (!strcmp(c_grp, crg->kn->name))
+						return crg;
+				}
+			}
+		}
+	}
+
+	return NULL;
+}
+
+/**
+ * resctrl_kernel_mode_assignment_write() - Set rdtgroup for kernel mode via info file
+ * @of:	kernfs file handle.
+ * @buf:	Input: "CTRL_MON/MON/" per line (e.g. "//" for default,
+ *		"ctrl1//" or "ctrl1/mon1/"); empty string clears the assignment.
+ * @nbytes:	Length of buf.
+ * @off:	File offset (unused).
+ *
+ * Only valid when kernel mode is not inherit_ctrl_and_mon. Empty write clears
+ * the current assignment. Parses lines as "parent/child/"; empty child means
+ * CTRL_MON group. Errors are reported in last_cmd_status.
+ *
+ * Return: nbytes on success, or -EINVAL with last_cmd_status set on error.
+ */
+static ssize_t resctrl_kernel_mode_assignment_write(struct kernfs_open_file *of,
+						    char *buf, size_t nbytes, loff_t off)
+{
+	struct rdtgroup *rdtgrp;
+	char *token, *cmon_grp, *mon_grp;
+	enum rdt_group_type rtype;
+	int ret = 0;
+
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+	buf[nbytes - 1] = '\0';
+	buf = strim(buf);
+
+	mutex_lock(&rdtgroup_mutex);
+	rdt_last_cmd_clear();
+
+	if (resctrl_kcfg.kmode_cur & INHERIT_CTRL_AND_MON) {
+		rdt_last_cmd_puts("Cannot change kmode in inherit_ctrl_and_mon\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/*
+	 * Group can be deleted from Kmode by empty write: e.g.
+	 * "echo >> /sys/fs/resctrl/info/kernel_mode_assignment"
+	 */
+	if (*buf == '\0') {
+		if (resctrl_kcfg.k_rdtgrp) {
+			ret = rdtgroup_config_kmode(resctrl_kcfg.k_rdtgrp, false);
+			if (ret)
+				rdt_last_cmd_printf("Kernel mode disable failed on group %s\n",
+						    rdt_kn_name(resctrl_kcfg.k_rdtgrp->kn));
+		}
+		goto out_unlock;
+	}
+
+	/* Only one group can be assigned for kernel mode at a time. */
+	if (resctrl_kcfg.k_rdtgrp) {
+		rdt_last_cmd_printf("Kernel mode already configured on group %s\n",
+				    rdt_kn_name(resctrl_kcfg.k_rdtgrp->kn));
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	while ((token = strsep(&buf, "\n")) != NULL) {
+		/*
+		 * Each line has the format "<CTRL_MON group>/<MON group>/".
+		 * Extract the CTRL_MON group name.
+		 */
+		cmon_grp = strsep(&token, "/");
+
+		/*
+		 * Extract the MON_GROUP.
+		 * strsep returns empty string for contiguous delimiters.
+		 * Empty mon_grp here means it is a RDTCTRL_GROUP.
+		 */
+		mon_grp = strsep(&token, "/");
+
+		if (*mon_grp == '\0')
+			rtype = RDTCTRL_GROUP;
+		else
+			rtype = RDTMON_GROUP;
+
+		rdtgrp = rdtgroup_find_grp_by_name(rtype, cmon_grp, mon_grp);
+
+		if (!rdtgrp) {
+			rdt_last_cmd_puts("Not a valid resctrl group\n");
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		if (!rdtgrp->kmode) {
+			ret = rdtgroup_config_kmode(rdtgrp, true);
+			if (ret)
+				break;
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	return ret ?: nbytes;
+}
+
 void *rdt_kn_parent_priv(struct kernfs_node *kn)
 {
 	/*
@@ -2067,9 +2198,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "kernel_mode_assignment",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= resctrl_kernel_mode_assignment_show,
+		.write		= resctrl_kernel_mode_assignment_write,
 		.fflags		= RFTYPE_TOP_INFO,
 	},
 	{
@@ -3248,6 +3380,10 @@ static void rmdir_all_sub(void)
 	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
 
 	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
+		/* Disable Kmode if configured */
+		if (rdtgrp->kmode)
+			rdtgroup_config_kmode(rdtgrp, false);
+
 		/* Free any child rmids */
 		free_all_child_rdtgrp(rdtgrp);
 
@@ -3358,6 +3494,8 @@ static void resctrl_fs_teardown(void)
 	mon_put_kn_priv();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
+	resctrl_kcfg.k_rdtgrp = NULL;
+	resctrl_kcfg.kmode_cur = INHERIT_CTRL_AND_MON;
 	closid_exit();
 	schemata_list_destroy();
 	rdtgroup_destroy_root();
@@ -4156,6 +4294,10 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	u32 closid, rmid;
 	int cpu;
 
+	/* Disable Kmode if configured */
+	if (rdtgrp->kmode)
+		rdtgroup_config_kmode(rdtgrp, false);
+
 	/* Give any tasks back to the parent group */
 	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
 
@@ -4206,6 +4348,10 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	u32 closid, rmid;
 	int cpu;
 
+	/* Disable Kmode if configured */
+	if (rdtgrp->kmode)
+		rdtgroup_config_kmode(rdtgrp, false);
+
 	/* Give any tasks back to the default group */
 	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
 
-- 
2.43.0

