Received: from mta1.migadu.com (out-233.mta1.migadu.com [95.215.58.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87BC5111BA
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677734; cv=none; b=Pa2BCsLZcA2/Qlrs1VDv8t72bTPwXdQaTl0ya4tAZoBptcDB+eiG5P/m9y1jWCEwjQFQfsDeR1U08s8HdlEEA5xWoLW8Jt8P5DY/W63E4eMrLtnrJKqL3XNOzXk3J9rgG3oeCgPH5gTTyZED63ATVgJDQHw8iYop8WHcBUL0aS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677734; c=relaxed/simple;
	bh=co6B8L2QZeZ5y/7DLgZfORcWFy9PBWFmGWSRoJadijY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gh1TIT4oVIg+yRaUuJB/ZBrOTGUXTwAvsXlGoMhqhieRtsXweLfosWpxWnjYpfDi5dk/lH5aGjj6KEzcRlmEZF9Q2r10kC+7kqHD9abtTZ3nedeHrL78OEZVRNU9K0sGPxAHqQ/JojXYQGbU17ny9pFURcDw+19PU0VQxbtoMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=scFbImNt; arc=none smtp.client-ip=95.215.58.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="scFbImNt"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=co6B8L2QZeZ5y/7DLgZfORcWFy9PBWFmGWSRoJadijY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790677719; v=1; x=1791282519;
 b=scFbImNtxUhmFIkFUCz/CucG5gH3Vz22pYPdH5csIrChPkvkIxRmjsEMC7HA+6S/ZAd/pLCf
 Hk8Z3dsjIh2O4T932ZoC1pdVBg7z8CLeLX1Fb4slpvWaIFgTUaB/4zyehsQbe9MkcenM3V/EbiE
 zOQluo72DAqnTbnK2BGxrfMM=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4f8663cc1e8a7efc;
	Tue, 29 Sep 2026 10:28:39 +0000
X-Mizu-Trace-ID: 4f8663cc1e8a7efc
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: maobibo@loongson.cn,
	gaosong@loongson.cn,
	zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	nagachaithanya9911@gmail.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 1/4] LoongArch: KVM: Clear device pointer in irqchip destroy callbacks
Date: Tue, 29 Sep 2026 18:28:18 +0800
Message-ID: <20260929102821.36112-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929102821.36112-1-cui.tao@linux.dev>
References: <20260929102821.36112-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The destroy callbacks of the four irqchip devices free the device
structure without clearing kvm->arch.{ipi,eiointc,pch_pic,dmsintc},
leaving a dangling pointer.  ops->destroy() is not only called at VM
teardown but also when KVM_CREATE_DEVICE succeeds and the following
anon_inode_getfd() fails (e.g. under RLIMIT_NOFILE); the VM stays
alive, kvm_arch_irqchip_in_kernel() still reports true, and interrupt
injection dereferences the freed device.

Clear the pointer when destroying.

Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")
Fixes: 2e8b9df82631 ("LoongArch: KVM: Add EIOINTC device support")
Fixes: e785dfacf7e7 ("LoongArch: KVM: Add PCHPIC device support")
Fixes: 229132c309d6 ("LoongArch: KVM: Add DMSINTC device support")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/kvm/intc/dmsintc.c | 1 +
 arch/loongarch/kvm/intc/eiointc.c | 1 +
 arch/loongarch/kvm/intc/ipi.c     | 1 +
 arch/loongarch/kvm/intc/pch_pic.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
index 89f980d867be..41c8b597b5bd 100644
--- a/arch/loongarch/kvm/intc/dmsintc.c
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -166,6 +166,7 @@ static void kvm_dmsintc_destroy(struct kvm_device *dev)
 		return;
 
 	kfree(dev->kvm->arch.dmsintc);
+	dev->kvm->arch.dmsintc = NULL;
 	kfree(dev);
 }
 
diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index 80f78e07c74a..fe0a1918f26f 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -675,6 +675,7 @@ static void kvm_eiointc_destroy(struct kvm_device *dev)
 
 	kvm = dev->kvm;
 	eiointc = kvm->arch.eiointc;
+	kvm->arch.eiointc = NULL;
 	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device);
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device_vext);
diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
index 7b333a4a0430..6ee90c10827a 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -444,6 +444,7 @@ static void kvm_ipi_destroy(struct kvm_device *dev)
 
 	kvm = dev->kvm;
 	ipi = kvm->arch.ipi;
+	kvm->arch.ipi = NULL;
 	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &ipi->device);
 	mutex_unlock(&kvm->slots_lock);
diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index 2b63b0c2c7ce..62c09b5f3937 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -483,6 +483,7 @@ static void kvm_pch_pic_destroy(struct kvm_device *dev)
 
 	kvm = dev->kvm;
 	s = kvm->arch.pch_pic;
+	kvm->arch.pch_pic = NULL;
 	/* unregister pch pic device and free it's memory */
 	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &s->device);
-- 
2.43.0

