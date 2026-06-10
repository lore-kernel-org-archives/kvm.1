Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5338C28DC4
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781051434; cv=none; b=lG+cPy5t8ssczqmgvG5N2eTNPreH0cpcGSFNVEbMXVz/31Fgw1oEQLt0wVe8pOG67rr+CLo5zL/z2Sh+dO513BA0yB3n20f4ulz2l2r815klUK9POCifbwFOcjfwiRg+ry5PTH29lUHCXs15fO3ZVAsM0FTkDIICHP/biFlLg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781051434; c=relaxed/simple;
	bh=4d2YpPE3MJSwpFCXtKtMn7CD4QRh4ycTaVKBrV61MdA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L+EbqRudPgJRaPEkt0QGeMRaA/nocVUR8HRz9JKLup+/GjWmrTugL179CZi14Y8DPsCN8QuxqEhN0xDHrDuRze+ZIo00yJGp/pZM5Fn+8lRPZRf1kzR8Zr64fvIgrYtCd1Fsj0U2q145ZWEMBaYXHl9VGkUmucckhbMXSiDQuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sXQ4qg6d; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXQ4qg6d"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so86363455ad.0
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781051432; x=1781656232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wmvrWZYdbFP/pyb4oIuyF7Q4qkwJgfKUGT83D582MQ=;
        b=sXQ4qg6dYxkxVlwFhPT2ONAAwCqhUPanXQlFC53D1jXzwKLpFji3fBF8JnmonPI4Fq
         Eib+jcbpmSXAGTa6hhtKnGkZdeq0VJFeMgDw9sqZfWxx5QKKHfleDjTJJwRvwJRmV4f1
         cIHxY90iZ5MqxLjC2Kx8x3Ulf0Dz81ACGJNS6yoFT/XjS3btwUr+HsH3CrMNO3L2nbPN
         cFoi4nf1bf1/vXMfN2PxgxaB2q0uDWZZ0J9KesK/r58ZzdPL9ZZATPWtYDIUPx8HGLgs
         8Be5V43RVJZttlqm1kc9wkxbCSy2RDwspbE6KSrnVSD14giL96bsq9lV1IWf9pMTAzRH
         m63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781051432; x=1781656232;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wmvrWZYdbFP/pyb4oIuyF7Q4qkwJgfKUGT83D582MQ=;
        b=ANemjvF7vs15KMewFiJZOcYauGm8zKtZwFqzeY2idKo0vdUaMIP5zdfGQa1XMMaDnl
         5oRoU6yEpswcFLpeyVaRzFUQGlBVRKxjugEQF+ftza5A/cb0fKCLtQXWC9KNqaTT/QYd
         ae3ocQ1qgqDwFnbSBaZ0UfaaxFY8iHvx8/ZlSTeoi0tbiEbCnRVh9P0Pd75LAq8sxkLG
         QQ64d7eP3tPtcLoFBoP7XTcgw91R7oSWdUY+yB8PXV7As75E8hzTxjUvLdxvXr2+eScJ
         aqfKJBs6QpPz1hZYerFb1kpvWp4JBnWv+Kf01/trgBFK393T62tX6gZlXm6lOBHhMYm1
         mxXg==
X-Gm-Message-State: AOJu0YyvWUFwLpLFKHyutFxH0Oi605QlRBc3nbEy7zfCNFX0TGU3/hEq
	pQUegYhctHB/0j1FGvvAqNmDE79iz9XPgHXLnVPLnNo8MK4mPFaiFD5pMjLbZyTqelgEhgLCAZP
	CUKX6jQ==
