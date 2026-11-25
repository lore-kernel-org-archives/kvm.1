Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795571080;
	b=S7Is4ibuNFPHWdLnTWjTx0qBtLT8qv2Wv/Q98ar7E2506fttO6+gx+wuTS06IVW5CaDT
	 kjcksNpkGCPm7DEPb4ECZrIjWNTHPl47vUfN++xvRbV05i8ktEqxjYqXYzz+Ny3ioJ1x3
	 JTGmHzXK6OLClQnueugPGO8kCglDybt8K+d9GxOD9lYJZ0z71dqow81uYC3wGWblu213A
	 zcJulIZfDMuL3Sl+f1sRLD0Eb7n2sugcyOufWeowbeICSNpaKzHszAmbLkqXajWxKeeH1
	 fMuFUSLCTYGAV5nbXW+Ui352Fg1Ee5gdPzLcGXr/GLZcnBt1WXwdLghYoXdqglWhiZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571080;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=DQ2noZm5zCHHb7/oSScqzeGGuAbrQQoSEmOlcfHGp20=;
	b=3OxiRjOUBiM1xyJqn3aqwKqIgxFRspTpC+HyTxipLNRDLoPWv+eg8rzf0jC/YjTqo02W
	 Kj245mDNIhCwu4PSLH3PJzWAYiB3PUee1OBG7MBqWc87usNbrLN3YhA9+zM0ZhJKVfNxh
	 jIMiz8Mic+C0cyvVjKb6wvQcu8mGsonPXwo9b4pqegu/lduVOPvSucJE6ixwuRZqsJpsi
	 bLXNFN713jFrvKrAyoq7st0e9eo6su8KjwxXFnPusUAAFDR5f+h72Fw8eAJMru+22cNi2
	 yZ/0dpvZBZiB0bicYmVzKz/wZlDlhYfNihpEpmcNLJulwIdjSGsJJU1TkrvPxuofEQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF42606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 01:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BF42606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.240])
	by APP-03 (Coremail) with SMTP id rQCowADn8JF7PQZrw9m8AQ--.22523S2;
	Wed, 25 Nov 2026 09:44:27 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v3 5/9] riscv: Fall back to SBI DBCN when no UART is available
Date: Wed, 25 Nov 2026 09:44:05 +0800
Message-ID: <20261125014409.79852-6-wangxiang@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125014409.79852-1-wangxiang@iscas.ac.cn>
References: <20261125014409.79852-1-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:rQCowADn8JF7PQZrw9m8AQ--.22523S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF18AFWDKw43Jr1fZF1kXwb_yoW5uw18pF
	ZIgFsxtry5GFnYq3Z7tr1kCw4rGr48W3ykKryxJw1xZw4DJrZ8Xw4fta1av343WFy3AF4Y
	yFsFvFyfCF4UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUeQ6pDUUUU
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

Console setup currently relies on UART initialization. On EFI/ACPI
systems without a supported MMIO UART, initialization fails even when
the SBI DBCN console is available.

Probe SBI_EXT_DBCN during console initialization. Use the UART when it
is successfully initialized; if no UART is available, fall back to
SBI_EXT_DBCN_CONSOLE_WRITE when DBCN is supported. Report when early
printing may not work because the initialized UART differs from the
early UART base, or because DBCN is used instead.

Rename uart_lock to console_lock, since it protects both console
backends.

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 lib/riscv/io.c | 52 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/lib/riscv/io.c b/lib/riscv/io.c
index b1163404..45fe93f5 100644
--- a/lib/riscv/io.c
+++ b/lib/riscv/io.c
@@ -28,7 +28,8 @@
 static volatile u8 *uart0_base = UART_EARLY_BASE;
 static u32 uart0_reg_width = 1;
 static u32 uart0_reg_shift;
-static struct spinlock uart_lock;
+static struct spinlock console_lock;
+static bool prefer_dbcn;
 
 static u32 uart0_read(u32 num)
 {
@@ -71,16 +72,15 @@ static void uart0_init_fdt(void)
 				break;
 		}
 
-#ifdef CONFIG_SBI_CONSOLE
-		uart0_base = NULL;
-		return;
-#else
 		if (ret) {
+			if (prefer_dbcn) {
+				uart0_base = NULL;
+				return;
+			}
 			printf("%s: Compatible uart not found in the device tree, aborting...\n",
 			       __func__);
 			abort();
 		}
-#endif
 	} else {
 		const fdt32_t *val;
 		int len;
@@ -102,20 +102,33 @@ static void uart0_init_fdt(void)
 
 static void uart0_init_acpi(void)
 {
-	assert_msg(false, "ACPI not available");
+	if (prefer_dbcn)
+		uart0_base = NULL;
+	else
+		assert_msg(false, "ACPI UART not supported");
 }
 
 void io_init(void)
 {
+	prefer_dbcn = sbi_probe(SBI_EXT_DBCN);
+
 	if (dt_available())
 		uart0_init_fdt();
 	else
 		uart0_init_acpi();
 
+	if (!uart0_base && !prefer_dbcn)
+		assert_msg(false, "No console available");
+
 	if (uart0_base != UART_EARLY_BASE) {
-		printf("WARNING: early print support may not work. "
-		       "Found uart at %p, but early base is %p.\n",
-		       uart0_base, UART_EARLY_BASE);
+		if (uart0_base)
+			printf("WARNING: early print support may not work. "
+			       "Found uart at %p, but early base is %p.\n",
+			       uart0_base, UART_EARLY_BASE);
+		else
+			printf("WARNING: early print support may not work. "
+			       "Found DBCN console, but early base is %p.\n",
+			       UART_EARLY_BASE);
 	}
 }
 
@@ -126,31 +139,32 @@ void sbi_puts(const char *s)
 	unsigned long hi = upper_32_bits(addr);
 	unsigned long lo = lower_32_bits(addr);
 
-	spin_lock(&uart_lock);
+	spin_lock(&console_lock);
 	sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE, strlen(s), lo, hi, 0, 0, 0);
-	spin_unlock(&uart_lock);
+	spin_unlock(&console_lock);
 }
 
 void uart0_puts(const char *s);
 void uart0_puts(const char *s)
 {
 	assert(uart0_base);
-	spin_lock(&uart_lock);
+	spin_lock(&console_lock);
 	while (*s) {
 		while (!(uart0_read(UART_LSR_OFFSET) & UART_LSR_THRE))
 			;
 		uart0_write(0, *s++);
 	}
-	spin_unlock(&uart_lock);
+	spin_unlock(&console_lock);
 }
 
 void puts(const char *s)
 {
-#ifdef CONFIG_SBI_CONSOLE
-	sbi_puts(s);
-#else
-	uart0_puts(s);
-#endif
+	if (uart0_base)
+		uart0_puts(s);
+	else if (prefer_dbcn)
+		sbi_puts(s);
+	else
+		assert_msg(false, "No console available");
 }
 
 /*
-- 
2.47.3

