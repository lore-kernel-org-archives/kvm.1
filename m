Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B5237B022
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787562; cv=none; b=e/9CCG185f4SBwzF2v1JJTysQ/rwivIkImWhW9I9KOLFw4svBOsOXgSdd8iMzLzgQzE5v3sqiicfFvMf5sMTE49tx7QxXy7I+wEXHuVFwpBmqLjJ4llfscJBMSyZFk2rQH6x0LXDLr2bBIUg1KbUOKUF2e335LKyhnChdGshWJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787562; c=relaxed/simple;
	bh=ltnk6ZEe6UBI+OuxfAsKht6KJZGAQfW6WOiKhx0pKlc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BT2tsgQ7C9cQuz8k7MuV2pq2TYMO9/DvGz33WEE9FRBkw5Y7s0DepMcJnnHAiLvOwAVDNyaKgAcSw7YVVtXiEk+qkW9TamNtRZAIbgi4/SillibIFOa++H/4cMsifIKlTipMFpP+xIlgVf7ryueAJnw7Xv1vEUOVbw0EQmu1lXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrpuwiUf; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrpuwiUf"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d55d8cd938so6099945ad.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787787561; x=1788392361; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1gny5c0JRJP6S8e9mlpbqEEJSGDZQAlsB6AnRfyperE=;
        b=OrpuwiUfn63xiS/+IPAWxhjmil4CpKlMPIHYyaBBMeFRy3i9eGt5CQweChsU1lPvDq
         VGxW8ZyoIjjwl/DWNvHh1rebEVVgBBc6eGrFIaMjT3YlONpNwGvAP8JUdok5KvQtzCtJ
         iYJetgSF2cW1W56ky6OJoMwZh51vMtU0G8ONpvBhOQhudI393PtWU3JzbdRPpWfU6a+2
         s1If4Dyz/WC+TXXbWhxx6dwTBwQSffnm8cC/9FRE9CYhJZeYL7gvuzJa8LAPPf3dFOox
         XXJSchmg20Qjew2qFbYzSOM2jral8wYNC3PuRSN1EnEfmJfRIDwu+fYKHoXyt71TAI4g
         F0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787787561; x=1788392361;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1gny5c0JRJP6S8e9mlpbqEEJSGDZQAlsB6AnRfyperE=;
        b=DA7/LK1R5e0w1+zNEj1l5ZroHsnJ1fdTt8YF3Ig6uc8RgMPjNoNSE2Bp15x1cY8+qR
         PaitAJsZ+fTsD2PcyQSPQIz3bsd2AAVTblk0DVqCT/Yjj7nRJ1KsAwKI1r91vomxRHYW
         E1oUZjjD9dmaZFo09gH7slwGPqyee5RUy7jz/9CVcXy+qSV4S6R6Iuq0g9j3xqX3lHwc
         RajiqiFjan2mew3BnWw0Mg4F+mIheo78ZuW/cwoiuUtEJT9RnHLMaKQlMJ/44PSNZDxh
         eJKkyYZr3/3VhQCTab/53EvUf2b2Whvo9eJCIqE67DJKRSasdBK+G6U27I43dY+sN9Og
         LQ4A==
X-Gm-Message-State: AFuF++mIwh53BQyN7T41zQPGyPYt7ITHz2svmFC/C+bKKd4f78caBdQY
	KmHGflWamGUaLbzG5utGx9HQlsPFaXyu3uy1dbl5N2eoOG5OFXcrK920tRJrWWGw4skH7aCJhji
	Kia2opA==
X-Received: from plpe14.prod.google.com ([2002:a17:903:3c2e:b0:2ca:d0f4:2f91])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a45:b0:2cc:d6de:d597
 with SMTP id d9443c01a7336-2d707a9fecbmr190994405ad.7.1787787560405; Wed, 26
 Aug 2026 16:39:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:39:06 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826233919.998904-1-seanjc@google.com>
Subject: [PATCH v3 00/13] KVM: nVMX: Adjust VMPTRLD/VMPTRST behavior with
 active eVMCS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Vitaly's series to adjust KVM's emulation of VMPTRLD/VMPTRST when the vCPU
