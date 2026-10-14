Received: from mta0.migadu.com (out-28.mta0.migadu.com [91.218.175.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80E3BB9FD
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791955802; cv=none; b=s62ZiUCb/CHfnEJAE/KmxwWfYC9QjU6Xukx9YpuS8xTq/KqZFL6uEmG896ViKhF0Z7tiqd//nl9GGyJ2aXXH0INYf1oC01ywVCHpPaF492K+l7f8ua/JCJYPBPFwDTuVcrPlG7bp4Fwf5tj5k53Ls1QvU0eXbzmvULwShVhW4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791955802; c=relaxed/simple;
	bh=JKfFc8KtfybnDLmrB7rjPkLnCMRQmtiOhDNQkr5M6aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaPsnTw+9tL0e44so2kF/8PJhNYDzvkRjBNalBvyQ+lyEI3/rV8iy50O5a+xfHruoClcc9aQQ3N9/3FKykwRGDYlEthggvDWdVPAkZ8p7HYxWg4gOPRiPvF51Fc72fEJG9fZGWOhBqYLEffthRsj+6rnGrM23l5vohTg5/IeG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WBD1ikpe; arc=none smtp.client-ip=91.218.175.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WBD1ikpe"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JKfFc8KtfybnDLmrB7rjPkLnCMRQmtiOhDNQkr5M6aA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791955798; v=1; x=1792560598;
 b=WBD1ikpev4jRJ9kTKqS4emLs0njJeFoWpoXjjhbi96ZNCZmlC5G1H/YNF7dmML2ep1F3zVjw
 QKLwUdSK4QmZchR95jd8IiDYA6gb31/8CVRP6H1+GjfUF7ITA601rekM5vH41YlrPi7AbMk9XWm
 sj/d2zn5wfDcHvB99zMcr8DI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bebb5b74179fdd7f;
	Wed, 14 Oct 2026 05:29:58 +0000
X-Mizu-Trace-ID: bebb5b74179fdd7f
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: chenhuacai@kernel.org,
	maobibo@loongson.cn,
	gaosong@loongson.cn,
	zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@xen0n.name,
	nagachaithanya9911@gmail.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v3 1/3] LoongArch: KVM: Clear device pointer in irqchip destroy callbacks
Date: Wed, 14 Oct 2026 13:29:31 +0800
Message-ID: <20261014052933.723303-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014052933.723303-1-cui.tao@linux.dev>
References: <20261014052933.723303-1-cui.tao@linux.dev>
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
index ff327b4c05f7..c182185a3d59 100644
--- a/arch/loongarch/kvm/intc/dmsintc.c
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -146,6 +146,7 @@ static void kvm_dmsintc_destroy(struct kvm_device *dev)
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
index 80faa770c0cd..7a2dd72a4952 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -441,6 +441,7 @@ static void kvm_ipi_destroy(struct kvm_device *dev)
 
 	kvm = dev->kvm;
 	ipi = kvm->arch.ipi;
+	kvm->arch.ipi = NULL;
 	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &ipi->device);
 	mutex_unlock(&kvm->slots_lock);
diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index 220fc23ffe8c..dab2d3f1b8f6 100644
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

