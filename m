Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575E1DE2A5;
	Tue, 28 Jul 2026 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198965; cv=none; b=R00xKXavefeu1ABy3EGYr7dC4HZNOgsYWX3WNMp/MHMi/+5vzcsxtgrWze0Yy0+i/zrnkpD2fNjQdx9ZGQqwciBefM36nBOvOodTtYgSSyWFmVWRzE6IwPOXwHS3kuPGYVP7S1zBOcFRR4/luD2oBGYCB+ap8qFNmT9kjvXL1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198965; c=relaxed/simple;
	bh=+HCqnyQLBTDd8KXgJJ7h0hYoHnDYjPPr0J0nbpN8Nd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krxhJcviF6KXPXi/oaUKVyZJQp2iuvKK6Wbc98+jiuaT+fddsT4g3+Waidm7CBCACq0k0LP0LHlBpwpwcJCou/JIrUXpmsrZ+HjNdbFDqcYJhbrhBzV6M7qKQtcW5FRkcYx4/f/vkBcStWkXRqnjIy5Di7krpboS0DGAAlxYlEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H43HeaCx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H43HeaCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429EF1F000E9;
	Tue, 28 Jul 2026 00:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198963;
	bh=p8braoJmZyG4vXnk/jWGHrZbkOThH2zKb6UuTCLImyw=;
	h=From:To:Cc:Subject:Date;
	b=H43HeaCxYfQ2wp7svlFKiM6Q3A1wzruXdkCgolpx1fpAIIOFd0ghjv5xJ5JoZ3f35
	 xJ72OYEYObttKZbUCBCS2yjH3cWQK4WNXTIjgu3a7gA3Z/2YeuZfIDNUOsyErFLrqm
	 +zNx6lJk2dHruabAvhd4w8WqsHhTDNYc61HAU2boc0AWHeUgdtdByfvHc2MrWH2nvj
	 2vDt/KPQ7TyIUoGSPxOeKuSQnIUufZ8cc8Va1Ot+QufZj1d1HNJmVcxLGkX9wStNSl
	 GFnhi0qyloMsjQweZecxOUZ3mBou3Id3MZV66ADxwmsVllnFAUhhevaBA8s0hdjaQX
	 YtYJYXv+OK82w==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v1 00/28] KVM: nSVM: Optimize nSVM TLB flushes
