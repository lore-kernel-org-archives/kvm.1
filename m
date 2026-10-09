Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8003E4106;
	Fri,  9 Oct 2026 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791589500; cv=fail; b=QL6rRYBahdfQVwKSUu+dJYNsXGNfHHb4nwZFnzmIt2Ujxrf1YxD0LuO+0gavNAcR35dWyLpTHflo38q2veLPkWFAev7yLSWTsqerKASKG9jTgnExSvLMfQrd0pn6t7mMMqUu8ONr9CIn7naN6wRFnqD5o093waGr7v0XLk1Mkzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791589500; c=relaxed/simple;
	bh=5v3Y3JMQyRg/rcN6I/5QQuPzYJsD9pC+nQZMaHPEkjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOTgG9TJtMkakjAVlIETJaynKxyA5DuP9lS8AcleYKRcX+4UaiBrBfVRqH5yYsSxyWRccaMogqE2HD3cjseUr6lH+u4cF5eRA4cEQ/t2px98nls0UTu6ssklpEZboI27SZxSun361p2T/ocReSD3mmwEZNOkuQeWfCBn+r55fYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dwLcrqaD; arc=fail smtp.client-ip=52.101.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dwLcrqaD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQ1cv/SD6gASTEZ8qMGWRBUekq+81fHSi3Nb4j9+LUYkuREc4muHaDOHIUqOWlnHiv1xmWkmHNhk02E80sEZo+6vZTzwyOpNFFIVcWgBHmN61XP1xDsTO6mGLefktFDhuK9V4mjdXexV7dqrgLgqhtCOFk5J+qB6NBS/fLy9nkbnIVTewWI6HLoWUtUNqS3sNPaGtMjRTIX1vw3jpBDL5oLgwge0Uy+RxmProxIwakAMMy/HVIgX1KsgyMRXvWBrAZFVnY8F0lnEDQO0iD1/62NPUA3YJtZ8UabEQk6oDDN/3jYjSkntsWWR3a2jxPMlb89g6vnZO0qSO6aWpDg9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWfCf+FXpktqcyLF4x3V5XRyuTIqHUE7mAn+I5nEiYE=;
 b=fn8MKfuaxg012leRVIkgnQbejhdcckcVmZuyN/Mauu959w87LoMKLbFraU7pafuEHN6ly9NU/IBl7L0vVpdAuax4JJZLDS6WSwBfHRyz3nAOL3+PGKNwc5LMKEPf7jVyeByUNhUJzdw+P4mtUvKO65ZIqwkactIl4ScxQvDRAQ6UXgpDFRtZHvtPvJiavHC0ehZhoaYHbauIAeSjUAULMf/F6hn8oA8lT6SbLh7M4mNgw4lsA2x1r+SgJN2Me48y1mD/rUGNeVk/WmJfGWCcN9G0t7iDHw+k5kcMv9DNLSKuVHy2AdMqU8B68JjTb48swSEWkjX2b3hLZpYpFJqpYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWfCf+FXpktqcyLF4x3V5XRyuTIqHUE7mAn+I5nEiYE=;
 b=dwLcrqaDSqGY94M4ddaS9+xUIkdBnnNLNJjzjQrgUi5jjzhJ8tk7nyxgLDhLBs/b5it/Id9GLGinanphg0j1Ti7T6DLgLkRQ0vd9Wj7I+JLaJYKWeqoSysBkb2rSNpqiE6rvvoxtysEE797Ys3HpDDLO9iVs/IEdIrFP9eyDD1o=
Received: from BN9PR03CA0625.namprd03.prod.outlook.com (2603:10b6:408:106::30)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Fri, 9 Oct
 2026 23:44:49 +0000
