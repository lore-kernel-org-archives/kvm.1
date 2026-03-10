Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC133EC2D1
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186536; cv=none; b=AhC4cbHAHnSuDHxlS1YLizwXYaRNJXNLX5jwX7+Hm/jWx6xLimeUXi92M9i0wGVjtfvHx8dkZ9HIPnyslnBcKJ+s65ymmM15dsaOJ6uElSXmc2gPPdwKn7mEJZjQopLYDaj6H/WV3uTRJ4HgWfdgFUk6R6WuiRtyXTNSpMOMdms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186536; c=relaxed/simple;
	bh=8ne8MkK4K85JoNzXsxwnssB6HZgQt0IZT4YFEhXWxjA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CRKfPUarAlvA8Odh0ZpgO/dXnYiGGGsGjLtBZbOcIHul8BNcXDQBYIn42tvC25ErlWn6opyQ/X6SXNMAc3rI1yHJnxXClP+MaZIFCnmfhc2qUw2B164E65GWTZCP958ZV7hr9omqUEL69nv/XfkFY3g1H3d54hYwj+SsLMrPZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKEqC8by; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKEqC8by"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae4af66f40so106205875ad.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186534; x=1773791334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CPjkzUEfG6jizjcDCrY5SRP9ZwheMlXTocmku9Giv8g=;
        b=TKEqC8by+mU/c43pBylV3HIPp8WbmIMbzU+hZIw7szInuIUfytG0Bqy0KRLBa6v6TO
         bUQGFhMp2DlM8aPDWvANzU+7++Ds10p8aFXos+iaanSmdPuXDjb92qFHsrhjrT8qqAjy
         dyMuO2FWP6+6wCmg/BVvOJZ7kQt7cssDOazd40Fzo7FAGTxysB3Jed1j/H7rpa5Y4l0g
         PLk/ITymIBCoJsROx0kLbHfwtNzEXs3guJw1PPPrZE2kBH6d7ZONg0I1Xr7WkNcsRZ39
         QKyGGSE/EYopPsdVGaEu4OuJRwMzrndlEMl2U0cUuvLLuk/XOx2dXsVPKDXI0oOTw1k8
         f9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186534; x=1773791334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPjkzUEfG6jizjcDCrY5SRP9ZwheMlXTocmku9Giv8g=;
        b=TdYqamloJRM177ClH5rUDe0ViOnID4gtXU8MZlNYm5HLoyU9Bs7H2isVqCs/rcm6+b
         NlWmj5vM34GI0Z+NCPwd6Kr3ZkIdcOaXX2+KwoNZrq3m4uWLomEyVVxyOBqkQ/8NEWj7
         ZFYWMeJhZyvFwFOHi/pSoVpg1pWevHCJjcSwszuhq292lRuk81YG2HdgrpH0LDEfWoZq
         WXyxwg2NgeJVBaeZHYmTmLmGjTIGiQ8AVBrPY7NZv6ALAc0oRZACKts1TtXje6C9ejFa
         lZDyVpWdC/hd0b2SrPecdbUI94Az0TQM/p1PUnJHq0gXTVMUbvcrniLg2rTgv1+8N/h3
         IfNQ==
X-Gm-Message-State: AOJu0Yww/tJAv5Asurp5c1ZDzGu89hdOfMFBa8dgBp2U7KDYFmrN3P4l
	Zl4osA3LrWOcA+NbjW9Xf+AtVlT4/UcIibc6EN4Kkv2+VpV7hNsApk0DCxA87N/ltJEvifkrurT
	BJoYjqw==
X-Received: from plv14.prod.google.com ([2002:a17:903:bce:b0:2ae:506a:658])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b0c:b0:2ae:450c:951e
 with SMTP id d9443c01a7336-2aeae7d35b2mr4781825ad.17.1773186534257; Tue, 10
 Mar 2026 16:48:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:19 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-12-seanjc@google.com>
Subject: [PATCH 11/21] KVM: SEV: Move SEV-specific VM initialization to sev.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Move SEV+ VM initialization to sev.c (as sev_vm_init()) so that
kvm_sev_info (and all usage) can be gated on CONFIG_KVM_AMD_SEV=y without
needing more #ifdefs.  As a bonus, isolating the logic will make it easier
to harden the flow, e.g. to WARN if the vm_type is unknown.

No functional change intended (SEV, SEV_ES, and SNP VM types are only
supported if CONFIG_KVM_AMD_SEV=y).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 15 +++++++++++++++
 arch/x86/kvm/svm/svm.c | 12 +-----------
 arch/x86/kvm/svm/svm.h |  2 ++
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0c5b47272335..e5dae76d2986 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2928,6 +2928,21 @@ static int snp_decommission_context(struct kvm *kvm)
 	return 0;
 }
 
+void sev_vm_init(struct kvm *kvm)
+{
+	int type = kvm->arch.vm_type;
+
+	if (type == KVM_X86_DEFAULT_VM || type == KVM_X86_SW_PROTECTED_VM)
+		return;
+
+	kvm->arch.has_protected_state = (type == KVM_X86_SEV_ES_VM ||
+					 type == KVM_X86_SNP_VM);
+	to_kvm_sev_info(kvm)->need_init = true;
+
+	kvm->arch.has_private_mem = (type == KVM_X86_SNP_VM);
+	kvm->arch.pre_fault_allowed = !kvm->arch.has_private_mem;
+}
+
 void sev_vm_destroy(struct kvm *kvm)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index bd0c497c6040..780acd454913 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5093,17 +5093,7 @@ static void svm_vm_destroy(struct kvm *kvm)
 
 static int svm_vm_init(struct kvm *kvm)
 {
-	int type = kvm->arch.vm_type;
-
-	if (type != KVM_X86_DEFAULT_VM &&
-	    type != KVM_X86_SW_PROTECTED_VM) {
-		kvm->arch.has_protected_state =
-			(type == KVM_X86_SEV_ES_VM || type == KVM_X86_SNP_VM);
-		to_kvm_sev_info(kvm)->need_init = true;
-
-		kvm->arch.has_private_mem = (type == KVM_X86_SNP_VM);
-		kvm->arch.pre_fault_allowed = !kvm->arch.has_private_mem;
-	}
+	sev_vm_init(kvm);
 
 	if (!pause_filter_count || !pause_filter_thresh)
 		kvm_disable_exits(kvm, KVM_X86_DISABLE_EXITS_PAUSE);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 1b27d20f3022..7f28445766b6 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -899,6 +899,7 @@ static inline struct page *snp_safe_alloc_page(void)
 
 int sev_vcpu_create(struct kvm_vcpu *vcpu);
 void sev_free_vcpu(struct kvm_vcpu *vcpu);
+void sev_vm_init(struct kvm *kvm);
 void sev_vm_destroy(struct kvm *kvm);
 void __init sev_set_cpu_caps(void);
 void __init sev_hardware_setup(void);
@@ -925,6 +926,7 @@ static inline struct page *snp_safe_alloc_page(void)
 
 static inline int sev_vcpu_create(struct kvm_vcpu *vcpu) { return 0; }
 static inline void sev_free_vcpu(struct kvm_vcpu *vcpu) {}
+static inline void sev_vm_init(struct kvm *kvm) {}
 static inline void sev_vm_destroy(struct kvm *kvm) {}
 static inline void __init sev_set_cpu_caps(void) {}
 static inline void __init sev_hardware_setup(void) {}
-- 
2.53.0.473.g4a7958ca14-goog

