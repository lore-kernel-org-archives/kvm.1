Received: from mta1.migadu.com (out-9.mta1.migadu.com [95.215.58.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E793D811C
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677758; cv=none; b=QqYbV1LUfELioa8KRiZTECIpWF4nuLEfiNRf4fwhwxXaba7CTuBzA6R8mE0DNesN+udt1kbaN5yJq0QysZeeTFnvi1SRRP9dDXUgUldwMitXTiBeNZsO14lBbR4plmaxXT707CaZeRM5ZdiANY2PKlGIpDa8GFhVWmTu2yLdL5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677758; c=relaxed/simple;
	bh=i++ALgs4QNdXIzX9B2a2qb3UTaTvW7/iRJONd8BitkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPMDtriutG9C7LR8o0mL1/ZCAAHKfegJATePD/7SsJkWvZ7JXFRYY9Pp3D0/XCnX1UcHuKTSo6d+e6WGOF5j/aDP+5rtWptKpaDpd6zFi098zD0yrTMg6HnQ/r/PZenwSBxMJdr0b/PTu+6JvXGawY/7TWPvaH8c8Fa+Jgc+5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xHmxr1ZU; arc=none smtp.client-ip=95.215.58.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xHmxr1ZU"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=i++ALgs4QNdXIzX9B2a2qb3UTaTvW7/iRJONd8BitkQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790677739; v=1; x=1791282539;
 b=xHmxr1ZU5+5CSDWIWGEpIi0Wu+u7VhpqcNSVBpycH19IiV36vkm+ocDazIn1pOBn9p94/ZlK
 urm6DF3GPwnqCdElpm0qD6/MLwhL7srFAQJd3YreHC1AycopRYmCrV5OKKhMTEgraNFCs/SVATN
 SnXn55BCRzPCgf9b+Skbcr/E=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e6fb5c99a14e3dad;
	Tue, 29 Sep 2026 10:28:59 +0000
X-Mizu-Trace-ID: e6fb5c99a14e3dad
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
Subject: [PATCH v2 4/4] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
Date: Tue, 29 Sep 2026 18:28:21 +0800
Message-ID: <20260929102821.36112-5-cui.tao@linux.dev>
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

KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT has no guard against repeated
invocation: every call overwrites pch_pic_base and registers the same
kvm_io_device on the MMIO bus at the new address, while
kvm_pch_pic_destroy() unregisters only one bus range.  After a repeated
init, MMIO to the stale ranges computes its register offset against the
new base and silently reads 0 / drops writes, and the leftover bus
entries persist until the VM is destroyed.

Reject repeated initialization with -EEXIST, tracking the state with
a has_init flag so the check and the MMIO base update are atomic
under slots_lock.  The base is only committed after a successful bus
registration, and the real registration error is propagated instead
of being replaced with -EFAULT.

Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and write functions")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/include/asm/kvm_pch_pic.h |  1 +
 arch/loongarch/kvm/intc/pch_pic.c        | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch/include/asm/kvm_pch_pic.h
index 887b0431fd20..679132d840e6 100644
--- a/arch/loongarch/include/asm/kvm_pch_pic.h
+++ b/arch/loongarch/include/asm/kvm_pch_pic.h
@@ -53,6 +53,7 @@ struct loongarch_pch_pic {
 	spinlock_t lock;
 	struct kvm *kvm;
 	struct kvm_io_device device;
+	bool has_init;
 	union pch_pic_id id;
 	uint64_t mask; /* 1:disable irq, 0:enable irq */
 	uint64_t htmsi_en; /* 1:msi */
diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index 7a704f18880d..a884a043feef 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -282,16 +282,24 @@ static int kvm_pch_pic_init(struct kvm_device *dev, u64 addr)
 	struct kvm_io_device *device;
 	struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
 
-	s->pch_pic_base = addr;
 	device = &s->device;
 	/* init device by pch pic writing and reading ops */
 	kvm_iodevice_init(device, &kvm_pch_pic_ops);
 	mutex_lock(&kvm->slots_lock);
+	if (s->has_init) {
+		ret = -EEXIST;
+		goto out;
+	}
 	/* register pch pic device */
 	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_SIZE, device);
+	if (!ret) {
+		s->pch_pic_base = addr;
+		s->has_init = true;
+	}
+out:
 	mutex_unlock(&kvm->slots_lock);
 
-	return (ret < 0) ? -EFAULT : 0;
+	return ret;
 }
 
 /* used by user space to get or set pch pic registers */
-- 
2.43.0

