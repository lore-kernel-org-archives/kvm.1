Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720983BE659
	for <kvm@vger.kernel.org>; Sat, 22 Aug 2026 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787392446; cv=none; b=CY9tMq/GIsQdIo4WiPC6FIf1JzytCmI3O6MkNYHEcKy/qUO/v1IySdTpe54wKA2YkIbLTXIchqjFyFU80ET/rtWyVTsaeOKUcfm4Agy72IruKtvHvwJqPJKBhZSYcYZJleVQOP/BIjgLqopf7BKBF5hkBnHAMkcc6C+Pr43nz/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787392446; c=relaxed/simple;
	bh=0b8VuyaQuF/XCQ3FNlzXnVd3Yhyh8aOgT8hrkybBkwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSnjAbHILqtnBtU8Mblp/MEd9KFeVZEOflzk8gi/+xVxMo4M0DpHrdSxgEDcFJ+WeN2aIiKMxyrdKj8kqGWH/vuDfwNzTvP5r6KQwp3BGPLzneGiC/EMNuHuRjO4yBGd/gXBDV7r53cGGeF/AfKP2evcad3JymxbkiFgeitCFN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9UnxW6j; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9UnxW6j"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a3efa2b38aso3472787a12.2
        for <kvm@vger.kernel.org>; Sat, 22 Aug 2026 02:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787392441; x=1787997241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PqPQildVUr5OZauQmAhm0/cwcJh5PP5Ede7gwQE/8hQ=;
        b=e9UnxW6jDvw4BHJ7Rjzi8T2NImnZN4ZVApWPIFTFgjhe8NSSR8kuxyh3UIkjez0Ijv
         QLCgweKJg9uU2pprbRNq3Rsn+yOsaD5CpAA72+hN7qWNeSBAgP9elCu1aHhtqCe9U3Bg
         KU3WSR50Hq30ZyZYFhVa2i/LIXA/v0eqZ6v+R7CZfBcYD0kaeSp3yDNrlgXncH7Y1v3P
         Aw46C1xRRK+F8Is+k1nL9KtpNVCyQIrLnroH3clbLoKUk/5Ws50STOg+rV+PUeEooNOt
         ljtCIa3KRn1yomvD+MQsAJBh//URAF1v9adKw1efp0X+59phFdMlzmHDeuCjNmak/ugG
         McaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787392441; x=1787997241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PqPQildVUr5OZauQmAhm0/cwcJh5PP5Ede7gwQE/8hQ=;
        b=R5oMijNMy1oecB4RYUTL9+ejeqrAsTCiDEZSILpA9vMgqd0k1lIqd+5digFNzGN53F
         sikmenk52xhoc353YR0k1T7pW+QP5XeS4Ka3+JweUwkcLCGYsb4mBNhcNImNyddFNCfD
         BgH+n1clsv6EoyjNbaiE4J1itiWWgz1JrxMROp48aJ9loa9hjD6+qOhB1XJpGTIUry0i
         jbksVzBpZjPQzj+DcmHlc8mwYDjZjqB/bZu5ibvfBWkZ+Cb0eFFCoSjtpPf+YyFiU7yF
         Cy8wqcJoNS7TYTDseEepjujnqj5G9IahXz3SJ5DyUnXFlcBejBTS3FZI5YjAGeqgmtUZ
         7FHQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4rCGOXRLskNPNzQ0MQvZrpnPGIvOckxm7mOhpamxLQE7rPb/c+igNQCpDaYpwCM9KGeQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nLtC7ZpfHZz6wu7MzAfcWSwyxMYWgb7TlguhKarK4/T49SfR2/
	ON+HcpjM3pGpTsGfxpSnCG26IUysdPGPEXNRziNB2us7TFM/J21RQ67C
