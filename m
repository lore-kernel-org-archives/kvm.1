Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908A397E73;
	Mon, 29 Jun 2026 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758281; cv=none; b=RHxtm9BGHe7LlTWXVnrfz+jJl5jCIWGT3NdknE1cGSyX8C4vx9cMe3EpOtxbkveMXewVBnhlw+CRITJK6k+TQOKycbBud77siWuEJESULQMjXe7rec7gGe5KNZEqmDTCovWKmxgUx3wP5S8wfssPzZ+GRkwAkr+jnytAQsG28iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758281; c=relaxed/simple;
	bh=3AKK36BaWkeorLzWOpN5Tvibn3HevnVbwavTna18koY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1clHMokxoyRzWM930tlhY6KF5J7Dlg1HGRUWoQda9KgM3qV8clbX1jduPxjbM39+R+5UgDtG3jy5P0eqBEXEtbDrZ0+LC4yWbkHxqD4hbf19vfsaFz4n9f8oPk5uKm6Ru63VsKVwa5O0gm5tKznxxQ03t7PJBZQbphwwzzTfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZ6l55K5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ6l55K5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421371F000E9;
	Mon, 29 Jun 2026 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782758279;
	bh=64OyJFZjyxk17y8fQvtUvOfVXfFmYipSgoTrYIU7HjY=;
	h=From:To:Cc:Subject:Date;
	b=HZ6l55K5LBmii7Ks32O0LyuDAv2g/M9lpzsDeqgLeqAUufB32BJDpLHGgZjsPXO5V
	 7lge2qCKV3hJO0ga8yVKvCr5gWHDPYeEamfxbwTrW2Kp+CAZ7PcBFFcL2LMzUvK68G
	 bPmIF9fb9pZeoBDO6miUlHxmNK677lvjwZEYxMkq9A52FM8wnK1EIw8622OaWkRXr9
	 8o7IxIv0nV9oM7s/mI2KiVQQ5SsLinKFhumlRkz6WP3/Y8zpHgvSqxAcbBIGIUKGAQ
	 gCSl+x6T+ZpY3bOiPEr2tB+oQPvDGOtfBTaufveOOQlLz4kaMrA8p2W0XBc1hmqJFL
	 0J44vcu4NtkXg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 00/10] KVM: selftests: Stress save+restore and #PF (ft. nested)
Date: Mon, 29 Jun 2026 18:37:35 +0000
Message-ID: <20260629183746.699840-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
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
 .../testing/selftests/kvm/include/x86/evmcs.h |  40 +--
 .../selftests/kvm/include/x86/processor.h     |  55 ++-
 tools/testing/selftests/kvm/include/x86/vmx.h |  63 ++--
 .../testing/selftests/kvm/lib/x86/processor.c |   2 +
 tools/testing/selftests/kvm/lib/x86/svm.c     |  60 ++--
 tools/testing/selftests/kvm/lib/x86/ucall.c   |  32 +-
 .../kvm/x86/evmcs_smm_controls_test.c         |   3 -
 tools/testing/selftests/kvm/x86/smm_test.c    |   3 -
 .../kvm/x86/stress_save_restore_pf_test.c     | 326 ++++++++++++++++++
 11 files changed, 441 insertions(+), 147 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c


base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
-- 
2.55.0.rc0.799.gd6f94ed593-goog

