Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549F1FC8;
	Sat, 18 Jul 2026 04:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784349503; cv=none; b=f6ReUA+HmRIjoztBnJOeMzWqVGPk5rDacizmP4pePk/OvtcOPtY5dBip5icngy3NZe8JrUJj4yC6BnVeGbMh8W2woFHEzt66xQ1JrsDug3CPVZ8aISf5B9DR4Zn3uorm/TT/A2jDX8kotJSfQ69VhWDQQ88gv94TD+kDXXappRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784349503; c=relaxed/simple;
	bh=nMJKzz7qXH8PDLwS9zugaXVYXeUCYHHiOfZjtHOgBhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujyGb+DxlnzOwaPl0W8GDuP8DyOWLWhnaFVUPWSzZKjBbdVdpdiUhFqHgLXefmlccOLjZhKWQ1ghAbl1REyXKPSgjlzSnBs91Oh+vkGW7gF8BaDwZX4/WWpAiGxt5R45rhKdrUdESwLTra3USqeALzEecUb11Sos4m20SWRiRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowABHUkAzA1tq5VAuAA--.39461S2;
	Sat, 18 Jul 2026 12:38:11 +0800 (CST)
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
Subject: [PATCH] RISC-V: KVM: Guard HFENCE range loops against overflow
Date: Sat, 18 Jul 2026 12:38:11 +0800
Message-ID: <20260718040000.008.17bfd3bd-caplitmus-rv@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHUkAzA1tq5VAuAA--.39461S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFWkWFWxuF15AF1xKrW3ZFb_yoW7Aw48pF
	s3WrWFkw4xXrnrXr9Fv3ZaqFy5G340gr45K3y3Ar9YqwnaqrsYv3s0g347Ar1kCF97ZFy8
	Aa4YgFn29FyDZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUoq2MUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The local HFENCE range helpers build the loop end with addr + size and
then step through the range by the requested page order. If addr + size
wraps, a small range near the top of the address space can be treated as
empty and skip the intended fence. The final loop step can also wrap
before the loop condition is evaluated again.

Treat wrapped ranges conservatively as full-range HFENCE requests and stop
each bounded loop before the next step can wrap past the computed end. This
keeps the existing large-range fallback and only changes local GVMA/VVMA
range construction.

Fixes: 2415e46e3a9a ("RISC-V: KVM: Introduce range based local HFENCE functions")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/riscv/kvm/tlb.c | 71 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 993b25ea94d67..b0c83e3ccc15a 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -8,6 +8,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/smp.h>
 #include <linux/kvm_host.h>
 #include <asm/cacheflush.h>
@@ -24,7 +25,12 @@ void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
 					  gpa_t gpa, gpa_t gpsz,
 					  unsigned long order)
 {
-	gpa_t pos;
+	gpa_t end, pos, step = BIT(order);
+
+	if (check_add_overflow(gpa, gpsz, &end)) {
+		kvm_riscv_local_hfence_gvma_vmid_all(vmid);
+		return;
+	}
 
 	if (PTRS_PER_PTE < (gpsz >> order)) {
 		kvm_riscv_local_hfence_gvma_vmid_all(vmid);
@@ -33,14 +39,20 @@ void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
 
 	if (has_svinval()) {
 		asm volatile (SFENCE_W_INVAL() ::: "memory");
-		for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order))
+		for (pos = gpa; pos < end; pos += step) {
 			asm volatile (HINVAL_GVMA(%0, %1)
 			: : "r" (pos >> 2), "r" (vmid) : "memory");
+			if (end - pos <= step)
+				break;
+		}
 		asm volatile (SFENCE_INVAL_IR() ::: "memory");
 	} else {
-		for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order))
+		for (pos = gpa; pos < end; pos += step) {
 			asm volatile (HFENCE_GVMA(%0, %1)
 			: : "r" (pos >> 2), "r" (vmid) : "memory");
+			if (end - pos <= step)
+				break;
+		}
 	}
 }
 
