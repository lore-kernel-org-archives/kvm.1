Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBF83C583A;
	Mon, 27 Jul 2026 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196366; cv=none; b=FuXY2N5OYrd8CgqWpVEmpd71wssUU9Q9E4RdU9ZqWI4j7R/a4cMB/eDgM9ek7zZ0G961SJa8MApIrIbleM9BwN1IKN00mM5zt3veVn+mEHzJ3vHs3VK90z/JblL9Hod8IdATkCkfkfanHFQ46bWgVQ5LWAVlL8dOj8e3fUmLzWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196366; c=relaxed/simple;
	bh=zGxzUBR1cUH27e32qPzsVlh5KxOAeuwVr6BGjsoxFjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=slbeLhC6J6CPnP2bxrCJW4tRXnDh3kEh3lMvkuJPbGALZa5CnCqCyIngs9hj2olC3bV0NDLGT2Da7nR57zOUGvizqnC2PS/2HugnIlKUOhMRHypOmK4lV5m+HMA4yqHd0XB27Wcn1hwIt6Lxm0HyAKJESYuCmbm17izbTDD6HnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzjDPPz3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzjDPPz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BA51F000E9;
	Mon, 27 Jul 2026 23:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196365;
	bh=3ixTldtdiu2kWaOwujzl9m/EwVT7aBJ6jNqfPueerOk=;
	h=From:To:Cc:Subject:Date;
	b=FzjDPPz3FbOQxDWnzEGecqis1kAdTdvc5Rw9fn+8xXEZQSWr46QolPE/gLv945+Oz
	 GSN3Z0A11bDGlYRqvO1t7q7n2lR+Ntx4sxLGjRC7XiSzqvC8t3tU5Yd6BQY8IDBjbO
	 DDAY0jx9aPA6vl6fDc32U4Yrxek64JwhVJgxrxrtg2Xot8jruUHjnq8fIHpRFEgLG5
	 ww024ATozD4u+L6VmqpkQfzImqUOiKcWi/SlXlWDd6EqSpQxpUEg3HIOF5WMhhjbVh
	 SFiHPnmN/1FFC7E8ccJ0dD9f2heZHmuJ/ttKmK4ldzvKuVQc0GjtCG2SDe7nf/FEkp
	 UyreqPTUQrp5w==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 00/12] KVM: selftests: Stress save+restore and #PF (ft. nested)
Date: Mon, 27 Jul 2026 23:52:16 +0000
Message-ID: <20260727235228.1007324-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a stress test for save+restore while the guest is triggering and
handling #PFs, in both L1 and L2. The goal was to create a generic
selftest that would catch bugs like the one fixed by commit 5c247d08bc81
("KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12 on nested
#VMEXIT"), instead of relying on high-level testing (e.g. building GCC
in L2) to catch it.

The test tries to be as generic as possible by triggering #PFs in a
guest and installing a proper #PF handler, while the host is
continuously doing save+restore cycles. Exiting to userspace is randomly
triggered by a second thread that constantly signals the vCPU thread.

