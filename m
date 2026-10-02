Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C71361DD0;
	Fri,  2 Oct 2026 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976449; cv=fail; b=GP1H4KIbHAFX6u9gLGrFQalplCQE1BZ3AbNWGqaG6Kf14U3YzQ9WmfL92sCaa9Qw4B98zd9S1rIJw1/WHZ1f3dLmARvYmoNcbw0mvMGQraclQJNHBoRoBkFu9d8K8jsiyBUnQYaWdagkbaztivHdHogxudREPrQbp0UoVobKz9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976449; c=relaxed/simple;
	bh=iv4iGPxiXevG1VXwD0n0Denrkj/WEUnZoDAF+sDT9dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wuk+6pRrkL+IWm+dDeMv2Nx6+zX44Z/1YCmiDdVBKd4W3Eg4qlyibK6ivtEnXztOUB6H7xlixPP0pcFffnQ4IPsDLLq6RqhhC2oNWISdCYbBMVBDkF74vtKHCqE7IKvfOLaAkkL3k7Mndy+TMrtQ3n/xkQ8NdB9TvIk2y0nSwyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O3wZOF2U; arc=fail smtp.client-ip=52.101.52.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O3wZOF2U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEigS17TkwWSLzAZSBXdVyvyX3LTDNa6zDwEztelTvdXUv4YO31FzZBJDiJA6OwKkM2gjJiupfN+bjxKBqmy7dJ5Jjc75Y0iU2viNzrPSrS5YfBy+KFMhfcYApzK8gnai2w7JAfOlCKumaoN5JAuhJuGmSNNxiSsA0BykEe0lxG+ENqIAxRjV3yRYACYSpw8dXqkzsosB3h8PMtlg70P6AfBu7pAFt4VbqdIHTvUgjQsbcgTHi1wNpajpVv9OogIJDwPusiM7pH7O1lYc+7aQkbH68MMPZn/TaRSVo4K1o4FKFyQt9LM5bsl6S4LaT9EhFFhC9JRvamIQzG46+UMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS7BM3ffH/EYhZ6gHETpNnjDmla2ASgIEbw2QAmvt44=;
 b=SYzY1OyacTbmceO404uG8QZzo4OzVyaiOdoUJvvYZWN8xC7Vw/B/yy4SnteoG8HFBesRTovYzjG3gOsPiU5H6k4T+rDjVfUsR22lReC1avIocatBIRJuIXvt/kxxBSV8bE6ausiXKjvyz3981EU423TGzEXqD+O3QejVbTBe8BkIgKCdXKyeUXp/1iZhU17jGVPA4ZVf6omi94IK3RRMYbW5wzHpa0DBAW6GR1B8Q2fdwQe5MLDQZz0BfK/kDgvyAObLpneH5OtMsC6X6dBGq36xFwPgCWr5yFp/dbGjP0/quYcnYlp7co7f9AOdusg+cnwmflBjYQ1VdavRfSxatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS7BM3ffH/EYhZ6gHETpNnjDmla2ASgIEbw2QAmvt44=;
 b=O3wZOF2UH2ookO7QdflLO20ZrduepMp953OKuwD5kqNXNJKHRctirF3wwcldM82595dxUR/w9ynWGEfJGu2O1ZFMVhr7JEPlLzMMi+2L3P5chqc6i/iag7DXNv0SNL8sxsmNERFijlNSKZenYGptYKWxbN/0EmyfUE9BHm2UWx4=
