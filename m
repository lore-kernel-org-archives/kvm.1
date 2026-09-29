Received: from mta1.migadu.com (out-241.mta1.migadu.com [95.215.58.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907C5111B9
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677743; cv=none; b=sMskQSvQz3/6Q37aeRrLbKWxmn2WktdX8c620kMpdliqb+wsH86jdtAk0nuO7Qc9iJaGmYabQgDukk7aw89Ugdsr8UZ/OW3yhn2zjFYATKPZ67cP4Ta1pHPQMP9CPyhQiqag169FHnBBzIY20J6TAvw2OmhCpmxGQ9HHm4VI+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677743; c=relaxed/simple;
	bh=pD+cis/wDWCh93w5eb5Uib3ul/Qyk4R+r1GaHe1/vbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CK6FXttcsUMFmpwWZV33UaCe8RCieNE9zXKsbzCqdgFu6HXKev4ffXVbPmWTetJnVtFsQ7ucVE1RCVhUeOUd3IEw7/O0TTtWDAL4LAQqsjKGPgp8uBMfS5V4Iu0w+usTs4tXOy+ydhoTbh1utkDem3MxfY69OJyDI47FPxzDoNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ErmKEZm6; arc=none smtp.client-ip=95.215.58.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ErmKEZm6"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pD+cis/wDWCh93w5eb5Uib3ul/Qyk4R+r1GaHe1/vbA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790677727; v=1; x=1791282527;
 b=ErmKEZm6fD7msYX/LvY2lNTjDlK/Ff5NTSJyjpLx3MCeWRdKheMo2koufaXJTji48czHASqy
 itIZsaJKIX6XSg+dPaHoHDCh24IV44k5q1eg6rnRRkEaUh0eJYqYOGMH1IJfvcG5UotNscXwPG8
 9PEwis2f8XVMJRZ10UzK4NTI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9fbbb2095db56e44;
	Tue, 29 Sep 2026 10:28:47 +0000
X-Mizu-Trace-ID: 9fbbb2095db56e44
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
Subject: [PATCH v2 2/4] LoongArch: KVM: Load dmsintc pointer once in pch_msi_set_irq
Date: Tue, 29 Sep 2026 18:28:19 +0800
Message-ID: <20260929102821.36112-3-cui.tao@linux.dev>
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

pch_msi_set_irq() reads kvm->arch.dmsintc several times: the non-NULL
check and the address-window comparison each reload the pointer, so a
concurrent device removal can be observed between them and the
following dereference hits a freed object.

Load the pointer once at the top of pch_msi_set_irq() and add a NULL
check with a local snapshot in dmsintc_set_irq().  Both loads use
READ_ONCE() so the compiler keeps them single.  This closes the
reload race; a narrower window where removal happens right after the
load remains, as the injection path takes no lock against destroy.

Fixes: 03de5eecb0f0 ("LoongArch: KVM: Add DMSINTC inject msi to vCPU")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/kvm/intc/dmsintc.c | 6 +++++-
 arch/loongarch/kvm/intc/pch_pic.c | 7 ++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
index 41c8b597b5bd..91a163698c3c 100644
--- a/arch/loongarch/kvm/intc/dmsintc.c
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -69,9 +69,13 @@ int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data, int level)
 {
 	unsigned int irq, cpu;
 	struct kvm_vcpu *vcpu;
+	struct loongarch_dmsintc *s = READ_ONCE(kvm->arch.dmsintc);
+
+	if (!s)
+		return -EINVAL;
 
 	irq = (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
-	cpu = (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mask;
+	cpu = (addr >> AVEC_CPU_SHIFT) & s->cpu_mask;
 	if (cpu >= KVM_MAX_VCPUS)
 		return -EINVAL;
 	vcpu = kvm_get_vcpu_by_cpuid(kvm, cpu);
diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index 62c09b5f3937..30a8c65c7609 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -71,10 +71,11 @@ void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level)
 int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e, int level)
 {
 	u64 msg_addr = (((u64)e->msi.address_hi) << 32) | e->msi.address_lo;
+	struct loongarch_dmsintc *dmsintc = READ_ONCE(kvm->arch.dmsintc);
 
-	if (cpu_has_msgint && kvm->arch.dmsintc &&
-		msg_addr >= kvm->arch.dmsintc->msg_addr_base &&
-		msg_addr < (kvm->arch.dmsintc->msg_addr_base + kvm->arch.dmsintc->msg_addr_size)) {
+	if (cpu_has_msgint && dmsintc &&
+		msg_addr >= dmsintc->msg_addr_base &&
+		msg_addr < (dmsintc->msg_addr_base + dmsintc->msg_addr_size)) {
 		return dmsintc_set_irq(kvm, msg_addr, e->msi.data, level);
 	}
 
-- 
2.43.0

