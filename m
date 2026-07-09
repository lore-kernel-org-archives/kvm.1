Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A63E1714
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630197; cv=none; b=q7vWAdtOEhbSqjZXVTK99nqgLyjM9VD2VZreZV1/4advN2YgV+Px6p6OTOHiGaQb/63d2uizxBJv16IGEYxvMFCRQXs8JNOE+g267FghmUcHF0Ou124qs4HCGDIc2SO616eLjylxkOJyL6USJQ8jTQA/9MFIXAzNjFbjbJOlCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630197; c=relaxed/simple;
	bh=cZZUUb8P+jSuZ46TafiQ+IhaReR4B3L8OuHCXr6ZHxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XAE9nVPEiuQ31ktA58X5DjP2Q05aKjOIJ35vY0LtReyGZkybg+pq+8j8Q9DNCmgp/sByxmC5nsrtRpzVT0zxwpLpeoQFOygyO86AdVVcrAz0C+63ntlxW/HLV3FF0yRnPhCI8jF4f473cKgDzIp9ubZzpyl8BtG+PER9L36tiT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s85sOmMM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s85sOmMM"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cc73f47bdcso2578325ad.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630195; x=1784234995; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GK0nZM/ctkS0Rl6X7OluF/i9ggLQDBMdL3eflObnNVI=;
        b=s85sOmMMFfGWsS4lbtyV53A6o26g3sCWV8uvKWrpcHVC4qfd9I0vgVnButAOD18nSg
         KkHsbZcUtu4+MpAP38jFEf4Jit1zfjt/L6TZ/sfs2ca5ut9lehEL/JMQ+JxWXQT124sV
         2qgkWsE5xf3xJ/LqqffRHR6zJE6uKu4YtaaT3G8gGsNFF9+fMLrlW6SwvHNe87YICAA5
         2u8JWP23VQ6QaIiQNUMzO0kpKWg7LrxehPDcq/PSc/J0gBVD2kpdgsSp76SLQXW10GqF
         fumtYMta9UZCUQ1Z2KfTGgvp3lZhWlXo3mQhxCfnZSR27wEEU3RPKT+kbgyd1Ol7KkFB
         VZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630195; x=1784234995;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GK0nZM/ctkS0Rl6X7OluF/i9ggLQDBMdL3eflObnNVI=;
        b=gu+/ClMJXV3pTxpYCv9EVuyRsNWL0MGJQjJ2mD0HjUZK634g39XhK/1+atkU+IwSu7
         Mp3kvpvq46R0/H2XY3KU+FbUhW5pODi1/V0+Eatts/QTlelj0SKH8vLwdVk5g2BZSX5H
         yQJh3Al1MH8TcfEADQbqLb5fT2HvZ31qJECQbWpl+7ElunNokyT8P1+Kutw5IqR+Al5G
         dGGfpometThe7BusjddGhKxSw+honjdhBbNeN70LvymfqsdktxNIaC//WeaZ7UvQP9+5
         pG7S5fAJaVc8kbQ38ynEds8/gLcGpmUDFLLPY+MJEZ3OPd5sHqQWsqbALOfc4ZJgb00U
         gxcg==
X-Gm-Message-State: AOJu0YwXQbzlfqLDHMoOpINubUaHs2Howv4Xcn5s6ucAtOkWTgw8L/W1
	pA6okyIZEwzYCpR2TqRmjAbfKF/wWfHruvmwTqJ2adF46Na8cflPhr1siXa86/w2l6ABH7lASio
	ipXoPUA==
X-Received: from plrb5.prod.google.com ([2002:a17:902:a9c5:b0:2ca:cdc4:8da])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef08:b0:2ca:d151:383a
 with SMTP id d9443c01a7336-2ccea3ca6bdmr92086165ad.20.1783630195204; Thu, 09
 Jul 2026 13:49:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:34 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-5-seanjc@google.com>
Subject: [PATCH v4 04/18] KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and only
 if CONFIG_KVM_AMD_SEV=y
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Wire up the SEV-SNP guest_memfd kvm_x86_ops hooks if and only if SEV is
actually enabled, and drop the now-unnecessary stubs.  Leaving the hooks
NULL allows the static call infrastructure to elide the CALL+RET, and more
importantly, referencing the hooks if and only if SEV support is enabled
will allow conditionally definining the hooks using their corresponding
HAVE_KVM_ARCH_GMEM_XXX Kconfig.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c |  8 ++++----
 arch/x86/kvm/svm/svm.h | 10 ----------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f..79c818d91dda 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5448,6 +5448,10 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.vm_copy_enc_context_from = sev_vm_copy_enc_context_from,
 	.vm_move_enc_context_from = sev_vm_move_enc_context_from,
+
+	.gmem_prepare = sev_gmem_prepare,
+	.gmem_invalidate = sev_gmem_invalidate,
+	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
 #endif
 	.check_emulate_instruction = svm_check_emulate_instruction,
 
@@ -5459,10 +5463,6 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_deliver_sipi_vector = svm_vcpu_deliver_sipi_vector,
 	.vcpu_get_apicv_inhibit_reasons = avic_vcpu_get_apicv_inhibit_reasons,
 	.alloc_apic_backing_page = svm_alloc_apic_backing_page,
-
-	.gmem_prepare = sev_gmem_prepare,
-	.gmem_invalidate = sev_gmem_invalidate,
-	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
 };
 
 /*
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index d077783c287e..effca6372e15 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1035,16 +1035,6 @@ static inline int sev_cpu_init(struct svm_cpu_data *sd) { return 0; }
 static inline int sev_dev_get_attr(u32 group, u64 attr, u64 *val) { return -ENXIO; }
 #define max_sev_asid 0
 static inline void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code) {}
-static inline int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
-{
-	return 0;
-}
-static inline void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end) {}
-static inline int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private)
-{
-	return 0;
-}
-
 static inline struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 {
 	return NULL;
-- 
2.55.0.795.g602f6c329a-goog

