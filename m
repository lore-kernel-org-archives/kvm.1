Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214190;
	b=jWK3qQFVd6mKKNb8W6gjg+CVqgh6jT5Nl1t7eDVEkc7M6iWarI6S2U0w5wwEOZC+4Fnh
	 GnrZhJSw5xttgfPgSp0Pu5QgK1/kTlXme51zsuWUMzJS3l1K/huMPS16zCk7eeUbL8GrR
	 th9wdR5gbWJlONYwic20H4WN9SjKZ+BQpaiD1oIMYGEeT0UwZGMfbULp6+IqnUnEgdet4
	 r6GUoLaPDh0EAx1DRQbQhS10RHmYsePjsFhByk0LCBJTo2EQIRdFEpc5uAGEQo63aaY0s
	 YLMCmjqdpOqO7XPX8Ia7bf+uRk3em1MoA9IS9EnOt0zeiE8eVi6E1D3w4DKMuQpAsag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=KIzhXXz4HgfGAdkUpoWB/z0OMxuU8qDaDSAd1VOEpew=;
	b=Tb4cV0SI7N4ZjVIVREqX0Drd/BQqHpfbcgtQfBqJZFtB8BtiV1mCyIuni1EbZJBGT5Aa
	 qWW3EpcysYakGU7ocZEAE5JvOGblVkexLubh8Bqod/tWvfSIWf4usyL+ZkuP59rogogvx
	 BJUsC329x4d2WR8nlnDv1w+Net/99CYa0lWgc9B2IEB7i1Qzmp+S+3+dSGZ3675739ii/
	 9m/uWiDJxiXnB0lFm8C35lzVgXJNdnhThHSMhidkfPzAb/xArWl70PTDXQynlnxN7e1oX
	 nYQDJlxvjJnfG22DrZ5lsVTu8v5fHOqIqDb0OsD6FlcGI1EbVE3FhwxzbcQR3yCjJKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pGFlp0EN;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030E760A263A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 19:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 030E760A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pGFlp0EN
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ac8f449d1bso1104130a91.3
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 12:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793214189; x=1793818989; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KIzhXXz4HgfGAdkUpoWB/z0OMxuU8qDaDSAd1VOEpew=;
        b=pGFlp0ENKqWM3zxMe4l0HO32iIDM9FQtMJdGG2kuCIimYi/ALlynhAd+s/4RFHCyHP
         QWVo5FfdN7XfHpv6JCiYLeUQxNzWAPnLkzbeaBWX1HPjOYkK1GwSscaWUlC64P68wjOO
         H3o7khGN3TrIlClbtiKyWZpUspnBmfo93DPzjZsqVtDpGs9Ey9Zw1EaTWH+AxbdxLFIW
         cOZSqdrQg/XPvb5EZKmroN8Ni0EFl7myAWTx6gsOyByi529y3aT+akl8rlmJjrCr5Ue7
         oYDohpLF7bkKWQPGrgi8YGoW47Ac7/CEq3JkJRgnPTYxZnDlg4OR2/EywXGuakFg4eQA
         Fxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214189; x=1793818989;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KIzhXXz4HgfGAdkUpoWB/z0OMxuU8qDaDSAd1VOEpew=;
        b=HR15Dx3O2KAwJQlpKak2IJ17MI7mYvJ6dhxggk5EHlGLVtSAZZ8gU7FI6aTicduX7Z
         gUKAMxiNIzcCFGv0ckFCRMu5+A5hSlroE4t5Ii0hlJumE4hIVyVPCDAaRP87f2noAe4L
         P+C1U8gsdGNGLShxqtEr9u5JIuV8T/Ds/Pl4G5koBTqB5/0u2HpajF7sMWT3q0rN0zew
         aBBLw2zW3F5nDSsPlNhwMW/KwEXxxaAWKBHpCD2mctOdEjpT95dGXrNAarmIUsNWjgm2
         aIP9xx7VvtzNEhZgBGgr0qc2R7WEHdEGAMctI94UndE3axXZPhJAmfuvO9o7RwS/tyKh
         aJjQ==
