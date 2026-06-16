Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC6189F20;
	Tue, 16 Jun 2026 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570542; cv=none; b=fB7P//DrQzWQco1dLGb6FMco0Xj2ahT88Ah9TbNP8ECHpgiKypwURhFeeVb3fVV0W+tpyWpqz/gzEF21eTzcHjKsHczMAPumKJ7Pc62tYb6LXV4pLJLCD9a3aRfxm0kJCKL0P2TU0ZWA7eGHK9/6eRG6AmGJRiyezpznwRPsAVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570542; c=relaxed/simple;
	bh=zI8lPf5aLajdh27/JRJNELGimz8jPzDdYmzhtoMOhjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWJj1e6M0hdXcctxk2XVeVs/csK59+4RLs5eAHnTB7D2OEPUZmLIl2Wt+PThsyJwsNnsQ9wgyJ28sOViAZsMZTqZyQNrIocyaiBt9R1RtYz7mcPVqN6vERuAWycf/Gjgv3PmBASZpW3hI8mBKCRIb9lFQN+zfkUCDaOiwAbg+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt4zAu+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt4zAu+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270911F000E9;
	Tue, 16 Jun 2026 00:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570541;
	bh=RWszTfQamjG4cUbhJyG0QQOkr7xIKS14iEKBaGlo9Dk=;
	h=From:To:Cc:Subject:Date;
	b=Bt4zAu+fc4YB1vNz4pm+J9M0zKOc21TP3ecCn6Ltu0sUsQpfEIWJ30EXgeNoz7s7+
	 vJVXH/CUdmbQryND0zsjP3LlWRGuiDSiwhg+cz5/bVONVyBPIoL7q1YxhIQfGsIk5z
	 rOjBPrzTIC1vHBWw/4VNOkSbiz51jz8aCmrHejklO576mPZGm+GndUVbKabgEv6mkg
	 QNkQWtPDmHxs9pda6gGRsOemdM2eLOuduYsxgS6JH9S4lQUf0x6KwJZC2+Fh083/AZ
	 rJeOTf5swzQDkX0+gdFHotiRK38EG0VX+fart7pDfm7hjR4Cv4pB3HUFgYHsrIn001
	 2wbAmNsaEgexQ==
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
Subject: [RFC PATCH v2 00/25] Optimize nSVM TLB flushes
Date: Tue, 16 Jun 2026 00:41:29 +0000
Message-ID: <20260616004155.1435766-1-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A second RFC series (or third) for optimizing TLB flushes for nested
SVM, over a year later. This series optimizes TLB flushes by using and
maintaining a separate ASID for L2 for each vCPU (similar to VMX's
handling of VPIDs), rather than sharing the same ASID and flushing
everything on every nested transition.

The series also drops the dynamic ASID allocation scheme and uses a
static ASID for vCPU (or two if using nested), brining it further closer
to how VMX handles VPIDs. Modern CPUs (checked Milan, Genoa, and Turin)
advertise 32K ASIDs, so there is no point.

The series is mostly in a good shape, but it is an RFC because I only
did basic testing (booted an L2 and an L3, run netperf in L2). I am
mainly sending this out to get some feedback on the code while I do more
extensive testing. Ideally I would test this with a memory overcommitted
VM in L0 (to trigger KVM unmapping and flushing guest memory) and a CPU
overcommitted VM in L1 (to trigger L1 KVM multiplexing multiple L2 ASIDs
on the same L1 vCPU) -- let's see if AI can help with this.

Admittedly, the SEV and HV bits only got build tested, and I doubt that
I would be able to do more than this going forward.

Since over a year passed and the code changed non-trivially, I dropped
all Reviewed-by tags (sorry Maxim!), even on patches that are relatively
the same. I won't go too much into the details for what changed because
over a year has passed, but I will describe the main changes.

Breakdown:
- Patch 1 is a bug fix that can be taken separately.
- Patches 2-9 implement the change to use static ASIDs per vCPU for
  SVM, and can also be taken separately if needed.
- The rest of the patches (up to patch 24) add an L2 ASID and proper
  handling for it, leading to ultimately dropping the unconditional
  flushes on nested transitions.
