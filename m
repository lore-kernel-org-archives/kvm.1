Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73E1C5D72;
	Mon, 18 May 2026 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097573; cv=none; b=O8S7+EWL1tWpdObBlxDsC5HAdf5vNQa1iXn9GVwYDYwS0HeriQTJCLTR5PdYb5xcAlhWYwvEzTIKYFYM4P854NY8/pC2yGcRP95g/tKS2ZdmIWZ2kq3sj2ZTvPZrDumoHxiUMsD07QdXv1GoH2YC4H/Xvp+5BS6hh0trOFRK5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097573; c=relaxed/simple;
	bh=H/glQs9nUrdf/JB9IH8cZDjZT2MMIBPBpwUT5XuF3LE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dS5SIwRvdind8kq+1LVZKSkPA5WLMv9z2gCxDCqlUry5shgtse4LAweD3kka5XFANirDtEDA5CDWB9alt9WvPFOmvfLfuRGFwI+jXjljY5aG5H8gIoSKI7LCUwgrZfwUpSl2RJghwEEkIlpishyoHv/VcbkXPJKhUGGSEIIM8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bNTi4op6; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bNTi4op6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pa
	Wfd0J41Qw2Gu0sg/c21JfGyqYleKbjw8wcayIPOl4=; b=bNTi4op69ZehPHteoO
	ebj4bYb21FvjK+cv7EkaKhBVENGHy9vBVD7nUlDUeSjGHUhkhedzntzwFnW7Q8eU
	C8cxDZeriw+/vvPDwqwFFBqMaJFprzA0zGZ0EU/ZdM8MmZ4/ilpYHPtM3yUv9CNu
	RRHzWem/1eNcJjOL06mMwNkso=
Received: from zengchi (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnew683wpqmVyCFA--.31878S2;
	Mon, 18 May 2026 17:45:33 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zengchi@kylinos.cn
Subject: [PATCH] LoongArch: KVM: Add missing slots_lock for EIOINTC virtual extension device registration
Date: Mon, 18 May 2026 17:45:21 +0800
Message-Id: <20260518094521.138692-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCnew683wpqmVyCFA--.31878S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFy7Cw43tr18uw4kCw1UGFg_yoWDWrX_Cr
	yS93s3GrWrJa45W3Wqyw1Fkr109a95KFWrAryfuF1kCwnxZrsxZw47Wry5Zwn29rWxurs8
	XrW0y34akF129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8hqXPUUUUU==
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbCwB1EAGoK370HjwAA3T

From: Zeng Chi <zengchi@kylinos.cn>

The second kvm_io_bus_register_dev() call for device_vext was missing
kvm->slots_lock protection. Add it to match the first registration.

Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
 arch/loongarch/kvm/intc/eiointc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index 2ab7fafa86d5..ce64ffb706df 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -645,8 +645,10 @@ static int kvm_eiointc_create(struct kvm_device *dev, u32 type)
 
 	device = &s->device_vext;
 	kvm_iodevice_init(device, &kvm_eiointc_virt_ops);
+	mutex_lock(&kvm->slots_lock);
 	ret = kvm_io_bus_register_dev(kvm, KVM_IOCSR_BUS,
 			EIOINTC_VIRT_BASE, EIOINTC_VIRT_SIZE, device);
+	mutex_unlock(&kvm->slots_lock);
 	if (ret < 0) {
 		kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &s->device);
 		kfree(s);
-- 
2.25.1

