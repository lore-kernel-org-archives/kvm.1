Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D037F737
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782515687; cv=none; b=diz/Zwe7371CCALZNrZrDvSM7b8EgxdaXo4tsc38sQ5DgL/zUEsfwhWcY0xDmBw7ii79MEDv9YyDRBTwMMnrANe0Q+Cb7ii1I8jbbwgbGqSs38bySR7w6x9HOuMJPW1TWP0LWmyYM34dHBCGyD8kI6VRDEwW1GfoLjURpJk2aIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782515687; c=relaxed/simple;
	bh=HBkgRA6uVgfyEUqrtY2okf9+4WoA/QhXCaV1revLFpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k61i6WKkA5smZ+ON9WK7+QBLA9099mwpfrlFkzy861gEVsCvsesmBrBrOcSL598xVNUiD+aiATU9FQTJoaZ9Jq6cgjFZjCHlktNaNn5uqEdMytlaYZgVgvgWKFWSIOiPKDFNf3sQl+aA3AT7b1cFQC50nqRrC/X4fHwHTSJ5C9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ia1Uz1nA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ia1Uz1nA"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37d4f23eb37so2024600a91.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 16:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782515668; x=1783120468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Mwe4uem1XSlnKjJx9IUUikqz2qOQzYyIv13OTVMORgo=;
        b=ia1Uz1nATbqt8fvHKlTNZ238HoMJyn2nMBPY5FeHb1oUTlvncIn3vsNK3VaXKw97B3
         bXS80Hk+v/tosyXZrd8Icia6gOUSbXissq6mBTEV520QG0R61nP82HI9oLvw9jV9yOPJ
         BVR3hqJTv7PCj0NgR5Mb/TnhGeaQOtkYS3ntEtWX8/uB56VLH4DyRAiK3a6oh+x4nzOz
         q7UVSQvD5CkMLesaIzQFyqGEHMZpScyhMmEuwbnz0GHG2rsQobPPVdViYWi+Q9LgcFQ9
         iFt4Vt0L/UWP870D8v4LKFRfGxzb7WhEZXQy9OakCPgyU/mnnP8H69JE+re2288VrQ3g
         wrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782515668; x=1783120468;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mwe4uem1XSlnKjJx9IUUikqz2qOQzYyIv13OTVMORgo=;
        b=gCpZnErmTznudOioSdEOytoEOqJh4xAbgxcxwXAx52/gtCMuDoopbcG88+mGDxWF1r
         0v6V5fDvAd4x3+K8Ip3CzppvoDw6a1XC82OdTqzH8+6u+geesGpV08iLRL6cILaEpSEn
         tHa9+Z7KXlkMKywwMo3GEdPOeyd4qSO3y9MjMi/oTU9ncEGRNixxf57XP2DR32jmE0Nv
         ilVt8OuQudZOfRpXPLGoY79XP+3E1HYMa4fOR2tvvnPKdkuDy1Xc5KYRjZiy5hB6OAJb
         pt5dNSv8wiwubaQ3oRmf2XtJMupK7mSub8jO4XyY4LoiKe9VfEUcWutKo3iZbOIj3Gl1
         /yjg==
X-Gm-Message-State: AOJu0YxdRy18hJs4udz2gNtEiKRo3pWxIOM42cObyjqogZNS3qqXALRG
	pgSQXzfRskpX3+BV+IRGDrxBbT1ws9dnU4Nk1vOldgnbCWWvKZo5A918N6Uchs4sofHMnq9V8dQ
	H85f9xQ==
X-Received: from pjbga17.prod.google.com ([2002:a17:90b:391:b0:36b:bc13:f5a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52:b0:37f:9ce3:ca95
 with SMTP id 98e67ed59e1d1-37f9ce3cb1amr1839395a91.30.1782515668073; Fri, 26
 Jun 2026 16:14:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 16:14:15 -0700
In-Reply-To: <20260626231416.3943216-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626231416.3943216-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626231416.3943216-9-seanjc@google.com>
Subject: [PATCH v2 8/9] KVM: x86: Guard .gmem_prepare() declarations with HAVE_KVM_GMEM_PREPARE=y
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Wrap the .gmem_prepare() declarations with HAVE_KVM_GMEM_PREPARE so that
non-SEV code doesn't try to wire up a callback without doing the necessary
enabling.

No functional change intended.

Fixes: 3bb2531e20bf ("KVM: guest_memfd: Add hook for initializing memory")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 4 +++-
 arch/x86/include/asm/kvm_host.h    | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 69ca2a848ad6..fd08454c7553 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -146,12 +146,14 @@ KVM_X86_OP(vcpu_deliver_sipi_vector)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
 KVM_X86_OP_OPTIONAL(get_untagged_addr)
 KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
-KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
+#endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
 KVM_X86_OP_OPTIONAL(gmem_free_folio)
 #endif
+KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
 #endif
 
 #undef KVM_X86_OP
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 776272dc6fdc..ee47a0d1feb9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1903,7 +1903,9 @@ struct kvm_x86_ops {
 
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
+#endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
 	void (*gmem_free_folio)(struct folio *folio);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

