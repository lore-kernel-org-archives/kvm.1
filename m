Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163691;
	b=1FGm7hIqm5ujJqB8ptOHLNb09+CDelDAyLsIGfzG1yUcNUA1c1Yc6BoSNF49KJIlkE1Y
	 FDXZRdFxHHWBAWEuxgmcJdQVfrdTOFOU3UWiqtksKOyzayzBp+VJ43uU1sOPrRcpkxi+J
	 hgk/t30uXQkljhGFqrrfs5yxK0UB4PlzopKjJAGNQyBODgHwiIoZCM4GRvCzqoYuTXs8B
	 2aPaWmDhDkM6wP2oglQzyqWFQnaGEI6goWC2UKlaD3TiZXJFQIwKbIwu//CcTCUNK/Wh5
	 5TaXmdLAWHk3kH4sjcVLptWi2dO1am4fkxTTcm0gA51sSSvAAKAUYcf9KN9Gw/cjGhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4PPjtqMp1V58uGYejGtWodvU/HeeS5pvfYydRAC9x9I=;
	b=UolVW8JQ5Cep6B68HOEvphHvMuywnGhfYvnioedRSAmjkU6+MI285NCTtHWamMORpRRI
	 8qI61d7qFMiUC6dy5P6qEMRqOd9VuOHXBMGQIC4ep7SKP78HGoyCtXNqkjp3Xg78J4XIm
	 vdK1nGc+Qme+T5M5tZaZMtlo3U6TSFGxGXqiplydw6ieSiYx4jSI35Tbt71I48L3zAKdb
	 3qY1tPqX8hUy7wv/hUrBM6OrKetIQUwp0nMyNXFf7wBC6tbAlekYqiPyRPJY2sdziDsMO
	 tbRjxSFIgJISuLdvsiPQMFqxzf/VBujxaO6jBGfg1qh3rqzlUwUV5C5WK71tjEZ0THQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=unqNiMoR;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00520606A334
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 05:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00520606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=unqNiMoR
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so2383955e9.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793163689; x=1793768489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4PPjtqMp1V58uGYejGtWodvU/HeeS5pvfYydRAC9x9I=;
        b=unqNiMoRYCef3A9/hfXhrILrTnGL85C1xRpiwvrMP317cz7PbheJLnkdxtnAQBULFn
         x0Na3E5+jDO3SdIKc/QmiQD1TO69+Lhblv9SehFYKUjMECY6h4+ICO8e7necMnyHd+ZE
         D8N9WLr8AAtG7sBU/qYRP+JKBCjONj/HTtiJGhxewmpZ0AnPuKkXL9ltUyrj6Z4HFKOq
         h2SD3L5Ex4Aip2hhDgoAKdydvYczjTHgixF5sq2kq9XIb1oQV2qKPo9Jj2PSUVQg/PcX
         RfEG58xmn4X9jR2+P85j8yv2KRskqZ4larVHaD8xeODB/7QdFdXpqfuRbO/BMHXoC2UT
         A4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793163689; x=1793768489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4PPjtqMp1V58uGYejGtWodvU/HeeS5pvfYydRAC9x9I=;
        b=X6lY0Oy7KNq9JQD/nNUUfmcE4JoO7eSa4Vr8Zj3vn5Q2g83ljZLuuBzngY1BXMYBIz
         LCAJDIy5O0Bt7EINKK7PQuImT+JQiq7QPnr24DWxe6aFLS+EmoHjZg6HwIuU0b5ACCCz
         EWMdqAcpFCky/8Nk7V3WKfv/CXo6BjKlPa0aZATbkrqz1SRMe8EEGSvtklE/7wRK0vGz
         +r3brWkc4zRflmhe5+v/h00AKgFOHyTMFvQfVO8VCmqOcdmGig0uOGiSDl/1P3O3G7fo
         r0+aMilsCSX3sT088lRqpsE/nRdWkR2NyBMNzC20hY9CKXOBtO4170HBtt8Kx4qAs/8r
         OUoQ==
X-Forwarded-Encrypted: i=1; AKwUvBy494uwHNJ77DMKby/raqFjoS2BLA/EJGw2l+timY8p+zKNXR4jIEXPdxttL/edagwBmXU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIt1qqzzKFYdEhf0wuaLC6KwHtjhhg+7vD+62F4pb7ufyyzurOo
	fcR3sbPml0VU8zvZUm76QitLm5jp1YkvPUskZnYI5uqtwwpx7vn3WLoY