has an active eVMCS to match Hyper-V, and more importantly to not put the
vCPU into an infinite loop.

The patches from Vitaly remain the same from v2.  The churn I piled on top
came from wanting to use KVM_ASM_SAFE() for more VMX instructions to verify
the RFLAGS bug+fix Sashiko pointed out, and I lack impulse control when it
comes to cleanups.

v3:
 - See above.

v2:
 - https://lore.kernel.org/all/20260818165258.2613603-1-vkuznets@redhat.com
 - Fix build when !CONFIG_KVM_HYPERV [Sashiko]
 - Drop now-unneeded evmcs_vmptrst() [Sashiko]
 - Avoid hardcoding VMPTRLD insn length in hyperv_evmcs [Sashiko], use
   KVM_ASM_SAFE framework instead [Sean]

v1: https://lore.kernel.org/all/20260814162221.2144473-1-vkuznets@redhat.com

Sean Christopherson (9):
  KVM: selftests: Don't clobber RFLAGS in happy path of __KVM_ASM_SAFE()
  KVM: selftests: Assert success in vmptrst(), kill off vmptrstz()
  KVM: selftests: Always assert that vmxon() and
    prepare_for_vmx_operation() succeed
  KVM: selftests: Always assert that vmclear() succeeds
  KVM: selftests: Always assert that vmptrld() succeeds
  KVM: selftests: Drop useless return code from load_vmcs()
  KVM: selftests: Add macros to handle simple VMX instructions
  KVM: selftests: Dedup assembly code for VMLAUNCH and VMRESUME
  KVM: selftests: Add and use double-underscore versions of vmlaunch()
    and vmresume()

Vitaly Kuznetsov (4):
  KVM: nVMX: Make VMPTRLD result in #UD when eVMCS is used
  KVM: nVMX: Make VMPTRST return eVMCS GPA when it is used
  KVM: selftests: Adapt to the updated VMPTRST behavior when eVMCS is
    used
  KVM: selftests: Check VMPTRLD with active eVMCS

 arch/x86/kvm/vmx/nested.c                     |  24 ++-
 .../testing/selftests/kvm/include/x86/evmcs.h |   8 -
 .../selftests/kvm/include/x86/processor.h     |   2 +-
 tools/testing/selftests/kvm/include/x86/vmx.h | 173 +++++++-----------
 .../testing/selftests/kvm/lib/x86/memstress.c |   6 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c     |  20 +-
 .../selftests/kvm/x86/aperfmperf_test.c       |   6 +-
 .../kvm/x86/evmcs_smm_controls_test.c         |   4 +-
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  |  57 +++---
 .../selftests/kvm/x86/kvm_buslock_test.c      |   6 +-
 .../selftests/kvm/x86/nested_close_kvm_test.c |   6 +-
 .../selftests/kvm/x86/nested_dirty_log_test.c |   6 +-
 .../selftests/kvm/x86/nested_emulation_test.c |   6 +-
 .../kvm/x86/nested_exceptions_test.c          |   6 +-
 .../kvm/x86/nested_invalid_cr3_test.c         |   8 +-
 .../selftests/kvm/x86/nested_tdp_fault_test.c |   6 +-
 .../kvm/x86/nested_tsc_adjust_test.c          |   6 +-
 .../kvm/x86/nested_tsc_scaling_test.c         |   6 +-
 .../kvm/x86/save_restore_pf_stress_test.c     |   8 +-
 tools/testing/selftests/kvm/x86/smm_test.c    |   4 +-
 tools/testing/selftests/kvm/x86/state_test.c  |  42 ++---
 .../kvm/x86/triple_fault_event_test.c         |   6 +-
 .../selftests/kvm/x86/vmx_apic_access_test.c  |   8 +-
 .../kvm/x86/vmx_apicv_updates_test.c          |   8 +-
 .../kvm/x86/vmx_invalid_nested_guest_state.c  |   6 +-
 .../kvm/x86/vmx_nested_la57_state_test.c      |   6 +-
 .../kvm/x86/vmx_preemption_timer_test.c       |  10 +-
 27 files changed, 214 insertions(+), 240 deletions(-)


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.887.g758fc8c411-goog

