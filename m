Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04887233947
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481469; cv=none; b=MAN58YQJATOIu+RfYPCPVpXHam2feYQCTBKTXmMENLwsK869feRM4XCtinpXArVMRIvya15yKO2+fgiAEYeBHjSkLjsQBqfYHyBdnFiw4x0u2+eRklz7sZ3MLsE9zJx36jDNrJUyJy1XHSLpnv7UYojCp479xSfbLeWFZphGxAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481469; c=relaxed/simple;
	bh=3UJVSOf/zQ3R/LCUqgu+uWYIoEske7jiFPTRPaDEp3Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iupipB8kEoK2XQu792jRQbV2KUEFEFz/68B3R+W98X/d3lPKOMqPPArsUPnfxGpNtVS8T6B/HE4D3dYK7cvdJR9MLhV3Ep6LwuqSPAlC2s9HY2RtxQpzNPSViRP4TviG41x1ZHgjZGdbAyhG9v7cbe/HDiFgoK6SjNNjj2uckRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XnoXuxjz; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnoXuxjz"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfc52ddc55so6353355ad.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481466; x=1789086266; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uAgyR6SHHf2VtxP6jZ6gU1Ff60o4GfZbL3l/u+NRPJg=;
        b=XnoXuxjzYWvxAagX4Eu9R+Sl21sOxZ1VkF55FjHXcAysv8DhVLNKEZt95k2ic1KM2T
         LllCVRXqucxh6y2zU8VY4WY3zko98/iO/CyxqUZnLZiYXxDflfTLGKDKU/J4E3nHol4l
         SoPESMsjDY47mRqOhB8cumeaZfyuY/qRcKDaYw5xeaa4yxA7Br5+Qcuo77qGL75kWiU2
         E3PWN4ghiSqUl9ZJg654tX0mP12yt0fsJjqon2PM1YBaCAKQJthTcJPtuwC7O9ziNRlS
         iK3d3EMCSdjOAPjjEBI/jU1PRbzJJBdvnN+wJmdbtEy7lRmJcYlTxrrDOn+o3zzoGj6s
         Qyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481466; x=1789086266;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uAgyR6SHHf2VtxP6jZ6gU1Ff60o4GfZbL3l/u+NRPJg=;
        b=C7HWJw6yDW1nPYeWbvA5O7kfCKAtJsqB1tA2KRiiyeBKYep9qq6/4GcOki7jIb8vts
         c02+4m9FbWQyU/VCJtmZB9ZLeOc9V2y6SshkTRwVuTvh10qwXp2KQXIL7H802E2pBUDh
         uyajQ+17z18EkdhtWKJEg8eTa8x6mvd7yBUKBYQPaebxgM487Q0Ram99o6YU4aILCdac
         7NWL4YMhspV0HJxHTi1hcbODdt0hUP39M2CXdezBRvP0ip+bqI4lsGLY+UdKoFMwMP96
         +CCfJZ0U0U5cohbPR45YB6J21rSSPQOrtGtXXcTItldvZwd+QpdX503F0IR75iUVV1oP
         np+A==
X-Gm-Message-State: AFuF++kT+65WtNc5rBPbCh4bNDdOiCZ9+ENljQhFWLL8Z//Idv/T8DLf
	AzNZ5DBdDQIGnrCdlGHcLZIq4HxUqWRPZ58enWjKHDoQMXPUX5SW7c/uE2xg5TXOAREdLN9CZDX
	MO8cjlQ==
