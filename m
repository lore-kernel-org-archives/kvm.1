Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600540B0F7
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 21:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570339; cv=none; b=teVmPutIz1gwE4dePBxtNN597VWSQCnNIxgrr9p1tLh9BxjGbxsHbRwwrZ78o6Qps8PTEsLeiTwfGuKMEMl06kP49WtC+MEvBl3CRTqTyiXeghK79j6CkvHEDhZz+tJLOwAW/HTlRa9uwYICDeOk2GrUBrNARYfGayG9ME/CXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570339; c=relaxed/simple;
	bh=nKsdMunICyTlQv8HzoTlRcL95iVDUi7N6JmyiOY1YH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I/rQpDDkBjvZx/w33FZjk89hnO89Djhr2epmICgKlk8TSnM+UWwZWR20ZQJvRwEGjO7Dp56d4KXgffarJjL3o5sthcl7FCIq1FcUMq7qhnBnNMNAu4tbYt4kqHIRHB2iDItfwxg2WG6mgE7nnPDxG1hYnUQYEX7gtCSuPfxprXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=irE3DhiM; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irE3DhiM"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84865f326efso86787b3a.0
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570336; x=1787175136; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wH99MqhCAou4zCuAGI/K/cC6DHezwBfILMHhTHWAKKY=;
        b=irE3DhiMlluwB20iSq6O2NN1ffT2lNhBVqY8pM5OdLgVgaj0YWbAhGwXRrzswHKklv
         Bv41JdwjiDZ4UCmcMPRd2reBDrOxtN9V0A7tjmSolf++qnH2NaREf7juCui54WUH1O0T
         xaxdlZC3aPdwli0yPelFSUs5BEyP4jiivLPaqkbQJ0PFlGZU1kP+x8pqykmWsr7rNGIy
         et4UyQtKpRb9c5Jb4QfxoJqnJPDyKhwg9orWyu/x74dglrK34rMHTs1sRyvzPP6jwQ/X
         TaxOqUm/EQkfHwrzPRd8ewt4aNKZncxUIFiTrInwo1okFf+umX9UwMWtFofRV4Lhs58W
         kloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570336; x=1787175136;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wH99MqhCAou4zCuAGI/K/cC6DHezwBfILMHhTHWAKKY=;
        b=ky20hS8omwKHNR1yDaSL3fhQwNPL+n+jfRhEfnCOh7YNDwAVjzwKbpzOg2Tfrd9TCo
         paZdL+HrLhIwDrAWrsQiVT6hTZP+o6e8LrZ1x6yklK0j7rDCACr7ccQwSJgrWFRorlHS
         x6atYllpQ9/HML7d9LwcBaoulCMYSZuROcNlDssMmJHGikN+Otvg15iTGOh04oz/xtWd
         BgVZQS4PiZJeMKKY7miDv/sPpfDZfIr+gVOTRlKKl6QJPtSFnnE7NCxPlEAd0yaDtK+f
         XhB1i4/lMWH7ZnADXW/WURwiizS8uX2NZ41yuT6DaD69Q/u+4co2iNNGoiaJQaI9rlSV
         AnEw==
X-Gm-Message-State: AOJu0YysM8jandJKmYqxqknmRQSwwXG5ujT7ljh3zwCxEPKtzFkKJC+O
	vlfKa+jmt6h7WjKzhacgLPhkb2xWVTdXWI5++iP+MtM9hCihzUauMRa1nBJ0yNo+JaiHu+52tsd
	3v4bmBA==
X-Received: from pfbkr10.prod.google.com ([2002:a05:6a00:4b4a:b0:848:569f:3464])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:f06:b0:848:3dae:66e2
 with SMTP id d2e1a72fcca58-84fc7159e61mr859017b3a.26.1786570335972; Wed, 12
 Aug 2026 14:32:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Aug 2026 14:32:02 -0700
In-Reply-To: <20260812213206.1564354-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812213206.1564354-8-seanjc@google.com>
Subject: [GIT PULL] KVM: Selftests change for 7.3, part 1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

This was supposed to be the "main" selftests pull request, but it ended up being
about half the size of the second pull request.  Yosry's work on the nested
virtualization infrastructure is by far the most notable thing here.

