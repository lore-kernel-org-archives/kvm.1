Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C83E435526
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402519; cv=none; b=iCXYAkfa3pa96KPPV/KTcGZujxvU2uw2DVD2gXQM0oXy66fDVaxw5ll9b5rH7TttLR+8tfp394qS0f2bY1yfYdl+Ei8mCPViKO5v++87Z179h7K2tfZsrXJT+KVcSn7q+jBA0zLuK32DDcUANThjXfplVMD9v4CySS5GjcfZMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402519; c=relaxed/simple;
	bh=tHgHzWXtTWzSurFZi7d7poZgSGg7TgtTAl+lGGS964I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cNwtVHSj4AuWotDFcoWS74C5N90G01m9C7+JBhOQOmhlKemalHo1PWAq3eIEh7QMp+m/78BQAl8Wp1ZDyR/U3sAW3Mn4kPmnj1fox3O4vnpTB3sNttDzGVCCVdmrBb+xz0ca1tHO2OxjAEpiYvhtr5nIabj2v7ejH4xOFMEjvSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nB7Ad6DF; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nB7Ad6DF"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e375d9736so3229289b3a.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402511; x=1787007311; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UeNZp5E2eUOzcTthah9NoXAW7FvUWg7wZ3z5+fNqOa4=;
        b=nB7Ad6DFmcHBM26xHgKAi8bV7rZqe747vNrrv1mh0ixoLCX7E9f0Ncgstv9/CFXsYe
         AU2DZIMOF4C58VskcTaYl6giWfTQUpkuwkw/3YqxsAH72d/1y+lcP7AYQrIHGeAgugds
         hu68lZkBrWC9I0w11ioDmi/bUnQA5WLYWrvd8XSh4qM4H2EFNs8dTh/xwxZ1rxwHoDf8
         gnNyojiqcq2Ku5QbGjGqkr99DD7kptCioFjLU7KsybKE021uHs6NJh2Bora9hkkPUBnX
         04032CvXdXhoMaDrWZh0G6vbiVhlx+rS++SwWkRY7WtKsgRETO7ff6kit1U79tac9xvw
         o2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402511; x=1787007311;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UeNZp5E2eUOzcTthah9NoXAW7FvUWg7wZ3z5+fNqOa4=;
        b=EGtmBWiewmk8eSEWIv25/pBX6uH5bDMwvQqWK2TCh1HNhRN17DTPSpC9L3LEJL8NB0
         j+L1GB1zLeGHXV7NXV7wmO1Rw1MSvQQwSAAcpLLpAK9qEKcQEWu1s77caa6ioFbQ0Tp9
         moMP6JjEjrf7FUz/alsWL0O4lcuFgVkcP55zx0Oln0zgl3a96nLgIWqQgDCtU7kAsNA4
         ijr712ninA41Mg9RFyMmLMM5g2KLRRg5IVJ3Oy26qrr+UGfOc5Pru4i8L+2p5UevW9aq
         YM+Dx6u0ZcS7+W5XvkhT8oal2L9aEw5f2ziNKIpU3EVkyJXrmK18E+siDfcxdVGqDU+U
         FBag==
X-Gm-Message-State: AOJu0YxAlre5AH4dto7Sbh+iM77AWZPEMXzEtk3j/Gq0A1+tYaL4hbh6
	S1PFPx3cJFY3nEgPr/1F4M13VkPj+/l8YT+G2lXkGGfe/Oo+gf72bNMXyqqBOeODHkQPlwZ0hpj
	BXfS0vQ==
X-Received: from pfbeg27.prod.google.com ([2002:a05:6a00:801b:b0:842:83c0:8d73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:9306:0:b0:847:98ff:4af5
 with SMTP id d2e1a72fcca58-84f2e00ea3amr56097393b3a.26.1786402510570; Mon, 10
 Aug 2026 15:55:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:44 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-7-seanjc@google.com>
Subject: [PATCH v9 06/21] KVM: x86: Avoid NTP frequency skew for KVM clock on
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
[sean: rebase on top of ktime_mono_to_any() usage]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 67c762b3bf28..93b49be0d887 100644
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
 	return ktime_to_ns(ktime_mono_to_any(ktime_get_raw(), TK_OFFS_BOOT));
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
2.55.0.679.g6767b8d81c-goog

