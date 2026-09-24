Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F73DB32D
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 03:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221206; cv=none; b=HxYEqziDivenjpZUGI0EeTSEMyabjkd5SEgf8aOJZ5SIBsdUZljnzK6n4c5p+uuDjgiaOupxIetNAbJc3ajX/Al2RGaBlGrt7OUAMvZ4cai8AdGQ9WB71OkOEB1maoBksete/EeoRIynDJ3PmuVNUCOElp37I2Hrro3w0MT9IjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221206; c=relaxed/simple;
	bh=j7DI/VwV+M54yeV+q26oH3LQ60/Na9icysO7TCTRn30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZH1p9jhBdmUQzCoYbmMyfBHO6i2LqNGc7i5VARYQyL+8qWPMPsDwc+eSv9uS2LvqWSzO8xvphuJlOy3NOm3NqGvtxn+q7RP5eFKFMWTV4GIPHhmBK+mVxAMCT6+NCKH+Y/OMpVe/KfxhJ9MW0mXj9VCBhEcB4Zpc5xcH/HiEBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.201])
	by APP-01 (Coremail) with SMTP id qwCowADHnvKIm7RqE0_JCA--.1133S2;
	Thu, 24 Sep 2026 11:39:52 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	pbonzini@redhat.com,
	thuth@redhat.com,
	Xiang W <wangxiang@iscas.ac.cn>
Subject: [kvm-unit-tests PATCH 5/7] riscv: Decouple SBI console from UART init
Date: Thu, 24 Sep 2026 11:39:43 +0800
Message-ID: <20260924033945.176581-6-wangxiang@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260924033945.176581-1-wangxiang@iscas.ac.cn>
References: <20260924033945.176581-1-wangxiang@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHnvKIm7RqE0_JCA--.1133S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF45uFy8Kr1DuFW3AFyxKrg_yoW5Xw4fpF
	sxKFZxtryrJr4fu3Wxtw1kuwn8KFn7Cr4Sgr17Aw1FyayDXayDXws5KayIv34DWFyxZFWU
	AFWSqF93JF48uaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUFksgUUUUU=
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

CONFIG_SBI_CONSOLE already routes puts() through SBI DBCN, but console
setup still went through the UART init path. uart0_init_fdt() could skip
a missing UART, while uart0_init_acpi() aborted, so EFI/ACPI guests
with no described UART could not print.

Split the SBI console out of the UART driver. When CONFIG_SBI_CONSOLE is
set, io_init() is a no-op and puts() issues SBI_EXT_DBCN_CONSOLE_WRITE
directly. The UART probe and MMIO path are compiled only when SBI
console is disabled, so ACPI and DT boots no longer depend on an MMIO
UART for output.

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 lib/riscv/io.c | 50 +++++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/lib/riscv/io.c b/lib/riscv/io.c
index b1163404..6656cd32 100644
--- a/lib/riscv/io.c
+++ b/lib/riscv/io.c
@@ -14,6 +14,26 @@
 #include <asm/setup.h>
 #include <asm/spinlock.h>
 
+static struct spinlock uart_lock;
+
+#ifdef CONFIG_SBI_CONSOLE
+
+void io_init(void)
+{
+}
+
+void puts(const char *s)
+{
+	phys_addr_t addr = virt_to_phys((void *)s);
+	unsigned long hi = upper_32_bits(addr);
+	unsigned long lo = lower_32_bits(addr);
+
+	spin_lock(&uart_lock);
+	sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE, strlen(s), lo, hi, 0, 0, 0);
+	spin_unlock(&uart_lock);
+}
+
+#else
 #define UART_LSR_OFFSET		5
 #define UART_LSR_THRE		0x20
 
@@ -28,7 +48,6 @@
 static volatile u8 *uart0_base = UART_EARLY_BASE;
 static u32 uart0_reg_width = 1;
 static u32 uart0_reg_shift;
-static struct spinlock uart_lock;
 
 static u32 uart0_read(u32 num)
 {
@@ -71,16 +90,11 @@ static void uart0_init_fdt(void)
 				break;
 		}
 
-#ifdef CONFIG_SBI_CONSOLE
-		uart0_base = NULL;
-		return;
-#else
 		if (ret) {
 			printf("%s: Compatible uart not found in the device tree, aborting...\n",
 			       __func__);
 			abort();
 		}
-#endif
 	} else {
 		const fdt32_t *val;
 		int len;
@@ -118,21 +132,7 @@ void io_init(void)
 		       uart0_base, UART_EARLY_BASE);
 	}
 }
-
-void sbi_puts(const char *s);
-void sbi_puts(const char *s)
-{
-	phys_addr_t addr = virt_to_phys((void *)s);
-	unsigned long hi = upper_32_bits(addr);
-	unsigned long lo = lower_32_bits(addr);
-
-	spin_lock(&uart_lock);
-	sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE, strlen(s), lo, hi, 0, 0, 0);
-	spin_unlock(&uart_lock);
-}
-
-void uart0_puts(const char *s);
-void uart0_puts(const char *s)
+void puts(const char *s)
 {
 	assert(uart0_base);
 	spin_lock(&uart_lock);
@@ -143,15 +143,7 @@ void uart0_puts(const char *s)
 	}
 	spin_unlock(&uart_lock);
 }
-
-void puts(const char *s)
-{
-#ifdef CONFIG_SBI_CONSOLE
-	sbi_puts(s);
-#else
-	uart0_puts(s);
 #endif
-}
 
 /*
  * Defining halt to take 'code' as an argument guarantees that it will
-- 
2.47.3

