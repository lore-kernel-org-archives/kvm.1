Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959743C09E2
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784244333; cv=none; b=dbDx26UbHhX3yWTfCji8X1xAR+LD4qvvoXz93viUu+hwjx18KLttQQz9TRZi1dXKx9RewJ/cWWSFo8AukzUJk152XC02a6FL/Ltjt2nfnh6C/iD/EmI3YE2aLUcByPuUqIBOQFWyc8u1nVaoxa42V1gIhEHgZpmWO+OwEsyMark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784244333; c=relaxed/simple;
	bh=pJGXpOXQ9oQMwRg9Q0BIdaZbSV6pqGh7aclnHt6j5qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UAqRURC0AuL74qRuz8PgEzPFbI/c0N8ISaqvdICGh8Gbup0sCVFHBkJ9LxEkOxZcASTwnxiqBBYiGzGJ7/KHoVlJcbUuK92uc7Lo1biuRavTL19SSE8LBZHRC8Xza3gaX5mfUgzzZ4NvxRyrw48uQ/eDCBptAw+LiiiyBM+kLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKYDAPt+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKYDAPt+"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so137342445ad.1
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 16:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784244332; x=1784849132; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z8+e94i9Fp4M++b+t7KTUTHFvvj2k8Rsi+p57Ogbxhg=;
        b=wKYDAPt+uYHIOYdHJcCETD80dvt1tAR/GvULnKWaF5ccaFkifLJyxiHXW2LL30yUIw
         7ggrzhnS5bDfiYwIobN0l1Jd0AkZW9Fdm/FjiYI6+rzYnRooeVbZZmiHgnrdnp7FemT3
         /1igIH3vH7hu6hE2Dww+5JZUMzPhi7r86uA25ZsNL+v0e1TUSuFVKDxy9AjcKm9fd+iO
         UBq3EovlDIzqNREGWXmW1NrjUXbZTNvRa/cg+XKPH4Ali6eijky1uXXg2QeQljuEDuQR
         GnEshNgLc8pASoi7svaHsWLZzBOyupRdPfzKoEZJ1e69pu51+2liFUtUeDJpmlqE0REo
         weMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784244332; x=1784849132;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z8+e94i9Fp4M++b+t7KTUTHFvvj2k8Rsi+p57Ogbxhg=;
        b=lT8/3yi+nOu4K5uMsjq/JuRIRGEAJMXqsNtN79G/WrpeKkeKKVLcqpxaDBoeKNNTuX
         uA9RzE1L02vihzukxC7u69U+sGNrfjUUPdgKrHE4x3YArourMvaQCMBOdcp8QshYbyXq
         jBo8IpuruEP+Gxa6wxDUovmhGTpIcU+XkCLr0sHBVodXRtlwaV43N/BxqHIHEws/6xoq
         MWA/OdEg5COXr0bIlpfYeTbt9J1AWdqtw3v/M59uDUyBbfwvpe9ABOtBWTiq4zmxs5uN
         bfEvtB+dxmGXkVllUB8OEofYMvVE+B1BER+oZ36D1MmwBbEzNWjLwN/ksnvAEZZNfIjT
         cuUw==
X-Forwarded-Encrypted: i=1; AHgh+RrQyJlPyCwMmgExWEcN3vHUBprhewled90trlsbRupRPMlRMG5hoXay0DO0T27VUw8/Jdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzty+Fb+lWG4upeQei5DwQi6F2ADrSEY2QtfrVsIQZVcQKbYqT
	Sge+VI1db1J1kbsqN6HYNl7ksR089NLqZBZ7ezIAzQHvHz142v5NmC2Qk8DvlcP40iuo0nFQI2I
	7ZgycdVxJ2dO0lg==
X-Received: from plbbh3.prod.google.com ([2002:a17:902:a983:b0:2ca:ed29:ea82])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2350:b0:2ce:d5e4:2fcf with SMTP id d9443c01a7336-2cf34a18da5mr1156875ad.42.1784244331663;
 Thu, 16 Jul 2026 16:25:31 -0700 (PDT)
Date: Thu, 16 Jul 2026 16:25:22 -0700
In-Reply-To: <20260716232524.2092085-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716232524.2092085-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260716232524.2092085-2-jmattson@google.com>
Subject: [PATCH 1/3] KVM: SVM: Configure ALLOW_LARGER_RAP in svm_vcpu_after_set_cpuid()
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Amit Shah <amit.shah@amd.com>, venkateshs@google.com, yosry@kernel.org, 
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

On initial vCPU creation, init_vmcb() is called before userspace configures
guest CPUID via KVM_SET_CPUID2. Consequently, ERAP_CONTROL_ALLOW_LARGER_RAP
is never set during initial vCPU creation. If an AP later receives an INIT
signal after CPUID has been set, init_vmcb() would set the bit for that AP,
but the BSP would be left with ALLOW_LARGER_RAP clear.

Move the ALLOW_LARGER_RAP configuration from init_vmcb() into
svm_vcpu_after_set_cpuid() to dynamically set or clear the bit in vmcb01's
erap_ctl whenever guest CPUID changes.

Remove the now redundaant code to set ALLOW_LARGER_RAP inside init_vmcb().

Fixes: db5e82496492 ("KVM: SVM: Virtualize and advertise support for ERAPS")
Assisted-by: Gemini:Gemini-Next
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4d2bacd00ec4..b76c6a76ce37 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1243,9 +1243,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 		svm_clr_intercept(svm, INTERCEPT_PAUSE);
 	}
 
-	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS))
-		svm->vmcb->control.erap_ctl |= ERAP_CONTROL_ALLOW_LARGER_RAP;
-
 	if (enable_apicv && irqchip_in_kernel(vcpu->kvm))
 		avic_init_vmcb(svm, vmcb);
 
@@ -4736,6 +4733,11 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (guest_cpuid_is_intel_compatible(vcpu))
 		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
 
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS))
+		svm->vmcb01.ptr->control.erap_ctl |= ERAP_CONTROL_ALLOW_LARGER_RAP;
+	else
+		svm->vmcb01.ptr->control.erap_ctl &= ~ERAP_CONTROL_ALLOW_LARGER_RAP;
+
 	if (is_sev_guest(vcpu))
 		sev_vcpu_after_set_cpuid(svm);
 }
-- 
2.55.0.229.g6434b31f56-goog

