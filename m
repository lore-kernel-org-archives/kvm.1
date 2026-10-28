Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214185;
	b=cvsQXaVk9nqR2h+hus1eIRG2TssK6qsBKZM8aPMuwpHPm+TlGH8pD2Hh60prGCLQT4EW
	 /FjS6KmqIxkJFPIWtoEd8MgDJguw9mCYwqAJXOfByfaScZova3DMDRKAuu6NcsiQGjqdD
	 MLg078aearq6RsakFOssVrhgHYzw+KiQKFKdrl/7ba06UgH198KS/f9V5OYidtb2QCK0L
	 QH5lQ+zlbwxN7Ml5PCpIpoF5yF5vEHGCpRb/24jq0Qe8CGUnFmvgN9qHDb9xvBARfJqzK
	 ylA7pNnXqRloPqZFPdGAoNwzp41MOtLO+eLXbgZBpfMnF3RomyydtAVPs23NlM4u9dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=ua8GfkfDrHDUR8px+Sy19+vmLzFSWzTq6VAHh+SakiE=;
	b=BWk6hKK+6uHOG809v39qNcQ5zIsr2SDgGGuxVlhCfRj9yHFyZRrqlM/rz7pihWdjy9ZM
	 zMAVPRg1Ur5gpSUbAoF8FzpRsml6fP2c7vtfNEodc/ZBvOjbNL9IqJUYJYyuunhyxqeTV
	 fzCJIHs6Z1xj/M1KJ5puXAprs4ZVg9InL3jpqKNdqzWxy0bzj8oe30S3OgB1lWRowTmNB
	 2gO3+oYzn4wy+++uSO1BKuMIWUOPGN48XbGkHR7POyzWmSBmC7IBsMcU7RiVJrzHH+iWS
	 vgR5OaTK3h/iGEAwbAe0fan6b93L6ZIX3l/XJLisdbdSMDzoCEckeHIo07SCekcX9Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bxt7Z8wd;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDA460A261A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 19:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFDA460A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bxt7Z8wd
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adbc9a47fbso1504527a91.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793214184; x=1793818984; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ua8GfkfDrHDUR8px+Sy19+vmLzFSWzTq6VAHh+SakiE=;
        b=bxt7Z8wde6nB+VKnGLTbQOgO0WAPwnj21OlBYLZL2WreRrQgI/PSzqaByZuydLuYmn
         sDXb8vXBC1zN4uqGCFWL1ZdN/4EQt7dO3X6JV98m7ImqakWH7EBjlfQDZ2Jy9glZxaZS
         m9GjnXqDQGn9+nwwCxzQTmsn6qbLFouAvl5tRior2/pX2+MSgBlGvPyW6FrHBBa/fVaf
         ZYf8Jb+RyeuLpQIfiiWfV7HmIPZhPZ7kM49t12UUdV0ECNgwnf24y3axMKuVhTdP0+z8
         P0SB8puAP/sWa1hP0NKyo6zpkuZFD115enxQ7041dd0h/VoZj0m0v+hNcU1Pu9uKacfd
         WJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214184; x=1793818984;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ua8GfkfDrHDUR8px+Sy19+vmLzFSWzTq6VAHh+SakiE=;
        b=eOXpovyKQAhf4TV+gxZL2cW5kB4l5qFrD2XMS0/d4MF4Guy2rZto8332r24bs2yO+z
         SJVvA/YS/eShotJkIBUK8a1ENm9qTbPhom8gVQn0ZxTwOcg4AypekIvwZHwbUOrBJARg
         xEHfII4IymPTlYUlf8ROP6wCeCBBKNKVUREGO7aZn9t3PdshwQgZB+oedrLntQ1GVKVE
         ogmiB55kPwn5Dp+i9zPe/omTbCsXCDsZC9mPsmbsM/S5UE3GgdjT25wG6XLfd0OnQzXl
         ltBrwiNPOFi88Xxvl11rZZKKiAjvAboOa6Hs8koDQLGe9jBk0R3y0TdZuYA8IdUgothb
         b1WQ==
