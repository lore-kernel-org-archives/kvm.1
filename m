Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5874C9546
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934356; cv=none; b=moyVArB/na1py1yo5AXdwnw/5JnmAOPyghUFRdkFYwCdc434Qt65Ep4IakysGf7arywh4MAd18J6TU9YwV5fPUK8NBS8cK7VkojUo5Yg3Tp/HFJU6YMHpXXriigaga69+ymhYgfSL0ykBpUmzIGNCe6ZatzJ1gZayjJ/iG0D3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934356; c=relaxed/simple;
	bh=p5tLZkB3crC07vF32aPnSFAmwAQDDSFCr6tkFys+CMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HNCO9kgA8MMqGzH+NXTNA/Ij3g7UpPY+ybN9cG46P49iHyRnSpeZj9XQNG5ZI+v9LApmTiQsDdoYLyWgKjJSpQ6nAyWvrnrzshqkY8CGL9viuuGCfa6kciwfXjcG6G1aLMKjuZH3q2HGYUGtSKCJ30P35vgGrWsv2WKmpa3FafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hn9tEGsg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hn9tEGsg"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c9e994869aso10508095ad.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934354; x=1783539154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=evwxLM71EsC76xUKnJUsM6sZDhf4kmGP6xo/jdNLobw=;
        b=Hn9tEGsg81obPWeBySjt9n3Y/aqivac4a9GG7opEcrcdjO73D94oWJMEzYPjq7sKgZ
         egiSEepBrJCPb89Fsla+BxHujqnLcrY9W+antf9uHGsglS+BMY2hbPnvsK47XeOFw4ji
         IdhEqvi6pZQR3vDX4d+HbJbUG8V7r37a3g343+2HR1tvSA1geiccFk+1FbBVE8XFFbbv
         jHZ6O0mdWMdD6PxN5KIbAkHXwK30XRblPp74DsJTfLZN2Uvo0wJid7Xr8DOuidFJP7lo
         HW2F06uKrgcR4yJN2GZZuwx8f1aqVd6HfGzMxmDRPL3DsJouJ4AZ5AMPUgzJYkgNi6jf
         3wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934354; x=1783539154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evwxLM71EsC76xUKnJUsM6sZDhf4kmGP6xo/jdNLobw=;
        b=kcEXAEeqenj41BTPnQcxV/7hk1EyL9dag4i/C+vZuB0vh5Kc9JT/XIt6PNKlEM3Ly7
         V2FiRcWuY0sMzye25kklb8oCvJNIsgzdLfGMGnjQuHOq6NhUz5T2EJV6x/gcaFA5tscU
         sc1IFfAsLo/+n4BENUNfCyx9wfi80BGBn/pO2+32RbVXKkw193aIVgkCRtfQJu01U3j+
         dCGdDk4Q9Sc6e/vN0kShgHy6yqW09UbtedhQtHtps1BaareAK1LhMTaekN7M2Yggj+FG
         i6cWvztSctI98zBkv9NueMHvEjZPBuVFozLMCiIZIyOqYf0c7bMXLBw6M7QRzC4KXb2w
         33qA==
X-Forwarded-Encrypted: i=1; AHgh+RqrFWAIIAWQ7VNLK1dgKqUxoOhxo/+ct4+ic9Q35k+hEWsURZegxOnNppStxcIFoZgmxGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8NIbHf8r1/uk77SOAtw92EK8mvk87+nGyMhQAZD4fSDb6FeDC
	AJjgpCEkZMxN4dtVyDphx1e7ISsBobKqaI4k7Y76d9ZeBpAWbZa+ibZGJtvCHbgHtZ0xG3qHn7B
	AdysLQg==
X-Received: from plha8.prod.google.com ([2002:a17:902:ecc8:b0:2c6:a75b:2129])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:f8c:b0:2c7:d603:117f
 with SMTP id d9443c01a7336-2ca7e754b82mr34808385ad.26.1782934353608; Wed, 01
 Jul 2026 12:32:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:27 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-7-seanjc@google.com>
Subject: [PATCH v5 06/51] x86/sev: Don't override CPU frequency calibration
 for SNP's Secure TSC
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

Don't override the kernel's CPU frequency calibration routine when
registering SNP's Secure TSC calibration routine.  SNP (the architecture)
provides zero guarantees that the CPU runs at the same frequency as the
TSC.  The justification for clobbering the CPU routine was:

  Since the difference between CPU base and TSC frequency does not apply
  in this case, the same callback is being used.

but that's simply not true.  E.g. if APERF/MPERF is exposed to the VM, then
the CPU frequency absolutely does matter.

While relying on heuristics and/or the untrusted hypervisor to provide the
CPU frequency isn't ideal, it's at least not outright wrong.

Fixes: 73bbf3b0fbba ("x86/tsc: Init the TSC for Secure TSC guests")
Cc: Nikunj A Dadhania <nikunj@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ed0ac52a765e..665de1aea0ee 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2046,7 +2046,6 @@ void __init snp_secure_tsc_init(void)
 
 	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
-	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
 	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
 
 	early_memunmap(mem, PAGE_SIZE);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

