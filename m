Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616343;
	b=kHj7dIL2wn3ASruHD8StgFuF12rYwjv4uZ/ir1scJ7Ppl7Yuay1h+fLRy+QWbfdg96Wj
	 zKwK2Q+WkwrsyYDZYtCfSZ9CqYxnCNHFye9J7sTc35W0flBAeutfgU1AIt2doU8cAw7XD
	 Dm7XWTRFgDLRQWTmI7dP4j+njx/qG6wvQY8sYm0Ygw8L7rB95uDBhc7d/I8fDHjJS3kxe
	 k85Umtf2cBctNMb8DBWFO8ykv7iDo50z/efV0Rws3t8/jio2Cx1akREzrPAdrHlFetl5s
	 ZQrduc9DC5Xks4zwKn6Hhuz34VrPItqBydTqrv5VmJ7r9k8EEFmTrxH7hkWX+Nf3JfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616343;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=nr236xYih7iz3SImZnvcAGfaOnE1s+PqGimbAN2jjPE=;
	b=r9UZO5iyAoLCVlNOQWHQR0lVP6xtX6fcAil8lQabtW8wIbz7Q/b5V2Pj2E3i0ekxK7An
	 FDnDdhWMOD4bHez9Qdw5ZIgjnp+NSm5ZkwfPWX1uPMDFfsuA9jS0Z3KXatykYs931eo/w
	 2BG9c3b/+u8Sjq8sLZNPXAxBfxQ78i1ijShunmV2SmQpvniIGqe6qJxPCvM+1LwLo8A9b
	 Qu/XLz+d4ew7IV2rxh3quwks4IIhL/Bh2nNbTATB/Ef2brGQ3CxccFLoQwKiJz6MUt4MI
	 kKA8D/uzMijNTlCWRXDd5WcVG3++FAOO1Q+x5wk66mltoTLYPXBgFBlFCBtlXMH0jWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mails.ucas.ac.cn;
	spf=pass smtp.mailfrom=mails.ucas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA2606A323
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 14:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3DA2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from k3-03 (unknown [159.226.43.8])
	by APP-03 (Coremail) with SMTP id rQCowACHlpdC7gZrNoDHAQ--.9257S2;
	Wed, 25 Nov 2026 22:18:43 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH] RISC-V: KVM: Add missing write barrier when linking G-stage page tables
Date: Wed, 25 Nov 2026 22:18:40 +0800
Message-ID: <20261125141840.2047392-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHlpdC7gZrNoDHAQ--.9257S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF43Ar48Zry3JF43GF1DAwb_yoW8Xr1kpF
	Z7G3sa9r1rt3sagrnxtas2vrn3Wan3Gr13JrZ3CF1UZr4aqryjywnYg39FkFy5Gr9Yy34U
	ZrWUKF1kur4DA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
	W5XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhdbbUUUUU
	=
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/

kvm_riscv_gstage_set_pte() links a newly allocated page table
to its parent PTE without a write memory barrier.

A concurrent hardware page table walker may observe the parent
PTE before the child page table is fully initialized, potentially
interpreting stale contents as valid PTEs.

Add an smp_wmb() before linking the child page table, as is
already done in kvm_riscv_gstage_split_huge().

Sashiko reported this pre-existing issue while reviewing my
G-stage page table accounting patch. LLM assistance was used
to analyze the issue and prepare the changelog.

Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")
Link: https://sashiko.dev/#/bug/linux-9339e577-5f31-42a2-a5ea-9844d30b43f8

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
 arch/riscv/kvm/gstage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index 0aace3215d3e..61ab60adb616 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -160,6 +160,13 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
 			next_ptep = kvm_mmu_memory_cache_alloc(pcache);
 			if (!next_ptep)
 				return -ENOMEM;
+
+			/*
+			 * Ensure the initialization of the new page table is visible
+			 * before linking it to the parent PTE.
+			 */
+			smp_wmb();
+
 			set_pte(ptep, pfn_pte(PFN_DOWN(__pa(next_ptep)),
 					      __pgprot(_PAGE_TABLE)));
 		} else {
-- 
2.53.0

