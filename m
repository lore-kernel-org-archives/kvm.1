Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AAE25B09F;
	Sat, 18 Jul 2026 04:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784349352; cv=none; b=iPuGI5deDdV5v1ShNiDnDDBpUQmLZDiR6lZd5rwe9V9weT2WrfGQWhTcs1jbRpH4ak7cVvTK1eZRhSreDnka4XxSO95HMawCYmciRCUBJh6QyHEXbxTwmS7LKIhCrlEQssgI4LBfz4PczytLuRgjcQyIDptJtrjQs+g+VFgnbKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784349352; c=relaxed/simple;
	bh=z9gnMkr4OELYOwaL5eUrA1GA1pXIcuIfhMViEi0fIIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBSxT+OaZ5ouMxLe7u6+0UJwz8lv/m2AxO/9SLsj4YRsNv6NokhFCd6un61SbLCVYzF89QAKDZplUnOOcLt8PtQyKQdJDr6oKOxWEH4X6gk/jzzJbqvtCbGsGfUrN3W6qa+Q3u1Qd/HRbTCquuqRAbyZI6/CPtq874voODqKz98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAD3AUCcAltqvEsuAA--.37031S2;
	Sat, 18 Jul 2026 12:35:40 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: Reject overlapping AIA IMSIC address fields
Date: Sat, 18 Jul 2026 12:35:40 +0800
Message-ID: <20260718040000.005.6ede2881-caplitmus-rv@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3AUCcAltqvEsuAA--.37031S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr43Ww17Kw45tF1UKw1DGFg_yoW8WFyUpr
	ZxKF4Fkryjgry7KFZY9w1Igw48C3Wvkw43JryUAr12kr1Iyr92kFn0grWUZFs5Ars2q3yf
	tF4Y93yv934UAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUpwZcUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

KVM lets userspace configure the IMSIC guest, HART, group-width, and
group-shift fields independently. The individual bounds allow a layout
such as guest_bits=7, hart_bits=6, group_bits=1, and group_shift=24.

That layout places the group index bit at bit 24 while the lower
guest+HART field also extends through bit 24. The IMSIC address helpers
later consume these values as one address layout: aia_imsic_ppn() masks
the lower guest+HART field and the group field, while
aia_imsic_hart_index() combines the group and HART index. Allowing an
overlapping configuration therefore gives one address bit two different
meanings.

Reject group-index layouts that start before the end of the guest+HART
field before initializing the in-kernel irqchip.

Fixes: 89d01306e34d ("RISC-V: KVM: Implement device interface for AIA irqchip")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/riscv/kvm/aia_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index be83c2d5fc308..0793d4d4cf5e3 100644
--- a/arch/riscv/kvm/aia_device.c
+++ b/arch/riscv/kvm/aia_device.c
@@ -248,6 +248,12 @@ static int aia_init(struct kvm *kvm)
 	if (aia->nr_sources && aia->aplic_addr == KVM_RISCV_AIA_UNDEF_ADDR)
 		return -EINVAL;
 
+	/* Group index bits must not overlap guest and HART index bits. */
+	if (aia->nr_group_bits &&
+	    aia->nr_group_shift < IMSIC_MMIO_PAGE_SHIFT +
+					  aia->nr_guest_bits + aia->nr_hart_bits)
+		return -EINVAL;
+
 	/* Initialize APLIC */
 	ret = kvm_riscv_aia_aplic_init(kvm);
 	if (ret)
-- 
2.43.0

