Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65923D1CB6
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122447; cv=fail; b=nqcxr8Vwq14P5eR6AhKgmZlxaRrCmnBoeZSW1Bihsjmb8wrozsXgRmUfZnhAQTcaNbFr4IUx/etvvA6gLgdDEiqJq1LUGYyEg0fNtsA5AfSH8ne5kKM2RtFFfsm+e3scj/5aNNMjdeAtgEdj08Hcyg0jEB0ysGcy00BEXnMDp/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122447; c=relaxed/simple;
	bh=B9/MKDkC7mKAqpWqvH0IAm8ETA9XXV3JpZOI8U19scs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hKFQXbE9CMu4h4ml2f2ubqZCZT6kj053wVP/GT3wQIG7Aoqy+npbdzfFX+hg6Gah4jXHR4ihWmPaDUF5cXdvxsF+ZffYzsGArFVMGGRmpnnfxf9nHl8Y1d6VdS8cbdLak5D5cFHVmuk6knZUcXCLt49XJ2A3ZSpSLhhRMvVSHhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sFZbosmJ; arc=fail smtp.client-ip=52.101.52.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sFZbosmJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFtOeVyDEhfJlhWBj8wgJWd1dmzdQiqQpAR5UQiLRKceiCDog0bOR6gk1U4OZwL6fREjbsJQ0ka7yU4ssQp7ewGv937m8eNfL/+U/RReexJ5Kt1zhcilOck8g0fG/BbVKC3IhxiC+Y+Bqqdv/p8hszwqAza/+KBwf1YFif3Po3azenqFAZW81TRaOI1x099Hq3AnDYwrSai6+3wVdGXJU69tI1OsGXwJjQ2Zl4Cn3iXTRRjmNtPhU1OKM3L8o0V99GL1426QPwVzGF1pqDywmNv6tjBJoOr0E01G7tVHgba5dTuePI/5e9T0oTJedZMyOIBjsxzlOlO6W8Up9VUMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR1YlVuYN9gylbV7YbzyQZh7h6yKOvnay5GOSyyw66o=;
 b=MqA4FHrz+1QVfJXoWuf+Z4jfwMT/L8SBQiQkOabG0714zHicD41m1ChqRPCKuIBjfFeqIb//cmdWnDGzHRneEgny2l6tFF0e/II1Ln8/mgT/PaUCUmpmr36BK8k6XeZQD/AKXsMc7Afb7/UVaRyabcwrXlSR1+4Q7hhyUJdn3DrdJg6lJFRYfFDH2Ldl+S4QQXNDkcwYU06Dzjun0DHEQtwUUV771PHUcYV4EK6B0MqCmptjAW+5mLYF9oZ0ixpfCpfJK1l6JIyN+AxiaT0hYJ4s57aetGkOBTjTsE3DvECYBuArhj5OTv5OqSt7beVrscZXXc2v9vwQBI/2HkeUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR1YlVuYN9gylbV7YbzyQZh7h6yKOvnay5GOSyyw66o=;
 b=sFZbosmJLrUYOHzmEnepAnJiBUCdabQnmIIpVOtySVT0ZZOJs71J5g17qaSQgs5YGRBT0c52QD6HAgCCiLukanai1JKVKYwHU+SzEnHytsMl2vfwOgR1FOomML++90+TXQ5yaDHpZn0CjiIrgJwx5sH4nzrtK0tSmO74oB23dy8=
