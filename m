Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF773F5BD3
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065908; cv=none; b=Q/GWoC1L621URf42nsh573VdKI73fgpeL4j4poHaSsTMOsKAnYloNK4/S2JOEi9ZMzAL7+q1NWsGCwm7KLeyYDrQUGD3sLDIwJ/m/858f+aOGCIx/zrQka2U3nPLTCzNok7s1UqFnhFcCiBUGac6p3QHoZNx5MZqfT3BwBbxuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065908; c=relaxed/simple;
	bh=RKwWhqVrOQPM1dUBpPmXNW9Ctazo079sf1ULKHAbSWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DAckteXUDzK+Wsl/qgOk2d5mlOI2wlKQ7/flicZK5ZMQKB5jjdCs5aCI4nuM8tuhxmqdPEDqdHLRoToSM6OBdvjYn0IX52g8YsRkLIOCcaLTVJ+EgXEBi00BskjYfRVLlcCZ0FKZ2bQ8Eo5b6lI2paHw6gS80gTblmsmf57dwBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YkV1NK4s; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YkV1NK4s"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b934a336eso1414364a91.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065905; x=1780670705; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nNJLu7do7nPWUZaqv5wFSjm3is+mcIorKyFYEzca5zQ=;
        b=YkV1NK4swRSLQaJ1MnLwQmoRldU7WJ/scHBGJ+ulCyUtszFUUNrNxjUMhmFMr46NBb
         yewkwmQaBjQwRPvHDQn4rjNIV377UQpEDaG5xaLPasidXNbBWkPdtMOXBiE7Gros24zW
         6M5uPAJfoxWcam8/A1j5OqH75HcoeugjY4Sh4cP8ZHwf9Yj52E5PoozusB73H3otFQqo
         3XUfc/2eZ+DAq42a2tEZIxNkY1vJWxeJ1hnd9Rcq4bOATYdJvchU1BpN00R/QGE6XSmx
         Nc7bLYp2VZ4IaGCu6XDvuTUTOWlcx9pxsE5pWt7VoVo99HUqOmPxhwwvEw+mrhzKhInZ
         1TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065905; x=1780670705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNJLu7do7nPWUZaqv5wFSjm3is+mcIorKyFYEzca5zQ=;
        b=S8iBVCCsvk9iWqwHA2mmMSgtm6ER08vsvqBsuYmVINBxeEBxSU3XEN3y9GgsBSkZKo
         jZJi/Ex6DgbjeHq900xOJBjlQkVo0027BvKopJLxQ8fpWFrb7hRvxNZHJWab9jZIKa+O
         lWCzsakXO6CfWM/FqqHyaXaCe92iddnQxuDJdmTHNxqp7bpvXmvdX2xKsTSQ/sGiocEX
         dNadXrJkPIBIbsX2WTZhivfEt0G1oW9XAKemU/SY0hMbgg7dnQoldur5t92TxVm/h40J
         8KyzF6JoQudAholp1SuUNAaA3rekRFEKhNTfn6CfRj4MsD49acGBnQfA1ncFJnOg8Txl
         T8Mg==
X-Forwarded-Encrypted: i=1; AFNElJ9B5Xh+3ys8i396keruJebVvYK0+lpeGmM8AbyvAwPLT7AomgIS+aWXYcUB0nOyXshJCn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5asAu8apiqR/XbNE9gG+InOvP5z81Pxgjs0tUjhzbS1KCEXBH
	/h+Tpzt0Y1cV7ahLMWXUoSo/G5ocgRXG3x6gehgV24RTjs0x6bVXFzQIW18+Zdj/ut6GWCq2+4u
	lq/a7kw==
