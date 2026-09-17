Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118924E1C83
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647274; cv=none; b=RHmSkYAkU5QvoWxJrOAQhHSYkjWXzLjs80sZRypcpqAN04ysndun0QvnVXPEERKh1olERv4SrzXRcIEpWUUTxIO6s/cmtNYLb6gwuih/MvcjzYeUF7ZrJXx46xOUfFixio/AnRxTc/xH7FFTkwRkocXA42I2frPUN3wcZA1rSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647274; c=relaxed/simple;
	bh=+eyexfpnseWmjhMaD8L8quyWCu+TJraVjkv11B6D1cE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m7ZdFdRH7w+h9KNq5AzHPqKpk8ICwPWbL9j90TGOP2ojzi2g1j75dgdyBdOEbPXXITx/ruPjMG2WzrW8iJMCCR31D4U+NZpO6tcQs1HtKSbXTCMMMOFai7q56FmihEJqhwl3NQ2FXKbW4C/8avjlSpD2zeeKD13aZqnfdQUI6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0002472LT.eswin.cn (unknown [10.12.96.78])
	by app2 (Coremail) with SMTP id TQJkCgDX7aCT2atq4JiDAA--.20140S2;
	Thu, 17 Sep 2026 20:14:12 +0800 (CST)
From: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Subject: [PATCH] RISC-V: KVM: Replace imsic switch-case macros with range checks
Date: Thu, 17 Sep 2026 20:14:11 +0800
Message-Id: <20260917121411.2445-1-yuanxiaofeng@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgDX7aCT2atq4JiDAA--.20140S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XrWkuF1UZF1fGFyUAw43ZFb_yoWxuF1Dp3
	4DWrWqkr1kA3Z7Xws8Gws8ZFy8Jrn8urn8Cr1fKa1fXryUA3Z5Wr1kZ393GFy7ur9rZ3Zx
	W3s7C3W5A34UGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUva14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
	uYvjfU5oGQDUUUU
X-CM-SenderInfo: h1xd05xldrwv1qj6v25zlqu0xpsx3x1qjou0bp/1tbiAQENE2qqxK88TQAAsE

The imsic_eix_read/swap/write/set accessors use a family of macros
that expand into a switch with 128 cases covering the EIP and EIE
register windows. This mirrors the csr_read_num() idiom required where
a CSR number must be encoded as a csrr instruction immediate (e.g.
drivers/perf/riscv_pmu.c), but here the register number is merely
written to vsiselect as data, so the expansion solves no real
constraint. It costs ~90 lines of nested macros and trips ~30
checkpatch errors and warnings.

Since the generated cases form two contiguous windows, [IMSIC_EIP0,
IMSIC_EIP63] and [IMSIC_EIE0, IMSIC_EIE63], the same behavior is
expressed with a simple range check. Introduce imsic_eix_ireg_is_valid()
and use it in the four accessors, removing the macros along with the
~30 checkpatch errors and warnings they caused.

No functional change intended. Compile tested with riscv64-linux-gnu-gcc
and tested on QEMU (RISC-V virt, AIA).

Signed-off-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
---
 arch/riscv/kvm/aia_imsic.c | 124 +++++--------------------------------
 1 file changed, 15 insertions(+), 109 deletions(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index c1af23e79..5b6927733 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -67,36 +67,17 @@ struct imsic {
 	__r;					\
 })
 
-#define imsic_read_switchcase(__ireg)			\
-	case __ireg:					\
-		return imsic_vs_csr_read(__ireg);
-#define imsic_read_switchcase_2(__ireg)			\
-	imsic_read_switchcase(__ireg + 0)		\
-	imsic_read_switchcase(__ireg + 1)
-#define imsic_read_switchcase_4(__ireg)			\
-	imsic_read_switchcase_2(__ireg + 0)		\
-	imsic_read_switchcase_2(__ireg + 2)
-#define imsic_read_switchcase_8(__ireg)			\
-	imsic_read_switchcase_4(__ireg + 0)		\
-	imsic_read_switchcase_4(__ireg + 4)
-#define imsic_read_switchcase_16(__ireg)		\
-	imsic_read_switchcase_8(__ireg + 0)		\
-	imsic_read_switchcase_8(__ireg + 8)
-#define imsic_read_switchcase_32(__ireg)		\
-	imsic_read_switchcase_16(__ireg + 0)		\
-	imsic_read_switchcase_16(__ireg + 16)
-#define imsic_read_switchcase_64(__ireg)		\
-	imsic_read_switchcase_32(__ireg + 0)		\
-	imsic_read_switchcase_32(__ireg + 32)
+static bool imsic_eix_ireg_is_valid(int ireg)
+{
+	return (ireg >= IMSIC_EIP0 && ireg <= IMSIC_EIP63) ||
+	       (ireg >= IMSIC_EIE0 && ireg <= IMSIC_EIE63);
+}
 
 static unsigned long imsic_eix_read(int ireg)
 {
-	switch (ireg) {
-	imsic_read_switchcase_64(IMSIC_EIP0)
-	imsic_read_switchcase_64(IMSIC_EIE0)
-	}
-
-	return 0;
+	if (!imsic_eix_ireg_is_valid(ireg))
+		return 0;
+	return imsic_vs_csr_read(ireg);
 }
 
 #define imsic_vs_csr_swap(__c, __v)		\
@@ -107,36 +88,11 @@ static unsigned long imsic_eix_read(int ireg)
 	__r;					\
 })
 
