Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347183AE187
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356952; cv=fail; b=T6XGWW5HiSw4YD6AZEoHZD8RwHuLRL/LLhwT+JWBQWTZJJ6XdG4sVu2pDSwILkWXOs7nkkXmUdmKUOeut5AjcvB6InangrLH1PDma8lq51gU5R33bEkZiTGtS2w2it0VjnK4pVba9+21hMwz1C3v4JY4A4CuKQE+5GK31oeAE2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356952; c=relaxed/simple;
	bh=XMfnmDLUjKKWX1YmCZzxzc80/vRqdtYTyVibrKsxQ7c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MeHZQrL37W2Ifr3pT5eY+WxnuM8J+K+GAG4hL3y+ftkyHPmHmMKfiY9VtDD07eyUecJoOgGp6u/5xGElhf6snmhC7LgOvo4WGjfEIFV16PbKoxQoLal2GXv8PLXXzbK0Hopk92wDLI51Ge/fjOrPp6g33Diy8MPgM9dLbjTLjM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t9KaNPzv; arc=fail smtp.client-ip=40.107.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t9KaNPzv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOmaBRwwi7REkJDVactcpYB97IA01uA2gJIfcDrMLu2WD3mbrsRkMrVp5fqm+FT9+U61E8TCx6JUSTI+oCa+0OhlwGp3IJ16ufXoFttc5LLdXm4VOYYByPth7BlC10oPUMJKyzqpNyXFYYgtNCkQHsiHouDtuiVm5+udol9XmDDf7CV+rXtO3RLd2WN9p42FVowSWF22nc5IKWYk6CIfyB/Nt6x/nnhIEXYkeQ3md2ibBbpHuNpgx3ec2MZ+6+s3s9q7pQ27vYsp6rHwMgU0qZJoFYaOtjQIRYjwiVkfHFJ8r8uxdc39XRYuAMyDyx34XL3/uT4kGPYQgfoZlBrXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmPVxo0m+z368mG/sAXNcI/b/Y5jwMhILqytk37XkHo=;
 b=KMcBx0ob+O3ytKXsN4DOin0qLYK67JreDESsWL2PchYXELCTHPIMV0eoJV7QLseeC1+/gYwrmfYAq3xs/L3xVrINhUUq2o5z9P1UwN+CLtgUixYdQ+7TorZfrsxGJU4qFoRlsvjd3gQVwg4YiRkukqQt/Vh0UZ6UrAZA1Y/st+GsPmj/zliHTlBlHINm50uKeieYd22jmfLz8V95BGGHS0KbJUZcUkP7hD3gErEPyC9ytNkl5vkNZgvCD9TaWs97HoBfDCxsC7TDPzgItIxu4ieYye3GcrlRc0LLC4TKMzNHRv00EcevvgBqZOXTvPv0qMBKOKKeXN4SA38HjPYkjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmPVxo0m+z368mG/sAXNcI/b/Y5jwMhILqytk37XkHo=;
 b=t9KaNPzvfsQI5bC2ELZhWBSH7qIK3m8nBaXnIpWehALhdhKe743Y62sNb3NPGH+XUg7/kouUZY2aTMLz8iZM3VW9vbO/mYO6kCKoLEtPrrKJPTIP4VJR2vkMXrvvI90ASmDV518wfA6a6s1p2l2vkJenor6BvVcT5gO5QipkNqg=
