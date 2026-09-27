Received: from mta0.migadu.com (out-147.mta0.migadu.com [91.218.175.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2A3CB564
	for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790495591; cv=none; b=ktwpJKd0HLInERlPMHRkzfJSyfo1ol6Ngx4ZiGMDicNZuArzl9V0CuPMroyrqLhrb4ciRPGRaiCwycOqOK8f8PUf0Y4AGihXo22w71zLp3tNuaYzRpVmzgljVTa2LeqFdHF4BEF4aR0dkObB9ALfgE+hiMkQHHrJVyMtgSQuCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790495591; c=relaxed/simple;
	bh=m/X5aoPRXyHsasyxwDbYK+y0ZJ9VoSZaZZKIVhLMmTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhblakrV/WMYdZ5K9tXFC0E4Q4rTjC6RfFgwhdzweiJU5qir0LjxzWBIoRi/zOVWiY3arhR1TXG2WuH9534VmJAt3YJ4N94PsNYo6G9VKNOd1Xi+X5oLIzTdXbi0Lm7EOHWzCJU3UjPkSjqKh7+C5CVTDymOCATrXmPKLA+o0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vywe1/s6; arc=none smtp.client-ip=91.218.175.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vywe1/s6"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=m/X5aoPRXyHsasyxwDbYK+y0ZJ9VoSZaZZKIVhLMmTw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790495583; v=1; x=1791100383;
 b=Vywe1/s672i3zZ9ozFKDxbu5cqMajZrQEdnCzh3PgyfAsgo6MqlLYmn9ZiOoLZA18ExCo+Xk
 P3lPRXia/9KAJieAq346J57fYd4kOm/ww8MyaD5gPwxvu1coNpJnkyhN21oKTVTS/ol/vn1dwgV
 SE6pChfCxhphaM5aIroXNkKc=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5472bcec4e8a13a7;
	Sun, 27 Sep 2026 07:53:03 +0000
X-Mizu-Trace-ID: 5472bcec4e8a13a7
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
Subject: [PATCH 1/6] LoongArch: KVM: Clear device pointer in irqchip destroy callbacks
Date: Sun, 27 Sep 2026 15:52:35 +0800
Message-ID: <20260927075240.3007947-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927075240.3007947-1-cui.tao@linux.dev>
References: <20260927075240.3007947-1-cui.tao@linux.dev>
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

Clear the pointer before freeing.

Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")
Fixes: 2e8b9df82631 ("LoongArch: KVM: Add EIOINTC device support")
Fixes: e785dfacf7e7 ("LoongArch: KVM: Add PCHPIC device support")
Fixes: 229132c309d6 ("LoongArch: KVM: Add DMSINTC device support")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/kvm/intc/dmsintc.c | 5 ++++-
 arch/loongarch/kvm/intc/eiointc.c | 1 +
 arch/loongarch/kvm/intc/ipi.c     | 1 +
 arch/loongarch/kvm/intc/pch_pic.c | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
index 89f980d867be..63072595c01b 100644
--- a/arch/loongarch/kvm/intc/dmsintc.c
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -161,11 +161,14 @@ static int kvm_dmsintc_create(struct kvm_device *dev, u32 type)
 
 static void kvm_dmsintc_destroy(struct kvm_device *dev)
 {
+	struct loongarch_dmsintc *s;
 
 	if (!dev || !dev->kvm || !dev->kvm->arch.dmsintc)
 		return;
 
-	kfree(dev->kvm->arch.dmsintc);
+	s = dev->kvm->arch.dmsintc;
+	dev->kvm->arch.dmsintc = NULL;
+	kfree(s);
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

