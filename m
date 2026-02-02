Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16636C0D8;
	Mon,  2 Feb 2026 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041264; cv=none; b=HbAZ2pGW+TAauQ9znofS7xt/xho73OgKZI4nmNVi0rE4/P6kZgSzEXH+QLpexyMU0eY+6JrbsL1IeZeaOy55Q+C07LWOR5GJWPnzDTDoEWlea+N6tYvBBlC4ao+WsOtcuSFu40aTldEc5QCiWJcNxyTxYaxR+sG17AjrgKsDkog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041264; c=relaxed/simple;
	bh=zlesaAogkQOyVKUMQdg35f6XjMNaQPjhX1pqXB9H2zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEIoBBR5kNq/eWXA1H0CLeY6ILVqjEjjljqIhVll24b40YI/Va87n3sReQCv2wT6hfFNmClSyw1dL3BW+yCHbPFKZ2ZWbn/qtxKSGrCHVbmB2EGS0NACU3VaOe8T5I6ufJbr1aJ2p6DdP7hN/NWFIlQXQCz/xsE58R5M3KQ6EXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LIeqAuWj; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LIeqAuWj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770041260; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=c7nf1V7kmJWw/Odnsc78VRe3jSjZG2g5QRkqoKh8BQo=;
	b=LIeqAuWjRBHwUxaesb5LbZUSfYUB7npgo+wBHGtvu92iKGgfFEQa9DEzxWoFWtj8f72JyPhO7hZrnyYY/zcWs1V25iD33ZqG1VTgr46fIV2LvDQQCZp1LbHkY2jwlDvzjlqtNjYrvTMhuVhpavv+f6WAMNu2RubfETvredDtwU0=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WyO62Yz_1770041257 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Feb 2026 22:07:39 +0800
From: fangyu.yu@linux.alibaba.com
To: pbonzini@redhat.com,
	corbet@lwn.net,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: guoren@kernel.org,
	ajones@ventanamicro.com,
	rkrcmar@ventanamicro.com,
	radim.krcmar@oss.qualcomm.com,
	andrew.jones@oss.qualcomm.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v4 4/4] RISC-V: KVM: Define HGATP mode bits for KVM_CAP_RISCV_SET_HGATP_MODE
Date: Mon,  2 Feb 2026 22:07:16 +0800
Message-Id: <20260202140716.34323-5-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260202140716.34323-1-fangyu.yu@linux.alibaba.com>
References: <20260202140716.34323-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Define UAPI bit positions for the supported-mode bitmask returned by
KVM_CHECK_EXTENSION(KVM_CAP_RISCV_SET_HGATP_MODE).

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 54f3ad7ed2e4..236cd790cb13 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -393,6 +393,9 @@ struct kvm_riscv_sbi_fwft {
 /* One single KVM irqchip, ie. the AIA */
 #define KVM_NR_IRQCHIPS			1
 
+#define KVM_RISCV_HGATP_MODE_SV39X4_BIT  0
+#define KVM_RISCV_HGATP_MODE_SV48X4_BIT  1
+#define KVM_RISCV_HGATP_MODE_SV57X4_BIT  2
 #endif
 
 #endif /* __LINUX_KVM_RISCV_H */
-- 
2.50.1

