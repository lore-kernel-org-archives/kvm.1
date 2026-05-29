Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D0D47DD74
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093408; cv=none; b=CLQ3BTqPP8MQER/VkelJKqOA6PlM0XxYnO2M5xgoVjfAvLHGaboMSwVFF8iq4ugswmgn2rMcC3mcThSy6Yb/8VRzpnSHoV/t2ZlDo+o87z138DLBt+9akA3eRnBsESvJCrPZJsC9tKq09EGI6BIHWKITp11b8zjGQERakimDRhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093408; c=relaxed/simple;
	bh=JpBvH7r8fr5j6fRXa8XHX2REUYUMDv45z0vOFjhJqfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dfa+y6AIdlytOcxFaMtRgQtzA9zsTycQMeHPWYzlM4RfJHgfIqFv6bkIuQoqroG715rP6CfXDCLS6ua7Qtl/Xh82f3ajAXzTZzJUIHxcBrzFbqMcGoQkYRkin81dgSED7jXcM77+HQBMyRsD3yP6WzZOlZ5ylOpb1Wdu8Rphhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZCi6fiuF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCi6fiuF"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf0b7425bbso38894545ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093407; x=1780698207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=WdjQYB+bJBo3ge+pQ5WkXdfoYUD+JPPPdYiP6D03Qng=;
        b=ZCi6fiuF72mQJjmn9iNlGiVuy1WzhrXeV8bOIkyI+P4+vVyQLJnidjBh4LY7rh5fDg
         qAbVTCQRiR9SlxmiNIaqgYnTcVYkRebT+QPkxfTGOZusk/GePO0NcslCC/Gub/yPnCTU
         /oqfrTZRZERnVkBaGOfU09m8pkZvVGaiCwDTNGLotnBJAVMYSKzOB70AqpvisPRYs1bt
         qh532bwWJAk1GkVmJsMY86NK9hlTXg1VC8DgueHvwE3Bc3oQSgjBDSHlvsMWgOGev75t
         qFGdAeotr3uqP8UpXtyzgLuQtGp764nosbM4EFumzrO5K5Z7Vy1aPZ9iEkhmC6ekjsif
         4N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093407; x=1780698207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdjQYB+bJBo3ge+pQ5WkXdfoYUD+JPPPdYiP6D03Qng=;
        b=ccE1I6km08Vx79rG7hOof/VaRLeSxmHUufOdgVyowkg1MtvOZru5j/EkIzb4naCGFR
         xs9XblHd+d8yCDDO6B/wfl3FOv58+nTVAwQaaPFt0iRfs+mD/g22Xb1GH9gNbFtttaOo
         MHCYHvY6gK31/rOyU8u7qqbWkedYtDzxIin2UuCCqifOZyeISNnH0ABnZkfWLdFwMKGu
         tnFnaLPbL2aaVo+iQERJ1yIQHYudO5gKfHzINmmL5c2ucrAXTNktz9Q5fSH0v5PzjltA
         WYYyV+DpGorMYJb6f/x9LQ1y7PHd+eUym4a1cE+eSVe4I/uyGJxZfnq1BoC/QJ2g8MRP
         FdUw==
X-Gm-Message-State: AOJu0Yw6UDlIwe1Wgsi6bKC5koD4NpqV+1wl7af27PB682Oj47BfH85X
	3vlaWK6zcZtV6PZOgwmPhrZ5It/2BFxfLWDT0Esky2g6mrIYLqXOYo/GW09E8jojLa3jJ34lhPN
	20soPWw==
X-Received: from plbkg4.prod.google.com ([2002:a17:903:604:b0:2b0:a8dc:303f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4ce:b0:2ba:7749:f89a
 with SMTP id d9443c01a7336-2bf367a00fcmr20935015ad.11.1780093406587; Fri, 29
 May 2026 15:23:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:19 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-37-seanjc@google.com>
Subject: [PATCH v3 36/40] KVM: x86: Move IRQ-related helper declarations from
 kvm_host.h => irq.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the function declaration for APIs to get/query pending IRQs from
kvm_host.h to irq.h, as the APIs are only used by KVM x86 code.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 5 -----
 arch/x86/kvm/irq.h              | 6 ++++++
 arch/x86/kvm/svm/nested.c       | 1 +
 arch/x86/kvm/vmx/nested.c       | 1 +
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 866d33abaee0..38de6c0dc743 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2360,12 +2360,7 @@ enum {
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
2.54.0.823.g6e5bcc1fc9-goog

