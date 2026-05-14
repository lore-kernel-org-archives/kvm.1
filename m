Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613BD3D1AB1
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795647; cv=none; b=iq+msjoVcaTYEWj5KwD+8YRY9w9vJj3Dzhnqq+5wxI30Y54HAyf5zq0cCNivm+RxeCFzxiyKJTAZrx8UaOxWbY3DrTrZGKM51J8GUyTv56rlHx7534RrsQHvjZsduxz8SB99+5i3nrCqXmYPgphprX4CVaiPYeUOOnx3q6Q2mGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795647; c=relaxed/simple;
	bh=LgzQvsxxX3nzX18piIgpsaez26+Gbcq9HNZDoLa+NpM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C/sWuA2FJH+2ktkh42zJrOYd8Nozwp1zcVYwR6Okv3R5yMmX8AsQscXZFTTNryXrrdIj9Op1N2tl1y1PHMW32jEdGZE9KuF++Cm4kRAb2ZGGlsmJDG5PxHhvyORPW9VhlMuXMrBfAtxW4Zna0ieYbcQ1y6Mrc06HhFIWvozgWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kq0SKok+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kq0SKok+"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa366fb79so9224058b3a.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778795642; x=1779400442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AuBt9TLpeBgSZbTV0sAjcKLbSpi+4/r6Mj25KjhoAAo=;
        b=kq0SKok++v+nT5w6jtIWcXEnKjVL4z1ZTtlSGtCs651URDxt0Rs+zAym4Hu6adjIgB
         g6SON9Gyy8tgG2P10+vUUiTKAm+ej6vk1Y6BuwdbQNG1YttjA0JOP3bM6g0AVjHhFDKX
         0KVjPRfmXBS5KNjIfE3PtCwIbdW/+97Rnb71BO51b2WRFc61ffBRLP0rVEtINfm/lzc4
         4TGLfEthUpPKJQnX3GCZgMyMQC09rP+9/5RIIpl5BHy9rVPGnUwlkTjZ3zzmTFH7b2dw
         H28ZILmK7pEKfQ2bVD1qcqrSDoRdijjG+XreozgxVC56Z62dqgfjKzZ83wXOEJi7uWJL
         e49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795642; x=1779400442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuBt9TLpeBgSZbTV0sAjcKLbSpi+4/r6Mj25KjhoAAo=;
        b=oNP5W1pCV/hPR/UwFGjWSywCPfK56qpwEHJJmBFNWXyx2x/XcjgXDaRqRHP/O+0BjI
         UVgDwGoAH04Fv/cXy5wLzBuHcY1STqhPU0gspLUfumkjGr9M/0fSoTfI8RHZ5C3fddmH
         NggCO3iGoXiet2VwJe8GH3zZhmVTy0Xb+bUfhwMjldtBCt3lILWVLBqV37agjs9HcKEJ
         c+hSHU+wngJwHNmN1+WWnmihJfoQORVcamzqGaSAqurIKm8DJLTmCoC/FLGWqEzHttt6
         9HCWmfesZhGYo9xA3lhuxZnESaoBUXixLMVDym04FirKhZN3k0mPYooW+rTMFY8z1Yqz
         42ag==
X-Forwarded-Encrypted: i=1; AFNElJ8BeHQk7fTW2yN9Pvqz0GYTQOnypQgnQ+2uj8ZfJvD5l0VZV+kYBICAcQfzcgkKBztssGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhIltuLA25xb1cHSbuKzHsra58SjvoBfy/0oyyPufrGnFZZtG0
	RwaNMVu3IkV1wAIT+pgFO4qj784Su+at7o8lqJ9uJ1hiBys/odR2j8sbaCHfrbuKf5zaeEmcPUG
	obYAXUg==
X-Received: from pfhh12.prod.google.com ([2002:a05:6a00:230c:b0:838:1469:2431])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:198f:b0:82c:20ba:1570
 with SMTP id d2e1a72fcca58-83f33d9828dmr1291294b3a.29.1778795641340; Thu, 14
 May 2026 14:54:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:53:44 -0700
In-Reply-To: <20260514215355.1648463-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514215355.1648463-5-seanjc@google.com>
Subject: [PATCH v2 04/15] KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
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
2.54.0.563.g4f69b47b94-goog