@@ -52,7 +64,12 @@ void kvm_riscv_local_hfence_gvma_vmid_all(unsigned long vmid)
 void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t gpsz,
 				     unsigned long order)
 {
-	gpa_t pos;
+	gpa_t end, pos, step = BIT(order);
+
+	if (check_add_overflow(gpa, gpsz, &end)) {
+		kvm_riscv_local_hfence_gvma_all();
+		return;
+	}
 
 	if (PTRS_PER_PTE < (gpsz >> order)) {
 		kvm_riscv_local_hfence_gvma_all();
@@ -61,14 +78,20 @@ void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t gpsz,
 
 	if (has_svinval()) {
 		asm volatile (SFENCE_W_INVAL() ::: "memory");
-		for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order))
+		for (pos = gpa; pos < end; pos += step) {
 			asm volatile(HINVAL_GVMA(%0, zero)
 			: : "r" (pos >> 2) : "memory");
+			if (end - pos <= step)
+				break;
+		}
 		asm volatile (SFENCE_INVAL_IR() ::: "memory");
 	} else {
-		for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order))
+		for (pos = gpa; pos < end; pos += step) {
 			asm volatile(HFENCE_GVMA(%0, zero)
 			: : "r" (pos >> 2) : "memory");
+			if (end - pos <= step)
+				break;
+		}
 	}
 }
 
@@ -83,7 +106,13 @@ void kvm_riscv_local_hfence_vvma_asid_gva(unsigned long vmid,
 					  unsigned long gvsz,
 					  unsigned long order)
 {
-	unsigned long pos, hgatp;
+	unsigned long end, pos, step = BIT(order);
+	unsigned long hgatp;
+
+	if (check_add_overflow(gva, gvsz, &end)) {
+		kvm_riscv_local_hfence_vvma_asid_all(vmid, asid);
+		return;
+	}
 
 	if (PTRS_PER_PTE < (gvsz >> order)) {
 		kvm_riscv_local_hfence_vvma_asid_all(vmid, asid);
@@ -94,14 +123,20 @@ void kvm_riscv_local_hfence_vvma_asid_gva(unsigned long vmid,
 
 	if (has_svinval()) {
 		asm volatile (SFENCE_W_INVAL() ::: "memory");
-		for (pos = gva; pos < (gva + gvsz); pos += BIT(order))
+		for (pos = gva; pos < end; pos += step) {
 			asm volatile(HINVAL_VVMA(%0, %1)
 			: : "r" (pos), "r" (asid) : "memory");
+			if (end - pos <= step)
+				break;
+		}
 		asm volatile (SFENCE_INVAL_IR() ::: "memory");
 	} else {
-		for (pos = gva; pos < (gva + gvsz); pos += BIT(order))
+		for (pos = gva; pos < end; pos += step) {
 			asm volatile(HFENCE_VVMA(%0, %1)
 			: : "r" (pos), "r" (asid) : "memory");
+			if (end - pos <= step)
+				break;
+		}
 	}
 
 	csr_write(CSR_HGATP, hgatp);
@@ -123,7 +158,13 @@ void kvm_riscv_local_hfence_vvma_gva(unsigned long vmid,
 				     unsigned long gva, unsigned long gvsz,
 				     unsigned long order)
 {
-	unsigned long pos, hgatp;
+	unsigned long end, pos, step = BIT(order);
+	unsigned long hgatp;
+
+	if (check_add_overflow(gva, gvsz, &end)) {
+		kvm_riscv_local_hfence_vvma_all(vmid);
+		return;
+	}
 
 	if (PTRS_PER_PTE < (gvsz >> order)) {
 		kvm_riscv_local_hfence_vvma_all(vmid);
@@ -134,14 +175,20 @@ void kvm_riscv_local_hfence_vvma_gva(unsigned long vmid,
 
 	if (has_svinval()) {
 		asm volatile (SFENCE_W_INVAL() ::: "memory");
-		for (pos = gva; pos < (gva + gvsz); pos += BIT(order))
+		for (pos = gva; pos < end; pos += step) {
 			asm volatile(HINVAL_VVMA(%0, zero)
 			: : "r" (pos) : "memory");
+			if (end - pos <= step)
+				break;
+		}
 		asm volatile (SFENCE_INVAL_IR() ::: "memory");
 	} else {
-		for (pos = gva; pos < (gva + gvsz); pos += BIT(order))
+		for (pos = gva; pos < end; pos += step) {
 			asm volatile(HFENCE_VVMA(%0, zero)
 			: : "r" (pos) : "memory");
+			if (end - pos <= step)
+				break;
+		}
 	}
 
 	csr_write(CSR_HGATP, hgatp);
-- 
2.43.0

