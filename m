Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FA4330650
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858374; cv=none; b=MpHsX1+iwkODqIB0DoWk6HfOfgliuUPw+svLK9sYZfxpO8AkJVZQScklxqBQ9kQSUW0+aCSeK/+Z6rsF+PTAA1USWJ7OuKOCU5nY4urRbX68++W9njyyflnKNOPXmdkeq8+nDVmuO2TLaLUtMTbgqrr5fpPfqz/ShzUffTnMJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858374; c=relaxed/simple;
	bh=cLAArd5nybMiu3r+R3Qm47YziTKO1SAgN6CEWYEefpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=teXiXqUB9mS/bhVNwKZSyMetA1Kb37Vn1QKYOEyx4LWgSEcuH/n9cvJN9mhAeFTW7Ix6CQ7ZVrF8tnatzUYqALfQNlhhBz4TkZvEwCaAAPHMOmytDWqSoVXwhjmxZ3Plbz1dAhgTzIF1jdz4UJ4PKSk965/lMbTVMSKnlHLZgzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jLh2R6A5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jLh2R6A5"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c9b1b608e2so230545ad.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858372; x=1783463172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=J7VaYaxJJVMtoOolx64XAs1pKjxdxycGmzS3zdTPuH8=;
        b=jLh2R6A5NtzwUZCb8VycTHCw2AztDkEDHhvhW23CmEwOxdHnMCaT9d2+jQ2/jVXi2m
         LiMFPgNudmJE4nl9uogyc2qKlyFevknAiSbsHmGlkrMBZ2i2uTnaVmtC7nIbi0FOUILM
         HFHTzN6Q/BR4oJuxWKx5uO87ppjQjgOuP5pZgp6NfVyBvA0y1jjX4ByGyST3NoxRJ13X
         UFiejUbC4cQuxgWcgQZTPEy5eaMfIdZO8SOihhhx6uf9dZbEij+VMttXZf7IzJIO5MbV
         l07dKnp7GAwBXfTaSh2OuSeOtaDNhuIKPkJ+16DPTWIwaNU605tXqcqsBv0M2pyYs/dV
         twfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858372; x=1783463172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7VaYaxJJVMtoOolx64XAs1pKjxdxycGmzS3zdTPuH8=;
        b=Z54TYDHRZ0vbMtPxfSU4OpJ45od8BLScSzdGNNWtxpgtzxzpv1t4oypfSJaRZ7OK+D
         aAFmvG9pIcweJbvR7uBErYRSOXmB/4aU9fDRmr8ZPi1VbhpWVvr71O5OsLbSAt7Pn+F3
         0slGUHuw21PgxN5KOdtM9R56+Oy+FZXaRs1Ig/rAsmrPDHvcz2V0lT+cWwca7olHoYHd
         wv1hgKPX1IKh6j/WwLZ3BIhnZkmJw4UmC+bt/tfvdklqRJIwIL8e8yDgDoS92szZVjpw
         VZsyYl2AOhA+G9GvaOmG7OcfFnjVmkZCjucpONsIw6pXGo7W8a9PqLVsdpc9eKXYsntY
         r6IA==
X-Gm-Message-State: AOJu0Yzex3wtxAegjtOJq8P1RXoYy++zFCynak6ntFw1twplLBlbVT3a
	66hF93DzdOfYMg1EXoa6pCrklQEDMxd8uvuthktEgxwiSAC/zeRhGOcNQ5+W66uFymX8zD2CFwF
	lehPqVQ==
X-Received: from plbke5.prod.google.com ([2002:a17:903:3405:b0:2c7:f259:cf84])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef09:b0:2c9:ae0b:61e3
 with SMTP id d9443c01a7336-2ca5a52fceemr20837005ad.2.1782858372081; Tue, 30
 Jun 2026 15:26:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:25:58 -0700
In-Reply-To: <20260630222607.497895-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630222607.497895-4-seanjc@google.com>
Subject: [PATCH v3 03/12] KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even
 if VMSA is unusable
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
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

