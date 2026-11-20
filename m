Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795169371;
	b=4/DyXPIOWhHUOoG2HfpUGw+EtWJ3rmNTtLp30xmUdO8CRa67P6I0hPNz0N5BC7Zt/mk/
	 mnLRPUbdgfGtzg9cxk/Um0jnp7e1v59Aue2Nb/mL3pKsxHwXs3yj/KqUZbg7DSVf+Fu4W
	 u+GSjOHJYBuesWIy5ATHut1Y0Pd3+hIKyxdF8iHnIGQIuoS8EJWGRASB9f2GiEarAUqBf
	 QV5e3XHwno5ijCJgRx1sT/y5DCMLCCS5qzlUraiIA3/1KMNVLjRp9FmmY1GOcgtoQQAU4
	 /Xw2myO8/oasHtxxO4803fX5bk2Zu309eKsfzBKgFXppaK3wInc3SKGrCIQKh/c3AEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169371;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=F+xGlAnwR0WLyiydHfIp0vRf8UMesa+0QBoGK1N3+X0=;
	b=YeTP7+iUeaSnrSOtXOFExpV1T3S+k0cssNcfaAhDPIlD4d4nldSC73VgFuvRyH/B0jIt
	 HW4wRv81KhueZzlV5nlfNb6FacdnkF+qClaMyur6KvIr5wy4W/Ppu5EcY7tB8kA7bln2q
	 Ty53vdZ8aY1jGyFJtZ7DwWcQ8Yy84aUe89/xJBC7vQCTuQJED9dFkctdsgiPxN1r8W9oZ
	 8kWMMElcJhlDYzH5rS6o1x7IVYM5YHvm6oGPj6UJoGDPquPBntnJEDt/YhTyIdQgCave4
	 V26d3kZnkYXPKO8+VEv20/7tdjSyrHcTblbCssSXT0JbGJZ4V73Q1VMsalahmzwxjNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fzECUmiL;
	arc=none smtp.remote-ip=95.215.58.35
Received: from mta1.migadu.com (out-35.mta1.migadu.com [95.215.58.35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BFE60A2607
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 10:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05BFE60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fzECUmiL
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=P0qrC4mC5wPI0uNFi0/eqyjXHkxpX4a02QQNu5yIipA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795169369; v=1; x=1795774169;
 b=fzECUmiLzPUvYi6RAYuAglbE99OzMBGX63ylbmMKzlLfzGwBVX89gLjbqToy7yGiZcBJ7Myb
 rbVs+v3v/6ooL7+E0Y/0Inzw88xtkuGM03nzwlpWJvu+V69TxFXx6DE2FC8F/Ij2QCrLCbJ96QN
 R/pzTkCjAYj5Rq1+6h+8wEWc=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 86bed2740540ad58;
	Fri, 20 Nov 2026 10:09:29 +0000
X-Mizu-Trace-ID: 86bed2740540ad58
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 11:08:56 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v2 5/8] riscv: Prefer SBI DBCN console
 with UART fallback
Message-ID: <awAQYxcqIrJwxRl2@orel>
References: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
 <20261105082035.133680-6-wangxiang@iscas.ac.cn>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105082035.133680-6-wangxiang@iscas.ac.cn>

On Thu, Nov 05, 2026 at 04:20:32PM +0800, Xiang W wrote:
> CONFIG_SBI_CONSOLE already routes output through SBI DBCN, but console
> setup still always went through the UART init path. uart0_init_fdt()
> could skip a missing UART while uart0_init_acpi() aborted, so EFI/ACPI
> guests without a described MMIO UART could not print.
> 
> Probe SBI_EXT_DBCN first. When it is available, use
> SBI_EXT_DBCN_CONSOLE_WRITE and skip UART setup. Otherwise fall back to
> the existing FDT or ACPI UART path. This keeps a UART fallback (as
> required by the server platform spec on ACPI systems) while allowing

Your patch actually didn't support the fallback for early prints.
Let's go with the following approach instead.

diff --git a/lib/riscv/io.c b/lib/riscv/io.c
index b11634046b8f..e92c9288b3ad 100644
--- a/lib/riscv/io.c
+++ b/lib/riscv/io.c
@@ -28,7 +28,12 @@
 static volatile u8 *uart0_base = UART_EARLY_BASE;
 static u32 uart0_reg_width = 1;
 static u32 uart0_reg_shift;
-static struct spinlock uart_lock;
+static struct spinlock console_lock;
+#ifdef CONFIG_SBI_CONSOLE
+static bool prefer_dbcn = true;
+#else
+static bool prefer_dbcn = false;
+#endif
 
 static u32 uart0_read(u32 num)
 {
@@ -71,16 +76,15 @@ static void uart0_init_fdt(void)
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
@@ -102,17 +106,23 @@ static void uart0_init_fdt(void)
 
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
+	if (prefer_dbcn && !sbi_probe(SBI_EXT_DBCN))
+		prefer_dbcn = false;
+
 	if (dt_available())
 		uart0_init_fdt();
 	else
 		uart0_init_acpi();
 
-	if (uart0_base != UART_EARLY_BASE) {
+	if (!prefer_dbcn && uart0_base != UART_EARLY_BASE) {
 		printf("WARNING: early print support may not work. "
 		       "Found uart at %p, but early base is %p.\n",
 		       uart0_base, UART_EARLY_BASE);
@@ -126,31 +136,30 @@ void sbi_puts(const char *s)
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
+	if (prefer_dbcn)
+		sbi_puts(s);
+	else
+		uart0_puts(s);
 }
 
 /*
