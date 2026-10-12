Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D732931DC;
	Mon, 12 Oct 2026 23:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848207; cv=none; b=FBGn2+0AIBxTEHiIVpa2S2AtLK62o75IGxGRJZBz9hP+vPZZub4dZOIysYkV8PpP+QzX1iyhFslefM/nC5SPP+io/Z09xS13IakAdVawpasXhzOwOPYr2MSakzcyawK0rTPr+VxXht8rrgAA92yUVHW/gXw1hVrfuUtZ62uFOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848207; c=relaxed/simple;
	bh=JgrQqBc7drMB24xVZlkTZA0BGVYt6L6Yu2oXQRrJeTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DIQW/4LdIA1Z+sEAvxPmzgBLlQGTcNESpoisyU0QPTfzhXZxd1LC8T2BF2OlEqLWhMYGn4bmURrG3IVfT6bYhFRfkHaUa3ahzxHL6bijn1a4+chqyxqH4QAfmPizsFalNHp1LEJa0KeDqqO7NKmnS6ZA5geICzf1TFlIi6QjRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz5+dybg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz5+dybg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89241F0089B;
	Mon, 12 Oct 2026 23:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848206;
	bh=aalcpPHEI/cFORApeGAdtVePJhBXOoIxU8ls0due+JQ=;
	h=From:To:Cc:Subject:Date;
	b=Vz5+dybgarR5LlJHlBOaF3KlzaWSHNHbC9uyHi2dP130GmKZRQfGnd8rX6BAFAVJr
	 t3aRyO1O5D6h+WPY2fAZKZehX7ozWzyEoE3zuL/bnc7cG1aoNpKzc+Oxg1DnPx0H+p
	 xsaZKycvbJuGzk2Hk34mLM45f8Dq4ZrtWNvd/rlLHtyR33J6aKSEMk9hyNw5BKrUzj
	 kPsWCJZNi/wjUADQO8jTUet2wLQ7yVhW2BLwRk9lMh2JI040lsqBeOAN5opinZR17h
	 3gvsBVktXCGt0Fg+oTEwZgfbOJT3jsDVeaphQZWNroY8QKegmaizTOyzuy175Zz19Y
	 akPVeSGZ5qmaw==
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
Subject: [PATCH v3 00/27] KVM: nSVM: Optimize nSVM TLB flushes
Date: Mon, 12 Oct 2026 23:36:11 +0000
Message-ID: <20261012233638.2546339-1-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
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

The Hyper-V bits only got build tested. The SEV bits were only tested
using the SEV selftests.

Otherwise, this series was tested in two ways:
1. A new selftest:
  - Tests most basic scenarios where L1 flushes the TLB for L2, as well
    as when KVM triggers a TLB flush for both L1 and L2.
  - On AMD, also tests that flushing (or changing) L2's ASID flushes
    nested NPT translations for all nCR3 roots, not just the current one.
  - Fails reliably when injecting manual TLB bugs (e.g. commenting out a
    flush).
  - Caught an actual bug when I was rebasing the series on top of
    Paolo's MMU structures rework.
  - Works for both SVM and VMX.
  - Was used to repro a separate nVMX TLB bug [1].

2. An AI generated script (now 1300 lines of bash that I still don't dare
   to read):
  - Runs 20 L1 VMs, split into two groups:
    - 10 L1 VMs with vCPUs pinned 1:1 to dedicated host CPUs, each
      running a single L2 VM with as many vCPUs as L1. This avoids TLB
      flushes on vCPU migration and L2 ASID switching, which would
      otherwise hide missed flushes.
    - 10 L1 VMs with vCPUs confined to half as many host CPUs, each
      running 4 L2 VMs. This overcommits CPU in both L0 and L1 to
      exercise TLB flushes on vCPU migration and L2 ASID switching.
  - Each L2 VM runs a workload that writes to most of its memory and then
    validates its content from a different vCPU.
  - L2 VMs overcommit memory in L1, and are periodically recycled to
    exercise ASID reallocation.
  - L0 periodically reclaims memory from L1 VMs proactively (exercise
    L0-induced TLB flushes).
  - The number of ASIDs is synthetically reduced (using a test-only
    patch) such that some L1 vCPUs use the fallback ASID for L2.
  - Runs with NPT enabled/disabled in L0 and L1.
  - Catches most manually injected TLB bugs, some only semi-reliably.
  - Caught an actual bug when testing the fallback ASID logic with
    synthetically reduced number of ASIDs (in v1).

