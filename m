Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0352F7F02
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 23:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782515662; cv=none; b=Bk8GmslvIufRpQuN7uwnj8njVNecmIc4kF+Cy4Eqsh2hftIBSJlwcTI7ed3hFA6GoEOrFAMIUBgiNi4XRueWV3hTdQiC2UHpE17S0wjCE/e9r00AsVkEoZj6xxnc0EmTydoS4Oi9pwSNA0MudqJ8VfCxkJLX+AiWzMWWobykRGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782515662; c=relaxed/simple;
	bh=uVi2Chp1vV6EahdIjFvu+n1EWpXA4p58psRCFDcnczw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E7QoALgiS+vgppmguv85qNIDwZB2DV1gkQnsthshtUPCRZ7v0g7n6TYzTByeBSrZOIUqgyS0aL9gyD9ePTuaw3g/bhlxe8bFrlZL5WPfV7xF3/HX0kUpjKInpA7/WnoxUdxLkIKhxKeA4Jg9KT/otwvJrSdTTbfW1dDvrIMi6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nt9dtX0y; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nt9dtX0y"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37d4eede8ccso903253a91.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 16:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782515661; x=1783120461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1Qg5ogp3hVy4JjWswKtD5TCuxaTIlYXYqGp8/XcN0yA=;
        b=nt9dtX0yPtiwS99kWbUCTsfFTKqzwahtA+ODRWOxGB1/10+JM6YOIMsfamROLyTz21
         z/HMdAspZVrZg6mh5mty8Of2rRukb07zZA4QGGA6p+zMoLnljGrkzvdnJKvv4+pNuKMu
         BvOpumFYdxqfnXHl+MLAKtxYkZdtfblKDV8fKXlUTRMc+psy687m2R0UHeARkJuS3R6L
         EmiVaHgRvBlhB/52tKLNotDS65Mq4JOiKrdM4KWJWTGxTp+8c6NxWP4dTdXxTmHm9Ijz
         +csiWZiwbwVgQnnFqp8hOe+Cf4KgVjKYPhI8sEkCNrANkEVSCBycmmyLo7oNJxTDBLK6
         CjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782515661; x=1783120461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Qg5ogp3hVy4JjWswKtD5TCuxaTIlYXYqGp8/XcN0yA=;
        b=EmFSY3cB9Fz4h836XjNNnE3Y/ytOcWwUaJy4+KTJDT1bpI3Y6RYQjl+Zk8Ew3TQNdw
         GMQs4f4L5l6Ac0xP5KZA1S3g8/XoumU+kQf7wrxnyqmYgHJnDp7e1YFA+UHGtOIjoqi6
         XJZVLSA0VpGZ/xiJcy7dVchDgFU5zZdPC5A7xp9k/A0if2pznMU6Ga43PlohulJO0ZQa
         uPyW+06CxrsOpZb+aRhf22XZBCYxc0Wj4JsRNaCBfwV73aLNQv5ioPfsobqV6pjcNuTn
         wemQ0e/3SEXlFX/aZT2rBeL1mvZhFYWzNc9vbfpxmKUzaK/7JVOHYnpq2x7s/qgAQtOQ
         fbNw==
X-Gm-Message-State: AOJu0YzS2Ix0hWIYgqOt5BGuyIRChdgDQsT3s1BaIJB/OlXDufw8SWNK
	glu/moUa5i4wrlOjw+NIrCaEBeORuitPBPKb9NJe/gfpktTLk/vWFKXWhM1ljxq97MLrfH728vH
	wOAlciQ==
X-Received: from pjxu15.prod.google.com ([2002:a17:90a:db4f:b0:37e:f87c:928a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:46:b0:37e:1ff4:44c0
 with SMTP id 98e67ed59e1d1-37e1ff4463cmr2880873a91.12.1782515660460; Fri, 26
 Jun 2026 16:14:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 16:14:08 -0700
In-Reply-To: <20260626231416.3943216-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626231416.3943216-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626231416.3943216-2-seanjc@google.com>
Subject: [PATCH v2 1/9] KVM: SEV: Track the GPA of the guest-controlled VMSA
 used for SNP guests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
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

