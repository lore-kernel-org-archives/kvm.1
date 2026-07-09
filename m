Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E523E024B
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630196; cv=none; b=PlBM4W7TwrQrt8h8bgFMID0Q4dPukK5+NNX+dg4Yyi8E4btpvz8FB30RDbHbHeRGRRyxqZh5yq+WlIUSiiYSWiYpp7RosV1GuVUQWHCkR08fTs+Si38CYrRMjhuC0RbVchEBTz6KrIFlkCD3LwldX0Z1iVubNhkLtgYP0/9fE7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630196; c=relaxed/simple;
	bh=jYIfqQXY2em8d5cMD3SfIfshm/QmC3hSVdk1wDzv7g4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fSTJjV17wC8Io/Fb3gvOO10FQzy7dOas72d3a8wAn/uxPJuWIF1WsrmkFchDomMbfPZUenNtcDLhyWBZp0Bp4iVBuN4btHihH2RB9dsYlUDt8eqpHdEzKF8YsyFmbqzKap9xvlRU6sreCwaooRT4HiQM4zSQtF9M/Se5DyVPbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u172+0gZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u172+0gZ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso2184045ad.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630194; x=1784234994; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WdJwAwE2DcmuoEnPWlDc07p8+SV/t3cVV8KAtzXYt94=;
        b=u172+0gZX6UzI5H15WtZ85x47OYWUzPE6wukVWlrA25lTANTWOS5CDQiX7Sn1lSejt
         gfHWWr6AJ3E7D10F5AUCyP5E0WWwXtItwv0kENBPOgA6YqpMUMCh+Fl2Omi4A2XTpcHd
         41gEMhrXnC/hb0MflzR1t659rSlic08+Az0uqAHwfQ54RxnEI3l5LCUvPYD0m2WAUt7S
         buvRgDfsXvG6hcVVnLkGOdoY/FBcQZoS/X4qjbOn0vS1qd471nuDjtqUkWb5YTLGeO7o
         bepY8rl65BUtB77mx5NsXWdcP8Nab78KkVy5v6Eqicpwniwpp+5QrrxklvEmEJ98EnvM
         alKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630194; x=1784234994;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WdJwAwE2DcmuoEnPWlDc07p8+SV/t3cVV8KAtzXYt94=;
        b=mRdkS/MSASLuoMHzIX5FHBcj//LztKAv2MkooPvyd/yBmnY4BYw4X5Oz1d5QuZqgam
         m5ndHyw6XKzRMe8drz1hKDBHpDlpO02ABZAiAq2FKOEBn/eZcsLrg6g4B5eOiL2yfhN5
         LG8PGNHjblgjtlJ2fP/Eu4o/5b+WxJ94UxhQxrb46gSKYyM+v8SdOq+i1pDSr918JXkE
         C8lgkrhsEkv6UIpqufvMTODfVA2DjFCF6KUUyrTjoLkHgjodK95XC5aYnKj6xbDvZMfe
         Ceb8qqih4M6bB21FDdkbokY5AoYs5rh+IpPazR6/91dZeiG8MPAXVCLVAbCQvK/r0jUI
         Jpvw==
X-Gm-Message-State: AOJu0YxT/EGVpCKgfcDFa94GyioUNB+tgwHKXjKP/zUX8HJ+AYVLWB5A
	385C7Un7uZDBHfPwAgvTuFlPWTG2y/OPkPY7CZsTJhEkKePp3nW73vWnq36eFjcSSo+CUziYiG8
	+URDJsQ==
X-Received: from plbld3.prod.google.com ([2002:a17:902:fac3:b0:2ca:d6eb:2a36])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d58e:b0:2ca:12aa:a395
 with SMTP id d9443c01a7336-2ccea38ed79mr88147885ad.17.1783630194140; Thu, 09
 Jul 2026 13:49:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:33 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-4-seanjc@google.com>
Subject: [PATCH v4 03/18] KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even
 if VMSA is unusable
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
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
Reviewed-by: Michael Roth <michael.roth@amd.com>
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
2.55.0.795.g602f6c329a-goog

