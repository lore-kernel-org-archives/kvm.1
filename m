Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555743079F
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786449161; cv=none; b=aEg0dHokaUpu+D6IZQ6sa4C+Q0dfERY7uij6JEJA17r4lkyQyjbBkhL+r3HdUsCd/7TkFPX7muZB2OUhKsSg5eqWccXt6adRikStoj++LukuonDSAtm9mdXLNdxb/6cNGxSO1972h9WoqO55VloM6DCgZDq8pIxP7iW2L5eLq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786449161; c=relaxed/simple;
	bh=sF4ZXooBZlNb3igRfzN3K1JDogOA104bctH8cbHjmFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InzcVdpyEme2EEtzUczOkKaUoyvvQG/sMO6T2ljbzjhpZI/TFTNXNfy3OYCc8FRhso4MGAWm74fvbcbVOJjk+1MtzglLBJJwV6c9geVDQTjDKAwUGC7ofwwhLwCE6i3Ki+3PCYngAm3o5F/sC6wP+/epQ+f0tYXAWGybHhUoeSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=niaZN9iQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="niaZN9iQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786449159; x=1817985159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sF4ZXooBZlNb3igRfzN3K1JDogOA104bctH8cbHjmFA=;
  b=niaZN9iQ3JmDx5CCP14h0ojG956dhgcsn3OJBNiFUDAxlSZkkE6tqyx+
   j6fMGdoe0kFuMBIHcBs0LTI8vI0St53dNBFPd7eBgRDoQ9+zrJnvz2vPd
   mkp486sx1jnfcBNnEzqmGqTfGDqPYeQ5d5U0MAuzOwIQop0TcKCS/8URx
   7S8irpB7RNxwNEOXMNEzb5dvx7nS7CJ2nMXvWgzs4MwQZOaKADlJOGOvI
   0ja3W4J565AHs8E74Tp1h6L8U6cesdmKwOkVVfGuHkPT3bGZmdXYDu1pu
   /3Cv5qqIzjuXYqacN54FZ5eTye8fDufOggNJhWYdoMUNq9v1jgsHECHdj
   g==;
X-CSE-ConnectionGUID: xhQE3eLESJOAvrp4MfQF3w==
X-CSE-MsgGUID: qEbfBE5eTy+d8Q+fwUircw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86856640"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86856640"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 04:52:38 -0700
X-CSE-ConnectionGUID: F6KNxGlHTXew43spSu7fyA==
X-CSE-MsgGUID: zAhtEevySJ+OzpICIAvdFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="259479736"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 04:52:35 -0700
Message-ID: <ee4968b8-c40e-49f5-9f9d-46c007e78ae7@linux.intel.com>
Date: Tue, 11 Aug 2026 19:52:32 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] KVM: Add support for hardware-switched mediated PMU
To: Sandipan Das <sandipan.das@amd.com>, kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>,
 Yosry Ahmed <yosry@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>,
 Zide Chen <zide.chen@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 "Nikunj A . Dadhania" <nikunj@amd.com>, Manali Shukla <manali.shukla@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
 <32239a68-5ba8-4985-b959-1959f331f30a@linux.intel.com>
 <c240acb1-22ac-48cd-9243-792f415171c3@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <c240acb1-22ac-48cd-9243-792f415171c3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/11/2026 4:37 PM, Sandipan Das wrote:
