Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792627112;
	b=1vLIa7ooTc7Ti57qGJKgCELIpYiDPo7VraQdzDDDsgjcu6h+oO0kdqc9+wtfPOBzEUoR
	 CpoZmvS+gAL6N1KtDzPdr5dUGLjPPSdI9gcz62R6ucTsJZJCf8+jxm8lPdGTujgvJWdAE
	 XpxjEPI8PBrcZBzU5X1thXGFNNx4bO1pZyh5RP8r8xNRGD8xItfN1jNmlVoT7Q36EcFSX
	 8piBU6JSRbFtyz43mrTKBEcNYt5JokGJCtBQN+ZmYdsk9/H2LnKn7mEuaUhS06iVSM8J3
	 Drx+STWyn46BePUwXHBj4eKxv1UEd8iOJFdgGWec++Ioiegtx+ZEebZtF5EBNPYbvmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627112;
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
	bh=JgBIAQYzbu66xN+vT1H3QoyaoW97mbzNmjjQNakGNSM=;
	b=WyBN2LyVTGWqeVmv+CLfNCTQwZo+qc8KgpKdTd+3MT6cvtYUpEvy2FDEY9yDrcm76EnW
	 kEVu9ktm5MD8ODC4wF+tb0vSi0iIVQZNXRbCA51RvpSZqlxIadkPQtCymncPNVvHhF19V
	 Qm3xrVm64DDKrAzbqL645xJq31EhCYJt1ar1GemYVOSYPpTkmSWlA4+qRSMT5NG3HSiCW
	 +ivjc7BKdah5Cg5idk2VUjtljgmErs70AbClFNZ7Fc4ZkfldIwv/zhDQ9CNbUPHE+BCvA
	 wg3VbC+IT/1H7fCdv0F3EZLxAlTodndzmzzFqwmHdBE+efQWcXbRWxJzsqgarH6CCCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Rh2T1+UL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.33
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0E606A323;
	Wed, 21 Oct 2026 23:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73F0E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Rh2T1+UL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qa5PNxrvDtBUN5CwNqbQCvpbQ9CiBiNyD/wXiSFGSkvdWqn621TA0Z1vs2+lneNuAgxsuiriEvpeeWD4jBmco9Df5nvrIzERnfUTOfned93TjvoSlJ/pWBhdL7Z1N/op8myeheTxeuC6wiLKIR+L3+l9IScaDxhLQ7HFZ8LsPNRO6e/1uTocFwTdHIkTVlAqC5KLcD/N+o65Mz/6R1fwPm+Ql4Dxki2fDVSaQc16ReVj1idT+5/Dw+46Pf+dDYyVRQhXDeoKmjvTeMVFalOrlgp/deJK7jLyaeGKTRVIaILiLS4SsbIb0Qqcr6slIaJKyapVVd95f07chV01/TgTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgBIAQYzbu66xN+vT1H3QoyaoW97mbzNmjjQNakGNSM=;
 b=mO7ndO9JUFL9s1vD9vfezWZsnPGd5uhiaiNYv6nwjYIGAgs4/HMaBwgqHlNOO6hGKVLKwgPbLO/q5OhXfUzPKUqthnzYe3k41sd1vsEf8kwo21E3G/C9AqRPeoZXNNOU7LL8mnt8hyx41t30igoFjosy34UClFX0kijci4ByvQeqfwFTjNNMyRi5+qR53LqH3h+WT6jH7xg6XIRe6NGmpaiHY8YYwcN3jsoJ4a3HUOknarz12nLOyKaA3RYeD+9Pvvckt1kjKVmRciW409O4EYIUhX1qchbRaTO/WztZSklmF2jNhqzb8Biih7P14e5PX9k9Ns+qfgihD+UsF10duA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgBIAQYzbu66xN+vT1H3QoyaoW97mbzNmjjQNakGNSM=;
 b=Rh2T1+ULax74TNW6xEmIujTdPnrBgwau94bAP15hHmnuZu8qO2N7Jo1EghKyscrEnA3nRQ4kkiQE28Uai7KHOmO1RDVv5oEJHrZgkoFM1e53QUkziGR5Dk55PBpOsMBF3XMTzPJG4yg6kHM5nk1zNo0303w8QAoVdsE7ZfTTNUA=
