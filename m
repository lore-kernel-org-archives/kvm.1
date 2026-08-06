Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4348D49A22E
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059405; cv=none; b=PUEKYWsqWDvY3Bo9dcJshJC+GVGwgA++ZEzHsHDAWYQKKlGRsQa0FD3a8J6jlsKM9sZTlxCQPMi5f5DpN8gDRqjalDOT6IAHzwpYJdmBVAW2DeRA1aROKbHvy8s5pfkBzgLvm1n5+OfYBTSCaDDMw5Yll00YJ2IvcmrjoTHw//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059405; c=relaxed/simple;
	bh=5EQ2Y/7/FNva86+E9j6gKcmQXh6x7dP7WF5CCExJXh8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ye8a+A9SD8ropn+kNPbVt5t4m48aU0LUFKUMQjLdG0qIXB6TY36kbC0H7DjbZhkhrURHYV5/S0cAPBJ0RTTrjrwAHO+tJmhlJN10E7Y04VQXzjqfPZETx+g27n6QNNMKSd758Baaf9WKnpwhwcTBuR54IHU6KJPAVGz0MSug6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wii+txzL; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wii+txzL"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso3440799a91.3
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 16:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059402; x=1786664202; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wbY0NuQ4jmVaTb967BiKKQEFZ81rzIFWsnI6s/GLKnk=;
        b=Wii+txzLelzaKOJJOA6gpOLE3CopBg+pArw7kCtIF0L84BVM09uKlUDsy6R50IlMwp
         dT5PExfGdLxGZ3mqBgRQnanWpvY1JO8D7PbSOKemRQWuefxrcwUE69eROOcajx3owu0u
         b8G4P/jLgGEm+j68qbMUjkUylct0KuT4GEzNh98M9olXvl5L7UdFbNYggq66rPzWy5AJ
         SjJLX9Dr8TlAQ7yFGbARnfDiuwhOT/9e+gvnXdirkcjqocm+42YXk6GHyoxMuZrToL6r
         I5kYvnD/4Pe3hj1A6Cq0mSpaDFRMUA7vhtPKMnOON62dn5fedVgSEddldxsbU+5jkOAK
         t6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059402; x=1786664202;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wbY0NuQ4jmVaTb967BiKKQEFZ81rzIFWsnI6s/GLKnk=;
        b=CGhpwZF4+ZTRbTzpygnaKSLtc28h/bVJz1K+t2cUTHX55k+OvQIfgHVygIz8GOxwkM
         aiWJWMbWn/Q/stfNxEwUuOIeMn4AhoqY2+9lz818YJgABNBflJb9kEchgB7d2He9ckfh
         ziUEMHC7KkpZrpJLUYs9eY1N+f/c02A2Nj+FXQumhBROarwjLrCr5DZwGRa5/ubHZwsF
         jcELKwDohz0Oofz7X4+O7UtqGAvHJfn1wERZ705QEqOSGJJSrXO6AZnh6CfuowZj3ZR4
         yJKWcC890/CxWqnO/sACcG+sEZq76oTHPMa2NWefbCw1hGcmHcMlyKUhb+uSnzsR/rJW
         puSg==
X-Forwarded-Encrypted: i=1; AHgh+RqHItxbihjuOfSn1u5BBU4xHtPt2O2uqnTVAlrwi89ce+BUqz4+wdD0fIL9o8Lup9Gf7YE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm7IcW7LkdJ/Y+CYd0OPWMzlUrU3pS2GiF1RMQyPwjGYiYZ30G
	K5KVC0sNtrYKS9sDF7WrMgY5EpPOj2Nm6hCHSjOlmnMfUeM85yLZpRTlpXkz5ggS8bxQ5SMnctL
	q5ejw9Q==