-#define imsic_swap_switchcase(__ireg, __v)		\
-	case __ireg:					\
-		return imsic_vs_csr_swap(__ireg, __v);
-#define imsic_swap_switchcase_2(__ireg, __v)		\
-	imsic_swap_switchcase(__ireg + 0, __v)		\
-	imsic_swap_switchcase(__ireg + 1, __v)
-#define imsic_swap_switchcase_4(__ireg, __v)		\
-	imsic_swap_switchcase_2(__ireg + 0, __v)	\
-	imsic_swap_switchcase_2(__ireg + 2, __v)
-#define imsic_swap_switchcase_8(__ireg, __v)		\
-	imsic_swap_switchcase_4(__ireg + 0, __v)	\
-	imsic_swap_switchcase_4(__ireg + 4, __v)
-#define imsic_swap_switchcase_16(__ireg, __v)		\
-	imsic_swap_switchcase_8(__ireg + 0, __v)	\
-	imsic_swap_switchcase_8(__ireg + 8, __v)
-#define imsic_swap_switchcase_32(__ireg, __v)		\
-	imsic_swap_switchcase_16(__ireg + 0, __v)	\
-	imsic_swap_switchcase_16(__ireg + 16, __v)
-#define imsic_swap_switchcase_64(__ireg, __v)		\
-	imsic_swap_switchcase_32(__ireg + 0, __v)	\
-	imsic_swap_switchcase_32(__ireg + 32, __v)
-
 static unsigned long imsic_eix_swap(int ireg, unsigned long val)
 {
-	switch (ireg) {
-	imsic_swap_switchcase_64(IMSIC_EIP0, val)
-	imsic_swap_switchcase_64(IMSIC_EIE0, val)
-	}
-
-	return 0;
+	if (!imsic_eix_ireg_is_valid(ireg))
+		return 0;
+	return imsic_vs_csr_swap(ireg, val);
 }
 
 #define imsic_vs_csr_write(__c, __v)		\
@@ -145,35 +101,10 @@ do {						\
 	csr_write(CSR_VSIREG, __v);		\
 } while (0)
 
-#define imsic_write_switchcase(__ireg, __v)		\
-	case __ireg:					\
-		imsic_vs_csr_write(__ireg, __v);	\
-		break;
-#define imsic_write_switchcase_2(__ireg, __v)		\
-	imsic_write_switchcase(__ireg + 0, __v)		\
-	imsic_write_switchcase(__ireg + 1, __v)
-#define imsic_write_switchcase_4(__ireg, __v)		\
-	imsic_write_switchcase_2(__ireg + 0, __v)	\
-	imsic_write_switchcase_2(__ireg + 2, __v)
-#define imsic_write_switchcase_8(__ireg, __v)		\
-	imsic_write_switchcase_4(__ireg + 0, __v)	\
-	imsic_write_switchcase_4(__ireg + 4, __v)
-#define imsic_write_switchcase_16(__ireg, __v)		\
-	imsic_write_switchcase_8(__ireg + 0, __v)	\
-	imsic_write_switchcase_8(__ireg + 8, __v)
-#define imsic_write_switchcase_32(__ireg, __v)		\
-	imsic_write_switchcase_16(__ireg + 0, __v)	\
-	imsic_write_switchcase_16(__ireg + 16, __v)
-#define imsic_write_switchcase_64(__ireg, __v)		\
-	imsic_write_switchcase_32(__ireg + 0, __v)	\
-	imsic_write_switchcase_32(__ireg + 32, __v)
-
 static void imsic_eix_write(int ireg, unsigned long val)
 {
-	switch (ireg) {
-	imsic_write_switchcase_64(IMSIC_EIP0, val)
-	imsic_write_switchcase_64(IMSIC_EIE0, val)
-	}
+	if (imsic_eix_ireg_is_valid(ireg))
+		imsic_vs_csr_write(ireg, val);
 }
 
 #define imsic_vs_csr_set(__c, __v)		\
@@ -182,35 +113,10 @@ do {						\
 	csr_set(CSR_VSIREG, __v);		\
 } while (0)
 
-#define imsic_set_switchcase(__ireg, __v)		\
-	case __ireg:					\
-		imsic_vs_csr_set(__ireg, __v);		\
-		break;
-#define imsic_set_switchcase_2(__ireg, __v)		\
-	imsic_set_switchcase(__ireg + 0, __v)		\
-	imsic_set_switchcase(__ireg + 1, __v)
-#define imsic_set_switchcase_4(__ireg, __v)		\
-	imsic_set_switchcase_2(__ireg + 0, __v)		\
-	imsic_set_switchcase_2(__ireg + 2, __v)
-#define imsic_set_switchcase_8(__ireg, __v)		\
-	imsic_set_switchcase_4(__ireg + 0, __v)		\
-	imsic_set_switchcase_4(__ireg + 4, __v)
-#define imsic_set_switchcase_16(__ireg, __v)		\
-	imsic_set_switchcase_8(__ireg + 0, __v)		\
-	imsic_set_switchcase_8(__ireg + 8, __v)
-#define imsic_set_switchcase_32(__ireg, __v)		\
-	imsic_set_switchcase_16(__ireg + 0, __v)	\
-	imsic_set_switchcase_16(__ireg + 16, __v)
-#define imsic_set_switchcase_64(__ireg, __v)		\
-	imsic_set_switchcase_32(__ireg + 0, __v)	\
-	imsic_set_switchcase_32(__ireg + 32, __v)
-
 static void imsic_eix_set(int ireg, unsigned long val)
 {
-	switch (ireg) {
-	imsic_set_switchcase_64(IMSIC_EIP0, val)
-	imsic_set_switchcase_64(IMSIC_EIE0, val)
-	}
+	if (imsic_eix_ireg_is_valid(ireg))
+		imsic_vs_csr_set(ireg, val);
 }
 
 static unsigned long imsic_mrif_atomic_rmw(struct imsic_mrif *mrif,
-- 
2.34.1

