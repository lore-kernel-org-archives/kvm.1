Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D783909A2
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779986; cv=none; b=N2n0cuicU3DRG7riNSWmjPKhvQDNRt9g1MAPg1ge/V8DGGENfGcF3ebqkK7TapLrLWTjKnB/G9Fwp+Yvoie+yGDIdSTuAuYEhllFv1HApIH10BNAG2cCWgEOukVQewSc7CUzQ6ZCMd3ThLzVyM+aJgA5t7jepI7fR+blx9DrNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779986; c=relaxed/simple;
	bh=BpaksvF5UiW1hvchMik7kTD9xZb/ra4jb7djNqkMrks=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QWM+6UIch2iiHjMTlUh1bu5MCEDNB+HzsiafL+WosISMBPWNg+UUN4pgpLaJ6pqiu2TjVBV0eAFJxNOBx8WV2zZQnM39xuW6JqyBBo55srjNU2bQozvpa/eOIQ4dD8ZSZ1aFlsE0jesPPOdQo0azh+arQsH5xRRWrN8k0hSYQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQ9ky1aV; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQ9ky1aV"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbbb9c9bfc3so1237982a12.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787779985; x=1788384785; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4JrZ3+7VrlAoRWfokfGXF58q3ir4/R4tHcE9QWIU5G4=;
        b=nQ9ky1aVJWyFCarMJgy3yoCfgpEU9QPIZEhiSFSnn2Pl98SFEK+DrozErr7zzqgT0d
         6ZtEclmeR4yh59GalSOq/iaA+birD067f9BUzh6LVSADxgafciY1olCKGNjF16BFox95
         zypXppQyw7j6vUHEiRHn4dnnhO/6yjZ8StEuPWceqc3F57mVSlycxFUH+bHjc2oHRykT
         hNJi/7QdAHwPNjCc85c1um/i8SFXxZ1ErcVKPC73i5NL8vWTNFb3LVhj5W0DIr1wOKtA
         /TA2ycfNeKJ2WOie0LnxybAgd1yNQQX+TEAQ5Qapp0Vmzm5ZtcGboOBr1Xn2g28zEI+r
         cMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779985; x=1788384785;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4JrZ3+7VrlAoRWfokfGXF58q3ir4/R4tHcE9QWIU5G4=;
        b=gKj++NBu2quhZkNPNg47jyVpRbRd54H/HaOgPTe5qKAXTlwbQPPh/WXhZzkz7wQXWP
         qqe3T6e1kHAsK+17v9+iexh+jX0QcMPCA3TNX0ZFZDyPZLBWTUFGtqOPxg7dxnyLiBmQ
         9+6PxeJk0Hs2BfAEcNDh5TgpSPyZ0laiENuxpfHSeQi88E6PqutbLhgo+nXxupla42u1
         t1Hja4sYkLfAu7lNmQfpNi0B8dc00DiIq7uP17NFzbSG5wXRtyRxk/23xNvKr19L+UCN
         TndjehEK0BR3XYiAfRttdf95E1OSW8dzhOv10eT3SklqUWXTv8gO0LccssR3SdBB0GQs
         boeA==
X-Gm-Message-State: AFuF++nuWgNo0pgWrSEsgYtA9bINv2EQ7EPCXEaQtCdCjLcDbHRL3Fa4
	8yq0EGihTA1eDB4iGbXmL4gNBKoGaPKfDcrwuQ6oVY1leCDCFnMfdEIr5/MUPGbzKnsLmC2QqEr
	cPEDuGA==
X-Received: from pgby7-n1.prod.google.com ([2002:a05:6a02:6507:10b0:cbe:9e80:c38b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e18b:b0:3be:b0b3:3962
 with SMTP id adf61e73a8af0-3cf83f36b8amr21365562637.9.1787779984471; Wed, 26
 Aug 2026 14:33:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:40 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-1-seanjc@google.com>
Subject: [PATCH v10 00/21] KVM: x86: Cleaning up the KVM clock mess, part 1
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Part 1 of David's series to clean up the host-side mess of kvmclock.  The cut
point in this version is still quite arbitrary, but what's left for "part 2" 
fits nicely into 2-3 buckets:

  1: Masterclock overhaul
  2. New uAPI and tests

v10:
 - Drop the stale reference to using div_u64() for the now-removed CPUID leaf.
   [Sashiko]
 - Don't bother with a enabling the pvclock_gtod notifier on 32-bit, and go
   straight to ktime_mono_to_any(). [Sashiko]

v9:
 - https://lore.kernel.org/all/20260810225500.869288-1-seanjc@google.com
 - Pull in "Compute kvmclock base without pvclock_gtod_data" before "Avoid NTP
   frequency skew for KVM clock on 32-bit host" to avoid having to provide what
   is effectively an open-coded version of ktime_mono_to_any() to avoid data
   races. [Sashiko].
 - Pull in use of kernel timekeeping snapshots, split in three patches purely
   to aid review and bisection.
 - Check and clear KVM_REQ_MASTERCLOCK_UPDATE in kvm_arch_vcpu_postcreate().
   [me, Sashiko]
 - Add the missing return value in "Move "no master clock" fallback from...".
   [Sashiko]

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

David Woodhouse (14):
  KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
  KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
  KVM: x86: Activate master clock immediately on vCPU creation
  KVM: x86: Compute kvmclock base without pvclock_gtod_data
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
  KVM: x86: Use kernel timekeeping snapshots for getting kvmclock time
    since boot

Sean Christopherson (7):
  KVM: x86: Update "last guest TSC" snapshot prior to enabling
    IRQs/preemption
  KVM: x86: Drop unnecessary CPU pinning when computing/getting kvmclock
  KVM: x86: Move "no master clock" fallback from __get_kvmclock() to
    get_kvmclock()
  KVM: x86: Disable preemption, not IRQs, when getting TSC+freq pair
  KVM: x86: Make master clock logic in guest PV clock updates 64-bit
    only
  KVM: x86: Use kernel timekeeping snapshot for monotonic clock
  KVM: x86: Use kernel timekeeping snapshot to get walltime+TSC

 arch/x86/include/asm/kvm_host.h |   6 +-
 arch/x86/kvm/cpuid.c            |   1 +
 arch/x86/kvm/msrs.c             |   3 +-
 arch/x86/kvm/svm/svm.c          |   3 +-
 arch/x86/kvm/vmx/vmx.c          |  10 +
 arch/x86/kvm/x86.c              | 480 +++++++++++++++-----------------
 arch/x86/kvm/x86.h              |   3 +-
 7 files changed, 240 insertions(+), 266 deletions(-)


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.887.g758fc8c411-goog

