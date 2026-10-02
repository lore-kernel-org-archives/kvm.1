Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD82A44A400;
	Fri,  2 Oct 2026 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976464; cv=fail; b=MmoxfvKVQOVoNdKRXQol2d9Go2IGmz3SoH03kJ7ED5LTR3+I92sCrYXA9XxtZ15E3kAfMgscbJ2IX3K8OqF7Z7SmkHVVIFH6bohb2cB5g8P9qI/MIYFLPqfoSMYkuziA9eanUbzkGVXsCtIjN+uIsDW+gwjkL8Y1mQjfpWEFo7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976464; c=relaxed/simple;
	bh=LVTqZvfB65X2jefwFD4RTFAIAKl5U4BWwmcsREKESPE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pR3zE4Rvo8Hi+L7uquNvXZQ2lkTNPsQJqLCL6KHAhBzab3x6qRYZiNeb8l4RGJp2cOjfnMCW3KK0PfuW+0lYnWdk/yb0pv52NVmWjrULdH2tVC1ivE0qcs0+WgjCCJdoPYPpgPgvnBSqBsJJrLATlsX6jlzoaei09XULgAjJYD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sKXjfcHL; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sKXjfcHL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLEXrs1uU4bXxxUyoo1ACaoH/r2viGPCiRXOtSkM4zf9K2nyhvyTvvIoJ83zF7jg8EZjY6gIBkVl+68N4oHaG9CMo2K0iQ8/tOLzl2yBGpgzbDkvCKvMZl8hbf9zKtL55vlCOJKsi3luOnwzz4/bwhMFsxF9tTHlB5SE0//ythk/BalKMSHBbEMqSMrNETyO/YnDYrf1poeGMVEo/5NGJndxFTJL6u16jMlsUrvFyLBKNECHMlHlhue8Ek5AUDkPqPVEB9mWpz2EV8E2DtJ/BuFf+8J9fYgWeQlhgfiWk+/YW3ZgIQGZ0IXio8CedypfNNYp7xxcybTOZk4++TA51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5i5fa+H3enKBdR1IBgj8djgPj021enJRKVNdt0OeiI=;
 b=Zll9O2vhuzs5QkRL3riGUzwwaCtWqa+tx3ccTns8DizgwU0RDoVftIHwVT3sfzSwQDlARNXLBCrfq1hY0VeAcfxBu0BcsA8bVu2oM/j1S+mJKqNY9QHZp93jaaHyU9UbJ2fYVT8+jJSdK7MIZcbPFisvm0hJ/6A7nCXdtm6JJ8OH+/l4lhoFexZQn52BVHzu8fxC/gjsyOyqlXTGr/jogRDV6RFnmDbHvSvHwo2ZKe+/mpjT28jguAgIwHLjNfUO9AgEwL6eP4GsR0nckUh+xqMFr3U/lkNA0GkzJ3td4ekS2QywW6Iak5p5Y9rSn2L0Tz1dRoR0sCvAz0v+wF80Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5i5fa+H3enKBdR1IBgj8djgPj021enJRKVNdt0OeiI=;
 b=sKXjfcHL1I6WdhXGUs/p3etGNtFONq9f0wQBqqKIrHvm7xfrZYk3r2NMn5+t+7ffFKCL5W9jEWZnvXweni8/5hCRmcbOc4ps15lGedBh/lRuqUM176V8cHUy6VhCzSpvQb6A2d4FVDTKkk5z8Hoyu/5hzp1jr5UrWd+dDljfddY=
