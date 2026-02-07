Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC433E377
	for <kvm@vger.kernel.org>; Sat,  7 Feb 2026 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770437429; cv=none; b=NHxkkVwqoOFRW991qqQ1f03gCrYrp9oQDC1qbXVegQGYIjj6ExCOQP36ZgCb8efcKfJEbFcWRIQVAEKVmrFBCzVph3qG4OwCmtmSSkofwdVBr0fxojd1xrcLXjCGLDmywooe2UOHNg+1hnsQgvSQjOF2ogjzFSwMaeCMVdH5/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770437429; c=relaxed/simple;
	bh=8C78vSWrrTTxUucaZ/p+T4Xnh6GRDji4DEbtewqjixk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oBOsMc2XdyvGijtAHttJqOtVY9RCeOH2yHn4b0Mnp0cf8TNKFFItIphYHpHbJIAEU3m5ZdYBfs/U8WmY5SwroQcZjqc2hUTbzAmRyzWybRHiPElV3d2jQ5DpVChH8n+OZmbEOoCZVQOtYLPZY8mnfmdMAN+ELiYiWyXyUSN3/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4N2WxMtL; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4N2WxMtL"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c68b97c0adeso1740053a12.1
        for <kvm@vger.kernel.org>; Fri, 06 Feb 2026 20:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770437426; x=1771042226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GGv6OerfzlBag79bK/fq6RxdqQlhEouk9cUTuAMP8lA=;
        b=4N2WxMtLjS4d71hQDVnte/zPNeI4Oq9DT8RoOjbgrZZWQyBGtmtz2b+X7cB0bupQGB
         U8ip6B2RkLS0xkarHEoDc2fpJ0felOu1RKqiQnnnb2AWrfyFOg1MsNjqbG7ajl9GPhVc
         6GT16b8eSC9KBkjeQInCLyj3fmi4AUyXTWzAlNlynNOjmA9JWU38QE2Argh5OBgGcxgH
         Sr4FwKV/jQtRxX+zE4B5M8VxxrzKHIv9qsAS3DhtauQGqniXoL3SXNDNroyHKfO2ITtS
         EHyhB7vqERaJDqKJrn6IPrx3zUaFI6/gBymy4bj2TRzjSR+MiwI+8nISY9BVCWA+h1CP
         EdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770437426; x=1771042226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGv6OerfzlBag79bK/fq6RxdqQlhEouk9cUTuAMP8lA=;
        b=XtRotEhHBVp7cv4KC6me/wHfoon7gWQRKSINi3W7xYO5HokvTBqb/QjR7Tbuiiw6OT
         vuoGZ3m4Y9rywatyo2Vi/fxA2YkaKQ/nm/XzIs0WZ4D40AGi+U7Hwk7GDhNPwQX5Ev+r
         1K2GxRRaZ89KLdejy8NFBtoBC920bw3w4B0mD7lnLi3ZTE86laReTd4SpkFiv3Cq9JiD
         FnXGhqISXdWSsq+G7ZdYnGCTy046QDvD1psa1e0jbtTvKvDJ/STJq5JzIMxjjUmW8pAO
         isap6vD/to0buoG+h499A6QsTrP14tep7VbeDA60EGQljxsOxaTvRvJDr/c3k14G0eAc
         JimA==
X-Gm-Message-State: AOJu0Yz5AEd+bRmOwNqGIhKPW543bp6quzknVQz8kEYKog7WEzgIWmPV
	vjHcPjFIw8Bm9QPdvku3CUkL8j0jusHb0G/ZOw9hVwsvC8af2uuJAx44QdiJXgq9cro4J9aKTY1
	Hs4v16Q==
