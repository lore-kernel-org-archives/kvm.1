Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4D3264F9;
	Fri,  3 Apr 2026 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775258426; cv=none; b=lBUIOObFLOpLYiQSQVaF4M4yDUvprBHnIP4UypKjukB3g57rHv9h1SSwK1ad+B22dH7HkmbxYC9f1/g43VTGacTYq7OTHxR4IVwCuxITO9n0m+holwmXc/pIK02y8LJojRvDwQ1urvfnSy/7vraWgS0TVqQ+KZjpDDI0bxjgGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775258426; c=relaxed/simple;
	bh=Re3Py+OOsHnqXfYI69sqfdtmhzoou8VimSghUjBf2JU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kJzCtcfhgGGOtjqkP6a4dz8FmXycAo8PlRYSLQucpf3FmaAbPe157KvPgL6yHxPCnYsW+n/gh58NK6zDtxC6sy11lkJ9UR/j5olsGpZADBNBmTuF5I6La3ift5OMknPSHRj0y6cB8QYSb6fCtetAmpZTHgj6PU3ace1e1jy4UjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowADHb2ssS9BpDqMbDA--.3154S2;
	Sat, 04 Apr 2026 07:20:12 +0800 (CST)
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
Subject: [PATCH v2] RISC-V: KVM: Fix shift-out-of-bounds in make_xfence_request()
Date: Fri,  3 Apr 2026 23:20:11 +0000
Message-Id: <20260403232011.2394966-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHb2ssS9BpDqMbDA--.3154S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy7try3tw1UXF4rWr45Jrb_yoW8XryDpr
	4kuFsa9Fs5GFnFya47ArZ5WF18Ar1kK34jvrW3uF48Jr4qqry8ArsY93s8Wry3JFsYqryF
	krnIqFyfua1DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6FWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0sqXDUUU
	U
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiBwkGCWnP11+pggAAsE

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
V1 -> V2:
- Dropped 'idx' variable and compared vcpu_id against hbase directly,
  as suggested by Andrew Jones.
---
 arch/riscv/kvm/tlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index ff1aeac4eb8eb..439c20c2775ab 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -338,7 +338,8 @@ static void make_xfence_request(struct kvm *kvm,
 	bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		if (hbase != -1UL) {
-			if (vcpu->vcpu_id < hbase)
+			if (vcpu->vcpu_id < hbase ||
+				vcpu->vcpu_id >= hbase + BITS_PER_LONG)
 				continue;
 			if (!(hmask & (1UL << (vcpu->vcpu_id - hbase))))
 				continue;
-- 
2.34.1

