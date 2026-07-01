Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B3371D07
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 19:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934361; cv=none; b=E2s0PydPRAfJ2PzZ07jr9mt4dfIuB0jS7Mkt4Yp39wivJ7s/QA6K3tlWVQfeU2DhNLVq9ITTEAAKTybpwgzb6SY2D018aw1o4i5AElbI4KW9dm9ltDSrcZ7i7yJIkxPMNZT/W2SH65qBIOmG+6kyq3U5+9WBWOOaG5ZM4H4ETcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934361; c=relaxed/simple;
	bh=BqZrQFDYqCLPu/01WSmaD7Zj4w0fC0dOaEwcmaj4YV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yw04tRtFbCJUiAteS0w/Xdx/WqSesMBYQ9yMgXRsN1rUbPUM2dsn+UayY0sdoxb5JxqN0+1/8UNx08HA1lvGsK2euZ//9knzkxoL44vTzK4sgx+kXvNvOQUE/1iJQ8eU+URC7Drvp+Hs1amykGHeMq6isi/qzyyYz4usSoeM5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iwIIFytr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iwIIFytr"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84786d85ec2so1010355b3a.1
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934357; x=1783539157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=f4XM+SKEbnv+9fV8zEMQX/tlhGFDki//v0QnInqZVcA=;
        b=iwIIFytrdqnIVVzJvIYNwgce2pLibJ07p/p8kuYt9HtWfrNVABKlNbXbEiaGBlmumq
         65s+DjZoIePV0ZjWalLJbITSGb2QJXyw5gv4+9xm98uuj9yuqhZc1s4EOVOPtSWmhfwS
         UePzZBqiq+vRZMNnGNrMtwkaihlScP9cWgYwBQ8NTZPHu3EfbQEJOpgXILeh/7u261QY
         MUON9B1hZut9+gRNQn1VNsgpQs3xdUF6d0gnrb/6IPskCdMZZOiCtSrnoCC+jWiQLu2T
         XJ0V3j0TBcei9UgJJzQ4/zS5VeFt9R5yBurg01YKibelpxm1YawZ5y0HVIuuTgQcKzZv
         v0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934357; x=1783539157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4XM+SKEbnv+9fV8zEMQX/tlhGFDki//v0QnInqZVcA=;
        b=dz9McE7JFrbflKaTzN2IZ3/zexu7cp0Grh02O+Ilt8yQ9fn2Jkp+jILzedBnDxDuCe
         Sf9lQa647sAmRW3j8Oc2SByA0gtv455TRk4OM0CZj+fFbibHUtgJfBrn42LwuNb0tYu9
         qPJQfpNg/38+qUTt/ws0mdRMXwIQVeInKWa8qpgfph0FlXavqdiBmMNZUh9P8i99dORG
         +VAkEfmwO2oZMJVW6S7MqZ5ax6HLz0bkMzZrNS7Ui2pegIRbKtZcL1d9lPb4wH3dpQgM
         kYv6ZRhwPpyBcaEwJ9o+/qtcWQuQTmRoOaNqHjN1Jq5uPSNAFJCLHP11qxcx2I2KkgDd
         V+yw==
X-Forwarded-Encrypted: i=1; AFNElJ/QpzMNt33TAGEmgNSC2V9iVFUSZfBdotYS5p0/RYlDlBO3MO+J9I9dNigesRlcHDTfkbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEm9JIjoXEQaBqtUZKV/hiOZMURpgMfzbevxFbpIOVGChieUEA
	SSh1X8NeMHx3/wJqzvliw1BrarPfOaKYTXZP9jeWqZmiz4Q+plGLJ6BIaFIxluoMMjZyRD/Uhwf
	U0tHluw==
X-Received: from pgge10.prod.google.com ([2002:a63:db0a:0:b0:c8c:b193:3b13])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a104:b0:3bf:6c08:fb81
 with SMTP id adf61e73a8af0-3bfed44c700mr3262662637.49.1782934356969; Wed, 01
 Jul 2026 12:32:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:30 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-10-seanjc@google.com>
Subject: [PATCH v5 09/51] x86/tsc: Add a standalone helper for getting TSC
 info from CPUID.0x15
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Extract retrieval of TSC frequency information from CPUID into a standalone
helper so that TDX guest support can reuse the logic.

Opportunistically drop native_calibrate_tsc()'s "== 0" and "!= 0" checks
in favor of the kernel's preferred style.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 61 +++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f049c126e47c..12043812c8f5 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -645,46 +645,62 @@ static unsigned long quick_pit_calibrate(void)
 	return delta;
 }
 
+struct cpuid_tsc_info {
+	unsigned int denominator;
+	unsigned int numerator;
+	unsigned int crystal_khz;
+};
+
+static int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
+{
+	unsigned int ecx_hz, edx;
+
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
+		return -ENOENT;
+
+	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
+	cpuid(CPUID_LEAF_TSC, &info->denominator, &info->numerator, &ecx_hz, &edx);
+
+	if (!info->denominator || !info->numerator)
+		return -ENOENT;
+
+	/*
+	 * Note: some CPUs provide the multiplier information, but not the core
+	 * crystal frequency.  The multiplier information is still useful for
+	 * such CPUs, as the crystal frequency can be gleaned from CPUID.0x16.
+	 */
+	info->crystal_khz = ecx_hz / 1000;
+	return 0;
+}
+
 /**
  * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
  */
 unsigned long native_calibrate_tsc(void)
 {
-	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
-	unsigned int crystal_khz;
+	struct cpuid_tsc_info info;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
+	if (cpuid_get_tsc_info(&info))
 		return 0;
 
-	eax_denominator = ebx_numerator = ecx_hz = edx = 0;
-
-	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
-	cpuid(CPUID_LEAF_TSC, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
-
-	if (ebx_numerator == 0 || eax_denominator == 0)
-		return 0;
-
-	crystal_khz = ecx_hz / 1000;
-
 	/*
 	 * Denverton SoCs don't report crystal clock, and also don't support
 	 * CPUID_LEAF_FREQ for the calculation below, so hardcode the 25MHz
 	 * crystal clock.
 	 */
-	if (crystal_khz == 0 &&
-			boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
-		crystal_khz = 25000;
+	if (!info.crystal_khz && boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
+		info.crystal_khz = 25000;
 
 	/*
 	 * TSC frequency reported directly by CPUID is a "hardware reported"
 	 * frequency and is the most accurate one so far we have. This
 	 * is considered a known frequency.
 	 */
-	if (crystal_khz != 0)
+	if (info.crystal_khz)
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 
 	/*
@@ -692,15 +708,14 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
+	if (!info.crystal_khz && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
 		unsigned int eax_base_mhz, ebx, ecx, edx;
 
 		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
-		crystal_khz = eax_base_mhz * 1000 *
-			eax_denominator / ebx_numerator;
+		info.crystal_khz = eax_base_mhz * 1000 * info.denominator / info.numerator;
 	}
 
-	if (crystal_khz == 0)
+	if (!info.crystal_khz)
 		return 0;
 
 	/*
@@ -716,9 +731,9 @@ unsigned long native_calibrate_tsc(void)
 	 * lapic_timer_period here to avoid having to calibrate the APIC
 	 * timer later.
 	 */
-	apic_set_timer_period_khz(crystal_khz, "CPUID 0x15/0x16");
+	apic_set_timer_period_khz(info.crystal_khz, "CPUID 0x15/0x16");
 
-	return crystal_khz * ebx_numerator / eax_denominator;
+	return info.crystal_khz * info.numerator / info.denominator;
 }
 
 static unsigned long cpu_khz_from_cpuid(void)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

