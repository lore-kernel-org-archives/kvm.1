Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4725D390214;
	Fri,  4 Sep 2026 02:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489096; cv=none; b=Tbn/3emK6AKTKAs/BdT4XsVjwWWgsWukLxRqUTHhe/89aiJ81HY7bJO0x53zTM1ppui8Hca5tS/LRAg60WDVhG442LE2fcvh/9KOSA2ZBVKcgRIM7CkrZekykr7C0Y7XUBgvGwW5OBqWXQsV7DFLT/HzYnsjA7pFZCG/OzNHa0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489096; c=relaxed/simple;
	bh=akIoDhXyVIrI7sL7nD+jqHniSkh3DFIabdfKV37esCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qMMB0kkl2We+/+naRlmidZ9RI44Qbas9RXXvE4aX3GRscphz96FDy4SqnRmpJAbPYlFLtLKW5t83IHQ8HhPVPqx/fOcSCWbEi+MevmF+w6VvtQcnKeOjSWsKioLP10IZ/pVPi3UXNrzA0VfAu8kBgtRHIZc+FG94WVNUMHxQrtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6eEAlJZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6eEAlJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788489093; x=1820025093;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=akIoDhXyVIrI7sL7nD+jqHniSkh3DFIabdfKV37esCw=;
  b=Y6eEAlJZKE878DYvnhKqAM3jB2y8K4e7o+bFs1Mzx8lqi3zIcie9Dmvz
   KprVn82smjD0RW+G2uEm9rby+zYaG5AdlhVQAuOBNyrESumvQVQ1b2dZa
   BrizcUOkAcf5Ebmqi5EPE57g2dPPBPTLjxHSZgLF6//YVZwPUndfi/718
   gLljO1He2A94anNzn3qZFg16FYQq5LbYMpnFeMa3cbF9S9mmyZEmE2yea
   sCWKPRL8tPFsMgHCw8ZMhGij+n3/hDvSnMjQFFLxP0is7riJ28La9CX8n
   PiJTSrh3MoYZL/ms5AKGK+fvryDK0SPda9jgom1AuiUyiYqjjpnoam1j8
   Q==;
X-CSE-ConnectionGUID: 713oasOYQ1WYR3kWVYrDBg==
X-CSE-MsgGUID: pVxugXkeTp+g+vUd91LN0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="106506737"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="106506737"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:31:32 -0700
X-CSE-ConnectionGUID: CBsqO7imSD6iGL6OHbMuJw==
X-CSE-MsgGUID: 3eBBviPLSPykQsDmVANN8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="270433488"
Received: from zhaoliu1-desk.sh.intel.com ([10.238.208.118])
  by orviesa009.jf.intel.com with ESMTP; 03 Sep 2026 19:31:29 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Chao Gao <chao.gao@intel.com>,
	Xin Li <xin@zytor.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 0/4] KVM: nVMX: Fix guest (CET) state handling on VM-entry failure
Date: Fri,  4 Sep 2026 10:31:01 +0800
Message-Id: <20260904023105.1167376-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series tries to point out the missing guest state retain behavior
in the current KVM handling for the nested vm-entry failure case, by a
CET nested selftest (patch 4), and to raise a discussion on how KVM
retains guest state at VM-entry failure.

Currently, I think there are two possible fix approaches: one is patch 1,
which explicitly enumerates the stages, and the other is option B
mentioned in section "Option B", which uses (or reuse pre_vmenter_* ?)
intermediate variables to cache the guest state between vmcs01 and
vmcs02.

Back to problem (using CET as the example), at present, on a nested
VM-exit with VM_EXIT_LOAD_CET_STATE cleared, KVM unconditionally copies
vmcs12's guest CET fields into vmcs01. When the VM-exit is a VM-entry
failure that occurred before guest state was loaded, those fields hold
what L1 wrote for L2, not what the CPU would have kept, so L1 resumes
with the S_CET/SSP/INTERRUPT_SSP_TABLE_ADDR it had programmed for L2.

This does not conform to the SDM's description of vm-entry failure.

Background
==========

