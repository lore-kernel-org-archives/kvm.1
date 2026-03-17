Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51604288530;
	Tue, 17 Mar 2026 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748139; cv=none; b=ZsNFk65ZRVo83yYDdd32sYV3geupDdV5SINnKznGj+cRBKri49+0Oxmv5q8SHenP7TF2LqSBbKrprCbvmd2Jv40PPQGgpZqnJaVof3IDaMRS229T80Hg6egXVe6D6A6ieg9Ly6DnpWHoVu51eSyZUkeM7lA5ZV2QowBj8YmcFtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748139; c=relaxed/simple;
	bh=3wLjJP31fnJ+/U8yicSpNu19mLtNHe9+Ak1b2C4eVcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D3cs/n3kpvVsB5ZGgbSV0Vk65glODfzZd4ZK0ZLoDX/7y5lSr2rOpWDcfdVPxWuWxJU0wPqE2O6siMLkskNwQpnN4RYTRkpz5uyWdPkRxMkXANnp7JSUojs2eyTTWtI82nwR8tk12Q8jxTNTHzcjEty8mGX7whrufevmJmVpzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DzKVecJ/; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DzKVecJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=s9
	IU2IA+qffEatxA+OQV2y2PbABqMCPV4NHMrG4Jiks=; b=DzKVecJ/SnNywN4Xo0
	7dElOCcrtSYj25kVgdNgS4KOCzKUzb+qCPg9J4dSaag2qMo7ivKKpm0g0ezINleY
	yJpUXkVyso8sXseUtrGBHXkXuZ8xxVEB7WhGgTTYzYTbZW06GvVYy+nNxpBgbsKn
	L4wVHeKWA/UyGcv13gZwD7lek=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAHqYhwP7lpCgwKAA--.596S2;
	Tue, 17 Mar 2026 19:48:06 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yufeng Wang <wangyufeng@kylinos.cn>
Subject: [PATCH] riscv: kvm: add null pointer check for vector datap
Date: Tue, 17 Mar 2026 19:47:59 +0800
Message-Id: <20260317114759.53165-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAHqYhwP7lpCgwKAA--.596S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw13Cr17XF4rJr48AFWrKrg_yoWDArg_G3
	WxXa4Sq3yrAF4jvw4DKa1fGF1Sgr97K3yUGrn3Krn7WFW09w4DC3yDXF4rZFyUZ39xG3Z7
	Jr4jvrW2y343tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8O6pPUUUUU==
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzRa1K2m5P3YGCwAA3R

From: Yufeng Wang <wangyufeng@kylinos.cn>

Add WARN_ON check before accessing cntx->vector.datap in
kvm_riscv_vcpu_vreg_addr() to detect potential null pointer
dereferences early, consistent with the pattern used in
kvm_riscv_vcpu_vector_reset().

This helps catch initialization issues where vector context
allocation may have failed.

Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
 arch/riscv/kvm/vcpu_vector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 46fbf48f2503..e989cb9f1ac4 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -129,6 +129,7 @@ static int kvm_riscv_vcpu_vreg_addr(struct kvm_vcpu *vcpu,
 	} else if (reg_num <= KVM_REG_RISCV_VECTOR_REG(31)) {
 		if (reg_size != vlenb)
 			return -EINVAL;
+		WARN_ON(!cntx->vector.datap);
 		*reg_addr = cntx->vector.datap +
 			    (reg_num - KVM_REG_RISCV_VECTOR_REG(0)) * vlenb;
 	} else {
-- 
2.34.1

