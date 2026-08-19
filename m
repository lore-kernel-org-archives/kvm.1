Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0A3E16A8
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787179384; cv=none; b=s4O4vmlzfxs2WLJr1o2GQfGDLqV5cL4aYb6WTmB32mLVx1IaoV8s+7taQUTHuZKtRyU82fJAVgEykskg1E7DgHHRkGtUSCOIpAV/fNZNx01YqdblWGFuFJJ57HSO68+cTLFcavg/FAeN/ABg9rW/Y3/iABxz3/3pgrPG++8Dug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787179384; c=relaxed/simple;
	bh=QtGuQD6Y9WhA9fpXpeTIYaXrx/WTjnsW3HXx6vlkPTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EIyhsvCSNVqZn1UrTVBAQt9vcsJZasQ8bvDFj8JN65KKnJiefrfMPR01sRgsC/NNAdt5A5HoiBvaeKEuaa7dtdUGvZ0hNKI3hV+OQpMm75nDUaDvr+tHB4+4yhrOeCN1s1surFOaY6pingzh+MMrFeGjveuyol1aj67H0Z3C+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Am3jUH3Q; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am3jUH3Q"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-472326ca506so1045427f8f.2
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787179380; x=1787784180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=spw3TDdOtLdIsF7CwDxVZdY48WpWL2JF0u4UNC1DfkY=;
        b=Am3jUH3Q7uX+XXOvvOpJzN6Ns7bzhlhjo7G0CR4+5JhsgXdIdkrBQonQEwO5UAzHGX
         5GO91JIC8KmHVPTOaK3dJscLj3UlAo/HFuUpr0qSxjGwfJvNwic0FbTc63JsCRozLri+
         TamJiPy3qkH7UaWNdkO8fXzwfyrBT3Y7eX2C2Lvp0csvN8utyDgjeNEh5iFdE3+18T7J
         V5w6A3/HiXUgEWkDzkU2VjJx3MmhvdVI7wzCs/usNXeGinZmcOujhMUn3XlFC7n/cvxl
         sO3JbGUnJLJpo+bsg0IFLsxNhNh0MPfkn8SL7q0obM/K3jTyQXfBkVl5RKxhZEjkVaB9
         K1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787179380; x=1787784180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=spw3TDdOtLdIsF7CwDxVZdY48WpWL2JF0u4UNC1DfkY=;
        b=VircYiOONVER3X9/XZzn3647N0KPRDtAcdgXBqZX45OtXRvS8eLfMBhnm7Cxe7Onod
         eTJ3zmsn/JsI3lUzX8y44kR3Y/eKPwiYmYhGoucoKkuVOfDz6T7RYbN2Zamex5uBb2Vt
         oOGqTmn/J+CPZKFTVBJg6cfjo3pJsfUzIRxRLA0jqg++jDt0kRWkDyjJh+xyA51qvfV9
         YYv+Sa8Ax5NpfURaMBMFYeuIaojay0Y+yYfRPlmgpCov/6FRa79IXM/2SHFT827Yz/99
         OyOHbB2ZYtVRGcjL6AO7HPDsq6hhtPjWXUwU3tB5uAyG8lzijVZSOdF4NOH7hRQ7pI8Z
         mswQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZMMqf8ctLLr3kT3Pjsm+4czpl2G+1YUEgj0Y+RFWQDBzDEqGGUr+A+3Nx+CaDuIURfps=@vger.kernel.org
X-Gm-Message-State: AFuF++n/bin6RwBpeDJwX82cwLiTpdTzmYUsT3r/yptvdG70PIAPsRnF
	PEirIM2O0LVNNcxHMGMGYsrcjMF3p0N/0NpQQfBZxESXiwSn48hKnkq5