> On 11-08-2026 13:19, Mi, Dapeng wrote:
>> On 8/10/2026 6:14 PM, Sandipan Das wrote:
>>> Mediated PMU currently saves and restores the guest PMU state in
>>> software on every world switch. On Zen 5 and later processors, it is
>>> possible to offload this to the hardware, which automatically saves and
>>> restores the guest counter state to and from a vendor save area (VMCB)
>>> during world switches. This feature is called PMC virtualization and
>>> detailed information about it can be found in Volume 2 of the AMD64
>>> Architecture Programmer's Manual under Section 15.39.
>>>
>>> This series extends the mediated PMU framework with a hardware-switched
>>> mode and adds the AMD (SVM) implementation, including nested support.
>>>
>>> Performance
>>> -----------
>>> The difference in the world switch overhead between software-switched
>>> and hardware-switched modes is measured with the x86/vmexit test from
>>> kvm-unit-tests on a system with an AMD EPYC 9755 processor. The values
>>> are in cycles per operation (lower is better), averaged over 5 runs.
>>>
>>> ------------------------------------------------------------------------
>>> test                               sw-switched  hw-switched         gain
>>> ------------------------------------------------------------------------
>>> cpuid                                     5333         2592       +51.4%
>>> vmcall                                   15858         7619       +52.0%
>>> wbinvd                                    5256         2517       +52.1%
>>> invd                                      1857         2147       -15.6%
>>> mov_from_cr8                                18           18         0.0%
>>> mov_to_cr8                                 157          156        +0.6%
>>> inl_from_pmtimer                         25934        21176       +18.3%
>>> inl_from_qemu                            25881        21156       +18.3%
>>> inl_from_kernel                           5521         2772       +49.8%
>>> outl_to_kernel                            5522         2778       +49.7%
>>> mov_dr                                     114          114         0.0%
>>> self_ipi_sti_nop                          1020         1015        +0.5%
>>>   ipi self_ipi_sti_nop                     310          307        +1.0%
>>>   eoi self_ipi_sti_nop                     242          241        +0.4%
>>> self_ipi_sti_hlt                          2714         2704        +0.4%
>>>   ipi self_ipi_sti_hlt                     310          307        +1.0%
>>>   eoi self_ipi_sti_hlt                     242          240        +0.8%
>>> self_ipi_tpr                              1272         1263        +0.7%
>>>   ipi self_ipi_tpr                         309          307        +0.6%
>>>   eoi self_ipi_tpr                         241          240        +0.4%
>>> self_ipi_tpr_sti_nop                      1304         1295        +0.7%
>>>   ipi self_ipi_tpr_sti_nop                 309          307        +0.6%
>>>   eoi self_ipi_tpr_sti_nop                 242          241        +0.4%
>>> self_ipi_tpr_sti_hlt                      3003         2991        +0.4%
>>>   ipi self_ipi_tpr_sti_hlt                 309          307        +0.6%
>>>   eoi self_ipi_tpr_sti_hlt                 242          240        +0.8%
>>> x2apic_self_ipi_sti_nop                    899          895        +0.4%
>>>   ipi x2apic_self_ipi_sti_nop              191          190        +0.5%
>>>   eoi x2apic_self_ipi_sti_nop              242          241        +0.4%
>>> x2apic_self_ipi_sti_hlt                   2592         2587        +0.2%
>>>   ipi x2apic_self_ipi_sti_hlt              191          190        +0.5%
>>>   eoi x2apic_self_ipi_sti_hlt              242          241        +0.4%
>>> x2apic_self_ipi_tpr                       1159         1151        +0.7%
>>>   ipi x2apic_self_ipi_tpr                  193          193         0.0%
>>>   eoi x2apic_self_ipi_tpr                  241          240        +0.4%
>>> x2apic_self_ipi_tpr_sti_nop               1189         1180        +0.8%
>>>   ipi x2apic_self_ipi_tpr_sti_nop          193          193         0.0%
>>>   eoi x2apic_self_ipi_tpr_sti_nop          242          241        +0.4%
>>> x2apic_self_ipi_tpr_sti_hlt               2887         2875        +0.4%
>>>   ipi x2apic_self_ipi_tpr_sti_hlt          194          192        +1.0%
>>>   eoi x2apic_self_ipi_tpr_sti_hlt          242          239        +1.2%
>>> ple_round_robin                             19           19         0.0%
>>> wr_kernel_gs_base                           73           73         0.0%
>>> wr_ibpb_msr                                563          557        +1.1%
>>> wr_tsc_adjust_msr                         5352         2603       +51.4%
>>> rd_tsc_adjust_msr                         5330         2586       +51.5%
>>> toggle_cr0_wp                            11319         5810       +48.7%
>>> toggle_cr4_pge                           11743         6242       +46.8%
>>> mmio-no-eventfd:pci-mem                  31890        26835       +15.9%
>>> mmio-wildcard-eventfd:pci-mem             6461         3666       +43.3%
>>> mmio-datamatch-eventfd:pci-mem            6449         3671       +43.1%
>>> portio-no-eventfd:pci-io                 25218        21455       +14.9%
>>> portio-wildcard-eventfd:pci-io            5512         2774       +49.7%
>>> portio-datamatch-eventfd:pci-io           5524         2780       +49.7%
>>> ------------------------------------------------------------------------
>> Just curious what causes the gain difference between these test cases?
>> Different vm-exit/vm-entry number in each test case? Suppose the cost for
>> saving/restoring PMU MSRs on each vm-exit/vm-entry should be same or close.
>>
> In this case, the cost is actually lower when hardware handles save-restore
> of PMU MSRs. Hardware can use fastpaths and optimizations which an usual
> RDMSR/WRMSR sequence cannot.