X-Received: from pjbcv18.prod.google.com ([2002:a17:90a:fd12:b0:38e:7f2c:2c4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:264c:b0:37f:e326:6557
 with SMTP id 98e67ed59e1d1-3903c598e8amr20096574a91.4.1786059402046; Thu, 06
 Aug 2026 16:36:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:32 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-16-seanjc@google.com>
Subject: [PATCH v6 15/51] x86/tsc: Kill off x86_platform_ops.calibrate_{cpu,tsc}()
 hooks
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Now that getting the CPU and/or TSC frequencies from the hypervisor uses
dedicated hooks, drop x86_platform_ops.calibrate_{cpu,tsc}() and instead
directly invoke the correct helper at each phase of (re)calibration.  In
addition to eliminating unnecessary code, this makes it a bit more obvious
when the "late" path invokes pit_hpet_ptimer_calibrate_cpu() instead of
x86_platform_ops.calibrate_cpu().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/tsc.h      |  2 --
 arch/x86/include/asm/x86_init.h |  4 ----
 arch/x86/kernel/tsc.c           | 28 ++++++++++++----------------
 arch/x86/kernel/x86_init.c      |  2 --
 4 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index b6b86e24e1bf..c09ec485abcd 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -95,8 +95,6 @@ extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
 extern int check_tsc_unstable(void);
 extern void mark_tsc_async_resets(char *reason);
-extern unsigned long native_calibrate_cpu_early(void);
-extern unsigned long native_calibrate_tsc(void);
 extern unsigned long long native_sched_clock_from_tsc(u64 tsc);
 
 extern int tsc_clocksource_reliable;
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 0c89bf40f507..e879e6e83428 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -295,8 +295,6 @@ struct x86_hyper_runtime {
 
 /**
  * struct x86_platform_ops - platform specific runtime functions
- * @calibrate_cpu:		calibrate CPU
- * @calibrate_tsc:		calibrate TSC, if different from CPU
  * @get_wallclock:		get time from HW clock like RTC etc.
  * @set_wallclock:		set time back to HW clock
  * @iommu_shutdown:		set by an IOMMU driver for shutdown if necessary
@@ -320,8 +318,6 @@ struct x86_hyper_runtime {
  * @guest:			guest incarnations callbacks
  */
 struct x86_platform_ops {
-	unsigned long (*calibrate_cpu)(void);
-	unsigned long (*calibrate_tsc)(void);
 	void (*get_wallclock)(struct timespec64 *ts);
 	int (*set_wallclock)(const struct timespec64 *ts);
 	void (*iommu_shutdown)(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f42872c9ae99..1d41ef1db27c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -672,7 +672,7 @@ int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
  * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
  */
-unsigned long native_calibrate_tsc(void)
+static unsigned long native_calibrate_tsc(void)
 {
 	struct cpuid_tsc_info info;
 
@@ -904,7 +904,7 @@ static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
 /**
  * native_calibrate_cpu_early - can calibrate the cpu early in boot
  */
-unsigned long native_calibrate_cpu_early(void)
+static unsigned long native_calibrate_cpu_early(void)
 {
 	unsigned long flags, fast_calibrate = cpu_khz_from_cpuid();
 
@@ -918,7 +918,7 @@ unsigned long native_calibrate_cpu_early(void)
 	return fast_calibrate;
 }
 
-
+#ifndef CONFIG_SMP
 /**
  * native_calibrate_cpu - calibrate the cpu
  */
@@ -931,6 +931,7 @@ static unsigned long native_calibrate_cpu(void)
 
 	return tsc_freq;
 }
+#endif
 
 void recalibrate_cpu_khz(void)
 {
@@ -943,8 +944,8 @@ void recalibrate_cpu_khz(void)
 	if (WARN_ON_ONCE(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ)))
 		return;
 
-	cpu_khz = x86_platform.calibrate_cpu();
-	tsc_khz = x86_platform.calibrate_tsc();
+	cpu_khz = native_calibrate_cpu();
+	tsc_khz = native_calibrate_tsc();
 	if (tsc_khz == 0)
 		tsc_khz = cpu_khz;
 	else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
@@ -1458,17 +1459,19 @@ static bool __init determine_cpu_tsc_frequencies(bool early,
 	WARN_ON(cpu_khz || tsc_khz);
 
 	if (early) {
+		/*
+		 * Early CPU calibration can only use methods that are available
+		 * early in boot (obviously).
+		 */
 		if (known_cpu_khz)
 			cpu_khz = known_cpu_khz;
 		else
-			cpu_khz = x86_platform.calibrate_cpu();
+			cpu_khz = native_calibrate_cpu_early();
 		if (known_tsc_khz)
 			tsc_khz = known_tsc_khz;
 		else
-			tsc_khz = x86_platform.calibrate_tsc();
+			tsc_khz = native_calibrate_tsc();
 	} else {
-		/* We should not be here with non-native cpu calibration */
-		WARN_ON(x86_platform.calibrate_cpu != native_calibrate_cpu);
 		cpu_khz = pit_hpet_ptimer_calibrate_cpu();
 	}
 
@@ -1571,13 +1574,6 @@ void __init tsc_init(void)
 		return;
 	}
 
-	/*
-	 * native_calibrate_cpu_early can only calibrate using methods that are
-	 * available early in boot.
-	 */
-	if (x86_platform.calibrate_cpu == native_calibrate_cpu_early)
-		x86_platform.calibrate_cpu = native_calibrate_cpu;
-
 	if (!tsc_khz) {
 		/* We failed to determine frequencies earlier, try again */
 		if (!determine_cpu_tsc_frequencies(false, 0, 0)) {
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 252c5827d063..b7a48e622f48 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -147,8 +147,6 @@ static void enc_kexec_finish_noop(void) {}
 static bool is_private_mmio_noop(u64 addr) {return false; }
 
 struct x86_platform_ops x86_platform __ro_after_init = {
-	.calibrate_cpu			= native_calibrate_cpu_early,
-	.calibrate_tsc			= native_calibrate_tsc,
 	.get_wallclock			= mach_get_cmos_time,
 	.set_wallclock			= mach_set_cmos_time,
 	.iommu_shutdown			= iommu_shutdown_noop,
-- 
2.55.0.679.g6767b8d81c-goog