The following changes since commit a204badd8432f93b7e862e7dac6db0fe3d65f370:

  Merge branch 'kvm-chainsaw' into HEAD (2026-06-25 11:32:09 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-7.3

for you to fetch changes up to b18ee21055a77eb1fb6070cb3f819cd3372c466e:

  KVM: selftests: Add a test for KVM_CREATE_VM VM type enforcement (2026-07-31 15:47:25 -0700)

----------------------------------------------------------------
KVM selftests changes for 7.3, part 1

 - Clean up nested SVM's handling of GPRs on L2<=>L1 transitions, reuse the
   functionality for nested VMX, and drop the ucall hack that was fudging
   around the lack of GPR switching on nVMX.

 - Add a stress test to verify KVM doesn't clobber/drop #PF state, e.g. CR2,
   across save/restore, including when L2 is active.

 - Add a test to verify KVM_CREATE_VM accepts exactly what is reported by
   KVM_CAP_VM_TYPES.

 - Misc selftests fixes and cleanups

----------------------------------------------------------------
Hemanth Selam (1):
      KVM: selftests: Add a test for KVM_CREATE_VM VM type enforcement

Sean Christopherson (2):
      KVM: selftests: Drop superfluous use of pthread_attr_setaffinity_np()
      KVM: selftests: Randomize pCPU in steal time test

Shivank Sharma (1):
      KVM: selftests: Fix typos in x86 and riscv tests

Wang Yan (1):
      KVM: selftests: Fix a spelling error in an xapic_ipi_test comment

Yosry Ahmed (13):
      KVM: selftests: Use __stringify() instead of custom XSTR() macros
      KVM: selftests: Fix RAX and RFLAGS VMCB offsets when running L2
      KVM: selftests: Rework GPR registers switching for SVM (and fix offsets)
      KVM: selftests: Handle rflags save/restore for SVM in guest_regs
      KVM: selftests: Reuse GPR switching logic for nVMX
      KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
      KVM: selftests: Add a blank line before logging assertion failures
      KVM: selftests: Expose PTE masks to guests as part of an MMU
      KVM: selftests: Do not intercept #PF by default in nVMX tests
      KVM: selftests: Add basic stress test for save+restore and #PF handling
      KVM: selftests: Trigger save+restore randomly in the #PF stress test
      KVM: selftests: Support running stress save+restore and #PF test in L2
      KVM: selftests: Trigger L2->L1 exits stress save+restore and #PF test

 tools/testing/selftests/kvm/Makefile.kvm           |   2 +
 tools/testing/selftests/kvm/include/test_util.h    |   1 +
 tools/testing/selftests/kvm/include/x86/evmcs.h    |  46 ++--
 .../testing/selftests/kvm/include/x86/processor.h  |  52 +++-
 tools/testing/selftests/kvm/include/x86/vmx.h      |  69 +++--
 tools/testing/selftests/kvm/lib/assert.c           |   2 +-
 tools/testing/selftests/kvm/lib/x86/processor.c    |  14 +
 tools/testing/selftests/kvm/lib/x86/svm.c          |  62 +++--
 tools/testing/selftests/kvm/lib/x86/ucall.c        |  32 +--
 tools/testing/selftests/kvm/lib/x86/vmx.c          |   2 +-
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c   |   4 +-
 tools/testing/selftests/kvm/steal_time.c           |  15 +-
 tools/testing/selftests/kvm/vm_types_test.c        |  48 ++++
 .../selftests/kvm/x86/evmcs_smm_controls_test.c    |   5 +-
 .../testing/selftests/kvm/x86/fix_hypercall_test.c |   1 -
 tools/testing/selftests/kvm/x86/hyperv_clock.c     |   4 +-
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c     |   2 +-
 .../kvm/x86/save_restore_pf_stress_test.c          | 288 +++++++++++++++++++++
 tools/testing/selftests/kvm/x86/sev_init2_tests.c  |   4 -
 tools/testing/selftests/kvm/x86/smm_test.c         |   5 +-
 .../kvm/x86/vmx_invalid_nested_guest_state.c       |   2 +-
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c   |   2 +-
 22 files changed, 502 insertions(+), 160 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/vm_types_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
