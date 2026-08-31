Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEEF3CC33F
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163826; cv=none; b=DZP05/Fv6/YBqvtcEj7yN+GDRPTWQK6zQ07doiuN926glvN/EokoSYDjDx2bbtfLwc4nLYZSzXF3kiBk80zs7Z5vmpFcFB7Gxy5InVg27ZNXWOCKMBbzq6hbHIR7mAc7amy+jqyXHyaCrgvz0gDTLSAAhsg+k1HSiu+nZaltxSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163826; c=relaxed/simple;
	bh=Aob392KCiPwYOZ26v4z6ameSKdVNEWay1hUTRybnICw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2ZtJYaEmwx7Uja01GnzrwfSSYxki0r1fGIueXQifYpjQHRgUSSdyS1aa1RVUQWpdGtvFMaejh/85UOuTM7oJq1RAcnnrP6lLESeigcF/YB5/5XlaNsetgH0DRuzlM6hfQAAs2GEgweQmkhdNub919gr6P6ormiEsuvh7Z4U7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6YXr0Cc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6YXr0Cc"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so36101675e9.1
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788163822; x=1788768622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQe0/H8SNUjRW9auKFahnt1W5WCW5fFGWugsoqcSd7E=;
        b=a6YXr0CcMuslOhGbOHvGG1AENbfAN3dxqwa3TkpYpBo5n7hRhqUs2JZTcJnrQQa0Jw
         EkBlGwygKVozAStl49+wKrfR9OVVzFD86NTxMOVtM1ELDvyNc+tndJ+W6ak4WoAAbowt
         g78k7jgeXfUyH9Wh8boZt0NyrRZ1WtbMSES0ppouGrz93g/55xSGx8Y0bHrsMigd5SXz
         US47fdUr0DFqw6giI1o/3lchJ4gL0nLAieNgOfLeahlayRxOuCpd1Kf5R+f4sCI3T+8S
         IwgpmxsSajV8QOEQ/wtwtZaQKcLr94Y2O10vPC97VZuW7+AvHtoVGg8vM6AyGWU22W0P
         moyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788163822; x=1788768622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQe0/H8SNUjRW9auKFahnt1W5WCW5fFGWugsoqcSd7E=;
        b=U914ff1CEIsm4Qd6MIO21UdpI4r1EWcCzKevvAkEGPL4WPcwUJLoOj3NvK5GYbheuA
         PAhb+d5LN+vJ5NNmaw8oxdmSxCUpMxQMWourGX77CqOMo3R01Fn3F4fT3VZIbEfeClcR
         plcvV1SSpXR8aqmAlEKIn2LbFADhV9R4rX8IxPtTOjJYSsGTpr9pkDhJsbjTi6pF6Rmh
         byFk1XJXtNMmjoEElDxEI0LMX1oc51SoJKO1BpHAd/kC0KY8bUJCBZKFg/W8xUAbtRys
         512IjN5dZZbyXDUC2gIMkF85zwLo/OY+HWrRzP2Mn5LjtKtbURn/O1QulFyQ+MV5bmos
         RXwA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9JC34gl0Oe9Vzk7i0etLesRfFJu//ixDUhwvQuVGyfBDKzj+SxSk1TqbXQOaB5nrlWZM=@vger.kernel.org
X-Gm-Message-State: AFuF++kiWl9sEISj2sZUqWXVXYPXmRLGfp3J/t1mDGVh7NTk4Ljsaml0
	Lh9Q9ZfKw65s3uj/ibQSPBCRRRNP19ElsNhoVYm0C8uQUU15MCjMM+g6
X-Gm-Gg: AR+sD125K9ENIYYQeRvOrNb7BsKTc5WU1wFrLlaUQ2rClij7b+Q3ArTsRLsemZmb1CR
	IPmjjETjvO9led26II442UtaON/ZSZCkKyRMiZevn/KIeN8AlMSBJ5JYZ+fvMOHumnrWWTGaZ9+
	D1AljizVNLDgbXcqmls20Hp7w0LlhaSU/cfvz6Z00DdKOVlM3jmitBN+tUfDEkpSa8j8WM9Mn/G
	/+VDEQ7ewWO8Ubt9+fv3viQRKjrTN0os/3DaRNwxU+fZxS9Tx1S/GWPnKbyLDKti9evBEm+9pP3
	jdA9tliIi1lNUxLgwL8CGEPovWcd8Qplx/osXunHa74BwqZ8f4q5jtdyycz29Efnr7uGmM53bHD
	HhSbm/e6lhhYILhUxiDA1W2WKEvjZOj6UVWpDxcKakffqeCVOlcPPt3wWwVIHHgWdZGKQosLfyB
	ppukqLPyI2qkWs29sR43j5YCbN/Dw3jc/6hjHZwVs7mXVPrqmevOR8iWvowuJiA/AlzqQqHPV17
	BXtF/7MlEj9mi/g+OYtL0we/Pv+FNC7uSBYSxlJ4DZlNctog5R4EaFUkUkfs8tD8ejbBUDgTcjW
	wrVPX9IMozilpdMkh9zaeMQU3/cfgBQJD5c6+JBLrO69xCUiyI0WgtOGfImWridE7HBvejc=
