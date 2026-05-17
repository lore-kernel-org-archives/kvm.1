Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE6191;
	Sun, 17 May 2026 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779021871; cv=none; b=eKVEGYOYH7w88dxEgOVZ4jYbMHjEgUfLYuCjIFNzGa3rtaCQIckw/drycFxHqvO/VgTDi31WaFBjccKkpTrYfBv+166soFxVFqzM5tI7+LaFu+6IhtIspIHcW4jvRuJ9Priv54AW3TUBF1p2aQQ0WHMloKK4/1qKjBdYkhA5dxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779021871; c=relaxed/simple;
	bh=vJ4pdgZXfvgMnJQv9+YIP/pe3GGKXx7TojmziqCoUGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qafLb9CpfFmG+2Sbu53dDuBw/pEtK8YVgUhilTrtqxuP3ICP+IL0G7qxoFYzmYkO/3KteZDk7pkBsihw2ijEB5hGDHxgfKqihxO/AjzWyCVPnLXmZbag5bh9j+iurNKIdS4t2UjqF2vZZ7ZHTXcxxGlegIBLHe4JJscChkdKL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABH2AsfuAlqerGHEA--.30950S2;
	Sun, 17 May 2026 20:44:15 +0800 (CST)
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
Subject: [PATCH v2] RISC-V: KVM: Fix NULL pointer dereference in SBI v0.1 SEND_IPI handler
Date: Sun, 17 May 2026 12:44:14 +0000
Message-Id: <20260517124414.420919-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABH2AsfuAlqerGHEA--.30950S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw48WF1xtryUCF1fAFW3Awb_yoW8Wr1rpr
	WDCFnI9FWrJFWjk3WktFs2yr42yrs8Krs5tr4kAw15Z398tF1rZw4DK347JryUuFWqqF1S
	9r4jgFWv9FZ8AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU122NtUUUUU==
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiDAUKCWoJMy-L9AABsL

The SBI v0.1 SEND_IPI handler iterates over the hart mask and calls
kvm_get_vcpu_by_id() to find the target vcpu for each set bit. When a
guest provides a hart mask containing bits for non-existent vcpu_ids,
kvm_get_vcpu_by_id() returns NULL, which is then unconditionally
dereferenced by kvm_riscv_vcpu_set_interrupt(), causing a kernel crash.

Fix this by adding a NULL check before dereferencing the return value.
If the target vcpu is not found, skip it and continue processing the
remaining valid harts.

Fixes: a046c2d8578c ("RISC-V: KVM: Reorganize SBI code by moving SBI v0.1 to its own file")
Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Assisted-by: OpenClaw:DeepSeek-V3.2
---
V1 -> V2:
- Changed break to continue when vcpu is not found, as suggested by
  Anup Patel. Non-existent VCPUs in the hart mask should be ignored
  rather than aborting the entire SEND_IPI operation.
---
 arch/riscv/kvm/vcpu_sbi_v01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi_v01.c b/arch/riscv/kvm/vcpu_sbi_v01.c
index 188d5ea5b3b85..c9c323d4577a9 100644
--- a/arch/riscv/kvm/vcpu_sbi_v01.c
+++ b/arch/riscv/kvm/vcpu_sbi_v01.c
@@ -55,6 +55,8 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 
 		for_each_set_bit(i, &hmask, BITS_PER_LONG) {
 			rvcpu = kvm_get_vcpu_by_id(vcpu->kvm, i);
+			if (!rvcpu)
+				continue;
 			ret = kvm_riscv_vcpu_set_interrupt(rvcpu, IRQ_VS_SOFT);
 			if (ret < 0)
 				break;
-- 
2.34.1

