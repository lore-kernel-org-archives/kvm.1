Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8873A5E93
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775779008; cv=none; b=fB7XGgHFhVyyKqThRI+QE3jgBJaN1xkpLTBu05Lum/VJnbdyejweAkwAnnBPjz99HZ2aMoibRUW9mJuj9LbcVh/fQTX1u84z0k4AgqNm1hGMj8ca6YqcUXb23m0QySWZCWbDqyu9rvCTZGvIdG14m9T5cYhBexBndUo/xP27KGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775779008; c=relaxed/simple;
	bh=4VSiwzk65MALSPIh6+qTgVvk/o5YZM/uQIkuW0RxpUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JU2kJvl4vzfZJTngs4+9eRas7bc5P8dvXdIiMLudPCgCuVYPuyDV+IHyIVlJm6yip47qI2eGzgBjOJD97AmT1hMHrKru0V5ZdK29m7xpX0TL5Vj8aqXc0Zbeft55afqW2h+yLSpTn1Jh2ir8yMAULNp1qh70Zw6Ja/1zy623TJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LVESAgFO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVESAgFO"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35842aa350fso3133003a91.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 16:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775779007; x=1776383807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7CIhqJpO1II+dflKt7LF6AvVPHOYrkF3a/Du1JRh6EY=;
        b=LVESAgFOEdyAdkexc4diLa5a8DoZDkJxqODjhAj3n4eNqp2UXr2AV1cKx+rt0uGDbS
         KiCVCwbfHhGDAWEJTRG/lUtcu3D+6a2RFh64fCwFjcmQAy7IVflJBKQZDgU/EDU89eF/
         btRlN9+kC8F1zrYDgi7kCy7yL0Wz5FNf+dCf1m46zaQCyF+jMVsCtLq5JPoJKkVsaSh5
         YRQ6ZoXREClNsqRj6d0x9u6eearSLrDYDISXkauL7fI9UiFDmww/MzU997ALYzeKH27t
         o+8ns4UvmPjAL/ZnkFqnlOcBjGRWGxDWfsgl+FDKSbWxCzdfCzLgWTa5OhuxvgdV9rLY
         a+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775779007; x=1776383807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CIhqJpO1II+dflKt7LF6AvVPHOYrkF3a/Du1JRh6EY=;
        b=jp0Vuau/7F5v71WPnLgEspprZ/cj12WHKU/ZJi3+zwQNtFozuD18tCEuuKs1ENagCB
         edm/E7RNBNmXP1ZIXNQKP+IUoSxnMq2Q7tWcKxsMkQe2bP1Hl2sn/NiMyMzUAcKHrulp
         44ll16shEV3oS2c4Ay+9RW71uZGmATe5mKRFnkjoMWb+xxyIGljWE2YBx7WAyeAXW4fZ
         DwQ3iWheQVgBOKa2Bbh9eEdWI1sRC8p6qp7mCsq5QBTREiiCzk7RucNP4kkgvCAn4XX/
         DAoDdSvZUgHWp6Kj8UZz0UZdbnfdVI1lVY41wNASl4pNRtMZDUOHb6S3ajYypZo3wHv2
         LyKA==
X-Gm-Message-State: AOJu0Yx2A3MdbvlZTWixnEIMCWAOzYwScPB6Z23pa+CIipakkH8dGgeA
	X9g/WRtIHsW8/+422hJo76DnTqaaQT0VyXL9AVS3ombs6zvxH8QL2Z0hZ0DAxFWcsS5+/gFuInB
	UXsxU9g==
X-Received: from pjbmg17.prod.google.com ([2002:a17:90b:3711:b0:35d:a66b:b3eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c1:b0:356:1db4:8fe5
 with SMTP id 98e67ed59e1d1-35e42869741mr970386a91.29.1775779006701; Thu, 09
 Apr 2026 16:56:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 16:56:21 -0700
In-Reply-To: <20260409235622.2052730-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409235622.2052730-11-seanjc@google.com>
Subject: [PATCH 10/11] Revert "KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Now that kvm_<reg>_read() are mode aware, i.e. are functionally equivalent
to kvm_register_read(), revert aback to the less verbose versions.

No functional change intended.

This reverts commit 60919eccf6764c71cef31a1afeaa1a36b8e5ab85.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/sgx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 4ca11e5ff4eb..5476743b66e7 100644
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
2.53.0.1213.gd9a14994de-goog

