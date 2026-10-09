Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A764A8A28;
	Fri,  9 Oct 2026 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791589490; cv=fail; b=fHpcLTBI2+KdIqgXVDFOzS6TcF/qW3V+xyw0F0DdAd6coBMgd+tanPxlYqb5uTOMZj16kChxVw1RoualhTIW++2gsBX7G5cza9RxM9eYcWz1JgSJphqOfe+oGuhuEEKy8FmOlAwcXSkItywRpYdNAlXHHXQAPI7azUH0zHGIGEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791589490; c=relaxed/simple;
	bh=jjV6t5R2lbOuPh8PkRRzYgZDvOo2QOuY9m9hvmU8nrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYvULsqQbcKd/oSKFwet94b7FHC4R6+jNM+HTUKd4VHOBGL9Mev4nXzGqxUL9HCLB8tTKK0Ym54xqMaqr2ecp/Cm91GJf6HljY9V+VNpkGmt//1YUgbOIypMsnBG5fSui/c0XfhTSK6MEVgA++zX0VzBe1DEGCdiaCfLEJGym4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jCMy9fit; arc=fail smtp.client-ip=52.101.56.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jCMy9fit"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0EG9TsJIPCCrfhxCvhXFQ/jnvlq8lrrGXXoDW1USNuRlCZvfDTGc8eRjUgq6v61EikTrVs9hwEnGWVWxlKOIloP0EEpzc1LEPOoPaBqaT0C4P3lkJQhnfC0W7cfhTbEdN/SywMfB5t4/YC6AmubpV+l8SEjMh9rrzHAVwxSLe5j9cQOYi2WuaJzK2KopYb98rIAu1/tH8W2IEesrG9BdCFrYgh89LaxzyUgp2jYB78XxLUUrmbZBbHAfzUuoa9lmEFoKA4C1ZLYHBuOcJGOfmDoSwV4Q9qre4bg9yPRUJ2NPXQyQR7VCdDRZg+VaVql6UJOvqSg4m6MW5p2ltphaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv2otMm86AJBJ4AlB51HI8V3XhyHHkPWthyQbLeg5U0=;
 b=V87cHUM8T5qclqAewGpAUlwlQozMOekyk8oo7QNEBjjhoRPNnOJ1HEy8C/2kWucUR2UBpDPg1NgvC2KTwbr5CxuvZ0wJOZ86tKcW/3dLSNKDXrf/UdMmawIDOhjMqz3lmmJwBBRgQhcmvJ/MvHG2zkmRxD/Bg7NvGmhX/iJ3zFwcq9UY40czkhc/xN/h4xeuccXKaWLeSJLNstrobI9Mqy8rzSIRCX5qMZUaKnTznCW3yPfB3dYQWSmyCFxvJq6g8W5qZmnIUbBZ90jbBF48oFfn7lzYpIlf+/DpzT4F376RcyfENSrqf8ZmHr150VR8T26gh/ckf6o2GkAR/txODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv2otMm86AJBJ4AlB51HI8V3XhyHHkPWthyQbLeg5U0=;
 b=jCMy9fitwqWdaktmj8j+MwRXYPlz53I91tE0Tu6gIb2edmYDZQfxQLDsgeq/4/Zvy1wIhI8YXUuMqYCXWD+/Nd8C9lJq+HdvEeRnrB7x4gGIJ4MbyO38LiDyJjhFQWCa9M5e8ThHkRjiEYg1VvtCpdjL/4JwYOVvpq25z8BQBB0=
