Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163692;
	b=Hz+pjeA+38SzNCdd3DxhA4OsE36BDMqBCWd1Vq0uWU9s4d21wzYWvTq3ZMDCza1g62tt
	 7Ug73yllhEW983LWtySOd2cr/fpJsOWLtbHXMWvJqT9oxGCCna804IyGA3M43Tm5thhNJ
	 74BUmetfJAiKZwvcYHlzSdbOR9sGwQUBQE1lL93BYpLHs3pcvno/QN94/4GXelCeG1gNT
	 LPwIEVTsdg/8mdP1lZIylSiXlSlynL43Ypa4UYi4PDk7DCsMpvE/YhsG1m4vnBhoh0dfK
	 L3O+WtXX/hqvmqQ/91XISp4fBfqvqM144bhz2UGPKCLeVeSiHTxelmhwnxa+0g++Pog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=R107460VN/9Lpa+clFPqIU2LdqoiAh3lsBpjR3ojfMo=;
	b=aMF6njdM9MyxGJ5HBLVd+SuRe7j63s05qC/CzF1tB98Jjj0pT0TbZyWhKdFsaB20z9hD
	 T+P79V7Yekl4WkhRS+Rf4K1NgzNqym/z+A+wy5o4DsTI4cz98pqZGBMhS4Ramvg9yAYw3
	 91c/KNCzjuqFD175KmEl7YPsQTTuvO9Wf5G/M/YMirzeus/S5MKQ8t1tvqAEtqCMESPwu
	 tWJYCESHrTZGv2ibe2iaXhDxj/RYeFnZLwpdhbxBLuen19qyObo3Ah9Wl9Lhohp02EAIO
	 h8vks3d1HWMQvUVBq2YaYTEl3Hfk9SUKYU9Ea8MpO7M/39p/e077Dpvjsxcg4fu8f1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vwNyz0N9;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655CC60A3822
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 05:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 655CC60A3822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vwNyz0N9
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e0d885929so385296f8f.3
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793163691; x=1793768491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R107460VN/9Lpa+clFPqIU2LdqoiAh3lsBpjR3ojfMo=;
        b=vwNyz0N9FPu0o6YgZqRkzyBxaG10fWVAQOVs2yTJgwqUwsngi4f2LJYKzFLwLUAh67
         DOwSrB1EfBP4ISN8zOhWqBzWBG6uMI/a8jXB/Yt3Eh7P3t2DH+W+WaIEf4hgvUnIlGmE
         GU5KvEwXJh8uv3n77XZebnt1KWXR2VyExWIWlJtV74udckaWC8GU6wbAZcJIsFK3x7fI
         YoIH0TbFMLnn1s8tTSfhq2glVItyFXNbYZyqBPMS91Dzi5FJV4Lqvj/EPW5g4F0cGnJn
         FHCwWqZF8zeQaGmVa1nHtDPvFg/O8KHPXK9fO+TPJjU66j+zkQF8pb3SbU3/sFK7+CXK
         h+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793163691; x=1793768491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R107460VN/9Lpa+clFPqIU2LdqoiAh3lsBpjR3ojfMo=;
        b=MDCb+BZExZIjvPRTVkoNjNK4DIlBUKoACxIUIZhg+Pvhw0CJv5B5PEn9uJaS/I/96S
         Lcoc9K4sF1xiPp6iegk6reUXbkfm0hR6MbJJCZbFxIN5zslngvEBtw/RRv8Mq8SkbE7k
         jUSC7Ns6YEpjvAPn9nFoqNICOsY1Nh04AFtF3ViwKJi9pYV9/TBXGfpMpiQ0v56EoXot
         1Xf42ZF3nzVZfnUW8Q3fAd+IgHoPtk8vX5Xg2sLEyiPPSr7Tm7/T2k12NwFy2PAMb4Eq
         x0VPgKPSzZpsD6YMDD8RihX/YDvOxsKii/ADWzeLfEFA9pm7IO8VhloVfGiyViRoDZXB
         WgDA==
X-Forwarded-Encrypted: i=1; AKwUvBwWdrMIWu9yesAe6h8ndOuYLhhqP+4b3zNFEQOItqUYSd7MezH7ETcZQKXmdPz7hK01dwk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6JgGx5Hpy9iKFvenCZwXEXcJeu2xxkp4GKPSyiAEL2m4KCiQ9
	6sMp/f/X3ZVUMWGBxgTJYOocfwphlb+Qr2gBbKYAvbbGXgrs0sS26rj2
