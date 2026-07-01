Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9144D2ED9
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934355; cv=none; b=JoOGMqNHE2L08ELLcviNPdR1B8iR+1XmF3nuL8l+SRnmoqVXlNO8nyBk4lDBHWWLjTHN4hvdbOtLmZmbd+Hu8Z4L6t8Q+QGxZIid4m9ifSAMiUjAP5/SEQSaynRTIRrsUw+Kg5peA6znmCXXQ+dtUlEUuH6vMybWZoq5cT3FMsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934355; c=relaxed/simple;
	bh=iW4jDVvGqXNgRDhwZg+mkot4mv4vuA+G0sHIjbvfvgc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KD7LOLhq5pHnsnziA15/pPRD3Rse/r1a74UNjB5DhSTVOIpvMrPdodhOXAcclImAjzXNUdQeCHBT1Pxeii7wPPQJM8gUEe32QX0mHiwBo/Jj1evXMJLA/8Mx1Xii1NeNHnWeqlD4vjHUzK+JpQgdwhgS0bDRb4kwQU8s8UIo0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ooOmzlIs; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ooOmzlIs"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37d4eede8ccso843380a91.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934353; x=1783539153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=a+o8BZyrs+hCKgt2M2jOo1gfN0drsi4lQngccMqCRwE=;
        b=ooOmzlIsJqEViAAN/4qZa/+wbrlTo/ONKkDwnjAHE/lovw5h9bQj6S/uhFdI9C5qTk
         IRdhfgdSegNnMOhEar0RFaKvvwW8eqn3RH1oVDhfKrDWpV3zz0VWxPtB/5Wjc/hhNHLu
         s1xYpBplvdRNKaHaW4/lsDsqA/ODYiFkl+mBq64bXjO5hLAIlO2k+s8DcsYRxFKF0qQp
         f6xManKTUrOujgd2eDT4Gtadb0bOqBLtpba6HpTrdTXiWe+pTd8JmxOyplhn27Np2Str
         UF29DMwjFrbjmmmp2mdqfKt2UDn2rVoeg+EXh+t4X6o9sXx2oY2SN9oQeFKROR9mKPSS
         NHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934353; x=1783539153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+o8BZyrs+hCKgt2M2jOo1gfN0drsi4lQngccMqCRwE=;
        b=OUibNDq2fp6mGnb0gUhDxdZYqMMnTJysCT4kodyLTsUerlEIawk7XBq9WI+siZiEcN
         vNG0kW6PXtml6UV2ljY4FehVOLZldOGDB8CH/w3TIEeJvDnBwqRHkFmdKYCJw4g6RjAu
         ba5luXgVr1Uy90krXs6zop2kuERZoyYj8Y31kF3Fa4o0ziBAH8x6bcQKMk12fldk1EYI
         TpfYn2mIam8jslDgaEPKqXHdAekKpHXm63+/RnUh7yQP1onsVa+b7A9xBaAP1MaImUYi
         sj/dEuyVe8+nPbAANte8sJSesxMwlA6d72xsIcZYi1JCu+pkdxmKVRTZky3pEwhL5zWJ
         ezuA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/6RRWEPSnAwMuT0GpHIXezcqnUc0v3tY0nM5dQapDO9M+SAH74tLPEG518kSQFfuE/8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSjynz9xAoRetU9W7fx7mZmwjqkM6NGfy6tyMsIn0EOMr0RPmk
	xwWQ4QzBIfR2dH4x7isumflTCNUDq3Zsq3eAEt2Zd+F9Q9k1me5F3nWbz4tNNgAspvLI4HMQ4lM
	RrBiuxw==
X-Received: from pja11.prod.google.com ([2002:a17:90b:548b:b0:37e:1dd6:f70c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c4:b0:37f:9ce0:af32
 with SMTP id 98e67ed59e1d1-380aa204608mr2862792a91.29.1782934352462; Wed, 01
 Jul 2026 12:32:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:26 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-6-seanjc@google.com>
Subject: [PATCH v5 05/51] x86/sev: Mark TSC as reliable when configuring
 Secure TSC
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

Move the code to mark the TSC as reliable from sme_early_init() to
snp_secure_tsc_init().  The only reader of TSC_RELIABLE is the aptly
named check_system_tsc_reliable(), which runs in tsc_init(), i.e.
after snp_secure_tsc_init().

This will allow consolidating the handling of TSC_KNOWN_FREQ and
TSC_RELIABLE when overriding the TSC calibration routine.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c      | 2 ++
 arch/x86/mm/mem_encrypt_amd.c | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ecd77d3217f3..ed0ac52a765e 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2037,6 +2037,8 @@ void __init snp_secure_tsc_init(void)
 	secrets = (__force struct snp_secrets_page *)mem;
 
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+
 	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
 
 	/* Extract the GUEST TSC MHZ from BIT[17:0], rest is reserved space */
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 2f8c32173972..6c3af974c7c2 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -535,9 +535,6 @@ void __init sme_early_init(void)
 		 */
 		x86_init.resources.dmi_setup = snp_dmi_setup;
 	}
-
-	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
-		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

