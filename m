Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284F37F744
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782515664; cv=none; b=tDcKXRyrvvLzby++nycW1aG/OCNyWco1tlpW1ndJ3b8WqpYmxBnIAMcKCm+pUciDG480PET4u050Jfh5zDkZTt54P28qoqYEhfLv5TOJaOIDjZHEQA+k0wxtUqGrSGg7RNve8Lb51rYYkRlK/EVD3pyylngWLdd0BHVKBnnWV4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782515664; c=relaxed/simple;
	bh=cLAArd5nybMiu3r+R3Qm47YziTKO1SAgN6CEWYEefpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a38QwHYiti1zrVXc2Vic1aACZ0XlfQNOwlxak3s4ots9gGoYySHzkkDXWl6eKZvckwAQlQayEnnIs8MLfhHv4umFhFSyTfCimNiwFA+lmJFrUOOsB3r87r5QMLKYN0k5SwDMTRuLhahVRokNPEIUYVKwdgbLIYpx6EIizStKNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pP3LT45q; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pP3LT45q"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c892143db7fso752265a12.1
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782515663; x=1783120463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=J7VaYaxJJVMtoOolx64XAs1pKjxdxycGmzS3zdTPuH8=;
        b=pP3LT45qV46QX2mwepAhzk0Lm/yF46hw1gJ4Tr/skzfWsE7p17Fz1/LfZPjaXXRoLX
         JkDuRqCV88vBDh0gQ7rwmcm2Td7ngywI99/icNfqsjlqIg1k2lrlm2Qet/zYPzf4+sin
         dkcW2xqE3L9RusUx/68hBozoschCK/nBnHjzS3qs9qbwbFMdMcX8DxEcgqfYUlMLD1wK
         h211B27CORZAD3Qr3OR3V1HakdH+FE04nspqYZRs/1BsccPJss5rNfU/GvHXZUolBQGb
         4lrZnaeKkWTy+8O79S6vVkTAOkVHg9ADyNFMIGSAdJ4URm1TFjXiS/h6AvFzNoyLtGNs
         V4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782515663; x=1783120463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7VaYaxJJVMtoOolx64XAs1pKjxdxycGmzS3zdTPuH8=;
        b=QtkDcYpH/P9gDnpaUyheGOG2T8cPqJdewIL+wxDGt8VrhQTaLkCNZglnjr5zOdj2sz
         c0uDOYrlVRsZ8YDY1MML7hS1eWkqD14Vdclwyf9ngAgSKrEzaq2fKb7uJeWrazVNGeb5
         jbWrsdxK7753isdbaHgVHHwvokeEzU1CYze97+U27hppnU4wjhZVPPt8qgwmFhEWPW7L
         yDukgjshzko/BUK6GmDe41JtUr3j0dPaeaQqfaUxipZQNGHySAXwuSCPwsuahYXWzOVN
         WSDXjhLTeRpwH4QiMdtTXJO+xIWGJM2ZMmBbxpdlEzcF5NAd9nfmx2numVDWRYxNo5UE
         VsFg==
X-Gm-Message-State: AOJu0Yyk9RhdLpLvMiVaXyFYT80UgLV4Yjc/nMuxvw+ZCtR7aenxWrqW
	EscmcIO+MwHOeC7cNyYDnVhinbuROpuFAyhT9xYahasZwWH22fZ6GfpktYYwgxzeyVrfk0Lnmwb
	DuEMibg==
X-Received: from pgq23.prod.google.com ([2002:a63:1057:0:b0:c76:6c2f:89d4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d043:b0:3aa:60e0:b2ed
 with SMTP id adf61e73a8af0-3bd4ae16801mr9783519637.27.1782515662595; Fri, 26
 Jun 2026 16:14:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 16:14:10 -0700
In-Reply-To: <20260626231416.3943216-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626231416.3943216-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626231416.3943216-4-seanjc@google.com>
Subject: [PATCH v2 3/9] KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if
 VMSA is unusable
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Always mark the vCPU as RUNNABLE after responding to AP_CREATE, even if the
guest-specified VMSA is unusable, e.g. isn't backed by a memslot or doesn't
have a backing guest_memfd page.  If the VMSA is unusable, leaving the vCPU
in a non-running state will effectively hang the vCPU instead of reporting
an error to userspace.  This will also allow retrying the VMSA load in the
future, to fix a bug where KVM doesn't honor guest_memfd invalidation
events, e.g. if AP_CREATION races with PUNCH_HOLE.

Cc: stable@vger.kernel.org # 6.12.x
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