X-Gm-Gg: AYBFou3/WiOXClOyqriWS1KRKPtuC/v8BPXs9oMxyHnv/bkY7w1bFGEPBh7tylIGraK
	QTXgTtLWrnWLTSYmjZHWOqCn4teepIA+RdFOAHjX5Yk+9Q1P2IX+zfQl4HbI+bRc9Al6r76rf1b
	DAanaT7HoNENV877hcjNRyOGp+um/pkVVl+jt1Xc6m1c9CpOogYdSLm81vy4ZwlKpifk+YQTIO9
	DLpRvw0VT0jYFMQXeKgAaGx7PmfWwMwLl37zC8zcltFjYsDhBIsVFeHSRdxlgsDdOZrdpyuR2RF
	HQqMA8xaTJnkhbSkkZ71mqCKmLAbuHqNWp+jPpapVSsRlg8UXL3QfJ80Ai4j54eF/GqgOWptyRd
	7SOmv92Oqy12DLRnh4wDy0sSoRbbutDA6U/A21k2nBVYvABujkYlLJ6kpFgnQa/NZDKvDH76PrL
	y46cJCQPrdbRpUHoA7eHioag45bZFJ5LmLSUavn/hQWIasXu/6CFlIV5utvgZQBfo8VchxjQ2rK
	7rVd0BhsfvX1E7cdn1q/OsC96Bi9H059+/UORioc2MkITqzrYRBLBPt7v7fV59dXJ0nUeNtPXek
	KI8kRu9rpBasjoxntbsJ6Dn3Hnn5+L9hf7lijIPIwL4mr2Sy7yEEJwWVFAP1FnxUe6n8UdrpiHc
	PhF9hv5KoYqPShtNYn+2yNB8D9VHPJj9EdC4hImZGPJo708omh9phw8hN4dTMgh42mtuklyWDp1
	0N/V/tm20sX5K9oYzGjuKijek7ej7COqfpqrQW0g==
X-Received: by 2002:a05:600c:154e:b0:4a1:7bd4:d07d with SMTP id 5b1f17b1804b1-4a967e8d5a3mr18553845e9.34.1793163689112;
        Tue, 27 Oct 2026 22:01:29 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94eb8a60fsm13523365e9.3.2026.10.27.22.01.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 22:01:28 -0700 (PDT)
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
Subject: [PATCH v2 1/3] KVM: arm64: vgic-v2: Don't drop pending writes to active level IRQs
Date: Wed, 28 Oct 2026 06:01:11 +0100
Message-Id: <20261028050113.10046-2-kmehltretter@gmail.com>
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

A write to GICD_ISPENDR for an active level interrupt makes the
interrupt Active and Pending. It must be delivered again after it is
deactivated.

KVM loses the second pending state. vgic_v2_populate_lr() leaves
pending_latch set for a level interrupt, while vgic_v2_compute_lr()
keeps Pending and Active out of the same LR. vgic_v2_fold_lr() clears
the latch after the LR becomes empty. At that point it cannot tell the
original latch from one written while the interrupt was active, and
clears both.

Synchronize the target vCPU's LRs in vgic_mmio_write_spending() with
vgic_access_active_prepare() and vgic_access_active_finish() under
config_lock before setting pending_latch. When the interrupt is in an
LR on another vCPU, this folds any prior ack into the VGIC state before
the new pending state is recorded.

In vgic_v2_fold_lr(), clear the original latch when an LR populated for
an inactive interrupt no longer reports a pending state, and preserve a
latch written while the interrupt was active.

Fixes: 67b5b673ad4d ("KVM: arm/arm64: vgic: Disallow Active+Pending for level interrupts")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-mmio.c | 76 +++++++++++++++++++--------------
 arch/arm64/kvm/vgic/vgic-v2.c   | 10 +++--
 2 files changed, 50 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio.c b/arch/arm64/kvm/vgic/vgic-mmio.c
index fddb9da0403d5..e42eb10d502b2 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio.c
@@ -350,11 +350,54 @@ static void __set_pending(struct kvm_vcpu *vcpu, gpa_t addr, unsigned int len,
 	}
 }
 
