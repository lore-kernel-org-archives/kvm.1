Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651605;
	b=HrbNIjVTjN6VN4UZYvuqOFkH1/ayx32aT/0IcAU6PLdcrzuErSK2to5Z1WjrL7jH7Vks
	 igGbSVSfsXgnQjcAek3qPxitdZkfes0TGB8p6FSvrZv2+DfGA5NQAPFrBG6zYyIhqO2Sk
	 ZD2YAAkgFBNuRvHfrlknOWp8GU2y2CCwzMM4B9mk8RyI2E/VVhPEpkKXmTiGzpd5OMlHG
	 55G+vZYIjiUlqHsLOhOry8MtCWtNwYdzq7GHHAesj+2kkLVAbNC1qBi+l4DyzGVZCNTKd
	 9o6VAdtLMoTcHRDaKA9u9XsyWBx1EUPaIKP/R7LKniy8YyVPWm6y62YvFShtB9FoQ1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JINO212XZqoHkVZMBAnF93gGUq9jJ54l6n4NWOl1V5Y=;
	b=cfsn8o1DzOGX1FqAXL6WGlMN4vpaNTZwlQX1g3c+nl0ohMPQUWbT4u6vJHtamKoqlBaG
	 yoGt6R8kzr7k+Yw0aEk5PghBoyyEYZCyC5vnI+fs0B8oB2hyH/lwHG62OMRi4y/zBXyZX
	 7okseXaPeHYnSRWpz0aO5Emf5mtkrUrCuIPo1PZz4wj8Wyw47HRjUaxItfrg1oRtxzvYI
	 hqVR/W2hmmmG0A6ksWhqmBAFJZiu5TbO4QBhaIxPcVlksSAVEX+Uo93QlXPUs1DwneRo0
	 b624v7LL6sDo4va9uBeXSQaBPkiwbjgB91tVUzM0R1RA6JXuqwgno9GNj3Iw6dAt7uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cNCJ0M9q;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A74606A31F
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 06:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2A74606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cNCJ0M9q
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so1317981f8f.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 23:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792651603; x=1793256403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JINO212XZqoHkVZMBAnF93gGUq9jJ54l6n4NWOl1V5Y=;
        b=cNCJ0M9q/b7mQtbydfezi6RVtg95JA7uiIUtRmmTFcB2iR4E1ZPuh3wkoIVKaENRZL
         j1XLvivjMYL9/qvncZ/EDIVvh1fUi+BYnL15y1SWQmahLVUIgNf/FL7AzkDavnhLQJR0
         xYsbEfk0lKZzg67+ZXvtYWXHPRtuxTotXxdNIgAgIv7mSNMOp8cAzcopLQiVERNbOY3T
         6JzkPTqAGit0k3t/nrvFzrNn0RCakMgoS/FohqZTYtwD9DZnLeS7UwFmSpJ2AR79xMUW
         CIR5OcoBbvU72dINDXQC99Vtkwqtytbwyaa6OLqNlkgcaY9oiJLsUROYopuocjuWVFT0
         Na1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792651603; x=1793256403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JINO212XZqoHkVZMBAnF93gGUq9jJ54l6n4NWOl1V5Y=;
        b=mPncN3ZffxAxS1IN9eOsrgCDBLdoTJ7EU8P7lU1xdYAxlb3nIoA0eOmsB7VtcmFLmF
         GWNZnQUM24fdekTtNP5qLCqdCul4S0vwPO8i1LMSap27VHKtKJg8o7uikgAB+abyuk9L
         DEjN9TquCGXGxpRGVXXvMn37xk6Jv5bctQq8CtcUpMLLgWgENLZVo/DT268MNURS/6M+
         57ABRa63RqvWmvqGScVdZcvyxuAQ4Ny4x6bnSaGCuDbNRbFwVtvRfPe/j0oA03Vz3zGX
         kcXmmJW94H5jKGhJpDKDOT51mT0gy3x/LdERVxW1MR2x/O7dmd5Qk49qdCIoKUAupD+2
         wxzQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTkc9HRyNFUkvkeQtKxpNI/EKH6mofVXyYruaMnan4wzSRc4rInbv6qm5N3yjBMS60zsw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGbmP5KUzif9SbQYOL9qJhrScCftdiTdvbWAlPkqybZs1qBYij
	yPPQK/laPRFzUWNMF7N4E/qhRjaOm3hLKlfd/tPiNfsJFwewo+tFLfx+
