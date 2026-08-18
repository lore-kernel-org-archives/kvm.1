Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D7431E74
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044566; cv=none; b=MvpHWBCjli4OyheYHB6hRqZ5GdTmBYko2hWzBSkx6HLIl3Vc8424FHMdoCyirJ0eCt++tOA1CTBah7AO5EEF9X3APXcXHPiO1uIBqqWTYvZiYz/485x+bghxMXAPXMY1QcEn9HbLiOoDSARLRNWLeSw1+Dwa5xREtfzzwwNFMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044566; c=relaxed/simple;
	bh=Eu6toHOdCgS02ZJDxNjsrmINE4rufXfvVtLn/P5Q6r8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=klTXIxXAfRuKQ0rJz1FRJV1lvbAkJyd8R7cjR/+lUT3UyIFrU4dupEGZSUQPEvycK7doreyhoJU0RavK47O3UVpjMXhLp2TZF73TpkqnW9tPIrvb4u5tMpb44ORy7scxCK+l1VnPmjrvvx+Zja6CaqHhbfPviK2mOv0dLwr9ll4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K1Y8eF4/; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1Y8eF4/"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfc52ddc55so72285855ad.3
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 02:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787044564; x=1787649364; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JcYyJmxeOItQm57PoOzTDELkKzo8NHBgHiqMw1DpJFo=;
        b=K1Y8eF4/BfUF+J4iyXE0Oa41seR4CU+oiFBMdsUfp3uNW8x8dnahtiaPROB57SDhDx
         pZZH4yQ27tzvSQs/Vx8fYYiIRmee9VwP/JCuYbem4dWNrPU9qGYDLx+abfEBUdynA4Oj
         3sgQE9fuRufEmvaKJXUNMZ0x3dHMh7k2jvMwfcEizeMxlw9C8VC3agE3VTGm8qUGz2Wq
         RmhCTEsfejWir07gcIbtF736+Ym8egfzk/9pWW+dPAudrPyMYZrIJr1TQfw2/FVkEwRr
         cE03xxYiemG0nl/a3pbxnyV6m7M/vsNel6AAAXurWLJSqeAqol0p1zeSvD3XMUDOjRmP
         Drjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787044564; x=1787649364;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JcYyJmxeOItQm57PoOzTDELkKzo8NHBgHiqMw1DpJFo=;
        b=L8QdGJRsAQ2Eai/j+Xd784m1BeqXxaUVZEKnpR1Vsc2nXoOQiayREdE7+lWHTaJB61
         icXucUFHa3NKSEsKGWlRq5WTeXVWKdoaySyMOKoqJS3zK60FCaICfq5UeAXTRnDwbL3+
         GBdv2Mq+pq9IrqfBRHjMoQLRqbOW3LI323GLCmF+ZD8oC+Qas4A0A+vE/doplSybjoCH
         +Yg/UOd0hAKljx4NT85ZiqRVDnuJbh8cM0lFeCQExlbrOPSXiVwRb3KpQyD2HD50mFCW
         U+XvULMlPFwBUdDB1FTeIwp+yayorRDsTJf/L1E5YtMy9RQu9DY2RjVnaT7oen2FVOP7
         iUJw==
X-Gm-Message-State: AOJu0YyHTBU5Rn3ZiSFkgQ4VDxsEv6k6n+O4+OjSr6uKUStcDeRvRt5C
	VwOw4bodQRsM0dRVuW6CAVPbWhv8DP5Oa9Iw7srdT06BL5xZyL0FKmtsWu387TKtRys8N6rMSRz
	a++k5ByXSJ79Y6r+QeTGMTK6kEA==
X-Received: from plbz21.prod.google.com ([2002:a17:902:ee15:b0:2c7:de3c:549e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:b0b:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2d3b0c7ae46mr360869955ad.10.1787044564080;
 Tue, 18 Aug 2026 02:16:04 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:15:54 +0000
In-Reply-To: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787044557; l=1303;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Eu6toHOdCgS02ZJDxNjsrmINE4rufXfvVtLn/P5Q6r8=; b=4r394TRlnUkgQelNG88PQ96qVChnPFNFyot7lT1B9nuxLhLRLmkhypwFy2Q1Jy4P+LuelDJE+
 4XIVWacJ6u5CilOKJv5z0iQvoHdCGx3UqOwDFsxlX70DzaNRuHKHs6f
X-Mailer: b4 0.16.0
Message-ID: <20260818-gmem-no-return-page-v2-3-5298f42d49bb@google.com>
Subject: [PATCH v2 3/4] KVM: SEV: Drop page refcount early in VMSA reload
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, David Hildenbrand <david@kernel.org>, Fuad Tabba <tabba@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

When reloading the guest VMSA for an SEV-SNP vCPU, KVM retrieves the PFN
from guest_memfd.

Drop the page reference immediately after retrieving the PFN instead of
holding it across MMU lock acquisition in preparation for a follow-up patch
to stop returning page pointers from guest_memfd PFN lookups.

This is safe because the page's validity and presence are governed by KVM's
MMU invalidation protocol rather than the page reference.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/svm/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b34b11d7f8fad..d3d620bc04dce 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4062,6 +4062,7 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	 */
 	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
 		return;
+	kvm_release_page_clean(page);
 
 	read_lock(&kvm->mmu_lock);
 	/*
@@ -4076,8 +4077,6 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	else
 		svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
 	read_unlock(&kvm->mmu_lock);
-
-	kvm_release_page_clean(page);
 }
 
 /*

-- 
2.55.0.699.gb54405d56f-goog

