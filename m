Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B7393DEF
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 04:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125863; cv=none; b=Lnu6BLkE9exw7Xv76z00BvD+9maxbkLlJDvc9HTpo6K+uhMTEYqTOYsewlhPTDo4o0hBZLPn1HGa/YpH/NWik/HmV1AtA5cR3lFWbUZ9ZiFfubjh/zJhpIaqFjpclDtl0Nt6vpsImmLQrhxQNisnRQEgu4UJ+EOTY+Nj25oB4kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125863; c=relaxed/simple;
	bh=VA/CKG5TGpaH0tCblyH1AcFibPiB6QlsnsS32IvRxvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fsiDLXjSdFNATn3mjwTDQY9Mhx14RQYo0zgG3qwEY22rKOSrNdetoAICyaNZ4Xg/8gPB4YUieI8QJRlEqq8mNxRa+ekmSnEjfHndu61MrHp5fOLKMiVEhouVb2nfGFjBUpXBDkEw/lcZ+pEnRSv8jkgvQVor/GRO7/Ziz7gM4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iw2kONWi; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iw2kONWi"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e942b1cc86so23974575ad.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 21:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792125861; x=1792730661; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3zD8XpFPXJqFea7WUGGo95CCbrLBPfUfm1ny+qlhtNU=;
        b=Iw2kONWiZB4qZoD/KH3Gzyl1g5IIawzs4RTgOZIUBASjZcBGFpf2lC07aQWkycCIXi
         SPBdCDskXBOYrNiMbAT7vPhqGzFCGw7bCsxqySRTUY1OqxeN27c/m1nQsyMH+T/4Ba66
         hEdWQ9QQMSvQhUBeItHmv725V7BzHHM+tU0v/2v0u4tGutcU7vCRJCnA+fB3i7FojCEQ
         CIyZhxxfWNhQbZUtMEsIu7mLVnq/RscgkbdTtAvD9RPL5xbY1DxhWzCS4idj/G+Bn4/f
         i4BfDHThNRL2ehCtuQ9078tyf27MrYr8s1tpypkA4ebE2kLX8m3/GnYLZt2qvgx7d8Ih
         RHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125861; x=1792730661;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3zD8XpFPXJqFea7WUGGo95CCbrLBPfUfm1ny+qlhtNU=;
        b=xU0DQPmm6m7I2VWi+ecH9h9k5fBUnN5NpNdJmDQDwdW/4BQeDxQgKTAVImI8NerQGh
         /nAd50X3lskcvU9HKszSUlJmeemFrh1X+LJVGGzsSUtYa62EhscLfIVzau4YevXQoFdk
         pdrAsyauohOnzjtliiSX0j8Lvl1BUqIBpxwxBpWCAKHFiI+N2lttQy7LEZxnATUqW//Q
         C3Ih9/s7s5jFFrOMFZg8wfHfLrxcr459LBtpO42nqNqdn87MBs8K5uqrkjg8W+5TEhPO
         rnO5sEDyFmjNu86nixoUen+oxBIagMrp/FWEYzLRZP7gd0myYCbx8ML4Hz2VdSA8MO96
         lz7w==
X-Gm-Message-State: AFq9FYLb46YRzyM0X/iYSDhLmxNu7ohJwcvj6pzTpwrHsu2I/qFCQO6l
	R3YDe3NhamdtK34BJEIyQaNNlHo/xJCccG85eZm1W8BIOiOrJMZV/9jaoI6wnh3klQNzc+lwvPf
	+lOrEEg==