X-Forwarded-Encrypted: i=1; AKwUvBxXTY+FkgF0QYIHSQMp8jMeKQQfBJqcDeY7zKg74aPABNOfjIeGAk/svz3zljF99F1mW4U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLk7GaFMsMGyhmXjr2BzLyW+DcmCONI2tYPUNHoT3PTs4kggvjv
	os/aLiEA+dy5yVnXW+Y4Tz+G3xR85U3fCjGd/J1S2jLLTVwJkCy+ZpAHy+SP/FDH5thynFkNfBa
	hkRpFQg==
X-Received: from pjbov14.prod.google.com ([2002:a17:90b:258e:b0:3a8:d9d:78ef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224f:b0:3a0:b312:1fbe
 with SMTP id 98e67ed59e1d1-3ae580a7ac7mr2187674a91.23.1793214184152; Wed, 28
 Oct 2026 12:03:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 12:02:54 -0700
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
Message-ID: <20261028190259.1819571-3-seanjc@google.com>
Subject: [PATCH 2/7] KVM: Add a @force param to __kvm_vcpu_kick() for PPC
 backwards compatibility
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

Plumb in a @force param to __kvm_vcpu_kick() to force an IPI without
checking kvm_arch_vcpu_should_kick().  The param will be used to drop
kvm_arch_vcpu_should_kick() in favor of kvm_request_needs_ipi() without
regressing PPC, which for unknown reasons unconditionally blasts an IPI
in a variety of kvm_vcpu_kick() flows.

No functional change intended (nothing yet passes in @force=true).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h |  6 +++---
 virt/kvm/kvm_main.c      | 10 +++++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e7fc94e2910a..3b9844c3906d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1570,11 +1570,11 @@ void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu);
 
 #ifndef CONFIG_S390
-void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait);
+void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait, bool force);
 
 static inline void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 {
-	__kvm_vcpu_kick(vcpu, false);
+	__kvm_vcpu_kick(vcpu, false, false);
 }
 #endif
 
@@ -2315,7 +2315,7 @@ static __always_inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
 static inline void kvm_make_request_and_kick(int req, struct kvm_vcpu *vcpu)
 {
 	kvm_make_request(req, vcpu);
-	__kvm_vcpu_kick(vcpu, req & KVM_REQUEST_WAIT);
+	__kvm_vcpu_kick(vcpu, req & KVM_REQUEST_WAIT, false);
 }
 #endif
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..67addb9e48a7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3908,7 +3908,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_wake_up);
 /*
  * Kick a sleeping VCPU, or a guest VCPU in guest mode, into host kernel mode.
  */
-void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait)
+void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait, bool force)
 {
 	int me, cpu;
 
@@ -3933,9 +3933,13 @@ void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait)
 	 * after kvm_arch_vcpu_should_kick(), which could result in sending an
 	 * IPI to the previous pCPU.  But, that's ok because the purpose of the
 	 * IPI is to force the vCPU to leave IN_GUEST_MODE, and migrating the
-	 * vCPU also requires it to leave IN_GUEST_MODE.
+	 * vCPU also requires it to leave IN_GUEST_MODE
+	 *
+	 * Note #2, do NOT check if an IPI is needed if @force is true, as the
+	 * check also modifies vcpu->mode and KVM PPC needs to avoid that side
+	 * effect for unknown historical reasons.
 	 */
-	if (kvm_arch_vcpu_should_kick(vcpu)) {
+	if (force || kvm_arch_vcpu_should_kick(vcpu)) {
 		cpu = READ_ONCE(vcpu->cpu);
 		if (cpu != me && (unsigned int)cpu < nr_cpu_ids && cpu_online(cpu)) {
 			/*
-- 
2.56.0.313.g2479322e68-goog