Overall, I think I am happy with the testing I put this series through,
hence dropping the RFC tag at last.

Breakdown:
- Patch 1 is a bug fix that can be taken separately.
- Patches 2-11 implement the change to use static ASIDs per vCPU for
  SVM (including SEV-specific handling and fallback ASID optimization),
  and can also be taken separately if needed.
- Patches 12-26 add the L2 ASID and proper handling for it, leading to
  dropping the unconditional flushes on nested transitions.
- Patch 27 adds the nested TLB flush selftest.

v2 -> v3:
- Reworked INVLPGA emulation to free L2's shadow roots when NPT is
  disabled and L1 flushes L2's ASID, instead of syncing the flushed
  address.
- Dropped "KVM: x86/mmu: Rename __kvm_mmu_invalidate_addr() to
  kvm_mmu_sync_addr()" and "KVM: x86/mmu: Refactor kvm_mmu_invlpg() to
  allow skipping the GVA flush", as they are no longer needed.
- Use READ_ONCE()/WRITE_ONCE() to access the per-CPU fallback ASID vCPU
  tracking [Sashiko].
- Added a "memory" clobber to invlpga() in selftests [Sashiko].
- Clarified that VMRUN does not modify TLB_CONTROL in the changelog of
  "KVM: nSVM: Handle nested TLB flush requests through TLB_CONTROL".
- Collected Reviewed-by from Lai.
- Typo fixes.

v1 -> v2:
- Rebased on top of kvm-x86-next-2026.10.02. Drop the fixes to the
  dynamic ASID allocation that landed since v1 when switching to static
  ASIDs, as they are no longer needed (bumping the ASID generation on CPU
  online, resetting the ASID generation of both VMCBs on pCPU switch,
  and tracking pending full flushes per-CPU).
- Dropped "KVM: SVM: Duplicate pre-run ASID check for SEV and non-SEV
  guests", and keep syncing the ASID into the VMCB before VMRUN until
  static ASIDs are used, to avoid leaving vmcb02's ASID uninitialized
  for SEV guests in between [Sashiko].
- Explicitly initialize svm->asid during SEV VM migration in a separate
  patch, before the VMCB is initialized [Sashiko].
- Free any existing non-SEV ASID on the destination vCPUs during SEV VM
  migration to avoid leaking it, and decide whether an ASID needs to be
  freed based on the ASID range rather than the VM type [Sashiko].
- Update the L2 ASID (and vmcb02) during SEV VM migration if nested was
  already initialized on the destination vCPUs [Sashiko].
- Moved "KVM: nSVM: Drop svm->nested.initialized" before introducing the
  L2 ASID, so that the vmcb02 pointer can be reliably used to check if
  nested is initialized.
- Moved the WARN on L1 and L2 unexpectedly sharing an ASID to the patch
  that actually uses different ASIDs [Sashiko].
- Added KVM_REQ_MMU_SYNC_ALL_ROOTS, and sync all nested NPT roots (not
  just the current one) when L1 flushes or changes L2's ASID, as shadow
  NPT mappings are not tagged by ASID.
- Reset the last L2 ASID if nested VMRUN fails, to avoid losing the
  nested NPT sync.
- Extended the selftest to cover flushing with multiple nested NPT roots.
- Typo and changelog fixes.

