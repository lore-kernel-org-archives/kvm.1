Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793392208;
	b=yDrcjf/eostPODNi9WRs8xnVEFmisOKZ7Xn/yGk772Jzusiu64C7K0B7gWpG/rio4ib8
	 qXh7CD3FRy0N8SrbV6RE1dzLbkM50fdsmhTK48ASYGYlQ8ZKlidAU0heCqwRXk/KNEw+M
	 Fp4Ym3/4MpeZucTB8q/fz2KihZJg6xWRWN3SXaNcpZmWEPIu0y6zqXXRVgtp7/PJgFyW/
	 1zUqF0mmPNEUkfT/ZjAxD1MjlS59nUXfTG6e7j5oioIpaAuRxQaIWc6t9/nUpphOIxRoy
	 xRia+N1tHbA4rXa9khI2/3ksP52iX+mqV3ZtRm7h0tQBButF8Oabdtnz+mGXetw8Quw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392208;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=EmaNip1TOWik2L9R1iLAFI2USINzDSLi+XTwnV4jqZI=;
	b=OgVdqmQk1ncyneszpaKPBhLM3lJKYzmz6Dj58uAb/arnzfsIPLzk/un2v+szUaIH8SvH
	 sHj1c6PgWWBRVNzCdOI32CqZcgh95Eix5U88YUWjSyZpTx1+tw6BwYd+vEZAMfOkp7ayV
	 uYj8eZt/VkEe47udle+kGwzIvRi78uymC2mwdMtDXsQ0OFMutot0ylpGRClHZQ5A/j/NB
	 lVIt8e5ruFmUfcSkY87kF8ywdUrUPeZsAZ/JiOAc995qjYNHAMTX8PmowMNkGQANuMmyN
	 4hpnhujDUr7xy59fQq4x4f60y/eoEKXsrvfBaSEFIWtmjwRxUhp1CAI2Xzqqa2i+CAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="SsfF/JSO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.41
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2B6606A31F;
	Fri, 30 Oct 2026 20:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A2B6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SsfF/JSO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teuObmaOFzZc+YfLZPRUwD6N/5IG795JA649mFp9aoQKLb5xvRBCg9zAi2KkiY6K0XUNf7xZft8D6rX2x0FXOBAgJYZKOzMaV4mco3VywFujc14nm8DN6QZlj9UVQTPlvZu/BVbHQZ7jtTgq1I7t9Du0ATvAIQW9zqQ7CV49+sh6zHY0M3nK55xMfJrgT8Kdta4flw3+WN6KR/0yLwrV3ojdybLILu1zIBIbp6v8zsZCbww6x5hQEIMfGWuVxM8rHzotTBu+NDRWr0pvqdP7OjjiVARJL25+rxmRihkysW/Tg2iRw/tnPmYmYP0Z1sDFndribfDayPrZvusOP41ndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmaNip1TOWik2L9R1iLAFI2USINzDSLi+XTwnV4jqZI=;
 b=ZrFVcVH2gIPA5l8dURmhTepUGeHZgmYXwyjZ2ZtnyJpzCH3YdhTe4CppZDYuJlzP4BwTqKKCnML7e/1gRtYJNK8gNek/2YWp+cyVTAumymva7N/Lv7IjhMQJhNZPF4oDVSu7RJ9eds2ltcaEqFL/yuvxWCdSRfrIrmb5BGTGPTiUGHrkuDY+fTbhRMHzjhkxZKdImJZKf4THoNLBTMzCE0erqZA6Ik2CbBvSbkQTHXL4mAGpZH9GhEysztJywL+4/8UddW4zpSet1mDXqL33CAtr520V8EnyFkeJDZMFTiw6TU41DtayQenPdrgoL8mEw9zXtbwa4jSUx0UNeSJ/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmaNip1TOWik2L9R1iLAFI2USINzDSLi+XTwnV4jqZI=;
 b=SsfF/JSOqHlo+o1hSnFgu6iK4KNKqyVAPjUfq/pG+9cXhiYrR+eajBeHFYKSYhuvFSDNUWO50ttiw86RxPsBArvnQcVQVOMxUCY8YiLwy53fXG2OWPTIWDdpXdsyKwHF7U/fEGmvnMOOmi5PF/UeH5I0qdiKtoMC4yAy4i4WlQI=
