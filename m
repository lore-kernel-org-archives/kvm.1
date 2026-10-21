Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792627097;
	b=0VTaJvgqjvBeUahq7Jon0SAkvIWPnpRBStMxwNEmaamLKRtls+EdjF+a9LyQLaBzY9hQ
	 wssHHwZXH9sC9gT5ccSlEgL21iU8by5QBa2ZXySPGsy0APFZZPc0HQz4ZWhPSHWXU2YM+
	 aS5XwaJcGBPPXikoxg9nZZMIpwslATaJtZmzGW5cJHoIu0iN7e7fzRYjnHxSPxN/em6XL
	 MM/baLngjoX5JeaPBJwntIS//1Ml64FS/dZfZlTasnIu7zBxLIL4PjAGbLuf5N+DK3PSQ
	 vdzE++Z0C2GqZHGjStKhVneNR0XioAnjEW4le4RGXomSJYkXWGH01QQgTHF9ZEJiR0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627097;
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
	bh=PVO/xI+Q6StmOq54Kw84feMW9Wpfq5xDoAh0/gYL794=;
	b=O75n/ruAbqruQngXdHYRR9ND4PEorVSbOXzbW3nhFtpkJB3WFiGMNEEEi7fAWTQlgqHo
	 Sb/BB1gAr8DK6dBCTJCCe114dBpmUsT6AGYTom/qSVSwH+Rs6ItfVlsjckyRraqtTGil5
	 k2QkW+U8oREQ1/80BbySi1Vnn0pdz9EAR/deoItiSm6GzTg8N0U6Memt7gWX+BqIyExE4
	 6boLokwfAIGkbOR0TOnYuT4+3uO+AtEuu/FYX0mpP148fdYDtShWpa4mMpX0ZbnMZBvkA
	 8nQ8t57Xvqtw1xjYRsIBbp7M63IW8JVmc/SBJFALB2Os1LuwUtejf4NCmCYVDanhuEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tPUlbtZ3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.34
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013034.outbound.protection.outlook.com [40.107.201.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C87606A319;
	Wed, 21 Oct 2026 23:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C87606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tPUlbtZ3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEeBcpKcVgD/FSd9HuY4MBUDXssuc43Li+owy0bi5MAYdtPrgyBby4Q4nC76ACL6a9dbxmDYlfSCJkn+LE/uAH2QOtq/dzsL6hOxKrW/qhL7PBV6BAtkOlVAUFZ4F2wob2nmd5FgejA4268zPb6TYSis1IqbqeOaNDFIPJLYyoxCl4BjUUpsi3SxqVfkV3D07gZ/V/Kysle6lI/9efFYNyOmiHwm216vDZRRM62TpZ6V77J7xZ/MExsFAQoZza5gGz4gwbt5OUq3fEg5eIud1lCu/KunGuTHGEsi3PYRSfdyRY/kscN5G3WdNXdi7kJ1jJnnoob/bAXnJCSmrjrPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVO/xI+Q6StmOq54Kw84feMW9Wpfq5xDoAh0/gYL794=;
 b=Ka76+TMM/ogYqT56O5mJ3Z6CVxZY/yT4k0vTtdRcgOSreLAjdBIheVO7YndOsk1xK1J20l1jFTpD2etNWJVMDk8zUivUMmWzbIZfV+d+5O1iqlqzlA+wF2m+WbxoaSYSAoBK5fy8H5+spsIZ7Iq0W8u+4JQBqW+YuCZW2QpO8m81++GGKhtAqKDlXpoX+CSOgo3QCi7VG7M2O9e5ZSVPb4DozmyajlUxszg2GCIihDNYWGpoyng9ntYqP9YRrlY/BxciCbMjDYP+LSH9Y+aayYKgU1KAJpUWSmlOv5+kdag9Z+e0o3a+r9T7s3u3OsT6F6W5P9v3DYmrw5GF/Tp3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVO/xI+Q6StmOq54Kw84feMW9Wpfq5xDoAh0/gYL794=;
 b=tPUlbtZ3F6n2mHifaB5RzChMDktII9U9lhPhyRQd123n/wS8kUG83bZpgM+wu9ytNe/d/PMLfl/Hk4hNaE7TpO2/boKqj1VH+K3O7Sm5prUlU5muXkb43u8gA4TWciUzdhoVl8FEv5sHihCb1pbKZp2cfIm3kwJ0Onf/zGDwi1A=
Received: from BN8PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:d4::40)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 23:58:09 +0000
Received: from BN2PEPF0000A994.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::ae) by BN8PR04CA0066.outlook.office365.com
 (2603:10b6:408:d4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 23:58:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A994.mail.protection.outlook.com (10.167.248.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 23:58:09 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 18:58:08 -0500
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
Subject: [PATCH v5 0/2] x86,fs/resctrl: Keep default MBM mode at boot and fix ABMC programming
Date: Wed, 21 Oct 2026 18:58:00 -0500
Message-ID: <cover.1792627082.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A994:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 630e5f0a-42c0-483b-ab1b-08df2fcf286e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|376014|261021121427099003|6133799003|18002099003|3023799007|13003099007|261021123027099003|11063799006|260925021911599003|260925021311599003|261009223027099003|10067099003|260925022911599003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VHzHRhMaF39vURY8ophowf/xh2LcVEmnFXYdqLK9uI/5b5/aefaAetRtsH/EmQLmHx4A8H6gw8WxvgQariVlSznYUkayxywodphdgYyOlwS2eztQN3zmte/WOoGQm7u+hS8EmRmPS3WB65CtBKjIXQO8K4/OlsJNXxxQCFZni/w5yiMTJBOsmxQ1YFwR5rB+3VgWPh7Q7p42cqXy0KWZ5Bf+nT1wKw34pFDYZdrd6KZnaNyQ4CUSJmnq/9yOw9QI3FuONrcGJzwIm//In82vWKRCoNLu58pA++4iu8uvZgrOl9LZAsEIntrdzUEF0ZTL7u/8LdviCJOJSyiFjct5frYGmWhiuVJN4sIo7QT4mT08fvLEGh7P3iOk9mFNuCeQucLu4Zx2JgeSXoA0hDZnQxM14DJaAFuPVWWqSFBS8+3hvtt6mW8iwnmu0YLbJZFwuSY87pXHkfreaO3QYEjBebIaW8P/nUhvbT4pQZTx5/mzDFjZfT7uvDEaZ2btoYbM/Ig5l+7DhivOqU6kNLzlg8gsiXfnt0V+f0/WYm9Qj6lZgVPKZcgR0fHoLoAUjCQuf1Ivg0qtrqHaGe1qVMn29UkoNc8QjTQEpuMD1vbYrbLglmUxCr58YbrkMXdBII6LyHLAd059yg+gE5ooVKD6KA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(376014)(261021121427099003)(6133799003)(18002099003)(3023799007)(13003099007)(261021123027099003)(11063799006)(260925021911599003)(260925021311599003)(261009223027099003)(10067099003)(260925022911599003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ktSMrNvyp26DWgqO9qsi93yChh8ooswIUPwGscFc7D5JIiCbKyBE4je+CPlskLxBuK+aN8Xh+nLvR/sdKDIZ5vr2gH4wq+KwV5r+6YBwEOjWoHMEcIfI3ZQjkgzu0XhSKuoBZzwCYBoQ9IHFcXEHm4CMZx1Op7MfiZV8Wp0frO6bJ9UY2xyQr1cNChIA4HRR+PrnAk3UPbK4I4IgYN+s0M7hgWuFHn/DxvK7/S9YCtDiYIywctW8nf72nhmHA8or8m+QRO43ugS4dE8IEDq5rqcgwH9sNfb3xw3+gB6/iVnKZjGjGgPLRJs1Dvh0/xNPX8KswgFxrXv9wOBrgMnu1P7x3ZimIQKKHKq/12MbDQhIK6TWyUOkZXKF3trAvsZn3yQZwS0wznylw7yt00biQy1mPGxVyNZH3C91pQ+zTEJ/eos/2IeE530K1z+6ttij
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 23:58:09.2577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 630e5f0a-42c0-483b-ab1b-08df2fcf286e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A994.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894


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

Thanks
Babu Moger


Babu Moger (2):
  x86/resctrl: Fix ABMC counter programming
  x86,fs/resctrl: Keep mbm_assign_mode in default mode at boot

 Documentation/filesystems/resctrl.rst  | 101 +++++++++++++++----------
 arch/x86/kernel/cpu/resctrl/internal.h |   4 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  |   4 +-
 3 files changed, 67 insertions(+), 42 deletions(-)

-- 
2.43.0

