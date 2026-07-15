Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C3236215B;
	Wed, 15 Jul 2026 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784084980; cv=none; b=TOFkh9upmqZNafyK/KoUZMg/M/FD3P1OIm5NzKcLXSoIeyzyYsZlTTLb30WRnD+SnUn+rOUi5F/6IefUl26cQjSgtYUdwz/E0P52oxiK8y0sJfkBhRxvjF5lN5f52PrlUpK9Kuaw71cqBPFPmLbSpB0XtTgkCrV6BwHt0z+YpV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784084980; c=relaxed/simple;
	bh=SjM4GX4wdkiRAIHMwOnHtVSbSRRxfUfp9/2NZ9nnbAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KqmzFnJqtt2Wljf/ogXlvKcAt0D1uCZV+/gWKh2bBCIw50blNC+lag5J5ztX649KMaZGEeNtpiyHTi/x71nW07gkMNIsI1vYLQsuNhoThPm7v0AtbeP5xlmfB1nKY5LFIt0RrdpqFzPoxjbY9/aeXihMhM6gmJkqXlpTCScVGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XsGo+DI/; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XsGo+DI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=W1
	Yja4BcpkoEw5xyKbA+I2eOZwzX/z8TKRA8nCYLALs=; b=XsGo+DI/aqqyBjXE2V
	p4JGxAuPtYDmdot5HgXUKaZKBDIXc9zk2zuRFOAZ7Fz/9zwP1OAQIRkbfyRymvBv
	p2e4FUcRHTKhRz4mgPnULemelgsJifZTaNwmWm4cJco2SRC1+J5DjdeYFikaC4Yx
	4vjppZWtjshowhHcSWGArjSQ8=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHAr6n+VZqFyOrJw--.59083S2;
	Wed, 15 Jul 2026 11:08:23 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH] KVM: riscv: Fix Spectre-v1 in vector register access
Date: Wed, 15 Jul 2026 11:08:18 +0800
Message-Id: <20260715030818.75657-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHAr6n+VZqFyOrJw--.59083S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww43ZFWDWFW3tw48Kw1DAwb_yoW8Ar1kpF
	sFkrs5Xrs5X3WfCay3CFZFv3yUu3s3Ka1rArW29a1DAryfKFyvqanY9ryDWF15JrWrZr1a
	9a4UZFy5Can8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URuWJUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC9AfXg2pW+afAfAAA35

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

User-controlled register indices from the ONE_REG ioctl are used to
index into the vector register buffer (v0..v31). Sanitize the calculated
offset with array_index_nospec() to prevent speculative out-of-bounds
access.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 arch/riscv/kvm/vcpu_vector.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 62d2fb77bb9b..3708616e2c32 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/kvm_host.h>
+#include <linux/nospec.h>
 #include <linux/uaccess.h>
 #include <asm/cpufeature.h>
 #include <asm/kvm_isa.h>
@@ -129,11 +130,20 @@ static int kvm_riscv_vcpu_vreg_addr(struct kvm_vcpu *vcpu,
 			return -ENOENT;
 		}
 	} else if (reg_num <= KVM_REG_RISCV_VECTOR_REG(31)) {
+		unsigned long reg_offset;
+
 		if (reg_size != vlenb)
 			return -EINVAL;
 		WARN_ON(!cntx->vector.datap);
-		*reg_addr = cntx->vector.datap +
-			    (reg_num - KVM_REG_RISCV_VECTOR_REG(0)) * vlenb;
+		/*
+		 * The reg_num is derived from the userspace-provided ONE_REG
+		 * id. Sanitize it with array_index_nospec() to prevent
+		 * speculative out-of-bounds access to the vector register
+		 * buffer (32 vector registers: v0..v31).
+		 */
+		reg_offset = array_index_nospec(
+				reg_num - KVM_REG_RISCV_VECTOR_REG(0), 32);
+		*reg_addr = cntx->vector.datap + reg_offset * vlenb;
 	} else {
 		return -ENOENT;
 	}
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus

