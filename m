Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB77B41A4FC
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886774; cv=none; b=LOb1Pja5DcAoQ36BeDYMT2IfMW3mfFLVblL63CZLtnuI8mKxrmp8O3owASQlgxnESPOuo9DIll/QsUVVv3pBk8YXAjd5NJ8vQo3dwsOLv66YvyZo0iy8otCxDq8DVJJlkwDXVD+wKWp0+TpYoxBO7o+uNklmJMV97Ov+Gp5Od/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886774; c=relaxed/simple;
	bh=WqiyIYDUJvoYrhXVhsOcnM9n3MISpQM9nYaqruRIwEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kjW1cSeVJOE6+Iyt/8DQIs/R+NIVsF58q/VUmT9uAKUczUEfB/PQ3Xf0AHFaGK/bvPaz++gluep3Zksn2Ln7/aOk6UdEJGbMarGRm6FO5ysyrJSJAtP8kZeL1BWH2CgdWxX0MBxoHAFCI82zkzrgECOUib795uCNim9l6MlO550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZMDWs0B4; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMDWs0B4"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso4549275ad.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886772; x=1786491572; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x5rOF7VvxtdkKkuGdXTFcuTjBzanZoFZ5hsAKXxG2sk=;
        b=ZMDWs0B4p9YbqNPKhlrVRsNtllfcjB316CY7uxsAyQXycNamCaS/QCgH0v9ZqwqjuU
         PuT4nKuYXClwRxSTyKG4JOob8NqFbLcGBaCAjo5nMlsfaB8TSL7qyQnQSzpESIWuapdk
         r1muW0Gnl6p+rMHUGmI9OZFrn5sc+fVm9Jx2WTNaCta7Zlpu+js3Sm/P/wzQCvFtwyjh
         joAtqSL60TGW94machOexOie80Al82qUHrG2zQh8dp1IqTbIRoMoR+rntnti2po9/c3d
         GNHzZOtMEeJL+BWF3J3JLqaQXjkYbcnQegsjqYdwKMxdS5vGEfzBmiy3KXPFa5/KOiHQ
         Tx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886772; x=1786491572;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x5rOF7VvxtdkKkuGdXTFcuTjBzanZoFZ5hsAKXxG2sk=;
        b=HUQpce/tEVh2a3GX0bjTPlKV9AR/vdHRYzO9yjdSTtEy3XoibQqTU9YYOz3BBb6ZPW
         Hw9Fc3X3N6Wm7oDwCyd0LDO3MtJdGWvs4B38OZRkfqud82sQgGXbLbbODrpvXoVrE7Zf
         mSVo/A3LCglBxiKwnhHg1A5gg1ezrFIOq6jydxvF+lTTde5CuT1VwDjewrT3M9TBfc3w
         Cb6Bbg3K9qrIsoOpVlhrg8PvmR+VDoSP22BNSUyDEil6xCs/dTZlPRDv0hwsJxIkoHwB
         F6LEJQGHoenJx5A8V2q4rak/HtcJs0tGDcIEWMThihWlFHjNsPF/s6OdKD9s3JWZkt61
         1Ipg==
X-Gm-Message-State: AOJu0YyX7WbTJ35k0aRdeDZmHwBxJloH7IOyPrsCCUeWOIYVXZKQVj1e
	Z//q9VSQ2K4P5Lt4rj7B/6GOme69up8eSPfV+AwnkZ+r/NYPb8y68dypp4rCrhWoQBkQZbhh/B6
	H2UEyDg==
X-Received: from plck21.prod.google.com ([2002:a17:902:f295:b0:2cc:8e87:df3c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:388c:b0:2cf:4339:aaa
 with SMTP id d9443c01a7336-2d0ca7fbb6bmr26189435ad.12.1785886771887; Tue, 04
 Aug 2026 16:39:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:09 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-6-seanjc@google.com>
Subject: [PATCH v8 05/17] KVM: x86: Avoid NTP frequency skew for KVM clock on
 32-bit host
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

Commit 53fafdbb8b21 ("KVM: x86: switch KVMCLOCK base to monotonic raw
clock") did so only for 64-bit hosts, by capturing the boot offset from
within the existing clocksource notifier update_pvclock_gtod().

That notifier was added in commit 16e8d74d2da9 ("KVM: x86: notifier for
clocksource changes") but only on x86_64, because its original purpose
was just to disable the "master clock" mode which is only supported on
x86_64.

Now that the notifier is used for more than disabling master clock mode,
enable it for the 32-bit build too so that get_kvmclock_base_ns() can be
unaffected by NTP sync on 32-bit too.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3ebcf2f27f7d..f60f4826db1a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -874,7 +874,6 @@ static inline bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
 	       kvm_request_pending(vcpu) || xfer_to_guest_mode_work_pending();
 }
 
-#ifdef CONFIG_X86_64
 struct pvclock_clock {
 	int vclock_mode;
 	u64 cycle_last;
@@ -932,13 +931,6 @@ static s64 get_kvmclock_base_ns(void)
 	/* Count up from boot time, but with the frequency of the raw clock.  */
 	return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_data.offs_boot));
 }
-#else
-static s64 get_kvmclock_base_ns(void)
-{
-	/* Master clock not used, so we can just use CLOCK_BOOTTIME.  */
-	return ktime_get_boottime_ns();
-}
-#endif
 
 static uint32_t div_frac(uint32_t dividend, uint32_t divisor)
 {
@@ -6873,6 +6865,7 @@ static void pvclock_irq_work_fn(struct irq_work *w)
 }
 
 static DEFINE_IRQ_WORK(pvclock_irq_work, pvclock_irq_work_fn);
+#endif
 
 /*
  * Notification about pvclock gtod data update.
@@ -6880,26 +6873,26 @@ static DEFINE_IRQ_WORK(pvclock_irq_work, pvclock_irq_work_fn);
 static int pvclock_gtod_notify(struct notifier_block *nb, unsigned long unused,
 			       void *priv)
 {
-	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
 	struct timekeeper *tk = priv;
 
 	update_pvclock_gtod(tk);
 
+#ifdef CONFIG_X86_64
 	/*
 	 * Disable master clock if host does not trust, or does not use,
 	 * TSC based clocksource. Delegate queue_work() to irq_work as
 	 * this is invoked with tk_core.seq write held.
 	 */
-	if (!gtod_is_based_on_tsc(gtod->clock.vclock_mode) &&
+	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode) &&
 	    atomic_read(&kvm_guest_has_master_clock) != 0)
 		irq_work_queue(&pvclock_irq_work);
+#endif
 	return 0;
 }
 
 static struct notifier_block pvclock_gtod_notifier = {
 	.notifier_call = pvclock_gtod_notify,
 };
-#endif
 
 void kvm_setup_xss_caps(void)
 {
@@ -7118,9 +7111,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 
 	if (pi_inject_timer == -1)
 		pi_inject_timer = housekeeping_enabled(HK_TYPE_TIMER);
-#ifdef CONFIG_X86_64
 	pvclock_gtod_register_notifier(&pvclock_gtod_notifier);
 
+#ifdef CONFIG_X86_64
 	if (hypervisor_is_type(X86_HYPER_MS_HYPERV))
 		set_hv_tscchange_cb(kvm_hyperv_tsc_notifier);
 #endif
@@ -7177,8 +7170,8 @@ void kvm_x86_vendor_exit(void)
 					    CPUFREQ_TRANSITION_NOTIFIER);
 		cpuhp_remove_state_nocalls(CPUHP_AP_X86_KVM_CLK_ONLINE);
 	}
-#ifdef CONFIG_X86_64
 	pvclock_gtod_unregister_notifier(&pvclock_gtod_notifier);
+#ifdef CONFIG_X86_64
 	irq_work_sync(&pvclock_irq_work);
 	cancel_work_sync(&pvclock_gtod_work);
 #endif
-- 
2.55.0.571.g244d577d93-goog

