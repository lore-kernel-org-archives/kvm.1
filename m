Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B269339A4C4
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268771; cv=none; b=Eir8y62vgl1cYgUl/O4n1vrBkH//A5k9UWQ8tj9KUqxA2ne92CGpP1DQNBbpl+CGU5qJuNM+XqBN18Y5/uCJ11Kf6VeI+O5todJNLpBpoI3YA0MYEIWaKDNRMFx4YGXo4XCjJr7ulacrfdhJJRGARZkD7GavRl6EO3GnGho/wdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268771; c=relaxed/simple;
	bh=1sJotEgA8ehiPs3J9DAGu4AbZ2bnjjEWvNkwbMlJckU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fEovN16T4C4A9BWNqZt3ubzIId3lfxUG8B4YQkj/zNpCGLs/WPIZ/po2mP7sfbBsuQ073p1KRcdDgQoRfe4xHyKDX9LS+JuhBqKlJypIspWpROR+wWWiO+IDyZk0LEJA0fj50A36zVZviB+rTg2MJE1efA2uTWezJ53h4oj0KAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6T6Wv+7; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6T6Wv+7"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e048a801dso469890b3a.3
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787268765; x=1787873565; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D9DlHJtu4nYE/0Q7Tlo35sv+3vAygx91goMAZ3ynrq4=;
        b=k6T6Wv+7k/owLB+flVvGutMx1PlrVtxMdLjFhSbvL/j7uz/Q4R3lJ7Edl64397L5eW
         mlOBHIRyCozdIVxe4jRhFXEY/a6zC3vgUPH7sFYxXg/qYj75rYJab6CPY8BFaIizPykJ
         0WaHeZc2nJl4CfM3vNXubTp7TtduOSGzI0beLNl8qstNwzB+3ex9WYaSmcj04bTjVw5O
         bjHjqXzC/VzMmjFwitr+3GmMoHJbyM9nFM3Z7o60P3On0DLs/O33V6y4uuZZrf98BbaC
         4Dp016aRTR2i4tleuK8+UDu1t9ch/7+X75Z+CkNHe0r/aRa0Eft9vuvWGFwgz2fgAxBs
         vLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787268765; x=1787873565;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D9DlHJtu4nYE/0Q7Tlo35sv+3vAygx91goMAZ3ynrq4=;
        b=KNxYqzJ6HHEq+V0pruirHZMsBvBl7vb77sb7sfXms2UPyOZrlAIAj+R7dHuXsfVzaH
         5NMPK6jAsls+jX0uGe6GRzHNOH3we4n2kked1Po3SdyxVTpIHeJj/1tPtcpBPrh4qxQo
         T4JRhCmwY3omyIa0zTMc1P/qmDNVXNhMSEdqAPyJCnyfSAiqx1deigZovfN5a6fjO6FL
         CXFuKJFvkTAqiChOUGK/fd2rKO8XPhTuHGSgXR9tNFtE/Pu4bgFbzWi+ENZGoBMXMHU2
         NwEWS8tANsF/DEhq8Zrjku+uBYE8xNSOGfY52XIo0GcK9ZTx8rtPg8AGSJuf+4qupfFu
         +lWA==
X-Gm-Message-State: AFuF++kV3PpxVzSIjp++13incyTehU4g7IciOxWQUfHS/u1Z7t6DCgoD
	lXXTydnPvmCtrGHq1CQXW2m5+DFcu7Oy5p9z1hF8SDQvzKevcRqOGAZyDZhYLkjS6GdVStC6S1m
	uxHRgy/S0k4zv5HsrqrGIIHcMPQ==
X-Received: from pgsb12.prod.google.com ([2002:a65:67cc:0:b0:cc1:4df5:5acb])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8010:b0:84f:a170:4f5b with SMTP id d2e1a72fcca58-851f9aa7714mr2971480b3a.8.1787268764952;
 Thu, 20 Aug 2026 16:32:44 -0700 (PDT)
Date: Thu, 20 Aug 2026 23:32:36 +0000
In-Reply-To: <20260820-gmem-no-return-page-v3-0-3bf8f80a7b4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260820-gmem-no-return-page-v3-0-3bf8f80a7b4d@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787268758; l=1353;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=1sJotEgA8ehiPs3J9DAGu4AbZ2bnjjEWvNkwbMlJckU=; b=x9w/WvPH12uIL2DGAb5DL+tydH0mG6AFPF/kocY0XpSFzUkQYU6qgERR2lFjs4T457yY7MM0c
 q7HGbnpu+exD47dSoIA22tQ/jsBNKwgkYwIbWfbJghtPXWJ6s+RH79A
X-Mailer: b4 0.16.0
Message-ID: <20260820-gmem-no-return-page-v3-3-3bf8f80a7b4d@google.com>
Subject: [PATCH v3 3/4] KVM: SEV: Drop page refcount early in VMSA reload
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

Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/svm/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 563870342a2ba..0375ef709ee2c 100644
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
2.55.0.766.g2966f0265a-goog

