Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011A44A725
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093387; cv=none; b=hU4ZoHMxQu13AgxE22T2ybqTfH1tXbcTOzvrkP1SG0B1KBRxy7yzKCSK06ZTZ0kyHExdiar4DiePlUPBcrFdj1Wh016oc2oE+k9eQB2zMEvSa3bXX5wJBa4RvBjH8CC0fcAC6z4oQGxHEdxDmCxXJFaGPUdd4bw/wC2w4V4PuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093387; c=relaxed/simple;
	bh=tnvCBMKREAgQlP+QG6F27Ubo/7PoA8ieAPgptJnds2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gGsXuL/sWSFERVOPDaxdsNeibn0JfBi9JnCUEj4FyFRrWg1RXEM8uO+xJc5J/+lfzSni6zTtAFgx7y9Zbe/cHEaP4efMqxC4xmS0Jr7Op/xRYU5yUrLPcfGKkFD6e2j7ricLddRcP1jmVz8sRfzHYPFEHJ8JgTSusNCdywADcp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TM/QxvlL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TM/QxvlL"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c827bda3052so18866166a12.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093385; x=1780698185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mEqYYKIFBUgeehbwG3cS85rQVU90faoGahhTIj84wEA=;
        b=TM/QxvlLQImd25S4ZiLijX0gb1tFjSsk7j0Y07V0FJuKKe2vzvEusWLzKiQw9v5G3c
         6TACzJ50lUEB4etQIbLrEQ7S16PZRliDTn2NhdQLs+xqkDu12EdmugPZKCjMex6y1xi0
         46jwSdrglXS/wxEqFB3O3bTulQ90sOaWcv6Lmte6sKqc8PAwfYjChiR0Ap5fjGIKYAdS
         h2InRsGHvJ8PJCq6PgOPQ2VWo9wfX4sL9eS8MIaB5XWHVk/Nq0I39nP9Z+RZKfUDrNAg
         gqyiZRyfC5Ko+F4ckY9g3QaSLE2ZcYLSyujFBh88PDlyQ8tbgjOd+vEvKwxdX251yxYM
         TsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093385; x=1780698185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEqYYKIFBUgeehbwG3cS85rQVU90faoGahhTIj84wEA=;
        b=XvNz7/N5vaxu6AYwAtJIkQsXyZtM373AFbPyCgJYZNBMnpxH/6DKYEMRmNQyndcPjt
         ECFqO7VPkh3END0Nmva1Wj3mGD3h3Ux73m5iqwNzb2ZHSsSNebkhUC1EBZREneEn4cbD
         Th7HSsxFdY+g1IdPEG1U27w/qSabmuSQ0LdIgy2N4E7GUbEMG0TkM5i1goHu1hbmmJPv
         uq6PSCWbBVCA7gkgZjkhqlo42rthnERIptfHspGSxoEU1+3DHiz1SK7rbNdbhiHwO91V
         dViLd0p9AkO4yMmNAyStDM0OZK2nXophtV/u8elGL9azf/WaK1UjdCjGTUl32N952HV8
         C69w==
X-Gm-Message-State: AOJu0Yy17KuRiIT4avgZIrkXKC6d8bSOXH27zT7v8m9stln8vHq/9iAl
	RvnzHvZzwvxvcIKWvNlpBlnpTaUWIDBGRE09Pf+5qcSdoTrtOPjMrNEU45QFNUyUrCaMGkwvt4s
	NCV3fwA==
X-Received: from pgh1.prod.google.com ([2002:a05:6a02:4e01:b0:c79:8102:80bb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:b94:b0:3b3:bf95:f7e3
 with SMTP id adf61e73a8af0-3b427f81b40mr1274332637.43.1780093385457; Fri, 29
 May 2026 15:23:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:02 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-20-seanjc@google.com>
Subject: [PATCH v3 19/40] KVM: x86: Swap the include order between x86.h and mmu.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Invert the include ordering between x86.h and mmu.h, so that x86.h is the
"top-level" include for KVM x86.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h | 6 +++++-
 arch/x86/kvm/x86.h | 6 +-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index e1bb663ebbd5..28fca48dcf64 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -4,7 +4,6 @@
 
 #include <linux/kvm_host.h>
 #include "regs.h"
-#include "x86.h"
 #include "cpuid.h"
 
 extern bool __read_mostly enable_mmio_caching;
@@ -300,6 +299,11 @@ static inline void kvm_update_page_stats(struct kvm *kvm, int level, int count)
 	atomic64_add(count, &kvm->stat.pages[level - 1]);
 }
 
+static inline bool mmu_is_nested(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.walk_mmu == &vcpu->arch.nested_mmu;
+}
+
 static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 				      struct kvm_mmu *mmu,
 				      gpa_t gpa, u64 access,
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index b7d3b54cde15..a0e68eaf1f80 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -6,6 +6,7 @@
 #include <asm/fpu/xstate.h>
 #include <asm/mce.h>
 #include <asm/pvclock.h>
+#include "mmu.h"
 #include "regs.h"
 #include "kvm_emulate.h"
 #include "cpuid.h"
@@ -210,11 +211,6 @@ static inline bool x86_exception_has_error_code(unsigned int vector)
 	return (1U << vector) & exception_has_error_code;
 }
 
-static inline bool mmu_is_nested(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.walk_mmu == &vcpu->arch.nested_mmu;
-}
-
 static inline u8 vcpu_virt_addr_bits(struct kvm_vcpu *vcpu)
 {
 	return kvm_is_cr4_bit_set(vcpu, X86_CR4_LA57) ? 57 : 48;
-- 
2.54.0.823.g6e5bcc1fc9-goog

