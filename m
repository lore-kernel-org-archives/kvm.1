Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C3239DBC9
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426167; cv=none; b=HOysr3UCUZNQVHTnVRxG54Jo900lphH3F+nDrpkIDPBJPU3AjbBBpakPtxm6xin2DcA7DDH7OaXcM9z87nlF27MPCvZVXGWTroDfQhQe1FVGmLHJ0gBqPN0WIAEl86/paAPiK7QcoQXaJhwtgluIXbnmwooXTN3LGwRas7RXSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426167; c=relaxed/simple;
	bh=HBkgRA6uVgfyEUqrtY2okf9+4WoA/QhXCaV1revLFpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n4GFJoa3EQIlUZdgg3unSxI4a159ms/9GIXMEWn91PR2+J8Ppa6TnzWDwMRmhdsSqwxaNVbTsJPM75nOmiiiv+X6In9/S84CuY3wspWmIDIbnbFJJV9NV13ua2I44BJJkS4r8MQN/Qn42Bp4K8PmZgEDszFPEa5JA1SYSZLjChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OgXPIdSn; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OgXPIdSn"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845bae98cdcso169137b3a.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426159; x=1783030959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Mwe4uem1XSlnKjJx9IUUikqz2qOQzYyIv13OTVMORgo=;
        b=OgXPIdSn8KzQuQlyNFdZJkA4vtLMClEj/woENw9JrvTs+GdMRUGxHwcs3oqbpxJ4ci
         pNFQOWzsZusuPpJlh6Moj8m+T7LgtcoPt178+3PyRSUSC4Em5mvYNuhV32WWH1i7oiQM
         XVwrRLmMCBYGu8+d8cpL/wgKIGpJFPSQG4/p+filUOD/i/DCYPxQ6qzSwD66/15K3w6Z
         qt2G82ybom6U/JuntMnQVPYyNDHDSyNEYeoB86QocZE5uSgZ7WiA55dEGg0ThWeusglO
         POH5A1lOPMOGN5tDbM7/G5xbrvRI1l8S/wvGCAT9aK2cKgim8MloiMnzlHCp9mN1besm
         3vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426159; x=1783030959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mwe4uem1XSlnKjJx9IUUikqz2qOQzYyIv13OTVMORgo=;
        b=dsncHNxmAdlb3hUv78IngpnXIU7A7cvyxCxxk72SiFOGkhoe+CJz4y2iMD2ZotdJtB
         ccm245ko4zAVh1v4mvq864vUm34bbk2bR650O1qj+6FlnPS6lvWx5SFUzc2qsH6WQiog
         5hLdLeqvbDEk9gjdYkTysYLRdo/ZxHlJyiA7ETDd+r1Rj/rTiZTWuxXxFAZ2K4RRTjYS
         t4ayMdt7yUPrtS6aDk41SvTanSHOcdn/RozE19PqGabZsvxzysyTxbZ/NAVPZyS5nm/7
         +CkAQXw0wYkux4Y8B4HycRrU/tmwRFnWLqMzdG4ibiKSOLMQCKv7on7IvIg9AuyCe1Mt
         K4Xg==
X-Gm-Message-State: AOJu0YxBJOxGWeMLNFVP0+wXFoTflwa5SqYmi0PcQGAs/rnT/9L9FA5q
	c8eBMN0QXw8JbKNlflL9EP2fDwWt2NOj/zp04wc2JmvQIyUf4qsHnjIZOrrah74d6AM1ts5j/Ji
	MXvih+A==
X-Received: from pgvh14.prod.google.com ([2002:a65:638e:0:b0:c89:e204:124b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1382:b0:845:363e:12d9
 with SMTP id d2e1a72fcca58-845b39bfaecmr6216939b3a.3.1782426158796; Thu, 25
 Jun 2026 15:22:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:22:28 -0700
In-Reply-To: <20260625222229.3367197-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625222229.3367197-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625222229.3367197-7-seanjc@google.com>
Subject: [PATCH 6/7] KVM: x86: Guard .gmem_prepare() declarations with HAVE_KVM_GMEM_PREPARE=y
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>
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

