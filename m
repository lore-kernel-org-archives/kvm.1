Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013067.outbound.protection.outlook.com [40.93.196.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE9352C54
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 04:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829864; cv=fail; b=DjCQwGKG5sGlycjSL03DfpC8EZccztei9atWU/Z31/rJ0Ai24BB6/IN0wACJK5pDlJ03cqQSDcRWf/2TWYNl2Xk4FnjJoeR2ZTtlVRzuRmB1jUz9pCDTMD76FNF8PM8IGe9/rRq7PFLlw/SIliH2234jCth4rG7qlMQUhM64bg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829864; c=relaxed/simple;
	bh=N3MBqdCtCSzaB785eOjeg8kI+Wd6yCMdzNyLaPqC6fA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=crF7SQ3IpTcn1UeQNIGP0jnsDjOiHcC9jG+K0KtXvX8P18dNnOqDbCwYPtfJMuTfTy5iMkpzFz3fRbKAP0PnYbUxC3XEjXmuLlQgGIhwH21tvWnLFzzpJRj86wfjf11Gm8Ilsx25c0gYoP60eTpbZjE/zeXeuWKa9jM1PuBDDAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RKLEBAeS; arc=fail smtp.client-ip=40.93.196.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RKLEBAeS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRJvgEqMbfztrwEXfu48FMPoCbz9Nbt3MqsWZMTtCN/3JH0AMxctPWcboC+PSiWvcC+GRnBVDdrZArMCOmTR1/GEzMTpDqKEa1okx+lQ1JK9cwuuMNZNwZnnaL93tZbi3LestzRr5Tygp++1MmtiuTGLdVGQrVhn4D9x3EyMuO/SGTpgcBJ9RKvg4WpxedIbksqIvV6Riy2cougew3gmQ6VEgzLB81FaniCGCWQrDP+DFI0WFuaN1DkSIbwcCbmHuioMk9rOpwMuMUa9eYnmZTWc8xsld4i2kADr6d2FMqPY7ZaCDpw7Q42qys9MDqjVT/K1KAWdVKK2VYnMQNT0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDeIgzzsYQRXlul7SA7Em5IZ/+ZI4jSWBskdQpo7lb4=;
 b=GAI4MM7b1CxsRV6Xw8F76fF455hf6hSbfB/Dm5WwK5RQZfUaO8Kv+kwD1DvtAuAFawJ/tvEaItng5ppYkwB0UOuSU5kAZmvofffNYjFu6Ft0GUbSH+Nm8MCP1WbMwtWt3fwOpiutVg81jAS5qtaBE+uyX1OPSxIqnqdYdoYf/INZ7J3CvIItdgHkZTQToNMAE+KedOoaPxyeUFsiyXibXtVkIny04AUBpFy0DOJD6anXBvfY6BRSfbVghx1boY9Mc/778irMhCkvHHDM2WRXa1D6txzY7g4qL9HutY4T8h90x/XXdHhcHBwlpRWDF2fSh9yQeU6yEs+SBggrxCY2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDeIgzzsYQRXlul7SA7Em5IZ/+ZI4jSWBskdQpo7lb4=;
 b=RKLEBAeS29VGy46+wnscazbscfueIcmH5tZw5UCMsaKXX/U5bFmhjCWciFl43Xqt1AKSXl6g0Q1uQMJeqWOsdJ7LPcf6B/XOwp3Tdcq7PJVlCIzYJiPW/JLZktKkteCpc+IS2DIlAQWA/NRqYh6BvT3jPlhktBscs4m0dLZlDhs=
Received: from BN9PR03CA0326.namprd03.prod.outlook.com (2603:10b6:408:112::31)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 04:44:14 +0000
Received: from BN1PEPF00018546.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::3a) by BN9PR03CA0326.outlook.office365.com
 (2603:10b6:408:112::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.22 via Frontend Transport; Thu, 1
 Oct 2026 04:44:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018546.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 04:44:13 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 23:44:10 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sandipan Das <sandipan.das@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 0/7] KVM: SVM: Add support for hardware-assisted PMC filtering