X-Forwarded-Encrypted: i=1; AKwUvByLL0tEcvHd1SxbftQj716p5Da/ErXo+D8e0a0yL5eP4Qt44xm9xtixCLbkcS2Hr0csSHA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqpxmgBMubmqX4WekNx1DWYGYucFyYzHaDYPoKDa/8sDx4VOEi
	BIvOHVFdc4bZDdsuJXxlcasawBE9JlI3Eko1b4VUfPs0WPAVUTiJpe7KTX23hx3mfqlHImhRszZ
	piugCjQ==
X-Received: from pghw14.prod.google.com ([2002:a63:f50e:0:b0:cda:c74c:ca8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b86:b0:3ac:a11a:7c84
 with SMTP id 98e67ed59e1d1-3ae58195de0mr2519930a91.65.1793214189231; Wed, 28
 Oct 2026 12:03:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 12:02:58 -0700
In-Reply-To: <20261028190259.1819571-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028190259.1819571-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028190259.1819571-7-seanjc@google.com>
Subject: [PATCH 6/7] KVM: Plumb the full request into __kvm_vcpu_kick()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Plumb the full request instead of just a "wait" boolean into
__kvm_vcpu_kick() so that it can use kvm_request_needs_ipi() instead of
the flawed kvm_vcpu_should_kick().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/include/asm/kvm_ppc.h |  2 +-
 include/linux/kvm_host.h           |  6 +++---
 virt/kvm/kvm_main.c                | 17 +++++++++--------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index bbe7378ad0ef..011dc422af78 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -38,7 +38,7 @@
  */
 static inline void kvmppc_vcpu_kick(struct kvm_vcpu *vcpu)
 {
-	__kvm_vcpu_kick(vcpu, false, true);
+	__kvm_vcpu_kick(vcpu, 0, true);
 }
 
 /*
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9db42f58c561..035b1bdd8c09 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1570,11 +1570,11 @@ void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu);
 
 #ifndef CONFIG_S390
-void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait, bool force);
+void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, int request, bool force);
 
 static inline void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 {
-	__kvm_vcpu_kick(vcpu, false, false);
+	__kvm_vcpu_kick(vcpu, 0, false);
 }
 #endif
 
@@ -2314,7 +2314,7 @@ static __always_inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
 static inline void kvm_make_request_and_kick(int req, struct kvm_vcpu *vcpu)
 {
 	kvm_make_request(req, vcpu);
-	__kvm_vcpu_kick(vcpu, req & KVM_REQUEST_WAIT, false);
+	__kvm_vcpu_kick(vcpu, req, false);
 }
 #endif
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e1a9da8b43d7..f1792256576b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3913,7 +3913,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_wake_up);
 /*
  * Kick a sleeping VCPU, or a guest VCPU in guest mode, into host kernel mode.
  */
-void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait, bool force)
+void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, int req, bool force)
 {
 	int me, cpu;
 
@@ -3948,14 +3948,15 @@ void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait, bool force)
 		cpu = READ_ONCE(vcpu->cpu);
 		if (cpu != me && (unsigned int)cpu < nr_cpu_ids && cpu_online(cpu)) {
 			/*
-			 * Use a reschedule IPI to kick the vCPU if the caller
-			 * doesn't need to wait for a response, as KVM allows
-			 * kicking vCPUs while IRQs are disabled, but using the
-			 * SMP function call framework with IRQs disabled can
-			 * deadlock due to taking cross-CPU locks.
+			 * Use a reschedule IPI to kick the vCPU if the request
+			 * doesn't need to wait for a response (or there is no
+			 * request), as KVM allows kicking vCPUs while IRQs are
+			 * disabled, but using the SMP function call framework
+			 * with IRQs disabled can deadlock due to taking cross-
+			 * CPU locks.
 			 */
-			if (wait)
-				smp_call_function_single(cpu, ack_kick, NULL, wait);
+			if (req & KVM_REQUEST_WAIT)
+				smp_call_function_single(cpu, ack_kick, NULL, true);
 			else
 				smp_send_reschedule(cpu);
 		}
-- 
2.56.0.313.g2479322e68-goog

