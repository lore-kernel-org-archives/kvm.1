Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D793403E0
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784610384; cv=fail; b=bIuHu+NQYZlIvj74vapO1tPC+q6+BsqnzovAFOlr9lI1IMAR+ANyfTOVfXjjFoXtBfNwFQeXAN8Hm6AWoN+9Y6qD3HcVixPnaZz+eGF6HINkJPIGzy7juZj3FkrOksP0UpLGEuSYQvTvdKx+K8ULL13xWEl1cZsGw17a7r+CsVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784610384; c=relaxed/simple;
	bh=yWP6MTIdcDmSLu2CUxSLTqlLRvK0vUjbcCenjNGd2fo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RXkXrJ+RCdJeTvVmagw2+RUegGZYG1xP648rEoDGFTHJC/7/Xid7gVNlUhMumXn+0CQ+bvdvgiVgRoINEXX0SyZ+yBzFMS4rRzZ+0tscalBXeZD0uh/fmmgc/3rbihmMQ4i51eop+UPsn7X+ja9ZouAPjSJC0yrfBaipEmsez0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BMdXqVys; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BMdXqVys"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IG04mNerweTSiCo8ug8KUnTBp+AyccSxKAmMiVvVElWlje1znOWY0rfqcHb13yNrjsAU9yWLmILENRyL3+4WrLXwNN7I1GIdVPEciy2lPnKyqtoV+UBbnjm/Z45+G9oXeDUaEHtnO7eBFmFoLU26eWj6x4oBxDJ64obScXQqq7auQiiXnYmqI8NtLH8KZUKnW7gt+iXhhSFOfY9NRmoc8+38P3o9xXJVimcMZp8YWKcAumMQdLkduLlXHluQTZNz8uLIe1+F8ZzhXXcYJO5T0P4E1IJQpd9ppCt6tXs+dhoz5Fg8gGirsGkkUND2djJtqT7OkBzL7m97o9WzlE7KAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sckwW7ZFhyXYdP4+CEvQLadLZQvtbXoBJRI+n8digtI=;
 b=cWLN6sP+lSBTBxtItYUnWPXcbNFfgLQIt49T0xeIN3i2PrcRhe49hIa+MsL7tOCOElWQ6EBQq7gIwb75bU5+dg+xHVfgQ1nz4fEDAEt0S56j9eY4rk/99KUEVnLaNKWBFCJ+T5UySGrmx92qNAZrRwDyEZp8S0hDERSLMkr0Wc+Nm/WZfEHcfp4Gtova/7B9RFhC7ms9hy7SPniK6Sz42hg/nBJehntgzoauz8OgGAJ88CTVShQl1GAe2NyB3UJFk4txt8JOIq8t6PGmdOfkwgxaUL+P9KAxTtzYQqPBaioJLOe08VlNPvamgsA9zyIiUPiiv5ThrlqBBwPStHcDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sckwW7ZFhyXYdP4+CEvQLadLZQvtbXoBJRI+n8digtI=;
 b=BMdXqVys0HxNe5FltoBW/xab3q5dDqjB8hwi62yNv+VsU/wjd6d8YWez7D8uBmOycQacoS2SsG1QrcpprOhsgDxTXNGxReGhPx+rWOXy06/SyROv5B8yazDHYnbjw8IjkFGKvlyvzqUYXJee6CEPrh1mF44zTuB30a9bP4iZHIo=
Received: from SJ0PR13CA0155.namprd13.prod.outlook.com (2603:10b6:a03:2c7::10)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 05:06:17 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::33) by SJ0PR13CA0155.outlook.office365.com
 (2603:10b6:a03:2c7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 05:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 05:06:17 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 00:06:13 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v4 0/5] KVM: SVM: Add Bus Lock Detect support and refactor LBRV
Date: Tue, 21 Jul 2026 05:05:55 +0000
Message-ID: <20260721050600.87268-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|MW6PR12MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bed3e4b-48b9-4f65-208f-08dee6e5cba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|13003099007|6133799003|11063799006|56012099006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	aCQ+wHNOF+hBG6dCD8NAA6w3ZiHmaaXnWegLu+9OXifK6Mlnf4q2HtO/lsKzVqi35ZS4SOH5SBDCyTIgVNxWp6fkCoBOnOyHAFS+jCUu6iKSK0x3VfJ8IRuisdFlaOEqOKPPlUBgxUsduXCWxmDjt0PJrF3amj3aw6C6uNab8keY17E9KTNH2VWSN4CT4nrbBMHhirQIKaYcQlSrpoYW1Ur1S1w/9tINAvhcTOsR2kt25DkOfOlpR2kEovgSm1ZEI2k1Qxxw2+B+YgVCHOrbXcnvjL7D5uLuZRslitVlEJT4Gbt10/+EHe1olzMbmHN8ZIF6bQPanq5dgS0Lf/KkqxmRc1toxd0z62IL5NWJ3nsgheRrsceUdMRB9XI30y4TT8eDzSNcCPK0Xe70wJVYc6C68tfUwxLHDzj8Pnu1yn4RAwg27clydOPygWheU+2d1iPcjOXYn+u9v/n+EFmxU2hJAAug1816/1k7wibl3WgiIjXUHSdGwARwLomikJFo1L3V9cMelPfi/m4YQbDjk0qmiYeiRjFCyQGbIMGT9LUBDbhmiGZM+YtXVBVffhG+D2Tpjtwr9jk2Ur7XGuSVs1GCQdgdW1zzrA3Qq0rL5aTSfcdXqrihZQLVwuqcw/5Bc623Q9bwuDBdcYhxQDVFnQnlflqSMX5iX5fi2pK06f2KefI0zna0EYY2jxXTrlzrCYJq7PnWafQvwWntujGgoA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(13003099007)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xtBUSegZvO+nrFLN9F1A2opf69+kTlGgbf/E0sdhv0dPC67FSYgxYAx6ckIY7OV+2xj4m7Ss9GqjLimQcdiR5NYI2XJycbtdDdGT2UqNUV+KAtavItvZpte/v1fL9DAu84ANfUw1aSjCgmr7EsshGl/iXAVK/xW29KNWSXU5y9yuLMZBgXV9fMKodkNOceQfrOoDS9/1ccMM4qiyb45p1g0KiKkMBPPeg0cLbTeUGY7G7e8RM7gMNlPyT6u3Jx44vt+/vq7qi6hDek4C/ALYGwq8sKxyTjr6oedmcpSPHuz19K0Tc/tUtG00X8fEfRNF8XzKYwGA//EBJJjsPfKYyA7wOxeDcUrthzbZpHzfRrDh63QC9bVZSzFBhUfNIDlvzFppy54e1zuYuyb/wnacXzLcYgbS8LRHmUMBz58vIfx6hs9iH0xGijGnlvtDeoVV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 05:06:17.0725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bed3e4b-48b9-4f65-208f-08dee6e5cba7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733

