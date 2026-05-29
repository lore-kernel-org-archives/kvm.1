Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24545BD78
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093391; cv=none; b=JltGu3RJs3lra3LTGtxHsWF4z/sI/E9ivsr6zr2AUnsDpEnb/XDlYSqD8g6i5hz/NPaIVzHhVitUptSaLVLd/3I3+x0MBRayHBtHkzNGKaDi3BW/atTY8CQkIBKofXrpiBJ6qO/veqvGHuqp1jq6kfiKVuBdXYHjnzCFn9/YIGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093391; c=relaxed/simple;
	bh=EGPfyjJEkMRALBldQbQlTBqALJmI6WLTaQUvqWM0994=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=msOPDYDVtuVECsCO86yapOkgHnsepcqoIUxjJ8M9zLVdmcnR+eJGPKWOacQ9+ncdYPVlHY0q14jJ0qoEQUzUENClX9ADzzEdAOeDR5sVk7L1Il+RjVMBxYwkD19U43bCeMge38sixQXgIEB4QTbTIH/a922wcaAcxS9QP7sexjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bqw6aNHI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bqw6aNHI"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf08c2a24bso26328785ad.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093390; x=1780698190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LNxa5lWov+tsCDMl+sF7sk9ofNMegwWDjQlcUaSncIw=;
        b=Bqw6aNHIVVFRiQFr6DSnyKl3ZHU8Xxkk5DhGuvYZsjJ+WcQHbuWpuwh+usemDrdawF
         z+XPC1WH4AfWyXFhPCWzr0j74mAl7lr8ePZwtLYDyiqkYF7WY0VlfA7DyxcmrKpT3lnN
         j31Vyzr6YouK6LciKEZIy7pjzRJBfJiB1Ss+7heSzT+ETy0/84KNuCfFi67S2nqJYi9e
         nYHZQe/7IA9tSW/foFFCVFmN6OQLxV9pUMRgeRzb2VZliV8wn3kWiwvZSWC/lzIy9T8E
         NXBkdeRVD9kvwWI2KnWO8LUDSzyYotYvYSBpCBsKWJl1HXd0K/Awi3UBUD9q33kWMPZW
         ItyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093390; x=1780698190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNxa5lWov+tsCDMl+sF7sk9ofNMegwWDjQlcUaSncIw=;
        b=M3qYsErZAIkFAhsCS4RQ7G6WYepUE0dlrA8P8EjVwiHxvuAhxRIg6olvaC/AmFQE61
         xZ9NP6yEn3febRYcLuFUho+dBxeqOQu9curcWaiogQB47z03eSvT9vLmsDFZrKPjY0s5
         WHYOoDQn7jjNu730XsrabCUtnomCt9tW4rr4K5TXLP9dVgobby+AqDKfBi4tW7slCkZb
         Vr/QfQsc4mdLPLIfzDR9vtysIXptrNhX2+kg6x5BeuTa7OkLm0dWpxTyZxuyACDV3qiN
         pbUPcRFZdpOKUCzdyUC/vfqqRUABQ4EEnN+p+MmuOFoqDHqT1nkivMiyImWtMqm2KZ4D
         X+Fw==
X-Gm-Message-State: AOJu0Yz/ReyLi0eMTyUYN+RIvR3KWsS67ItSpnJg9GxCDGts7oi18V+f
	oD+0g3tFr4USLB1cO4lPIP29KL9f1ogcPdhJZo3wO1Fxl3jUfAsl3SVvbMJef+r9NdusHi9XVXI
	Qz7sRIA==
X-Received: from pllg1.prod.google.com ([2002:a17:902:7401:b0:2b4:5be2:f5a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf12:b0:2bc:cf06:6835
 with SMTP id d9443c01a7336-2bf36798747mr20427575ad.8.1780093389821; Fri, 29
 May 2026 15:23:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:06 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-24-seanjc@google.com>
Subject: [PATCH v3 23/40] KVM: x86: Move kvm_{load,put}_guest_fpu() to fpu.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the kvm_{load,put}_guest_fpu() helpers to fpu.h in anticipation of
moving the bulk of KVM's register specific code out of x86.c.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/fpu.h | 26 ++++++++++++++++++++++++++
 arch/x86/kvm/x86.c | 24 ------------------------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/fpu.h b/arch/x86/kvm/fpu.h
index f898781b6a06..6b7b628f530d 100644
--- a/arch/x86/kvm/fpu.h
+++ b/arch/x86/kvm/fpu.h
@@ -3,8 +3,34 @@
 #ifndef __KVM_FPU_H_
 #define __KVM_FPU_H_
 
+#include <linux/kvm_host.h>
+
+#include <trace/events/kvm.h>
+
 #include <asm/fpu/api.h>
 
+/* Swap (qemu) user FPU context for the guest FPU context. */
+static inline void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
+{
+	if (KVM_BUG_ON(vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm))
+		return;
+
+	/* Exclude PKRU, it's restored separately immediately after VM-Exit. */
+	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, true);
+	trace_kvm_fpu(1);
+}
+
+/* When vcpu_run ends, restore user space FPU context. */
+static inline void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
+{
+	if (KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm))
+		return;
+
+	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, false);
+	++vcpu->stat.fpu_reload;
+	trace_kvm_fpu(0);
+}
+
 typedef u32		__attribute__((vector_size(16))) sse128_t;
 #define __sse128_u	union { sse128_t vec; u64 as_u64[2]; u32 as_u32[4]; }
 #define sse128_lo(x)	({ __sse128_u t; t.vec = x; t.as_u64[0]; })
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index be421f467563..56ccb6b77abb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -133,8 +133,6 @@ static void store_regs(struct kvm_vcpu *vcpu);
 static int sync_regs(struct kvm_vcpu *vcpu);
 
 static DEFINE_MUTEX(vendor_module_lock);
-static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
-static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
 
 struct kvm_x86_ops kvm_x86_ops __read_mostly;
 
@@ -11432,28 +11430,6 @@ static int complete_emulated_mmio(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-/* Swap (qemu) user FPU context for the guest FPU context. */
-static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
-{
-	if (KVM_BUG_ON(vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm))
-		return;
-
-	/* Exclude PKRU, it's restored separately immediately after VM-Exit. */
-	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, true);
-	trace_kvm_fpu(1);
-}
-
-/* When vcpu_run ends, restore user space FPU context. */
-static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
-{
-	if (KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm))
-		return;
-
-	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, false);
-	++vcpu->stat.fpu_reload;
-	trace_kvm_fpu(0);
-}
-
 static int kvm_x86_vcpu_pre_run(struct kvm_vcpu *vcpu)
 {
 	/*
-- 
2.54.0.823.g6e5bcc1fc9-goog