Received: from CH0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::11)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 20:29:00 +0000
Received: from BL6PEPF0006C3E1.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::9a) by CH0P220CA0021.outlook.office365.com
 (2603:10b6:610:ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Fri, 30
 Oct 2026 20:29:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3E1.mail.protection.outlook.com (10.167.249.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 20:29:00 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 15:28:59 -0500
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
Subject: [PATCH v6 0/2] x86,fs/resctrl: Keep default MBM mode at boot and fix ABMC programming
Date: Fri, 30 Oct 2026 15:28:46 -0500
Message-ID: <cover.1793392128.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3E1:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 470f7ec6-289a-4203-3703-08df36c46e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|6133799003|18002099003|3023799007|13003099007|56012099006|11063799006|261028144727099003|261026121527099003|10067099003|261026140227099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261009223027099003|260925022911599003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	Dn2CI/aBpbeQx3O6yP9SZMJrKKnhG2GGlB2KPDxyL7zpgoOl8TNADyCJRtdq0C6uS37rXSHe9sbUHFoZrL4r2rVWVwCEYBVYz7W9aUZe5owlW9w1Cc5QzM9X47RqiB66UKIE63buqqHgWMLhrBr/T0iAz7wcpZLckpTCYW4IUd/ZieQdBXevloIDaiwK5Yb8NpibEjmoOe8H/zNw9P35eJ2trSBN2K243t4207KCR8ERx3RCDyyiCLaqUGGarq/IPknyPZ8asdNG4w6YHV99Dpyg4t8e0HOimHyPSy5MsTEffGs9+X3Ye1+K7ufyH+zEcdVZ18v6/EEV0Pgksff50zDiY9Jx1fpi0MpADpavoqxHuMR++aDKZa3z2Xfn+AJUfaAugBxCbDUfCwUxA/bpqzAsLD2v3AMS8+nJUqey4uaIqUk1VPHGSaxLC7xbiYoZQqSs6tC42++iyTAJT+Buzk5LgEbj0oq9HSiNhxvguKT9dlUosnUiK3ueqjEC1EP0RApIAEdyAMZtABWajgSJ7A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(18002099003)(3023799007)(13003099007)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(10067099003)(261026140227099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261009223027099003)(260925022911599003)(260925021311599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zzGelTDW1+eCmlQC0OEkKEDxpQ3ONxYC22xrlcPpKWqYOQ/7H/XupQP0rdw1BS6DmTeYG6nxEdKaxPtS7Wl0Frf/6JytuEJT3ue+Yj18njrBBUppbMJYi2u8yFWtl8nBjPeskPQt4dqzm3Lm71Nt0uv8ciXyCLauPmiPCR7KChWwO4dTjrhRS5+k2AA/PmBNhUCAVfJOUiPddxV9q2VmxNMwe1KhLpHNytS4dgNCKPNetieUCqzPfzLGQc/gIjudIOYRWXwjNjIh14FcLHY6ThNo2G7DHYmYYNWeAeHVbJ6GjQfRlyd708fUTd89g0r7kOSPca0PAOyTM2ctwe4clP9SoyNoGzFs3MjpJvBqwcpXkcee3bo9cp+f675L5aloWRVuH+eb64C1UCIGGfHPjArQpPt6GCPiSnqrMbh9DgnddCkuy13ekg0zoiCueHqc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 20:29:00.5375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 470f7ec6-289a-4203-3703-08df36c46e88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0006C3E1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654


Hi All,

This series restores default MBM assignment mode at boot, and fixes ABMC
programming for more than 32 counters.

Commit 0f1576e43adc ("x86/resctrl: Configure mbm_event mode if supported")
enabled ABMC at boot. That breaks the pqos tool from intel-cmt-cat [1],
which treats a non-numeric event read as zero bandwidth. pqos creates 16
or more groups and uses two counters per group. On a platform with 32
counters per domain, that consumes the pool, so further groups read
"Unassigned" and pqos reports 0 MB/s.

Leaving the mode at default does not make pqos correct. pqos still
treats "Unavailable" as zero. Once the default-mode counter pool is
exceeded, hardware can re-allocate a counter between reads and pqos can
report that as a wraparound. That shows up only after the pool is
exceeded. Default mode uses one counter per monitoring group. On existing
AMD platforms that pool is 64 counters and may be larger on newer
hardware, so common deployments stay within it. mbm_event mode uses two
counters per group, so the same 32 counters cover only 16 groups.

mbm_event remains available as an opt-in. Users that need stable
measurements beyond the default-mode pool should enable it and rotate
assignments. The limitation of default mode is documented.

Patch 1: widen cntr_id in L3_QOS_ABMC_CFG from 5 bits to 12 bits, and
limit the enumerated counter count to 4096, which is what that field can
encode. The APM [2] at [3] will be updated for the expanded cntr_id field.

Patch 2: leave mbm_assign_mode as "default" at boot. Counters are not
assigned automatically. So, update resctrl documentation to replect that.

Based on tip/master:
  6b27d3127c05 Merge branch into tip/master: 'x86/tdx'

[1] https://github.com/intel/intel-cmt-cat/issues/311
[2] AMD64 Architecture Programmer's Manual Volume 2: System Programming,
    Publication #24593, Revision 3.41, Section 19.3.3.3 "Assignable
    Bandwidth Monitoring (ABMC)"
[3] https://bugzilla.kernel.org/show_bug.cgi?id=206537

v6:
 - Patch 1: No changes.
 - Patch 2: Minor changelog and mbm_assign_mode documentation updates to
            reflect that auto-assignment on MBM event switch is not enabled.

v5:
 - Dropped patch 2 from v4, as auto-assignment is not a requirement
   and should be left to the user.
 - Patch 1: Added Reviewed-by tag from Reinette.
 - Patch 2: Fixed a few typos.
            Auto-assignment is not a requirement based on our discussion.
            Updated the resctrl documentation to reflect this.

v4:
 - Patch 1: Updated changelog(from Reinette's input).
 - Patch 2: Changelog update (Reinette's input).
            Function comment update for rdtgroup_assign_cntrs().
            Tag order update.
 - Patch 3: Introduced mbm_event counter pool and default active counter pool.
            Removed duplicate texts in resctrl.rst.
            Re-arranged the tag order.
v3:
- Patch 1: drop the 32-bit u64 change and the bw_src widening. Cap the
  enumerated counter count at 4096 instead of truncating the CPUID field.
- Patch 2: clean up comments. Add Reported-by, Closes, and Cc: stable.
- Patch 3: document one counter per group in default mode and two counters
  per group in mbm_event mode. Describe the default-mode pool and the pqos
  wraparound once that pool is exceeded.

v2:
- Added patch 2 to address Sashiko's comment regarding the documentation
  issue. In fact, it exposed a real issue. When switching to mbm_event mode,
  existing monitoring groups should be assigned counters whenever counters
  are available. This provides a smooth transition between modes and aligns
  the behavior with the existing auto-assignment mechanism.
  https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com

- Combine the two v1 patches and add patch 2 (assign existing groups
  on mbm_event switch; Sashiko review).
- Keep boot-default separate from the encoding/truncation fixes.
- Document the default-mode counter-pool limitation.

Previous versions:

v1: https://lore.kernel.org/lkml/980f39d3a0e0d9f73925e362f835aeef070a1bc5.1784322818.git.babu.moger@amd.com/
v2: https://lore.kernel.org/lkml/cover.1788545152.git.babu.moger@amd.com/
v3: https://lore.kernel.org/lkml/cover.1790976400.git.babu.moger@amd.com/
v4: https://lore.kernel.org/lkml/cover.1791589412.git.babu.moger@amd.com/
v5: https://lore.kernel.org/lkml/cover.1792627082.git.babu.moger@amd.com/

Thanks
Babu Moger


Babu Moger (2):
  x86/resctrl: Fix ABMC counter programming
  x86,fs/resctrl: Keep mbm_assign_mode in default mode at boot

 Documentation/filesystems/resctrl.rst  | 87 +++++++++++++++-----------
 arch/x86/kernel/cpu/resctrl/internal.h |  4 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  |  4 +-
 3 files changed, 55 insertions(+), 40 deletions(-)

-- 
2.43.0

