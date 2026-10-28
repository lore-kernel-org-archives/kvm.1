Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214184;
	b=v4LehKzDrdlMhMG/vxXqfeGsFw/rw0SFeEAogo54vbtaeJzLxYHcg8Mr3NUiQH6MghX8
	 0sclcN0qR/gWej1ea80nrLQCXKKlBuv9vFvhAYPLrQlmEHUgafCGo8f3rR11Cj8ZZkYyU
	 y2amSBfgrFj9SQGcVz1/bQ7r7y93zY9txC4whFD98lNXhebu4DjtM+1GFbRu1BvRwbOIV
	 J+Cca0Lx9ed3bmj7YgGIdd6T4pA+u1XfKWfaRLnPXP61l4BFRiBaLvSO57Ooxgj9OJBrJ
	 cDr5TE9bjcl63osQGNwwlWoYWrCinALvjTYC2atSxEMixuMV+a0FdsPLI65vPKwtu9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=LaqWhYbOMD7sY9Ovf2nEN4IH4sn07uRJnSek/bjgEtY=;
	b=JHi1b9EekqQHguRnhlqLSjIVfqq8A9avSORVJnFAwDSZDUZqQzIKqeWGkbbt6PAUdY5j
	 QqIcGhWl2mlozPBRYgBb4HHC17M7OnhlO9WF9umy0tYesyzi9FKJXQUyWvAGDYi2UCVVt
	 jWi2zfJoJ69FPnU+fH3iy4sl2BwhJvL+vR7dvxEipDthMKvcIB6Ogt2AqH4RiD7yeaAsH
	 K4iXwOr4CIh08dhfiXDe2O+8wcBXBEVH5egfKW7+urmM+t5Qi6X5eqjKagE1Bx/bN3S6k
	 Mg3srrr9N/4Rdf3hJEfhHqzh3R77UHw0US80/8f1Ox4h7RlLHyTJWCbSWEYkEpTfU8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PBBEXKdM;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885B606A33D
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 19:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A885B606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PBBEXKdM
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3adad90c894so1402162a91.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 12:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793214183; x=1793818983; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LaqWhYbOMD7sY9Ovf2nEN4IH4sn07uRJnSek/bjgEtY=;
        b=PBBEXKdMwfX+FjL1d5AZipaGfCOiVWPE3ZyGym/gyDjDtfCSZrVdtSa4uiqDHkUAnw
         nWn0JCeheccbKH+eq26vu7CIhvWZv7xT5cW7fsKeMpcAlFpHqzT5ibP85wG2AX/lsRon
         TdSnzsVXvxkKaZGTazt7S0ncI90qxjJdg+x21UouS6k4kJRok83E8UPGJr897LPL3tDR
         /Nx3bD17OLmsPvbZe4ifj4bJFa5nRrjMjbh3Fcx2L0ohXcoB4bWCgz/MfbE825NH4Bcv
         JyNMLGtOSIuFQPO/uobuTFC/iJS3fXRYHvdJqMkt4W9++3eQzL5XW+luaLqedqQZ/n95
         IBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214183; x=1793818983;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LaqWhYbOMD7sY9Ovf2nEN4IH4sn07uRJnSek/bjgEtY=;
        b=h0WPPouVVX+p+Idgpjj9HSXbGq6n4QQIi6jvdGfaO+DMALAg/2ZJsMI5WdgRBZhOxm
         gSyjNH6xKQYZ2h+5aTpfPsFYPbtip25A2fA6oHRFLfR5GC/+QE3u8xH8DgjV+Y/2adYP
         2Omgfg4CuVLVXCguBp4wIVG2oI+2jYKEU+HI8ymrIgZc/wDH7olqlRaiE+gm5jAlkdoG
         56VqdKdHH8O5pq9FLyaGQRibTs9e0gXAWYB0ZFosL2RyNpKZbmLhv0SvGwfZWaLiT362
         Ig0GzZNr6a247r5RqLHJ8bSrphZ3uCOWZE1p/AeDIY2dLpFW2RqoN44L0FoOxENevOhn
         VeQw==
X-Forwarded-Encrypted: i=1; AKwUvBwrIoFgjiisZeL04HF/0tQvbeZbifpehsMJLh8Qx7EFKF+MR0ucQAVKrJm9MX0MgHWvp18=@vger.kernel.org
X-Gm-Message-State: AFq9FYKv+oET1XR6dfoDynqaQq4lmJGxbCgC7j65LvKXF2cCOQu5f5VH
	Uc7XRQ+R3sabcZMLL7hVzeVd3sgbQ4OUAlECiWW4WvehnHfBMfWJOf9wHpgLQxhRNeCLnFE3IKJ
	Sog9Vqw==
X-Received: from pjbmh6.prod.google.com ([2002:a17:90b:4ac6:b0:3aa:f38e:cb2d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:264d:b0:3ac:9d83:8856
 with SMTP id 98e67ed59e1d1-3ae57e3d6c1mr2423992a91.9.1793214182870; Wed, 28
 Oct 2026 12:03:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 12:02:53 -0700
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
Message-ID: <20261028190259.1819571-2-seanjc@google.com>
Subject: [PATCH 1/7] KVM: s390: Drop unused and unreachable kvm_arch_vcpu_should_kick()
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

Drop s390's kvm_arch_vcpu_should_kick() stub as the one and only call site
is wrapped with "#ifndef CONFIG_S390".

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/s390/kvm/s390/s390.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 18fb200f854a..9900a1a1c148 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -3922,13 +3922,6 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 	return false;
 }
 
-int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
-{
-	/* kvm common code refers to this, but never calls it */
-	BUG();
-	return 0;
-}
-
 static int kvm_arch_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu,
 					   struct kvm_one_reg *reg)
 {
-- 
2.56.0.313.g2479322e68-goog

