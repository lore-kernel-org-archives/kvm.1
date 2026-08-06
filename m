Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5D649DD27
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059408; cv=none; b=qThpzWttKonrU201NP/80d8XMB8U9Nu3Xbay0pqXCRT78I4aztjGB/ZvSZJVoKUsrdJHNyQ0wnnO/ojTjZDLcCHGQYdyZ9+b+3HTVbzsWZqHalbsIgp41h1DZKSV0MXPkyTuc6DhvE7A0znBfEqfccimvFvFHhY0dMj5UVQx1I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059408; c=relaxed/simple;
	bh=zUwj/tUghTiTEVoKSWMsQNbnRAFLb6fHDZIqhxq4ECM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uuECdd9XNx8+559nZb/X8mFalesi0kdSxWXiubAPKp088cG3AcGKOpoBK924S25mVPkLu3VL6m0F+OdFDmQsSRmcs8SQT2y8iM25a6nXS3c54gmLdmDNXrx2hgU4rYPdY/rqdOb9/ALOUMgXYnuzOMrafvLUFhx9da+NX7W3i9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QOGCG0tu; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOGCG0tu"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cea6a46766so46522015ad.0
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 16:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059405; x=1786664205; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=as+YzjPRM0DAZztxhbx3Raa/ax9+dW0ZzZ4Dw8q0B68=;
        b=QOGCG0tu18x7UqhQoq1sTMznk6mLlwZxmrn25kI8bEQeaG+rcZAQfVqGtCQLmPJ1Ng
         PbVxhpEyFQf1Tt5Zd1HTSNTJtlx5oBdidjECPfcZPBpNhGFhkUL2OYveXfIt3ciRE+bJ
         SznTi/Y5UaBJ8LuoeC90gWrqyy2kk4xwJIH31gKxFaRO2XBQ7/FV2nL5uvRvxCM/sT61
         dFyWn/ZIg4wbGWaLo4wzuUB3GuV1cBCwbt4ol25c9nD9GlsYZm071zNhKl2LatVK6rS+
         Ic5MAksOk+nRjSJK8EsovnvRkzqJs47qe6U9XEdTa7kH9bZJDv7v8o87HqJqArWbciL2
         pCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059405; x=1786664205;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=as+YzjPRM0DAZztxhbx3Raa/ax9+dW0ZzZ4Dw8q0B68=;
        b=qPibpUF+EHb8lkyiiVVXddmsGjmXOHJGBJSIKnLTyp7rMXailum8hlgFGBotwPZ8Qw
         uWu2GsP5mg6Lqa1TCVU5bmmaSjvkgapUw+TGAEm6nIZ9bHat589GQzWzH/EbGPPglw6Y
         4CT+AjqEvG9BH7TpuGnjJmjLpDeV3ylSbPZZiXcGGwXZ3OEc40dTyGTLbRj4v6KVMIh+
         lnUUZLG6+3lhh8/3GqG/wT+qEcxfb0qkXV0LOclWQp+CXoeMLoRJ575ldZ9EUFEeh9rB
         LXvY6E25beNP33VvQ2ImPmczMxRUNA6ixf/n0jXbt870VVOYC6/MCQl8WNEF7AaN5aBu
         llIg==
X-Forwarded-Encrypted: i=1; AHgh+RouPpHwz9m4ad2EB6t2sZgWOf8zoVan/1DgdyTyJhjgL6nv7aG3jZ0Ey+6rolySiL9gXWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFe+Yr12eUEwgCKuXxgxx9rRsBCYw+kRLROaA1I1PZr/jo3TAJ
	dCF5cf2TYLv5rRUsed9BRcERf1gKY4J4wJWKFJQS9+uN7uLF+FLJc+j6byWlm6lFMpdoHvi8v5P
	ztnzKag==
X-Received: from plblh12.prod.google.com ([2002:a17:903:290c:b0:2cf:277e:c60c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f708:b0:2ba:6518:a6d4
 with SMTP id d9443c01a7336-2d0ca9624bdmr224800085ad.20.1786059405010; Thu, 06
 Aug 2026 16:36:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:34 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-18-seanjc@google.com>
Subject: [PATCH v6 17/51] x86/tsc: Fold native_calibrate_cpu() into recalibrate_cpu_khz()
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

Fold the guts of native_calibrate_cpu() into its sole remaining caller,
recalibrate_cpu_khz() to eliminate the extra SMP=n #ifdef, and so that it's
more obvious that directly invoking the early vs. late calibration routines
in determine_cpu_tsc_frequencies() is intentional.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index dd9e04e325d6..d95e4f059f17 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -918,21 +918,6 @@ static unsigned long native_calibrate_cpu_early(void)
 	return fast_calibrate;
 }
 
-#ifndef CONFIG_SMP
-/**
- * native_calibrate_cpu - calibrate the cpu
- */
-static unsigned long native_calibrate_cpu(void)
-{
-	unsigned long tsc_freq = native_calibrate_cpu_early();
-
-	if (!tsc_freq)
-		tsc_freq = native_calibrate_cpu_late();
-
-	return tsc_freq;
-}
-#endif
-
 void recalibrate_cpu_khz(void)
 {
 #ifndef CONFIG_SMP
@@ -944,7 +929,9 @@ void recalibrate_cpu_khz(void)
 	if (WARN_ON_ONCE(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ)))
 		return;
 
-	cpu_khz = native_calibrate_cpu();
+	cpu_khz = native_calibrate_cpu_early();
+	if (!cpu_khz)
+		cpu_khz = native_calibrate_cpu_late();
 	tsc_khz = native_calibrate_tsc();
 	if (tsc_khz == 0)
 		tsc_khz = cpu_khz;
-- 
2.55.0.679.g6767b8d81c-goog