X-Received: from plll17.prod.google.com ([2002:a17:902:d051:b0:2d0:f9b3:3acb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c8:b0:2d9:69c9:2815
 with SMTP id d9443c01a7336-2db12588b02mr36267515ad.7.1788481466032; Thu, 03
 Sep 2026 17:24:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:06 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-1-seanjc@google.com>
Subject: [PATCH v4 00/17] KVM: nVMX: Adjust VMPTRLD/VMPTRST behavior with
 active eVMCS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The first four patches are Vitaly's series to adjust KVM's emulation of
VMPTRLD/VMPTRST when the vCPU has an active eVMCS to match Hyper-V, and more
importantly to not put the vCPU into an infinite loop.

The churn piled on top came from wanting to use KVM_ASM_SAFE() for more VMX
instructions to verify the RFLAGS bug+fix Sashiko pointed out, lack impulse
control when it comes to cleanups, and Yosry being a bad/good influence.

v4:
 - Redo the VMLAUNCH/VMRESUME handling, dedup eVMCS as well. [Yosry]
 - Give vmread() and vmwrite() the same treatment. [Yosry]
 - Drop pointless returns from eVMCS setup.

v3:
 - https://lore.kernel.org/all/20260826233919.998904-1-seanjc@google.com
 - MOAR PATCHES.

v2:
 - https://lore.kernel.org/all/20260818165258.2613603-1-vkuznets@redhat.com
 - Fix build when !CONFIG_KVM_HYPERV [Sashiko]
 - Drop now-unneeded evmcs_vmptrst() [Sashiko]
 - Avoid hardcoding VMPTRLD insn length in hyperv_evmcs [Sashiko], use
   KVM_ASM_SAFE framework instead [Sean]

v1: https://lore.kernel.org/all/20260814162221.2144473-1-vkuznets@redhat.com

Sean Christopherson (13):
  KVM: selftests: Don't clobber RFLAGS in happy path of __KVM_ASM_SAFE()
  KVM: selftests: Assert success in vmptrst(), kill off vmptrstz()
  KVM: selftests: Always assert that vmxon() and
    prepare_for_vmx_operation() succeed
  KVM: selftests: Always assert that vmclear() succeeds
  KVM: selftests: Always assert that vmptrld() succeeds
  KVM: selftests: Drop useless return code from load_vmcs()
  KVM: selftests: Add macros to handle simple VMX instructions
  KVM: selftests: Drop dead return code from evmcs_vmptrld() and
    load_evmcs()
  KVM: selftests: Dedup assembly code for VMLAUNCH and VMRESUME
  KVM: selftests: Assert success in vmlaunch() and vmresume()
  KVM: selftests: Add __vmwrite() and use it when initializing optional
    fields.
  KVM: selftests: Always assert that vmwrite() succeeds
  KVM: selftests: Always assert that vmreadz() succeeds

Vitaly Kuznetsov (4):
  KVM: nVMX: Make VMPTRLD result in #UD when eVMCS is used
  KVM: nVMX: Make VMPTRST return eVMCS GPA when it is used
  KVM: selftests: Adapt to the updated VMPTRST behavior when eVMCS is
    used
  KVM: selftests: Check VMPTRLD with active eVMCS

 arch/x86/kvm/vmx/nested.c                     |  24 ++-
 .../testing/selftests/kvm/include/x86/evmcs.h |  78 +--------
 .../selftests/kvm/include/x86/processor.h     |   2 +-
 tools/testing/selftests/kvm/include/x86/vmx.h | 165 ++++++------------
 .../testing/selftests/kvm/lib/x86/memstress.c |   8 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c     | 143 ++++++++++-----
 .../selftests/kvm/x86/aperfmperf_test.c       |  10 +-
 .../kvm/x86/evmcs_smm_controls_test.c         |   6 +-
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  |  83 +++++----
 .../selftests/kvm/x86/kvm_buslock_test.c      |   8 +-
 .../selftests/kvm/x86/nested_close_kvm_test.c |   6 +-
 .../selftests/kvm/x86/nested_dirty_log_test.c |   8 +-
 .../selftests/kvm/x86/nested_emulation_test.c |  23 +--
 .../kvm/x86/nested_exceptions_test.c          |  29 +--
 .../kvm/x86/nested_invalid_cr3_test.c         |  14 +-
 .../selftests/kvm/x86/nested_tdp_fault_test.c |  16 +-
 .../kvm/x86/nested_tsc_adjust_test.c          |  10 +-
 .../kvm/x86/nested_tsc_scaling_test.c         |  12 +-
 .../kvm/x86/save_restore_pf_stress_test.c     |  14 +-
 tools/testing/selftests/kvm/x86/smm_test.c    |   4 +-
 tools/testing/selftests/kvm/x86/state_test.c  |  70 ++++----
 .../kvm/x86/triple_fault_event_test.c         |   8 +-
 .../selftests/kvm/x86/vmx_apic_access_test.c  |  20 +--
 .../kvm/x86/vmx_apicv_updates_test.c          |  16 +-
 .../kvm/x86/vmx_invalid_nested_guest_state.c  |  12 +-
 .../kvm/x86/vmx_nested_la57_state_test.c      |  10 +-
 .../kvm/x86/vmx_preemption_timer_test.c       |  24 ++-
 27 files changed, 387 insertions(+), 436 deletions(-)


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.979.g7e5102b832-goog

