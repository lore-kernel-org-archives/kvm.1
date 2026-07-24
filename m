Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98678299931
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854084; cv=none; b=PxebqoMmYdOrJME2R5R8y/uWWg7AMPMVM2k9SLCJ6GPGloqxtguTnZwdkt6H+Amwmgqq4YpSffIJuc/R1uhwBh/RSxb4LbIRpzqLt1hM81RWjGmHy0vmQkwOVlMU/mkTprbbzdrTEA/w4OnC0Z0zty9SbA+igKXOkrI01s5anyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854084; c=relaxed/simple;
	bh=il0oC+ts1tFRkD6YLSl9Y8nYr9O6K2V6l/fww+pWdNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZPKIN+EKTFAHpFM5u+sFlwVi1NujZXZ0gzzi5IbqVlnby8YPSLSIInj8Rp5xcZL7v5X3k+2hr6kAxzxmfrE+GaajZJC6ta0prADbesnNCms6ehHaVnE4r0gBRgF9R5TcdGNbiMKPjUg8+xrVdVde+F3RyYz5iXzfkoNe93cfyyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uynIzGl5; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uynIzGl5"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so1528823a12.3
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854082; x=1785458882; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+KAdYpKsVpQWTrdyWSZ+uQBEtcV06POwwOgp0O+/BnM=;
        b=uynIzGl53i4xGrzDeLweT0FOeb34ayBBUZTC/wJFVTXKMNJz9utWElZotZwK0u6THg
         M6DhcOyn/fN5RaOUgl2vc3+e0YBP++OPvvYLHpqbA5Qd/PMb7ZcvCXTEpw8NeErCWdOS
         bW4SMO/OGL0ZMLffRgY+Eo4dp1H0vFKszDMUSfphtulV+Vw1O/R0mgxZrtcHpFtOgqpj
         DFTsR1MxkC8Q64Ixcvtz2f4HMqHiscatxydPO9zqUYA5/lqG9twsob0zJO5iv0rbKYRk
         ADzUpurfX0NJC50vyyZL3Yz7JacBVPHZiCLAT7zz8hnWqhduOzqnxGAE88Fs4lsd0Dgv
         9/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854082; x=1785458882;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+KAdYpKsVpQWTrdyWSZ+uQBEtcV06POwwOgp0O+/BnM=;
        b=aXmd7A98M2EOgVbWPFdIMq3C/hkWilX5S1ZQBNaLq8Wga3uZIB0oST+gKqGTT+IDdn
         YkqQhvIFb/gfLgr6G6MPBu9Wko7nZEUosUnAAwEwX5VJ4ysJym3IUoMY71r9RlPvoe1J
         ttlS525bKnZ4ZhrW3zgVZZYGSQNnaevOFiETWdNQuo6Cw9cOoS8+slohYNW9uWJfri5e
         +4GpqSr44iQabifXd6pDsCW2i/RpEeea2xPFVvsXTCqU3CiQEH50g1CPX2iGy8zxxQ49
         ynxocsKdsN0TOvHPQmey6nYfdmaW5Tw/XI6uZ4AmaLmYgsRjp24mpIAJMQwoc3EG2N4o
         okxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1QoeUNV97a1hn9JDWJSca/HjrXO5lDQGFMhQ0+3y57CgD5TDLLJQdcGHIa6wioqMQngU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+t5jjui0vD8pOTNoNqYlawHrnFgbHvqjZ2tN/DNkojMpJDSL1
	LAcmXG1draSxgyQ8MCook57eO9m6eEDtqPLXGcaklGN2wsa5oEzPppL8BTugNvUWyMaoJkil2G4
	tf/ZSXQ==
X-Received: from pfbjw39.prod.google.com ([2002:a05:6a00:92a7:b0:847:aa6c:47fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:300f:b0:848:2cb2:cd97
 with SMTP id d2e1a72fcca58-84e2bba4c21mr6791782b3a.52.1784854081825; Thu, 23
 Jul 2026 17:48:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 17:47:52 -0700
In-Reply-To: <20260724004757.131420-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724004757.131420-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724004757.131420-2-seanjc@google.com>
Subject: [PATCH 1/6] KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is
 cleared on VM-Exit
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Always check and clear KVM_REQ_GET_NESTED_STATE_PAGES when emulating a
nested VM-Exit to ensure the request is cleared, even when KVM was built
with CONFIG_KVM_HYPERV=n, as KVM subtly relies on the "check" to clear
the flag and thus avoid double-mapping the vmcs12 pages, e.g. if KVM
manages to bail from VM-Enter without processing the request, and then
emulates VMLAUNCH or VMRESUME.

Fixes: b4f69df0f65e ("KVM: x86: Make Hyper-V emulation optional")
Cc: stable@vger.kernel.org
Reported-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b5460de4b1a7..f2518d67e7de 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5066,8 +5066,9 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	/* trying to cancel vmlaunch/vmresume is a bug */
 	kvm_warn_on_nested_run_pending(vcpu);
 
-#ifdef CONFIG_KVM_HYPERV
+	/* Note, "checking" the request also clears the request. */
 	if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
+#ifdef CONFIG_KVM_HYPERV
 		/*
 		 * KVM_REQ_GET_NESTED_STATE_PAGES is also used to map
 		 * Enlightened VMCS after migration and we still need to
@@ -5075,8 +5076,8 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		 * the first L2 run.
 		 */
 		(void)nested_get_evmcs_page(vcpu);
-	}
 #endif
+	}
 
 	/* Service pending TLB flush requests for L2 before switching to L1. */
 	kvm_service_local_tlb_flush_requests(vcpu);
-- 
2.55.0.229.g6434b31f56-goog

