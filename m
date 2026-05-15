Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865B4033E8
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872886; cv=none; b=me9vMAPssyky8etmAKjDWkHmLnLj4VhYs43HcWTzEDTNUtFFhXu5U0gKCVEO13U420ueM/k/eQb63o/0d+O6U+hXxlWlWdaoNIbDecSRMNUhNIM5s1lmXsiQFiqNxAQw8rbB1QSDDBlqUku1/c/v+rdYSxjObtkgv1+NPFITJ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872886; c=relaxed/simple;
	bh=FAuTHtAqfIjKZiW/8ebxRcA6f3m9NrH7uZUAhFreD6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nec714/OC4rkI8UqZ3v7gULTXeate5QOBzg7TF3Y4b2GkihkE2stInLl5jO+10DKtzLJUxpbyTVIsl7CTDAMX0rW1U35jwzQY2lOkcDN6HQ6PTulij4EdnCgAdm/aXuFW/0JQXRWZseSVjAXkyhHCW5CJt5Up+3e3VvL4L4GDAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LvrbrJH9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LvrbrJH9"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so296444b3a.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872883; x=1779477683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cGLSRPI8RMv865ATBw7wYYFL1PB8rGFTI0lK6a8u9vM=;
        b=LvrbrJH94vhQ6HA2qmxkxxXJ/QN2Dw0//whyTF6hOG0f9Is6tgL31c3w7RLGKF+K1M
         JmzLVPzlkPDt2MIOEMZNqUMcebW9IMXDQqOdykZeflTp56RXPVyiHJmybf8nVlARZ6rN
         F5LmNRtKIcF0vsz0mI5i+YnddiFoN+L3AzgbUMfiFUcUlTbgab2AGRsxPcLU8z6etKTk
         Tf4tqQk6bmX2yu4u1/1cRqdwrEAoweNCd0+FMK0DO0QRvEjEy3IwwROFYvmsJ5wOifoD
         oRV49fLytlfJ9/kjdp7HjfAeqteaGAIMF2PG1HN/DFh/qolrVKPVU9IgjJXKA6xfuBcr
         rhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872883; x=1779477683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGLSRPI8RMv865ATBw7wYYFL1PB8rGFTI0lK6a8u9vM=;
        b=XDB6/ZQjMtIbHh3QxqasbHgKEiFAv8H4qNAzWq2Ce4VqzSCiNUDK6ARdpaZ6fy+F+r
         qAZVhiIgjm7PThc+oDafpCK2y9yP9SorVDL0kxLSLA82RbWCGdm5jgEaNWawu7jG30Wf
         lODnYq1z7nZYNDAjNAsjyz18HHdMXyI0pf8/6sz/AM0IXPhMyhK3WkxrbgOa7Cz6ZR+h
         Ks3EBUxfq04UNjWySK85MiUgc93YAvn6Zd11qxk6DO9bUOLrTHx4EoyRESPPv5N84REc
         EVvlHyTn6eUr35lSIb8yxj3LpXZyII8cPlEpRzutRGv/OX0xRjE9cnN2c1QZy5iqCrDD
         CyRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9B1TQYNokUqEezAfGFFOIJZS7V1sgN/HJHQckVn7XdpiqWKiDjqmY5NHIy6opDQ2Rhm4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwomSQofMxhRvcaGZgEaENj5GAdxNBkSfbNPvsRE5t6b5vrOMbV
	dJiT6y0qwMWGvSreT1Qun7ZNfUE7v5hpHDUK9rWUD3NtEV57i1cfeOwMNPjGMhNElz515Kic1WV
	zwdFo4g==
X-Received: from pfdc18.prod.google.com ([2002:aa7:8c12:0:b0:834:df9e:8e02])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:194f:b0:82f:355a:857e
 with SMTP id d2e1a72fcca58-83f33d0398emr5462972b3a.47.1778872883144; Fri, 15
 May 2026 12:21:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:41 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-41-seanjc@google.com>
Subject: [PATCH v3 40/41] x86/tsc: Add standalone helper for getting CPU
 frequency from CPUID
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

Extract the guts of cpu_khz_from_cpuid() to a standalone helper that
doesn't restrict the usage to Intel CPUs.  This will allow sharing the
core logic with kvmclock, as (a) CPUID.0x16 may be enumerated alongside
kvmclock, and (b) KVM generally doesn't restrict CPUID based on vendor.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/tsc.h |  1 +
 arch/x86/kernel/tsc.c      | 37 +++++++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index f458be688512..c145f5707b52 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -91,6 +91,7 @@ struct cpuid_tsc_info {
 };
 extern int cpuid_get_tsc_info(struct cpuid_tsc_info *info);
 extern int cpuid_get_tsc_freq(struct cpuid_tsc_info *info);
+extern int cpuid_get_cpu_freq(unsigned int *cpu_khz);
 
 extern void tsc_early_init(void);
 extern void tsc_init(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 1b569954ae5e..745fa2052c74 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -719,6 +719,24 @@ int cpuid_get_tsc_freq(struct cpuid_tsc_info *info)
 	return 0;
 }
 
+int cpuid_get_cpu_freq(unsigned int *cpu_khz)
+{
+	unsigned int eax_base_mhz, ebx, ecx, edx;
+
+	*cpu_khz = 0;
+
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
+		return -ENOENT;
+
+	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
+
+	if (!eax_base_mhz)
+		return -ENOENT;
+
+	*cpu_khz = eax_base_mhz * 1000;
+	return 0;
+}
+
 /**
  * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
@@ -754,13 +772,8 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (!info.crystal_khz && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
-		unsigned int eax_base_mhz, ebx, ecx, edx;
-
-		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
-		info.crystal_khz = eax_base_mhz * 1000 *
-			info.denominator / info.numerator;
-	}
+	if (!info.crystal_khz && !cpuid_get_cpu_freq(&cpu_khz))
+		info.crystal_khz = cpu_khz * info.denominator / info.numerator;
 
 	if (!info.crystal_khz)
 		return 0;
@@ -787,19 +800,15 @@ unsigned long native_calibrate_tsc(void)
 
 static unsigned long cpu_khz_from_cpuid(void)
 {
-	unsigned int eax_base_mhz, ebx_max_mhz, ecx_bus_mhz, edx;
+	unsigned int cpu_khz;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
+	if (cpuid_get_cpu_freq(&cpu_khz))
 		return 0;
 
-	eax_base_mhz = ebx_max_mhz = ecx_bus_mhz = edx = 0;
-
-	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
-
-	return eax_base_mhz * 1000;
+	return cpu_khz;
 }
 
 /*
-- 
2.54.0.563.g4f69b47b94-goog

