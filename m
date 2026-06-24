Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75863DB32C
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316598; cv=none; b=g4I5RE/iUSp78lhf46JhibxEJ06ptZwaU/rpmdszIOR5lg47abZ88HT5WUd2oSfS1LTXdep0e6QPH7TbTfwqjeIC7L5iYO3THJNHT7QrNAT6b5oP9T5aN0wCGGqES9qu7EYlUE8NaMZZVpScLZayyeF3P6Pjs52pl1xkSmf+n+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316598; c=relaxed/simple;
	bh=dO60zG8Yg3na92lTOA/VN0QDV2e1y5SPmjC5IV1AALE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pEuhuXv5c/F83dKWgs0ZERzfJsy9VB+JLpvYhag8Om6ybxP8P7/hnPM861cYo8d9KBmPTLeNQXmoNHN7WPluytix0w2v38sWnIfJlCBiqGm5gHMPpeVSFJ+fV08K4ha9oRTY6jCTXpvPrmU0O1eGsA9rQWNDLp05qbZGBvG3Nyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VfF2OV2f; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfF2OV2f"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37c648d3ab9so775447a91.3
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 08:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782316596; x=1782921396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHW9DBOLnZBr8QWGnxKOBSzJU5m0g1xPalv9JP1w5CI=;
        b=VfF2OV2fipeqshRIvh4dBzxh3E3y4XK3VH0a4uXxhUjnJgF87GzDu/nSieyxABHcQO
         2XR57sN5RU7y+HI2nfuYXjGnOCaY+sR/NvHO4TLerMnWgryVP34hAQRJBgesHXYt+A7H
         S7IAEq3p6fQzaaiG79eHCIQjYu5DNNEAxTzM/QtdlnpGncXLdSNi4x0j2jADMaF0n9MU
         iKZgTBjCV/ClRq16jlHZRTjc8Zou2gFBOdeuVha8Jv6d1DaFY/O/xW2hewYQVqi3s+Ay
         pCdhnAmDA9LqJdJrQCZJpoQOiO5Ja1vanAZQ71mUQAKXu2MfDn+NkeinCpr/uE1rDEEz
         w/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782316596; x=1782921396;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHW9DBOLnZBr8QWGnxKOBSzJU5m0g1xPalv9JP1w5CI=;
        b=F99L8jAExA5drLupHFlEl2nkIp1NhXc25rG6iz6sBoQWXGzDdJkMTZ13RPWiwfSkvR
         bwLqMx1bD81IVdskgDXSeIjYyDj8hAVAUMof1Jsjgq6BKchQdSdsimJfVxAvyp11PolD
         p6Zz8e9hlh995yKNbsvDVIrSfoVKuxBmLaw33x5Hf2GICxZlpbtImBNg/7fegv43N3Wo
         a0r9dbcQ+AVaK7lV8axuZP45g1GdgQGWVxao6B/5l/O2poytvKOGi9xYPMI5UT8wF9lL
         CBaSySsLd2ks3za7nO8HjU/vuL9ofioEgUnVzQh8eQ3eKQ51ODDeJCViFX9rUT1I6+Ks
         +x8g==
X-Gm-Message-State: AOJu0Yx86hQR5vtCjLJa8ZvOz7o5Ecui7lR+5xI2om4ghhfY0TtyFn5J
	zaVUfwyhY4oG/gFsjgpowy05FqwWdW1WV7B1OB6l6j7BeIBWDBhGAcGcPZF/VlYyMFVyHwqTdhw
	22utukA==