+/*
+ * If we are fiddling with an IRQ's active state, we have to make sure the IRQ
+ * is not queued on some running VCPU's LRs, because then the change to the
+ * active state can be overwritten when the VCPU's state is synced coming back
+ * from the guest. Setting an IRQ pending also requires the target VCPU's LRs
+ * to be synced first so that any prior ack in the LR is folded
+ * before pending_latch is set.
+ *
+ * For shared interrupts as well as GICv3 private interrupts accessed from the
+ * non-owning CPU, we have to stop all the VCPUs because interrupts can be
+ * migrated while we don't hold the IRQ locks and we don't want to be chasing
+ * moving targets.
+ *
+ * For GICv2 private interrupts we don't have to do anything because
+ * userspace accesses to the VGIC state already require all VCPUs to be
+ * stopped, and only the VCPU itself can modify its private interrupts
+ * active state, which guarantees that the VCPU is not running.
+ */
+static void vgic_access_active_prepare(struct kvm_vcpu *vcpu, u32 intid)
+{
+	if ((vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3 &&
+	     vcpu != kvm_get_running_vcpu()) ||
+	    intid >= VGIC_NR_PRIVATE_IRQS)
+		kvm_arm_halt_guest(vcpu->kvm);
+}
+
+/* See vgic_access_active_prepare */
+static void vgic_access_active_finish(struct kvm_vcpu *vcpu, u32 intid)
+{
+	if ((vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3 &&
+	     vcpu != kvm_get_running_vcpu()) ||
+	    intid >= VGIC_NR_PRIVATE_IRQS)
+		kvm_arm_resume_guest(vcpu->kvm);
+}
+
 void vgic_mmio_write_spending(struct kvm_vcpu *vcpu,
 			      gpa_t addr, unsigned int len,
 			      unsigned long val)
 {
+	u32 intid = VGIC_ADDR_TO_INTID(addr, 1);
+
+	mutex_lock(&vcpu->kvm->arch.config_lock);
+	vgic_access_active_prepare(vcpu, intid);
+
 	__set_pending(vcpu, addr, len, val, false);
+
+	vgic_access_active_finish(vcpu, intid);
+	mutex_unlock(&vcpu->kvm->arch.config_lock);
 }
 
 int vgic_uaccess_write_spending(struct kvm_vcpu *vcpu,
@@ -452,39 +495,6 @@ int vgic_uaccess_write_cpending(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-/*
- * If we are fiddling with an IRQ's active state, we have to make sure the IRQ
- * is not queued on some running VCPU's LRs, because then the change to the
- * active state can be overwritten when the VCPU's state is synced coming back
- * from the guest.
- *
- * For shared interrupts as well as GICv3 private interrupts accessed from the
- * non-owning CPU, we have to stop all the VCPUs because interrupts can be
- * migrated while we don't hold the IRQ locks and we don't want to be chasing
- * moving targets.
- *
- * For GICv2 private interrupts we don't have to do anything because
- * userspace accesses to the VGIC state already require all VCPUs to be
- * stopped, and only the VCPU itself can modify its private interrupts
- * active state, which guarantees that the VCPU is not running.
- */
-static void vgic_access_active_prepare(struct kvm_vcpu *vcpu, u32 intid)
-{
-	if ((vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3 &&
-	     vcpu != kvm_get_running_vcpu()) ||
-	    intid >= VGIC_NR_PRIVATE_IRQS)
-		kvm_arm_halt_guest(vcpu->kvm);
-}
-
-/* See vgic_access_active_prepare */
-static void vgic_access_active_finish(struct kvm_vcpu *vcpu, u32 intid)
-{
-	if ((vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3 &&
-	     vcpu != kvm_get_running_vcpu()) ||
-	    intid >= VGIC_NR_PRIVATE_IRQS)
-		kvm_arm_resume_guest(vcpu->kvm);
-}
-
 static unsigned long __vgic_mmio_read_active(struct kvm_vcpu *vcpu,
 					     gpa_t addr, unsigned int len)
 {
diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
index 7182f63fc9382..f3ba3177dd97b 100644
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
@@ -88,8 +89,11 @@ static void vgic_v2_fold_lr(struct kvm_vcpu *vcpu, u32 val)
 
 		/*
 		 * Clear soft pending state when level irqs have been acked.
+		 * A latch written while the irq was active is a new pending
+		 * state and was not represented in the LR, so preserve it.
 		 */
-		if (irq->config == VGIC_CONFIG_LEVEL && !(val & GICH_LR_STATE))
+		if (irq->config == VGIC_CONFIG_LEVEL &&
+		    !(val & GICH_LR_PENDING_BIT) && !was_active)
 			irq->pending_latch = false;
 
 		/* Handle resampling for mapped interrupts if required */
-- 
2.39.5 (Apple Git-154)

