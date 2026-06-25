Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B8382F1C
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426158; cv=none; b=bz8teTGkDgQ9E0O4B4zziMWLTxDpG19qBNb6pGKyrzy5fh2Mb+u3hOuwSbBfD8th2uQlC7vbNO1RNBaVgILEv6fCzMqozxcHQZEvjy3oVMsPBTaxbPBQDQvHO5d12ZcgBALzEzYecHBYcRBCTbvgxvpU0b/Tc5lrTQ3qvoqEol8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426158; c=relaxed/simple;
	bh=uG7/X/lk/XKicvOk6r4qzbuZJV2YiJrro+DUh40R564=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AP17crhjfDOFX2XhiKYpYEouP4BrOki0ZLVPsmd58oJMOipH/zqWtocmAeWm+Pkx3wR5k4P80ynNEmqcQfr8ysRbpVq7ZaVCKWG0s4RUgA0tybDWx6q1YmUXBD7TGENACQgy6L1bnXbXd52SjExcQEPynNyXuSAA9j7dVcndah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZyhsuCa; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZyhsuCa"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c7f259d20aso4235035ad.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426156; x=1783030956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=S1vaRA9ZfSiTmtM9NIB1WY/+jCo6EHFZOcapwSf7Wws=;
        b=tZyhsuCayPHCq/hE1F1HZNutQ+wUNm/87QOJ0HIOwqDGiTlIKXjqVxIQgUyprP6PWx
         zTygd2gc32Xie24U+U00w1kbsaUoDS6MBS7AUKvVshwBUWsac6WST4dyhJTfBRBfeLXD
         F690l+kL4xWs13qK6eDVLOTuk+9Z6ZtQG0IWUdYcEJsltlURN+3A3t8nWSeUl7+lBEib
         lwSnbWCRr2GlBIGfYHmer1fW0r/S0Tr4vQmOTsU4gxgS5/S1d+Uikr1uacH+R0rH/san
         IS2T2sEj5RiQ3OQwIKuiWoFj4cBxuuDtxc5t/mQpC4VcMknZYJUkFCZqQW/SvuAo+t8u
         vXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426156; x=1783030956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1vaRA9ZfSiTmtM9NIB1WY/+jCo6EHFZOcapwSf7Wws=;
        b=b9LlsBE5cxnN4Fpi6mdR1juEqcQ68xN8ispwU+JyoM3h1pwxd/roj1GhdfLy8lHrcs
         GdCCduzrHi9Ys+AXbawXPM21X5tOiLijLXoFHZiw/MwNkpgLIQUgZTmfJPlxizJQ4nbK
         DAmalOr6fxQgzSTzE8oGl/KSqtWnjqsJCujuDBtubWoxeTx2f8kSAuBAg+2W4ARdTz98
         rNUJcOg6LkIOuUw2C4ay3jGsXI/7IjrQ8WYfN40PE7nVmpk+0bcJYTfWotxOYlkx8dU0
         bdiE4AmM9yQZvnK8Tpd0oqJ1IRteKD21wc7uxdMf8xXi15tFDUhW0Ywx9ynOzQ9WKzNh
         h2jg==
X-Gm-Message-State: AOJu0Yz4t7JfRPe955xwO2jCflmSg9RZt74K2AmGn4U5t1Q6O4SPW65b
	Wk+Ed7IyqoUm/5cgpOyZ3MPusWwm7oNO2KGlb6fsKL6cqhKtWIbNFo3XKq2n0rQzz0S1xn5dKIj
	c7zhYPQ==
X-Received: from pgbcl7.prod.google.com ([2002:a05:6a02:987:b0:c93:e04b:d9ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce90:b0:2c7:feb3:8652
 with SMTP id d9443c01a7336-2c7feb38971mr38056355ad.11.1782426155541; Thu, 25
 Jun 2026 15:22:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:22:25 -0700
In-Reply-To: <20260625222229.3367197-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625222229.3367197-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625222229.3367197-4-seanjc@google.com>
Subject: [PATCH 3/7] KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if
 VMSA is unusable
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"

Always mark the vCPU as RUNNABLE after responding to AP_CREATE, even if the
guest-specified VMSA is unusable, e.g. isn't backed by a memslot or doesn't
have a backing guest_memfd page.  If the VMSA is unusable, leaving the vCPU
in a non-running state will effectively hang the vCPU instead of reporting
an error to userspace.  This will also allow retrying the VMSA load in the
future, to fix a bug where KVM doesn't honor guest_memfd invalidation
events, e.g. if AP_CREATION races with PUNCH_HOLE.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d8ed00f76aa3..30792adcfc8e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4028,9 +4028,6 @@ static void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	svm->sev_es.snp_guest_vmsa_gpa = gpa;
 	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
 
-	/* Mark the vCPU as runnable */
-	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
-
 	/*
 	 * gmem pages aren't currently migratable, but if this ever changes
 	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
@@ -4062,6 +4059,15 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
 
 	sev_snp_reload_vmsa(vcpu, gpa);
+
+	/*
+	 * Mark the vCPU as runnable for CREATE requests, indicated by a valid
+	 * VMSA GPA, even if installing the VMSA failed, so that KVM_RUN will
+	 * fail instead of blocking indefinitely and hanging the vCPU, e.g. if
+	 * the backing guest_memfd page is unavailable.
+	 */
+	if (VALID_PAGE(gpa))
+		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 }
 
 static int sev_snp_ap_creation(struct vcpu_svm *svm)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