Received: from BL1PR13CA0083.namprd13.prod.outlook.com (2603:10b6:208:2b8::28)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 23:44:41 +0000
Received: from BN2PEPF0000A990.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::36) by BL1PR13CA0083.outlook.office365.com
 (2603:10b6:208:2b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 9
 Oct 2026 23:44:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A990.mail.protection.outlook.com (10.167.248.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 23:44:41 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 18:44:35 -0500
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
Subject: [PATCH v4 2/3] fs/resctrl: Assign counters to existing groups when enabling mbm_event
Date: Fri, 9 Oct 2026 18:44:08 -0500
Message-ID: <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791589412.git.babu.moger@amd.com>
References: <cover.1791589412.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A990:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f8a974-be90-49ee-e182-08df265f4a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|11063799006|56012099006|260925021311599003|260925022911599003|260925021911599003|261009223027099003|10067099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	cXzfJ1FbLHv3y94YBQxgEJfbu2joOFqPwo3SjVWLSpDit55m4nhTpxMTOBUT0ELSoLJCF1jsiCAcgxjtJL+miGzgTEvzHPceM4Tt/R17QKsamG0qdIwP7CLDVAXkJ45T0jf66u+0+ODuyzaGwTZNRNE/y8ZS2I9/mzjuCFOICvxPFEB35fJ0X7JUUC9gVM04n9Rc7ciciQTsZxfsDssLKdagx1T6lXk9EqfCf3dGjsGWu9n/NkoMs/XlIhM1lSkER9lrYkSqhzB3h0maoEzG+/rL9ATpygpciwkCJwVDaKksKEMLDngQxuOEV/dwpakSZ/aP9FpTQIYLMbjpjxbO+W0J4/xyy44xSOPLVsRZua7de+wWmAiE4iOpAIruHX839759RIBqoZHXRLfjS1IYd9O3e/fk47j6JkRam9+XZpyP3UPxh4SRqoMluzjFvqUfuZN6lkR8FL5kttCL4kH4QGpfwx2aGbf6GsYOAIrlSnxX+MWBluOU2kPyWJxGf/FjWRsAKNYpX3sQgQBhEK1xFQ2jC+X0NIjOp2r2CvwbEi20hXhhGCrwPw/e8RMcwT/lUYm54sLPzyF9m3tJSSbpFrvPLFulxp+b25V06J/i5Cm5wx1HM9IGGdRbFCdqXfjToSdV09ZtWGDPI2pNeV8uEA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hFjgkG0WeM74O7+QYk4memtfk3ILbXNuM798M8Wi3zgdswSHC2wDTefktFYUnkY0KcSKbKIgdd1IK+/syRGxamHJ5+CG5V1SaplwP1tQGtvdZGLb+ZsEg9NphymzQ0cBxJPYmevqTAmiPubaBZpfPFiVTCAj5K1ywh/AjdJZHYmLkr2XK0eUpn6NJ1FNMX7h/zLH39fvAnSe3PoylW5z7NCwZRzIvImdiUIJ54k0lfIH7BAPCH4pnIEwLW362CAVsOa66LyvaiJ8BihOKwSbuXy2PDa5VLfZAGtFRjKaJWLP50RRmLJnCvTQjLVjJqiKQI8zqtwA8/R5zbp48NUcO7s90xB6jDxsOYtf53M/uVLSc2cgTLrQgElr/6lLQ2uvAjo90U38Poh/zetwSuiFauvk+s9tZhoFXlonRxulG0h24cjySYCb8IotFpVsOvZf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 23:44:41.4793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f8a974-be90-49ee-e182-08df265f4a00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A990.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998

When the user switches counter assignment mode by writing "mbm_event" to
/sys/fs/resctrl/info/L3_MON/mbm_assign_mode, resctrl frees all assignable
counters, resets per-domain RMID state, and enables counter auto-assignment
exposed to user space as mbm_assign_on_mkdir.

Even though counter auto-assignment is enabled, groups that already exist
at the time of the switch, including the default group created at mount,
are not assigned a counter. All MBM events read "Unassigned" until the user
assigns a counter by hand.

Walk every existing CTRL_MON and its MON children after the reset and
assign counters to their MBM events. Enabling "mbm_event" now leaves the
same per-group state that auto-assignment would have produced. There may be
fewer available counters than MBM events across the existing groups; in
that case stop assignment when no counters remain. Events in the remaining
groups read "Unassigned", matching the behavior of creating a group when no
counters are available. Also revise the rdtgroup_assign_cntrs() function
comments to account for the new callers.

Fixes: 8004ea01cf63 ("fs/resctrl: Introduce the interface to switch between monitor modes")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
Signed-off-by: Babu Moger <babu.moger@amd.com>
Cc: stable@vger.kernel.org
---
v4: Changelog update (Reinette's input).
    Function comment update for rdtgroup_assign_cntrs().

v3: Changelog update.
    Code comment cleanup.
    Added Cc to stable.
    Added Reported-by and Closes tags.

v2: New patch.
    This patch addresses the Sashiko comment about documentation issue where
    counters are not assigned automatically when mode is switched to mbm_event.
    https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
    In fact, it exposed a real issue. When switching to mbm_event mode, existing
    monitoring groups should be assigned counters whenever counters are available.
    This provides a smooth transition between modes and aligns the behavior with
    the existing auto-assignment mechanism.
---
 Documentation/filesystems/resctrl.rst |  7 ++--
 fs/resctrl/monitor.c                  | 47 ++++++++++++++++++++++-----
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index b52795e03303..c8507580474a 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -370,8 +370,11 @@ with the following files:
 	of counters available is described in the "num_mbm_cntrs" file. Changing the
 	mode may cause all counters on the resource to reset.
 
-	Moving to mbm_event counter assignment mode requires users to assign the counters
-	to the events. Otherwise, the MBM event counters will return 'Unassigned' when read.
+	Moving to mbm_event counter assignment mode enables "mbm_assign_on_mkdir" and
+	assigns counters to the events of all existing monitoring groups, including
+	the default group, while counters remain available. Consult
+	"mbm_L3_assignments" after switching to "mbm_event" mode for counter
+	assignment states of all monitoring groups.
 
 	The mode is beneficial for AMD platforms that support more CTRL_MON
 	and MON groups than available hardware counters. By default, this
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 04e4ea612b7c..9e705eafe873 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1302,14 +1302,17 @@ static int rdtgroup_assign_cntr_event(struct rdt_l3_mon_domain *d, struct rdtgro
 }
 
 /*
- * rdtgroup_assign_cntrs() - Assign counters to MBM events. Called when
- *			     a new group is created.
+ * rdtgroup_assign_cntrs() - Assign counters to enabled MBM events of a
+ *                         resource group
  *
  * Each group can accommodate two counters per domain: one for the total
- * event and one for the local event. Assignments may fail due to the limited
- * number of counters. However, it is not necessary to fail the group creation
- * and thus no failure is returned. Users have the option to modify the
- * counter assignments after the group has been created.
+ * event and one for the local event. Assignments may fail due to the
+ * limited number of counters.
+ *
+ * Intended to be called in auto assignment scenarios ("mbm_assign_on_mkdir"
+ * enabled in "mbm_event" counter assignment mode) where counter assignment
+ * is not required to succeed. Thus no failure is returned. Users can modify
+ * the counter assignments afterwards if needed.
  */
 void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
 {
@@ -1328,6 +1331,22 @@ void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
 					   &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
 }
 
+/*
+ * resctrl_assign_cntrs_allrdtgrp() - Assign counters to the MBM events of
+ *				      every existing group.
+ */
+static void resctrl_assign_cntrs_allrdtgrp(void)
+{
+	struct rdtgroup *prgrp, *crgrp;
+
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		rdtgroup_assign_cntrs(prgrp);
+
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
+			rdtgroup_assign_cntrs(crgrp);
+	}
+}
+
 /*
  * rdtgroup_free_unassign_cntr() - Unassign and reset the counter ID configuration
  * for the event pointed to by @mevt within the domain @d and resctrl group @rdtgrp.
@@ -1601,9 +1620,6 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
 									   (READS_TO_LOCAL_MEM |
 									    READS_TO_LOCAL_S_MEM |
 									    NON_TEMP_WRITE_TO_LOCAL_MEM);
-		/* Enable auto assignment when switching to "mbm_event" mode */
-		if (enable)
-			r->mon.mbm_assign_on_mkdir = true;
 		/*
 		 * Reset all the non-achitectural RMID state and assignable counters.
 		 */
@@ -1611,6 +1627,19 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
 			mbm_cntr_free_all(r, d);
 			resctrl_reset_rmid_all(r, d);
 		}
+
+		/*
+		 * Counters were freed above, so both new groups (via mkdir) and
+		 * the groups that already exist need assignments. Groups created
+		 * while in "default" mode have no counter assigned, including the
+		 * default group created when resctrl is mounted. Assign counters
+		 * to them so that enabling the mode leaves the same assignments
+		 * that mkdir would have made.
+		 */
+		if (enable) {
+			r->mon.mbm_assign_on_mkdir = true;
+			resctrl_assign_cntrs_allrdtgrp();
+		}
 	}
 
 out_unlock:
-- 
2.43.0