What L1 should observe after a nested VM-exit depends on three things:
the VM-exit "load host state" control, whether VM-entry got far enough
to load L2's state, and whether L2 ran. For CET:

 1) VM_EXIT_LOAD_CET_STATE set: load L1's state from vmcs12's host
    fields, no matter what happened before. KVM already does this, and
    setting this control makes L1 immune to the bug below.

 2) Control clear, VM-entry loaded L2's CET state: the guest state is
    retained on the CPU, so L1 observes it. Copying vmcs12's guest
    fields into vmcs01 gives the right result.

 3) Control clear, VM-entry did not load L2's CET state (VM-entry
    failed before the guest-state loading phase): the CPU keeps L1's
    own state, so KVM must do nothing.

 4) Control clear, VM-entry did not load CET state, but L2 ran and
    exited normally: L2 may have changed the state while running, and
    vmcs12's guest fields hold what L2 left behind (guest CET state is
    always saved on VM-exit; there is no VM-exit control for it), so
    copying them is again correct.

Case 3) is broken today: KVM never syncs vmcs02 back to vmcs12 on the
VM-entry failure path, so vmcs12's guest fields still hold whatever L1
wrote with VMWRITE, and KVM stuffs that into vmcs01.

Note that one "VM-entry failed" flag is not enough to distinguish 2)
from 3): MSR loading happens after guest-state loading, so an
EXIT_REASON_MSR_LOAD_FAIL implies L2's state was loaded, whereas an
EXIT_REASON_INVALID_STATE does not.

The INVALID_STATE side of this is a modeling choice, not a hardware
guarantee. Per the SDM ("Checking and Loading Guest State"), guest-state
checking and loading occur concurrently, so whether L2's state was
loaded when the check fails is architecturally undefined.

With patch 1, we can make the behavior well-defined for KVM, by treating
the check as preceding the load, i.e. it emulates an INVALID_STATE
VM-entry failure as if no guest state was loaded at all (Case 3).

Option A (this series)
======================

Track how far VM-entry got, and use that at VM-exit to decide whether
vmcs12's guest fields are a faithful copy of what the CPU holds:

  enum nested_l2_state {
	L2_STATE_NOT_LOADED,		/* VM-entry failed before the
					   guest-state loading phase */
	L2_STATE_LOADED_FROM_VMCS12,
	L2_STATE_SAVED_TO_VMCS12,	/* L2 ran, state synced back */
  };

nested_vmx_enter_non_root_mode() sets L2_STATE_LOADED_FROM_VMCS12 right
after prepare_vmcs02() succeeds, __nested_vmx_vmexit() passes
L2_STATE_SAVED_TO_VMCS12, and nested_l2_state_is_live() folds the three
states plus the VM-entry load control into one predicate.

Pros: small, self-contained, no new state that outlives the transition
(the enum is a local + one parameter), and the per-feature cost is one
stage check in load_vmcs12_host_state().

Cons: the VM-exit path now has to look at vmcs12->vm_entry_controls,
which is odd, because that control belongs to VM-entry.

Option B (not implemented)
==========================

On a VM-exit, the host-state loading step only ever does one of two
things: load the register from the VMCS host field, or leave the register
alone. It does not care why the VM-exit happened, nor how far a failed
VM-entry got. But KVM cannot simply "leave the register alone", because
the live value sits in the guest fields of the current VMCS, so it moves
when KVM switches from vmcs02 back to vmcs01.

KVM already solves this for the L1->L2 direction, with
nested.pre_vmenter_{s_cet,ssp,ssp_tbl}: L1's live value is read from
vmcs01 before the switch, and written into vmcs02 if VM-entry does not
load CET state. The L2->L1 direction has no such variable and uses
vmcs12's guest fields instead. That is where the bug comes from.

