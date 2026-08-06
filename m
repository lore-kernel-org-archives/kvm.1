Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB7422530
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059392; cv=none; b=JhF/uI2r+oDBvJeXXe9wJT4GUk+oH6jESUh26PXDfeJ6Eaa3a2B11H85pdmW8W9amvtKKx0Ffj9zyB1pmssm3aJv52yqUF7n/Lh8KggkILLYihXuA3G2IdYdfIZ+3nyxznN7bIcZ/V4FoYvO3k1AWKAPbQP1FX4A/mWc+EegFro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059392; c=relaxed/simple;
	bh=ovqgLwzv9GptZQJnSNvVW0VhM2ENGfkbKgdGmBqtAeI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ckALn00KfDmfbQY2f/rW4iRS+RMVCTQoQYxEVwTSOFNOWR6JAI9aQxNgcmTB6SQq6P11yJUer0gwjPy1Ug7zVgMUXgzTjDjP+ePnguE+R7sEIruL140BI+wINmbwunmGpBYZ9XJmUMDXkoEjwODO74buhjRHmjyRdASLlKxZnyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1m0d6uf; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1m0d6uf"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484ba00601so3362580b3a.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059386; x=1786664186; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lGVITa15iYf7ywTb6PznrnwE5mV86GVcr9KZACd8UjM=;
        b=Y1m0d6ufJixeCfvrGR9+G5GcsnNNjDZPuazE11YFqFiTxZHWjXHBnIvnDU6yW1WRAW
         qNqkNBPxfiNdurCvJSOunnHl35KeSlNkOKG2Oxu7MLPk6lv0bcKaDWk8FHQtJGD+8lW4
         bBaGLbA8QYW5lSuyW4pLGG16R0bEml4hoU7Plhz4KygmRBJ5L3tqAnQ8hMTvaE84hQAN
         2ez5Tpa7WJEO/I0OCngKpl1R7ZvqbZ9ScQS+4azsj1Vfs7WN1Vd65r905Mi7qAd+83LV
         wyR5rEFWMTGKm31qNcHKpXGRilVitN5MM6dLPuKqdR9z8nQ9RJzl15rI7Nj30EHFMbhE
         gwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059386; x=1786664186;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lGVITa15iYf7ywTb6PznrnwE5mV86GVcr9KZACd8UjM=;
        b=VzQdR7DrS2LjVQfw5jJs+N7PeJGDYvZEeyLFTbkwnlSJbSbfUr17JTTV3F1dnjMa5V
         0q6jA6Lxpj71MYlvbG/Nbns/RQ3uZfyNflPNsa+v89EG3wDn2Av9uYXj9eP11Zld0LAp
         35AjqkpfAUDA8ajGdwQ2MQM+KN1AnY4pjzqaTDfY0vrLKq2sWYVrxa+MSF4GEC29kU/H
         whLTcqMY8gsyOusK9Xt9ktZgiIlVMRwK03QO9zI0L5DAlhmvLX3YUs8veXtt6zL+lBN8
         8nKBBWEjBRHWBTsnmG9yUJF9pmOTW69L3X2+zx6Nqztc5CNOMhVXsZ0YjjhQv0cgdjOn
         XaEA==
X-Forwarded-Encrypted: i=1; AHgh+RpDS9QSnzX1E+qvtgLr39CZrtapcf2eJCb0gc2B13tIuBmIZa/6EdZgl6mFQlJKs6CX+SM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw81Uq+CKNOE0CFBlnjWYJyGQD8xpQSegJZLg9uYqdM8LscxNap
	r6znUBgePjlk8d0DzTUhwMNh43xsBqTle5KFoyjxXxtXqTY6QkGW7nMaQbURTP/f0Dg1QWWxNHN
	nBqi0/g==
X-Received: from pgnc18.prod.google.com ([2002:a63:7252:0:b0:c9e:6c82:64e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1310:b0:84e:216d:7e52
 with SMTP id d2e1a72fcca58-84f2e03175emr20642138b3a.14.1786059385989; Thu, 06
 Aug 2026 16:36:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:19 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-3-seanjc@google.com>
Subject: [PATCH v6 02/51] x86/apic: Add CONFIG_X86_LOCAL_APIC=n stubs for APIC
 timer frequency APIs
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

Add stubs for the apic_set_timer_frequency_{,k}hz() APIs when the kernel is
built without support for a local APIC, and drop #ifdefs in callers that
don't need to check CONFIG_X86_LOCAL_APIC for other reasons.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/apic.h  | 2 ++
 arch/x86/kernel/cpu/vmware.c | 2 --
 arch/x86/kernel/tsc.c        | 2 --
 arch/x86/kernel/tsc_msr.c    | 2 --
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 6946220a6008..9c5084f3317f 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -189,6 +189,8 @@ static inline void disable_local_APIC(void) { }
 # define setup_boot_APIC_clock x86_init_noop
 # define setup_secondary_APIC_clock x86_init_noop
 static inline void lapic_update_tsc_freq(void) { }
+static inline void apic_set_timer_frequency_hz(u64 freq_hz, const char *source) { }
+static inline void apic_set_timer_frequency_khz(u64 freq_khz, const char *source) { }
 static inline void init_bsp_APIC(void) { }
 static inline void apic_intr_mode_select(void) { }
 static inline void apic_intr_mode_init(void) { }
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 22842bf5b59e..2225df67d45f 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -422,10 +422,8 @@ static void __init vmware_platform_setup(void)
 		x86_platform.calibrate_tsc = vmware_get_tsc_khz;
 		x86_platform.calibrate_cpu = vmware_get_tsc_khz;
 
-#ifdef CONFIG_X86_LOCAL_APIC
 		/* Skip lapic calibration since we know the bus frequency. */
 		apic_set_timer_frequency_hz(ecx, "VMware hypervisor");
-#endif
 	} else {
 		pr_warn("Failed to get TSC freq from the hypervisor\n");
 	}
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 63e26805f8dd..4392fddd616e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -710,7 +710,6 @@ unsigned long native_calibrate_tsc(void)
 	if (boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
-#ifdef CONFIG_X86_LOCAL_APIC
 	/*
 	 * The local APIC appears to be fed by the core crystal clock
 	 * (which sounds entirely sensible). We can set the global
@@ -718,7 +717,6 @@ unsigned long native_calibrate_tsc(void)
 	 * timer later.
 	 */
 	apic_set_timer_frequency_khz(crystal_khz, "CPUID 0x15/0x16");
-#endif
 
 	return crystal_khz * ebx_numerator / eax_denominator;
 }
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 4bd5f2ae656b..179e3a331ef9 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -211,9 +211,7 @@ unsigned long cpu_khz_from_msr(void)
 	if (freq == 0)
 		pr_err("Error MSR_FSB_FREQ index %d is unknown\n", index);
 
-#ifdef CONFIG_X86_LOCAL_APIC
 	apic_set_timer_frequency_khz(freq, "MSR_FSB_FREQ");
-#endif
 
 	/*
 	 * TSC frequency determined by MSR is always considered "known"
-- 
2.55.0.679.g6767b8d81c-goog

