Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E993DB325;
	Fri,  2 Oct 2026 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976426; cv=fail; b=Xg+T+fwH/LJvzUjKE9Fk0Heo+4s4x6jlNkrNV+fkp9o2ApHPiK8KrLk63pNzdYYu+79CvU3u7evq/PsVcsJkd/GEavgQg+mdqbFIq7W/Z+D5JzKfkYZg0qrC5jtco32G38ZqibLfH+DivHkj8C4kC8lP/x9BQthIGTSpIUUA9WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976426; c=relaxed/simple;
	bh=SpO3g5TjvjdyLG4+TvZ3u4ys9q6XsLNXF6O0VVlUeX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=APBt36s2zMprUlG0UPYvzO/6L6aTwjSS9n6z2x5RkmRDIiAWGEkG38UmATs1csugQBUGeA3AJSaubNCS9SDQFv8DnEyzGvyruKwk2ZGpzXlpyO+ipuf58pZ6INSI5ZHSUu56BcHdme5SB8NGb+DQ/hcrJ4hQHuJ8bwLAUhOtCpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D0hQlEVi; arc=fail smtp.client-ip=40.107.209.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D0hQlEVi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMTReFtu2cPo5MRBBaATIILqteTwznFF9hZ96SACYChqf6bjRSX/4R57Eu8GPPjw5p5QPkMs4ZrKHw/c3meZShIEvqFl5/1xXVcAovnUfbaIbuDE5bfj/j3rMYUTLHSppMO/1Q/i2D/19dUc+mrKKR8wTxV2Zd0Q9nwRhFGDDG0lD6EXROffY70AQEcpcffTwIzW4qCGuUnV573qXO7pEvETyoHEP3hLZVUWBOAyRMbgb5RpVWlQKKMBxGmlvZ5T5hix5a/EE3n4PlLTvtNvlkDwiXO3QD+wCvcPjmb4/Jj8bXcVk//KMTD1N4GL73ok+eCOTxF3MrOWpdBzatEztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFNkE9pfDKv2snzywxox0RnyAOtSmwoab855xgIEsWk=;
 b=PNyf259DRGr825wQ5oNwuBvTqoBQl9RYL7KJ21pI7DQlFKpDJBmizTwPvjsUY4Lwg2ObnXR65E2vzaEPMj3yV0ZVagkVFx095vaWaxmtYau+JKrsT9WQbX9aQHJbZwnMrY14wU2mjYuyhXDMMQtfwLMEHbVJocGQk9i4L9evxUUY5862xbBBijzLvLwdk/GTHnWCLc7oJGPlMWNGkJ4Z1sE3zW5xrtZg6UcEMuDecPhR48IT++8U7nmQH7ujKaSB8kJxDqAh09bynuKx4gl8fB2zZH7Mjmk9TdxCkCk3R7aB8Kae2HmkokqouWFvP/f5kmHK0v5KyrNIZesyR034pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFNkE9pfDKv2snzywxox0RnyAOtSmwoab855xgIEsWk=;
 b=D0hQlEVi4Pb9k6iguIN+fpyaT8oeEhhH9zdVmbNGrE3C3vJfDCJ3q6Da3tu+1Ajryqmv+2TLdhoPDLPagN4am1BDou4xLNBOrV0w+SJ9Kv7TmzTLh7xucL22myl49JHn+jprCIYfuU284iX3rhsQe4kfmwKZf6ifS6BEb6fS8Vc=