So the other way to fix this is to keep those fields updated in both
directions. They would then hold more than the pre-VM-entry value, so
they'd want a new name as well (nested.cet_state, i.e. drop the
"pre_vmenter" prefix again :-)):

  nested_vmx_enter_non_root_mode()
	read the live state from vmcs01		/* unconditionally */
	switch to vmcs02
	guest-state checks fail  -> exit path, value is still L1's
	prepare_vmcs02() fails   -> exit path, value is still L1's
	/* guest-state loading phase */
	if (VM_ENTRY_LOAD_CET_STATE)
		value = vmcs12 guest fields
	write the value into vmcs02
	/* MSR loading phase; on failure the value is already correct */

  prepare_vmcs12()				/* real VM-exits only */
	read the live state from vmcs02 into vmcs12's guest fields
	and into the tracked value

  load_vmcs12_host_state()
	if (VM_EXIT_LOAD_CET_STATE)
		value = vmcs12 host fields
	write the value into vmcs01		/* unconditionally */

Pros: no history to reconstruct at VM-exit, no reference to the
VM-entry control from the VM-exit path, symmetric with the existing
L1->L2 handling, and it works for state that is not synced back to
vmcs12.

Cons: a wider diff (VM-entry path, prepare_vmcs02(), prepare_vmcs12(),
load_vmcs12_host_state()), and the tracked value is a "second copy" [*]
of live state, which introduces a third place where guest state lives,
next to vmcs01/vmcs02 and vmcs12, and every affected state needs its
own variable. So this is the approach that grows with the number of
features, whereas Option A's staging enum is shared by all of them.

[*]: "second copy" may be inaccurate, since several places already hold
guest state outside the VMCS: EFER and PAT are kept in vcpu->arch.*,
which survives the VMCS switch for free, while CET and BNDCFGS live only
in the VMCS and already need their own nested.pre_vmenter_* fields for
the L1->L2 direction. No single unified place is a pity indeed.

Extensibility
=============

Any feature with a VM-exit "load host state" (or "clear") control has to
answer the same question: with that control set/clear, what state to
retain for l1? So this is not only about CET:

 * EFER is correct, because vcpu->arch.efer holds L2's value and
   the vmx_set_efer() at the end of that if/else chain writes vmcs01
   unconditionally.

 * CET is broken, which is what patch 1 fixes.

 * BNDCFGS is broken: load_vmcs12_host_state() only handles
   VM_EXIT_CLEAR_BNDCFGS, so with that control clear L2's value is lost
   and L1 resumes with its own. MPX is limited to a few older CPUs.

 * PAT is broken: with VM_EXIT_LOAD_IA32_PAT clear, vmcs01.GUEST_IA32_PAT
   keeps L1's pre-VM-entry value while vcpu->arch.pat holds L2's, so L1
   resumes with its own PAT but reads L2's back with RDMSR.

 * (in future) FRED also needs to consider this.

Testing
=======

The selftest gives L1, L2 and vmcs12's host fields three different sets
of CET values, so that whichever one L1 ends up with tells us where it
came from. For each of the 4 combinations of VM_ENTRY_LOAD_CET_STATE and
VM_EXIT_LOAD_CET_STATE, it triggers both kinds of VM-entry failure and
then checks what L1 reads back:

 - EXIT_REASON_INVALID_STATE: guest CR0 with PG set and PE clear.
 - EXIT_REASON_MSR_LOAD_FAIL: a VM-entry MSR load list entry for
   MSR_IA32_UCODE_REV.

MSR_IA32_INTERRUPT_SSP_TABLE_ADDR is the primary observation point
because KVM always intercepts it and reads it straight out of
vmcs01.GUEST_INTR_SSP_TABLE. The test requires SHSTK and skips
otherwise.

Thanks and Best Regards,
Zhao
---
Zhao Liu (4):
  KVM: nVMX: Don't copy L2's CET state to L1 if VM-entry didn't load it
  KVM: selftests: Synchronize and update VMCS controls
  KVM: selftests: Synchronize and update VMCS encodings
  KVM: selftests: Test VM-entry failure handling for nested VM

 arch/x86/kvm/vmx/nested.c                     |  59 ++-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 tools/testing/selftests/kvm/include/x86/vmx.h | 489 ++++++++++--------
 .../selftests/kvm/include/x86/vmxfeatures.h   |  93 ++++
 .../x86/vmx_nested_entry_fail_state_test.c    | 311 +++++++++++
 6 files changed, 727 insertions(+), 227 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/vmxfeatures.h
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_nested_entry_fail_state_test.c

-- 
2.34.1