X-Received: from plbmf15.prod.google.com ([2002:a17:902:fc8f:b0:2bf:14c9:866d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1205:b0:2c0:b6c7:2271
 with SMTP id d9443c01a7336-2c1e80e3bc0mr276805925ad.4.1781051432376; Tue, 09
 Jun 2026 17:30:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:30:25 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610003030.2957261-1-seanjc@google.com>
Subject: [PATCH v8 0/5] KVM: selftests: Add AMD PMU Host/Guest test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

This is the selftests portion of the mediated PMU Host-Only/Guest-Only series.
My plan is to get this into 7.2-rc1, but after the other KVM x86 pull requests
have been merged by Paolo (several unpleasant conflicts across multiple
branches).  I'll either send a separate pull request, or see if Paolo wants
to apply them directly.

v8:
 - Add a kvm_is_mediated_pmu_enabled() helper.
 - Drop the AMD Family check.

v7: https://lore.kernel.org/all/20260527234711.4175166-1-yosry@kernel.org

Jim Mattson (1):
  KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Only
    bits

Sean Christopherson (1):
  KVM: selftests: Add a helper to query enable_mediated_pmu module param

Yosry Ahmed (3):
  KVM: selftests: Refactor allocating guest stack into a helper
  KVM: selftests: Allocate a dedicated guest page for x86 L2 guest stack
  KVM: selftests: Drop L1-provided stacks for L2 guests on x86

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |   6 +
 .../selftests/kvm/include/x86/processor.h     |  10 +
 .../selftests/kvm/include/x86/svm_util.h      |   5 +-
 tools/testing/selftests/kvm/include/x86/vmx.h |   4 +-
 .../testing/selftests/kvm/lib/x86/memstress.c |  19 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  45 ++--
 tools/testing/selftests/kvm/lib/x86/svm.c     |   6 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c     |   6 +-
 .../selftests/kvm/x86/aperfmperf_test.c       |   9 +-
 .../kvm/x86/evmcs_smm_controls_test.c         |   5 +-
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  |   6 +-
 .../selftests/kvm/x86/hyperv_svm_test.c       |   6 +-
 .../selftests/kvm/x86/kvm_buslock_test.c      |   9 +-
 .../selftests/kvm/x86/nested_close_kvm_test.c |  12 +-
 .../selftests/kvm/x86/nested_dirty_log_test.c |   8 +-
 .../selftests/kvm/x86/nested_emulation_test.c |   4 +-
 .../kvm/x86/nested_exceptions_test.c          |   9 +-
 .../kvm/x86/nested_invalid_cr3_test.c         |  10 +-
 .../selftests/kvm/x86/nested_tdp_fault_test.c |   9 +-
 .../kvm/x86/nested_tsc_adjust_test.c          |  10 +-
 .../kvm/x86/nested_tsc_scaling_test.c         |  10 +-
 .../kvm/x86/nested_vmsave_vmload_test.c       |   6 +-
 tools/testing/selftests/kvm/x86/smm_test.c    |   8 +-
 tools/testing/selftests/kvm/x86/state_test.c  |  11 +-
 .../selftests/kvm/x86/svm_int_ctl_test.c      |   5 +-
 .../selftests/kvm/x86/svm_lbr_nested_state.c  |   6 +-
 .../kvm/x86/svm_nested_clear_efer_svme.c      |   7 +-
 .../selftests/kvm/x86/svm_nested_pat_test.c   |   8 +-
 .../kvm/x86/svm_nested_shutdown_test.c        |   5 +-
 .../kvm/x86/svm_nested_soft_inject_test.c     |   6 +-
 .../selftests/kvm/x86/svm_nested_vmcb12_gpa.c |  13 +-
 .../kvm/x86/svm_pmu_host_guest_test.c         | 215 ++++++++++++++++++
 .../selftests/kvm/x86/svm_vmcall_test.c       |   5 +-
 .../kvm/x86/triple_fault_event_test.c         |   9 +-
 .../selftests/kvm/x86/vmx_apic_access_test.c  |   5 +-
 .../kvm/x86/vmx_apicv_updates_test.c          |   4 +-
 .../kvm/x86/vmx_invalid_nested_guest_state.c  |   6 +-
 .../kvm/x86/vmx_nested_la57_state_test.c      |   5 +-
 .../kvm/x86/vmx_preemption_timer_test.c       |   5 +-
 40 files changed, 323 insertions(+), 215 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c


base-commit: de3a35be92d2391ece4bf3143ef2887192625fd0
-- 
2.54.0.1099.g489fc7bff1-goog

