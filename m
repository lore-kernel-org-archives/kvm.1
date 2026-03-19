Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A93242D9;
	Thu, 19 Mar 2026 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773892768; cv=none; b=DA3SnktoPPQuXcxIir9Y4kk3RJG2zJfzTBIbzGNAEq5g+sG/uvp1lKr0Hc5XFMxqWkEgIY1kMKFlxOGtdSVyqHLZdMWllXOJ4Mf2MWO6fJUoUnBFJapsoiZtx9LZtqijQK10jU7tgEoQkE003pyV78XLQP7bgTOACggHCNLx4WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773892768; c=relaxed/simple;
	bh=NhsDBbc8SLaLB4rr/KX51cjwDkWLmSFppwxfoL+6kHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BYbvTRdcovzv8NLIJiOuGfl+pfdY5ALcqeTBx6cjysa/k0PKtQkdouvYvYTllxgKJFKI1JJ8ANorM1rv00AoekuLOwLglsGmyAZ4T0DNcK9KtxnXikXPLtyt9/XSNh8HzsiohFqGqZBe3qdc0mo/kfe4z/dxzjy7Uw1/2hvZVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowAAHmQyKdLtpTTrUCg--.61883S2;
	Thu, 19 Mar 2026 11:59:07 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: [PATCH] RISC-V: KVM: Fix integer overflow in kvm_pmu_validate_counter_mask()
Date: Thu, 19 Mar 2026 03:59:02 +0000
Message-Id: <20260319035902.924661-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHmQyKdLtpTTrUCg--.61883S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1xZw1furW7Cw4Uuw43trb_yoW5AF4UpF
	WDGry5Grs5JF1kGa4UAws8Xr15Kr4kKanxCrs0k3yUtr90ga48Zrn5Kry2yrnrJFWkZFya
	yryDuayDuFW5Xa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1xhlDUUU
	U
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiBwsLCWm7a4Mi3AAAsK

When a guest initiates an SBI_EXT_PMU_COUNTER_CFG_MATCH call with
ctr_base=0xfffffffffffffffe, ctr_mask=0xeb5f and flags=0x1
(SBI_PMU_CFG_FLAG_SKIP_MATCH), kvm_riscv_vcpu_pmu_ctr_cfg_match()
first invokes kvm_pmu_validate_counter_mask() to verify whether
ctr_base and ctr_mask are valid, by evaluating:
 !ctr_mask || (ctr_base + __fls(ctr_mask) >= kvm_pmu_num_counters(kvpmu))

With the above inputs, __fls(0xeb5f) equals 15, and adding 15 to
0xfffffffffffffffe causes an integer overflow, wrapping around to 13.
Since 13 is less than kvm_pmu_num_counters(), the validation wrongly
succeeds.

Thereafter, since flags & SBI_PMU_CFG_FLAG_SKIP_MATCH is satisfied,
the code evaluates:
 !test_bit(ctr_base + __ffs(ctr_mask), kvpmu->pmc_in_use)

Here __ffs(0xeb5f) equals 0, so test_bit() receives 0xfffffffffffffffe
as the bit index and attempts to access the corresponding element of
the kvpmu->pmc_in_use, which results in an invalid memory access. This
triggers the following Oops:
 Unable to handle kernel paging request at virtual address e3ebffff12abba89
  generic_test_bit include/asm-generic/bitops/generic-non-atomic.h:128
  kvm_riscv_vcpu_pmu_ctr_cfg_match arch/riscv/kvm/vcpu_pmu.c:758
  kvm_sbi_ext_pmu_handler arch/riscv/kvm/vcpu_sbi_pmu.c:49
  kvm_riscv_vcpu_sbi_ecall arch/riscv/kvm/vcpu_sbi.c:608
  kvm_riscv_vcpu_exit arch/riscv/kvm/vcpu_exit.c:240

The root cause is that kvm_pmu_validate_counter_mask() does not account
for the case where ctr_base itself is out of range, allowing the
subsequent addition to silently overflow and bypass the check.

Fix this by explicitly validating ctr_base against kvm_pmu_num_counters()
before performing the addition.

This bug was found by fuzzing the KVM RISC-V PMU interface.

Fixes: 0cb74b65d2e5e6 ("RISC-V: KVM: Implement perf support without sampling")
Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
---
 arch/riscv/kvm/vcpu_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index e873430e596b2..a098a9b417ad8 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -266,8 +266,10 @@ static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 static int kvm_pmu_validate_counter_mask(struct kvm_pmu *kvpmu, unsigned long ctr_base,
 					 unsigned long ctr_mask)
 {
-	/* Make sure the we have a valid counter mask requested from the caller */
-	if (!ctr_mask || (ctr_base + __fls(ctr_mask) >= kvm_pmu_num_counters(kvpmu)))
+	unsigned long num_ctrs = kvm_pmu_num_counters(kvpmu);
+
+	/* Make sure we have a valid counter mask requested from the caller */
+	if (!ctr_mask || ctr_base >= num_ctrs || (ctr_base + __fls(ctr_mask) >= num_ctrs))
 		return -EINVAL;
 
 	return 0;
-- 
2.34.1