Received: from SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::35)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 21:27:00 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::15) by SJ0P220CA0019.outlook.office365.com
 (2603:10b6:a03:41b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 21:27:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 21:26:59 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 16:26:58 -0500
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <tglx@kernel.org>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: [PATCH v3 0/3] x86,fs/resctrl: Keep default MBM mode at boot and fix ABMC
Date: Fri, 2 Oct 2026 16:26:38 -0500
Message-ID: <cover.1790976400.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: dda6e19a-93c1-4fb0-4dfe-08df20cbe4d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|7416014|36860700016|56012099006|10067099003|3023799007|260925022911599003|260925021911599003|260925021311599003|11063799006|13003099007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VcXNGzTi1Xu0xcEQlPkM+HWKiYU+vtsQdjQd4NoSur6GIbxxRywldbisu9PDAsTeiCz+6Gys/AsfdClweI+7PGNvVjRvKxR7VpHR8tK8iKLhPEy60u+VVx65QMBctOWQTrR+eHJeKoK1JU6FGb5lgNZyMDHP/9hRh2O1P/GPH15HgrJjxkwU9Q+HaTVcd6HUCoFdMKNa1ivMnJMZiwXhDNuuvpm6TPN5fJpzw4iqD8gXoH7zNcm0wsfOhJmotqPz+RgbbgZQ2fbXizSPfOs99k+BGoZwuznKIIsuPBEcLMgEEsTf+BZJgvFzXZ5LigElpbvfmpP6duPBh96VFNHP8Gk2LYd/iVz1aE1OO1LK9pq0/cp+rk+dVAiyw8xbQhf5r5yn3apqmEFZGBMXwZz1cw4KdC+VdnfN9HaK9qkJC50mq7ThiLUouu+ANOrRRmFBnePDaLw/pJHHzP3/i+NaxqYYY69htZXGBIboSb+YIPvDquE5XWSZRDh1IEizQQ9SJzrrHUwFt5ReuWixZ+xi/yyZ6Db1m37hhuU+QDOGfLbsqu/rvKYlYFSpvv2AZR9EUO7atqb/3RiF97cJ2oWbuQ//KCYBAeWRlA3Go5cIXlpLTznWnI89iii9MO/ipa2+bZUhZINgVT0zgmkc5gGZ0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(7416014)(36860700016)(56012099006)(10067099003)(3023799007)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(13003099007)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A0gg80L8QocrkrA257AQB4jRtFoTTMoM+fCWnVbW3WAgzA1y/6vPyE40HTx0vsLYWoSECf+KxGsNJdIKZaipMNLktEU8PvhB5XZ5ry36EkJEy8tl1Qki+3uJvt4IKeuE6b53Mfq7a37+TbOmQQcfoKcImijutVgorlyYjBAOM2SYh/Ga5bR7YuUklv5efPWLRmiVm7mwnNAVJ0qeMP8ZzyJ8agNj1WNEa776qvn7IIZTxFh0/ecAeq3rIyyhtVQ4WYt/DNe5c0MoMjEEMy3yOgC0ZY7Kxem2ekCnk3s6LvwRVhcIZBL2kBG5TqnS3JWEbBekAwTMyETa1LHV8zMLKg4eY75TIN57pUsSwnMKpFN64/lJ0Iw7/CjgmfURBo+90VaOhdqqWxlwthN/Ont6Rx+lDD7kH5uNyjr0JDafR2pwUyD4xOO6WpXe1WNO7Hsl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 21:26:59.8192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dda6e19a-93c1-4fb0-4dfe-08df20cbe4d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306


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

Leaving the mode at "default" does not make pqos correct. pqos still
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

  1aeb52f7869a Merge branch into tip/master: 'x86/tdx'

[1] https://github.com/intel/intel-cmt-cat/issues/311
[2] AMD64 Architecture Programmer's Manual Volume 2: System Programming,
    Publication #24593, Revision 3.41, Section 19.3.3.3 "Assignable
    Bandwidth Monitoring (ABMC)"
[3] https://bugzilla.kernel.org/show_bug.cgi?id=206537

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

v1: https://lore.kernel.org/lkml/980f39d3a0e0d9f73925e362f835aeef070a1bc5.1784322818.git.babu.moger@amd.com/
v2: https://lore.kernel.org/lkml/cover.1788545152.git.babu.moger@amd.com/

Thanks
Babu Moger

Babu Moger (3):
  x86/resctrl: Fix ABMC counter programming
  fs/resctrl: Assign counters to existing groups when enabling mbm_event
  x86,fs/resctrl: Keep mbm_assign_mode in default mode at boot

 Documentation/filesystems/resctrl.rst  | 57 ++++++++++++++++++--------
 arch/x86/kernel/cpu/resctrl/internal.h |  4 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  |  4 +-
 fs/resctrl/monitor.c                   | 35 +++++++++++++---
 4 files changed, 73 insertions(+), 27 deletions(-)

-- 
2.43.0

