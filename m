Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750073C416B
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163824; cv=none; b=DEn4V3DghLPe4QsAN2M0d+O5MPjHnlQjImpl2pJF7OGtx9YMaSfGt5jKLL6DxcvMfgaKsT6JveOtsjz7h0gag/YeLg8wC9l9uOaOSvcVaR8Xl3D1y0C3YccBB3M+EJxonimdwJX3ceJMsXtIx9BYDlKO7yXTxjW2p99TM3bQkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163824; c=relaxed/simple;
	bh=r/bufVq0OkVZwEdQ//AHO/OTUOmVemWl8G+OQpZ2wJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHR4Y+OYFCUxNvbrXAfWNCCvh54Ua3oohL+tos7dSl6IxyEbGVIlLmihoJKA48YoUCV45yec7T11ft/iDjHw36chRPAyp+KuI6fc40rvPdTQBFrwHP/SklKE45MqNPTQXGO+dCGVrbX18+qVvKQ3NWGLgMnAAVDGZ9PbSBTbW34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa1FPmK+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa1FPmK+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so21157925e9.1
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 01:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788163821; x=1788768621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mg0FhLj+v96vUWe+LyIXKQir5MTYCv01Q4cNbefOBGw=;
        b=Oa1FPmK+llG2ZjaXwPvqJ403Aks7qoUpHSGmpXCa/9SUl+lU6W5FLrxK5+cUpdMw1N
         7WBH+sDUtnN09CiqCZGvHJRiktyLn7FwWEbpUA234w8m0OFA6eVCQ11ss1gIhM7PJEwD
         qZZ4pa3ivIs0sxLIP4EiGEDDf39ElWG5b2JpnrUV8BIWkv0sjRPLB/C7sOQJRybJk19g
         HAzdm7yuYwx0VXGeffIIrKCtxA8qWMqiX3Od0J0zKjR2fbe8lux4qjkHMaiHzvTzGAIb
         ZE6uF3gTnhOnFbXCQw/7CGl/lVL+NhOGNmDuwF20haJ6dV12Ihc+4QFaaxeihcCfR5Be
         Gj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788163821; x=1788768621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mg0FhLj+v96vUWe+LyIXKQir5MTYCv01Q4cNbefOBGw=;
        b=Vqe8Vd4iUf21W2sZ22A9tXYJCeoSEQddC5hTCKEZZjueRAebc8xOoKmYlAF92VZfJ6
         q/wXuW9I7mLMRgj7puW3JE5/1aBGifmADbIXe+rYiWbyUwaCBH+LOEA1HcW9uBvnzOgT
         02l3c2vBjwr5TnhV91fV77/JGqyJchSemQZoC7NJ/VDGSKPXb9pSWvYdLKBSy0UM0HSN
         3lKW4AOnpAxmtGkHoqMobmdmZu7ElTYujMK2dN2xCaeIqrti1gx8EGXCg/BAndSI27Xh
         dSOk5hRzYwMzR5wnRkdzQpZ/6skdmalppMt5zu6aQZGoCCUODfebgXxV63MlfqNnBCr2
         J60Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqgtup+h5aVjtzOeIYWxYjasnaONfHROS9uUiq0fqlgrYLJFydcavaKLPpjvRQPxO/fwnA=@vger.kernel.org
X-Gm-Message-State: AFuF++mNz9KCe4olFEinp2OvFKGsdsPL2g+Btts6Bi33L5SjNO1p4G5k
	2YV4dHYvRuo+jbDBxcoUyNbLUQdE8XevM+1jAfLogTGUTktqGdw2nmAh
X-Gm-Gg: AR+sD11ESRGykYleyCdsTW8NppFqhaehGo2FqaKzIkbuwK6BHrLA4HA6Qee7Uj/DtFr
	2zGLRwOp94QagqwHpvcvGGaIswWkyF9R6TpbwSYJueViZSZyOlXCginVm+6BFwcEJUXfL6+5Pvq
	poNIAhxTh+mdtl6cGNKFMghkMKofvuVcUblQ2LgjsvuwSAqiX7bNu8d/TwL36gO3I9YSYJ6oSIb
	iWzPnYup+fw6BBTBUZrKKqbZarD2jeZPY26yszNApgYt+eVAIO1fwTDIUVImrOEbQ3wEwfOJ0Y1
	EdJanJ0yHvoSpA2OPc41nTF5lGlpBW3Zo1PhhTrSQ2PSr4ixDeEFZKMjhtkfHa4t414R/75ZDcr
	rK7VMkPqqfPp+nX/bErw82bckuubvQyhO7BOOTK1hwxMBGNQdZrbfcL6XShdlFIECCMAlDt3jwu
	A4f8l8nDt1LWro9WPxspG3VPrTsemq6SUsT6yWwn4kZ0ZZSdhF4UV7Sq3PmbJNH9GgoaQiBoe+P
	9qNV8jYIRNrGYy2lPAnmnWC6aGqcBaYH0oYB5Xa2YnqyU/FCTyfrXWWzopercnngS2lBsXFki3m
	KEdK1YPYRc0btv58TfUuttkNRVAtZWQrd3OWawGDccRvCjmg4d/dpO7wY7g8HrwE+XOndrU=
X-Received: by 2002:a05:600c:4f92:b0:49b:90cc:3c87 with SMTP id 5b1f17b1804b1-49b91c487b2mr367309225e9.13.1788163820227;
        Mon, 31 Aug 2026 01:10:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acb9-0201-68d0-34d2-ad1a-175a.310.pool.telefonica.de. [2a02:3100:acb9:201:68d0:34d2:ad1a:175a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b95013d06sm370393515e9.12.2026.08.31.01.10.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 01:10:19 -0700 (PDT)
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
Subject: [PATCH v4 1/4] KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
Date: Mon, 31 Aug 2026 10:10:01 +0200
Message-Id: <20260831081005.41346-2-kmehltretter@gmail.com>
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

vgic_register_redist_iodev() assigns a redistributor region and base
address to the vCPU before adding its iodev to the MMIO bus. However, the
region's free_index is advanced only after registration succeeds.

If kvm_io_bus_register_dev() fails, the vCPU retains the assignment while
free_index still identifies the same slot as free. A later registration can
therefore reuse a slot that remains assigned to the vCPU.

Reserve the slot before registering its iodev. The caller holds slots_lock,
so a registration failure cannot race with a later assignment. Undo the
reservation and clear the cached assignment on failure.

Fixes: dbd9733ab674 ("KVM: arm/arm64: Replace the single rdist region by a list")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 5913a20d8301..22897ce64dbf 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -766,6 +766,19 @@ unsigned int vgic_v3_init_dist_iodev(struct vgic_io_device *dev)
 	return SZ_64K;
 }
 
+static void vgic_undo_redist_assignment(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+
+	lockdep_assert_held(&vcpu->kvm->slots_lock);
+
+	guard(mutex)(&vcpu->kvm->arch.config_lock);
+
+	vgic_cpu->rdreg->free_index--;
+	vgic_cpu->rdreg = NULL;
+	vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+}
+
 /**
  * vgic_register_redist_iodev - register a single redist iodev
  * @vcpu:    The VCPU to which the redistributor belongs
@@ -818,16 +831,17 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
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
+		vgic_undo_redist_assignment(vcpu);
 
-	/* Protected by slots_lock */
-	rdreg->free_index++;
-	return 0;
+	return ret;
 
 out_unlock:
 	mutex_unlock(&kvm->arch.config_lock);

base-commit: cf72cbb39da84b6f02f90c07f33b102fc10b16f0
-- 
2.39.5 (Apple Git-154)
