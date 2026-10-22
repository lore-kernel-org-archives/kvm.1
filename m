Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651606;
	b=PAgwnn7FbL/GkHMaq6SbDglaGhYUJcwOjqBzhIaj6h0LCkZcni4+sk4mef6hsC9Unwl/
	 9ZScb/4AI8RwGYD5LeG7zpN2MMGHF3U+qPU9W0gddjOPoO1lnnwva5yPZOh/MsfZOr4Z8
	 cfFu7Ipih851q7jMpjQ+5uWbRIg/HlOHqpRwa3g3w/K/pyRqtaGN+mGtOAAaB13cvCrBF
	 5m6BhrSc1v6vgmJd3iKZC1dpOcK/hlVE3JKNtKcNk5g7fy7/EMEfGMjwg7SrF2OHIIHaA
	 S+u4BcmzX02bgqyt/9n9fnUbe3AeMZ4Mpo5qWB8JEFohsIpNxdXhakZR+SBCytayGWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M/mYu7fYt3Nnrov1PUQgYA1NNwSASs0rt/VgYt7AiFM=;
	b=V6p7XUBXFaeSSR6PTOvo28SW6jZ7bPoo1FUUMPym2IREHUCbAhL3Nlx17Ii7lISkx0Ke
	 My22Ng2kog/E2mEUtAaS5+yivnf84XtwkEGYsfWWBTSFxfFtZOZz7P641zZrj2HVsM9XW
	 DNCTCClHwxT9dDXVqryPL6QeLJiqyK7qUU0Z1rzVezwqIuY6wSdg0UfJoD6LOv39B4jpo
	 bwmFKn2E7ECyxnS4Cj68+6rST2fUWJXVne/qMGKP25GEDxw47GrMNTMrcEZKGZVvH8CyO
	 283lTx3BMFf1VdYXzxPEsYyXfaqgrxvnAep7LYkesGevtjZUDsO4G/f7f3XIOPGlPrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V3VZFGWD;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2605B606A32A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 06:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2605B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V3VZFGWD
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-487049569b6so966429f8f.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 23:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792651604; x=1793256404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M/mYu7fYt3Nnrov1PUQgYA1NNwSASs0rt/VgYt7AiFM=;
        b=V3VZFGWD4KSHeM+DO1nMisS6i/wVge1HM6fBy74v88dr0yo3wdHQIcH6CdlySChT9O
         ZtagAUhE4z5oHQbTDfwTzSZAUjg5OkMthcQr1prlqKy+nrnPy6M4YeSm41x3jV1ykpwW
         GG4PBQloGs3RtgMl8ipgoXyQ19SZhjzgRr2vtEeIoOEnT/nmoFDRWKVqaiVR81kVgbGf
         Vn58vCEk37QLp6G8KhPEJg6hpNnZkZ/jKHVhQ2eec4UbeGitkwn8TsbXto7m7KJZdr6e
         qybFZILP1qgJqUYcnorNnc57GrlG+Ja02JZIX+MV14ALtyZqW3DKLy/V4RxNyP9VN+J4
         FTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792651604; x=1793256404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M/mYu7fYt3Nnrov1PUQgYA1NNwSASs0rt/VgYt7AiFM=;
        b=uPZcFoEDFsb8T5HeZ1DHTeSblB99I6L+GMt/8TAsRuAWINx9US/YMXMsSWBwzdgyg/
         d+8/tPe6RVkyGvqga5+v3nYzmSSLx9BTkuBlKsBTrNXnGJ43eSV3HOP8/An62z148kaa
         Fby24wLTHsAyzfmKbdY6Hn0eO4X7oItTqXIfhATmniu5RMyQxT45KHpLoIDFcEvbwrdZ
         vsn39HW8JYwNJmaNrFTctYAh0GahpDyW0tLsc+ESSBdXkOiW4iH04meBu9zTeMcOh1m5
         jBUajZH+vjFIHjM/JTynKPPzYSR2Mr0VSFf7CYAjj5mFw9KKDEJYiDKlflokDpLnVMzf
         5FQw==
X-Forwarded-Encrypted: i=1; AKwUvByJSd8AtkP4AfNEBOumLw1bwQj7eKOX8qfI4oiKGuq7N7Ss9aqfs5iqXobKpHuD1LtkIBc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbi/bkBbfe8ZWSe8d44f0UN8ihac9R6LWTquZqcOFlogjgGiVa
	YYa8gjX8W4Y4LxfzYIVtyEs7xoGn428XAjxqowYrWMvoA70Z6o4M5YLZ
