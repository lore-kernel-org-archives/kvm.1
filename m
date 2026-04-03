Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6536C0BD;
	Fri,  3 Apr 2026 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196817; cv=none; b=geTA31WepctcbYqav1uvdt1xzW9103ylx3Pbo41wAItYLD/3ZscruFKG3FM5Bj87sEYq+XQZOsZ9zNIK23K++d4/lHItNy7/0jjJnLhg2H+GSQ3zEBmpV00iHVyXfZ38awsTc5uKx29+iLXraMf5f2RczP3O0/SClncpbLzyqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196817; c=relaxed/simple;
	bh=1Z1csZvF8u2/sVJ5tNQBH/es/ajWN3czLvvNbQny0fs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CxhNp4OtW1t2vY4cRjfZeHxR0rf6yvA7Iola6qRIic08bIGx3uIVi92Upl8a2IJ8j1vMzo/m7+CW99An8HdfRSQbmY/ZuwSkYVXrtBb3vF0en8UEI8FKEqXYK4pyEhBr3QRGo2zqUzEdggiHfLr2lpa/L6MTt0pZcpjqo3/0ngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowAAn0m1wWs9pxNMLDA--.32889S2;
	Fri, 03 Apr 2026 14:13:05 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: [PATCH] RISC-V: KVM: Fix shift-out-of-bounds in make_xfence_request()
Date: Fri,  3 Apr 2026 06:13:02 +0000
Message-Id: <20260403061302.2203179-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAn0m1wWs9pxNMLDA--.32889S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy7try3tw1UXF4rWr45Jrb_yoW8XFWfpF
	4kCanY9FZ5GF1aya4ftrZ5WF1Fkrs7Cw1DZrWa9FyrKrn0qF10yrsYg3sxWry3JFsYqry0
	kFnxtFy5ua1DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjEoGDUUUUU==
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiDAgGCWnPFcPwogAAsp

The make_xfence_request() function uses a shift operation to check if a
vCPU is in the hart mask:

  if (!(hmask & (1UL << (vcpu->vcpu_id - hbase))))

However, when the difference between vcpu_id and hbase
is >= BITS_PER_LONG, the shift operation causes undefined behavior.

This was detected by UBSAN:
  UBSAN: shift-out-of-bounds in arch/riscv/kvm/tlb.c:343:23
  shift exponent 256 is too large for 64-bit type 'long unsigned int'

Fix this by adding a bounds check before the shift operation.

This bug was found by fuzzing the KVM RISC-V interface.

Fixes: 13acfec2dbcc ("RISC-V: KVM: Add remote HFENCE functions based on VCPU requests")
Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
---
 arch/riscv/kvm/tlb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index ff1aeac4eb8eb..500e001513a11 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -333,14 +333,17 @@ static void make_xfence_request(struct kvm *kvm,
 	unsigned long i;
 	struct kvm_vcpu *vcpu;
 	unsigned int actual_req = req;
+	unsigned int idx;
 	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
 
 	bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		if (hbase != -1UL) {
-			if (vcpu->vcpu_id < hbase)
+			idx = vcpu->vcpu_id - hbase;
+
+			if (idx < 0 || idx >= BITS_PER_LONG)
 				continue;
-			if (!(hmask & (1UL << (vcpu->vcpu_id - hbase))))
+			if (!(hmask & (1UL << idx)))
 				continue;
 		}
 
-- 
2.34.1