X-Gm-Gg: AR+sD11Ws5UWqaIosAqyAeN7pXRTGVpDqHNaCFP6dNDrwu6+mdOwGUAxtu5PQNLGAeA
	oMjXEP/wprYJ8IYvPQQAV+ejzMrmLWyuxz3OepaG+Y9pI1rMtfjCPwwPHqAguoAMUrP/bVapD4q
	N7hmiKlw9bcjBfD8SBjlW6+liMy1mLGakNcDt446cUpZ2Jzn0t2zqXejvqz0GAm/RXiQG5txprs
	suHceFPgilJCC/i1fDZtORpytHw4v85OM959Stul183VpjzCnvYHe66SxW0xl6tvO2g21qoqHvM
	njkSFvOlVIUyK8kLr1kFieKGQ4OhjMvigyhTM9PgIy4w2tfD/s97A/WEzivPHdXrL0d0xZ1/iEo
	80RbDvGn9Akpd+e6OXVZ/y3ArbH2NOnkK9FKySgOTaU3sAjlNHDxl1Ag8tTKBiozdz5F2EJRnV7
	86i/dpZ3ikS5j0w0AllvVsb3bwsz4J6qLVpcVO0GhWXYZGMXUL74dKjs0rJLrzFD5ZGpSJw8agi
	zrjv/uzucOzEDkiNDpZ7Ijy7lOYWAbhKqDuXOTUAwXBOxAU5Kh531PAKG20A1hXUGW5DNA7dZfP
	aym11nLAtW2L4wBq9mMoXh+J8y9bzsz2YNL65y1EWJryJjcFxLruA7dy5k1VpNpnoSE=
X-Received: by 2002:a05:6000:27cc:20b0:482:bb55:8bdc with SMTP id ffacd0b85a97d-482bb558d7fmr23879f8f.1.1787179380523;
        Wed, 19 Aug 2026 15:43:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae9e-1d01-58d3-443d-4fa6-01cd.310.pool.telefonica.de. [2a02:3100:ae9e:1d01:58d3:443d:4fa6:1cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1450e61sm8553317f8f.13.2026.08.19.15.42.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 15:43:00 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <tabba@google.com>,
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
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
Date: Thu, 20 Aug 2026 00:42:25 +0200
Message-Id: <20260819224229.82948-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260819224229.82948-1-kmehltretter@gmail.com>
References: <20260819224229.82948-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vgic_register_redist_iodev() assigns a redistributor region and base
address to the vCPU before adding its iodev to the MMIO bus. However, the
region's free_index is advanced only after registration succeeds.

If kvm_io_bus_register_dev() fails, the vCPU retains the assignment while
free_index still identifies the same slot as free. A later registration can
therefore reuse a slot that remains assigned to the vCPU.

Advance free_index when assigning the slot. On registration failure, return
the slot and clear rdreg and base_addr.

Fixes: dbd9733ab674 ("KVM: arm/arm64: Replace the single rdist region by a list")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 5913a20d8301..c75caadbd1d3 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -766,6 +766,18 @@ unsigned int vgic_v3_init_dist_iodev(struct vgic_io_device *dev)
 	return SZ_64K;
 }
 
+static void vgic_unassign_redist_iodev(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+
+	guard(mutex)(&vcpu->kvm->arch.config_lock);
+	if (vgic_cpu->rdreg) {
+		vgic_cpu->rdreg->free_index--;
+		vgic_cpu->rdreg = NULL;
+	}
+	vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+}
+
 /**
  * vgic_register_redist_iodev - register a single redist iodev
  * @vcpu:    The VCPU to which the redistributor belongs
@@ -818,16 +830,17 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	rd_dev->nr_regions = ARRAY_SIZE(vgic_v3_rd_registers);
 	rd_dev->redist_vcpu = vcpu;
 
+	/* Protected by slots_lock */
+	rdreg->free_index++;
+
 	mutex_unlock(&kvm->arch.config_lock);
 
 	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, rd_base,
 				      2 * SZ_64K, &rd_dev->dev);
 	if (ret)
-		return ret;
+		vgic_unassign_redist_iodev(vcpu);
 
-	/* Protected by slots_lock */
-	rdreg->free_index++;
-	return 0;
+	return ret;
 
 out_unlock:
 	mutex_unlock(&kvm->arch.config_lock);
-- 
2.39.5 (Apple Git-154)
