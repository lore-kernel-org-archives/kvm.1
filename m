Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE2335066
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787734932; cv=none; b=B3pHRzWaHj5BHej43dIKsujLjPcPhA+6RdNrJ6qBYuwN0SiSQkU1ngc/ENIJOKCEKNgOv6ifhjQ/IXdMmtzEZUXUkEn+aDzWMHgKeqZevvlqFNO1wGR4MQ0duevkmUnI8pPNmD5F5m+sOfV1uB5HAdQx4pSXyKewiYtMLFF8Cg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787734932; c=relaxed/simple;
	bh=wJOyfULGjQ7JJwE+0qiErJO6uCXLldGcRp+nAP+aV5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bM8snXx+pUZfyeDDe9Jxg8IjrokfKOSX8+mj36peEfYq3+kQxjqVruLgsRhBfKX5eg9DGwrGEpBgnC3CEVS5K8dn8gk2oGffnswZRebUmrByhH+A/BqGa4TWtziXcg3odlWrboOchEAuDD8z2LvxizUePVeKa25mw+Wky6iRPqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PUJa1ljA; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUJa1ljA"
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4959c49e054so734180b6e.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 02:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787734929; x=1788339729; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNaAio5F1cBCNtxlrEFoP4xklnbz677Jx5ey+mk7fOE=;
        b=PUJa1ljACwtONDi052/ABCvaWucEVkKwtyCF606XGMgd3k+0d+LMjn/UwcygA9W4kG
         o7SYCEF9AeYQLo9XRIs6jyknlIXFsciefvaJ7dak0mpMbuYMiBd6UJpYQHUkjg+4loEn
         9Zl1LL3jbH3pweW47ijxMJslEVWtWRUOeGzxJ4dwU3bCzZLCuPfPTH9EfD6EZHwP/gh/
         qAmqXKzGkgplzJUCDngTU1D+T4oD+PHLQ/ZQnRtkQ1+OxiedNFM1e13UxvboBYciun+U
         Fw57Rf8ZKgJSgT4IRyVZ5t/LT/1JavO7DkF3zW7024KNw9xI8Rjm9vcnwIZ3MeZC7qff
         oWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787734929; x=1788339729;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TNaAio5F1cBCNtxlrEFoP4xklnbz677Jx5ey+mk7fOE=;
        b=Jr39HS1pa5Of3LyQkevwyOGCjbg3yNkLGXmz7fw0f97gNrmoRQRz9b7pnM6Ekfn8/4
         i1pPQtHa+oxkR9XMhBsM/6j/3oQeN9KRGpkMnpf51KhTEJ+2R0BLgMozyoDWrgHj0OT2
         WXjRY9sDebY0Wqq474L5XOK9nG0cikBsWmB1/YJpc8JXbiNkd/yuWWNzDKTe/k6cOFST
         mP4/cOTzqW+bKED0HIAEZqRimJLqm/XkBIjCiHtK0Rr+2UHG0jyggxMJrAZH8gygoSso
         izIG4Su7xMx4d2XZhXXL6wIyffU2ZavKm2oJgF2K/yvHjucnXvOpXTVzT2x+TH4KN8mO
         6V/Q==
X-Gm-Message-State: AFuF++nSaOnznE7tG3ym8tPomUgZssZ53JAyhIT7dViZFNXYSJckpR9E
	uig6lU8kzRRKqd7M913DIXCHCNE/ZOJIuTITCYkCm9ujR1lSukVkmBJLuf8uV5nAOVRzFfPwSB9
	PPT8LE2A2JAvamrn0whU9ThMArg==
X-Received: from pgnm16.prod.google.com ([2002:a63:7d50:0:b0:c88:90c8:13c5])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2f18:b0:496:11f1:f2b5 with SMTP id 5614622812f47-4b366a4fac4mr6019140b6e.10.1787734928803;
 Wed, 26 Aug 2026 02:02:08 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:01:49 +0000
In-Reply-To: <20260826-gmem-no-return-page-v4-0-3bb9c1ddb4e3@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-no-return-page-v4-0-3bb9c1ddb4e3@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787734920; l=1353;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=wJOyfULGjQ7JJwE+0qiErJO6uCXLldGcRp+nAP+aV5k=; b=z/jEqpUrNgcyUxL/Z8M0h+X83m4nMTDrvNZG71fmUEG3iFGsl8CB+iONKXlWeTPtqJt/DJfsA
 fXBzpO0jrAZBZvXSyzkSiu1twbOvJ+XRsMxmMGFlpjbWacNRwyM4Zwe
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-no-return-page-v4-4-3bb9c1ddb4e3@google.com>
Subject: [PATCH v4 4/5] KVM: SEV: Drop page refcount early in VMSA reload
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, David Hildenbrand <david@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>
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

Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/svm/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f9dce8acac8eb..f094b19226b92 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4078,6 +4078,7 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	 */
 	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
 		return;
+	kvm_release_page_clean(page);
 
 	read_lock(&kvm->mmu_lock);
 	/*
@@ -4092,8 +4093,6 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	else
 		svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
 	read_unlock(&kvm->mmu_lock);
-
-	kvm_release_page_clean(page);
 }
 
 /*

-- 
2.55.0.887.g758fc8c411-goog