X-Gm-Gg: AYBFou3d3no/SbvacjJt6XLfOgtWT9zoQFXk1NHsbQ0a/4Bny1I8CA8kmS5szh2tozU
	TxqIWJ7Dkl7U3Wrltq0KODzwtxlk8n5Y1x13ofi9dHn2Ut3QG7hqeUAMrb7c1PrYZw8HrgS2+U3
	FJLXYeizzX5so+wt3c8BVSyhfJRmCaUaMXQF46jXz/dEam3YJQRt/+M63cDLKVnXrclML4Ih5+d
	/yK1a/DaRcoVZ1KHaALOO6x0UZjkmiqWsd7Wm54ClohLAi1tPYNhvYjZEtMWfQ8YvHU9orI8M9k
	NBbh5GohFLpDpSh5j+Zn4Sqc6yYuoLBlbhyWkx9l1pDq88GNgs8CoB6Mn7aoae3k6afYDPbs39y
	CZMiyeSfMQt1adr+ADwDL3FPooQJWzD3QI1105MInetQY3hEoOsINVCzJ7kv69pC4wuqDKxEcLE
	tGXX7dEicmhnzD7qYQ5Wt1h55pKwz5ZJFnjDBOnbdpdKPqtErqA1o46eEMskIAHo2WdxCOWGr7V
	BfjbeOvi0Eyin93ipU+FbVbIOgT8q2UAxJkI1lnSrq+vCXBpBiVKWKZ+YC45xcQgwk4COYPHsZ3
	4Y6VD9G3aU8pxZuQJuS0vPAOL1j+CvBctT3YHzcMyMWG/5oNTuP+QuYATcCv1CVxlNOw49ZpZ9M
	pzwQJlz6cqPxoXdipsq0WmDtyetegjx53Ug70Dzftmzy4+3GqbbS0kCRhEUM06/l8
X-Received: by 2002:a05:6000:26c5:b0:48c:8126:a260 with SMTP id ffacd0b85a97d-48e26427bd6mr9490490f8f.6.1792651602673;
        Wed, 21 Oct 2026 23:46:42 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cd1sm10215624f8f.22.2026.10.21.23.46.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 23:46:42 -0700 (PDT)
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
Subject: [RFC PATCH 1/3] KVM: arm64: vgic-v2: Don't drop pending writes to active level IRQs
Date: Thu, 22 Oct 2026 08:46:26 +0200
Message-Id: <20261022064628.4206-2-kmehltretter@gmail.com>
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

A write to GICD_ISPENDR for an active level interrupt makes the
interrupt Active and Pending. It must be delivered again after it is
deactivated.

KVM loses the second pending state. vgic_v2_populate_lr() leaves
pending_latch set for a level interrupt, while vgic_v2_compute_lr()
keeps Pending and Active out of the same LR. vgic_v2_fold_lr() clears
the latch after the LR becomes empty. At that point it cannot tell the
original latch from one written while the interrupt was active, and
clears both.

Clear the original latch when the LR first reports no pending state.
Keep a latch which was not represented in the LR, either because the
interrupt was already active or because the guest wrote ISPENDR while
the interrupt was in an LR. Clear the marker together with the latch
on an ICPENDR write.

A remote ISPENDR write can race with the guest ack. KVM cannot tell
which happened first without synchronizing the target vCPU. Preserve
the write, which may cause one extra delivery if it preceded the ack
but avoids losing a write that followed it.