X-Gm-Gg: AYBFou34wQ6wYns8wUOfZy4gew0uJjfaJftMC/+qDoGgyyUx+NFwRnkKVTxylv/DD56
	vRB4o+qTdzCR99R0PF6YueFauUTVHyj1BuZrMQIhfK9KwT4FarOUbR8DWYhrTNrs6X1bLs4SaTC
	MPXwcer0+VFWPCCdFlFsZ1ZSqiW1U6xLwwM83gqOXzlPwAU0rDYuD3jgdHzpSyUrpLq6mmgZSlx
	nD4mo+Aw7In5DOLTr+2QRxnsQhyu0QLr/SHWECMnnSon2KbrdqqZScGLj7y9xdMcKd4wLfP6JlM
	KLd9mGTSXofyE5hUb400lh6n6SIj02AyE5EtFoAbeZH/ruZ2WeK4BgzoXpIugkK5vbFkHkcOlz0
	qVSu8nLYkyVhXnb7abbcUAfwyzwO6ammkVyS2N5fYxP3cnkqRVxvu0geUD85MrAGpoWeESs0xKr
	bO0yl5mxEs7oIQWLxZG41BwjyjNkH2WgsjjRO0nDH5GPV96WxRlp+QdBEXdxBDRcQ0wXcDEJV5u
	6sZqarzS4zMx12DPFn6UWsrN4qPMhEumg9rmzWtS0qWt0HjegTT+YBjickD/ALzwr/U4rP/wiy4
	Z7ANNqoTwbwVI2yfWkmB/U6cmNNgRnA/iH9sTzzw1zz+Hmx4ezmYtvf2hGSVq+OBGNMK3LBN2at
	o/v+YXLV3RiokkZ31OcBReAuWBXO56iEGqhmh48FUtzjliUEy03mJRiUKfmc8WfvCVdYh4YLDPp
	swp3JHxKzhCXHPGCcDE0AWy0m6v9zyzmGEQEOTGMiCj9JW1hcixPnrMqCUsDI=
X-Received: by 2002:a05:600c:4e03:b0:4a7:7d22:c50c with SMTP id 5b1f17b1804b1-4a963ffcf87mr21560375e9.2.1793163690594;
        Tue, 27 Oct 2026 22:01:30 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94eb8a60fsm13523365e9.3.2026.10.27.22.01.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 22:01:30 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Eric Auger <eric.auger@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] KVM: arm64: vgic-v3: Don't drop pending writes to active level IRQs
Date: Wed, 28 Oct 2026 06:01:12 +0100
Message-Id: <20261028050113.10046-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261028050113.10046-1-kmehltretter@gmail.com>
References: <20261028050113.10046-1-kmehltretter@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GICv3 backend also loses a level interrupt set pending through
GICD_ISPENDR or GICR_ISPENDR0 while it is active. Its LR handling has
the same split between pending_latch and an Active-only LR as GICv2,
and clears the new pending state after deactivation.

With vgic_mmio_write_spending() synchronizing the target vCPU's LRs
before setting pending_latch (which is a no-op when a vCPU writes its
own GICR_ISPENDR0), apply the GICv2 fold rule to vgic_v3_fold_lr().
Clear the old latch when an LR populated for an inactive interrupt
reports that the interrupt has been acknowledged, and preserve a latch
written while the interrupt was active.

GICv3 permits an implementation to clear register-set pending state on
ack. Doing so matches the GICv2 backend and makes a later ISPENDR write
a distinct pending state.

Fixes: 67b5b673ad4d ("KVM: arm/arm64: vgic: Disallow Active+Pending for level interrupts")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-v3.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 726e20a1da6e7..4d802fc9c6dd5 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -75,7 +75,7 @@ static void vgic_v3_fold_lr(struct kvm_vcpu *vcpu, u64 val)
 {
 	struct vgic_irq *irq;
 	bool is_v2_sgi = false;
-	bool deactivated;
+	bool deactivated, was_active;
 	u32 intid;
 
 	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
@@ -93,7 +93,8 @@ static void vgic_v3_fold_lr(struct kvm_vcpu *vcpu, u64 val)
 		/* Always preserve the active bit for !LPIs, note deactivation */
 		if (irq->intid >= VGIC_MIN_LPI)
 			val &= ~ICH_LR_ACTIVE_BIT;
-		deactivated = irq->active && !(val & ICH_LR_ACTIVE_BIT);
+		was_active = irq->active;
+		deactivated = was_active && !(val & ICH_LR_ACTIVE_BIT);
 		irq->active = !!(val & ICH_LR_ACTIVE_BIT);
 
 		/* Edge is the only case where we preserve the pending bit */
@@ -103,8 +104,11 @@ static void vgic_v3_fold_lr(struct kvm_vcpu *vcpu, u64 val)
 
 		/*
 		 * Clear soft pending state when level irqs have been acked.
+		 * A latch written while the irq was active is a new pending
+		 * state and was not represented in the LR, so preserve it.
 		 */
-		if (irq->config == VGIC_CONFIG_LEVEL && !(val & ICH_LR_STATE))
+		if (irq->config == VGIC_CONFIG_LEVEL &&
+		    !(val & ICH_LR_PENDING_BIT) && !was_active)
 			irq->pending_latch = false;
 
 		if (is_v2_sgi) {
-- 
2.39.5 (Apple Git-154)

