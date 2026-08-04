Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C033BBD7
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886768; cv=none; b=puGCBQRSkUht1dr7OSLk+SdKR8wItCDObHSx3XszFIldoy9aBaUTz2DoUR6rzH3v4I/mYF0OW8/Nbu19u1xuHDBGXkGiZc9rGvNiuHTqhu/qDhg2DxwD7zXMBpUidwQUu5xFXjZIroat9A49Cz61cKFiuFKNJmbBIHkDHnqntmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886768; c=relaxed/simple;
	bh=JJOWOiazh9hbd55PEARizwtcOCwRLbjqT+V6GkpgxNw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IFa8a1EQzDo2dH8xTQTsk9aEUUAn5v8hvxITRyxwDHiDUd1dGCaxH+At22n8hVOlclWFRYmIK2HDlSXiiRDA3w/v3fb8hax61MBlqCGWKkFqCqu44LH1IfSnhyokij4tkyBNKdcb1IDUuy+DDxcw6WcyCw72AaMDQx7iUv7+/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNWLap3u; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNWLap3u"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84842381150so584854b3a.3
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886767; x=1786491567; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=377A3J/TE3/FgbcypMT8C/e1RTsBxbIY6pGR8tcpmrQ=;
        b=fNWLap3u8ARGLL0Duw6lL9s7JRHUeUSKMunLzvtNZA2eHdcecW0DSaRfOu3Id/Kh9X
         P2wh9BOgKwfcaA+AgGy1cY4rFe2o2AWYVbj9oGYfOjdpJ60dtkOLxZlCc7Uvh78RZbfa
         LZ/FfsTM1p1DBKpL89QuDPT2Wvggo3YqQeZtK7AOjm2DjWdpDNDgy6wHH52lqAhd++q/
         6ARpKrKprIFaxzmL6YWeHDvpfpdh8YSADyCggqyTnEaqjkmqswdYcZzoVqofC6HKioOq
         7movD9Zr9tHAFl96fJC0sdKrXOKATGk8y5XwLkq1PvXbv1VuZ7760fjgjYMC1YQa5qSR
         V9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886767; x=1786491567;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=377A3J/TE3/FgbcypMT8C/e1RTsBxbIY6pGR8tcpmrQ=;
        b=pue1c/aJVrUlniLSY8qF5TQOgv7wwts0pSQNWzK/XZcv7gqpMcgFC1rZ4H0jFOPm8n
         K+OrAk2IlDyf3z2r96LD7XD5fwbecjTc+9i3FRpRetzgDeux0EWNRbDtp2X+gpC6xiFj
         DR7dKYFfHPugOv7EICTn1Dhysi4kUoMVYN+nKnJQSTjSXmiNbSDpzblCoek4g/JFjSBu
         kwy5vrnDlEm8NEysgTxWOEZhWrF1lfRYXIK9tJF80e3RTbHAUvd9lbhqlKjRDyVGBmRM
         e4yZhLX62deX3qHX+QuJGRUufQ4xk3P3r/o77TKQHDLj18nKbQJrO4/DYcj2eppsdC1e
         l6DQ==
X-Gm-Message-State: AOJu0YyUPcQZnEKTuyxiSljadXQIj1GoPz0/k3WFJ1Z4GwxPsuNj1JOF
	27VzAFWzFiUukN2QiIxQ9pCm3m+aO2Vf2SyYhzeqiqo6GZXnl7+JXRvUT63Q9GioMbnt/CHGPsy
	sj9LaGQ==
X-Received: from pfaf12.prod.google.com ([2002:a05:6a00:a11c:b0:848:866d:f119])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b03:b0:847:95a6:eb74
 with SMTP id d2e1a72fcca58-84f2e00e9f2mr2312052b3a.23.1785886766332; Tue, 04
 Aug 2026 16:39:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:04 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-1-seanjc@google.com>
Subject: [PATCH v8 00/17] KVM: x86: Cleaning up the KVM clock mess, part 1
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

This is the first half (give or take) of David's series to clean up some of
the mess that is timekeeping in KVM.  The "cut point" is rather arbitrary:
I stopped when I lost confidence in my understanding of the patches.  I'm
planning on diving back into review for the remaining patches asap, but want
to get start landing changes since many of these are fixes.

v8:
 - Obviously cut partway through the full series.
 - Update commit references for 633d7652f80f ("KVM: x86/xen: Do not corrupt
   KVM clock in kvm_xen_shared_info_init()").
 - Chunk the "Restructure ..." patches into individual logical changes
   ("Restructure kvm_guest_time_update() for TSC upscaling" in particular was
   quite gnarly).
 - Ensure the TSC+freq pair during guest time updates happens on a single
   CPU. [Sashiko]
 - Keep __get_kvmclock() as a masterclock-specific helper to avoid deep
   indentation and gotos.
 - Do waaaaay too much spelunking to try piece together the history of some
   of the many warts.
 - Ensure preemption is disabled in get_kvmclock() when getting the TSC freq.

v7: https://lore.kernel.org/all/20260728144954.355376-1-dwmw2@infradead.org

David Woodhouse (12):
  KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
  KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
  KVM: x86: Activate master clock immediately on vCPU creation
  KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
  KVM: x86: Wrap all of __get_kvmclock_master_clock() with
    CONFIG_X86_64=y
  KVM: x86: Fall back to non-master-clock if clockread fails in
    get_kvmclock()
  KVM: x86: Fix KVM clock precision in get_kvmclock() with TSC scaling
  KVM: x86: Use get_kvmclock() in kvm_get_wall_clock_epoch()
  KVM: x86: Fix compute_guest_tsc() to handle negative time deltas
  KVM: x86: Upscale TSC to "now", not master clock when updating PV
    clocks
  KVM: x86: Simplify and comment kvm_get_time_scale()
  KVM: x86: Remove implicit rdtsc() from kvm_compute_l1_tsc_offset()

Sean Christopherson (5):
  KVM: x86: Update "last guest TSC" snapshot prior to enabling
    IRQs/preemption
  KVM: x86: Drop unnecessary CPU pinning when computing/getting kvmclock
  KVM: x86: Move "no master clock" fallback from __get_kvmclock() to
    get_kvmclock()
  KVM: x86: Disable preemption, not IRQs, when getting TSC+freq pair
  KVM: x86: Make master clock logic in guest PV clock updates 64-bit
    only

 arch/x86/include/asm/kvm_host.h |   6 +-
 arch/x86/kvm/cpuid.c            |   3 +-
 arch/x86/kvm/msrs.c             |   3 +-
 arch/x86/kvm/svm/svm.c          |   3 +-
 arch/x86/kvm/vmx/vmx.c          |  10 +
 arch/x86/kvm/x86.c              | 332 ++++++++++++++++++--------------
 arch/x86/kvm/x86.h              |   3 +-
 7 files changed, 212 insertions(+), 148 deletions(-)


base-commit: 51ba04112e93ac6e04c627eddcea5caf9cbc0134
-- 
2.55.0.571.g244d577d93-goog

