Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45747604C
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886785; cv=none; b=g3qfTOL3hwDcze22pf4DTZMPFDZoUjavqCx9FFa6HL0tb/8VruF60+ZvyuhWqdYiJH5zuiEpBwZHGRx42dmRLXGSDBufDqMsoPReAMocnT3kwGXDBmnLAQtYRC6urUiwyoo89wp14loj/sMB5wz8WeFc/7zjIQdkchDd9+rrjwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886785; c=relaxed/simple;
	bh=2zDZMYJnAPP4eISEzQ3+eAg8OusTbWq0ZtfbBKV6o2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u6G5s4O3HxBAL7rHZFpRRkaTbNfhDQe3CfhA0qeLgL+GjKg3ZUWbliQCWVpMdlnHlOK8I5VrGHhftIY2f0piGDkdIftFOrfMKmbemZIlbG/h7dxw+mB3DYoYr+AVI+9oisHmd0uNp2cFM+Mriuba8A3mogK6BxmH2INzfjCDp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XtXitA4M; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtXitA4M"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so5810685ad.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886783; x=1786491583; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q8tVJEpYezHZD1AJM7SOc8wInFAVXdKdeRZ1XVRTCk0=;
        b=XtXitA4M+uovRh5BGfnrTYyZ3oDrU2NGg001XR2nuTKF4zDA0muYiHyii7883fF+uP
         4db+eeNXADyIee0vcs8nW+3ots5XCct35dZx5gi9t/oYxSBomXu1ijdx1LiaTHvv6oPR
         4XxkQeRH9fahU+DKIyTZNBjCoL8+zmdW4siRX6HCKkCQ2nsoSpHXx07Sq/9DqW7kjaqZ
         c9KeBBy3mfw4krSM4ULfmktid2IE8BqzOF+0eb1s8RGALYu6auTvmv8SxK/mkhIB+hwa
         blAVBUtaWpbzWro4CabmIXI8iOCYK9y6ZYoY5AmrDbR/BuBSCURXUw0Qq1cq3IsnuK3s
         Q4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886783; x=1786491583;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q8tVJEpYezHZD1AJM7SOc8wInFAVXdKdeRZ1XVRTCk0=;
        b=Br81eDyEJ4QAdnWnDoYVvuNTS2Pp4PYE8n/ykow22v8G6X+lhhhmptaa8cZbwW8fdF
         TE//LQHWvoIESdchVBm0z8zOas9fdb+OlBij/XVhP8adm3U7bGhNcrIiwe8LXaMltbFW
         NLYZuPNMtGmXBRhwzmZlDOfyvbAYNdei2Mn/3ko+z4/nyKvCy6DGbv9Q/UV9E0ki8rRm
         /9BhoQhLbuExmfW0b4jd9jhVe1Wm6Qq8aOl/bvwQwZXvBMVOMnUMklNHdr5w34n/p6GQ
         vnpz7+r2uXbx62alB6gzZ3U8uWKbz9Z6VyEkwLUua+VJfZ73Tnqq4kqWYXRimp3dO3GI
         biTQ==
X-Gm-Message-State: AOJu0YxeIoeuIunI3bucBEACzTk22P2EtcRR5x90mVeZc8wONmqXoxwd
	jMLCQKFt1uVshi0yWnLg4yAUKMbYvry0mCcAO0Z9avfI6k1Qaf01gtVzz+CSX4YBVaPdPRPXWlA
	jSMrN2Q==
X-Received: from ploy5.prod.google.com ([2002:a17:903:1b25:b0:2cf:cc85:6bcc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2407:b0:2ca:c847:8e41
 with SMTP id d9443c01a7336-2d0c9b0faf9mr14056335ad.11.1785886783345; Tue, 04
 Aug 2026 16:39:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:19 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-16-seanjc@google.com>
Subject: [PATCH v8 15/17] KVM: x86: Upscale TSC to "now", not master clock
 when updating PV clocks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

When doing TSC upscaling in software, e.g. when the guest TSC frequency is
configured to run faster than the host without hardware support, always
advance guest TSC to "now", not to the master clock's reference values,
which represents some time in the past.

In master clock mode, there are two points of time which need to be taken
into account. First there is the master clock reference point, stored in
kvm->arch.master_kernel_ns (and associated host TSC ->master_cycle_now).
Secondly, there is the time *now*, at the point kvm_update_guest_time()
is being called.

With software TSC upscaling, the guest TSC is getting further and further
ahead of the host TSC as time elapses.  So at time "now", the guest TSC
should be further ahead of the host, than it was at master_kernel_ns.
Not taking that into account means KVM was advancing the guest TSC only by
the amount appropriate for the snapshot taken in the past, *not* to the
current time (which is what RDTSC is supposed to return).

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 070a12535788..cd438d06e4cc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1796,12 +1796,11 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 
 int kvm_guest_time_update(struct kvm_vcpu *v)
 {
+	u64 tgt_tsc_hz, tsc_timestamp, host_tsc, master_tsc, master_ns;
 	struct kvm_arch *ka __maybe_unused = &v->kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock = {};
-	u64 tgt_tsc_hz;
 	struct kvm_vcpu_arch *vcpu = &v->arch;
 	s64 kernel_ns;
-	u64 tsc_timestamp, host_tsc;
 
 	/*
 	 * If the host uses TSC clock, then passthrough TSC as stable
@@ -1814,10 +1813,16 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 	do {
 		seq = read_seqcount_begin(&ka->pvclock_sc);
 		use_master_clock = ka->use_master_clock;
-		if (use_master_clock) {
-			host_tsc = ka->master_cycle_now;
-			kernel_ns = ka->master_kernel_ns;
+		if (!use_master_clock)
+			continue;
+
+		if (!kvm_get_time_and_clockread(&kernel_ns, &host_tsc)) {
+			use_master_clock = false;
+			continue;
 		}
+
+		master_tsc = ka->master_cycle_now;
+		master_ns = ka->master_kernel_ns;
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 #else
 	const bool use_master_clock = false;
@@ -1883,8 +1888,18 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 
 	hv_clock.tsc_shift = vcpu->pvclock_tsc_shift;
 	hv_clock.tsc_to_system_mul = vcpu->pvclock_tsc_mul;
-	hv_clock.tsc_timestamp = tsc_timestamp;
-	hv_clock.system_time = kernel_ns + v->kvm->arch.kvmclock_offset;
+	/*
+	 * If the master clock is NOT in use, the reference time placed in the
+	 * hv_clock is "now".  If master clock is in use, the reference time is
+	 * the master clock's snapshot from some time in the past, not "now".
+	 */
+	if (use_master_clock) {
+		hv_clock.tsc_timestamp = kvm_read_l1_tsc(v, master_tsc);
+		hv_clock.system_time = master_ns + v->kvm->arch.kvmclock_offset;
+	} else {
+		hv_clock.tsc_timestamp = tsc_timestamp;
+		hv_clock.system_time = kernel_ns + v->kvm->arch.kvmclock_offset;
+	}
 
 	/* If the host uses TSC clocksource, then it is stable */
 	hv_clock.flags = 0;
-- 
2.55.0.571.g244d577d93-goog