Received: from BN2PEPF0000A994.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::30) by BN9PR03CA0625.outlook.office365.com
 (2603:10b6:408:106::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 23:44:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A994.mail.protection.outlook.com (10.167.248.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 23:44:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 18:44:42 -0500
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
Subject: [PATCH v4 3/3] x86,fs/resctrl: Keep mbm_assign_mode in default mode at boot
Date: Fri, 9 Oct 2026 18:44:09 -0500
Message-ID: <fb62d29c027514fbd371bd932f098d119625acfd.1791589412.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A994:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: e33cd8c8-59a2-495c-2875-08df265f4e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|7416014|6133799003|10067099003|22082099003|3023799007|261009223027099003|13003099007|18002099003|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	MgzH2HkcZBMQcQIpNkVc7DVUHhACBxEBf6DNfF+z6qF2yFJBTDS1hWdEjxiGO87S2Ce/IE37H2mksVhSXZkrkJzb9dmubtnHQ6PGhcsAHA1ABe2z1nD+gg6FXr4H264KeDRGTy1BYmeGe0DMFakfIMR+xH8KKo6AeIpaDfudeaBVM3CADLSqB8wD/Ow1dCgp8tbxWtrABKsnoqTv57m/t0xYkunCZkX0e5EovyNjdaSR/jMMBHtDQ2KvmW3kxgma5hcqIcVz4u6+6LXGlOMggeIVmMwmhvL+yH4ixUiGbxxv3GgzWl065uhRlU1zbV8GhGnqJ8UoHGl6D5IfecgCLH2G7CGFQF2ayMKEWTiNulTqdaOol7jcVy+82Pc3OebgCUDLAwHe+iA7wHjtexYM5vOFOoJIka3zdZWrWDvD/u6h6423JSbpuNq9TWE24PIuja3nHyEGSQV3iaB3N2ubz0wgOZdEgaGAKdLy0NFCyaaNcokpIaZKYKEhtQF1JEnBjz+VPAtaNngnvRMRKAZViT91BP5OtJoeCmYOVtGuT9r0sG3Z5kMEoFqaxhHxRQBe20n/01i2xrDBIt4osw9PUaP5/b0tBXgFGuZJsiL7fOPgJsH2QDb8sjg8arjpMRMSQVGWuVba+/4Tr4t6mnt5AJdsIRW88IJVfbRlqimlFjQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(7416014)(6133799003)(10067099003)(22082099003)(3023799007)(261009223027099003)(13003099007)(18002099003)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iCLAdVjtKluO1oAST0+0/FLDV7EiKM0TxicyVKy1FM7UtM/JZpozEiwN87XcNiDdPBtNfPyQTToxebZMXjRFTE8CzfRDy1yFMsLKFdC+oo7qFTL9/JtZbXcRQnK32WikKdhua1eUakkc8YMFDHhSJHx9r7cmvON730HWA7O3zWeVRZs6TP2sDgBuQkAUz7olwuqwKPD+8LEViEjVx9FtH6ggnVlzkrrGAsaphgcYYMGiw2XQERClBv7Pj2cDa150uy/7fo4rnaTSwv9m5bNSUq+3n6Og9mklKcpz27yLNdXq+Wv/RI+cyUkWDR4ld+0d08yBRzkPN0qG/lGiFhtm/2j/YRlm7i9k6+B7P4xHSq1nieJM9zIyycinw2natNkmnXQd0I9ze4FO5assydxkLZItb4TQnDnPkjPM4uzn2C02kkjLGruUT+glc9WA9mqk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 23:44:48.4241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e33cd8c8-59a2-495c-2875-08df265f4e25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A994.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652

The mbm_event mode assigns hardware MBM counters to RMID/event pairs.
It is intended for deployments that need to manage counter assignment
on platforms where the number of monitoring groups exceeds the available
hardware counters. Hardware counters are scarce on these platforms, so
mbm_event mode suits workflows that monitor a subset of groups at a time
and rotate assignments as needed.

resctrl enables the mbm_event mode by default on hardware that supports
it. This breaks the pqos tool [1], which assumes the historical default
mode. It creates 16 or more monitoring groups and uses two counters per
group. On a platform with 32 counters per domain, that exhausts the
mbm_event counters pool, causing additional groups to read "Unassigned".
pqos interprets a non-numeric event read as zero bandwidth and reports 0
MB/s for those groups:

  $sudo pqos -m all:0-4
  CORE         IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
     0        0.69         16k       192.0         0.0         0.0
     1        0.40          3k         0.0         0.0         0.0
     2        0.44          1k        64.0         0.0         0.0
     3        0.39          1k        64.0         0.0         0.0
     4        0.43          1k         0.0         0.0         0.0

Leave mbm_assign_mode in default mode during initialization. Default mode
uses one counter per monitoring group. On existing AMD platforms, the
default active counters pool is 64 and may be larger on newer hardware.
The active counters pool is the number of counters that the hardware can
actively track in default mode.

Deployments within the active counter pool receive accurate bandwidth
measurements in the default mode. Users can create more monitoring groups
(4096) than there are active counters in the pool. Beyond that pool,
readings may be misleading or report as "Unavailable", with no user-visible
indication.

Default mode is still limited once the number of monitoring groups exceeds
that active counters pool. After hardware re-allocates a counter, a read
may return "Unavailable". pqos still treats "Unavailable" as zero.
Successive reads can be a count, "Unavailable", then another count. pqos
treats those jumps as wraparound and can report an inconsistent rate:

  $sudo pqos -m all:0-4
  CORE     IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
  0        0.76         60k        32.0         0.0         0.0
  1        0.45          1k        32.0         0.0         0.0
  2        1.57        107k        64.0         0.0 17592186044184.9
  3        1.62        276k      4928.0         3.2         0.5

Users that need stable measurements beyond the active countes pool should
use mbm_event mode and rotate assignments as needed. Enable it with:

  $echo mbm_event > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

Fixes: 0f1576e43adc ("x86/resctrl: Configure mbm_event mode if supported")
Closes: https://github.com/intel/intel-cmt-cat/issues/311
Signed-off-by: Babu Moger <babu.moger@amd.com>
Cc: stable@vger.kernel.org
Link: https://github.com/intel/intel-cmt-cat # [1]
---
v4: Introduced mbm_event counter pool and default active counter pool.
    Removed duplicate texts in resctrl.rst.
    Re-arranged the tag order.

v3: Added pqos output to show the problem.
    More changelog to detail the issue.
    Updated the resctrl.rst to mention changes.

v2:
  Added documentation describing the known issue with the default mode.
  Will add cc to stable once we have all the things in order.
  Let me know if I missed anything.

v1:
  https://lore.kernel.org/lkml/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger@amd.com/
---
 Documentation/filesystems/resctrl.rst | 43 +++++++++++++++++----------
 arch/x86/kernel/cpu/resctrl/monitor.c |  1 -
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index c8507580474a..a896bcae3319 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -354,8 +354,8 @@ with the following files:
 	::
 
 	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
-	  [mbm_event]
-	  default
+	  [default]
+	  mbm_event
 
 	"mbm_event":
 
@@ -376,20 +376,35 @@ with the following files:
 	"mbm_L3_assignments" after switching to "mbm_event" mode for counter
 	assignment states of all monitoring groups.
 
-	The mode is beneficial for AMD platforms that support more CTRL_MON
-	and MON groups than available hardware counters. By default, this
-	feature is enabled on AMD platforms with the ABMC (Assignable Bandwidth
-	Monitoring Counters) capability, ensuring counters remain assigned even
-	when the corresponding RMID is not actively used by any processor.
+	It is intended for deployments that need to manage counter assignment on
+	platforms where the number of monitoring groups exceeds the available
+	hardware counters. Hardware counters are scarce on these platforms, so
+	mbm_event mode suits workflows that monitor a subset of groups at a time and
+	rotate assignments as needed. The mbm_event mode ensures counters remain
+	assigned even when the corresponding RMID is not actively monitored.
 
 	"default":
 
 	In default mode, resctrl assumes there is a hardware counter for each
-	event within every CTRL_MON and MON group. On AMD platforms, it is
-	recommended to use the mbm_event mode, if supported, to prevent reset of MBM
-	events between reads resulting from hardware re-allocating counters. This can
-	result in misleading values or display "Unavailable" if no counter is assigned
-	to the event.
+	event within every CTRL_MON and MON group. This mode is enabled by default.
+
+	On AMD platforms that support more CTRL_MON and MON groups than hardware
+	counters, hardware dynamically shares a smaller pool of counters among
+	RMIDs. One counter from this pool is used per monitoring group and counts
+	every MBM event of that group's RMID. The size of the pool is not
+	enumerated to software (unlike "num_mbm_cntrs"), and "num_rmids" may be
+	much larger. For example, 64 counters in this pool monitor 64 groups.
+	Newer hardware may provide a larger pool.
+
+	While the number of monitoring groups does not exceed that pool, a counter
+	stays attached to each RMID and readings remain accurate. Creating more
+	groups than the pool can cause hardware to re-allocate those counters
+	between successive reads of an event. Bandwidth values may then be
+	misleading, or a read may return "Unavailable" if no counter is allocated
+	to the RMID. There is no user-visible indication when this begins.
+	Users who need stable readings beyond that pool should switch to mbm_event
+	mode, if supported, and assign counters to the groups of interest
+	(rotating assignments as needed).
 
 	* To enable "mbm_event" counter assignment mode:
 	  ::
@@ -1787,11 +1802,9 @@ View the llc occupancy snapshot::
 Examples on working with mbm_assign_mode
 ========================================
 
-a. Check if MBM counter assignment mode is supported.
+a. Check if MBM counter assignment mode is supported and enabled.
 ::
 
-  # mount -t resctrl resctrl /sys/fs/resctrl/
-
   # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
   [mbm_event]
   default
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 5d0d3b18f9b8..a6a9090c4808 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -472,7 +472,6 @@ int __init rdt_get_l3_mon_config(struct rdt_resource *r)
 		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 		/* cntr_id is 12 bits and can only encode 4096 counters. */
 		r->mon.num_mbm_cntrs = min((ebx & GENMASK(15, 0)) + 1, BIT(12));
-		hw_res->mbm_cntr_assign_enabled = true;
 	}
 
 	r->mon_capable = true;
-- 
2.43.0