Date: Tue, 28 Jul 2026 00:35:29 +0000
Message-ID: <20260728003557.1136583-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series optimizes TLB flushes for nested SVM by using and maintaining
a separate ASID for L2 for each vCPU (similar to VMX's handling of VPIDs),
rather than sharing the same ASID and flushing everything on every nested
transition.

The series also drops the dynamic ASID allocation scheme and uses a
static ASID per vCPU (or two if using nested), bringing it closer to how
VMX handles VPIDs. Modern CPUs (Rome, Milan, Genoa, Turin) advertise 32K
ASIDs, so there is no need for dynamic allocation.

The SEV and Hyper-V bits only got build tested.

Otherwise, this series was tested in two ways:
1. A new selftest:
  - Tests most basic scenarios where L1 flushes the TLB for L2, as well
    as when KVM triggers a TLB flush for both L1 and L2.
  - Fails reliably when injecting manual TLB bugs (e.g. commenting out a
    flush).
  - Caught an actual bug when I was rebasing the series on top of
    Paolo's MMU structures rework.
  - Works for both SVM and VMX.
  - Was used to repro a separate nVMX TLB bug [1].

2. An AI generated script (800 lines of bash that I don't dare to read):
  - Runs 10 L1 VMs, each with 4 L2 VMs inside.
  - Each L2 VM runs a workload that writes to all memory and then
    validates its content.
  - L2 VMs overcommit both memory and CPU in L1 (exercise L1-induced TLB
    flushes as well as L2 ASID switching).
  - L0 periodically reclaims memory from L1 VMs proactively (exercise
    L0-induced TLB flushes).
  - Fails semi-reliably when injecting manual TLB bugs.
  - Caugh an actual bug when testing the fallback ASID logic with
    synthetically reduced number of ASIDs.

Overall, I think I am happy with the testing I put this series through,
hence dropping the RFC tag at last.

Breakdown:
- Patch 1 is a bug fix that can be taken separately.
- Patches 2-11 implement the change to use static ASIDs per vCPU for
  SVM (including SEV-specific handling and fallback ASID optimization),
  and can also be taken separately if needed.
- Patches 12-27 add the L2 ASID and proper handling for it, leading to
  dropping the unconditional flushes on nested transitions.
- Patch 28 adds the nested TLB flush selftest.

RFC v2 -> v1:
- Dropped the RFC tag.
- Document KVM's handling of number of ASIDs in CPUID rather than
  increase the number of advertised ASIDs [Jim, Sean].
- Explicitly support reserved TLB tags rather than a minuimum TLB tag
  [Sean].
- Set an upper bound on the number of TLB tags [Sean].
- Allow reserving all ASIDs to allow allocating all ASIDs to SEV (if at
  all possible). [Sashiko].
- Actually handle TLB flushes for nested on SEV [Sean, Sashiko].
- Optimize fallback ASID flushes by tracking the last vCPU using it on
  each pCPU instead of flushing it on every VMRUN [Sean].
- Drop svm->nested.initialized and properly NULLify the vmcb02 pointer
  instead (and use it).
- Make sure servicing local TLB flushes is done when both the VMCB and
  guest_mode are consistent [Sashiko].
- Always initialize last_asid to 0 to flush the TLB on the first use of
  L2's ASID [Sashiko].
- Open-code TLB flush handling on nested VM-Enter and VM-Exit instead of
  burying it in svm_switch_vmcb() [Sean].
- Always flush the hardware ASID on nested transitions if L1 and L2
  share it (e.g. when using the fallback ASID, or for SEV guests) to
  prevent TLB entry leakage between L1 and L2.
- Rename __kvm_mmu_invalidate_addr() to kvm_mmu_sync_addr() [Sean].

RFC v1: https://lore.kernel.org/lkml/20250326193619.3714986-1-yosry.ahmed@linux.dev/
RFC v2: https://lore.kernel.org/kvm/20260616004155.1435766-1-yosry@kernel.org/

[1]https://lore.kernel.org/kvm/20260722230128.1587363-1-yosry@kernel.org/


Yosry Ahmed (28):
  KVM: nSVM: Flush the TLB after forcefully leaving nested
  KVM: SVM: Document number of ASIDs CPUID setting
  KVM: VMX: Generalize VPID allocation to be vendor-neutral
  KVM: x86/mmu: Support specifying reserved TLB tags
  KVM: SVM: Add helpers to set/clear ASID flush in VMCB
  KVM: SVM: Fallback to flush everything if FLUSHBYASID is not available
  KVM: SVM: Duplicate pre-run ASID check for SEV and non-SEV guests
  KVM: SEV: Do ASID initialization at VMCB initialization
  KVM: SEV: Expose sev_get_asid() outside of sev.c
  KVM: SVM: Use a static ASID per vCPU
  KVM: SVM: Only flush the fallback ASID when used by a different vCPU
  KVM: nSVM: Add a placeholder ASID for L2
  KVM: x86: hyper-v: Rename kvm_hv_vcpu_purge_flush_tlb()
  KVM: x86: hyper-v: Allow puring all TLB flush FIFOs
  KVM: nSVM: Drop svm->nested.initialized
  KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH
  KVM: nSVM: Always switch VMCB before leaving guest mode
  KVM: nSVM: Split nested_svm_transition_tlb_flush() into entry/exit fns
  KVM: nSVM: Service local TLB flushes before nested transitions
  KVM: nSVM: Handle nested TLB flush requests through TLB_CONTROL
  KVM: nSVM: Flush the TLB if L1 changes L2's ASID in vmcb12
  KVM: nSVM: Do not reset TLB_CONTROL in vmcb02 on nested VM-Enter
  KVM: x86/mmu: Rename __kvm_mmu_invalidate_addr() to
    kvm_mmu_sync_addr()
  KVM: x86/mmu: Refactor kvm_mmu_invlpg() to allow skipping the GVA
    flush
  KVM: nSVM: Flush L2's ASID when emulating INVLPGA
  KVM: nSVM: Flush the ASID on nested transitions if shared by L1 and L2
  KVM: nSVM: Use different ASIDs for L1 and L2
  KVM: selftests: Add a test for nested TLB flushes

 Documentation/virt/kvm/api.rst                |  20 +
 arch/x86/kvm/cpuid.c                          |   4 +-
 arch/x86/kvm/hyperv.h                         |  33 +-
 arch/x86/kvm/mmu.h                            |  11 +
 arch/x86/kvm/mmu/mmu.c                        | 126 ++++-
 arch/x86/kvm/svm/nested.c                     | 142 ++++--
 arch/x86/kvm/svm/sev.c                        |  16 +-
 arch/x86/kvm/svm/svm.c                        | 133 ++++--
 arch/x86/kvm/svm/svm.h                        |  54 ++-
 arch/x86/kvm/vmx/vmx.c                        |  40 +-
 arch/x86/kvm/vmx/vmx.h                        |  28 +-
 arch/x86/kvm/x86.c                            |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/svm.h |   5 +
 tools/testing/selftests/kvm/include/x86/vmx.h |  21 +
 .../selftests/kvm/x86/nested_tlb_flush_test.c | 432 ++++++++++++++++++
 16 files changed, 916 insertions(+), 152 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c


base-commit: 271255273d5ff348fe29d89fe4712b2f7f7907c3
-- 
2.55.0.229.g6434b31f56-goog

