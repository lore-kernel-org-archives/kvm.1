Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9A5381AF;
	Fri,  9 Oct 2026 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791589471; cv=fail; b=TZCQlmjIENDpHGOl27VVW1pAoNhZodl+BNo6RkQ9Rqmd4WHT7YoQb9As4ajmn8nv14skDvb5YkJjN4Vxf1No9ZuXgu7YnUNyIApdGyhQI8S3Wq9TembSH2umuj6h9VZil0NTVAOoE+0cCdAcDKepjBb5aag54229/Q0zbHYEfmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791589471; c=relaxed/simple;
	bh=ZWbUVrSauXWjhTjrjaU5hDUoht3m8KYB7X7tY5AaR1E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JJbko01BH9bFLhAvhirUVLYLW7lRBIPfXL/FIYySccRUGsj2+UboTTeWcWlF4HMxUA0U5rsM/UIlKsTlp+9Pg2yQoTFn8GyvZ8MibWP+3kj0jnZpx10pO4P0p6IJ50ammdf8utuQ/fmEcV2+m7KGO1c6Yiwois+jGyY/wKdHa4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WGWmO7vX; arc=fail smtp.client-ip=52.101.43.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WGWmO7vX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHGyaVE1ZeliwIItgjfp2brDbD4YF/lwb0p/tn2qywqL+FWo3Y1Xd1HxVZ7DiWQ0uUY6ZGKO1pc+9cw6y5H6vrF8QUYeY22okraFNisxG0rIxJ3F6lRR/RtZEFNUP8tDH7gksUaND9AZyPL14Q25XMusY0S273SEVjPVYCLp8j96R5Jus9gnzL0l4sSkrf5Xmq+bjg6fE1l6f0ca2Ip1Yg1vVvYnZWjD5K51oJssiyA+qJc1z5WfWhUdsZMv5RA9Wt0mWd1jCgZyPo+kk/0V1Zhxh9YIsdSVtNXaPWRk4tPuIRSrISWIDdaADWwPU/SE9s5OUh3HPgpU2vCf/WHpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afs7wO4B1RbTKybyw5EPZBa1xny/KObecDZy2pzyqog=;
 b=caXuFLfxI9JIYprr30CGWnv4TQnunVeeBB7hCdJ1r7I7iHcoIXUXi9tJfD4SL5zMAjUlrINAN/eIpJLe8R8B0Cse0Ldw7adaEuN4fJs8IEByZWZXFz1HvI+KmfnUjII7OB5//AK6S6Ao738/YwSMij63cz6G9RScX7vGPuNV/yEZb5nUhG3ZgPEXiXqcur9c2ogHhFceYUmxmutU9vsDrY9Yr+lkakS7G8aiFa4bsi2SO6eDgRNzjdVSQ4mdwBu6iY1D620LMAoPc5MGujyi7xxvmW3MDoFwcPm5zkUpU3UjI4KgT58oBEXr/wsG9XcwnzgKjnmHpZkXEhzJS2fTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afs7wO4B1RbTKybyw5EPZBa1xny/KObecDZy2pzyqog=;
 b=WGWmO7vXbXoNJpPArnqP5k2BfaSXzHYNASMijLS80EU2Hxz5iouStOj58jdW3/ae8ABA0exEUWqmzDAAClLf0I4vnaMCJ0bt5QHxGRBsLXOFn0P5n1dMLFp77gJILs3DED8PIV8gOcrFApMKFVAiQjyU6hi4J9hgMYDtiytjOjM=
Received: from BN0PR04CA0018.namprd04.prod.outlook.com (2603:10b6:408:ee::23)
 by SJ5PPFA5F0E981D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 23:44:27 +0000
