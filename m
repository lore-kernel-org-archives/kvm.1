Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27FB3A451E
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778997; cv=none; b=L4WUIRfJ8HAIuppXHHCn7GVdLQt74pu6P/ghbV7uj9F1BT0slfP/STDa8pYG9q9gJHxVmF7YXTPSSXqodBMchF/mT0CIBU7hmIVgN+wHqjYoxizhg3lohwxT2E0TfQFEzXDxbF5gDNrqxLVyx71x2eKKwEGr+WHVRzhPBuysrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778997; c=relaxed/simple;
	bh=SwVtY12hgBgQVNg/aL4ojF3ryEpphQQaObwrB5edxqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KgEb8FkIZ0SNgw3LqeydJuDAPSSN81iROmOOyyZvIdvtOwlsCz0wdzgGSlf+ol3FdFIkBLb2oO5/lLn+kJ15V26S0sOgRYzcppimOR+nVDnD1ocXgFnB07VGnPXvkBlmpzN9/CvbLK/B4yn31F5GChHxLx1MrOrZA9CuH219sm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GnMwqXF1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GnMwqXF1"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f07078eaaso457640b3a.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 16:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775778996; x=1776383796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kXxd+FRfeqdfqRkD2vAbTBLqeVS0Zz0p9iuPyi5dCns=;
        b=GnMwqXF1NOr72+Ozc8+49dnY5+GEPV9PxAoU1ZDbrzuePWnm4kGmy6aZ5rLfACky56
         T6rGaR3bwLcphrnBHuZYfv+z3vplowPpcpzSvfXNAMH0N+s4R0p/6YDMsMySSr4IXxmU
         HjXOcsgtiNKJ8quE4pgzWpN3Z6GBfId74KFjJ1ZW5DGObcWLOekIvoKqZJOB3u7tNcPR
         nvEvf91gnkzbJG9VmKcQ6ybyDqnDOnbQ7tn0uWqO5qE95LSj5SxQgWJG74B/LB8xU+2r
         oakg6CTT+EOx6T3AmAiW08y83dKzb6emuPqeV4VmzaOxMtLScbm3pUrocw4qqotiosau
         z4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775778996; x=1776383796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXxd+FRfeqdfqRkD2vAbTBLqeVS0Zz0p9iuPyi5dCns=;
        b=kXiQFBXph7GskLswFC1N046ZF9wthT/W/PZ9pYlYYM0Px69DIY261Ewur+jvKFmRM8
         wOhgDDLEcRM3zFgVWnYYd7ah+6/y1/B/rwsvPXQI7VrMxglk85TKbUUahemXN8CGQOqw
         pnHmcqzLToTYHWpL0Feq8Opfh7p49f/ZUv+s55I7H5KKEjjHE5uQG8RaDs073YrYiK9n
         s/jzrde7HFa8xXI9cVN02iGwkj8suoDWBJDMHMgnN4YVZ3WKkAjSTGPUHdYYqnwwJvKj
         7L9gq3/taN+2ZfR4bkdIMGCHJi4ruLwzNoVPtZnE+Idncdvw88Xtmzcdz5pRmAx0SBct
         uqoQ==
X-Gm-Message-State: AOJu0YxWbiwj4gHZL9+nz4iYnnV7cpX+fO7mScKI/qIm80H7YHnXGRX9
	qYOpIl2RRTearK/wlUu3LdPQKJY+P+EBaSX2Y8QyI9LimG4bScu5Tj0Qdlkb40sydseoa9CsIVA
	5bULtWQ==
X-Received: from pfbdh21.prod.google.com ([2002:a05:6a00:4795:b0:829:f706:70e4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cce:b0:82a:7f1a:758c
 with SMTP id d2e1a72fcca58-82f0c1cf390mr1320023b3a.11.1775778995649; Thu, 09
 Apr 2026 16:56:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 16:56:15 -0700
In-Reply-To: <20260409235622.2052730-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409235622.2052730-5-seanjc@google.com>
Subject: [PATCH 04/11] KVM: VMX: Read 32-bit GPR values for ENCLS instructions
 outside of 64-bit mode
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When getting register values for ENCLS emulation, use kvm_register_read()
instead of kvm_<reg>_read() so that bits 63:32 of the register are dropped
if the guest is in 32-bit mode.

Note, the misleading/surprising behavior of kvm_<reg>_read() being "raw"
variants under the hood will be addressed once all non-benign bugs are
fixed.

Fixes: 70210c044b4e ("KVM: VMX: Add SGX ENCLS[ECREATE] handler to enforce CPUID restrictions")
Fixes: b6f084ca5538 ("KVM: VMX: Add ENCLS[EINIT] handler to support SGX Launch Control (LC)")
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
2.53.0.1213.gd9a14994de-goog