Fixes: 67b5b673ad4d ("KVM: arm/arm64: vgic: Disallow Active+Pending for level interrupts")
Assisted-by: LLM
---
 arch/arm64/kvm/vgic/vgic-mmio.c |  9 +++++++++
 arch/arm64/kvm/vgic/vgic-v2.c   | 13 ++++++++++---
 include/kvm/arm_vgic.h          |  1 +
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio.c b/arch/arm64/kvm/vgic/vgic-mmio.c
index fddb9da0403d5..1728c78f99cfd 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio.c
@@ -341,6 +341,13 @@ static void __set_pending(struct kvm_vcpu *vcpu, gpa_t addr, unsigned int len,
 			continue;
 		}
 
+		/*
+		 * The guest may already have acked what is in the LR,
+		 * in which case this is a new pending state.
+		 */
+		if (irq->on_lr)
+			irq->latch_written = true;
+
 		irq->pending_latch = true;
 		if (irq->hw && !is_user)
 			vgic_irq_set_phys_active(irq, true);
@@ -427,6 +434,8 @@ static void __clear_pending(struct kvm_vcpu *vcpu,
 			continue;
 		}
 
+		irq->latch_written = false;
+
 		if (irq->hw && !is_user)
 			vgic_hw_irq_cpending(vcpu, irq);
 		else
diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
index 7182f63fc9382..37474ea2431c5 100644
--- a/arch/arm64/kvm/vgic/vgic-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-v2.c
@@ -57,7 +57,7 @@ static void vgic_v2_fold_lr(struct kvm_vcpu *vcpu, u32 val)
 {
 	u32 cpuid, intid = val & GICH_LR_VIRTUALID;
 	struct vgic_irq *irq;
-	bool deactivated;
+	bool deactivated, was_active;
 
 	/* Extract the source vCPU id from the LR */
 	cpuid = FIELD_GET(GICH_LR_PHYSID_CPUID, val) & 7;
@@ -71,7 +71,8 @@ static void vgic_v2_fold_lr(struct kvm_vcpu *vcpu, u32 val)
 
 	scoped_guard(raw_spinlock, &irq->irq_lock) {
 		/* Always preserve the active bit, note deactivation */
-		deactivated = irq->active && !(val & GICH_LR_ACTIVE_BIT);
+		was_active = irq->active;
+		deactivated = was_active && !(val & GICH_LR_ACTIVE_BIT);
 		irq->active = !!(val & GICH_LR_ACTIVE_BIT);
 
 		if (irq->active && vgic_irq_is_sgi(intid))
@@ -88,9 +89,15 @@ static void vgic_v2_fold_lr(struct kvm_vcpu *vcpu, u32 val)
 
 		/*
 		 * Clear soft pending state when level irqs have been acked.
+		 * A latch written while the irq was active is a new pending
+		 * state. A write while the irq was in the LR may also have
+		 * followed the ack, so preserve it too.
 		 */
-		if (irq->config == VGIC_CONFIG_LEVEL && !(val & GICH_LR_STATE))
+		if (irq->config == VGIC_CONFIG_LEVEL &&
+		    !(val & GICH_LR_PENDING_BIT) &&
+		    !was_active && !irq->latch_written)
 			irq->pending_latch = false;
+		irq->latch_written = false;
 
 		/* Handle resampling for mapped interrupts if required */
 		vgic_irq_handle_resampling(irq, deactivated, val & GICH_LR_PENDING_BIT);
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 7be81b936bf10..28ed27d982dfc 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -292,6 +292,7 @@ struct vgic_irq {
 	bool active:1;
 	bool hw:1;			/* Tied to HW IRQ */
 	bool on_lr:1;			/* Present in a CPU LR */
+	bool latch_written:1;		/* Level only: latch set while on_lr */
 	refcount_t refcount;		/* Used for LPIs */
 	u32 hwintid;			/* HW INTID number */
 	unsigned int host_irq;		/* linux irq corresponding to hwintid */
-- 
2.39.5 (Apple Git-154)