Received: from BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::16)
 by MW9PR12MB999209.namprd12.prod.outlook.com (2603:10b6:303:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 2 Oct
 2026 21:27:32 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::f) by BY1P220CA0008.outlook.office365.com
 (2603:10b6:a03:59d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 21:27:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 21:27:31 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 16:27:30 -0500
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <tglx@kernel.org>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: [PATCH v3 3/3] x86,fs/resctrl: Keep mbm_assign_mode in default mode at boot
Date: Fri, 2 Oct 2026 16:26:41 -0500
Message-ID: <b969687be3162715e10242424b5a489857d67f2a.1790976400.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|MW9PR12MB999209:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a987e9-3916-41b7-69e6-08df20cbf7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|7416014|260925022911599003|10067099003|260925021911599003|260925021311599003|11063799006|56012099006|5023799004|22082099003|18002099003|3023799007|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	2J0zb/vZ3lMhKfmPawcjO2ZoDoFjHXOB0csEuYXndDS8x6N9zC3dfp6Qug/its+ZZRjzWTRzWI9JgVTqPfCgRJUtFeDQRPk6Zn3OefAFaqNwAwiJYUbrLqF6QxoPzrTXWJh4gN+7hyGvDg8CAKlFz+H6QEYRQwOUaarg8YviZs/xwAvXyapwXUT8Y413QIzGC0UdLLVH0AqJtpcYHqdcsD3TKqPxpQYK0IO17itffVoFW41LgwQHp2xGgaj+MGNdnau3PoWpUuJCgCqcRcvGKwXpal7zdJfX/U0D4yrt84fXBSY8IvDGVjQQTjbuI55RTdz2z0tnzhi7DN5dR2/zzqN9100upv65Pmloj3FfS5rR+5kMgROHjOr84OxSgzDUqjK3AgwuSw3k3KSBMuMNseP/sNLNY/25ExNKiu2cAIjoUUOSpFwWY6w8ELxKzuw5ywhYCJmznr6Nx/mQ7RxQ9VszgSqj+2qwKtNHGLSl7GnHQGermvBPrcbnH+ghUZ21Lh8dL8o5AAGUOzI4MkE8/LumpyMEtaCkUf8mbC3yYh2fACzn6gKE93U5xByCG/a7MuNAL+vDG/2QgbaRZthOIM0qT12UMo6oZ+IV24nws17AhZeadoWP8c8dJfsBzrc2jHCISuET43oesgVytKS//XCi7sCSYGXR4ktQplh9KHMhVEnjVr9lGXInqKUQ0VmogzHq0F6iRpirmKEjNG3RkA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(7416014)(260925022911599003)(10067099003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(5023799004)(22082099003)(18002099003)(3023799007)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a8HiI/pBnAL+BgNhPy4UQ2FhE43FBvUJsUJECJlAH+TeSJP6eyuA18mtNm0hF9oMKoiIrmfU18ujApDoMiVK5FCdPqXWEXanF01mtVJyVcelOUyMnQ4eV6tRykl9KuzxeqQmYAbSL/V+H7HgEJeE0uhNvpzoYC0nMgfI6Vhlp7IaXevc7AErD7EVF/Ay8JixNs3P6YfaSMHCsdjg8XJBfzGJa+yj5UJPWIVexWM3TSeoCSiWmR+43L9CG0btgAeBnwOvAr9RRA5E1b7+jfRV04n5AaUSXicIK712f5Zzkl5POqUyIQlR0Po87IMRWKg1ZEZ/OT4SCU10EYSfxCwmRJImP7t+viYxkYK7DUkBObefYXZSQzA9XiCKWGlU8xuWNreSTo8EM/eu/K/SbpLD579chjopNOirV+VYs7TV1/DPYSpA3EwwJfzQw1sxNIzn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 21:27:31.7562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a987e9-3916-41b7-69e6-08df20cbf7dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999209

The "mbm_event" mode assigns hardware MBM counters to RMID/event pairs.
It is intended for deployments that need to manage counter assignment on
platforms where the number of monitoring groups exceeds the available
hardware counters. Hardware counters are scarce, so mbm_event mode suits
workflows that monitor a subset of groups at a time and rotate
assignments as needed.

resctrl enables the "mbm_event" mode by default on hardware that
supports it. That breaks the pqos tool [1], which assumes the historical
default mode. pqos treats a non-numeric event read as zero bandwidth. It
creates 16 or more monitoring groups and uses two counters per group.
On a platform with 32 counters per domain, that consumes the pool, so
further groups read "Unassigned" and pqos reports 0 MB/s for them:

  $sudo pqos -m all:0-4
  CORE         IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
     0        0.69         16k       192.0         0.0         0.0
     1        0.40          3k         0.0         0.0         0.0
     2        0.44          1k        64.0         0.0         0.0
     3        0.39          1k        64.0         0.0         0.0
     4        0.43          1k         0.0         0.0         0.0

Leave mbm_assign_mode in "default" mode during initialization. Default
mode uses one counter per monitoring group. On existing AMD platforms
that pool is 64 counters and may be larger on newer hardware. The
"mbm_event" mode uses two counters per group, so 32 counters cover only
16 groups.

Deployments within that pool receive accurate bandwidth measurements
with default mode. The hardware supports 4096 monitoring groups. Beyond
that pool, readings may be misleading or "Unavailable", with no
user-visible indication.

Default mode is still limited once the number of monitoring groups
exceeds that counter pool. After hardware re-allocates a counter, a
read may return "Unavailable". pqos still treats "Unavailable" as zero.
Successive reads can be a count, "Unavailable", then another count.
pqos treats those jumps as wraparound and can report an inconsistent
rate:

  $sudo pqos -m all:0-4
  CORE     IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
  0        0.76         60k        32.0         0.0         0.0
  1        0.45          1k        32.0         0.0         0.0
  2        1.57        107k        64.0         0.0 17592186044184.9
  3        1.62        276k      4928.0         3.2         0.5

Users that need stable measurements beyond that pool should use
"mbm_event" mode and rotate assignments as needed.
Enable it with:

  $echo mbm_event > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

Fixes: 0f1576e43adc ("x86/resctrl: Configure mbm_event mode if supported")
Closes: https://github.com/intel/intel-cmt-cat/issues/311
Link: https://github.com/intel/intel-cmt-cat # [1]
Cc: stable@vger.kernel.org
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/filesystems/resctrl.rst | 48 ++++++++++++++++++---------
 arch/x86/kernel/cpu/resctrl/monitor.c |  1 -
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index c8507580474a..2efc99223bdc 100644
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
 
@@ -363,6 +363,9 @@ with the following files:
 	pair and monitor the bandwidth usage as long as it is assigned. The hardware
 	continues to track the assigned counter until it is explicitly unassigned by
 	the user. Each event within a resctrl group can be assigned independently.
+	mbm_event mode uses one counter per event of one RMID. A monitoring group
+	can use two counters, one for mbm_total_bytes and one for mbm_local_bytes.
+	For example, 32 counters can monitor 16 groups.
 
 	In this mode, a monitoring event can only accumulate data while it is backed
 	by a hardware counter. Use "mbm_L3_assignments" found in each CTRL_MON and MON
@@ -376,20 +379,37 @@ with the following files:
 	"mbm_L3_assignments" after switching to "mbm_event" mode for counter
 	assignment states of all monitoring groups.
 
-	The mode is beneficial for AMD platforms that support more CTRL_MON
-	and MON groups than available hardware counters. By default, this
-	feature is enabled on AMD platforms with the ABMC (Assignable Bandwidth
-	Monitoring Counters) capability, ensuring counters remain assigned even
-	when the corresponding RMID is not actively used by any processor.
+	It is intended for deployments that need to manage counter assignment on
+	platforms where the number of monitoring groups exceeds the available
+	hardware counters. Hardware counters are scarce, so mbm_event mode suits
+	workflows that monitor a subset of groups at a time and rotate assignments
+	as needed. The mode is beneficial for AMD platforms that support more
+	CTRL_MON and MON groups than available hardware counters. The mbm_event
+	mode ensures counters remain assigned even when the corresponding RMID is
+	not actively monitored.
 
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
@@ -1787,11 +1807,9 @@ View the llc occupancy snapshot::
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

