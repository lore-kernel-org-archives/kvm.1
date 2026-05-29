Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E566477E2B
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093398; cv=none; b=s4NS06zyRhDfmWT+dFKqSchv9rWvim78naRnCxrUya5JooVW6ZiC7mchBlBOSgbjt7cq6LomMIjlSqhOBeKLrcElda9GfXpk5XVBtoQT0QkW66Ak+BGnDUAh1Jtvlekyho+RKGlC3csQ7NOwptW4FL8G/kxY3IqtHgD1sTkclKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093398; c=relaxed/simple;
	bh=hQlztW9k5qUi+RS2tHkICEwQcFdk//PT0p9sdq++9zk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fxMil8NEPAZsbcXtIxYNGxhBmb/9UrgIl/eR8kks64Y7XubSUpXwMnFLkCvemkPymHeWiCYpDpwqV93Pi6E+0LiWGTAucT5l+golMiblEgdm1aaxsYsWm10zzLzNjv0mZd5th/F8PC1mKuSmpPMP38Wy+jpJJPE7bVzP9IiSj6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fc/L91gx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fc/L91gx"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365d4d2fa04so13668351a91.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093397; x=1780698197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VRGvG+QPcfiu5+a02Ie+c018EHuB9fhsX5SkwkrCswc=;
        b=Fc/L91gxUWn5UKxT3PW1FkIwKECTuXImIW3IjRDs3Bx8qmyyeCYjCq3pThFNfOxBPC
         p8tgMK/LtcFa7IWROAFDKdGbC52Qik9vwNZOSkZRjqzPusp2q/iHZcSwFKHW7/jmmpZp
         Xb1eKxe3EH8fqtZrKpxXEdnIoCN/60h1H59o+a9eMM8TRebkVxgQCYyKLqmTkX/WAOp5
         YdqL34NDPzI8IVabYCysnLfphle0zeuvZbOgdzCpElnBQ9JO9UuRTvY60kUiqEz+yKau
         +ipmIa8K81gNYF8KxL5k+45EiKiUSd0K9BedHIDJ7bPE9HurK0dLRp1uaxxjDEQy7+c6
         PR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093397; x=1780698197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRGvG+QPcfiu5+a02Ie+c018EHuB9fhsX5SkwkrCswc=;
        b=Vdyf3AdGr+xgf2Q7xj9pHg5ODqRUFykvNw785XmbdOQNmXyKt+WiQpa2Z6YvmMkGAs
         nO/PsiiI60vENnh4C+mbsou7ifVkBRb1OUVje4sQkcb0nXq8sChPrsDLGqHMZ/vO2WX3
         nDnbkoJnd9Dt0ub0afHYNav9laGZzGcFPvXE69r3i2dIowC182KDliQLodQXxftFVNpU
         zeNoK3KRiSIyO4sTXgQZtIpJLny0un5O7PWXyKPeO5PYcJiuE90E0isle08R+nTmS+/v
         yRvF6NEABFgNQh1OjV9xj0aAD0QZPqpJk4Mz9qNNgvo4EbjN4QmSuBpBeKfgVeeX4mtZ
         A4xw==
X-Gm-Message-State: AOJu0YyewkT3OZ2Q9MaE5RyRWAvvdrhsaC0/csEfA3FxoWTTZXvM69Cd
	pdaa0ziG+tlJUJDWd7d2zZ2W3aRb6VHKOS+WS4XG5yqyEhTZbQx6cQCVWX/ZKietCL9Q7eKfz82
	QDvGZIw==
X-Received: from pgww22.prod.google.com ([2002:a05:6a02:2c96:b0:c63:55bd:18f0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5286:b0:36a:8240:2477
 with SMTP id 98e67ed59e1d1-36c59abd658mr1076084a91.19.1780093396783; Fri, 29
 May 2026 15:23:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:11 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-29-seanjc@google.com>
Subject: [PATCH v3 28/40] KVM: x86: Move kvm_{g,s}et_segment() to inline
 helpers in regs.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Define kvm_{g,s}et_segment() as inline functions in regs.h, as they are
literally one-line wrappers to invoke vendor code.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 --
 arch/x86/kvm/regs.h             | 12 ++++++++++++
 arch/x86/kvm/x86.c              | 12 ------------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0f4b16b26a27..ca2e69c80a8d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2303,8 +2303,6 @@ int kvm_emulate_halt_noskip(struct kvm_vcpu *vcpu);
 int kvm_emulate_ap_reset_hold(struct kvm_vcpu *vcpu);
 int kvm_emulate_wbinvd(struct kvm_vcpu *vcpu);
 
-void kvm_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
-void kvm_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
 int kvm_load_segment_descriptor(struct kvm_vcpu *vcpu, u16 selector, int seg);
 void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 30ef08d60a74..7a823422d78e 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -437,6 +437,18 @@ static inline unsigned long kvm_get_segment_base(struct kvm_vcpu *vcpu, int seg)
 	return kvm_x86_call(get_segment_base)(vcpu, seg);
 }
 
+static inline void kvm_set_segment(struct kvm_vcpu *vcpu,
+				   struct kvm_segment *var, int seg)
+{
+	kvm_x86_call(set_segment)(vcpu, var, seg);
+}
+
+static inline void kvm_get_segment(struct kvm_vcpu *vcpu,
+				   struct kvm_segment *var, int seg)
+{
+	kvm_x86_call(get_segment)(vcpu, var, seg);
+}
+
 unsigned long kvm_get_linear_rip(struct kvm_vcpu *vcpu);
 bool kvm_is_linear_rip(struct kvm_vcpu *vcpu, unsigned long linear_rip);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c648fac802f6..660ba27c76ec 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4719,18 +4719,6 @@ static int vcpu_mmio_read(struct kvm_vcpu *vcpu, gpa_t addr, int len, void *v)
 	return handled;
 }
 
-void kvm_set_segment(struct kvm_vcpu *vcpu,
-		     struct kvm_segment *var, int seg)
-{
-	kvm_x86_call(set_segment)(vcpu, var, seg);
-}
-
-void kvm_get_segment(struct kvm_vcpu *vcpu,
-		     struct kvm_segment *var, int seg)
-{
-	kvm_x86_call(get_segment)(vcpu, var, seg);
-}
-
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 			      struct x86_exception *exception)
 {
-- 
2.54.0.823.g6e5bcc1fc9-goog