X-Gm-Gg: AR+sD13zORGiJsyCvpVIzAXXu4GXQREBww0ZSd1vG/tMZjjZMZtGytieBSKo9Fr1cyI
	RyBcP7bQiE1rVqKBvgtyFtQ5CiHjWjPDW9VwbzgY2ibekN0+k8Bhy9mZThfu0X6xtO+Q5wiYKiX
	b6tWfU+L163eW9y18wYeVmSNZcOa6nEr6k0NK0OfbxcTgomA/Q1FUNxvFvVruFlfXgW408o46EI
	GUQS8mMxc/BpXskj06Nc861RhQS03Fc6+L6f3UUAh6omimdQ4KR6d1eaQMWdS5d0fuhbxjHnpob
	7vGNmj5F9xVfHgVHgNsQIgeJBRttcgeSeSigAHMSPffDEz5Oea6vTYEG3PgcabHHOM5PVXi/Oaj
	YdYwWAqBtqUWglOposeyR6ALn1n+i/S3hB4eqh5G5av6/lV85JwuBSY+X4hxcnhK1n4yOKqhfIK
	65CZWzQ57VDHA9XB3C+c9XL6O8VXNOCjIeRS/lc4PIo6zZum2mVcQv+BqHb+M5IZojfAouA2MoO
	AaSND/xgZbpmLhKVGSE+w15XJr1MeJQB62cfvgnTGjU4s5F4OjIpHs28jMdIVt3FPza5cc7vtAG
	5N8yB3SsPGEtrFd6IiTampAuxPwxsXh3PJ2bBL30RstDQCMjHvdPR2SXNKYANyvYHP5Y
X-Received: by 2002:a05:6402:4613:b0:698:9e5e:5df8 with SMTP id 4fb4d7f45d1cf-6a42f1aca88mr12197582a12.7.1787392440592;
        Sat, 22 Aug 2026 02:54:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c327asm11151586a12.8.2026.08.22.02.53.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 02:54:00 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 3/5] KVM: arm64: vgic-v3: Separate redistributor teardown from unassignment
Date: Sat, 22 Aug 2026 11:53:44 +0200
Message-Id: <20260822095346.53882-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260822095346.53882-1-kmehltretter@gmail.com>
References: <20260822095346.53882-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MMIO-bus unregistration may synchronize SRCU and must run outside
config_lock. Conversely, clearing the redistributor assignment needs
config_lock, and teardown must do so before freeing the redistributor
regions.

Introduce an already-locked unassignment primitive that only clears the
cached region and base address. It deliberately does not adjust free_index:
failure rollback resets all region counters, while VM teardown frees the
regions. Keep MMIO-bus unregistration separate. Unregister devices before
taking config_lock in VM teardown, then unassign the vCPUs before freeing
their regions.

Move redistributor cleanup out of __kvm_vgic_vcpu_destroy() and into its
outer wrapper. This preserves failed-vCPU cleanup before its memory can be
freed, without the special conditional in the common destructor. The region
destructor no longer needs to scan the vCPUs.

Suggested-by: Marc Zyngier <maz@kernel.org>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-init.c    | 46 +++++++++++-------------------
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 16 ++---------
 arch/arm64/kvm/vgic/vgic.h         |  1 +
 3 files changed, 21 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 0a3df6d3a691..a0d72b540331 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -523,29 +523,6 @@ static void __kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)
 	INIT_LIST_HEAD(&vgic_cpu->ap_list_head);
 	kfree(vgic_cpu->private_irqs);
 	vgic_cpu->private_irqs = NULL;
-
-	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
-		/*
-		 * If this vCPU is being destroyed because of a failed creation
-		 * then unregister the redistributor to avoid leaving behind a
-		 * dangling pointer to the vCPU struct.
-		 *
-		 * vCPUs that have been successfully created (i.e. added to
-		 * kvm->vcpu_array) get unregistered in kvm_vgic_destroy(), as
-		 * this function gets called while holding kvm->arch.config_lock
-		 * in the VM teardown path and would otherwise introduce a lock
-		 * inversion w.r.t. kvm->srcu.
-		 *
-		 * vCPUs that failed creation are torn down outside of the
-		 * kvm->arch.config_lock and do not get unregistered in
-		 * kvm_vgic_destroy(), meaning it is both safe and necessary to
-		 * do so here.
-		 */
-		if (kvm_get_vcpu_by_id(vcpu->kvm, vcpu->vcpu_id) != vcpu)
-			vgic_unregister_redist_iodev(vcpu);
-
-		vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
-	}
 }
 
 void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)
