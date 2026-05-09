Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86058221F39;
	Sat,  9 May 2026 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778326910; cv=none; b=WxauHODNZvkEhCffgWerKpxPkYQSB6LWjRSxB9kuH8+r8o1JPB+q3XE14UGN1ZA7pNN7iPqWJHjikLaltfMQjQSRC5/2U3hatgRRiEQISVUnwkvNTSbEAWFJsivJXzcV+5A/+a+Pl+jUxOWmYI/9Jm7fwhpOJJjrEQzMkUJUg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778326910; c=relaxed/simple;
	bh=bTGWTu+W0+QZJwn0RSSvWnQ6KJKxtjXeqkOZFxyYq3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=usLqZOitf4dOzbiIfMeFUFucv1tZ8mGQdWs5yb5QK2zYC6kNkhiVbUqkClPguCpEB3+OrMuPMLQnx0t8Dt0nHVPv3Dfg8Qj64MhO98qNBImdKQEfIAfmxNMIriuF6DyhjG6lJrlkLW0nWjWKX7j1mIMVChH/gwyC4Y4pd83LBVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from yzs (unknown [115.199.218.204])
	by APP-05 (Coremail) with SMTP id zQCowAAHlQhjHf9pbOLKDw--.3401S2;
	Sat, 09 May 2026 19:41:24 +0800 (CST)
From: Zishun Yi <vulab@iscas.ac.cn>
To: Anup Patel <anup@brainfault.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Atish Patra <atish.patra@linux.dev>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zishun Yi <vulab@iscas.ac.cn>
Subject: [PATCH] riscv: KVM: Fix missing TLB flush on HENVCFG.PMM updates
Date: Sat,  9 May 2026 19:41:22 +0800
Message-ID: <20260509114122.1868327-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHlQhjHf9pbOLKDw--.3401S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWrJF4fXF43CrWktr17GFg_yoW8Ar4UpF
	W3uF95uaykJF1xGF9rta12gF4jkr4vgasIgr9rA342vrZFyF1Fq3yvg34IyryUC3y8X3yF
	kr4YqFW5urn0v3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRACA2n+2gnStgAAs4

According to the RISC-V Privileged ISA specification, if henvcfg.PMM is
changed from or to a value where (XLEN-PMLEN) is less than the GPA width
supported by the hgatp translation mode of that guest, hypervisors must
execute an HFENCE.GVMA with rs1=x0.

Currently, when a guest dynamically changes pointer masking mode via the
SBI FWFT extension, kvm_sbi_fwft_set_pointer_masking_pmlen() directly
modifies the hardware CSR_HENVCFG from the non-one-reg-access path
without issuing the required TLB invalidation

Fix this by adding an unconditional HFENCE.GVMA after the CSR write.

This vulnerability was discovered and reported by my SpecHunter, an
AI-driven architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2494/linux.txt
Fixes: 48d67106f4a7 ("RISC-V: KVM: Implement ONE_REG interface for SBI FWFT state")
Assisted-by: DeepSeek:DeepSeek-V4-Pro
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
---
 arch/riscv/kvm/vcpu_sbi_fwft.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index 2eab15339694..c2bd3ae699fd 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -186,8 +186,10 @@ static long kvm_sbi_fwft_set_pointer_masking_pmlen(struct kvm_vcpu *vcpu,
 	 * update here so that VCPU see's pointer masking mode change
 	 * immediately.
 	 */
-	if (!one_reg_access)
+	if (!one_reg_access) {
 		csr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
+		kvm_riscv_local_hfence_gvma_all();
+	}
 
 	return SBI_SUCCESS;
 }
-- 
2.51.2