Date: Thu, 1 Oct 2026 04:43:44 +0000
Message-ID: <20261001044351.50535-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018546:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6b3639-a545-4f58-2ae7-08df1f76a4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|18002099003|13003099007|3023799007|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	ES8iTqYBTvnDubWbMFOoh8RwMoit9RxXTj26kAM+0fMsSkbHSMW/rNgx456EaTSFE87JuyjORFUoh2pllIgjWeZuVF3dQVdtrcYeywZFA300fOiccUi/kQrcdRrqvUz5dXOVnuZ6ji2MR9N9b2wbLcc49fw5eLuxiPVPn1LOEFgHDkhIJV4WvIM7g2WjXjNZVS3Rb9yDTOI/x/nr1Hss9ouINdaDXPb+1bsnRHo1/dZUlG5HeC5JYP71o8Qc8Gz42i4gr/nhKzofZ2hLe4GzDiz5WkrW3ukJfGo8bMaIxDL0ptJYeThB41JhjKbimQwsX8AWbVNH5ybVeSb9azkueHtC4eR6PGDZ9sxZVR75+2G4wScgjqmobsJ0B9zIDZL8YoTZ2neQVPFnKCqF6NgzFiFp4cusWy106Yjby44Y268ab5WhQ/swrb4/jzGJh45aNT+osCARkqS76R4DtJ+Y3vy1NoAH0dkhZr9MmU29Mou+6sWHl9LyNRO2NXFoEJj1guiGCPXiL/Xc4tJIbuANI6cTY485keG+VFupi86gakK8WtwW4Jy+Hpl1G0RNnssG+qOv7x2uJtCwmWLLzI05atO9NvjxZniucBX7K341hi26uKc1sIuGHEqavW6q2r7nXNyS9U9xH1GJamdy5UeX0A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(18002099003)(13003099007)(3023799007)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xd+10Rh5XvC4yHe1dO/AB381HfbcTJNba26bere4rsrWIa3m6Tm9+p2gAaX6CFa2SFe4Ts1K1xnsp+RsN7kSbSh5yQkT3xIL5ybkNyqrbgsQb36j8jJ7D5UR8yXrBFe5I+5bZIOSWRSVMBw+BBsJok3yhtkbW1h2LbkI3nUVVAFQY7k5dOiITy8R+Av9l5uyy1sUn6e30BiU6d7O90jd3ZAPaqtJyD6w2cBoVFSuDnV6fiCqsXw9Os7CqiUuDOrgakVLSzfW+ZUCJe0CvXfEjd44DMbNV1XvqxqIk+OPc7STCeAZaThgnDQiBMUN0KzCCzYA9WNLdoBZZ2C1NMRMHh4pOTuPr9Y2uXHMTSgXcg1o2bn2IOhbRMwPPNIEqWz3NAYUuefbeSTP7NmYchtWLLn2RYTqmcFMtLc6B85/tN2jEyTnRh9HJ2zCLZcHSr/p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 04:44:13.9082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6b3639-a545-4f58-2ae7-08df1f76a4b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018546.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468

Upcoming AMD hardware adds hardware-assisted PMC filtering that lets the
hypervisor restrict which performance events a guest may program into
the PMCs.  This is useful both for confining guests to a sanctioned set
of events and for mitigating PMC-based side-channel attacks.

This series builds on the hardware-switched PMU series [1] and wires the
hardware allow list into KVM's existing PMU event filter
(KVM_SET_PMU_EVENT_FILTER), so userspace continues to express policy the
same way it does for the software filter today.

Any feedback on design is welcomed.

Background
----------
Detailed information about the feature can be found at [2].

The feature is advertised via CPUID 0x8000000A ECX[3]
(X86_FEATURE_PMCFILTER) and is programmed through new VMCB control-area
fields:

- ALLOWED_PERF_CTL[0..5]  (offset 0x180) - the allowed event list
- ALLOWED_PERF_CTL_MASK   (offset 0x1C0) - bits compared during matching

To enable hardware-assisted PMC filtering for the VM, the hypervisor
sets SVM_MISC2_ENABLE_PMC_FILTER (bit 5) in the VMCB misc_ctl2 field
(offset 0xB8).

With hardware-assisted PMC filtering enabled, the event-select MSRs and
PerfCntrGlobalCtl are passed through to the guest.  Hardware intercepts
an event-select write only when it enables an event that does not
satisfy:

  (PERF_CTLx & ALLOWED_PERF_CTL_MASK) == (ALLOWED_PERF_CTL[0/1/2/3/4/5]
  & ALLOWED_PERF_CTL_MASK)

and VMRUN fails if an enabled counter's event isn't in the list.

Overview
--------
Patches 1-2 add the feature bit and the VMCB fields.

Patches 3-5 maintain the allow list: clear it when the PMU event filter
changes, add events KVM allows, and reload KVM's copy of the
passthrough event-selects before using them.

Patch 6 keeps PMC filtering off for SEV-ES/SEV-SNP guests, whose
event-selects KVM can't access because VMSA is inaccessible to KVM.

Patch 7 enables PMC filtering whenever the hardware-switched PMU is in
use, the CPU supports it, and nested=0.

Design
------
Hardware-assisted PMC filtering lets the CPU enforce KVM's PMU event
filter directly, instead of KVM trapping and checking each event-select
write in software.  The guest's event-select and PerfCntrGlobalCtl MSRs
are passed through, and hardware traps an event-select write only when
the guest enables an event that is not yet in the list.  On that trap
KVM runs its usual software filter and, if the event is allowed, adds it
to the list so the write can proceed.  A denied event leaves the counter
disabled.

  - Allow list: the list has six slots.  Once an event is allowed it
    stays listed, so an event that later moves to a different counter
    doesn't trap again.  An allowed event goes into the first free slot,
    unless an equal entry is already there.  KVM rebuilds the list from
    the enabled counters only when it is full, and clears it on every
    KVM_SET_PMU_EVENT_FILTER, so that an event the old filter allowed
    but the new one denies is no longer allowed.

  - Stale event-selects: the guest can change allowed events without a
    VM-exit, so KVM's copies of the event-selects can be out of date.
    KVM reloads them from the VMCB before using them, e.g. on a trapped
    PMU MSR write, when userspace reads them, and before counting
    emulated instructions.  It reloads at most once per VM-exit, so that
    its own changes that haven't reached the VMCB yet aren't lost.

  - A PerfCntrGlobalCtl write can enable counters without writing their
    event-selects, so KVM checks all counters again on it.

