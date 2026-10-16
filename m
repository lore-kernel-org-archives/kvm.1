Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659FB46E01C
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144333; cv=none; b=BICpXavPv7Kt0b8Qvzdp+GWAvKvXjowXxQN2qsgDa4dVm8ZhbySDi8lZ2gV9QBY3YeKgvUsYlVEGgrifxldudiTqpH5QKL/cysfgtDOvVS4CywXg+C3ZKqUywya6CxlIFf7i+gLMBZL+DoszAO2AxCFZSljsYm7DXr6AJonlgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144333; c=relaxed/simple;
	bh=Rf3CMQb2KEte/BbSHsUqY7LbOQ7Ver+Ulr3VtzWdFMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ss88TAv3oB+NIoPHucDOamRDOE2Ef9eP17off+fow2Be8cI4pc++EjplZGVKqdG6EhbzGJDB63FhEnA3RaKp+bedR41dR1tBtoPLlEHTohuGh3HdAXADliqloMuzqsNpLUySTRkqVfNRJwchA3/liFO8KG+jGaLPsr6E+wyA1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h/CTNynt; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h/CTNynt"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Rf3CMQb2KEte/BbSHsUqY7LbOQ7Ver+Ulr3VtzWdFMk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792144328; v=1; x=1792749128;
 b=h/CTNyntiCIZ/no26sMKMbii8PE6hEkgrCicX93LyEbMZfwsnGMLYYQk3NbXEkJ/IGhComn6
 EXV8E3eUfKOfzsCbfTMo88y6+Pnrb3om4XdDlopsC4aqwrq9lQoOXtaIb6xhocbyL10ugn4dlH1
 Znl1Pj/CxTfVYjZYrkoupzug=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 374f79ebbe3a2c0d;
	Fri, 16 Oct 2026 09:52:08 +0000
X-Mizu-Trace-ID: 374f79ebbe3a2c0d
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
Subject: [PATCH v5 3/3] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
Date: Fri, 16 Oct 2026 17:51:51 +0800
Message-ID: <20261016095151.1155049-4-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016095151.1155049-1-cui.tao@linux.dev>
References: <20261016095151.1155049-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT has no guard against repeated
invocation: every call overwrites pch_pic_base and registers the same
kvm_io_device on the MMIO bus at the new address, while
kvm_pch_pic_destroy() unregisters only one bus range.  After a repeated
init, MMIO to the stale ranges computes its register offset against the
new base and silently reads 0 / drops writes, and the leftover bus
entries persist until the VM is destroyed.

Reject repeated initialization with -EEXIST, using the initialized
state of the kvm_io_device as the indicator.  The check, the MMIO base
update and the bus registration are serialized by slots_lock, and the
real registration error is propagated instead of being replaced with
-EFAULT.  On a registration failure the base and the device state are
rolled back so that a retry can start over.

Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and write functions")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/intc/pch_pic.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index 51e4a6a39dc0..ee06bdfd6547 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -281,16 +281,26 @@ static int kvm_pch_pic_init(struct kvm_device *dev, u64 addr)
 	struct kvm_io_device *device;
 	struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
 
-	s->pch_pic_base = addr;
 	device = &s->device;
+	mutex_lock(&kvm->slots_lock);
+	if (s->device.ops) {
+		ret = -EEXIST;
+		goto out;
+	}
+	s->pch_pic_base = addr;
 	/* init device by pch pic writing and reading ops */
 	kvm_iodevice_init(device, &kvm_pch_pic_ops);
-	mutex_lock(&kvm->slots_lock);
 	/* register pch pic device */
 	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_SIZE, device);
+	if (ret) {
+		/* undo the state so that a retry can start over */
+		s->pch_pic_base = 0;
+		s->device.ops = NULL;
+	}
+out:
 	mutex_unlock(&kvm->slots_lock);
 
-	return (ret < 0) ? -EFAULT : 0;
+	return ret;
 }
 
 /* used by user space to get or set pch pic registers */
-- 
2.43.0

