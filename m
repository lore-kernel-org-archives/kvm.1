Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339B3242B0
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858372; cv=none; b=IgOqmWNlpIAuyCSookGoXHnZGGnPbcN0cMJ6XUM5oe6uJ28k0GFg1MrvyzyZ9w3c7ySuaBGuj76U4Pfozjux8ce8+fAheLCyHZImPI94zsj6klHmz2/HsfdD546aKz8XENCpuKiWxx1iFu28zkxyV83juK4d4rXF1naJc9VfjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858372; c=relaxed/simple;
	bh=uVi2Chp1vV6EahdIjFvu+n1EWpXA4p58psRCFDcnczw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tzistqY2nqW/0Zx0NUY949XY9y4DrLxVVZyHBqREcqdXld1nLJtPWN0BGs2J1R2GFeMUNR8DodNH+KhM/K/p4UAilQQUkmJlD+C+Q/7nBba26K1sT3IeQsIa2RqiCYWDhxQyVuFWNSXoNnI1iMWOml4nmn/FxJI1rJfrug5PFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m//vPAst; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m//vPAst"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c825562f8bso229005ad.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858370; x=1783463170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1Qg5ogp3hVy4JjWswKtD5TCuxaTIlYXYqGp8/XcN0yA=;
        b=m//vPAst7MKC8YDhCmMKfDXBpr3t0QRllxiw/0DV7Cnst33gQvUnygKQ25ThQdaBYd
         di+qFbMtFRsLfYQgw0oImrThRF/hbCW2OFGfUUd8sq5CY6GuiQOdzPJc8st3Lzf07NqQ
         Yep8bjT9+scuqJzJ4d0LXgprbGj/qaY35gy6D8mX1YP5lqr1N2upuEGxHWzdfxCB4rtD
         oI3SjVprdY7+duL6QTr142HWpTM2RLXKBGxsyi7pVAoTfEon8h1BDAWluJyWE2OUI9Ai
         drI/Pbu65gcoUyCbGHtFfpyPzwcAfZoWXqw4DOaSC+dY8TnXwYdOiBnvHPOd8tbUxRML
         VJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858370; x=1783463170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Qg5ogp3hVy4JjWswKtD5TCuxaTIlYXYqGp8/XcN0yA=;
        b=dIx9wCtNKh/j9hgsT8aM0LFBvvoqbzky4fkC4TKKMKyQltoXS8amcBJvspESZbzljH
         5mjeagwXeHOxPppw4/BIvtAwWkE6uTLN513mVgWOfbglHxkEHyXYl1jBuKER2p7RSu9O
         CNrksVSTID85LyqH8z5SE1BhQSEiNk8wrxQI+Dku37xya4dD9A8Yd8q357MdJqdCHENL
         Y4vPuQnHEP/8j8DXAJTgqrZK4ZG+4uv2xBSAssPJGJNHxCl6ExuX46KQGRQzZ6Sc0kUc
         US50lBqZEw/d7CUXinOEQo6UeqOJ7EJpxw1nwSg0gcr3jpGnMg9SiJsGF3bPfrvvFncn
         G73w==
X-Gm-Message-State: AOJu0Yxgx+5XzS3aUNsU6w7GD3TdApYp0U2Zuo+bz/gh+yZPy5Aj5shj
	PNPOWnRecHl2/iuPiB/MxcScRUiXxZ+n+l8fZHS+Gl7+ph1C3nC+waPPogQSj76dzutlQznbAZP
	jXZFloA==
X-Received: from plok16.prod.google.com ([2002:a17:903:3bd0:b0:2b0:ba5a:1fe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2a84:b0:2c9:d88e:f996
 with SMTP id d9443c01a7336-2ca2d580115mr46689875ad.9.1782858369871; Tue, 30
 Jun 2026 15:26:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:25:56 -0700
In-Reply-To: <20260630222607.497895-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630222607.497895-2-seanjc@google.com>
Subject: [PATCH v3 01/12] KVM: SEV: Track the GPA of the guest-controlled VMSA
 used for SNP guests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Track the GPA of the guest-provided VMSA used after AP_CREATION events when
running SNP guests, instead of simply tracking whether or not the vCPU is
using a guest-provided VMSA.  KVM needs to know the GPA of the VMSA that's
actively being used so that it can react to MMU invalidation events, i.e.
so that KVM can drop the VMSA if its backing guest_memfd page is punched
out of existence.

Opportunistically rename snp_vmsa_gpa to clarify that it tracks the pending
VMSA GPA, whereas snp_guest_vmsa_gpa now tracks the in-use VMSA GPA.

Note!  Take care to track the GPA, not the GFN, as VALID_PAGE() won't
behave correctly if an invalid GFN is converted to a GPA for checking.

Note #2!  Keep snp_has_guest_vmsa so that switching to a guest-provided
VMSA is sticky, even if the guest-provided VMSA becomes invalid.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 14 +++++++++-----
 arch/x86/kvm/svm/svm.h |  3 ++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74fb15551e83..827f5dc06102 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4003,6 +4003,7 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 
 	/* Clear use of the VMSA */
 	svm->vmcb->control.vmsa_pa = INVALID_PAGE;
+	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
 
 	/*
 	 * When replacing the VMSA during SEV-SNP AP creation,
@@ -4010,11 +4011,11 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	 */
 	vmcb_mark_all_dirty(svm->vmcb);
 
-	if (!VALID_PAGE(svm->sev_es.snp_vmsa_gpa))
+	if (!VALID_PAGE(svm->sev_es.snp_pending_vmsa_gpa))
 		return;
 
-	gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
-	svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
+	gfn = gpa_to_gfn(svm->sev_es.snp_pending_vmsa_gpa);
+	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
 
 	slot = gfn_to_memslot(vcpu->kvm, gfn);
 	if (!slot)
@@ -4039,6 +4040,7 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	svm->sev_es.snp_has_guest_vmsa = true;
 
 	/* Use the new VMSA */
+	svm->sev_es.snp_guest_vmsa_gpa = gfn_to_gpa(gfn);
 	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
 
 	/* Mark the vCPU as runnable */
@@ -4105,10 +4107,10 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 			return -EINVAL;
 		}
 
-		target_svm->sev_es.snp_vmsa_gpa = svm->vmcb->control.exit_info_2;
+		target_svm->sev_es.snp_pending_vmsa_gpa = svm->vmcb->control.exit_info_2;
 		break;
 	case SVM_VMGEXIT_AP_DESTROY:
-		target_svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
+		target_svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
 		break;
 	default:
 		vcpu_unimpl(vcpu, "vmgexit: invalid AP creation request [%#x] from guest\n",
@@ -4791,6 +4793,8 @@ int sev_vcpu_create(struct kvm_vcpu *vcpu)
 		return -ENOMEM;
 
 	svm->sev_es.vmsa = page_address(vmsa_page);
+	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
+	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
 
 	vcpu->arch.guest_tsc_protected = snp_is_secure_tsc_enabled(vcpu->kvm);
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 716be21fba33..d077783c287e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -271,7 +271,8 @@ struct vcpu_sev_es_state {
 	u64 ghcb_registered_gpa;
 
 	struct mutex snp_vmsa_mutex; /* Used to handle concurrent updates of VMSA. */
-	gpa_t snp_vmsa_gpa;
+	gpa_t snp_pending_vmsa_gpa;
+	gpa_t snp_guest_vmsa_gpa;
 	bool snp_ap_waiting_for_reset;
 	bool snp_has_guest_vmsa;
 };
-- 
2.55.0.rc0.799.gd6f94ed593-goog