X-Received: from pli18.prod.google.com ([2002:a17:902:c112:b0:2e9:59de:6dc0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce07:b0:2dd:ad73:5b6c
 with SMTP id d9443c01a7336-2e8429ad1d4mr185380335ad.28.1792125860305; Thu, 15
 Oct 2026 21:44:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 15 Oct 2026 21:44:08 -0700
In-Reply-To: <20261016044415.958618-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016044415.958618-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261016044415.958618-4-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Misc changes for 7.4
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

This one really lives up to its name.  There's a lot of smallish stuff all over.
There's a minor conflict between this and the "vmx" branch, more details in the
"vmx" pull request.

The following changes since commit d4b7fb647204f0c81dfeae2d1a708e4d858e0c94:

  Merge branch 'kvm-xen-longmode' into HEAD (2026-09-04 17:35:03 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-misc-7.4

for you to fetch changes up to 88b23a2e8286b7016c3b58dc10093cf28c22aa3d:

  KVM: x86: Request event processing for exception VM-Exits (2026-10-02 07:49:40 -0700)

----------------------------------------------------------------
KVM x86 misc changes for 7.4

 - Mask off the address space ID when checking for illegal usage of
   kvm_set_internal_memslot() to prevent false negatives on the sanity check.

 - Explicitly zero reserved flags when delivering a SynIC message to avoid
   leaking a byte of stack information to the guest.

 - Rework TDX's handling of the canonical MMU root level to not rely on
   userspace to fill CPUID correctly, as doing so lets userspace trivially
   trigger a KVM_BUG_ON().

 - Reject KVM_SET_NESTED_STATE if userspace "restores" L1 with EFER.LMA=1 &&
   EFER.LME=0, which confuses KVM into trying to configure an 64-bit MMU
   without PAE.

 - Ignore EFER.LMA (clear it from KVM's cached save state) if EFER.LME=0 when
   preparing L2 state, to fix another way to confuse KVM's MMU (and because
   real hardware also ignores EFER.LMA).

 - Improve KVM's sanity checks for a misconfigured MMU to (hopefully) detect
   all of the ways KVM can botch EFER.LMA vs. CR4.PAE.

 - Remove the "full" out-param from kvm_x86_ops.flush_tlb_gva() as the param
   is only used to avoid what effectively amounts to a single memory write.

 - Fix a mostly-benign bug where KVM can write through a guest's read-only
   mapping due to not checking the error code when expediting emulated MMIO
   page faults.

 - Honor the guest's view of the "EFER.LMSLE must be zero" defeature so that
   userspace can provide migration compatibility between Rome and Milan+.

 - Pend a KVM_REQ_EVENT request when an exception is morphed into a nested
   VM-Exit, otherwise KVM can fail to actually deliver the nested VM-Exit,
   e.g. when injecting a page fault.

 - Add support for PML on SVM.

 - Add support for virtualizating Bus Lock Detect on SVM, and fix a number of
   DR6 bugs and warts along the way.

 - Misc fixes and cleanups.

----------------------------------------------------------------
Hao Xiang (1):
      KVM: x86: Rename CPUID feature bit AVX10_VNNI_INT to AVX10_V1_AUX

Jim Mattson (4):
      KVM: x86: Advertise EFER_LMSLE_MBZ when KVM disallows EFER.LMSLE
      KVM: x86: Honor the guest's EFER_LMSLE_MBZ
      KVM: selftests: Rename svm_nested_clear_efer_svme to svm_nested_efer_test
      KVM: selftests: Add coverage for the EFER_LMSLE_MBZ defeature

Karl Mehltretter (2):
      Documentation: KVM: SEV: Use the uapi structure names
      Documentation: KVM: x86: Use struct kvm_clock_pairing in hypercalls.rst

Kyle Zeng (1):
      KVM: x86: Restrict saved GPA writes to hardware write faults

Loc Nguyen (1):
      KVM: x86: Request event processing for exception VM-Exits

Luka Absandze (1):
      KVM: x86/pmu: Don't retry a counter whose config was rejected

Nikunj A Dadhania (7):
      KVM: x86: Move PML page to common vcpu arch structure
      KVM: x86: Carve out PML flush routine
      KVM: VMX: Use cpu_dirty_log_size instead of enable_pml for PML checks
      KVM: x86: Carve out common dirty logging update
      x86/cpufeatures: Add Page modification logging
      KVM: SVM: Use BIT_ULL for 64-bit misc_ctl bit definitions
      KVM: SVM: Add Page modification logging support

Paolo Bonzini (1):
      KVM: x86: remove "full" out-argument from flush_tlb_gva

Ravi Bangoria (1):
      KVM: SVM: Add support for virtualizating Bus Lock Detect

Sean Christopherson (20):
      KVM: x86: Zero reserved synic flags when delivering message to avoid stack leak
      KVM: x86: Track kvm_vcpu_arch.pending_ioapic_eoi as a u8 to drop dead BUG_ON()
      KVM: x86/mmu: Use KVM's max TDP level to determine need for 32-bit TDP root
      KVM: VMX: Explicitly track TDX VMs' root level instead of guessing it from CPUID
      KVM: VMX: Drop TDX_SHARED_BIT_PWL_{4,5} and dedup related code
      KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
      KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state
      KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has
      KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with EFER.LMA=1 && CR4.PAE=0
      KVM: x86/mmu: Convert MMU walker's bounds check from BUG_ON() to KVM_BUG_ON()
      KVM: VMX: Pass @vcpu, not @vmx to init_vmcs()
      KVM: x86: Preserve DR6.BLD (Bus Lock Detect) when delivering #DB payload
      KVM: x86: Rename kvm_dr6_fixed() => kvm_get_dr6_fixed_1()
      KVM: Return an "unsigned long", not "u64" for the fixed-1 DR6 bits
      KVM: x86: Force fixed-1 bits in DR6 after synchronizing with hardware
      KVM: x86: Set guest's fixed-1 DR6 bits when delivering #DB payload
      KVM: x86: Kill off DR6_FIXED_1 to prevent future misuse
      KVM: SVM: Add helper to query if LBR virtualization needs to be enabled
      KVM: nSVM: Open code check on LBR virtualization being enabled in vmcb12
      KVM: selftests: Add module param API to check if nested virtualization is enabled

Shivansh Dhiman (3):
      KVM: nSVM: Disable LBRV in nested control cache when unsupported
      KVM: nSVM: Don't assume all active-low bits DR6 are fixed-1
      KVM: SVM: Add a vCPU-aware helper to get supported DEBUGCTL bits

Tharit Tangkijwanichakul (2):
      KVM: x86: Reject reserved CR8 bits in KVM_SET_SREGS
      KVM: selftests: Add CR8 reserved-bit checks to set_sregs_test

Zeng Chi (1):
      KVM: Mask off the address space ID in kvm_set_internal_memslot() check

 Documentation/virt/kvm/api.rst                     |  25 ++
 .../virt/kvm/x86/amd-memory-encryption.rst         |   8 +-
 Documentation/virt/kvm/x86/hypercalls.rst          |   2 +-
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/kvm_host.h                    |  10 +-
 arch/x86/include/asm/svm.h                         |  14 +-
 arch/x86/include/uapi/asm/svm.h                    |   2 +
 arch/x86/kernel/cpu/scattered.c                    |   1 +
 arch/x86/kvm/cpuid.c                               |  36 +--
 arch/x86/kvm/cpuid.h                               |   1 -
 arch/x86/kvm/hyperv.c                              |   9 +-
 arch/x86/kvm/kvm_emulate.h                         |   4 +-
 arch/x86/kvm/lapic.c                               |   4 +-
 arch/x86/kvm/lapic.h                               |   2 +-
 arch/x86/kvm/mmu/mmu.c                             |  29 ++-
 arch/x86/kvm/mmu/paging_tmpl.h                     |  17 +-
 arch/x86/kvm/msrs.c                                |  12 +-
 arch/x86/kvm/pmu.c                                 |  14 +-
 arch/x86/kvm/regs.c                                |  16 +-
 arch/x86/kvm/regs.h                                |  11 +-
 arch/x86/kvm/reverse_cpuid.h                       |   2 +-
 arch/x86/kvm/svm/nested.c                          |  46 ++--
 arch/x86/kvm/svm/sev.c                             |   7 +-
 arch/x86/kvm/svm/svm.c                             | 162 ++++++++++++-
 arch/x86/kvm/svm/svm.h                             |  13 +-
 arch/x86/kvm/vmx/main.c                            |   8 +-
 arch/x86/kvm/vmx/tdx.c                             |  21 +-
 arch/x86/kvm/vmx/vmx.c                             |  94 +++-----
 arch/x86/kvm/vmx/vmx.h                             |   9 +-
 arch/x86/kvm/vmx/x86_ops.h                         |   4 +-
 arch/x86/kvm/x86.c                                 | 130 +++++++---
 arch/x86/kvm/x86.h                                 |  10 +
 tools/testing/selftests/kvm/Makefile.kvm           |   2 +-
 .../testing/selftests/kvm/include/x86/processor.h  |  14 ++
 tools/testing/selftests/kvm/x86/set_sregs_test.c   |  11 +
 .../selftests/kvm/x86/svm_nested_clear_efer_svme.c |  50 ----
 .../selftests/kvm/x86/svm_nested_efer_test.c       | 266 +++++++++++++++++++++
 virt/kvm/kvm_main.c                                |   2 +-
 38 files changed, 803 insertions(+), 266 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