X-Received: from pjqx13.prod.google.com ([2002:a17:90a:b00d:b0:36b:a7c4:95be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2681:b0:368:6998:b4a9
 with SMTP id 98e67ed59e1d1-36bbcc14546mr3878407a91.11.1780065904236; Fri, 29
 May 2026 07:45:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:58 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-12-seanjc@google.com>
Subject: [PATCH v4 11/47] x86/tsc: Kill off x86_platform_ops.calibrate_{cpu,tsc}()
 hooks
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
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
index 6cf26e62e9a6..4a224f99c3b9 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -97,8 +97,6 @@ extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
 extern int check_tsc_unstable(void);
 extern void mark_tsc_async_resets(char *reason);
-extern unsigned long native_calibrate_cpu_early(void);
-extern unsigned long native_calibrate_tsc(void);
 extern unsigned long long native_sched_clock_from_tsc(u64 tsc);
 
 extern int tsc_clocksource_reliable;
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index a4f8a4aa601d..ada17827ea51 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -292,8 +292,6 @@ struct x86_hyper_runtime {
 
 /**
  * struct x86_platform_ops - platform specific runtime functions
- * @calibrate_cpu:		calibrate CPU
- * @calibrate_tsc:		calibrate TSC, if different from CPU
  * @get_wallclock:		get time from HW clock like RTC etc.
  * @set_wallclock:		set time back to HW clock
  * @iommu_shutdown:		set by an IOMMU driver for shutdown if necessary
@@ -317,8 +315,6 @@ struct x86_hyper_runtime {
  * @guest:			guest incarnations callbacks
  */
 struct x86_platform_ops {
-	unsigned long (*calibrate_cpu)(void);
-	unsigned long (*calibrate_tsc)(void);
 	void (*get_wallclock)(struct timespec64 *ts);
 	int (*set_wallclock)(const struct timespec64 *ts);
 	void (*iommu_shutdown)(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 8cef918486db..5b4b6e43c94c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -696,7 +696,7 @@ int __init cpuid_get_tsc_freq(struct cpuid_tsc_info *info)
  * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
  */
-unsigned long native_calibrate_tsc(void)
+static unsigned long native_calibrate_tsc(void)
 {
 	struct cpuid_tsc_info info;
 
@@ -931,7 +931,7 @@ static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
 /**
  * native_calibrate_cpu_early - can calibrate the cpu early in boot
  */
-unsigned long native_calibrate_cpu_early(void)
+static unsigned long native_calibrate_cpu_early(void)
 {
 	unsigned long flags, fast_calibrate = cpu_khz_from_cpuid();
 
@@ -945,7 +945,7 @@ unsigned long native_calibrate_cpu_early(void)
 	return fast_calibrate;
 }
 
-
+#ifndef CONFIG_SMP
 /**
  * native_calibrate_cpu - calibrate the cpu
  */
@@ -958,6 +958,7 @@ static unsigned long native_calibrate_cpu(void)
 
 	return tsc_freq;
 }
+#endif
 
 void recalibrate_cpu_khz(void)
 {
@@ -967,9 +968,9 @@ void recalibrate_cpu_khz(void)
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
 
-	cpu_khz = x86_platform.calibrate_cpu();
+	cpu_khz = native_calibrate_cpu();
 	if (!boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ))
-		tsc_khz = x86_platform.calibrate_tsc();
+		tsc_khz = native_calibrate_tsc();
 	if (tsc_khz == 0)
 		tsc_khz = cpu_khz;
 	else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
@@ -1483,17 +1484,19 @@ static bool __init determine_cpu_tsc_frequencies(bool early,
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
 
@@ -1590,13 +1593,6 @@ void __init tsc_init(void)
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
index ebefb77c37bb..c674cbbd466d 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -144,8 +144,6 @@ static void enc_kexec_finish_noop(void) {}
 static bool is_private_mmio_noop(u64 addr) {return false; }
 
 struct x86_platform_ops x86_platform __ro_after_init = {
-	.calibrate_cpu			= native_calibrate_cpu_early,
-	.calibrate_tsc			= native_calibrate_tsc,
 	.get_wallclock			= mach_get_cmos_time,
 	.set_wallclock			= mach_set_cmos_time,
 	.iommu_shutdown			= iommu_shutdown_noop,
-- 
2.54.0.823.g6e5bcc1fc9-goog

