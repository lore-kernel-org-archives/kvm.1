Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793392287;
	b=r+zeaMNiq9nsjN1BJ1Bu2CS6LQ+uYPxlb4v1WoKeADmMWrcRdOGfzkwVQH3tz9RSpQHS
	 FsV7zjC8zQnbwbrS9m16Z8Qv6c4MDsZfhEX3FOhfqaSKr8t2U5SJP7RxqxER/UbiCAFLN
	 8a941cyL2YzrXQb4u12tXz8p2zc/YgyhDdUXBs70OcX4U0tTDBLgHNNzGw7eHOZrwxFgZ
	 J3CSrxEkkrJerrcnTKaaggHfapMbny8lWd1erxo3/Xf7gi0HWZq2z9HajHPw7Wne3chmq
	 4TLG9BbggHYv52cSv/35z+9AGjUlD2F9vpFMh/dtfWl8xEr8UsJnf6L7a+3/NJa6oqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392287;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mGN54Vx5el8Kplz3LeMa55OvW/PjprAFTNep289Fdis=;
	b=Xxnoxz123HG4OLbCz3YGw8fR3ub2eVL1BgAgcTbkhPmmX/leOKtfig9ejjLSQ/N1Ns4B
	 Lipp45VfNI0w+EI0XLfopVajeZjJVPIhbQ0k7GzkuAqBrHXJV6YD3HD/gPrL4qOYqLZm2
	 WuPppYwIL1K3TDgy2AVn9L/U8thEhy3IrAWiRg9nJOSD/hBjsxRx1cseZ2h42tn4IOmsb
	 2DT/5GR7quiRYhhrQ4u71MB7DAd8B/4GDM28GmD/nXhbI3+0K85DQ+xTl6U0wLI+EAvtN
	 6hmvurGQ2CQvXHNtFuU4Q7dzaZWDd2VxWUEWO+E1h+yXhQuVRE+GoiM4Pm2UcEo/5RA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QlNGu3k8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.48
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C99606A31C;
	Fri, 30 Oct 2026 20:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46C99606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QlNGu3k8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TX+W18b6mU02oK5WaqMABf+brf/dl5NDOOZEmqoXzRM//7+aToa4wof8J99dN0qPlKFCMvsvR7jJXp3O3Yy/K046yEI6Qv+LhBHW20kK+qZ7jSxOw1/zUuvH+CGbpQDprnRU6W6AKF6YI++QwvLV7dD1nlENm3zxCWw/I+vF98ZcWFiMZLskKLFfL2A+mG8vvB31Pa0mNlHx3FXByG7ItepiGr3xuSg3X9mJdYgKn1hrSeSEcJMc+uhpLdsZx3lk1zSgCL+eOLNZzpBIOx/92Tx11uIPblghv1DrclJlo6aj7YGHLJkpWOlcFIeOvXvCUUkNzMxbIgAxD/IVUJq0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGN54Vx5el8Kplz3LeMa55OvW/PjprAFTNep289Fdis=;
 b=HP5pS7fSqewuQh+qp2wYtKxcTjl/xOKSKuslXnXBE415wtGTJMIj3evW+CcnJfwJq/qss4rrdfaUIVSAatnLCAtW2C1INNlL20oF8/r9cGozyCcQoHF4k2tRtBcZAS3TfwH/5qSC5NXplnwAOi920RZR0dZTBqpL9WW1gU8b8xKrekn3J4ot7fycE0TWoRUucxTFZvF/jPCAKRpKym0gUOBzv+iKPypEGuMEUZymOYQcOIcr4QS6N8IQHN8xAbokjuShgBuqlXSYDGU7EplSEpQFirdU/4iG/goJmYcHT/3bY8ULl/JYGLXEngZaLx2kBxtjOCVoNH8pD7QKMZdHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGN54Vx5el8Kplz3LeMa55OvW/PjprAFTNep289Fdis=;
 b=QlNGu3k8WMoCNv9eEPx4kccBFMFZvkWSahTbSHrotat3N5xMUzAEyQ9baoBHx4X34VndxpqUW5vJ0rXnuqPeBqKuk+tjP877kxgPwGfc105bz45Gf1Vq1tZ80FW6+fQB0uyN8mYXlo1pAEeyCrOnVGahqnnzxX7eW+tGSib2rwc=