@@ -553,7 +530,16 @@ void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)
 	struct kvm *kvm = vcpu->kvm;
 
 	mutex_lock(&kvm->slots_lock);
+	if (kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
+		vgic_unregister_redist_iodev(vcpu);
+
 	__kvm_vgic_vcpu_destroy(vcpu);
+
+	if (kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
+		mutex_lock(&kvm->arch.config_lock);
+		__vgic_unassign_redist_iodev(vcpu);
+		mutex_unlock(&kvm->arch.config_lock);
+	}
 	mutex_unlock(&kvm->slots_lock);
 }
 
@@ -563,21 +549,23 @@ void kvm_vgic_destroy(struct kvm *kvm)
 	unsigned long i;
 
 	mutex_lock(&kvm->slots_lock);
+	if (kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
+		kvm_for_each_vcpu(i, vcpu, kvm)
+			vgic_unregister_redist_iodev(vcpu);
+
 	mutex_lock(&kvm->arch.config_lock);
 
 	vgic_debug_destroy(kvm);
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(i, vcpu, kvm) {
 		__kvm_vgic_vcpu_destroy(vcpu);
+		if (kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
+			__vgic_unassign_redist_iodev(vcpu);
+	}
 
 	kvm_vgic_dist_destroy(kvm);
 
 	mutex_unlock(&kvm->arch.config_lock);
-
-	if (kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
-		kvm_for_each_vcpu(i, vcpu, kvm)
-			vgic_unregister_redist_iodev(vcpu);
-
 	mutex_unlock(&kvm->slots_lock);
 }
 
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 6c009deb11d4..dc860178105d 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -775,8 +775,7 @@ static void vgic_undo_redist_assignment(struct kvm_vcpu *vcpu)
 	guard(mutex)(&vcpu->kvm->arch.config_lock);
 
 	vgic_cpu->rdreg->free_index--;
-	vgic_cpu->rdreg = NULL;
-	vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+	__vgic_unassign_redist_iodev(vcpu);
 }
 
 /**
@@ -855,7 +854,7 @@ void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
 	kvm_io_bus_unregister_dev(vcpu->kvm, KVM_MMIO_BUS, &rd_dev->dev);
 }
 
-static void vgic_reset_redist_iodev(struct kvm_vcpu *vcpu)
+void __vgic_unassign_redist_iodev(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 
@@ -881,7 +880,7 @@ static void vgic_v3_rollback_redist_region(struct kvm *kvm, u32 index)
 	guard(mutex)(&kvm->arch.config_lock);
 
 	kvm_for_each_vcpu(c, vcpu, kvm)
-		vgic_reset_redist_iodev(vcpu);
+		__vgic_unassign_redist_iodev(vcpu);
 
 	list_for_each_entry(iter, &kvm->arch.vgic.rd_regions, list)
 		iter->free_index = 0;
@@ -991,17 +990,8 @@ static int vgic_v3_alloc_redist_region(struct kvm *kvm, uint32_t index,
 
 void vgic_v3_free_redist_region(struct kvm *kvm, struct vgic_redist_region *rdreg)
 {
-	struct kvm_vcpu *vcpu;
-	unsigned long c;
-
 	lockdep_assert_held(&kvm->arch.config_lock);
 
-	/* Garbage collect the region */
-	kvm_for_each_vcpu(c, vcpu, kvm) {
-		if (vcpu->arch.vgic_cpu.rdreg == rdreg)
-			vcpu->arch.vgic_cpu.rdreg = NULL;
-	}
-
 	list_del(&rdreg->list);
 	kfree(rdreg);
 }
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index b71d486ae514..1a2e40004a47 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -350,6 +350,7 @@ int vgic_v3_save_pending_tables(struct kvm *kvm);
 int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count);
 int vgic_register_redist_iodev(struct kvm_vcpu *vcpu);
 void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu);
+void __vgic_unassign_redist_iodev(struct kvm_vcpu *vcpu);
 bool vgic_v3_check_base(struct kvm *kvm);
 
 void vgic_v3_load(struct kvm_vcpu *vcpu);
-- 
2.39.5 (Apple Git-154)

