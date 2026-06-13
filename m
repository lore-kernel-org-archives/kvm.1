Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7399B171AF
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309031; cv=none; b=n1ynZUcl8qjVQRGJ7zALRhwX1ZZXupr4au+QdnuWCwJ6Aojeu5L3l05pvaglGs9/A/e1Bkxfx55+Xe6swLp9DFJAxyAbLTR2wAHFhs67RTHF2/h9HD9Sj2YjQvvjqlQ98Cb7nVa/lUUHxiWER5+V0QLkIXuImxCVaBWUdikYEWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309031; c=relaxed/simple;
	bh=noctCE8fNkJ1CPbGJu5QDC7NhA0mjVZEK62hEki3/l0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rfidl1CqAFbIECcOOS0pSi3L8f9JbWJphEysY2SbB9F9dOyld5KSHOyjs+3rtpsa8GxVeZnGtE3uEJrF3kfGeKT4O0KnZOswLVtQofemZUirO/FGWopqA4Tn3KF/PCcYGzVhg1V5VsChVKQBHiDYSJgSN219Xnu/SrH9xeGiOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PwWCG5Wv; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwWCG5Wv"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f544944so1110406b3a.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309029; x=1781913829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=s75p+w0J+iMg7rDe3eRLMtCsj68aJcc5iFyS6tg4dXQ=;
        b=PwWCG5WvAjBZkAN9gLoo/v8hK44kQCqY+LzAI2kMzJQYQwMR5z84gZKVHggJB6NbD/
         NRLEHqvi8o/6SeNsjmSRCo5yvMPVLEd7/PqNfGqCnqi3rFPshupgX3KXURSSqH3zUVwG
         4rKpxNDOYevonJzNJFZlx313qRWNwRtIs/hBifqlQXS4p3laZyPi6nlkXVvIKJc8bIXa
         XK/HPiI3oltBSON/x8oFUoIexBWr4aG0X/RqPRCLsaycu/IJx4NW3Kg0tKdswUoGJoZJ
         MRW8zcJwJ1ro1j/fc51mPeYCxw9hNyje5qhcUfoueMf0J1hnkx6x/KHlrtiZ6rdlC+L+
         K6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309029; x=1781913829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s75p+w0J+iMg7rDe3eRLMtCsj68aJcc5iFyS6tg4dXQ=;
        b=JL4iP0KDLF0bgG8pP8AJ1zms6ppHq74aRlv6RS18BwqWExxm/+ZLYxPELQljtiooX3
         EHxL428maYZqf7WlBwZrYxXkBM8RXckQh06q8d3ePU7DH+NGXzbcQ1P8bGY78SZo9G/q
         U4rppOSWDjHEoJdG5Azwx5faXY8hMzyQUKKhoM7JJmKXA6zB/CvLlvt48vM1AQd5V1/1
         6aZ6K9d7U1TcogeJKO4HhNWNITTphUCwn8RqJ0NbFYI3mnj0WJSNvr2KekLitpMJnmqp
         GN5OroxAWT1nrezIeYMPTSGFqDky6ecTci1GF585I4pdX48o+nMXEWJvZcr4vXi2KkBO
         J6Aw==
X-Gm-Message-State: AOJu0YyoTE2Wz+C/vkqFIGPbKSotQEIfw+bhpuxUm0EqKuY3r2JQGpk+
	ege4o8ZSj/4vxnh9JvifyMwIbx+QPkudd9Dl/vFlKtRm9UJ6oDWlbdLvjc6yQ0YvNyDqH0AzRRs
	gB/wkzQ==
X-Received: from pgcd22.prod.google.com ([2002:a05:6a02:4c56:b0:c85:9c9a:ab55])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918f:b0:398:9662:10ff
 with SMTP id adf61e73a8af0-3b783b13d77mr6083924637.4.1781309028589; Fri, 12
 Jun 2026 17:03:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:10 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-12-seanjc@google.com>
Subject: [PATCH v4 11/30] KVM: x86: Move kvm_{load,put}_guest_fpu() to fpu.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the kvm_{load,put}_guest_fpu() helpers to fpu.h in anticipation of
moving the bulk of KVM's register specific code out of x86.c.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
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
index 3813078cc028..8f9a1572a39f 100644
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
2.54.0.1136.gdb2ca164c4-goog

