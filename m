Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB93D4128
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795653; cv=none; b=bQX/W2R5h/hMtO982yM3ABETBGRbFMn9X8qZH029mAdPDgjXYfGoZjMbzyTVW4rNrAHmBj+ihOUU4bcCZGPCXGMY1Nx2/XwLDAFmZJ62S42Cm7crWxxLthrtO/KryGWIIj1cvPU5xpfpjdeuC5VcgmBXyi+VpoGA+vO8j6GqfrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795653; c=relaxed/simple;
	bh=kPzayqgTX4AYKj05HSSQLjERNpIEzXUE+TYLElLBau0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L4nL5AkS1zVZqojwCzF0B7773pDQsz78MIVLP+cxjL2KGjM9YDANU1j0qQAv54DuD1+PmL1+Ctwd4vbxSrjkq/oQxKFgRNk44FVBMQ89cQmrfphm4IaGQk08pzu+PqmlZfVqTdD8SRZ/TfGuas8E3MMip2bqk2QO/KLxUVVO2AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oBRYB03I; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBRYB03I"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso5749761b3a.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778795650; x=1779400450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LhpTli2hbTyfQzA9vyBgyGyJFOk8w+Rac8Zy54UhAOk=;
        b=oBRYB03IbWkiuAdyITc7VfVBAxwdxEjmOKUdwv0f51j5TXFJImuceM8LqgVdIhA1Km
         CTeiOOdlsdKeo9gapDtvijjgEKpQSog5vpPgj8xwvjbvOWkxUZKch7WzxXrWIQ3/jamE
         4vdPZLvBf4tkZaYtovqXOMo97jpK8uGHOgmc5JJZS39i8Qe+p2dp+l4KIuakFS9+HMgf
         XHuEL8O942FP+AiLA0fGU3pXT4pMoVbpvjjGY9ynsp8xpnMdrEbXr8kuloWbbA8M4b45
         0wHtI4bK5AbXPV/ybPaeziAFM+SwujD8r0dl+xiz4tekgjpHJl2hNlSiAatI2to9YJxe
         smzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795650; x=1779400450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhpTli2hbTyfQzA9vyBgyGyJFOk8w+Rac8Zy54UhAOk=;
        b=QwaT+QhqeUfOXF1EDh/c9fVW058fxiwmQrSmCIQXcn3xRgyqJiFDLpp5WLJE5cG+BS
         sSkafqxQBBoXjelo+1dUD6dEe1dFeYOdPv5xdKMnB4IvVSmT44kDDZJrRkXgt6G8lQMv
         bXr9ypMZ7qust3XLIxPsCzlSy7hsg+LKjYspm261x8ZZKTbM/ferWi18KMPWuAbslb1u
         flNlCkKrt19qdL+BVVekwQN+4QUX5wVXagy9uzVqAgRyDbwC0u3gay5+6okX4OktruUm
         UhLKnMLSweC4CYeTnHedZAPYFDgUm0N3gNWZxlEshkJInJenG3qHzRdOuEmZO99JbSz5
         PXQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bnwnQblyZFxwP1mvCqRaAxDmat6L1WljOWwnmOLVE+FXOWrVnH6HDJMXKbmw/IamQf98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqxzEfQdX3LvZixiDaKpc8stDCdPsX3r6gqPV1ASXGe0KHfrTG
	+AmPEhd0jJV6tcZYDURY+OFZx5ouzfPh2e9fgA0rVCs1HoRkZuhz04iEnVRqytwzzCUkpw5zzCQ
	YQkLwAQ==
X-Received: from pfmy21.prod.google.com ([2002:aa7:8055:0:b0:83f:2ce7:48ce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1954:b0:835:366f:5da2
 with SMTP id d2e1a72fcca58-83f33d80937mr1240198b3a.37.1778795649298; Thu, 14
 May 2026 14:54:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:53:51 -0700
In-Reply-To: <20260514215355.1648463-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514215355.1648463-12-seanjc@google.com>
Subject: [PATCH v2 11/15] Revert "KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode"
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

Now that kvm_<reg>_read() are mode aware, i.e. are functionally equivalent
to kvm_register_read(), revert aback to the less verbose versions.

No functional change intended.

This reverts commit 60919eccf6764c71cef31a1afeaa1a36b8e5ab85.

Acked-by: Kai Huang <kai.huang@intel.com>
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
2.54.0.563.g4f69b47b94-goog

