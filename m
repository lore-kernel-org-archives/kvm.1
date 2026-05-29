Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899247CC9A
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093405; cv=none; b=pnnCWzxdrTKydlguM0BO5OqfRXPJvXdmzMPD24X0qqdWwTZPJ2RKPAwTM7YhMDmyvjEu/rc3z6sdAmH8M+qiEUse9rHNDX5t/1TuHcZ4xqLgNHp47rudSiEcvN/UFtTV5XqH7RoBvcy+QdD1M4xUSjC5bTc9L/T9BMFnknMOEjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093405; c=relaxed/simple;
	bh=sM71/V/NEGLDRFoPFaHWGc/4+j5RVrXjbHZgs3jZqHk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=khOJpSAxStGfI54MngOZM0RZ7zPlnKAT8N0SuIdXa90hiExb6p+28djPTxrSyeMwsP+Bc/WTfC0gqXNmbGZCostEBsPmSVHKWjpHCGsy04jq2mxGf9gsMLzWPheccqSmqsXyzi4/w2zBg9qebnGYJ0tScGr4HSRWMK+A2K3YYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mm2TpSyA; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mm2TpSyA"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c857befe561so361851a12.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093404; x=1780698204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OYRO9/6QUt8JjFWwLPnwN9Nibat8wZa6YMCn9yp2By4=;
        b=Mm2TpSyAV6ifqbgo541o0ek7tkcGOSKhnrFq9XTuUcj8QE9/RLDMD/ey/Kx0ZCN+K/
         zHviDw8UVZGJ7/KWHL+wdmsFWFxFYnISdb7BclsdXSMV30fGh68wZUDiaeoRCiQdJfuM
         wTrdjj30XbNHUbNquAbYM+L22vAkPT5XqOlQl3Z4iCXvzsgoHawadvsAh8qsFiZfUVgJ
         2JVp3Jm4hiUgNuSmvyVd2aYlh7Jtp4Gpylm5/npwexuCqhPBFobHEb95s5N0bwLzPDhR
         jMfiXIItSHsDVRR61525sbZBpy5ieCdV3LouiIWtEZCPFIvhUF0p5af3i2dPVCNlcwNK
         I9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093404; x=1780698204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYRO9/6QUt8JjFWwLPnwN9Nibat8wZa6YMCn9yp2By4=;
        b=cSR+Do32wxhwZTiMjFyM9+HhmIGyedi4wSW7rXh6Dg+DuDNg1DcRe/AjWoqenf8MNn
         1eev8T2W6T7N3oDtL5Kmuuk7PC6pAGB1ikLMRzWOBagARUfLBfLA8eBinLTmHWcwMrzH
         PmHKV5LB35M/G2zx35KMtRojESbtu66q2XZFgfWG3SEqVK4wi8u2LBAKcVK4jlmrLbG6
         FQXrzM7x2p4FOih7gb6EQtQaIPbSK1jk+yIuX2smAGPqCLd8jtQP3bXQJr1rWaaMLDHI
         VHKVKFxS5qT7Gbla4lRqAR+0ZKTdWB2lisq5JVL+o1uuWnc7zSzfeI80m7ggc5RHp4B1
         SFxA==
X-Gm-Message-State: AOJu0YxfWYoY6qEG2zrXA/WRRyXDpeFUjHTE+87bkfTk3H0BoZ3/WPml
	kE4XAVty7A02xmfgcdtecqsgeaU4pzKAuR+CdClr9xR9KXWP/DWFBcx/anBmqGL4aLIBI+bODqG
	HdrJwZQ==
X-Received: from pgbs189.prod.google.com ([2002:a63:5ec6:0:b0:c79:89d2:43e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9f17:b0:399:12d:41f
 with SMTP id adf61e73a8af0-3b427be7b60mr1372617637.7.1780093403446; Fri, 29
 May 2026 15:23:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:16 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-34-seanjc@google.com>
Subject: [PATCH v3 33/40] KVM: x86: Move kvm_cpu_get_apicid() from kvm_host.h
 => avic.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Opportunistically drop the CONFIG_X86_LOCAL_APIC=n stub, as KVM hard
depends on CONFIG_X86_LOCAL_APIC=y (the stub was there purely to deal
with kvm_host.h being included by non-KVM code).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 10 ----------
 arch/x86/kvm/svm/avic.c         |  5 +++++
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3e0884a862d7..989294c7501b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2427,16 +2427,6 @@ static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 	kvm_x86_call(vcpu_unblocking)(vcpu);
 }
 
-static inline int kvm_cpu_get_apicid(int mps_cpu)
-{
-#ifdef CONFIG_X86_LOCAL_APIC
-	return default_cpu_present_to_apicid(mps_cpu);
-#else
-	WARN_ON_ONCE(1);
-	return BAD_APICID;
-#endif
-}
-
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
 
 #define KVM_CLOCK_VALID_FLAGS						\
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index b7083cd692ad..9264c8ef1fa1 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -146,6 +146,11 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 	svm->x2avic_msrs_intercepted = intercept;
 }
 
+static int kvm_cpu_get_apicid(int mps_cpu)
+{
+	return default_cpu_present_to_apicid(mps_cpu);
+}
+
 static u32 __avic_get_max_physical_id(struct kvm *kvm, struct kvm_vcpu *vcpu)
 {
 	u32 arch_max;
-- 
2.54.0.823.g6e5bcc1fc9-goog

