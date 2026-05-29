Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FD23BFE25
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093379; cv=none; b=j4uR4gT9ncyTqXku8gqaDlF5NYg0/bEq0ezLzPbrJsASrxjSLiEwhcPZRRZHiThng7aR2ziWVfen1bky91DPArjN49Cl0qggJfUUeVETpWfjMtRaMR6fBQRIqk3BA0noPCyes3+pBDU5G3N1BalpUNfuZ3TiCcOpEByxnmwHD+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093379; c=relaxed/simple;
	bh=y7gBMyXrlhkkVrixZ3rMHYtJrOyLsBu671OBCVJh2sk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ndOkWvAVwGW7FAoaOek2T6bIkmbh/kVoFDDncSaES4r1ipxS69yoBRq7Doy2Rc6madwodE18SdaVBaAE8plEuacdFNGcofqnhJW2NHarDybZ/8OsnVgJYv7wOqDPIqH18N3GhCyU9ZqGopmmoefcb8BV4Ecqx+kiu9nGTVbW64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A5L8bPr/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5L8bPr/"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso118360145ad.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093376; x=1780698176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1d+7JTGp/HbwqWUEDQGxoEibOm7OCRTR3a6kaHjtDYs=;
        b=A5L8bPr/DG/tde906di8RuRDge7PPWczF3eRDYmvbnhaN7L4bgn4KwOLds716P/whg
         MuWH9oFlcw7utUmfTtbaQjBSGNkGYMbigTFVBuLDgdBe2dy0Byrzb5+Dyh442oLqsh0K
         aL52NYh/VJ9Sn2nqo9f8FcrAW2fLFvh9xyFV292CZV+l9Llybuwc1J0SaAvjzWHbskn4
         VqifCa1Y9+6N29w8OW15GuLzF9P2yjQwuiIB2NNBu0aFCaJ65NGMqs3MKWBOwnTvv0lU
         3Z+ZzFWSzw2vfCNK/hb/mQvk97pOdYjVQDNTqryHkOkkwiPrxb3KAkeFhamfvi/Xze4h
         8iSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093376; x=1780698176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1d+7JTGp/HbwqWUEDQGxoEibOm7OCRTR3a6kaHjtDYs=;
        b=gVjF5/or/19byYgq2lJ03cWTlxw5Hlc0adkEzFhO8xlMqlYb+K/r/BcOzFWMcHF+jI
         t9lplIoOq/t0n0zNlOI0pFY1n+vrHQK9D5jbKFLKy9Bcj9rASbYkN0RD1WuLV0QF3G4I
         vE3G0iN9LdywEHqiQQOfGD7Zj9erOKvRAXw4WN0L6Yh0uQ7CZgP4OAIlJ97pQPwTP6X9
         EGNUvZsPHIz4cmK8Lr0re3plfKFG36xq+mwfkbN2VD3/ID25RykWRMMUqIZ3c5onc1Lq
         OgW5e4Vyz0daOghkfNWjSNqulqIpDd2lK3seG8W63zDrs31zNg9RrJjEtnFUfqVW+Pcq
         bsjQ==
X-Gm-Message-State: AOJu0YyTAEBuU7hF9Xs7Mo2e5g9Lrz8Jq3Te/7x/3jfiDorhaYxBYCUU
	9MXCnPl2QorXECL9gwThRmy7Btq0WhLl7zWzccegpq1yhRQyPwCTrcbhE6wb7JEDgEnqN8453Ha
	FIByItQ==
X-Received: from plqq10.prod.google.com ([2002:a17:902:c74a:b0:2be:bf91:ff92])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8d0:b0:2bd:c5f8:504f
 with SMTP id d9443c01a7336-2bf368d9ee5mr18560845ad.40.1780093375621; Fri, 29
 May 2026 15:22:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:54 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-12-seanjc@google.com>
Subject: [PATCH v3 11/40] Revert "KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Now that kvm_<reg>_read() are mode aware, i.e. are functionally equivalent
to kvm_register_read(), revert aback to the less verbose versions.

No functional change intended.

This reverts commit 60919eccf6764c71cef31a1afeaa1a36b8e5ab85.

Acked-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/sgx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 2f5a1c58f3c5..876dc2814108 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -225,8 +225,8 @@ static int handle_encls_ecreate(struct kvm_vcpu *vcpu)
 	struct x86_exception ex;
 	int r;
 
-	if (sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RBX), 32, 32, &pageinfo_gva) ||
-	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RCX), 4096, 4096, &secs_gva))
+	if (sgx_get_encls_gva(vcpu, kvm_rbx_read(vcpu), 32, 32, &pageinfo_gva) ||
+	    sgx_get_encls_gva(vcpu, kvm_rcx_read(vcpu), 4096, 4096, &secs_gva))
 		return 1;
 
 	/*
@@ -302,9 +302,9 @@ static int handle_encls_einit(struct kvm_vcpu *vcpu)
 	gpa_t sig_gpa, secs_gpa, token_gpa;
 	int ret, trapnr;
 
-	if (sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RBX), 1808, 4096, &sig_gva) ||
-	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RCX), 4096, 4096, &secs_gva) ||
-	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RDX), 304, 512, &token_gva))
+	if (sgx_get_encls_gva(vcpu, kvm_rbx_read(vcpu), 1808, 4096, &sig_gva) ||
+	    sgx_get_encls_gva(vcpu, kvm_rcx_read(vcpu), 4096, 4096, &secs_gva) ||
+	    sgx_get_encls_gva(vcpu, kvm_rdx_read(vcpu), 304, 512, &token_gva))
 		return 1;
 
 	/*
-- 
2.54.0.823.g6e5bcc1fc9-goog