Patches (1-6) are prep patches, fixing GPR and RFLAGS switching for nSVM
and generalizing GPR switching to cover nVMX, which is needed for the
test to run properly with nVMX. Patch 6 removes
HORRIFIC_L2_UCALL_CLOBBER_HACK, as it is no longer needed. While this
series does not have the "complete" fix added by commit 6783ca4105a7
("KVM: selftests: Add a shameful hack to preserve/clobber GPRs across
ucall"), it's a good step in the right direction.

Patches (7-8) add minor infrastructure improvements (assertion failure
formatting and exposing MMU masks to the guest).

Patches (9-12) add the actual test. The test is first introduced as a
simple (read: dummy) stress test that just explicitly syncs to userspace
after each #PF handling to do save+restore, then gradually evolves to
add the random signaling, nested support, and triggering L2->L1 exits.
After the last patch, the test reliably reproduces the CR2 bug.

v3 -> v4:
- Switch guest_regs back to a struct and provide struct offsets as
  ASM constraints similar to kvm-unit-tests [Sean].
- Expose PTE masks to guests as part of a guest MMU [Sean].
- Use __stringify() from <linux/stringify.h> instead of custom STR() and
  XSTR() macros [Sean].
- Handle guest RFLAGS save/restore as part of guest_regs.
- Run both L0 and L2 tests sequentially by default if nested is supported,
  instead of requiring a '-n' command line argument [Sean].
- Minor fixups and cleanups [Sean].

v2 -> v3:
- Rebased on top of L2 stack rework in selftests.
- Fix GPR array size (i.e. NR_GUEST_REGS) [Sashiko].
- Handle evmcs_vmlaunch() and evmcs_vmresume() [Sashiko].
- Fix off-by-one assertion error in intermediate patches.
- Increase inter-signal delay from 100us to 1msec.

v1 -> v2:
- Switch guest_regs to an array, which simplifies the offsets
  calculation and forgoes the dependency on using OFFSET() or defining
  the struct offsets for assembly otherwise.
- Move page table mapping to the test (instead of a generic helper), as
  the helper mistakenly tried to map the entire memslot, not just page
  tables.
- Do not use identity mappings for page tables as it collisions with
  GVAs used for ELF in some cases.
- Simplify page table walking by using loops.
- Make sure the signals are ignored before creating the signaling
  thread [Sashiko]
- Assert that the guest actually ran and had page faults [Sashiko]
- Add a patch to fix RAX and RFLAGS offsets in run_guest() [Sashiko]
- Initialize exception_has_payload when injecting a #UD [Sashiko]
- Only check KVM_STATE_NESTED_GUEST_MODE when running in nested mode
  [Sashiko]

v1: https://lore.kernel.org/all/20260518202514.2037078-1-yosry@kernel.org/
v2: https://lore.kernel.org/kvm/20260604203546.365658-1-yosry@kernel.org/
v3: https://lore.kernel.org/kvm/20260629183746.699840-1-yosry@kernel.org/


Yosry Ahmed (12):
  KVM: selftests: Use __stringify() instead of custom XSTR() macros
  KVM: selftests: Fix RAX and RFLAGS VMCB offsets when running L2
  KVM: selftests: Rework GPR registers switching for SVM (and fix
    offsets)
  KVM: selftests: Handle rflags save/restore for SVM in guest_regs
  KVM: selftests: Reuse GPR switching logic for nVMX
  KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
  KVM: selftests: Add a blank line before logging assertion failures
  KVM: selftests: Expose PTE masks to guests as part of an MMU
  KVM: selftests: Add basic stress test for save+restore and #PF
    handling
  KVM: selftests: Trigger save+restore randomly in the #PF stress test
  KVM: selftests: Support running stress save+restore and #PF test in L2
  KVM: selftests: Trigger L2->L1 exits stress save+restore and #PF test

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/test_util.h |   1 +
 .../testing/selftests/kvm/include/x86/evmcs.h |  46 +--
 .../selftests/kvm/include/x86/processor.h     |  53 +++-
 tools/testing/selftests/kvm/include/x86/vmx.h |  69 ++---
 tools/testing/selftests/kvm/lib/assert.c      |   2 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  14 +
 tools/testing/selftests/kvm/lib/x86/svm.c     |  62 ++--
 tools/testing/selftests/kvm/lib/x86/ucall.c   |  32 +-
 .../kvm/x86/evmcs_smm_controls_test.c         |   5 +-
 .../selftests/kvm/x86/fix_hypercall_test.c    |   1 -
 .../kvm/x86/save_restore_pf_stress_test.c     | 291 ++++++++++++++++++
 tools/testing/selftests/kvm/x86/smm_test.c    |   5 +-
 13 files changed, 442 insertions(+), 140 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c


base-commit: 271255273d5ff348fe29d89fe4712b2f7f7907c3
-- 
2.55.0.229.g6434b31f56-goog

