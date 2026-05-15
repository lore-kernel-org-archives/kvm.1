Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA343F6C3B
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884017; cv=none; b=g5vixocU/4k1NlZlLka1GoJD1oMTOCS0c5iwrjBjNiymzX9zBA9FHTbAa1vpUshs3lht2mDgElmlUEEP8JUwmH9VRNMYig3lO+hf2FYYfbXzu+IDAzzdt7WNenxS4n3esfWqMF15KmyF6d6R3wQPMxs3RtJ3Td4UZQ6eDHP33fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884017; c=relaxed/simple;
	bh=6MVVYrXYeJx/h4x3/7ZmRkGe6jHPyzxCw0+eNC2iSnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JM8QoP1bXk1K0kwasNW16lGwrsfkTDMamRi8HOA1SoBkNO6DHieyClP5ls51AKiTIn0GDZlzrXBaxC2oDBIJ7kLuCBOWyNnTYRNKRgzs8A9/uE0AMlkKyaByk0W1p4volPM4gKw5EKTQZnNRvF4Pa9FXZUB4DcK7T3U8mWW0ujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JRg4/kFB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRg4/kFB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc977e6aedso2641155ad.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778884009; x=1779488809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Jt7Kd3WCarFRpJgw3O1Bg6m17aRi135G15R1YIJLOaI=;
        b=JRg4/kFBlrbYcY+9Y69XjYWs03R1Fb/vwx4SmqZR4nhfnqxEYwvyab12lQMq4vme+g
         FWhKpCIEp9HWEcw+Pa9jYDK0RbOBOeZy4EnSfh66eZrJnZ3LUM7HPwNBFe2zGggs4noK
         lcN9HjCStAOp5wsBfRfMDZWLEH4bKpsNXVVGmv1m10zD5ktB4Cvv5wDNbRKrCa0qvrsY
         5xhX61RLgeTBF9hSzeZy8ZIFoMpxgxudLp1FCHYgw+QeMkzyfG3N4SI6GJ+gRULF/su3
         fqZqK/t7KV1O5TQapO1Wi+w/RJAr+5kkaqgagUcePOhnHuv6c4ikjHrioLp7aUCt6tUP
         v3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884009; x=1779488809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jt7Kd3WCarFRpJgw3O1Bg6m17aRi135G15R1YIJLOaI=;
        b=Lrp9g72RBmB+cuLZRTeDi8egwVzbOA2voY8fyjtyxkIOLRmf+chkmby7tRkoH22QaQ
         Os0l6tXpvD/fY0gADYz5z0cxYFoisosbDTIHZVEWFCX9zQde3Jqy91KJ++Pjr2vgieG4
         ZmM2Hielnxt3t790UPGJYBJQBBKbUidMZpMFjt6COgyCFA2/8tZLU35jQT5PhD65b6hr
         NPjFr8UCsj0b67qh1hWFYNKD85lPiHigfdyOiiuAVwebrL8A2bCbRbVvyB4Q4GH0Abve
         ntM0uv5lide3Pdosmtrds0iLlDhbWfrNER37a/cT6aXHbz+ybla7ncDVQfUNZpO7tZxd
         xwwg==
X-Gm-Message-State: AOJu0YxJZ9/TQFOsTxcu6uS/M+Tnp9v5nS0FGXNJKTvmhEASzsSgsXfi
	Hvw1FIuK73clSxnL/h8KWeAxKiTTlAkhYi+tDpuUuSz0Xitav4w3v4L+bILhwkDtUerflAvXEOx
	VkBUHeg==
X-Received: from plek2.prod.google.com ([2002:a17:903:4502:b0:2bd:27d9:9e57])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:94c:b0:2bd:a529:4b5e
 with SMTP id d9443c01a7336-2bda5294cdemr4182755ad.41.1778884009166; Fri, 15
 May 2026 15:26:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 15:26:36 -0700
In-Reply-To: <20260515222638.1949982-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515222638.1949982-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515222638.1949982-9-seanjc@google.com>
Subject: [PATCH v3 08/10] KVM: selftests: Add all (known) EFLAGS bit definitions
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

Add #defines for all known EFLAGS bit, e.g. so that tests can use things
like EFLAGS.TF to validate single-stepping behavior.  Opportunistically
use X86_EFLAGS_FIXED instead of an open-coded equivalent when stuffing
initial vCPU state.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86/processor.h     | 19 ++++++++++++++++++-
 .../testing/selftests/kvm/lib/x86/processor.c |  2 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c     |  2 +-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 77f576ee7789..851ffcd3340c 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -38,7 +38,24 @@ extern u64 guest_tsc_khz;
 
 const char *ex_str(int vector);
 
-#define X86_EFLAGS_FIXED	 (1u << 1)
+#define X86_EFLAGS_CF		BIT(0)  /* Carry Flag */
+#define X86_EFLAGS_FIXED	BIT(1)  /* Bit 1 - always on */
+#define X86_EFLAGS_PF		BIT(2)  /* Parity Flag */
+#define X86_EFLAGS_AF		BIT(4)  /* Auxiliary carry Flag */
+#define X86_EFLAGS_ZF		BIT(6)  /* Zero Flag */
+#define X86_EFLAGS_SF		BIT(7)  /* Sign Flag */
+#define X86_EFLAGS_TF		BIT(8)  /* Trap Flag */
+#define X86_EFLAGS_IF		BIT(9)  /* Interrupt Flag */
+#define X86_EFLAGS_DF		BIT(10) /* Direction Flag */
+#define X86_EFLAGS_OF		BIT(11) /* Overflow Flag */
+#define X86_EFLAGS_IOPL		BIT(12) /* I/O Privilege Level (2 bits) */
+#define X86_EFLAGS_NT		BIT(14) /* Nested Task */
+#define X86_EFLAGS_RF		BIT(16) /* Resume Flag */
+#define X86_EFLAGS_VM		BIT(17) /* Virtual Mode */
+#define X86_EFLAGS_AC		BIT(18) /* Alignment Check/Access Control */
+#define X86_EFLAGS_VIF		BIT(19) /* Virtual Interrupt Flag */
+#define X86_EFLAGS_VIP		BIT(20) /* Virtual Interrupt Pending */
+#define X86_EFLAGS_ID		BIT(21) /* CPUID detection */
 
 #define X86_CR4_VME		(1ul << 0)
 #define X86_CR4_PVI		(1ul << 1)
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index b51467d70f6e..4ca48de7a926 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -848,7 +848,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
-	regs.rflags = regs.rflags | 0x2;
+	regs.rflags = regs.rflags | X86_EFLAGS_FIXED;
 	regs.rsp = stack_gva;
 	vcpu_regs_set(vcpu, &regs);
 
diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index 67642759e4a0..7c10ba6e6fb4 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -360,7 +360,7 @@ static inline void init_vmcs_guest_state(void *rip, void *rsp)
 	vmwrite(GUEST_DR7, 0x400);
 	vmwrite(GUEST_RSP, (u64)rsp);
 	vmwrite(GUEST_RIP, (u64)rip);
-	vmwrite(GUEST_RFLAGS, 2);
+	vmwrite(GUEST_RFLAGS, X86_EFLAGS_FIXED);
 	vmwrite(GUEST_PENDING_DBG_EXCEPTIONS, 0);
 	vmwrite(GUEST_SYSENTER_ESP, vmreadz(HOST_IA32_SYSENTER_ESP));
 	vmwrite(GUEST_SYSENTER_EIP, vmreadz(HOST_IA32_SYSENTER_EIP));
-- 
2.54.0.563.g4f69b47b94-goog

