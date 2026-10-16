Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A7F38330A
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 04:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125860; cv=none; b=Ic8B7RjljCU4r5KYjP4ukgfCNYykjFCTJTz1tz6YzX6lDso9bTJKAey6SbRAQAI96n8U+xNu0ddsaI9agvUh/iyVncwFaFA4e0U4/oHxyi3Eu0tJJu1BGCQOqrbUQZhYRkOKQxnfpXkt3aWnFokTsuUb7X2HvdzYBAGNaZ9+a0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125860; c=relaxed/simple;
	bh=iBxhG0lDSXU9hccFsW+kLsVMxETbKXUFyCPAbKw24bg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=st62HT6E4kc4EChvqs2hlEM7OQ2H2f88Q4/kfgD3J3FerYGhHKfrS0sYbzqiBgEi95JCRmEIPQYf/xqHxee+QU1LRPvT7zap0CiQ81UZ+Ec7god/WmzOeg/dEwkmJGMNyQQLI+FDL2ey5YICh6S+mTdEsPH5q2bSWxrI6eQ2kpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rJsRHJde; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJsRHJde"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd5fd34fee0so1901839a12.3
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 21:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792125858; x=1792730658; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=stWvJXyBUg4KLELHwAAG+Vn93f0auxo1LLZDP1lXIio=;
        b=rJsRHJdeO12phGND+PhhDGk1cCcJyRFb0yAn/va1+H8kk1K/uWODl1bXSadrVTD1HS
         3UWcC0wMzGnk376YjrkyBGaIYd2gCqcntYSwyzjPJxVfwgBDX0Rv11CB/NcS+So+5Xnf
         9Wz29wX9/eaFtMq4h0icmmVq+X4b6ea00EKaQQAF/poRtot0OUQk699/CwoW/h64e97z
         bx422oNwQSrwsRgUauPkPXs3AunmzNu3ST52b6Lvkf3w3nl6qfOjDzS7JdOpoCjTxRcl
         wwYRcWsvTI+s9NBXH0KAB20hnfoJD/c1PuHgpZOLEdt+evG4TZxT/S7cnhi5GIgT3fUP
         KHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125858; x=1792730658;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=stWvJXyBUg4KLELHwAAG+Vn93f0auxo1LLZDP1lXIio=;
        b=mwu1vb1spj3Zmwwwn3ulboraCb7TH9Y+NCVW3c8sfsgj3BykfQPxq4ZzQt7cKt3oUp
         e9VtVWjWNajiMHp5JmmqVV/PXN3OCw2Jo58DUZsaSnUInhONO6127p3BBTvg6sjgRxPF
         xbOGLNk/FbBY0szn0YoaMvDIITSkzirXBG7hoNo3/7+yWmyjFc/R8juppMxDbnigpnUp
         rz6Va5EQAFiyMF4fd90w431rYidlznf9knDzOv1c/2pEbPlmvGWzfU6MNA0z6hpl8lg/
         4Gyzwo9nO1bEb+n9u4hvq+70+zVsI+PoiS3trpKreIji85LDgZM11lUEzJXCYgS6MSju
         iBgg==
X-Gm-Message-State: AFq9FYIhkQcbNgXoyHjUkW0/+A2UYN6BJ9zBJ8Sxr3OMilO6bH0i6K/G
	W3jbyKhdKk4o7D5L2hs1AD4wg39RiNE01abFAHql0hg156YHoDT1xbFw140zEg6jmT9VEvLlqpT
	Tb0SYiA==
X-Received: from pgbq26.prod.google.com ([2002:a63:5c1a:0:b0:cc7:e0b2:a5a2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1015:b0:3e1:6acc:59ea
 with SMTP id adf61e73a8af0-3e16c093f8cmr17703333637.62.1792125857644; Thu, 15
 Oct 2026 21:44:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 15 Oct 2026 21:44:06 -0700
In-Reply-To: <20261016044415.958618-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016044415.958618-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261016044415.958618-2-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Timekeeping fixes+cleanups for 7.4
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Part 1 of 2 (or maybe 3) of David's war on kvmclock.  Ugh, and when looking at
the shortlog, I realized I botched the author on these:

  KVM: x86: Use kernel timekeeping snapshot for monotonic clock
  KVM: x86: Use kernel timekeeping snapshot to get walltime+TSC

Holler if you would prefer a fixup to get the author right; these have been in
-next for over a month, so I opted to send them as-is instead of doing a super
last minute rewrite.

The following changes since commit d4b7fb647204f0c81dfeae2d1a708e4d858e0c94:

  Merge branch 'kvm-xen-longmode' into HEAD (2026-09-04 17:35:03 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-clocks-7.4

for you to fetch changes up to d7841275e1fb4ad1e1877e56725ebda5b6e3143d:

  KVM: x86: Use kernel timekeeping snapshot to get walltime+TSC (2026-09-11 11:46:19 -0700)

----------------------------------------------------------------
KVM x86 timekeeping fixes and cleanups for 7.4

Fix a variety of warts in KVM's handling of guest TSC, kvmclock, and
timekeeping in general, as a (big) first step towards addressing several
longstanding problems with the kvmclock implementation.

Most notably, fix a precision issue where get_kvmclock_ns() computed the
clock from the *host* TSC without applying guest TSC scaling, causing
systemic drift from the values the guest computes from its own TSC.

As a bonus cleanup, rip out the whole pvclock_gtod_data hack, which was
shadowing the kernel's timekeeping, and use ktime snapshots.

----------------------------------------------------------------
David Woodhouse (14):
      KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
      KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
      KVM: x86: Activate master clock immediately on vCPU creation
      KVM: x86: Compute kvmclock base without pvclock_gtod_data
      KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
      KVM: x86: Wrap all of __get_kvmclock_master_clock() with CONFIG_X86_64=y
      KVM: x86: Fall back to non-master-clock if clockread fails in get_kvmclock()
      KVM: x86: Fix KVM clock precision in get_kvmclock() with TSC scaling
      KVM: x86: Use get_kvmclock() in kvm_get_wall_clock_epoch()
      KVM: x86: Fix compute_guest_tsc() to handle negative time deltas
      KVM: x86: Upscale TSC to "now", not master clock when updating PV clocks
      KVM: x86: Simplify and comment kvm_get_time_scale()
      KVM: x86: Remove implicit rdtsc() from kvm_compute_l1_tsc_offset()
      KVM: x86: Use kernel timekeeping snapshots for getting kvmclock time since boot

Sean Christopherson (7):
      KVM: x86: Update "last guest TSC" snapshot prior to enabling IRQs/preemption
      KVM: x86: Drop unnecessary CPU pinning when computing/getting kvmclock
      KVM: x86: Move "no master clock" fallback from __get_kvmclock() to get_kvmclock()
      KVM: x86: Disable preemption, not IRQs, when getting TSC+freq pair
      KVM: x86: Make master clock logic in guest PV clock updates 64-bit only
      KVM: x86: Use kernel timekeeping snapshot for monotonic clock
      KVM: x86: Use kernel timekeeping snapshot to get walltime+TSC

 arch/x86/include/asm/kvm_host.h |   6 +-
 arch/x86/kvm/cpuid.c            |   1 +
 arch/x86/kvm/msrs.c             |   3 +-
 arch/x86/kvm/svm/svm.c          |   3 +-
 arch/x86/kvm/vmx/vmx.c          |  10 +
 arch/x86/kvm/x86.c              | 480 ++++++++++++++++++----------------------
 arch/x86/kvm/x86.h              |   3 +-
 7 files changed, 240 insertions(+), 266 deletions(-)