Bus Lock Detect (BLD) is a CPU feature that raises a #DB trap when an
instruction acquires a bus lock, allowing software to detect and act on bus
locks. It is enabled via MSR_IA32_DEBUGCTLMSR bit 2.

This series adds BLD support to AMD SVM and exposes the capability to the
guest. On AMD, MSR_IA32_DEBUGCTLMSR is virtualized only when LBR
Virtualization (LBRV) is enabled, so BLD depends on LBRV. Enabling that
dependency cleanly required first refactoring the LBRV handling, so the bulk
of the series is preparatory:

  1: Refactor svm_update_lbrv() so new LBRV dependencies are trivial to add.
  2: Sanitize V_LBR in the nested control cache and drop the now-redundant
     X86_FEATURE_LBRV checks.
  3: Use kvm_dr6_fixed() for nested DR6 so DR6_BUS_LOCK (bit 11) is forced
     per guest CPUID instead of unconditionally.
  4: Turn the DEBUGCTL_RESERVED_BITS macro into a per-vCPU helper (prep).
  5: Add Bus Lock Detect support, wiring BLD to LBRV, gating
     DEBUGCTLMSR_BUS_LOCK_DETECT on guest CPUID, and exposing the cap.

Regards,
Shivansh

---
Changelog:
v3 -> v4:
 * Rename nested_vmcb12_has_lbrv() to nested_lbrv_enabled() (Yosry).
 * Drop the redundant !lbrv check and the extra comment (Yosry).
 * Spell out in the changelog what breaks when DR6_BUS_LOCK is forced to 1
   (Nikunj).
 * Make it a pure NFC macro-to-helper conversion, and move the
   BUS_LOCK_DETECT gating to patch 5 (Nikunj).
 * Fold in the DEBUGCTLMSR_BUS_LOCK_DETECT gating moved from patch 4.
 * Collect Reviewed-by tags.

v2 -> v3:
 * Reworked the single v2 patch into a prep series (patches 1-4) plus the
   feature.
 * Rewrite svm_update_lbrv() as 'if' statements so the BLD LBRV
   dependency can be added cleanly (Yosry Ahmed).
 * Sanitize V_LBR in the nested control cache like NP/GMET and drop the
   redundant X86_FEATURE_LBRV checks (Yosry Ahmed).
 * Use kvm_dr6_fixed() for nested DR6 instead of DR6_FIXED_1 | DR6_RTM.
 * Compute DEBUGCTL reserved bits per-vCPU, gating BUS_LOCK_DETECT on
   guest CPUID rather than a static macro.

v2 resend:
 * Rebased on kvm-x86-next-2026.06.24.

v1 -> v2:
 * Used guest_cpu_cap_has() instead of guest_cpuid_has().

v3: https://lore.kernel.org/kvm/20260709082953.69434-1-shivansh.dhiman@amd.com/
v2 Resend: https://lore.kernel.org/kvm/20260629081018.60618-1-shivansh.dhiman@amd.com/
v2: https://lore.kernel.org/kvm/20251121081228.426974-1-shivansh.dhiman@amd.com/
v1: https://lore.kernel.org/all/20240808062937.1149-5-ravi.bangoria@amd.com

---
Shivansh Dhiman (5):
  KVM: SVM: Refactor svm_update_lbrv()
  KVM: nSVM: Disable LBRV in nested control cache when unsupported
  KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed()
  KVM: SVM: Turn DEBUGCTL_RESERVED_BITS into a helper
  KVM: SVM: Add Bus Lock Detect support

 arch/x86/kvm/regs.c       |  3 ++-
 arch/x86/kvm/regs.h       |  1 +
 arch/x86/kvm/svm/nested.c | 26 ++++++++++++++------------
 arch/x86/kvm/svm/svm.c    | 28 ++++++++++++++++++++--------
 arch/x86/kvm/svm/svm.h    | 13 +++++++++++--
 5 files changed, 48 insertions(+), 23 deletions(-)


base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
-- 
2.43.0

