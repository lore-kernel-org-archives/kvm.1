Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741E43CD8C2
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792713; cv=none; b=fvzndIyndVuXrwIlu0mQ2ApVqTfoPJP5ZvZ8fTg3Sh7XiA2hWvRSjwkQ0MR6IOJvmBD/CFFrtVeHEsZPAV8t0AOwlvpDpsYdBpeVn66//LZ+1XYYpoEPmT/SJbJhojs5E6cdU/FMCOBcNUl7KeZlMNIR26JAYDcgLnyNDhFlAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792713; c=relaxed/simple;
	bh=K5sJ8QsJgQHdwOvkOPi3IJtOhM33Jkke2olZGFXEZAs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UelK8+SbaXcfnTxQJcCy7wdKaKtrPJ7bK3BYAb5LjAhWHq53sYag5a6ggygz8wQnbwLiCvxmddzV6PmgJYDfUrv7YPWhRtypCmBRGmsFJ4UqClJJ3pczmohTZ1XsNd127Md9LSp8OFTvRCcV8GPotLfX5yuSAsnwHP5b7Id+gNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sd6Ks9Z3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sd6Ks9Z3"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-366ded5ab5fso12616702a91.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792712; x=1779397512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NTTaNVwfyM+AgjIx2cFlBV7Kkp80m8LicwXYg1n1iJE=;
        b=Sd6Ks9Z31k7WAZDi6q/OuHpWsDnbt3ydZAaX+6AhD17luBHs5/Ii1U7KZpnYRa5bfo
         sKP+IhLfZUN4uBmMEBHtLDt1IjZhsCzzm2rORo3edUrTUZp/JDeqmB8P6iGe3qgE5lLq
         bhPAggT+2/zw5h1dEFW5+K3d3hdA6ZjNIl+27yZZ081tbSJ0RhqH02fOl3ukizZuPf0g
         6Ux94CKNSCtKt0BqkrGnDkDKIbv0dHEJSaYJJfW1IOiQ17En2qKMe/giuP9lbj9UfR30
         4oaxybcK+XU2mYNm91sX8+TD2pGfXhkCNShqgr4X4MXiOtEj44p/vXo7/RTXYSPjft+2
         71IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792712; x=1779397512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTTaNVwfyM+AgjIx2cFlBV7Kkp80m8LicwXYg1n1iJE=;
        b=cVf65F3TpwT9MqsQbWeJq7EYp773ZnIvXt4vTtZMQAO8QZHB82xOAWYixMe9tGT7nP
         5U8rW5ksr6dUFOENpVO7ei9zDYNf6L/WrPSqs+r+POVqM4FXjjJ8M18/fR4rri+nu/hg
         kOgSf821dF1dj/x6g8cYd3g/DYHxGXmMcsilCIlMm5UQXNyUYYdZZQ7KOe8L4wt64q15
         1hQtss1ihNoT41Uaqnk8oQPB0RvNrAMUoTH1IjYC3LuF+wbHn1zfGItvlHbgtlRY5+L7
         dRbVfaX7e5BoyHa7r25JmMoLoLdRCNk327KYDwgVSfb8RL4/+3JsOJpqLCC96gqQMFuO
         ArYw==
X-Gm-Message-State: AOJu0Yyt8Juz0D9oCGxMnKjzuLI6BE0RcA8QHNnRo2t/K5q6Qy4tDVMd
	J9Phf/TXL4BOCcMPvEHdWmBSmH4KvdBsiKhgE12xckZzfz16Em/AdF+Ap86AJe8dtn7rPl1fgPe
	VWeSj/w==
X-Received: from pjbpa16.prod.google.com ([2002:a17:90b:2650:b0:369:1b0a:48d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d885:b0:368:d820:cd84
 with SMTP id 98e67ed59e1d1-36951c967dfmr1003049a91.21.1778792711470; Thu, 14
 May 2026 14:05:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:48 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-9-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 08/20] x86/vmx: Use separate VMCSes for BSP
 vs. AP in INIT test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Allocate and use a separate VMCS for the AP CPU in VMX's INIT test, and
simply mark the guest as finished on the BSP.  Sharing a VMCS between CPUs
requires _more_ code than allocating a dedicated VMCS, and completely
falls apart if things like "launched" are made per-CPU (spoiler alert).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/vmx_tests.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index e2bf06ac..effd0c59 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -9976,7 +9976,8 @@ static bool init_signal_test_thread_continued;
 
 static void init_signal_test_thread(void *data)
 {
-	struct vmcs *test_vmcs = data;
+	struct guest_regs *regs = this_cpu_guest_regs();
+	struct vmcs *ap_vmcs;
 
 	/* Enter VMX operation (i.e. exec VMXON) */
 	u64 *ap_vmxon_region = alloc_page();
@@ -9984,6 +9985,11 @@ static void init_signal_test_thread(void *data)
 	init_vmx(ap_vmxon_region);
 	TEST_ASSERT(!__vmxon_safe(ap_vmxon_region));
 
+	init_vmcs(&ap_vmcs);
+	make_vmcs_current(ap_vmcs);
+
+	memset(regs, 0, sizeof(regs));
+
 	/* Signal CPU have entered VMX operation */
 	vmx_set_test_stage(1);
 
@@ -10003,13 +10009,10 @@ static void init_signal_test_thread(void *data)
 
 	/* Enter VMX non-root mode */
 	test_set_guest(v2_null_test_guest);
-	make_vmcs_current(test_vmcs);
 	enter_guest();
 	/* Save exit reason for BSP CPU to compare to expected result */
 	init_signal_test_exit_reason = vmcs_read(EXI_REASON);
-	/* VMCLEAR test-vmcs so it could be loaded by BSP CPU */
-	vmcs_clear(test_vmcs);
-	launched = false;
+
 	/* Signal that CPU exited to VMX root mode */
 	vmx_set_test_stage(5);
 
@@ -10110,9 +10113,8 @@ static void vmx_init_signal_test(void)
 			exit_reason_description(init_signal_test_exit_reason),
 			init_signal_test_exit_reason);
 
-	/* Run guest to completion */
-	make_vmcs_current(test_vmcs);
-	enter_guest();
+	/* Mark the guest as being done. */
+	test_set_guest_finished();
 
 	/* Signal other CPU to exit VMX operation */
 	init_signal_test_thread_continued = false;
-- 
2.54.0.563.g4f69b47b94-goog