X-Received: by 2002:a05:600c:c3cf:10b0:49b:8f18:714a with SMTP id 5b1f17b1804b1-49b91c47b76mr281088265e9.12.1788163821808;
        Mon, 31 Aug 2026 01:10:21 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acb9-0201-68d0-34d2-ad1a-175a.310.pool.telefonica.de. [2a02:3100:acb9:201:68d0:34d2:ad1a:175a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b95013d06sm370393515e9.12.2026.08.31.01.10.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 01:10:21 -0700 (PDT)
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
Subject: [PATCH v4 2/4] KVM: arm64: vgic-v3: Roll back assignments from the new region
Date: Mon, 31 Aug 2026 10:10:02 +0200
Message-Id: <20260831081005.41346-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260831081005.41346-1-kmehltretter@gmail.com>
References: <20260831081005.41346-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A failed REDIST_REGION write unregisters the redistributor iodevs of every
vCPU processed before the failure. This includes vCPUs assigned to older
regions. Their assignments remain cached, so a retry does not register the
iodevs again.

The vCPU whose registration fails has no assignment to roll back. For vCPUs
processed earlier, limit rollback to those assigned to the new region. The
region is removed on failure, so its free_index does not need restoring.

Resetting assignments from older regions is unsafe because a vCPU can own
one before kvm_for_each_vcpu() can see it. Rollback could then move
free_index behind that live assignment.

kvm_vgic_addr() holds slots_lock across the REDIST_REGION write. vCPU
creation takes the same lock before assigning a redistributor. A concurrent
vCPU cannot acquire an assignment from the new region before rollback
completes. The lock also keeps rdreg valid across the config_lock drop
required by MMIO-bus registration.

Fixes: c011f4ea106b ("KVM: arm/arm64: Check vcpu redist base before registering an iodev")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 32 +++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 22897ce64dbf..77aa8433701a 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -855,7 +855,25 @@ void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
 	kvm_io_bus_unregister_dev(vcpu->kvm, KVM_MMIO_BUS, &rd_dev->dev);
 }
 
-static int vgic_register_all_redist_iodevs(struct kvm *kvm)
+static void vgic_rollback_redist_iodev(struct kvm_vcpu *vcpu,
+				       struct vgic_redist_region *rdreg)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+
+	lockdep_assert_held(&vcpu->kvm->slots_lock);
+
+	if (vgic_cpu->rdreg != rdreg)
+		return;
+
+	vgic_unregister_redist_iodev(vcpu);
+
+	guard(mutex)(&vcpu->kvm->arch.config_lock);
+	vgic_cpu->rdreg = NULL;
+	vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+}
+
+static int vgic_register_all_redist_iodevs(struct kvm *kvm,
+					   struct vgic_redist_region *rdreg)
 {
 	struct kvm_vcpu *vcpu;
 	unsigned long c;
@@ -870,12 +888,12 @@ static int vgic_register_all_redist_iodevs(struct kvm *kvm)
 	}
 
 	if (ret) {
-		/* The current c failed, so iterate over the previous ones. */
+		/* Undo assignments made from the region being added. */
 		int i;
 
 		for (i = 0; i < c; i++) {
 			vcpu = kvm_get_vcpu(kvm, i);
-			vgic_unregister_redist_iodev(vcpu);
+			vgic_rollback_redist_iodev(vcpu, rdreg);
 		}
 	}
 
@@ -984,10 +1002,13 @@ void vgic_v3_free_redist_region(struct kvm *kvm, struct vgic_redist_region *rdre
 
 int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
 {
+	struct vgic_redist_region *rdreg;
 	int ret;
 
 	mutex_lock(&kvm->arch.config_lock);
 	ret = vgic_v3_alloc_redist_region(kvm, index, addr, count);
+	if (!ret)
+		rdreg = vgic_v3_rdist_region_from_index(kvm, index);
 	mutex_unlock(&kvm->arch.config_lock);
 	if (ret)
 		return ret;
@@ -996,12 +1017,9 @@ int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
 	 * Register iodevs for each existing VCPU.  Adding more VCPUs
 	 * afterwards will register the iodevs when needed.
 	 */
-	ret = vgic_register_all_redist_iodevs(kvm);
+	ret = vgic_register_all_redist_iodevs(kvm, rdreg);
 	if (ret) {
-		struct vgic_redist_region *rdreg;
-
 		mutex_lock(&kvm->arch.config_lock);
-		rdreg = vgic_v3_rdist_region_from_index(kvm, index);
 		vgic_v3_free_redist_region(kvm, rdreg);
 		mutex_unlock(&kvm->arch.config_lock);
 		return ret;
-- 
2.39.5 (Apple Git-154)
