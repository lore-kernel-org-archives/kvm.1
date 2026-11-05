Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866858;
	b=BvxoTGsA9/C2bff7+CaVvhNRaPeaW3IWCsijW2sYHnFK+WGfSubY3Wyl6ggEwAYXTxQT
	 Rblcl2DKYMcb7NGsSBMzEBbhGkk1VIQRsABJPmEYNYVZn9BkkpvIKURfENZucu40DJ14A
	 4y2Iqal1L2DNO2RoVs7upem19LQh/cAq1bnDGq4wWwukbQKMT3x39axhJApGcuavmbbc9
	 /wq6mGcTXVNG4Lqe48ulL2qJ5XcQvjQ+unQI/UG4HQnUDFV+ZlZ4VhI47DDNOOeELZ/c/
	 4d7KtxTIFqG599u6TlsiOzMe1jXOrT+tTw4EpUgViRz2bFN8wBaCBsAQbXMdl49h0LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866858;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=brFF/KATiPJUA3/sTxoBk+W+nsgy+C1lWT1URBfqhmE=;
	b=zYG1cr0ARia/SXaf/Hqx22URTS5fW9RGKJNM9sKBstKOJGUiXHxWMxmSsUmh64jH3Hqe
	 TlRnbgOLcuGTyefuQ4U5YYHI9ol/bAseqvxnQaZ7sJubUS0nd5PmOwCXfdFhB4MPtY/O4
	 PwLm1grfgwvj40YdxRgIE/AN8/SQAp+arWu4aSr7c3n1XMQzF4nCGsLeVUA5Hq5ANZ8Xy
	 4+URFCC8HzD7gPUnzSzSEIC44vmLCiXSzBYYcA8PY3qpETS+J7zohTxeqtP99IbuiFdj4
	 M3FcNHcemyIwff6TESVfElmuoGjm2QZvuk8a0AIOThRi6TO1KU3DfU3NnLT0VePFcQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410D7606A330
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 08:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 410D7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.204])
	by APP-01 (Coremail) with SMTP id qwCowAAXQftYPOxqxydRAA--.3090S2;
	Thu, 05 Nov 2026 16:20:40 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v2 3/8] riscv: Add ACPI support for timer frequency discovery
Date: Thu,  5 Nov 2026 16:20:30 +0800
Message-ID: <20261105082035.133680-4-wangxiang@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
References: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAAXQftYPOxqxydRAA--.3090S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4UCrWfCw13Jr45XrW7XFb_yoW5Xr1rpF
	Z3KF43Gry7ta4fWwnxZrn0qrn5tw1vkF18Kr42yrZxuF4DJa4DJa1Yqrn2qFyfX3yDJa9x
	Kr1rGa9I9r4jgrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU8db1UUUUU
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

When a DT is not provided, read the system time base frequency from
the RHCT instead of aborting in timer_get_frequency().

RHCT Time Base Frequency is the ACPI equivalent of the DT
/cpus timebase-frequency property and is the same for all harts.
Keep DT as the preferred path when one is available.

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 lib/acpi.h        |  9 +++++++++
 lib/riscv/timer.c | 38 ++++++++++++++++++++++++++------------
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/lib/acpi.h b/lib/acpi.h
index f6c92d28..0589669b 100644
--- a/lib/acpi.h
+++ b/lib/acpi.h
@@ -20,6 +20,7 @@
 #define MADT_SIGNATURE ACPI_SIGNATURE('A','P','I','C')
 #define SPCR_SIGNATURE ACPI_SIGNATURE('S','P','C','R')
 #define GTDT_SIGNATURE ACPI_SIGNATURE('G','T','D','T')
+#define RHCT_SIGNATURE ACPI_SIGNATURE('R','H','C','T')
 
 #define ACPI_SIGNATURE_8BYTE(c1, c2, c3, c4, c5, c6, c7, c8) \
 	(((uint64_t)(ACPI_SIGNATURE(c1, c2, c3, c4))) |	     \
@@ -325,6 +326,14 @@ struct acpi_table_gtdt {
 	u32 virtual_el2_timer_flags;
 };
 
+struct acpi_table_rhct {
+	ACPI_TABLE_HEADER_DEF
+	u32 flags;
+	u64 time_base_freq;
+	u32 node_count;
+	u32 node_offset;
+};
+
 /* Reset to default packing */
 #pragma pack()
 
diff --git a/lib/riscv/timer.c b/lib/riscv/timer.c
index 18063b7e..a3af7e2b 100644
--- a/lib/riscv/timer.c
+++ b/lib/riscv/timer.c
@@ -13,24 +13,38 @@
 #include <asm/smp.h>
 #include <asm/timer.h>
 
+#ifdef CONFIG_EFI
+#include <acpi.h>
+#endif
+
 void timer_get_frequency(void)
 {
-	const struct fdt_property *prop;
-	u32 *data;
-	int cpus, len;
-
-	assert_msg(dt_available(), "ACPI not yet supported");
+	if (dt_available()) {
+		const struct fdt_property *prop;
+		const void *fdt;
+		u32 *data;
+		int cpus, len;
 
-	const void *fdt = dt_fdt();
+		fdt = dt_fdt();
+		cpus = fdt_path_offset(fdt, "/cpus");
+		assert(cpus >= 0);
 
-	cpus = fdt_path_offset(fdt, "/cpus");
-	assert(cpus >= 0);
+		prop = fdt_get_property(fdt, cpus, "timebase-frequency", &len);
+		assert(prop != NULL && len == 4);
 
-	prop = fdt_get_property(fdt, cpus, "timebase-frequency", &len);
-	assert(prop != NULL && len == 4);
+		data = (u32 *)prop->data;
+		timebase_frequency = fdt32_to_cpu(*data);
+	} else {
+#ifdef CONFIG_EFI
+		struct acpi_table_rhct *rhct;
 
-	data = (u32 *)prop->data;
-	timebase_frequency = fdt32_to_cpu(*data);
+		rhct = find_acpi_table_addr(RHCT_SIGNATURE);
+		assert_msg(rhct, "Cannot find ACPI RHCT");
+		timebase_frequency = rhct->time_base_freq;
+#else
+		assert_msg(false, "ACPI not available");
+#endif
+	}
 }
 
 void timer_start(unsigned long duration_us)
-- 
2.47.3

