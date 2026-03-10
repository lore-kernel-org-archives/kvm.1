Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0943F1655
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186539; cv=none; b=HO08LoiFdu9Tf5aZqjQ2b+ZeNsWiyjtsMc8ogc2ow+CDuKMBBee7ZTCuU6eN+0gBhntsRTJffUD/9CEMnNpaxyDFHgESPiCdoHtvfec+f9RwXGH0mJvzGqN3mpoJvY5svO1YMSSNjWRrRtcbPsxOToHKGRTdEaMqTjYbEaduFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186539; c=relaxed/simple;
	bh=yLT9leD6tbVXClrxr+0/anPB/JESBZGwpnCJuvNlJGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ofVXmHAnml8uamoFPnmxeAAisW6KZF8mYven2gT3fsuXsBZtVy47ACt60qlY0xB4XOhkNaPyb1QFUCg+ppztkchZQgV8hQ2IWAxO8olh5djuuXKbA1/zQfmX6x0BpWF4H8LNUug5/8jZDnuudd7IoAPgk2K3y/20Tayl6V7wIzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1tSQs9h; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1tSQs9h"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae65d5cc57so411469435ad.2
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186538; x=1773791338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yv2t64tdKmKRfKfd/MV+khzQ98ceOtJdslfcnGZwzWg=;
        b=G1tSQs9hnp0MBiTTkvjLSXehIcjKGFpKHS1Fd0fN3gpVmpkzSnNMpftqDyrGbT90yf
         nmp17v15sEkNG+3Ur0Flh3Aq2xB4g+tPJHQg/GDSL/UJFXcO3ZAPEqOvc+8uPwqW55mZ
         T54XMZQfNJLtDb1qBXAezOQ0R7Z/jLqjd7F/j2vKGLRNXgUYRyhj3yMDFgNlk1PSarpL
         RbqoZH0lKHRnSc0OO0PBznbcaBcY+VTLZB490omsK7fhGlxNHXdzjQy3LY2b4vq8nVW+
         vgFukN7Nepuq1aZekTw81B+kzNsxQcq3WFrLmbIb8+fDsd58W0f4anqbcAsnnpiCafYH
         Bqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186538; x=1773791338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yv2t64tdKmKRfKfd/MV+khzQ98ceOtJdslfcnGZwzWg=;
        b=SSO+UeHFLX6GPzOnBVKJBwgJYdvSzgVGDoxSojQpnRby1zZ541l6JhTUwpeNG0bO03
         vvKp7yEMkBSoB9SPIZ8QEJLrIgMZTJ8ZMQAHDfzBZpdxp86AB6KjUwi/qR+mOEQZ0q1A
         tp89eb4QuIIJ8+8ElyFU8AzELUUCNVSPHfWneZLxw5SJT81o2mprg8534H9eEB0BpUd0
         p/Yc0vp9fmlFNa2nquJTCB8Hjl++fbr093BjTdfAjRqSJz6WUiPz9G/uTxDW1jjG98oT
         MpLcbLGGigjDDjnevqv4ExJYAmTpQkXZjODaa/YuU0vxBzY0+lhE05uz/YO6t4dGND/E
         Objg==
X-Gm-Message-State: AOJu0Yx7ex2e5WjfhyJP9FreBWkJq2CR5ZAaMLVmzi9PqXg9u38UYhRd
	bgCil+RZr95gtpopwr15nMoh70MPolg/15z+dRa0tHN455Pg6X1DHiWfY2qucw7OIihX+m+6rpz
	4N60jmw==
X-Received: from plsl9.prod.google.com ([2002:a17:903:2449:b0:2ae:3d76:eb1b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b03:b0:2ae:5b52:3818
 with SMTP id d9443c01a7336-2aeae76f543mr5386855ad.8.1773186537997; Tue, 10
 Mar 2026 16:48:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:21 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-14-seanjc@google.com>
Subject: [PATCH 13/21] KVM: SEV: Hide "struct kvm_sev_info" behind CONFIG_KVM_AMD_SEV=y
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Bury "struct kvm_sev_info" behind CONFIG_KVM_AMD_SEV=y to make it harder
for SEV specific code to sneak into common SVM code.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 ++
 arch/x86/kvm/svm/svm.h | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 780acd454913..e6691c044913 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4215,8 +4215,10 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 
 static int svm_vcpu_pre_run(struct kvm_vcpu *vcpu)
 {
+#ifdef CONFIG_KVM_AMD_SEV
 	if (to_kvm_sev_info(vcpu->kvm)->need_init)
 		return -EINVAL;
+#endif
 
 	return 1;
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 7f28445766b6..58c08ed0819a 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -92,6 +92,7 @@ enum {
 /* TPR and CR2 are always written before VMRUN */
 #define VMCB_ALWAYS_DIRTY_MASK	((1U << VMCB_INTR) | (1U << VMCB_CR2))
 
+#ifdef CONFIG_KVM_AMD_SEV
 struct kvm_sev_info {
 	bool active;		/* SEV enabled guest */
 	bool es_active;		/* SEV-ES enabled guest */
@@ -117,6 +118,7 @@ struct kvm_sev_info {
 	cpumask_var_t have_run_cpus; /* CPUs that have done VMRUN for this VM. */
 	bool snp_certs_enabled;	/* SNP certificate-fetching support. */
 };
+#endif
 
 struct kvm_svm {
 	struct kvm kvm;
@@ -127,7 +129,9 @@ struct kvm_svm {
 	u64 *avic_physical_id_table;
 	struct hlist_node hnode;
 
+#ifdef CONFIG_KVM_AMD_SEV
 	struct kvm_sev_info sev_info;
+#endif
 };
 
 struct kvm_vcpu;
@@ -364,12 +368,12 @@ static __always_inline struct kvm_svm *to_kvm_svm(struct kvm *kvm)
 	return container_of(kvm, struct kvm_svm, kvm);
 }
 
+#ifdef CONFIG_KVM_AMD_SEV
 static __always_inline struct kvm_sev_info *to_kvm_sev_info(struct kvm *kvm)
 {
 	return &to_kvm_svm(kvm)->sev_info;
 }
 
-#ifdef CONFIG_KVM_AMD_SEV
 static __always_inline bool ____sev_guest(struct kvm *kvm)
 {
 	return to_kvm_sev_info(kvm)->active;
-- 
2.53.0.473.g4a7958ca14-goog

