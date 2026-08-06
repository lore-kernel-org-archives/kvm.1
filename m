Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D024931E2
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059402; cv=none; b=kIyrPzFk/cgkgI5Z9N3vnE7vL76fEJ+RNpq3T5fAntkgyJw9b7M72LdckkZld3lsAflpXsd+HC/wVexh3JUMXvOi3anWN5q2f0e2NgSPYOgsgKnyeG++CiMs65Va6atgATHUxlD6SwWUSlC0eqXzuhH/FdmXETWcqQrYIOP7QcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059402; c=relaxed/simple;
	bh=kNb3vvgtLbRH7N/DprLb1mmCclzI0d/ujF+Or08Q6XI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JTcQEnAAliVBzewLBAlalR7s+aOmBz6BFvQizZdqv6cCGe1vXSLA0uJWeRyjGsjQUockXeJnul56L26zR2ES4lf8YpxXaYzatoGat9RDt7FvEM25FAJJXJJzWwySUEesredGe+pYXfOOFr+Gf32WvEgeNtJaTNl+pO5e98R9xwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZF2Ukkqd; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZF2Ukkqd"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so5940738a91.2
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 16:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059399; x=1786664199; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yV4aOROKwLK4YUA2A0rPmI+8Xp1hkN/OxQzRiMqFKuI=;
        b=ZF2Ukkqd3umSY9eABbgOdeiNs5Foc92GSZ4cnzVJB7XoRxtMpjgraQ7/g1nlLF8ftw
         Xs/4yzafrN3MwoL8Lsa1b07NHrVjJ/FmZ1xvFxZsLMxQIQMk4uZa/Rcs5BRDJW1UipTJ
         y0Zpq7AAx+S5cwmAz27YAD+A8XgWMva1Kq5npzOuWksEILOqkDSapQlCbZaKgnddPfRP
         XKg6AvfcfvTH1KhVTOgtnwGA6bpYdXN2ZhevxVOPQNDNCk3cQ0eSe2m/4y0m8m01355r
         PCyumVeC8sEl4I5sEvWffI9u5FkvNx0+sWSj0s9US7KL9gLNqW2ha3zVisicX4l49o+P
         6jaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059399; x=1786664199;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yV4aOROKwLK4YUA2A0rPmI+8Xp1hkN/OxQzRiMqFKuI=;
        b=Uf1t7AGwNpRvQ2bfQUQV6XQvtt9jhLeLc19dApwoh2YkcEOEl9/c4t9hNLOQi4i4C5
         74va0YO4q7hB/K032QbabFkEhL2RUTdS3w+K366VBMk0efaN1a/6igG2OC0JgCPli/K/
         Od5e4U5bZWSTEPs+UgmdYk6aiXsfRa7icCdiM7mRU7pd73z3CUTnjtH67V9IQoD5MN5R
         xfM4JMRRn3o8u6EWlgr65VLsUmUf5etmXKCE0fOG0cUUQqq/OGGattxwdOguQwMW/Y8m
         HTrco0jrIhGO5nxd8fPypcOyEVh1g6xMi78HiQCT0FqLjEqRBUWd2Bghn7+4RRgH9p+y
         fidg==
X-Forwarded-Encrypted: i=1; AHgh+RpnLc7m/u0th88piKu0MQvRkm1LBnt3QLiHCH33IOM9rmreBUUtD+uLXjnkn3vP9dVQ3l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKA5JtO4yeCocr5L4P1Tfd1FAEb/UJpujVclYrxxFx4vP/pkod
	rQhCU/ydzE/rEbVu6g3lcCSzABHcq6t3f0FU+EXyi67mfAFbq6Vqk4vQSp4QCL+iTq3n3jzHiyb
	ZdyF3TQ==
X-Received: from pjbqa7.prod.google.com ([2002:a17:90b:4fc7:b0:38e:bbd1:f3c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c88e:b0:38e:488f:7068
 with SMTP id 98e67ed59e1d1-3903c5373b4mr20563002a91.2.1786059398528; Thu, 06
 Aug 2026 16:36:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:29 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-13-seanjc@google.com>
Subject: [PATCH v6 12/51] x86/acrn: Register TSC/CPU frequency callbacks iff
 frequency is actually in CPUID
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

Register ACRN's TSC/CPU frequency overrides if and only if the exact TSC
frequency is actually provided in CPUID.  This will allow marking the TSC
as reliable as appropriate, and avoids relying on the caller to handle
"failure".

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/acrn.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index ad8f2da8003b..dc71a6fdd461 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -19,6 +19,8 @@
 #include <asm/idtentry.h>
 #include <asm/irq_regs.h>
 
+static unsigned int acrn_tsc_khz_cpuid __initdata;
+
 static u32 __init acrn_detect(void)
 {
 	return acrn_cpuid_base();
@@ -26,13 +28,19 @@ static u32 __init acrn_detect(void)
 
 static unsigned int __init acrn_get_tsc_khz(void)
 {
-	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
+	return acrn_tsc_khz_cpuid;
 }
 
 static void __init acrn_init_platform(void)
 {
 	/* Install system interrupt handler for ACRN hypervisor callback */
 	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
+
+	acrn_tsc_khz_cpuid = cpuid_eax(ACRN_CPUID_TIMING_INFO);
+	if (acrn_tsc_khz_cpuid) {
+		x86_init.hyper.get_tsc_khz = acrn_get_tsc_khz;
+		x86_init.hyper.get_cpu_khz = acrn_get_tsc_khz;
+	}
 }
 
 static bool acrn_x2apic_available(void)
@@ -80,6 +88,4 @@ const __initconst struct hypervisor_x86 x86_hyper_acrn = {
 	.type			= X86_HYPER_ACRN,
 	.init.init_platform     = acrn_init_platform,
 	.init.x2apic_available  = acrn_x2apic_available,
-	.init.get_tsc_khz	= acrn_get_tsc_khz,
-	.init.get_cpu_khz	= acrn_get_tsc_khz,
 };
-- 
2.55.0.679.g6767b8d81c-goog

