Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BF741C71;
	Mon, 25 May 2026 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701247; cv=none; b=ALUGIhBLFPiU/2RQwoUvdjg9iUHtFbJGlFdwyWT1P5UmSXmuBZWgyBSpyczDs3A7LEpHDzfn5o483rulH6keGepS+JaiJwlk5w5DxV3lJKej7oxCv3UodGWN76a8mZ2i+5iN8x4X7mtHJ7jiJccNese/PV2++rg0DlPc5xX4xKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701247; c=relaxed/simple;
	bh=Brco6F+0yxSD40Yh34rfv/nCr44+pf8MJU5P5SG8sVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=efCMvLRHAhVqf99peOxEu01OPUADmuAXH3xD8/3WwGTh7ab4qMCjxOYV0VXrydIyX0K+mX7dFKahouP8H86M6Wz0ynhaHtZR339SqRhx6opxo+FR58kY7vEWSwluo6SjQz2OVPXRNMkX5uvzjyYqfsF+sCJOM9J1xMPXMsKwtkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bVyB9Ry5; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bVyB9Ry5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=79
	UOIxTKuxkuPjv6yilFv/UdojyXDWRUaVVq4a2P1nM=; b=bVyB9Ry5KwssU3S5Lb
	s1Jyxf0S6BXkVegpAtCcQgvgTYqwxnpwg9fzEBfu8ncAcV+qGNirwFIU/p5F93Mj
	tQwJjhXyEfi9/77IfkTw7bGAg9kYoEFu+3Ky5E6hFt3P64PxXy8zEmf+B3FomqI0
	37Ub8ie2kndVhVrhJ1x+D1i3o=
Received: from zengchi (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBnVRTNFRRqFKVnDQ--.13761S2;
	Mon, 25 May 2026 17:26:39 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	kees@kernel.org,
	siyanteng@cqsoftware.com.cm,
	maqianga@uniontech.com,
	gaosong@loongson.cn,
	yury.norov@gmail.com
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zengchi@kylinos.cn
Subject: [PATCH v2 net] LoongArch: KVM: Add missing slots_lock for IO bus device register/unregister
Date: Mon, 25 May 2026 17:26:33 +0800
Message-Id: <20260525092633.1706633-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260518094521.138692-1-zeng_chi911@163.com>
References: <20260518094521.138692-1-zeng_chi911@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnVRTNFRRqFKVnDQ--.13761S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFWfuF13Zr4kXry5Gr1DGFg_yoW5XFy7pF
	45uayqkr4rWrnrXrZFvr1DXF4Uuan2gw1furyUCFW7GF4jqFyFqF1kAFyUWFyjkayruFW0
	qF15Jw1Yva1UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6q2_UUUUU=
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbC6A8Y02oUFc8aEAAA3C

From: Zeng Chi <zengchi@kylinos.cn>

kvm_io_bus_register_dev() and kvm_io_bus_unregister_dev() should be
called under kvm->slots_lock. The unregister calls in ipi.c, pch_pic.c
and eiointc.c were missing this protection. Add it to match the
register side.

Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
 arch/loongarch/kvm/intc/eiointc.c | 6 ++++++
 arch/loongarch/kvm/intc/ipi.c     | 2 ++
 arch/loongarch/kvm/intc/pch_pic.c | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index 2ab7fafa86d5..2b14485d14a7 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -645,10 +645,14 @@ static int kvm_eiointc_create(struct kvm_device *dev, u32 type)
 
 	device = &s->device_vext;
 	kvm_iodevice_init(device, &kvm_eiointc_virt_ops);
+	mutex_lock(&kvm->slots_lock);
 	ret = kvm_io_bus_register_dev(kvm, KVM_IOCSR_BUS,
 			EIOINTC_VIRT_BASE, EIOINTC_VIRT_SIZE, device);
+	mutex_unlock(&kvm->slots_lock);
 	if (ret < 0) {
+		mutex_lock(&kvm->slots_lock);
 		kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &s->device);
+		mutex_unlock(&kvm->slots_lock);
 		kfree(s);
 		return ret;
 	}
@@ -667,8 +671,10 @@ static void kvm_eiointc_destroy(struct kvm_device *dev)
 
 	kvm = dev->kvm;
 	eiointc = kvm->arch.eiointc;
+	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device);
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device_vext);
+	mutex_unlock(&kvm->slots_lock);
 	kfree(eiointc);
 	kfree(dev);
 }
diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
index 1f6ebbd0af5c..4fa0897d7bdb 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -447,7 +447,9 @@ static void kvm_ipi_destroy(struct kvm_device *dev)
 
 	kvm = dev->kvm;
 	ipi = kvm->arch.ipi;
+	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &ipi->device);
+	mutex_unlock(&kvm->slots_lock);
 	kfree(ipi);
 	kfree(dev);
 }
diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index aa0ed59ae8cf..175a630aceb4 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -481,7 +481,9 @@ static void kvm_pch_pic_destroy(struct kvm_device *dev)
 	kvm = dev->kvm;
 	s = kvm->arch.pch_pic;
 	/* unregister pch pic device and free it's memory */
+	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &s->device);
+	mutex_unlock(&kvm->slots_lock);
 	kfree(s);
 	kfree(dev);
 }
-- 
2.25.1

