Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656F326939
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855448; cv=none; b=kwzXbKplXJ6Bf4CeEJoNa3RTRIxotyf6dXNzqPHEewcr0osX3qCTkKOnEdsawxBDTClOXW2TZOCDkaQSS4Wl8YRluCDNGnzG4wJdAaUWODKbkxDp392y7ka71/vRi28RBOURNCHH4ZrwlTfeMRTUn49TrosgDMNvVJENPZ4T9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855448; c=relaxed/simple;
	bh=PfL/KrfF/nM4dCO0Bt5k6/6q2wcRo8P21hIe83hdWwg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tibkBnfRYqq9o44CeSOevdzb6498mav+mgJ1+HnwktqTUXgIh0lyuu9s061WVWPYi5iynhDnqR5Ur4W+pww001vCVcZBtt83uMMHEJI09/DvpRql9ESjNZqibB9svG7WEXtAN50Nwk5Qy9fW/Z2mkBOaYctVW4rYgASmKlKlo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PtBlWE/H; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PtBlWE/H"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c987913b08so125475ad.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 14:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782855436; x=1783460236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TOW0Zc3HQX5JVoEMdXzsZ2+bZzhBD5tvhepZcMxoBvs=;
        b=PtBlWE/H5lwLQ4vcJ7N8VTZQ5rYzamkPxSrmok/2/G0ZRbu7zUpY5SK6fwyfxrDeE6
         zGAqvkzKQznmE0S6b9wm51TohnGMlPLITg/AEhFXcn1SeYSpSM0yqR9lZAC9wH81fU2T
         EW6iCgnY99hj6/7Br/HSiM0VrXvRufZaz5TAhpwFl1Ijn++cXKKg9i5ENCXs3yCZYf1X
         9wc9JcCXWfVd3okHNBEGpbFwXGhFCRjGp45XXtOtQRHDe1i3yyYlWTatKswFB7YATBLY
         7uWmKOtkEY7l/saIOzl57aj3d4jWDqtJ0oUwu0aC8JM1U82deUYzXVi/4xdr+gdwC0QF
         eYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782855436; x=1783460236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOW0Zc3HQX5JVoEMdXzsZ2+bZzhBD5tvhepZcMxoBvs=;
        b=ntD6otX18FUSJD4nO5yWHke+ZEVEuApim5SHrAUnbLI4M1OS6soV2+V0JKzH+4+/6x
         eNCkcb0B9ym8x3lXfZ/2evIFNNhAyazvX094YKRQTwfn1Afxk2yeHoEsnfMk6fYYSu8i
         nBmVMxwz2Swh6IcCmtVvUuP7XtZshAYpbrqlbDgvfONqSi0ZSSQQ2A+H7xNY4ZVXbDab
         B2Q/mj1lmQFcXHWrqYrHs9UxguVUEFEHBij/qY7knVddmTsW0ghT53fbDHvFzYzJS5uV
         InFS/t8ac7pjssut+4hMh1ZlcwC8PWm8hmC2+CP8R27DglkwLRqmUcf2zopMCS1HtIOA
         AXCg==
X-Forwarded-Encrypted: i=1; AHgh+RoBCIjMDPttT48AQ6JEWdoVDHRixB87akAkMmR7EynIpId96+jJ8T4bPz5ZFIj7U8FisDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu40fy7SP18rntPjiSNUgC+Sd92LQTk9p3X0UG688kztcUST3F
	Q0HOn+70LCnCgAu6FeYkhjIql8f5aM8KxfwB5lGeaVNIjRuH9c3Or7Hcu5K0TPJte6CEMs+tR5m
	cz1/n1w==
X-Received: from plcl21.prod.google.com ([2002:a17:902:e2d5:b0:2c7:ed23:f48b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e949:b0:2c6:9f6a:9f6f
 with SMTP id d9443c01a7336-2ca5a5eaff3mr18323585ad.28.1782855436276; Tue, 30
 Jun 2026 14:37:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 14:37:11 -0700
In-Reply-To: <20260630213711.479692-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630213711.479692-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630213711.479692-3-seanjc@google.com>
Subject: [PATCH v2 2/2] KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL
 INIT_MEM_REGION source
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Return EINVAL instead of EOPNOTSUPP if userspace attempts to pass a NULL
pointer for the source page of INIT_MEM_REGION, so that KVM's ABI is
consistent between TDX and SNP (for LAUNCH_UPDATE).  EOPNOTSUPP was chosen
to be a forward-looking error code for when guest_memfd supports in-place
conversion, but even when in-place conversion comes along, it's an awkward
error code as KVM is deliberately choosing to disallow virtual address '0',
which is technically a legal userspace address.  I.e. it's not so much a
lack of support as it is that KVM reserves address '0' to simplify KVM's
internal implementation.

Opportunistically move the check so that it's co-located with the other
checks on the userspace address, and so that it's more obvious that a NULL
source address is explicitly disallowed.

Fixes: 2a62345b3052 ("KVM: guest_memfd: GUP source pages prior to populating guest memory")
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index ffe9d0db58c5..b0ec054732b9 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3198,9 +3198,6 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
 		return -EIO;
 
-	if (!src_page)
-		return -EOPNOTSUPP;
-
 	kvm_tdx->page_add_src = src_page;
 	ret = kvm_tdp_mmu_map_private_pfn(arg->vcpu, gfn, pfn);
 	kvm_tdx->page_add_src = NULL;
@@ -3247,8 +3244,8 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
 	if (copy_from_user(&region, u64_to_user_ptr(cmd->data), sizeof(region)))
 		return -EFAULT;
 
-	if (!PAGE_ALIGNED(region.source_addr) || !PAGE_ALIGNED(region.gpa) ||
-	    !region.nr_pages ||
+	if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||
+	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages ||
 	    region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa ||
 	    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
 	    !vt_is_tdx_private_gpa(kvm, region.gpa + (region.nr_pages << PAGE_SHIFT) - 1))
-- 
2.55.0.rc0.799.gd6f94ed593-goog