Received: from MN2PR01CA0057.prod.exchangelabs.com (2603:10b6:208:23f::26) by
 IA1PR12MB9498.namprd12.prod.outlook.com (2603:10b6:208:594::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Tue, 10 Mar
 2026 06:00:36 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::c9) by MN2PR01CA0057.outlook.office365.com
 (2603:10b6:208:23f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 06:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 06:00:36 +0000
Received: from volcano-f23bhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 01:00:33 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>,
	<Naveen.Rao@amd.com>, <dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>
Subject: [PATCH v3 0/9] Implement support for IBS virtualization
Date: Tue, 10 Mar 2026 06:00:12 +0000
Message-ID: <20260310060022.15120-1-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA1PR12MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f230b43-2a56-429e-a025-08de7e6a5996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|13003099007;
X-Microsoft-Antispam-Message-Info:
	lWfKP5GARzUgMcSiAYCMnSIFehGS8wwYfviP2E6lfiq3a+68F1QeeagvDbvBZvnzLlMyIHKxCfvarG8+kQMrTjV762fAqJ1W0ifeyMd6u/L+Dc9x627Nkn6L9Fvw8i/VMjU1zGKD20KGKhWROxF7bTruy9lCMksdEbrOZZiHhuKrpr6QSzdOvvkvCPUDfNvMfSP4V7Gc8xGr48zGCcRZVS8zmZA/ynp3RirQ9vvTVuXYlLQqqde+4+h5Zl7u4VPct2qg32FgaHEy+6KHtsAzairoDRScbETFZlPPPWPRkNEfxtmyluW/L9MxVYjTcmWvGtJ4b2FOzZ+sRs3FaX7B/jXmyK7v/Tb+OTXF5aGffy5UVM1tawgwhgzdDSns/oLQy7ePLEDwSnfZASt+suarQooU50KHTD9FK/mfA9MgPEAQJkShjAj8AMGTabsaeQKl0WvjLvoAwjvb8XdBehSpo1aU0J+M37+ctWiVzEZm0v6O+Zf+CU6q/RJntYPHd5JCoc1SpbSnxUaj3T2KjaDoa9T4tuLbZUU4mFFQplPMPpsn9VKuTRg7Wotkw+QGJL5eTotRCvsp/egab2eg9/KreYNkty9wzWEgqLePJjBs2x4YfrgOs4laEiLr+5gLVhp9m8bi3jvObr8xtKCKIzTruLr/+jfcCDQPb61CX7hUoWRx/2A7X4HRTz9WhdXOVV67p6dHckq1kouI/FFrWsMf0PRwzC3fYp5H3xMJYY2ssqE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e6giFbGjy9tSsSCCxcmxkR80HHmFCiL8mCsAChPFpb6hKNl35nbrjfiAQZSHl7pT3F6aRVQNb12gaJwhGP/tT4EAxYdvIHxtz99/r3POJVoz/cPQxOsbWjhT2wN70wAREg0il6Jsa72ockvxonfyKMWHeS9lGKxM0cvsamkerhKmQESWQ87ZhTOPcxrSSyyy9tOWTVvkboL2e/LMR39PiUEVQ9rG1p+9NisjOfodCVWpBJDRWfFXDaKIbSV5k2kzZeOiAVl/FTkB73eOOolMrppTkmEFTgEdOcQFLnPO80sW+/YHk0prGP+FwrauDFHvty7uJie5CSch09MoLSzpfQe0qoY4sbcPnGCSI9X30+Nfs88JqpzUSia01tYO7KDtgVWJMcxQ00eN3aNQpjpZoF73+Ok+B9UlX9NnmI0nct4bijDsOBD+eHPtgrX8ltq3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:00:36.7422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f230b43-2a56-429e-a025-08de7e6a5996
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9498

Add support for IBS virtualization (VIBS). VIBS feature allows the
guest to collect IBS samples without exiting the guest.  There are
2 parts to it [1].
 - Virtualizing the IBS register state.
 - Ensuring the IBS interrupt is handled in the guest without exiting
   the hypervisor.

To deliver virtualized IBS interrupts to the guest, VIBS requires either
AVIC or Virtual NMI (VNMI) support [1]. During IBS sampling, the
hardware signals a VNMI. The source of this VNMI depends on the AVIC
configuration:

 - With AVIC disabled, the virtual NMI is hardware-accelerated.
 - With AVIC enabled, the virtual NMI is delivered via AVIC using Extended
   LVT.

The local interrupts are extended to include more LVT registers, to
allow additional interrupt sources, like instruction based sampling
etc. [3].

Although IBS virtualization requires either AVIC or VNMI to be enabled
in order to successfully deliver IBS NMIs to the guest, VNMI must be
enabled to ensure reliable delivery. This requirement stems from the
dynamic behavior of AVIC (This is needed because AVIC can change its
state while the guest is running). While a guest is launched with AVIC
enabled, AVIC can be inhibited at runtime. When AVIC is inhibited and
VNMI is disabled, there is no mechanism to deliver IBS NMIs to the
guest. Therefore, enabling VNMI is necessary to support IBS
virtualization reliably.

Note that, since IBS registers are swap type C [2], the hypervisor is
responsible for saving and restoring of IBS host state. Hypervisor needs
to disable host IBS before saving the state and enter the guest. After a
guest exit, the hypervisor needs to restore host IBS state and re-enable
IBS.

The mediated PMU has the capability to save the host context when
entering the guest by scheduling out all exclude_guest events, and to
restore the host context when exiting the guest by scheduling in the
previously scheduled-out events. This behavior aligns with the
requirement for IBS registers being of swap type C. Therefore, the
mediated PMU design can be leveraged to implement IBS virtualization.

How to enable VIBS?
sudo echo 0 | sudo tee /proc/sys/kernel/nmi_watchdog
sudo modprobe -r kvm_amd
sudo modprobe kvm_amd enable_mediated_pmu=1 vnmi=1

Testing done:
- Following tests were executed on guest
  - Basic IBS testing was done on the guest from IBS cheatsheet [5].
  - perf_fuzzer was run for 12hrs, no softlockups or unknown NMIs were
    seen.

TO-DO:
Enable IBS virtualization on SEV-ES and SEV-SNP guests.
Enable IBS virtualization on nested guests.

Patches are rebased on top of
https://github.com/kvm-x86/linux next
commit 7d14d027e733 ("Documentation: KVM: Formalizing taking vcpu->mutex *outside* of kvm->slots_lock") + [5] + [6] + [7].

[1]: https://bugzilla.kernel.org/attachment.cgi?id=306250
     AMD64 Architecture Programmer’s Manual, Vol 2, Section 15.38
     Instruction-Based Sampling Virtualization.

[2]: https://bugzilla.kernel.org/attachment.cgi?id=306250
     AMD64 Architecture Programmer’s Manual, Vol 2, Appendix B Layout
     of VMCB, Table B-3 Swap Types.

[3]: https://bugzilla.kernel.org/attachment.cgi?id=306250
     AMD64 Architecture Programmer’s Manual, Vol 2, Section 16.4.5
     Extended Interrupts.

[4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-amd-ibs.txt

[5]: https://lore.kernel.org/all/20260216042216.1440-1-ravi.bangoria@amd.com/

[6]: https://lore.kernel.org/all/20260216042530.1546-1-ravi.bangoria@amd.com/

[7]: https://lore.kernel.org/kvm/20260204074452.55453-1-manali.shukla@amd.com/

v2->v3
- Moved EXTLVT implementation to a different series
- Added virtualization for newly added IBS MSRs for future hardware
- Miscellaneous changes

v1->v2
- Incorporated review comments from Mi Dapeng
  - Change the name of kvm_lapic_state_w_extapic to kvm_ext_lapic_state.
  - Refactor APIC register mask handling in order to support extended
    APIC registers.
  - cpuid new leaf(CPUID_8000_001B) for IBS capabilities related code changes. 
  - Miscellaneous changes

---
v2: https://lore.kernel.org/kvm/20250901051656.209083-1-manali.shukla@amd.com/T/
v1: https://lore.kernel.org/kvm/afafc865-b42f-4a9d-82d7-a72de16bb47b@amd.com/T/

Manali Shukla (6):
  perf/amd/ibs: Fix race condition in IBS
  KVM: x86/cpuid: Add a KVM-only leaf for IBS capabilities
  KVM: x86: Extend CPUID range to include new leaf
  perf/x86/amd: Enable VPMU passthrough capability for IBS PMU
  perf/x86/amd: Remove exclude_guest check from perf_ibs_init()
  KVM: SVM: Add newly added IBS capabilities and MSRs

Santosh Shukla (3):
  x86/cpufeatures: Add CPUID feature bit for VIBS in SVM/SEV guests
  KVM: SVM: Extend VMCB area for virtualized IBS registers
  KVM: SVM: Add support for IBS Virtualization

 arch/x86/events/amd/ibs.c          |  8 +--
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/include/asm/svm.h         | 18 ++++++-
 arch/x86/kvm/cpuid.c               | 31 ++++++++++++
 arch/x86/kvm/reverse_cpuid.h       | 22 ++++++++
 arch/x86/kvm/svm/svm.c             | 80 +++++++++++++++++++++++++++++-
 7 files changed, 156 insertions(+), 5 deletions(-)

-- 
2.43.0