Received: from PH8PR21CA0021.namprd21.prod.outlook.com (2603:10b6:510:2ce::15)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:15:46 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:510:2ce:cafe::91) by PH8PR21CA0021.outlook.office365.com
 (2603:10b6:510:2ce::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.1 via Frontend Transport; Mon, 10
 Aug 2026 10:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615E.mail.protection.outlook.com (10.167.249.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Mon, 10 Aug 2026 10:15:45 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:15:42 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, Yosry Ahmed
	<yosry@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Nikunj A . Dadhania" <nikunj@amd.com>, "Manali
 Shukla" <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 0/8] KVM: Add support for hardware-switched mediated PMU
Date: Mon, 10 Aug 2026 15:44:48 +0530
Message-ID: <cover.1786345201.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 7400b927-8ff3-4d21-44ea-08def6c8579e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|13003099007|18002099003|10067099003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	T1cJRNYul9WxGXRk/MPzNoAqBKMU9gmzkUXRX/qXYlTjlgGnCXB5/SytU+BO1UKZ5Btz6Az4osOIn4BZ3/NxCDVBo1iy8mkhmxddKE63laCGAi34hKAAQMYAa8Z7fhFeXQmdVTO2HIcJg2H0PrbwpCqaP5tg4ebqRT3dc4cMG8kL3iTqJS1bOrMu4VN70x1u7pDeG8O6gXfJ13R0wAILTIiijahGxMxMw54Eiu6DrSrLLZysTSpUdBQ4NQv48BC/bp64iI8JtSL+x03IgdMuPzY49t2i5qshL1pMUQr31GSvqopiNzBFs7iPlpESLqR+cQrW5H8sS9lk4q+C/sECz+K8BmQzp6ZjrpWv74v9K9h2bxuDd/QuCuKYBBFnczpLe46Gq/tpKClk9pg9qhaWTMfMwFqfDW+O5dQdocQgJL8rVOj/eB+Qn6ElqgS7deZnFzA9ZU1qKI3rB5/Kh9/ICbA+lGbLpuUqCwli/J0i5g8uh4AndyuSewDAfnyEqlLPh4mTlRTSGlmOdhaENsofYqh/6D4LLv24CSal1wteCgBRwRzjxJic2wNxbbNHoBStkaOHYhd1Fxk+IRCDfvhR0bZ1tZRL1CZVX4GHWQ7EaibVqJ9BTxPDz72m98XgbSRTDE4p8sYMlRg8OMgc08j+NAkBtdxNBfWs2NgjVscA0mzWmHD5YOOkEChiKKwT9PblcgQ0DyYdXZoFzm+ZLF/9TA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(13003099007)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eK706YQ+U1Q5L0Z1ogR9AdKLfI1jEBPKjbzynSJxyOP09ITVN1lDwVSPXLLg43g/gKq9DsXsGmZ8ECCW6qQyIBRnN8I1MKhI3PWEtjDB3WJHe2w7k4OSuixIKSx4IhQBqtnXpcTkcCmaePSL6twb7UpqeRLARml6ivoTGEJwwoCdxSXacQZY2x4KgQAkIJZ5PHNR/uCxPQCUQ8eggdL5DoqnQ+T1P3U8R3f7bulXLW/6MW/sJM4mS71vf4pf8i2z9xc5wrjQTFbGMQs5L6CFgU2W5ox2ufCgQYhsc2c7T4L6tEie0VvWl3ycfvjh6Vso8P+eQGLXCkRE0LsXMny0NKXgSQQN6bP6Zu2mKWRrgtQk0wGq7vfk/c8AVW8YoPbHTt0eneWJ8AxKgvjElHRwscWZB//Opj+MdrVwSl0jeNquK8tN8xA5NnlHRe8nZq4V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:15:45.5749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7400b927-8ff3-4d21-44ea-08def6c8579e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824

Mediated PMU currently saves and restores the guest PMU state in
software on every world switch. On Zen 5 and later processors, it is
possible to offload this to the hardware, which automatically saves and
restores the guest counter state to and from a vendor save area (VMCB)
during world switches. This feature is called PMC virtualization and
detailed information about it can be found in Volume 2 of the AMD64
Architecture Programmer's Manual under Section 15.39.

This series extends the mediated PMU framework with a hardware-switched
mode and adds the AMD (SVM) implementation, including nested support.

Performance
-----------
The difference in the world switch overhead between software-switched
and hardware-switched modes is measured with the x86/vmexit test from
kvm-unit-tests on a system with an AMD EPYC 9755 processor. The values
are in cycles per operation (lower is better), averaged over 5 runs.

------------------------------------------------------------------------
test                               sw-switched  hw-switched         gain
------------------------------------------------------------------------
cpuid                                     5333         2592       +51.4%
vmcall                                   15858         7619       +52.0%
wbinvd                                    5256         2517       +52.1%
invd                                      1857         2147       -15.6%
mov_from_cr8                                18           18         0.0%
mov_to_cr8                                 157          156        +0.6%
inl_from_pmtimer                         25934        21176       +18.3%
inl_from_qemu                            25881        21156       +18.3%
inl_from_kernel                           5521         2772       +49.8%
outl_to_kernel                            5522         2778       +49.7%
mov_dr                                     114          114         0.0%
self_ipi_sti_nop                          1020         1015        +0.5%
  ipi self_ipi_sti_nop                     310          307        +1.0%
  eoi self_ipi_sti_nop                     242          241        +0.4%
self_ipi_sti_hlt                          2714         2704        +0.4%
  ipi self_ipi_sti_hlt                     310          307        +1.0%
  eoi self_ipi_sti_hlt                     242          240        +0.8%
self_ipi_tpr                              1272         1263        +0.7%
  ipi self_ipi_tpr                         309          307        +0.6%
  eoi self_ipi_tpr                         241          240        +0.4%
self_ipi_tpr_sti_nop                      1304         1295        +0.7%
  ipi self_ipi_tpr_sti_nop                 309          307        +0.6%
  eoi self_ipi_tpr_sti_nop                 242          241        +0.4%
self_ipi_tpr_sti_hlt                      3003         2991        +0.4%
  ipi self_ipi_tpr_sti_hlt                 309          307        +0.6%
  eoi self_ipi_tpr_sti_hlt                 242          240        +0.8%
x2apic_self_ipi_sti_nop                    899          895        +0.4%
  ipi x2apic_self_ipi_sti_nop              191          190        +0.5%
  eoi x2apic_self_ipi_sti_nop              242          241        +0.4%
x2apic_self_ipi_sti_hlt                   2592         2587        +0.2%
  ipi x2apic_self_ipi_sti_hlt              191          190        +0.5%
  eoi x2apic_self_ipi_sti_hlt              242          241        +0.4%
x2apic_self_ipi_tpr                       1159         1151        +0.7%
  ipi x2apic_self_ipi_tpr                  193          193         0.0%
  eoi x2apic_self_ipi_tpr                  241          240        +0.4%
x2apic_self_ipi_tpr_sti_nop               1189         1180        +0.8%
  ipi x2apic_self_ipi_tpr_sti_nop          193          193         0.0%
  eoi x2apic_self_ipi_tpr_sti_nop          242          241        +0.4%
x2apic_self_ipi_tpr_sti_hlt               2887         2875        +0.4%
  ipi x2apic_self_ipi_tpr_sti_hlt          194          192        +1.0%
  eoi x2apic_self_ipi_tpr_sti_hlt          242          239        +1.2%
ple_round_robin                             19           19         0.0%
wr_kernel_gs_base                           73           73         0.0%
wr_ibpb_msr                                563          557        +1.1%
wr_tsc_adjust_msr                         5352         2603       +51.4%
rd_tsc_adjust_msr                         5330         2586       +51.5%
toggle_cr0_wp                            11319         5810       +48.7%
toggle_cr4_pge                           11743         6242       +46.8%
mmio-no-eventfd:pci-mem                  31890        26835       +15.9%
mmio-wildcard-eventfd:pci-mem             6461         3666       +43.3%
mmio-datamatch-eventfd:pci-mem            6449         3671       +43.1%
portio-no-eventfd:pci-io                 25218        21455       +14.9%
portio-wildcard-eventfd:pci-io            5512         2774       +49.7%
portio-datamatch-eventfd:pci-io           5524         2780       +49.7%
------------------------------------------------------------------------

The largest gains are for wbinvd (+52.1%), vmcall (+52.0%), and cpuid
(+51.4%), followed by the TSC-adjust MSR accesses (~+51%), the
kernel-handled port I/O paths (~+50%), and the control-register toggles
(~+47-49%). The wildcard and datamatch MMIO / port-I/O paths improve by
~+43-50%, while the slower no-eventfd MMIO / port-I/O and pmtimer/qemu
port-I/O paths improve by ~+15-18%.

The only meaningful regression is invd (-15.6%). The self-IPI and EOI
subtests move by at most 1.2% and wr_kernel_gs_base is unchanged, all
within run-to-run noise.

Design
------
  * The entity responsible for switching the guest PMU state is tracked
    per-VM via a new set of mediated PMU capability flags in kvm_arch.
    In software-switched mode the state resides in struct kvm_pmu; in
    hardware-switched mode it resides in the vendor save area.
  * Event filtering, instruction emulation, and intercepted RDPMC still
    need the state in struct kvm_pmu, so new vendor state-sync PMU ops
    synchronize specific MSRs between struct kvm_pmu and the vendor
    save area on demand.
  * On SVM, the feature depends on VNMI for guest PMI delivery and is
    controlled by the new "vpmc" kvm_amd module parameter, enabled by
    default when the host supports it and mediated PMU is enabled.

Limitations
-----------
  * Not supported for SEV-ES and SEV-SNP guests: the guest PMU state
    resides in an encrypted VMSA that is inaccessible to the event
    filtering logic.
  * With VNMI and no AVIC, overflow interrupts are always delivered as
    NMIs because the APIC is emulated and the LVTPC is ignored. This
    shows up as expected behavioral differences in the x86/pmu test of
    kvm-unit-tests.

Overview
--------
Patches 1-3 extend the mediated PMU framework with hardware-switched
mode: the capability flags, the vendor state-sync ops, and the generic
support. Patches 4-6 add the SVM enablement: the PerfCtrVirt feature
bit, the VMCB save-area fields, and the SVM implementation. Patch 7
adds nested (nSVM) support to use the feature with L2 guests. Patch 8
explicitly disables the feature for SEV-ES and SEV-SNP guests.

Tested with kvm-unit-tests (KUT) and perf fuzzer. KUT's x86/pmu test
requires patching to accept overflow interrupts as NMIs (limitation
because of VNMI ignoring the LVTPC). It is recommended to apply the
following patches before testing.
https://lore.kernel.org/kvm/3bfbf15c22652ba00cf4a16fe9e0a3bfe7071f97.1784096302.git.sandipan.das@amd.com/
https://lore.kernel.org/kvm/b075ec13e95167da1f2229626713c91d291bb75b.1784097178.git.sandipan.das@amd.com/
https://lore.kernel.org/all/106bc3a4660653cb7750f3ae07a4dbca42c2762c.1786356229.git.sandipan.das@amd.com/

base-commit: 6cf46b37b0356b3408f8ba949e10462cc71b533d
             (tag: kvm-x86-next-2026.08.07)

Previous versions can be found at:
rfc: https://lore.kernel.org/kvm/cover.1762960531.git.sandipan.das@amd.com/

Changes in v1:
  * Introduce mediated PMU capabilities for hardware PMU virtualization
    features instead of perf PMU capabilities.
  * Make VNMI a hard requirement since AVIC can be inhibited.
  * Introduce new PMU ops to access VMCB PMU state instead of relying
    on host-initiated {get,set}_msr() ops.
  * Make VMCB PMU state accessible via KVM_{GET,SET}_MSRS for migration.
  * Implement support for nested SVM.
  * Disable support for SEV-ES and SEV-SNP guests explicitly.

Sandipan Das (8):
  KVM: x86/pmu: Add mediated PMU capability flags
  KVM: x86/pmu: Add PMU ops for vendor state sync
  KVM: x86/pmu: Add support for hardware-switched PMU
  x86/cpufeatures: Add PerfCtrVirt feature bit
  KVM: SVM: Add VMCB fields for PMC virtualization
  KVM: SVM: Add support for hardware-switched PMU
  KVM: nSVM: Add support for hardware-switched PMU
  KVM: SEV: Disallow the use of hardware-switched PMU

 arch/x86/include/asm/cpufeatures.h     |   1 +
 arch/x86/include/asm/kvm-x86-pmu-ops.h |   3 +
 arch/x86/include/asm/kvm_host.h        |  11 +++
 arch/x86/include/asm/svm.h             |  13 ++-
 arch/x86/kvm/cpuid.c                   |   1 +
 arch/x86/kvm/pmu.c                     | 102 +++++++++++++++++----
 arch/x86/kvm/pmu.h                     |  29 ++++++
 arch/x86/kvm/svm/nested.c              |  45 +++++++++-
 arch/x86/kvm/svm/pmu.c                 | 117 +++++++++++++++++++++++++
 arch/x86/kvm/svm/sev.c                 |   3 +
 arch/x86/kvm/svm/svm.c                 |  58 +++++++++++-
 arch/x86/kvm/svm/svm.h                 |  19 ++++
 arch/x86/kvm/vmx/pmu_intel.c           |   2 +
 arch/x86/kvm/vmx/vmx.c                 |   3 +-
 arch/x86/kvm/x86.c                     |   2 +
 15 files changed, 384 insertions(+), 25 deletions(-)

-- 
2.53.0