X-Received: from pjbds12.prod.google.com ([2002:a17:90b:8cc:b0:354:c5cd:9f73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d23:b0:38e:9294:b182
 with SMTP id adf61e73a8af0-393ada2c47dmr4969311637.26.1770437426430; Fri, 06
 Feb 2026 20:10:26 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  6 Feb 2026 20:10:09 -0800
In-Reply-To: <20260207041011.913471-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207041011.913471-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207041011.913471-8-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: SVM changes for 6.20
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Complete the "u64 exit_code" cleanup, start fixing nSVM issues (a lot more of
those will be coming in the near future), virtualize EPAPS, and support for
fetching SNP certificates.

The following changes since commit 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb:

  Linux 6.19-rc4 (2026-01-04 14:41:55 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-svm-6.20

for you to fetch changes up to 20c3c4108d58f87c711bf44cb0b498b3ac5af6bf:

  KVM: SEV: Add KVM_SEV_SNP_ENABLE_REQ_CERTS command (2026-01-23 09:14:16 -0800)

----------------------------------------------------------------
KVM SVM changes for 6.20

 - Drop a user-triggerable WARN on nested_svm_load_cr3() failure.

 - Add support for virtualizing ERAPS.  Note, correct virtualization of ERAPS
   relies on an upcoming, publicly announced change in the APM to reduce the
   set of conditions where hardware (i.e. KVM) *must* flush the RAP.

 - Ignore nSVM intercepts for instructions that are not supported according to
   L1's virtual CPU model.

 - Add support for expedited writes to the fast MMIO bus, a la VMX's fastpath
   for EPT Misconfig.

 - Don't set GIF when clearing EFER.SVME, as GIF exists independently of SVM,
   and allow userspace to restore nested state with GIF=0.

 - Treat exit_code as an unsigned 64-bit value through all of KVM.

 - Add support for fetching SNP certificates from userspace.

 - Fix a bug where KVM would use vmcb02 instead of vmcb01 when emulating VMLOAD
   or VMSAVE on behalf of L2.

 - Misc fixes and cleanups.

----------------------------------------------------------------
Amit Shah (1):
      KVM: SVM: Virtualize and advertise support for ERAPS

Jim Mattson (2):
      KVM: SVM: Don't set GIF when clearing EFER.SVME
      KVM: SVM: Allow KVM_SET_NESTED_STATE to clear GIF when SVME==0

Kevin Cheng (1):
      KVM: SVM: Don't allow L1 intercepts for instructions not advertised

Michael Roth (2):
      KVM: Introduce KVM_EXIT_SNP_REQ_CERTS for SNP certificate-fetching
      KVM: SEV: Add KVM_SEV_SNP_ENABLE_REQ_CERTS command

Sean Christopherson (14):
      KVM: nSVM: Remove a user-triggerable WARN on nested_svm_load_cr3() succeeding
      KVM: SVM: Rename "fault_address" to "gpa" in npf_interception()
      KVM: SVM: Add support for expedited writes to the fast MMIO bus
      KVM: SVM: Drop the module param to control SEV-ES DebugSwap
      KVM: SVM: Tag sev_supported_vmsa_features as read-only after init
      KVM: SVM: Add a helper to detect VMRUN failures
      KVM: SVM: Open code handling of unexpected exits in svm_invoke_exit_handler()
      KVM: SVM: Check for an unexpected VM-Exit after RETPOLINE "fast" handling
      KVM: SVM: Filter out 64-bit exit codes when invoking exit handlers on bare metal
      KVM: SVM: Treat exit_code as an unsigned 64-bit value through all of KVM
      KVM: SVM: Limit incorrect check on SVM_EXIT_ERR to running as a VM
      KVM: SVM: Harden exit_code against being used in Spectre-like attacks
      KVM: SVM: Assert that Hyper-V's HV_SVM_EXITCODE_ENL == SVM_EXIT_SW
      KVM: SVM: Fix an off-by-one typo in the comment for enabling AVIC by default

Yosry Ahmed (5):
      KVM: selftests: Use TEST_ASSERT_EQ() in test_vmx_nested_state()
      KVM: selftests: Extend vmx_set_nested_state_test to cover SVM
      KVM: nSVM: Drop redundant/wrong comment in nested_vmcb02_prepare_save()
      KVM: nSVM: Always use vmcb01 in VMLOAD/VMSAVE emulation
      KVM: SVM: Stop toggling virtual VMSAVE/VMLOAD on intercept recalc

 Documentation/virt/kvm/api.rst                     |  44 +++++++
 .../virt/kvm/x86/amd-memory-encryption.rst         |  52 ++++++++-
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/kvm_host.h                    |   8 ++
 arch/x86/include/asm/svm.h                         |   9 +-
 arch/x86/include/uapi/asm/kvm.h                    |   2 +
 arch/x86/include/uapi/asm/svm.h                    |  32 ++---
 arch/x86/kvm/cpuid.c                               |   9 +-
 arch/x86/kvm/svm/avic.c                            |   4 +-
 arch/x86/kvm/svm/hyperv.c                          |   7 +-
 arch/x86/kvm/svm/nested.c                          |  82 ++++++++-----
 arch/x86/kvm/svm/sev.c                             | 129 ++++++++++++++-------
 arch/x86/kvm/svm/svm.c                             | 121 ++++++++++++++-----
 arch/x86/kvm/svm/svm.h                             |  49 ++++++--
 arch/x86/kvm/trace.h                               |   6 +-
 arch/x86/kvm/x86.c                                 |  12 ++
 include/hyperv/hvgdk.h                             |   2 +-
 include/uapi/linux/kvm.h                           |   9 ++
 tools/testing/selftests/kvm/Makefile.kvm           |   2 +-
 tools/testing/selftests/kvm/include/x86/svm.h      |   3 +-
 ...nested_state_test.c => nested_set_state_test.c} | 128 +++++++++++++++++---
 .../kvm/x86/svm_nested_soft_inject_test.c          |   4 +-
 22 files changed, 559 insertions(+), 156 deletions(-)
 rename tools/testing/selftests/kvm/x86/{vmx_set_nested_state_test.c => nested_set_state_test.c} (70%)
