Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395278;
	b=Nc82z+bi//9UotyuSL1/guXWiXcXOKeuq2hIK9fBUbfaHioWaV2zGpdQjFVPcn5WJogJ
	 MQXtcy7ces1hzHLf4YhqMyjpzSdCCTtYfhb643epNGh1rXf5y7niQNcVr+KXGxs0KT2bN
	 yBaw2lHoUUwZC/QV7L9L7JM5vCNrASzidI/e5lP/pRqHuxKb7tzvZiwXIo5B8puDT/rnI
	 Yull3dvGIjjL7RKlHiJl75X8h6meN4NRCxiYVuzuGzWW72NEGMLoPAP/LLR4/wfjFUUDi
	 IbWqyB8dOsSyW5hEMTlVPqbjSP9Rn3YFazLI4ggwUqMlwt+8zJk+OMfX498grJLIYPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=xVLOuB5izvjqY2+yn+X5wA6bkjFEaB6u1KjQAeAFkZo=;
	b=BdqLF7mkEZoDtZAtWzK4wXAdeezTRVkmervlwG1rug6lwb4UflbDFE5j7XwJdlVbLR0X
	 hWajmXp5ja2O+hx2vSxPZRNM5mdxSs+7TmD0zbDri8o+wHS9cDIWH7559MJmuJb5c7BD6
	 kvpZ86WlGCFHo/znYjYXAvYMDbg/zJRVFAuV/Baw6j/8Zhg3+y9erKztbxr/YAAI+YdbW
	 UrptD5RiEKNqjNssiJ2oZQTZG8/uAPlUDqfswQ+8xcDCq3t2iMxhBOJYYrBlxYly+32On
	 NETtN9nzPdSQsqkvxVmmO620MCvZtVXgSBHzBCj29ECHe8x0agFW63MgNWqdvZXp+Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Uz//6MQN";
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8F960A2625
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB8F960A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Uz//6MQN
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a05bfa6af5so859605b3a.2
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395277; x=1794000077; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xVLOuB5izvjqY2+yn+X5wA6bkjFEaB6u1KjQAeAFkZo=;
        b=Uz//6MQNemp4FePqQi8GcGjSLB+vaNce72eW8KGybfE1x6DYHudA+3n2QFCg45n/vS
         cIOAPGelLY/xENU1u1moIoGJLpRpD77OYk96GgCvQqK+xoaOw7FdATQO+lmPWnDMMgx2
         FcEHxJt3w+fOzYb1TR/DUllSwqkoEohSmcLl1PxCWYZjPQmpawJy2mnk8b3mggyu+oft
         qA0rLRaMlXLeL5y/SkM+OgKtFLnb+6ZjhTv0Tk7p3zuDgXRUOLHkDlkSTL8Wsxc+vCRt
         FuUh6th827fEhRBJFTmWOM+3G403iMRh3QetYH7zhPybwT716vSOUSixP1PfmY34w1e2
         KIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395277; x=1794000077;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xVLOuB5izvjqY2+yn+X5wA6bkjFEaB6u1KjQAeAFkZo=;
        b=ptRbJQT4BTLvQ8JlV4pmOJrVVUj/ODhxUTvOm5zQEEjhE2x//aLZRt/Y9ATY+JuV0a
         gMBY+wKS4LlgzuIwNKlm2+hHIXFthfeKW7w/h3kFLfkZdnGogJI74ckDeUU7aCTBzBhA
         M4R3nxzZMLzu+Hw/GoS4KaHnAngW34GFP8VD7VDnjgDz8pZQrsBa08CMrqKGFVFAldc7
         cx96XpxsDXk8sxazq6avbeMbr1PEqSaz3OhO+NaVUWocrAsOydRJJTevk9gfWYHZfbUp
         IzB7x1QocJMoMLphOIDDeAC1znZ9A5E1g6A/wPeX9/YN0F+TCUZeOHPsU6cX4Zggzd7G
         vYdA==
X-Forwarded-Encrypted: i=1; AKwUvBx3cjcvffY9tieZk+acTJHZDcGq1RGLZmAylB8SQTg9IzfkuujLBiXkHsDH9FZqxjZmgoc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnElXSh60IXTGLNNKh5BZfGfTlza0PGtReXoGuBeHIl1Tu7eqQ
	YlVdwEE96kdjt3pBTuBbe81bm2oQEdkutSSAv/jdcRx55f+gIEebVBhsUmdSX/E1oNAQLBGbGhy
	OOhUBJg==
X-Received: from pfwy10.prod.google.com ([2002:a05:6a00:1c8a:b0:89f:5522:3f42])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a118:b0:89f:c441:580a
 with SMTP id d2e1a72fcca58-8a9bf339441mr2641764b3a.36.1793395276884; Fri, 30
 Oct 2026 14:21:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:51 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-4-seanjc@google.com>
Subject: [PATCH v4 03/23] KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
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
2.56.0.385.gac671c819a-goog