Limitations
-----------
  - TODO: Support for Nested guests.  vmcb02 doesn't enable PMC
    filtering, and L2 would inherit vmcb01's passthrough event-selects,
    so currently PMC filtering is enabled only with nested=0.

  - TODO: Hardware-assisted PMC filtering is left disabled for SEV-ES and
    SEV-SNP guests, because their PMU state lives in the encrypted VMSA,
    which KVM can't access.

  - Hardware-assisted PMC filtering requires PerfCntrGlobalCtl to be
    passed through, so the global control and status MSRs are passed
    through even to PerfMon-v1 and legacy guests, which then don't get
    a #GP when accessing them.

Performance
-----------
The mediated PMU and the hardware-switched PMU intercept the
event-select (PERF_CTL) MSRs unconditionally, on every write, regardless
of whether the counter is being enabled or disabled.  Hardware-assisted
PMC filtering passes those MSRs through and takes a VM-exit only when
the guest programs an event that is not already in the hardware allow
list, removing the majority of PMU-related exits.

Guest instance (single vCPU) (all events allowed, no filter set):
perf stat -e cycles,branches,instructions -- sleep 1
perf stat -M PipelineL1 -- sysbench --cpu-max-prime=1000 --threads=1 cpu run

Host instance - Count VM-Exits for hardware counter accesses:
perf stat -e kvm:kvm_msr --filter="((ecx >= 0xc0010000 && ecx <= 0xc0010007) ||
                                    (ecx >= 0xc0010200 && ecx <= 0xc001020b) ||
                                    (ecx >= 0xc0000300 && ecx <= 0xc0000303))"

------------------------------------------------------------------------
|               Type               |     No of exits (kvm:kvm_msr)     |
------------------------------------------------------------------------
|           Mediated PMU           |             101,528               |
------------------------------------------------------------------------
|              vpmc                |             101,264               |
------------------------------------------------------------------------
| Hardware-assisted PMC filtering  |               7,503                |
------------------------------------------------------------------------

Hardware-assisted filtering reduces PMU MSR exits by ~13x (~93%) for the
same workload: once an event is allow-listed, the guest's PERF_CTL
accesses no longer trap.

Testing
-------
  - pmu_event_filter_test passes on Hardware-assisted PMC filtering capable
    hardware.
  - Guests with PerfMon-v2, PerfMon-v1 and legacy counters, booted with
    QEMU [3] and a filter denying some events, never count the denied
    events.

These patches are based on 
branch:         kvm-x86/next (https://github.com/kvm-x86/linux.git)
Base commit:    6cf46b37b0356 (kvm-x86-next-2026.08.07) + hardware-switched PMU series [1]

[1] https://lore.kernel.org/kvm/cover.1786345201.git.sandipan.das@amd.com/
[2] https://docs.amd.com/api/khub/documents/2eieIP7KVNk7sKFJ9Ew~Ng/content
[3] https://lore.kernel.org/kvm/20250409082649.14733-2-zhao1.liu@intel.com/

Manali Shukla (7):
  x86/cpufeatures: Add hardware-assisted PMC filtering feature bit
  KVM: SVM: Add VMCB fields for hardware-assisted PMC filtering
  KVM: x86/pmu: Clear the hardware PMC filter allow list on filter
    changes
  KVM: SVM: Maintain the hardware PMC-filter allow list
  KVM: x86/pmu: Refresh event-selects before counting emulated events
  KVM: SEV: Disallow hardware-assisted PMC filtering
  KVM: SVM: Enable hardware-assisted PMC filtering

 arch/x86/include/asm/cpufeatures.h     |  1 +
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  2 +
 arch/x86/include/asm/kvm_host.h        |  7 ++
 arch/x86/include/asm/svm.h             |  7 +-
 arch/x86/kernel/cpu/scattered.c        |  1 +
 arch/x86/kvm/pmu.c                     | 26 +++++++-
 arch/x86/kvm/pmu.h                     |  2 +
 arch/x86/kvm/svm/pmu.c                 | 88 ++++++++++++++++++++++++++
 arch/x86/kvm/svm/sev.c                 |  3 +-
 arch/x86/kvm/svm/svm.c                 | 48 ++++++++++++++
 arch/x86/kvm/svm/svm.h                 |  8 +++
 11 files changed, 190 insertions(+), 3 deletions(-)


base-commit: 6cf46b37b0356b3408f8ba949e10462cc71b533d
-- 
2.43.0

