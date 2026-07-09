Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AD33F8242
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630206; cv=none; b=CSEvKMwmh8BVPyze/llX1Sz2jM0yv4rwWePGgvgd9nE3H7dewkqWnAp71nwtNCUIsLPWRCFkHOXtCo9J6IniOWLooYhPVawvvb+BolingXBQXxWGw9b4JBdCJRvO7KGD4TJBplQ8gzzv/6QyKoTg8zLgYAjc7Ue+b/DUP9aJAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630206; c=relaxed/simple;
	bh=67+2ixgczuWH0xlq2lmC6epK2acaFTRu7sLuczDvNWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iQez/JJQMNATcEf3AaZoiOZVUgVzuSaIOB1hEaLSMEsBaYygWBlZnJgy+1uiftHI7/lxCOyNhzJ8Wj92sK9r55bK+ZcgkxS9wcihr25xvEoiE25xHEu4VzfDfRoH1IqeIFXaRsO2Vw3ZMUdmNO21HRnVv5/uJ1OAFfgxvUIGpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nkuExMUE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nkuExMUE"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cce406883eso1334375ad.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630204; x=1784235004; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1nop2shpdxNKhn6ES/w/pTYIsFm7ZsGHZU896E4weFQ=;
        b=nkuExMUEo4QPEx34DQpDz9RW9HxFOVsYTdJXfISc7/W9TAyekBd38NgiGSIzNF7A02
         HeGtc0PmIuFIUGAMjN7L6JFurT/SJ1dAtpoH2fIsJ35xXPgJPvWNdvuCTVPHBvsyKYlk
         GVL1EU4l6g/QW9uPytgdbvbW9EqePDXUZDx4jML/18Hiru3sbzSDBe5eHLnvHb/kHuyz
         DFhOEyDxfjFbSbGPP7kIZFeh1Hnv5OcoIARsMDTNcVT9kZzKG0KeUrT35SxRY6gdmMOS
         fuJhHC7asPXGAJFe+vYD7gB4+t30IWD3jT46VcfQcPiaI2zIAXlYnBOrhutF177R/fyF
         eiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630204; x=1784235004;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1nop2shpdxNKhn6ES/w/pTYIsFm7ZsGHZU896E4weFQ=;
        b=fijEbV1RKQK2CI0ppPjDx2uy01fOrGJu7JRz16X+FmMT3tGIFBi8Y2SZDwn9goPSO2
         /KoAYJJWu+d+fttF3EfZqiO8P0/7md6UwzM5FwLXv6pIf6iWzP35vqxl/KMUFOuvouIt
         +FvjrN7lrQvKEeNU8gvOCydBc9Fabx4/uDTmank/uZr8UDoJEUpXC2xfhssuIO9/LJ5X
         BBviCGksFz9o6b5dQu73ukxbplbaeyeuyqziPwokonfrvqXRsor0KsIO1MLY9nJ+fUJu
         olKkXnZUAzf7HKzTE9GNbuf2YHpNdV6qw8GIy3nM1gndGjySNs0SxT557hpZQjhoI69Q
         sB+g==
X-Gm-Message-State: AOJu0YwdDCvj59OqvqBgry0t/9xK3MwFK9dtHGWDDla2/Yt9qTwffiBj
	o0ctQpfVJG12krr3Oj13nkybiwb/qExYyFJo4FX32M/2fexCfE8rb0ds6p28lQPPLHpylNAAzbt
	KwdKAlQ==
X-Received: from plbbb2.prod.google.com ([2002:a17:902:bc82:b0:2ca:97d5:9cac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d4e:b0:387:e0db:bc2e
 with SMTP id 98e67ed59e1d1-3894249c60bmr8360236a91.36.1783630203855; Thu, 09
 Jul 2026 13:50:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:42 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-13-seanjc@google.com>
Subject: [PATCH v4 12/18] KVM: x86: Guard .gmem_prepare() declarations with HAVE_KVM_GMEM_PREPARE=y
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Wrap the .gmem_prepare() declarations with HAVE_KVM_GMEM_PREPARE so that
non-SEV code doesn't try to wire up a callback without doing the necessary
enabling.

No functional change intended.

Fixes: 3bb2531e20bf ("KVM: guest_memfd: Add hook for initializing memory")
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 4 +++-
 arch/x86/include/asm/kvm_host.h    | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index ccf23b3f0e1c..736129db272a 100644
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
 KVM_X86_OP_OPTIONAL(gmem_invalidate)
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
 #endif
+KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
 #endif
 
 #undef KVM_X86_OP
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1c598b40e0c3..1f8ef0e1566a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1903,7 +1903,9 @@ struct kvm_x86_ops {
 
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
+#endif
 	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
-- 
2.55.0.795.g602f6c329a-goog