RFC v2 -> v1:
- Dropped the RFC tag.
- Document KVM's handling of number of ASIDs in CPUID rather than
  increase the number of advertised ASIDs [Jim, Sean].
- Explicitly support reserved TLB tags rather than a minimum TLB tag
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
v1: https://lore.kernel.org/kvm/20260728003557.1136583-1-yosry@kernel.org/
v2: https://lore.kernel.org/kvm/20261008001425.2458927-1-yosry@kernel.org/

[1] https://lore.kernel.org/kvm/20260722230128.1587363-1-yosry@kernel.org/

Yosry Ahmed (27):
  KVM: nSVM: Flush the TLB after forcefully leaving nested
  KVM: SVM: Document number of ASIDs CPUID setting
  KVM: VMX: Generalize VPID allocation to be vendor-neutral
  KVM: x86/mmu: Support specifying reserved TLB tags
  KVM: SVM: Add helpers to set/clear ASID flush in VMCB
  KVM: SVM: Fallback to flush everything if FLUSHBYASID is not available
  KVM: SEV: Do ASID initialization at VMCB initialization
  KVM: SEV: Expose sev_get_asid() outside of sev.c
  KVM: SEV: Explicitly initialize the per vCPU ASID on SEV VM migration
  KVM: SVM: Use a static ASID per vCPU
  KVM: SVM: Only flush the fallback ASID when used by a different vCPU
  KVM: nSVM: Drop svm->nested.initialized
  KVM: nSVM: Add a placeholder ASID for L2
  KVM: x86: hyper-v: Rename kvm_hv_vcpu_purge_flush_tlb()
  KVM: x86: hyper-v: Allow purging all TLB flush FIFOs
  KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH
  KVM: nSVM: Always switch VMCB before leaving guest mode
  KVM: nSVM: Split nested_svm_transition_tlb_flush() into entry/exit fns
  KVM: nSVM: Service local TLB flushes before nested transitions
  KVM: x86: Add KVM_REQ_MMU_SYNC_ALL_ROOTS
  KVM: nSVM: Handle nested TLB flush requests through TLB_CONTROL
  KVM: nSVM: Flush the TLB if L1 changes L2's ASID in vmcb12
  KVM: nSVM: Do not reset TLB_CONTROL in vmcb02 on nested VM-Enter
  KVM: nSVM: Flush L2's ASID when emulating INVLPGA
  KVM: nSVM: Flush the ASID on nested transitions if shared by L1 and L2
  KVM: nSVM: Use different ASIDs for L1 and L2
  KVM: selftests: Add a test for nested TLB flushes

 Documentation/virt/kvm/api.rst                |  20 +
 arch/x86/include/asm/kvm_host.h               |   1 +
 arch/x86/kvm/cpuid.c                          |   4 +-
 arch/x86/kvm/hyperv.h                         |  33 +-
 arch/x86/kvm/mmu.h                            |  15 +
 arch/x86/kvm/mmu/mmu.c                        |  92 +++
 arch/x86/kvm/svm/nested.c                     | 151 +++--
 arch/x86/kvm/svm/sev.c                        |  37 +-
 arch/x86/kvm/svm/svm.c                        | 160 ++++--
 arch/x86/kvm/svm/svm.h                        |  55 +-
 arch/x86/kvm/vmx/vmx.c                        |  40 +-
 arch/x86/kvm/vmx/vmx.h                        |  28 +-
 arch/x86/kvm/x86.c                            |  13 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 tools/testing/selftests/kvm/include/x86/svm.h |   5 +
 tools/testing/selftests/kvm/include/x86/vmx.h |  21 +
 .../testing/selftests/kvm/lib/x86/processor.c |  36 ++
 .../selftests/kvm/x86/nested_tlb_flush_test.c | 526 ++++++++++++++++++
 19 files changed, 1076 insertions(+), 163 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c


base-commit: 6bd2905303c58679e303941b7d8ae8c074cd95ce
-- 
2.56.0.385.gd3acb90ef8-goog

