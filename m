Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675AC2F8E84
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309050; cv=none; b=GYXMX1+Oh0ovSkqb+uQP42h4msZyXWonDAZJDZkTxLWAvm3M3ASzSghfj4HwCkIoMRUYlVVwnR2cQtLuP4ybbos1qzK2OAS0orFKrryB5K6sBlWGM8sFsb20NOthwf5Dre59uLGUt600tFcuJacn1fbdx6/f2Dp8+IiccIVPVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309050; c=relaxed/simple;
	bh=Xwuyuov94cuKeDGWYJTFTGHsvp5U8VxJsT9zOCIxWG8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z4WawJDefm4ND+351MkY0nPpgWAKwJZ2bJ0kY54PXZMtt7cKknZJaoW00QCucqDgDBb/BIeeoJeYBT7x3UzsTZxYLbcHIqwaFx9/tp8/ZpxojfRW1k0i0D60rUfYxoV4E1xQ7iJi2CC1c2V48YgWqGzE3B49Ne2Vw2QcAeXXEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cSB4F/fD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cSB4F/fD"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b76d12so1003707a91.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309049; x=1781913849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kEmXu0hBgiuGtr0DA+mnEYPgxWaLBxZioaKD7/+kq6M=;
        b=cSB4F/fDa/IT4DYFVQcJ0UgSXHSRpsJgXUoA5p9bDmWelmhEH+jA2F/+OPqdyX8th0
         Msd/dIWVu/fxpO9ghQgzEJzARBTGHQQzDIf+C6jx9UesAIJf6t0Ehoja8pJxqNKAn9Uc
         lO6IUlfRQMizEM2i5VoxkAf1OtOA1Yv6z5Du6x71xPAcYeEatdvO7kYt3EB3/ImydMTW
         9KuhKAObeevoeQ5w61iJSApnwMDfvXLF9FMT3ilclP5/Gz9VD345yJLX14A0LNRAz5og
         F1J4aNr1opdjmjIm19YDNIl0OL/RMZqDG4atEC5lpJYUR85J2U62Jl+5rEDoeXCOUwlK
         ViRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309049; x=1781913849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEmXu0hBgiuGtr0DA+mnEYPgxWaLBxZioaKD7/+kq6M=;
        b=VyUVd7yzV5raJKq3h+1GSQ2dLjC/S78J2XOr1E8EQpUKeeKAT+1CQUE3XkhC2WpVEZ
         UGppc30Dc1HNooKuJ0Crknu+x8HH4ugmefh2J27oYo4fX6CDvr+DXKr/R7/ouq/TPv4v
         mJziHspTy+Vsnct1AZkfzMYksHVeacCovCNYydAzrViTLXWTY66dGPxx4fwPf94EeALL
         VMKq55iJjf+mz+Rm7kFYn/EtGWMi/6fMScYPLTIh1nzA7Q6T5zg9xcsDAu6tFl4/nWfz
         eCA5CwoeGnP5Gd+JBC5TLF+A+0GAA3m8rQPu36EjiUlztTdWRwMx3CbNxSpDgVixbrMN
         PZpQ==
X-Gm-Message-State: AOJu0YxjMyZKCDvwNz+zf9xn7ztM4dw9CCvR+vcECsX8+UgBv8kJlVr6
	eK5ZaKOo2IVeKNWjY1i19KpFMqwI7zLIs7AoAWsS5GvzdKRWzjs+fChdcHbcIjbcpWPwBwa6ocO
	H6sUgsg==
X-Received: from pgbo20.prod.google.com ([2002:a63:5a14:0:b0:c0e:3543:bdb0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58c4:b0:35b:9894:f6f9
 with SMTP id 98e67ed59e1d1-37a040adfbbmr5006619a91.18.1781309048574; Fri, 12
 Jun 2026 17:04:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:23 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-25-seanjc@google.com>
Subject: [PATCH v4 24/30] KVM: x86: Move IRQ-related helper declarations from
 kvm_host.h => irq.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the function declaration for APIs to get/query pending IRQs from
kvm_host.h to irq.h, as the APIs are only used by KVM x86 code.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 5 -----
 arch/x86/kvm/irq.h              | 6 ++++++
 arch/x86/kvm/svm/nested.c       | 1 +
 arch/x86/kvm/vmx/nested.c       | 1 +
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2b96ab0f46f9..811687b7a76a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2338,12 +2338,7 @@ enum {
 # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
 #endif
 
-int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
-int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
-int kvm_cpu_has_extint(struct kvm_vcpu *v);
 int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);
-int kvm_cpu_get_extint(struct kvm_vcpu *v);
-int kvm_cpu_get_interrupt(struct kvm_vcpu *v);
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 
 int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index 34f4a78a7a01..1a84ea31e7fd 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -112,6 +112,12 @@ static inline int irqchip_in_kernel(struct kvm *kvm)
 	return mode != KVM_IRQCHIP_NONE;
 }
 
+int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
+int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
+int kvm_cpu_has_extint(struct kvm_vcpu *v);
+int kvm_cpu_get_extint(struct kvm_vcpu *v);
+int kvm_cpu_get_interrupt(struct kvm_vcpu *v);
+
 void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu);
 void kvm_inject_apic_timer_irqs(struct kvm_vcpu *vcpu);
 void kvm_apic_nmi_wd_deliver(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 1ab8b95975a4..ef10298cb320 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -23,6 +23,7 @@
 
 #include "kvm_emulate.h"
 #include "trace.h"
+#include "irq.h"
 #include "mmu.h"
 #include "x86.h"
 #include "smm.h"
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b2c851cc7d5c..adbb8358ade7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -11,6 +11,7 @@
 #include "x86.h"
 #include "cpuid.h"
 #include "hyperv.h"
+#include "irq.h"
 #include "mmu.h"
 #include "nested.h"
 #include "pmu.h"
-- 
2.54.0.1136.gdb2ca164c4-goog