Received: from BN0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:ee::18)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 23:58:24 +0000
Received: from BN2PEPF0000A992.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::73) by BN0PR04CA0013.outlook.office365.com
 (2603:10b6:408:ee::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 23:58:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A992.mail.protection.outlook.com (10.167.248.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 23:58:23 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 18:58:22 -0500
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
Subject: [PATCH v5 2/2] x86,fs/resctrl: Keep mbm_assign_mode in default mode at boot
Date: Wed, 21 Oct 2026 18:58:02 -0500
Message-ID: <1a8f3900e9e14ec19f5f7204fd64716eb0aa8427.1792627082.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792627082.git.babu.moger@amd.com>
References: <cover.1792627082.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A992:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: ae87d9ac-8380-4ec7-1640-08df2fcf312e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|36860700016|82310400026|376014|260925022911599003|11063799006|261021121427099003|56012099006|5023799004|260925021311599003|260925021911599003|261009223027099003|10067099003|261021123027099003|22082099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	kj/6huEEZ0q8nfDtacsB/5NmaRZKgNhwep1S1Q0gJkH+i9ElrUB2ssV58WA9++BnZkpPa29vp81IGRikOAGWFqCScbMS9JvAft48rogcHzdxnVPjrb6GeERZXo6lmkEJZISlyMFI2a1SlESmWuE7TnEyLSCSilbI69RSR7CxFUTnhld0/LtqiQ22LHOk4vSlUf2EC/xG6tTt2VRPr5kkyoYcR3e0S2flT4wKn6jKS6QEzhBuZPv2Xa0vUiBvn878HjvCbdsNt3bToCunv5vLYPeJ2cuc18KykyiRLdoS1ego+qc6AGQ58zyTgoh9YOOZM5Ru6FuHMyUKG2xxanWDaTO+6dDnuzgEzxiVMu27d92gg//PPTj2wALDD/MX2POPgiWgjgAYErKQo/ZREfaohwZNRY2V1Vn50I5p1ASj9HrwWUR2Wfv9eQqRNlt+xEv7c1f9xXrej/Bp/39We9O2eAIhh+6Uhk7LLXoomVdR+z9eN7cr+i53f6WW+MgxsidDIi5Yk5Bj0VVb5r/X2YI4IR1hiAv5TAwnDauBluUWGRN7oifez5b/c97fWk3kwfjT/KF5wqfBf+aU1Bgidtgz6o1DmTLekVOYcyeLpJoLFkIbCoZJ6SiOxbisgJrwRC2AnjBeCZ4JnfmomqQbWe+Cwy13ysXOtTxCgkKUOaZVKzk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(36860700016)(82310400026)(376014)(260925022911599003)(11063799006)(261021121427099003)(56012099006)(5023799004)(260925021311599003)(260925021911599003)(261009223027099003)(10067099003)(261021123027099003)(22082099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V7DcQzUZ/VhXjS6ZmNPB3xHIlG0JHE02O1MYWAzGS/lgXVu6i+aUxuuoZAcmxqBMJpmBu8uQPNIlMSTnPjyEgmp6xjlvWe16ok41N6GN/hIBhlfjNdvBBXRD54//RThzkupIb5cA5rNdlrciI9TGKSkRmz44AM3EteCekYrLNH20Ju1vF3cELWEtFcvNG0UpHphIzbO8rBqWPwZMSj7mLje1WG3dJEbFuJBftwOvzAFb62knuieJmB1B59tthPRKnOCsk4okoyDfYCbh6NkiLsJjgWinrsHokHD7c7OvKgV4GEQFJZepbiQxXboiSm/ttMrQoLJClejzJRQBo0mcDQq+66lzskMSB2iGT7gA76Bq23WJMhd+W58uRKYialhJL8z7oEUWzrtE3EZtQ5GOqrWh50P89GvdIRlxyFbXi2rArEm8AXMCUl6c7R4xr7my
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 23:58:23.9307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae87d9ac-8380-4ec7-1640-08df2fcf312e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A992.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111

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

  $sudo pqos -m all:0-4
  CORE     IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
  0        0.76         60k        32.0         0.0         0.0
  1        0.45          1k        32.0         0.0         0.0
  2        1.57        107k        64.0         0.0 17592186044184.9
  3        1.62        276k      4928.0         3.2         0.5

Users that need stable measurements beyond the active counters pool should
use mbm_event mode and rotate assignments as needed. Enable it with:

  $echo mbm_event > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

Fixes: 0f1576e43adc ("x86/resctrl: Configure mbm_event mode if supported")
Closes: https://github.com/intel/intel-cmt-cat/issues/311
Signed-off-by: Babu Moger <babu.moger@amd.com>
Cc: stable@vger.kernel.org
Link: https://github.com/intel/intel-cmt-cat # [1]
---
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
 Documentation/filesystems/resctrl.rst | 101 ++++++++++++++++----------
 arch/x86/kernel/cpu/resctrl/monitor.c |   1 -
 2 files changed, 63 insertions(+), 39 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index b52795e03303..fc3ced99e3b7 100644
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
 
@@ -373,20 +373,35 @@ with the following files:
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
@@ -1784,62 +1799,72 @@ View the llc occupancy snapshot::
 Examples on working with mbm_assign_mode
 ========================================
 
-a. Check if MBM counter assignment mode is supported.
+a. Check if MBM counter assignment mode is supported. The boot mode is "default".
 ::
 
-  # mount -t resctrl resctrl /sys/fs/resctrl/
+  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+  [default]
+  mbm_event
+
+The "default" mode is enabled. "mbm_event" is supported but not enabled.
 
+b. Enable "mbm_event" mode. Switching the mbm_assign_mode may
+reset all the MBM counters (and thus all MBM events) of all the resctrl groups.
+::
+
+  # echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
   # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
   [mbm_event]
   default
 
-The "mbm_event" mode is detected and enabled.
-
-b. Check how many assignable counters are supported.
+c. Check how many assignable counters are supported.
 ::
 
   # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
   0=32;1=32
 
-c. Check how many assignable counters are available for assignment in each domain.
+d. Check how many assignable counters are available for assignment in each domain.
 ::
 
   # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
-  0=30;1=30
+  0=32;1=32
 
-d. To list the default group's assign states.
+e. To list the default group's assign states. Counters are not assigned
+automatically. They are unassigned when the mode is switched to "mbm_event".
 ::
 
   # cat /sys/fs/resctrl/mbm_L3_assignments
-  mbm_total_bytes:0=e;1=e
-  mbm_local_bytes:0=e;1=e
+  mbm_total_bytes:0=_;1=_
+  mbm_local_bytes:0=_;1=_
 
-e.  To unassign the counter associated with the mbm_total_bytes event on domain 0.
+f. To assign the counter associated with the mbm_total_bytes event on domain 0
+in exclusive mode.
 ::
 
-  # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
+  # echo "mbm_total_bytes:0=e" > /sys/fs/resctrl/mbm_L3_assignments
   # cat /sys/fs/resctrl/mbm_L3_assignments
-  mbm_total_bytes:0=_;1=e
-  mbm_local_bytes:0=e;1=e
+  mbm_total_bytes:0=e;1=_
+  mbm_local_bytes:0=_;1=_
 
-f. To unassign the counter associated with the mbm_total_bytes event on all domains.
+g. To unassign the counter associated with the mbm_total_bytes event on all domains.
 ::
 
   # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
-  # cat /sys/fs/resctrl/mbm_L3_assignment
+  # cat /sys/fs/resctrl/mbm_L3_assignments
   mbm_total_bytes:0=_;1=_
-  mbm_local_bytes:0=e;1=e
+  mbm_local_bytes:0=_;1=_
 
-g. To assign a counter associated with the mbm_total_bytes event on all domains in
-exclusive mode.
+h. To assign a counter associated with the mbm_total_bytes and mbm_local_bytes
+events on all domains in exclusive mode.
 ::
 
   # echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
+  # echo "mbm_local_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
   # cat /sys/fs/resctrl/mbm_L3_assignments
   mbm_total_bytes:0=e;1=e
   mbm_local_bytes:0=e;1=e
 
-h. Read the events mbm_total_bytes and mbm_local_bytes of the default group. There is
+i. Read the events mbm_total_bytes and mbm_local_bytes of the default group. There is
 no change in reading the events with the assignment.
 ::
 
@@ -1852,7 +1877,7 @@ no change in reading the events with the assignment.
   # cat /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
   121212144
 
-i. Check the event configurations.
+j. Check the event configurations.
 ::
 
   # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
@@ -1862,7 +1887,7 @@ i. Check the event configurations.
   # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
   local_reads,local_non_temporal_writes,local_reads_slow_memory
 
-j. Change the event configuration for mbm_local_bytes.
+k. Change the event configuration for mbm_local_bytes.
 ::
 
   # echo "local_reads, local_non_temporal_writes, local_reads_slow_memory, remote_reads" >
@@ -1871,7 +1896,7 @@ j. Change the event configuration for mbm_local_bytes.
   # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
   local_reads,local_non_temporal_writes,local_reads_slow_memory,remote_reads
 
-k. Now read the local events again. The first read may come back with "Unavailable"
+l. Now read the local events again. The first read may come back with "Unavailable"
 status. The subsequent read of mbm_local_bytes will display the current value.
 ::
 
@@ -1884,17 +1909,17 @@ status. The subsequent read of mbm_local_bytes will display the current value.
   # cat /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
   1566565
 
-l. Users have the option to go back to 'default' mbm_assign_mode if required. This can be
+m. Users have the option to go back to 'default' mbm_assign_mode if required. This can be
 done using the following command. Note that switching the mbm_assign_mode may reset all
 the MBM counters (and thus all MBM events) of all the resctrl groups.
 ::
 
   # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
   # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
-  mbm_event
   [default]
+  mbm_event
 
-m. Unmount the resctrl filesystem.
+n. Unmount the resctrl filesystem.
 ::
 
   # umount /sys/fs/resctrl/
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