Received: from CH0PR03CA0313.namprd03.prod.outlook.com (2603:10b6:610:118::34)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 20:29:20 +0000
Received: from BL6PEPF0006C3DC.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::5c) by CH0PR03CA0313.outlook.office365.com
 (2603:10b6:610:118::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Fri, 30
 Oct 2026 20:29:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3DC.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 20:29:20 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 15:29:19 -0500
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
Subject: [PATCH v6 2/2] x86,fs/resctrl: Keep mbm_assign_mode in default mode at boot
Date: Fri, 30 Oct 2026 15:28:48 -0500
Message-ID: <c1e5ef23e83ea663e9aa969e301fac20723a988a.1793392128.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793392128.git.babu.moger@amd.com>
References: <cover.1793392128.git.babu.moger@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DC:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 430197c6-2012-4eb4-473c-08df36c47a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|260925021311599003|260925022911599003|260925021911599003|5023799004|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261022113327099003|261021123027099003|261021121427099003|261022105027099003|10067099003|18002099003|18092099006|22082099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	7s27ysFD/agYQTQ5W8HetKkjxMdChA8piFoUrFFLcf78obo+b4sosW2Qtjrp2yRtnc1cdf4CDYOhUYgvdiEZDmMAIYnqM2GgpQv4U0TLjtD0qhwrFZ5/oCzUDRlEFPmABhA3TLCTRTl7ufV05MYBQQfN/FcEJJG459uTrSB4sEpHBkRSZwM31qOmMDnl1sCxmzy+Feaqt1w/+bKEh2rkZCLldz0aM+8PEsFRVv/nXwhtVBfrIMRMeB8vqIQj+PIgd8XVBH+tl+4B/7GygCTKUD4PRrIQgCFfIyX2x3x7c5FjPg+8t1IWzpU4MKKPETL7KBUH5xnT22w7kn0qJAOUmdXYDjz0Uz/67N/Q8wK/0ezFXeo4o8xMHV/eGANtAZ5/UkisAAfzVSV+UF7v2ZMdx6OKhDIerMva+ZWIl6kxX/f7jIWB1FWZ5i5oDsA00ASjY6i1PLDTYvq897yvPFXJEgyIR6WpVKZtjzJuTyVLcMb3EJEE8Rs777zr7Z0LregsRZ+T/fqnHTpK8Yq4mYj+am4LogG8nlsoiyd35mYtfUr6l2bAK0fs/RQEg40rUOs80Zg/wtPTOl9KwNqaJ55V4q8AEGXTrFzh2b0DiRcTrTXaIZ74Be0I/8sdd3lcZRkalRaEy4CmOV0jUnv6TPRcachGB/2MtJgo2Y2Y+yI/Ltg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(260925021311599003)(260925022911599003)(260925021911599003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261022113327099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(18092099006)(22082099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mT51n57osprcL8+5C2rDPYVtFfYISxFPcQKxoc1b5kKZVUgGHLdR8n0wN2QyeyiK8CE4ixpi5LzPRByz8t3T4TLTdqBzs5aEDtLjXcbzEhh9A4zhuFJNX1UVBig+6ZKaw/P6sAHhaY2kTPPPXwZggpt4C7tbTakNJhJxB7yMBOFDvs1xcHCUIZTGgdAtbLisJ2nGLEorNno1AFYIzLHVtrU/ya2ssJgyh9AMe622I3lk5bv9dpQvVvPEmY/dl/7BV69EF9cL017msiKRxRILPgibf2qSZq4GIwPrlrELhu5/gMt7+6Jc1tpRCGH6XBEIfHLNO4GqAED8KHXpw20k0nDcpMB22A70YZLGurlVk5BNOfKJvXqRRtpB8POH2EEAcKoIDtZhzMSBuS2vlBBs1nFH6NJcADP6hF3WqFoap1uKrlJcFnKyCi3mAU7N6MOr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 20:29:20.2369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 430197c6-2012-4eb4-473c-08df36c47a46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0006C3DC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677

The mbm_event mode assigns hardware MBM counters to RMID/event pairs.
It is intended for deployments that need to manage counter assignment
on platforms where the number of monitoring groups exceeds the available
hardware counters. Hardware counters are scarce on these platforms, so
mbm_event mode suits workflows that monitor a subset of groups at a time
and rotate assignments as needed.

x86 resctrl enables the mbm_event mode by default on hardware that supports
it. This breaks the pqos tool [1], which assumes the historical default
mode. It creates 16 or more monitoring groups and uses two counters per
group. On a platform with 32 counters per domain, that exhausts the
mbm_event counters pool, causing additional groups to read "Unassigned".
pqos interprets a non-numeric event read as zero bandwidth and reports 0
MB/s for those groups:

  $ sudo pqos -m all:0-4
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

Deployments within the active counters pool receive accurate bandwidth
measurements in the default mode. Users can create more monitoring groups
(for example, 4096 on current hardware) than there are active counters in
the pool. Beyond that pool, readings may be misleading or report as
"Unavailable", with no user-visible indication.

Default mode is still limited once the number of monitoring groups exceeds
that active counters pool. After hardware re-allocates a counter, a read
may return "Unavailable". pqos still treats "Unavailable" as zero.
Successive reads can be a count, "Unavailable", then another count. pqos
treats those jumps as wraparound and can report an inconsistent rate:

  $ sudo pqos -m all:0-4
  CORE     IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
  0        0.76         60k        32.0         0.0         0.0
  1        0.45          1k        32.0         0.0         0.0
  2        1.57        107k        64.0         0.0 17592186044184.9
  3        1.62        276k      4928.0         3.2         0.5

Users that need stable measurements beyond the active counters pool should
use mbm_event mode and rotate assignments as needed. Enable it with:

  # echo mbm_event > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

Fixes: 0f1576e43adc ("x86/resctrl: Configure mbm_event mode if supported")
Closes: https://github.com/intel/intel-cmt-cat/issues/311
Signed-off-by: Babu Moger <babu.moger@amd.com>
Cc: stable@vger.kernel.org
Link: https://github.com/intel/intel-cmt-cat # [1]
---
v6: Minor changelog update.
    Re-arranged resctrl.rst to accomodate change in auto-assignment.

v5: Dropped the patch 2 from v4. As auto-assign is not a requirement when
    mode is switched to mbm_event, the examples needed some changes.
    Updated resctrl.rst to take care of that.
    Few minor changelog update.

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
 Documentation/filesystems/resctrl.rst | 87 ++++++++++++++++-----------
 arch/x86/kernel/cpu/resctrl/monitor.c |  1 -
 2 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index b52795e03303..2750f2eabf70 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -350,12 +350,12 @@ with the following files:
 "mbm_assign_mode":
 	The supported counter assignment modes. The enclosed brackets indicate which mode
 	is enabled. The MBM events associated with counters may reset when "mbm_assign_mode"
-	is changed.
+	is changed. See architecture specific notes below.
 	::
 
 	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
-	  [mbm_event]
-	  default
+	  [default]
+	  mbm_event
 
 	"mbm_event":
 
@@ -373,20 +373,17 @@ with the following files:
 	Moving to mbm_event counter assignment mode requires users to assign the counters
 	to the events. Otherwise, the MBM event counters will return 'Unassigned' when read.
 
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
+	assigned even when the corresponding RMID is not actively used.
 
 	"default":
 
 	In default mode, resctrl assumes there is a hardware counter for each
-	event within every CTRL_MON and MON group. On AMD platforms, it is
-	recommended to use the mbm_event mode, if supported, to prevent reset of MBM
-	events between reads resulting from hardware re-allocating counters. This can
-	result in misleading values or display "Unavailable" if no counter is assigned
-	to the event.
+	event within every CTRL_MON and MON group.
 
 	* To enable "mbm_event" counter assignment mode:
 	  ::
@@ -398,6 +395,24 @@ with the following files:
 
 	    # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
 
+	In default mode on AMD platforms that support more CTRL_MON and MON groups
+	than hardware counters, hardware dynamically shares a smaller pool of
+	counters among RMIDs. One counter from this pool is used per monitoring
+	group and counts every MBM event of that group's RMID. The size of the pool
+	is not enumerated to software (unlike "num_mbm_cntrs"), and "num_rmids" may
+	be much larger. For example, 64 counters in this pool monitor 64 groups.
+	Newer hardware may provide a larger pool.
+
+	On such platforms, while the number of monitoring groups does not exceed
+	that pool, a counter stays attached to each RMID and readings remain
+	accurate. Creating more groups than the pool can cause hardware to
+	re-allocate those counters between successive reads of an event. Bandwidth
+	values may then be misleading, or a read may return "Unavailable" if no
+	counter is allocated to the RMID. There is no user-visible indication when
+	this begins. Users who need stable readings beyond that pool should switch
+	to mbm_event mode, if supported, and assign counters to the groups of
+	interest (rotating assignments as needed).
+
 "num_mbm_cntrs":
 	The maximum number of counters (total of available and assigned counters) in
 	each domain when the system supports mbm_event mode.
@@ -1784,17 +1799,19 @@ View the llc occupancy snapshot::
 Examples on working with mbm_assign_mode
 ========================================
 
-a. Check if MBM counter assignment mode is supported.
+a. Check if MBM counter assignment mode is supported. Enable "mbm_event"
+mode. Switching the mbm_assign_mode may reset all the MBM counters (and
+thus all MBM events) of all the resctrl groups.
 ::
 
-  # mount -t resctrl resctrl /sys/fs/resctrl/
-
+  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+  [default]
+  mbm_event
+  # echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
   # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
   [mbm_event]
   default
 
-The "mbm_event" mode is detected and enabled.
-
 b. Check how many assignable counters are supported.
 ::
 
@@ -1805,36 +1822,39 @@ c. Check how many assignable counters are available for assignment in each domai
 ::
 
   # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
-  0=30;1=30
+  0=32;1=32
 
-d. To list the default group's assign states.
+d. To list the default group's assign states. Counters are unassigned when the mode
+is switched to "mbm_event".
 ::
 
   # cat /sys/fs/resctrl/mbm_L3_assignments
-  mbm_total_bytes:0=e;1=e
-  mbm_local_bytes:0=e;1=e
+  mbm_total_bytes:0=_;1=_
+  mbm_local_bytes:0=_;1=_
 
-e.  To unassign the counter associated with the mbm_total_bytes event on domain 0.
+e. To assign the counter associated with the mbm_total_bytes event on domain 0
+in exclusive mode.
 ::
 
-  # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
+  # echo "mbm_total_bytes:0=e" > /sys/fs/resctrl/mbm_L3_assignments
   # cat /sys/fs/resctrl/mbm_L3_assignments
-  mbm_total_bytes:0=_;1=e
-  mbm_local_bytes:0=e;1=e
+  mbm_total_bytes:0=e;1=_
+  mbm_local_bytes:0=_;1=_
 
 f. To unassign the counter associated with the mbm_total_bytes event on all domains.
 ::
 
   # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
-  # cat /sys/fs/resctrl/mbm_L3_assignment
+  # cat /sys/fs/resctrl/mbm_L3_assignments
   mbm_total_bytes:0=_;1=_
-  mbm_local_bytes:0=e;1=e
+  mbm_local_bytes:0=_;1=_
 
-g. To assign a counter associated with the mbm_total_bytes event on all domains in
-exclusive mode.
+g. To assign a counter associated with the mbm_total_bytes and mbm_local_bytes
+events on all domains in exclusive mode.
 ::
 
   # echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
+  # echo "mbm_local_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
   # cat /sys/fs/resctrl/mbm_L3_assignments
   mbm_total_bytes:0=e;1=e
   mbm_local_bytes:0=e;1=e
@@ -1891,13 +1911,8 @@ the MBM counters (and thus all MBM events) of all the resctrl groups.
 
   # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
   # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
-  mbm_event
   [default]
-
-m. Unmount the resctrl filesystem.
-::
-
-  # umount /sys/fs/resctrl/
+  mbm_event
 
 Intel RDT Errata
 ================
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