- Patch 25 is purely for testing convenience. It adds a module param
  that adds back the unconditional flushes. Although if we are really
  paranoid we can keep it for a while? Idk if we usually do that.

RFC v1 -> RFC v2:
- Changed from a static ASID per VM to a static ASID per vCPU, dropping
  the needed per-CPU ASID -> vCPU tracking and dropping all SEV changes.
- Fixed a missing flush in the current code when forcefully leaving
  nested (patch 1).
- Expose more ASIDs to L1 (patch 2), otherwise the usefulness of this
  series is limited when L1 runs a bunch of L2s.
- Drop passing is_guest_mode around (past me, EW!).
- Reuse more of kvm_mmu_invlpg() for INVLPGA emulation.
- Fix INVLPGA emulation in case L1 runs on a different CPU than L2 (but
  L2 never switches its CPU).
- Resync the nested NPT when L1 changes L2's ASID (missed in RFC v1).
- Shuffled some patches around, combined/split patches differently, and
  rewrote some changlogs.

RFC v1: https://lore.kernel.org/lkml/20250326193619.3714986-1-yosry.ahmed@linux.dev/


Yosry Ahmed (25):
  KVM: nSVM: Flush the TLB after forcefully leaving nested
  KVM: SVM: Passthrough the number of supported ASIDs
  KVM: VMX: Generalize VPID allocation to be vendor-neutral
  KVM: x86/mmu: Support specifying a minimum TLB tag
  KVM: SVM: Add helpers to set/clear ASID flush in VMCB
  KVM: SVM: Fallback to flush everything if FLUSHBYASID is not available
  KVM: SVM: Duplicate pre-run ASID check for SEV and non-SEV guests
  KVM: SEV: Stop using per-vCPU ASID for SEV VMs
  KVM: SVM: Use a static ASID per vCPU
  KVM: nSVM: Add a placeholder ASID for L2
  KVM: x86: hyper-v: Rename kvm_hv_vcpu_purge_flush_tlb()
  KVM: x86: hyper-v: Allow puring all TLB flush FIFOs
  KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH
  KVM: nSVM: Move svm_switch_vmcb() to nested.c
  KVM: nSVM: Call nested_svm_transition_tlb_flush() on every VMCB switch
  KVM: nSVM: Split nested_svm_transition_tlb_flush() into entry/exit fns
  KVM: nSVM: Service local TLB flushes before nested transitions
  KVM: nSVM: Handle nested TLB flush requests through TLB_CONTROL
  KVM: nSVM: Flush the TLB if L1 changes L2's ASID in vmcb12
  KVM: nSVM: Do not reset TLB_CONTROL in vmcb02 on nested VM-Enter
  KVM: x86/mmu: rename __kvm_mmu_invalidate_addr()
  KVM: x86/mmu: Refactor kvm_mmu_invlpg() to allow skipping the gva
    flush
  KVM: nSVM: Flush L2's ASID when emulating INVLPGA
  KVM: nSVM: Use different ASIDs for L1 and L2
  DO NOT MERGE: Add nested_tlb_force_flush

 arch/x86/include/asm/kvm_host.h |   3 +
 arch/x86/kvm/cpuid.c            |   2 -
 arch/x86/kvm/hyperv.h           |  33 ++++++--
 arch/x86/kvm/mmu.h              |   8 ++
 arch/x86/kvm/mmu/mmu.c          | 106 +++++++++++++++++++++---
 arch/x86/kvm/svm/nested.c       | 106 ++++++++++++++++++------
 arch/x86/kvm/svm/sev.c          |  12 ++-
 arch/x86/kvm/svm/svm.c          | 137 ++++++++++++++++++++------------
 arch/x86/kvm/svm/svm.h          |  41 +++++++---
 arch/x86/kvm/vmx/vmx.c          |  40 +++-------
 arch/x86/kvm/vmx/vmx.h          |  29 ++++++-
 arch/x86/kvm/x86.c              |   2 +-
 12 files changed, 377 insertions(+), 142 deletions(-)


base-commit: c1f7303302927f9cbf4efedf70f0512cde168c65
-- 
2.54.0.1136.gdb2ca164c4-goog

