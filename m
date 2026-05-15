Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F65386C3E
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872875; cv=none; b=KWXsXtAPaQuTlXCKlX+C1JFMkebzT4QMF01SNG20tK+SoqQdmcZqWx9vrz6JGfJ3w2WSlDxve8ML0h+pjJReHV8rmpg1Sc2B8WS84RaimlIi6GrudNr+eWfHpv06w494UbfbujTMqbKhjAn4ju2jvOHG9Z8jMrI2NrCRbPqf0+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872875; c=relaxed/simple;
	bh=oS9aSnkApcPsOGR1rkhF7MOLa9irLvbbIXlzkW7Bx9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N8ivWcrOX8YHreiOKiF1BFwvRtHCfl+fkpSo34fXs65ol0N+CpVhZjGVXNCHdOKetbYtLqMMU2up/cxa23Ftp+oDHt65AeowsOOVoJu0RCGCFiaJ7oXaB6kqRIFk3rzQ3olYU/5P7AN4KttlWHVINEyiQ9UePxnpxv83QUR0LWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HOQx/5IZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOQx/5IZ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365d4d2fa04so71966a91.3
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872872; x=1779477672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=POYAFJXhX15R3hmqAgfLZg3VsZ+0XFpd3jcwWXWllKs=;
        b=HOQx/5IZYerJC/WWeKC/Kkn6AjpugGAFhcEItpV+2mgON5Bqe8mkDlWs+nCRb2vhKr
         vwySmDj0B+x+ot6ih6EsjmEQG4yHhH8qWi0FI9wUed51CG6Gdm9XR7ZMkEXdyJzCaY8Z
         a1TKMv3bwfscaN1AtLvp38p1QsqDTT5TtWeHaaHPpzUSM0fcfEmVIklwDYFfDkLzCBfe
         75B6ASkGLw2rFzGkY+ctcOzeej4xIFifFHeyyPlhWxscy0+bPlf2YrlJqAVDIxBlJES0
         DHC/CVcg8bI/x9JTnyqExWxlQt+eAmUqPVm8CSdrw1Lh6AVoagF9XouAhCNCLGvR1iSZ
         b8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872872; x=1779477672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POYAFJXhX15R3hmqAgfLZg3VsZ+0XFpd3jcwWXWllKs=;
        b=VstYpM9qUvLLnPZvwuTncNUWg8DvZp9UfkftHW/BEUCHUXLGmYDPkmc+L0P6q0K77e
         kf1DPIQtV736wW0j+/kRDC4LizM4E2HWVUE4PbX4K0VLlAGaQecL1SELle2qJA8IR7ha
         oooiULLWXRd9cUJWtfdo5Dmj3NY77g5pEEwYs6EyXIaTm/fjmrBSx2Z1J7dEqG8EjTPS
         nKEEt48ECDbLuEvG1xMYhjvzXPYdLx/8mkCDcGECQJTkjupCg0xRQYKw96iPamm3L9xh
         pe0ZJt5eDDEPrJWPneiIgwAL2Dk7JEwccc2eqPkvv2WtIKUywT56eDM/gaKVvB1XFwia
         L7gQ==
X-Forwarded-Encrypted: i=1; AFNElJ/G3zvOoCQsjIr5HvdpXZ3fpFWQmvRn/bSBZsT0igCzACDGwphOg3nb6tngAMwponGR7Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhuSIjyZvCGrMSvo7P75BEQ7RmSZnScx9m5ys8elemIwAd/mw
	axyU5nVo4bb/Rn+3pfD6mG5az9zjvrlO9LrHR8zVEbKE+f8tv6R6y30vl7bq2m8yG07nzJYyDfJ
	BW4W4nA==
X-Received: from pgla17.prod.google.com ([2002:a63:b51:0:b0:c82:2e5b:8f33])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3505:b0:364:edd2:812
 with SMTP id 98e67ed59e1d1-36951cb3086mr5037302a91.25.1778872872299; Fri, 15
 May 2026 12:21:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:34 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-34-seanjc@google.com>
Subject: [PATCH v3 33/41] x86/kvmclock: Mark TSC as reliable when it's
 constant and nonstop
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Mark the TSC as reliable if the hypervisor (KVM) has enumerated the TSC
as constant and nonstop, and the admin hasn't explicitly marked the TSC
as unstable.  Like most (all?) virtualization setups, any secondary
clocksource that's used as a watchdog is guaranteed to be less reliable
than a constant, nonstop TSC, as all clocksources the kernel uses as a
watchdog are all but guaranteed to be emulated when running as a KVM
guest.  I.e. any observed discrepancies between the TSC and watchdog will
be due to jitter in the watchdog.

This is especially true for KVM, as the watchdog clocksource is usually
emulated in host userspace, i.e. reading the clock incurs a roundtrip
cost of thousands of cycles.

Marking the TSC reliable addresses a flaw where the TSC will occasionally
be marked unstable if the host is under moderate/heavy load.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index b6b2018c51db..47f7df1e81a0 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -363,6 +363,7 @@ static __init void kvm_sched_clock_init(bool stable)
 
 void __init kvmclock_init(void)
 {
+	enum tsc_properties tsc_properties = TSC_FREQUENCY_KNOWN;
 	bool stable = false;
 
 	if (!kvm_para_available() || !kvmclock)
@@ -401,18 +402,6 @@ void __init kvmclock_init(void)
 			 PVCLOCK_TSC_STABLE_BIT;
 	}
 
-	kvm_sched_clock_init(stable);
-
-	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
-					  TSC_FREQUENCY_KNOWN);
-
-	x86_platform.get_wallclock = kvm_get_wallclock;
-	x86_platform.set_wallclock = kvm_set_wallclock;
-#ifdef CONFIG_SMP
-	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
-#endif
-	kvm_get_preset_lpj();
-
 	/*
 	 * X86_FEATURE_NONSTOP_TSC is TSC runs at constant rate
 	 * with P/T states and does not stop in deep C-states.
@@ -423,8 +412,22 @@ void __init kvmclock_init(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
-	    !check_tsc_unstable())
+	    !check_tsc_unstable()) {
 		kvm_clock.rating = 299;
+		tsc_properties = TSC_FREQ_KNOWN_AND_RELIABLE;
+	}
+
+	kvm_sched_clock_init(stable);
+
+	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
+					  tsc_properties);
+
+	x86_platform.get_wallclock = kvm_get_wallclock;
+	x86_platform.set_wallclock = kvm_set_wallclock;
+#ifdef CONFIG_SMP
+	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
+#endif
+	kvm_get_preset_lpj();
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
 	pv_info.name = "KVM";
-- 
2.54.0.563.g4f69b47b94-goog

