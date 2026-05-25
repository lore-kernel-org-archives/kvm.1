Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FB01991D4;
	Mon, 25 May 2026 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673021; cv=none; b=VCUsmSdRUEFp3FV5OR0KQpaNd93mmoVrsYfb4YNBmmbAZnoC/qShaUtJ7q1Ropm9TsKgGvPt/EOZw8GIlyEa0FrxMD3ixBhHbavysYRDoPTOdeHcwNhb885PlHutOYoztYswMB/VCW7n4uJihVm+gIyLRh9f1QZBtN2jNG5aOm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673021; c=relaxed/simple;
	bh=axzvH90TSsKs8Aupvke37/rlVihK0yGw6H28gwedDVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UbeiySnABVNM/lshW6CYRt8lrAIKE1zjk0QfEC+9S3oS/e1qz/Br8NV+InIiv/X/sxTv9/oB/+ulLfLvJP6eIphJP4mhIUjkuTCk+h5VtkrWJ4NPp8VUOavjzI8U7+V9WIL3IRihSchl+HWsUPhGzJW6JLpa0K6IvwbDWKluPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABXcdirpxNquvA8Eg--.6572S2;
	Mon, 25 May 2026 09:36:44 +0800 (CST)
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
Subject: [PATCH v2] RISC-V: KVM: Document a TOCTOU race in SBI system suspend handler
Date: Mon, 25 May 2026 01:36:42 +0000
Message-Id: <20260525013642.999187-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXcdirpxNquvA8Eg--.6572S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF45Ww4ruF48Ww4DXr15twb_yoW8AFW5pr
	sYkFnIgws5Gr4Ika1IyanrXr1Sg3yvgF4aqrZ2yFW5Ww1qva40krs3urWUXryUAFZYqryf
	Ar4jvF1ruwn8ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl-eOUUUUU=
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiDAgSCWoTok4USQAAsX

The SUSP handler checks that all other vCPUs are stopped before
entering system suspend, but a concurrent HSM HART_START can start
a vCPU after it has already passed the check.

This is a known TOCTOU race. We do not fix it because:
1. Triggering it requires a pathological guest.
2. Only guest state is at risk, not host integrity.
3. Userspace can double-check vCPU states before suspend.

Add a comment documenting the race and the rationale for not fixing it.

Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Assisted-by: YuanSheng:DeepSeek-V3.2
---
V1 -> V2:
- Replaced the fix with a comment.
Link: https://lore.kernel.org/linux-riscv/20260521142030.1560861-1-xujiakai2025@iscas.ac.cn/t/#u
---
 arch/riscv/kvm/vcpu_sbi_system.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi_system.c b/arch/riscv/kvm/vcpu_sbi_system.c
index c6f7e609ac794..6f64a59e5d3c4 100644
--- a/arch/riscv/kvm/vcpu_sbi_system.c
+++ b/arch/riscv/kvm/vcpu_sbi_system.c
@@ -35,6 +35,20 @@ static int kvm_sbi_ext_susp_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			return 0;
 		}
 
+		/*
+		 * Check that all other vCPUs are stopped before entering
+		 * system suspend.
+		 *
+		 * There is a known TOCTOU race here: a concurrent HSM
+		 * HART_START on another vCPU can start a vCPU after it
+		 * has already passed this check, violating the invariant.
+		 *
+		 * We do not fix this because:
+		 * 1. Triggering the race requires a pathological guest.
+		 * 2. Only guest state is at risk, not host integrity.
+		 * 3. Userspace can double-check vCPU states before
+		 *    proceeding with suspend.
+		 */
 		kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
 			if (tmp == vcpu)
 				continue;
-- 
2.34.1