X-Received: from pjuu7.prod.google.com ([2002:a17:90b:5867:b0:377:2d20:59ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:394b:b0:37d:7bb4:bffb
 with SMTP id 98e67ed59e1d1-37de41dd113mr4240775a91.2.1782316595945; Wed, 24
 Jun 2026 08:56:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 24 Jun 2026 08:56:33 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624155633.2874939-1-seanjc@google.com>
Subject: [GIT PULL] KVM: Early selftests changes for 7.3
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

If it's possible to get this into to kvm/next before you disappear on holiday,
please pull a set of selftest changes that (lightly) touch all x86 tests that
use nested virtualization in any way.

If it's too late to get this into kvm/next, I'd say just ignore this pull
request and I'll include them in the normal 7.3 selftests pull requests.  I
don't think there will be any cross-branch conflicts to juggle?  But I've had
these sitting in -next for a few weeks now, and getting them into kvm/next
"now" would all but guarantee I won't end up having to play weird games with
selftests patches.

Thanks!

The following changes since commit ef057cbf825e03b63f6edf5980f96abf3c53089d:

  KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level (2026-06-16 00:39:57 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests_l2_stacks-7.3

for you to fetch changes up to 70f4701c12e4bb6214f0ec762f928e96ff3dacc3:

  KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Only bits (2026-06-17 17:56:17 -0700)

----------------------------------------------------------------
KVM selftests for 7.3, early edition

 - Automatically allocate a full page for L2 guest stacks on x86 instead of
   requiring test-specific L1 guest code to carve out a portion of the L1
   stack for L2 usage, and to ensure the L2 stack also adheres to the x86-64
   calling convention ABI.

 - Add a selftest to verify {Guest,Host}-Only behavior in x86's mediated PMU.

----------------------------------------------------------------
Jim Mattson (1):
      KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Only bits

Sean Christopherson (1):
      KVM: selftests: Add a helper to query enable_mediated_pmu module param

Yosry Ahmed (3):
      KVM: selftests: Refactor allocating guest stack into a helper
      KVM: selftests: Allocate a dedicated guest page for x86 L2 guest stack
      KVM: selftests: Drop L1-provided stacks for L2 guests on x86

 tools/testing/selftests/kvm/Makefile.kvm                         |   1 +
 tools/testing/selftests/kvm/include/x86/pmu.h                    |   6 +++
 tools/testing/selftests/kvm/include/x86/processor.h              |  10 +++++
 tools/testing/selftests/kvm/include/x86/svm_util.h               |   5 ++-
 tools/testing/selftests/kvm/include/x86/vmx.h                    |   4 +-
 tools/testing/selftests/kvm/lib/x86/memstress.c                  |  19 ++-------
 tools/testing/selftests/kvm/lib/x86/processor.c                  |  45 +++++++++++----------
 tools/testing/selftests/kvm/lib/x86/svm.c                        |   6 ++-
 tools/testing/selftests/kvm/lib/x86/vmx.c                        |   6 ++-
 tools/testing/selftests/kvm/x86/aperfmperf_test.c                |   9 +----
 tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c        |   5 +--
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c                   |   6 +--
 tools/testing/selftests/kvm/x86/hyperv_svm_test.c                |   6 +--
 tools/testing/selftests/kvm/x86/kvm_buslock_test.c               |   9 +----
 tools/testing/selftests/kvm/x86/nested_close_kvm_test.c          |  12 +-----
 tools/testing/selftests/kvm/x86/nested_dirty_log_test.c          |   8 +---
 tools/testing/selftests/kvm/x86/nested_emulation_test.c          |   4 +-
 tools/testing/selftests/kvm/x86/nested_exceptions_test.c         |   9 +----
 tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c        |  10 +----
 tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c          |   9 +----
 tools/testing/selftests/kvm/x86/nested_tsc_adjust_test.c         |  10 +----
 tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c        |  10 +----
 tools/testing/selftests/kvm/x86/nested_vmsave_vmload_test.c      |   6 +--
 tools/testing/selftests/kvm/x86/smm_test.c                       |   8 +---
 tools/testing/selftests/kvm/x86/state_test.c                     |  11 +-----
 tools/testing/selftests/kvm/x86/svm_int_ctl_test.c               |   5 +--
 tools/testing/selftests/kvm/x86/svm_lbr_nested_state.c           |   6 +--
 tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c     |   7 +---
 tools/testing/selftests/kvm/x86/svm_nested_pat_test.c            |   8 +---
 tools/testing/selftests/kvm/x86/svm_nested_shutdown_test.c       |   5 +--
 tools/testing/selftests/kvm/x86/svm_nested_soft_inject_test.c    |   6 +--
 tools/testing/selftests/kvm/x86/svm_nested_vmcb12_gpa.c          |  13 ++----
 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c        | 215 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/kvm/x86/svm_vmcall_test.c                |   5 +--
 tools/testing/selftests/kvm/x86/triple_fault_event_test.c        |   9 +----
 tools/testing/selftests/kvm/x86/vmx_apic_access_test.c           |   5 +--
 tools/testing/selftests/kvm/x86/vmx_apicv_updates_test.c         |   4 +-
 tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c |   6 +--
 tools/testing/selftests/kvm/x86/vmx_nested_la57_state_test.c     |   5 +--
 tools/testing/selftests/kvm/x86/vmx_preemption_timer_test.c      |   5 +--
 40 files changed, 323 insertions(+), 215 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