Thanks. My question is why the different test case show so much difference
on the gains, e.g., cpuid has +51%, while invd has -15%. Per my
understanding, the cost of saving/restoring PMU MSRs for most vm-exits
(exclude the fastpath vm-exit) should be fixed even for different vm-exit
reasons. Is it true? 


>
>>> The largest gains are for wbinvd (+52.1%), vmcall (+52.0%), and cpuid
>>> (+51.4%), followed by the TSC-adjust MSR accesses (~+51%), the
>>> kernel-handled port I/O paths (~+50%), and the control-register toggles
>>> (~+47-49%). The wildcard and datamatch MMIO / port-I/O paths improve by
>>> ~+43-50%, while the slower no-eventfd MMIO / port-I/O and pmtimer/qemu
>>> port-I/O paths improve by ~+15-18%.
>>>
>>> The only meaningful regression is invd (-15.6%). The self-IPI and EOI
>>> subtests move by at most 1.2% and wr_kernel_gs_base is unchanged, all
>>> within run-to-run noise.
>>>
>>> Design
>>> ------
>>>   * The entity responsible for switching the guest PMU state is tracked
>>>     per-VM via a new set of mediated PMU capability flags in kvm_arch.
>>>     In software-switched mode the state resides in struct kvm_pmu; in
>>>     hardware-switched mode it resides in the vendor save area.
>>>   * Event filtering, instruction emulation, and intercepted RDPMC still
>>>     need the state in struct kvm_pmu, so new vendor state-sync PMU ops
>>>     synchronize specific MSRs between struct kvm_pmu and the vendor
>>>     save area on demand.
>>>   * On SVM, the feature depends on VNMI for guest PMI delivery and is
>>>     controlled by the new "vpmc" kvm_amd module parameter, enabled by
>>>     default when the host supports it and mediated PMU is enabled.
>>>
>>> Limitations
>>> -----------
>>>   * Not supported for SEV-ES and SEV-SNP guests: the guest PMU state
>>>     resides in an encrypted VMSA that is inaccessible to the event
>>>     filtering logic.
>>>   * With VNMI and no AVIC, overflow interrupts are always delivered as
>>>     NMIs because the APIC is emulated and the LVTPC is ignored. This
>>>     shows up as expected behavioral differences in the x86/pmu test of
>>>     kvm-unit-tests.
>>>
>>> Overview
>>> --------
>>> Patches 1-3 extend the mediated PMU framework with hardware-switched
>>> mode: the capability flags, the vendor state-sync ops, and the generic
>>> support. Patches 4-6 add the SVM enablement: the PerfCtrVirt feature
>>> bit, the VMCB save-area fields, and the SVM implementation. Patch 7
>>> adds nested (nSVM) support to use the feature with L2 guests. Patch 8
>>> explicitly disables the feature for SEV-ES and SEV-SNP guests.
>>>
>>> Tested with kvm-unit-tests (KUT) and perf fuzzer. KUT's x86/pmu test
>>> requires patching to accept overflow interrupts as NMIs (limitation
>>> because of VNMI ignoring the LVTPC). It is recommended to apply the
>>> following patches before testing.
>>> https://lore.kernel.org/kvm/3bfbf15c22652ba00cf4a16fe9e0a3bfe7071f97.1784096302.git.sandipan.das@amd.com/
>>> https://lore.kernel.org/kvm/b075ec13e95167da1f2229626713c91d291bb75b.1784097178.git.sandipan.das@amd.com/
>>> https://lore.kernel.org/all/106bc3a4660653cb7750f3ae07a4dbca42c2762c.1786356229.git.sandipan.das@amd.com/
>>>
>>> base-commit: 6cf46b37b0356b3408f8ba949e10462cc71b533d
>>>              (tag: kvm-x86-next-2026.08.07)
>>>
>>> Previous versions can be found at:
>>> rfc: https://lore.kernel.org/kvm/cover.1762960531.git.sandipan.das@amd.com/
>>>
>>> Changes in v1:
>>>   * Introduce mediated PMU capabilities for hardware PMU virtualization
>>>     features instead of perf PMU capabilities.
>>>   * Make VNMI a hard requirement since AVIC can be inhibited.
>>>   * Introduce new PMU ops to access VMCB PMU state instead of relying
>>>     on host-initiated {get,set}_msr() ops.
>>>   * Make VMCB PMU state accessible via KVM_{GET,SET}_MSRS for migration.
>>>   * Implement support for nested SVM.
>>>   * Disable support for SEV-ES and SEV-SNP guests explicitly.
>>>
>>> Sandipan Das (8):
>>>   KVM: x86/pmu: Add mediated PMU capability flags
>>>   KVM: x86/pmu: Add PMU ops for vendor state sync
>>>   KVM: x86/pmu: Add support for hardware-switched PMU
>>>   x86/cpufeatures: Add PerfCtrVirt feature bit
>>>   KVM: SVM: Add VMCB fields for PMC virtualization
>>>   KVM: SVM: Add support for hardware-switched PMU
>>>   KVM: nSVM: Add support for hardware-switched PMU
>>>   KVM: SEV: Disallow the use of hardware-switched PMU
>>>
>>>  arch/x86/include/asm/cpufeatures.h     |   1 +
>>>  arch/x86/include/asm/kvm-x86-pmu-ops.h |   3 +
>>>  arch/x86/include/asm/kvm_host.h        |  11 +++
>>>  arch/x86/include/asm/svm.h             |  13 ++-
>>>  arch/x86/kvm/cpuid.c                   |   1 +
>>>  arch/x86/kvm/pmu.c                     | 102 +++++++++++++++++----
>>>  arch/x86/kvm/pmu.h                     |  29 ++++++
>>>  arch/x86/kvm/svm/nested.c              |  45 +++++++++-
>>>  arch/x86/kvm/svm/pmu.c                 | 117 +++++++++++++++++++++++++
>>>  arch/x86/kvm/svm/sev.c                 |   3 +
>>>  arch/x86/kvm/svm/svm.c                 |  58 +++++++++++-
>>>  arch/x86/kvm/svm/svm.h                 |  19 ++++
>>>  arch/x86/kvm/vmx/pmu_intel.c           |   2 +
>>>  arch/x86/kvm/vmx/vmx.c                 |   3 +-
>>>  arch/x86/kvm/x86.c                     |   2 +
>>>  15 files changed, 384 insertions(+), 25 deletions(-)
>>>
