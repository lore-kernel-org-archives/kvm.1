Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D983C13E7;
	Thu,  4 Jun 2026 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605361; cv=none; b=F+ITUGOfqHzYe3CPPMYwRe9l2zxVrD1HuAC0svXxdeYq45zHSbshxizCmZ4k1nC/az6O4Ypqg/iSUK/3yydKK9SwKbfqJ5IQI5/JGFEk6ooqpsJ0+wvHwFH/ezlu+uIb9Pfrlrl1DPk1jL3AebUrtiyeoEv2JsmP4UgGwsTbRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605361; c=relaxed/simple;
	bh=bb7uXVgF99YCfYIp6Oc01bLAl+54GARn1JqlpwHwqBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FsPSDZA2Esvn3WM5IKAJu86UDAzvsBiNg4lS+HI0BAHsW3k2pSA8QrOL4Uv1Ft1iaVlER5I3MFTbNIs4op8Xlo44I8v0OUDV1CiJ8ygWdgXRmDod+NQS6W9tZHmGTz77OBLG5ABB7BcaYRVr9Z2JZZf77iKUlUm+HImGO1hHSnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1qi+xit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1qi+xit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC82B1F00893;
	Thu,  4 Jun 2026 20:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605359;
	bh=scZOl5vgdZbQOajz2C/Zjlq3Bej0uujX7Ph67xmO1U4=;
	h=From:To:Cc:Subject:Date;
	b=U1qi+xithSwLRc6TuTQ+urQNs2Nss0oIWUnUOiuTguOAyGR8aU8/CLsAu9LuQZCh+
	 +FyCdoXXN3YImeT/fyBUWr4znouc/eTWKsIqFX8DzUZDyNaoqxkJvqTvJA3hQPnATk
	 lOhFpQyHpr4nALpVK58ftx1/paIv0eAt4EWDuqXsS4nCjzPU+35I2NY9Yl9kqXcKyX
	 fVIkgIc39GVxbdXIvCvL/4IlnXOgcNg1Po/X2eQxg5UUO+Dttp8jFY2yN8oZiH3VB7
	 TD4UG2Ez3Si/bV82M9QWU7IHZIp22vXo2RkgjIe2ck7mLbyi1KTxWYwiFgtJgRYzf9
	 B0kXFHENMGc4g==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 00/10] KVM: selftests: Stress save+restore and #PF (ft. nested)
Date: Thu,  4 Jun 2026 20:35:36 +0000
Message-ID: <20260604203546.365658-1-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
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

Patches (1-6) are prep patches, fixing GPR switching for nSVM and
generalizing it to cover nVMX, which is needed for the test to run
properly with nVMX. Patch 4 removes HORRIFIC_L2_UCALL_CLOBBER_HACK, as
it is no longer needed. While this series does not have the "complete"
fix added by commit 6783ca4105a7 ("KVM: selftests: Add a shameful hack
to preserve/clobber GPRs across ucall"), it's a good step in the right
direction.

Patches (7-10) add the actual test. The test is first introduced as a
simple (read: dummy) stress test that just explicitly syncs to userspace
after each #PF handling to do save+restore, then gradually evolves to
add the random signaling and nested support. After the last patch, the
test reliably reproduces the CR2 bug.

This series conflicts with reworking L2 stack allocation in [1], but the
conflict should be trivial to fix regardless of which series lands
first.

[1]https://lore.kernel.org/kvm/20260527234711.4175166-17-yosry@kernel.org/

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


Yosry Ahmed (10):
  KVM: selftests: Move STR() and XSTR() definitions to test_util.h
  KVM: selftests: Fix RAX and RFLAGS VMCB offsets when running L2
  KVM: selftests: Use an array for guest_regs (and fix offsets)
  KVM: selftests: Move GPR load/save definitions outside of nSVM code
  KVM: selftests: Reuse GPR switching logic for nVMX
  KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
  KVM: selftests: Add basic stress test for save+restore and #PF
    handling
  KVM: selftests: Trigger save+restore randomly in the #PF stress test
  KVM: selftests: Support running stress save+restore and #PF test in L2
  KVM: selftests: Trigger L2->L1 exits stress save+restore and #PF test

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/test_util.h |   3 +
 .../selftests/kvm/include/x86/processor.h     |  55 ++-
 tools/testing/selftests/kvm/include/x86/vmx.h |  63 ++--
 .../testing/selftests/kvm/lib/x86/processor.c |   2 +
 tools/testing/selftests/kvm/lib/x86/svm.c     |  58 +--
 tools/testing/selftests/kvm/lib/x86/ucall.c   |  32 +-
 .../kvm/x86/evmcs_smm_controls_test.c         |   3 -
 tools/testing/selftests/kvm/x86/smm_test.c    |   3 -
 .../kvm/x86/stress_save_restore_pf_test.c     | 333 ++++++++++++++++++
 10 files changed, 435 insertions(+), 118 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c


base-commit: d4bfaa66fa171089b9b9fb2dc17af9245f2b9b34
-- 
2.54.0.1032.g2f8565e1d1-goog