Received: from SJ0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:a03:2ef::6)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 21:27:19 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a1) by SJ0PR03CA0181.outlook.office365.com
 (2603:10b6:a03:2ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 21:27:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 21:27:19 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 16:27:18 -0500
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <tglx@kernel.org>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: [PATCH v3 2/3] fs/resctrl: Assign counters to existing groups when enabling mbm_event
Date: Fri, 2 Oct 2026 16:26:40 -0500
Message-ID: <09f0e27da685476211c43fa8ed85b49646305078.1790976400.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790976400.git.babu.moger@amd.com>
References: <cover.1790976400.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7554fc-6ca6-4ce0-f0f6-08df20cbf048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|23010399003|6133799003|260925021911599003|260925022911599003|260925021311599003|10067099003|11063799006|56012099006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ycRXAC4+EDqTLQgIk6Bq4chc+xEGvcprcx++bPgJV69tsQrg/qyuyST09e+5YqkRp0ZJnozFvoDlX/9H7VBgP3QZFFVmUAahrn32OenkycISjFTCkH95IVMgvCExaZjRWymPZd0kZf+VQjd8vsaijgLissY4nLEo6jxuWAeoVNYa8LIqV58fvj/gFLwbkYbRjdoS6W+QU5J4o4kJD5YS6rFXfMgTQRpmtkIjG1mgNfpS61hlrCwyGIpmGfi1z/mf9RRWOnvnEwqJwyuZAQT1BZ/Ez5fLfnB6eeXdmM2Rj9/XARY1DqLivZjaVoizTB+DNirN4gw1yvo7UUkUbW72pUvqnweRr7wApsZpEElrnPEmf3FFxxBtnu/qzbznoradqECVcAwGtGAwcqmWjsdIWkModDItCEuphwEzzhBV4x5T6pEX99cS3sM3GqBH8PyBvMZqq6onqgRlwVnFuPGgGfr4FwJZfnfTwPPVFPHia2icW9nuavYyofoanbHFvkhyg8pmz6SYwg7EoPjTOxjKN8aN/dSnuiCuLDgoRZxO8LKl5xSBvVbzDFK53o8Suxtp2JJfMc7O9mVNm2+h4kqW3jTBsAjdVsZ5q/FtG2pCMxZHhEakxd11JgzZSG7ykA2uX8HLT/IKmdMRT8iZ0AmN1A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(260925021911599003)(260925022911599003)(260925021311599003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O6Lwj+TnlNqlX0nh96i/TcZUAhtHB+dhDTOour3IZCLhkQkgMvAVDlFc5geoLIISffjzavBauPGCHi8bQgF1vftzMZKlhC0xX2WYegktdK1HStUREDHBPxFfnbQaPGvyMS+mFl7PFv186u+RlH5f2/9Ko+NQn2ZIPfxvKSfsirp3cCBAkgK4uGWUUnwGXDGYGBBwmnAW3IVaQjvQhzdJY5m+20f/eg4Hdksabs1LApgGccEKxWYEjO1IDMKLFAbD5Bw0w2BZIV1mu3Aj2sIazBkx30TDg20VwEcpAwBU7VllC4ADBj+L0MZMNzAETfaAsv32vwqg81R725Ka3PAD5WF9HLDzGYSMqMUoVGMqa31VGQjhakfDN/F0eCpC9BI+bJR0enlsEzjhfjH4lYUMc3Tgv2gi6wSzzcWI+QM+bXlVEKasgo/aFUmYeTnNCkB8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 21:27:19.0702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7554fc-6ca6-4ce0-f0f6-08df20cbf048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574

When the user enables counter assignment mode by writing "mbm_event"
to /sys/fs/resctrl/info/L3_MON/mbm_assign_mode, resctrl resets all
monitoring state and sets mbm_assign_on_mkdir for subsequent mkdir, but
does not assign counters to groups that already exist, including the
default group created at mount. The counters of those groups return
"Unassigned" until the user assigns counters by hand.

Enable mbm_assign_on_mkdir and assign counters, while there are some
available, to existing CTRL_MON and MON groups so the switch matches
mkdir auto-assignment. An event left without a counter reads
"Unassigned".

Fixes: 8004ea01cf63 ("fs/resctrl: Introduce the interface to switch between monitor modes")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
Cc: stable@vger.kernel.org
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 Documentation/filesystems/resctrl.rst |  7 ++++--
 fs/resctrl/monitor.c                  | 35 +++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 7 deletions(-)

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
index 73413cb128ea..fca0734bf346 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1300,8 +1300,7 @@ static int rdtgroup_assign_cntr_event(struct rdt_l3_mon_domain *d, struct rdtgro
 }
 
 /*
- * rdtgroup_assign_cntrs() - Assign counters to MBM events. Called when
- *			     a new group is created.
+ * rdtgroup_assign_cntrs() - Assign counters to MBM events.
  *
  * Each group can accommodate two counters per domain: one for the total
  * event and one for the local event. Assignments may fail due to the limited
@@ -1326,6 +1325,22 @@ void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
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
@@ -1599,9 +1614,6 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
 									   (READS_TO_LOCAL_MEM |
 									    READS_TO_LOCAL_S_MEM |
 									    NON_TEMP_WRITE_TO_LOCAL_MEM);
-		/* Enable auto assignment when switching to "mbm_event" mode */
-		if (enable)
-			r->mon.mbm_assign_on_mkdir = true;
 		/*
 		 * Reset all the non-achitectural RMID state and assignable counters.
 		 */
@@ -1609,6 +1621,19 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
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