Received: from BN2PEPF0000A98E.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::9) by BN0PR04CA0018.outlook.office365.com
 (2603:10b6:408:ee::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 23:44:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A98E.mail.protection.outlook.com (10.167.248.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 23:44:26 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 18:44:20 -0500
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
Subject: [PATCH v4 0/3] x86,fs/resctrl: Keep default MBM mode at boot and fix ABMC programming
Date: Fri, 9 Oct 2026 18:44:06 -0500
Message-ID: <cover.1791589412.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98E:EE_|SJ5PPFA5F0E981D:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa58ac9-b7c1-4805-ff08-08df265f4129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|82310400026|1800799024|376014|36860700016|10067099003|56012099006|260925021911599003|11063799006|3023799007|6133799003|261009223027099003|260925022911599003|18002099003|260925021311599003|13003099007;
X-Microsoft-Antispam-Message-Info:
	4jP4ZDf01N/sHu/WzXqKMw/EG7SOlS4dx0a68gqVnTRheVidtd6lrtGhioDg4CkhVmhGsDN3GpklT4pdDHiuo5nX0jkpo4zO0sagUpzHhUoZSZiMChBulpkRVPJt0FXBakAEYjz365/5cHH1tsrT1Yce9d3xZmhLJNWmW+3CwH51hyDFSg+jaHh7e+fmOBCMVfAVvR48Teg4j38FCtwPZ7YLqMtedYGOkQruzZ/Q9CcBkELITExL/wDN33wSDvjMFYc8wB6jpdQgSEWgI4DkA11lNQIrVjsrs9XpwrkFvgWi2KyoQVQB3GuhmhBPc7GRyzOt3eRmsHaDEyasYNBOx8SoeeUvg6g9gVS2tH6Hbo+erMaUOefwl0LPCsUV1upMLEfU8FvTTDkpm9tdz0c+YwAMPmcWxZc1QKEqJSPcH+1nYbhXkXPdNBFKsEtiDjvXLWsIIsNwJEM6lR8Q5Dqn0S25kZwJcA6QrG0IdusOBSBQ70zDEhhCBs3nzxO6Yb5SZaQgR+9kX/3Jtqgh4CTDN88Gvxi0cieYW2Dh7wrzhAbjbhVn7FJofV9gJV/58S0QznWgS8RafiIb9FER25OT9LSW4sQURacha5baF9TUFzMxTbaOpGGS6EdRYqyRYaqg1ZMbx26Gc2nEadV2VHvWSQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(56012099006)(260925021911599003)(11063799006)(3023799007)(6133799003)(261009223027099003)(260925022911599003)(18002099003)(260925021311599003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cU70orAOwNiFYHv08DLdeugwVNFlEt3V7GkPmLDQ3KxDgOgLk3e3XMNIs421T4TozZ2pm+KoQbNStdkejOme4GHyHreTPfLN3CRkTTWQrG/DeNhGx2iyyhv1/1dSyrehQiMwAE97Qp8LPU7YYPkElFvBqsKTYNdFiy4jVMd91XO6FVr9PJsbl9bRRZJAmcUwGHPoehWlOd45F2Jj/D6OFILfsP6N30Nl8XTY9DbOJ0hwdxZNZMivPePn0qDj685IVjSgAXESEBv4WhdkOrMbIIRrjt6TooTMgZRsMnoag0k/1JXwGJY9khn7PV+G7aGP3XeocdQOZ3x7sOszKFBQQCURc+wYSGdu1Yv1q0r1WpHySBPZK6ISP81SiktRaEsPzYxulJfdWKk3RHlKnO38R+hfMMJ+STio7ytxxn3TlzcnAF2SoCzLrVX+o3DIXpuY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 23:44:26.6484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa58ac9-b7c1-4805-ff08-08df265f4129
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A98E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA5F0E981D


Hi All,

This series restores default MBM assignment mode at boot, assigns counters
when switching to mbm_event, and fixes ABMC programming for more than 32
counters.

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

Patch 2: when switching to mbm_event, assign counters to existing
groups, including the default group, matching mkdir auto-assignment.

Patch 3: leave mbm_assign_mode as "default" at boot. This seems to be
the patch that has generated the most discussion. Let me know, if additional
justification in the documentation would be helpful, I'd be happy to add it.

Based on tip/master:
  6b27d3127c05 Merge branch into tip/master: 'x86/tdx'

[1] https://github.com/intel/intel-cmt-cat/issues/311
[2] AMD64 Architecture Programmer's Manual Volume 2: System Programming,
    Publication #24593, Revision 3.41, Section 19.3.3.3 "Assignable
    Bandwidth Monitoring (ABMC)"
[3] https://bugzilla.kernel.org/show_bug.cgi?id=206537

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

Thanks
Babu Moger


Babu Moger (3):
  x86/resctrl: Fix ABMC counter programming
  fs/resctrl: Assign counters to existing groups when enabling mbm_event
  x86,fs/resctrl: Keep mbm_assign_mode in default mode at boot

 Documentation/filesystems/resctrl.rst  | 50 +++++++++++++++++---------
 arch/x86/kernel/cpu/resctrl/internal.h |  4 +--
 arch/x86/kernel/cpu/resctrl/monitor.c  |  4 +--
 fs/resctrl/monitor.c                   | 47 +++++++++++++++++++-----
 4 files changed, 75 insertions(+), 30 deletions(-)

-- 
2.43.0

