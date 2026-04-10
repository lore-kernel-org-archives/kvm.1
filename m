Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E733932E0
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865524; cv=none; b=JwdW5DElZMBTKq3SABwY0SZ02+POzMqdTuQFWR+rxBppAzrWsUe622UdlqWnwz1QNHTy2xA2pSgC1NKEV6i7lewkZzDS6j0m/G6ukt48E6f/7hDqAFLoJuRF7WITphcgqXw0qXtZr2Zne2+JpE4E6HvYg4E232QVxvmZ3ju49X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865524; c=relaxed/simple;
	bh=AyOhxxP+LNX8AOwtZ314rKgLTiR0f6xVI/cbfnfoGDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MwMGyR05ldCjQ5yA5uGYX5cYIfMbnPWLYY9/ymxQ1KftUgvRX3JyA7me5DAiqT6+WFyzA7tGiPxkP128WIBJIVIwqdypblcyVC/scBw8/vH4wPkzXKT4xkXKepHPMEb3G7mt3F01cbYqHDdHv5yGfEPl2I9OqnWtq6qUF6120iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMFMJAWP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMFMJAWP"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35c0cbe0f64so5094803a91.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 16:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775865523; x=1776470323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYhEjI/DUF8BtY7K+RxlsdpfvyaITgHD0TOWbWw0dUQ=;
        b=EMFMJAWPAyf7Mrb0Eh21jIE/3/nCTQgCgsSFEV1zxpx8jUd/LU1o8PjZ6tqa4RSyrv
         GLeFUe2tBuYij9llnmWuuAoYdGy+ZSFnbNkBOTGxuzTNzQqK3mE/IR3azvwgBiwaosuF
         +zhurr3RazI+4YV6QoEm9Xmc+NwLVJ7mUVkPxHg/trb26m6FtPr1jrfjv9/yQOjGDcXb
         tJGKw4X0E16790qDAvZpuBRGhAhzNdGMW/eMVfZyL68IHnsPKV6JxdTeIcIAP4zY08QK
         ND61VWUFPsqkMy5q3EAKY+sEsCTrjekF1oK76WiS5+N5CQFztcKOzkkU7BVKlhg/OLpj
         /dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865523; x=1776470323;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RYhEjI/DUF8BtY7K+RxlsdpfvyaITgHD0TOWbWw0dUQ=;
        b=I+9NPs6xgk0EBaB3bBmM92G85RPougyzTLt0HutmWK70g8VHj9+OyQ53Qn4fT3b1zi
         I5zHSfNATqjGtqCWEevjiLd/34yZ03lroI/XE/jGJWZkRHNAx4X3SgzlRXwtYVETVhsJ
         h3Czg6+DK2U3nb6w5LIHWSaBBwxdpc2WF5EBKKJ37eaTFdLL9AYwbL5wRFZABLb2l2co
         SY/gA2TgHddnqWrWwZ+dEFBlLM9ea54NkuCjLRI4QT3fp6LjnlIzciJ3tVNwv5bFfTuD
         tGHi6qPzDRIXF41/8bbtr2QpoO1lBEAv/bY4Q2ac+ZJF9CofP8Gx6CNPZZX/P7eidjTj
         6EOg==
X-Gm-Message-State: AOJu0Yy3tKav4eTSzGlXCWpE1BVTipB7Rr6MJy5m9G3P8ZbLZ1yssTVu
	cTAypV2Az4jYqlxKws6c+FORS7bIz+5OUwlFeWiTeUlBiTw/3zPCec/QT4iBKSrDj6JqVcrPbKE
	ZtMpUOg==
X-Received: from pgbds10.prod.google.com ([2002:a05:6a02:430a:b0:c73:fe5a:384e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cc8:b0:35e:1d33:2324
 with SMTP id 98e67ed59e1d1-35e4282bd63mr5362666a91.14.1775865522516; Fri, 10
 Apr 2026 16:58:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 Apr 2026 16:58:22 -0700
In-Reply-To: <20260410235832.2312342-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410235832.2312342-4-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Misc changes for 7.1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A truly misc bundle of changes.  A few minor fixes, some cleanups, some
hardening, and one new feature (AVX512 BMM on AMD).

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808=
:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-misc-7.1

for you to fetch changes up to de0bfdc7137d5132b71dd1fe7aa3ca3df4d68241:

  KVM: x86: Advertise AVX512 Bit Matrix Multiply (BMM) to userspace (2026-0=
3-12 10:56:36 -0700)

----------------------------------------------------------------
KVM x86 misc changes for 7.1

 - Advertise support for AVX512 Bit Matrix Multiply (BMM) when it's present=
 in
   hardware (no additional emulation/virtualization required).

 - Immediately fail the build if a required #define is missing in one of KV=
M's
   headers that is included multiple times.

 - Reject SET_GUEST_DEBUG with -EBUSY if there's an already injected except=
ion,
   mostly to prevent syzkaller from abusing the uAPI to trigger WARNs, but =
also
   because it can help prevent userspace from unintentionally crashing the =
VM.

 - Exempt SMM from CPUID faulting on Intel, as per the spec.

 - Misc hardening and cleanup changes.

----------------------------------------------------------------
Anel Orazgaliyeva (1):
      KVM: X86: Fix array_index_nospec protection in __pv_send_ipi

Carlos L=C3=B3pez (1):
      KVM: x86/pmu: annotate struct kvm_x86_pmu_event_filter with __counted=
_by()

Jim Mattson (1):
      KVM: x86: Ignore cpuid faulting in SMM

Li RongQing (2):
      KVM: Mark halt poll and other module parameters with appropriate memo=
ry attributes
      KVM: SVM: Mark module parameters as __ro_after_init for security and =
performance

Nikunj A Dadhania (1):
      KVM: x86: Advertise AVX512 Bit Matrix Multiply (BMM) to userspace

Sean Christopherson (1):
      KVM: x86: Immediately fail the build when possible if required #defin=
e is missing

Uros Bizjak (1):
      KVM: x86: Zero-initialize temporary fxregs_state buffers in FXSAVE em=
ulation

Yosry Ahmed (4):
      KVM: x86: Check for injected exceptions before queuing a debug except=
ion
      KVM: x86: Drop redundant call to kvm_deliver_exception_payload()
      KVM: x86: Move some EFER bits enablement to common code
      KVM: x86: Use kvm_cpu_cap_has() for EFER bits enablement checks

xuanqingshi (1):
      KVM: x86: Add LAPIC guard in kvm_apic_write_nodecode()

 arch/x86/include/asm/cpufeatures.h     |  1 +
 arch/x86/include/asm/kvm-x86-ops.h     | 10 +++++----
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  8 ++++---
 arch/x86/include/asm/kvm_host.h        |  2 +-
 arch/x86/kvm/cpuid.c                   |  6 ++++--
 arch/x86/kvm/emulate.c                 | 10 ++++-----
 arch/x86/kvm/lapic.c                   | 13 +++++++-----
 arch/x86/kvm/pmu.c                     |  2 +-
 arch/x86/kvm/svm/avic.c                |  4 ++--
 arch/x86/kvm/svm/sev.c                 |  8 +++----
 arch/x86/kvm/svm/svm.c                 | 39 ++++++++++++++----------------=
----
 arch/x86/kvm/vmx/vmcs_shadow_fields.h  |  5 +++--
 arch/x86/kvm/vmx/vmx.c                 |  4 ----
 arch/x86/kvm/x86.c                     | 26 +++++++++++++++++------
 virt/kvm/kvm_main.c                    | 12 +++++------
 15 files changed, 81 insertions(+), 69 deletions(-)
