Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139136;
	b=MH5a1SPb+OsWByx3YFcfAvHLGBMzveWrqWhXjBTBskM+PXXX1KeK7Yi6z3uUuyoOhoTk
	 otbkEUnK7oyGBPfsu1ma6vTpvX4HdiE+bsdCjbCktVyUbx4pcWJFuQ15e00WOS22B5VQ7
	 3OGfKAqfkJhxm2TXTJksegg8t19vVixUfBMnmMen3RbYG0YoRhB15QrYEAny9spFCu0fL
	 qSh96s7/STsDTt3KsOFosItW5PJQ4pT7HJZtHSi4+gA18I55wSiTDol6Ufk9qZdePS/OE
	 nFrzGmmJaY++FHRb+UdI/Lw/zeVhl7ZVxTglBhvYURuTocRBGMZWTZ8mhRXVCc/mLHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=GXFll2rwFr+11U65zmd4BD/o9D9qDEYJ5GKHj/mz+LA=;
	b=igZ02d9RJI9xllq8kK6fbsFTJZxPhWZuqyvuJwe6P3okpcuJn2Sx+AeKrQ/9x/z1kSY0
	 MKnd9UpPguEftzYKpVu6CjITdpTJgAm/yHdo3nIGhbGx/94UUqGRv87P+XPPoDSL/nzEl
	 ddybmh+a/7WsrNPsV57aJn0GS4AibVUEi7MEIC6Y8AqqSFO2o4U3UT7776T7e4yuEUKiE
	 LA6iJDhmGHPMsLZMg9UevJ/XmStm/N45qrC/GwNIeCNc6iaFpFgyofHdcYCOkMGSnPI0L
	 01NZIyGfUPvk3y0dcxlaVBGURi1BSSLBZT46WWgfv6134K3wxlTA9DxSKE7j7PON7EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N6l6Exp8;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9C606A338
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAA9C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N6l6Exp8
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3aaf955db5fso458059a91.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139135; x=1793743935; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GXFll2rwFr+11U65zmd4BD/o9D9qDEYJ5GKHj/mz+LA=;
        b=N6l6Exp8j2Sb+gyuL9lMYXp6wSDrG9sZrgHXvFewgPl3/NhmhqeF1QX6W8XOFF1kIy
         2AF0AHImJ0mVnvCZT1/D4rs4D2KcKK3wUU2qgP2qVRsLN225J2MCB4ZT9kLJ3t6myMT2
         ZDp0UOWLBrYwowX1aXNfK5CNieC2lkbzUi8YApogmc82b+K55DfpBdb6E6gObX1KO/XG
         I2z+xJeEE5n2FbdnERHIEF3zQBOjC7YaZoyll8lZhAlJCPNv1f0pV78s7qkg9bfARs0V
         do9r908kAboJNQ3cA00KRbULlfqFO3o3qAUfGmRcxu/JLR/+xahdGDkCLDYzNZem//y5
         hN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139135; x=1793743935;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GXFll2rwFr+11U65zmd4BD/o9D9qDEYJ5GKHj/mz+LA=;
        b=T2Q/D8IeNNhi0IHGcV3nDv/FMUaKiCa+fGOI/7mQpuvxYMzywy2WZY4Q1skYz0qeoo
         hMS05qR8FR0yseW2enXlEIQrI+nO8UOY5bNfCEuig1jcEuRKgESvkjolW0ONRhNLmVZ5
         kKaFYuj/r37nmKDBwVpgW5Tdjq53mhe0Ub9xVDOePQpLFF8ytD2Hp/iyAzqDPw1GW0pq
         PZ5EgLZ0Vg88k3bCzWNGlN1pvBmsCbDWh+DVY3+e41TVKQlcg217bw8DbOI+X34G/xfi
         n2q75CCLT11+lUPRzej4/W7PE3OWB46GkXdpqHeoY5hIMwinq0ZoKbVjfWCsPaFq2MwE
         DtGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZ5uamqds5Mz/LNZ7DRvka7LOvtibiLV44cAHphxrDwdyS/v548i3e6FKiNN2HEtR8sQ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJF9WXnR8B2rYauVrUZ3IeXE0rjlFZATUDc85ojRUW5JtlfLRQl
	HMowsafw3uO0GM9j7Xpgh3Sv+kOHBKIZG8EcXafG+veOeJGPt9bOwx87lRWtdL3EPBkve/F4pVP
	+MJXtUA==
X-Received: from pjtn20.prod.google.com ([2002:a17:90a:c694:b0:3ae:1810:840c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2645:b0:3ac:9d26:551d
 with SMTP id 98e67ed59e1d1-3ae58313b6dmr297261a91.50.1793139135013; Tue, 27
 Oct 2026 15:12:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:11:56 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-4-seanjc@google.com>
Subject: [PATCH v3 03/15] KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Flush/zap every memslot in kvm_arch_flush_shadow_all(), i.e. when the
owning userspace process is exiting, as KVM must ensure all associated
memory is unmapped from the guest.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/include/asm/kvm_host.h |  1 -
 arch/powerpc/kvm/powerpc.c          | 11 +++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 708a32f89776..50a42f80e5f1 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -910,7 +910,6 @@ struct kvm_vcpu_arch {
 #define __KVM_HAVE_CREATE_DEVICE
 
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
-static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9194cf492d1c..9e9d0865c2f6 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -764,6 +764,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	kvmppc_core_commit_memory_region(kvm, old, new, change);
 }
 
+void kvm_arch_flush_shadow_all(struct kvm *kvm)
+{
+	struct kvm_memory_slot *slot;
+	struct kvm_memslots *slots;
+	int bkt;
+
+	slots = kvm_memslots(kvm);
+	kvm_for_each_memslot(slot, bkt, slots)
+		kvmppc_core_flush_memslot(kvm, slot);
+}
+
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 				   struct kvm_memory_slot *slot)
 {
-- 
2.56.0.307.g5fe7bd680c-goog

