Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D93BD646
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093375; cv=none; b=DYoLR0rAFNaGpxlKeUF1jpKj6weGRCTD+zZE0PnKy+AhTPwuxmpIVbluaMVdOaHMe3AG1OkJJPP4dfs2I/UJvPx2vMTKvkS7F2pZSXCO8uZEkoKV2zGKAtKQWa/LAAHICeEA6nMrA4qitUI2fhNY1YKOH8Z7AcCpS3GNWZSqx9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093375; c=relaxed/simple;
	bh=rNEMOfQP0lISV4GXkkh7r4YHYgmX95gg+RO88qDWtLA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FtcFdvc9F3XWbB3LFf4Ipv4tQp62f7NghZ/rBtsfyRCIQBk+RAuyxERkcBjkNbxmy+81hsVKtUtGz1PUTA+MkZY/B7z7wB43x7ZXtPIBNmLQfooouOqrUH8AG5Ay++Sj2UoZ0Q0BUcIsbgNSTAp5kzbMsjNmbmLLwk/glHWkR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X9FoXxLR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X9FoXxLR"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422ca754d8so25541b3a.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093368; x=1780698168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IFUIQ/grqF4H0Xyudg/Qm5uUCCNXYoJ9yfo9zM/sbkk=;
        b=X9FoXxLRCfoRy11dmMlzJPQzdEcFkvbPH4ZyXOxHrh4rD0UqB7nI33XDYdQKetSF2+
         Hn4oTGhlbu4I9Lb04v7ivE2rDtvUTJEK+cihxP17PmT8putSG5JOeS38AztDHoVwQUyw
         Kle1YmsYH75pldbcqkacPJBMYze15F9YbdVh5wG4onY2CMhSWQHHEN/9Zv/SL6NTW/n6
         bTB8GoMgZ3F4T9ImySSQPJXOvYgl2StdOOmGQnPYu8C74xZunZmM2EOFRJLEl0TajVex
         poI7u9ofCxukYtw9qKhPfgWab8NXqE2IY8JhpHT661RcI0w36njfuXdzPojN0S8ZeqC0
         TDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093368; x=1780698168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFUIQ/grqF4H0Xyudg/Qm5uUCCNXYoJ9yfo9zM/sbkk=;
        b=UU67YBEzEK74lznlveedtgQWcRPJIR+NGSi1unbUIdXqEPCCndA5TxqZfdfTLmVAMl
         oNz2U5k1ev2J1sIDFVxPMS5kF7Y7MQhXZnPDLTg7gTgRPala0uO1FLIFMV0YLi5RNmdj
         ukVDZOwlio4uIc7puFovxrK2TJqNimN7BjPivtYD7WaR9drw4MJpEyv9ZPUK+Rgbr4mz
         EvMI2R/lhOB04+QZOXq1B9GwSsK0N2LTznMPCZ5vcL5KeyhCctmS2ghw4ByvvajP+fGL
         TFFOWsrZKku9LW9iGDW6qswCnfFNAXlXgdC6eMjlN2pSLR8vc/QIWMRqUgIFhsCLaZQh
         Li2g==
X-Gm-Message-State: AOJu0YwNpvueSKsWkLY71vTopdmCg4JyQeHAmTP4565gCMDezrS7ZDxH
	E3Fjo7re1ViSJByPdqP/NEot3I9xVoMtHt27vaNbNg3IAH4dvNpKdddRHnlbG6zsHCoK5aFUZ35
	An9VZWg==
X-Received: from pfbk22.prod.google.com ([2002:a05:6a00:b016:b0:842:1f96:2713])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:27a0:b0:833:2398:cde2
 with SMTP id d2e1a72fcca58-8422570a361mr1184893b3a.43.1780093367744; Fri, 29
 May 2026 15:22:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:47 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-5-seanjc@google.com>
Subject: [PATCH v3 04/40] KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

When getting register values for ENCLS emulation, use kvm_register_read()
instead of kvm_<reg>_read() so that bits 63:32 of the register are dropped
if the guest is in 32-bit mode.

Note, the misleading/surprising behavior of kvm_<reg>_read() being "raw"
variants under the hood will be addressed once all non-benign bugs are
fixed.

Fixes: 70210c044b4e ("KVM: VMX: Add SGX ENCLS[ECREATE] handler to enforce CPUID restrictions")
Fixes: b6f084ca5538 ("KVM: VMX: Add ENCLS[EINIT] handler to support SGX Launch Control (LC)")
Acked-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/sgx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index df1d0cf76947..4c61fc33f764 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -225,8 +225,8 @@ static int handle_encls_ecreate(struct kvm_vcpu *vcpu)
 	struct x86_exception ex;
 	int r;
 
-	if (sgx_get_encls_gva(vcpu, kvm_rbx_read(vcpu), 32, 32, &pageinfo_gva) ||
-	    sgx_get_encls_gva(vcpu, kvm_rcx_read(vcpu), 4096, 4096, &secs_gva))
+	if (sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RBX), 32, 32, &pageinfo_gva) ||
+	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RCX), 4096, 4096, &secs_gva))
 		return 1;
 
 	/*
@@ -302,9 +302,9 @@ static int handle_encls_einit(struct kvm_vcpu *vcpu)
 	gpa_t sig_gpa, secs_gpa, token_gpa;
 	int ret, trapnr;
 
-	if (sgx_get_encls_gva(vcpu, kvm_rbx_read(vcpu), 1808, 4096, &sig_gva) ||
-	    sgx_get_encls_gva(vcpu, kvm_rcx_read(vcpu), 4096, 4096, &secs_gva) ||
-	    sgx_get_encls_gva(vcpu, kvm_rdx_read(vcpu), 304, 512, &token_gva))
+	if (sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RBX), 1808, 4096, &sig_gva) ||
+	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RCX), 4096, 4096, &secs_gva) ||
+	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RDX), 304, 512, &token_gva))
 		return 1;
 
 	/*
-- 
2.54.0.823.g6e5bcc1fc9-goog