X-Gm-Gg: AYBFou2t3sJ+NhQhxG7nLp4aRsT9IiMHcWORtVLKiwp07Zkx0mSOVMhaARmho56qPqF
	wQn9Pp9jUt+aiH84r74QLipqmlcRNHueMK1OJMqZzEJhczjHa53slHfYbqMCYTsQXX3kMNTQGoQ
	OLrLRPMg/rvg+HF5/Cg3y+Hlvn0doZXDkKvu7TqwASWnggQ3XzDzse/h1cnwSxwLqWRdPXGtnQX
	2U5a5kt1Feq0d+lY1DUxaODhZxMN670esGfO8dS2fP2H5csHL69BaTH2ylaIUV0I28tM3saASgH
	dHSAg55NMkmj9QMq31OBilLdaB79kbd7snoclA9JkAKE2NB4+pviR5S6MzpxzX0Fxrv6wPa1A5m
	2IJhMN7Xq/RuV5L9Cb1n0/XmApeHRvx+9Cet7TQ/tpipVykjIj3FpjM5xhc7UxfFRO6ihyB1Xqr
	k6zkW/QZxdBQvtB+QQuOnYumuj7tF/tuHPpnPO2Efy+gzohp/JSSjQvEARoF1bWZmkpq50nRM9x
	LoFMaCV7+MjAkHNBxKb1CZ/CT/cljEU8cmIejpRkjwxaTxMg6QArBQuK7xxlCm/AuzktNcZLik9
	HHo8tTAB+D1IB1+kXttm0SH5gdJ89vFopqm2wIfGdobCj9HcG86SMXu/LPXWGBUwdFLdHzcgVRQ
	UxjWSIcBB4AsuwEUT/yaFv3JvMF6C5JFvBT67a5ObJRYq8W7ErJX2XS1vAeo/f/k2
X-Received: by 2002:a05:6000:1111:b0:48d:fed0:ccbd with SMTP id ffacd0b85a97d-48e264caa01mr6437578f8f.34.1792651604419;
        Wed, 21 Oct 2026 23:46:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cd1sm10215624f8f.22.2026.10.21.23.46.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 23:46:44 -0700 (PDT)
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
Subject: [RFC PATCH 2/3] KVM: arm64: vgic-v3: Don't drop pending writes to active level IRQs
Date: Thu, 22 Oct 2026 08:46:27 +0200
Message-Id: <20261022064628.4206-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022064628.4206-1-kmehltretter@gmail.com>
References: <20261022064628.4206-1-kmehltretter@gmail.com>
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

Apply the GICv2 bookkeeping to vgic_v3_fold_lr(). Clear the old latch
when the LR reports that the interrupt has been acknowledged, and
preserve a latch which was not represented in the LR.

GICv3 permits an implementation to clear register-set pending state on
ack. Doing so matches the GICv2 backend and makes a later ISPENDR write
a distinct pending state.

Fixes: 67b5b673ad4d ("KVM: arm/arm64: vgic: Disallow Active+Pending for level interrupts")
Assisted-by: LLM
---
 arch/arm64/kvm/vgic/vgic-v3.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 726e20a1da6e7..8009dc6df00db 100644
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
@@ -103,9 +104,15 @@ static void vgic_v3_fold_lr(struct kvm_vcpu *vcpu, u64 val)
 
 		/*
 		 * Clear soft pending state when level irqs have been acked.
+		 * A latch written while the irq was active is a new pending
+		 * state. A write while the irq was in the LR may also have
+		 * followed the ack, so preserve it too.
 		 */
-		if (irq->config == VGIC_CONFIG_LEVEL && !(val & ICH_LR_STATE))
+		if (irq->config == VGIC_CONFIG_LEVEL &&
+		    !(val & ICH_LR_PENDING_BIT) &&
+		    !was_active && !irq->latch_written)
 			irq->pending_latch = false;
+		irq->latch_written = false;
 
 		if (is_v2_sgi) {
 			u8 cpuid = FIELD_GET(GICH_LR_PHYSID_CPUID, val);
-- 
2.39.5 (Apple Git-154)

