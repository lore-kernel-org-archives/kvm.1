Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866858;
	b=OfXioQupD0K36YgYxMfYbiGaIS+NH+0xBk+rIQb9a/EjSkiGxfWD78fT0kJLgeDN1KlZ
	 JBnD2qXtIBZEyw6NU3NjWQimI3pxqBhnMzNEyTJ35kZ9GgkMCshsxF7JvqR+nk5t2eb+Y
	 XogOU7mYFsJexaSfnS9BiJqwyw4jBP4a8hFhrsrc0zNV7qSAw6RkHAUTlswUaridqfklh
	 gzff5Z390+IhsyQsYFYaBinoCzR8f45S7+KtqZD2X5kusuRub6w1qSN6y9nqUfci/qtpn
	 0pD8UXqnLdiLGx/tmpx3v53r4VOt0RKofOsBlDrtesU3NGpWdUR5I5CJYGEeNE3Pq0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866858;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=Djoata5h8ls3QTH+JC8HuxG6nTJQGU3H7XYvKnQIZe0=;
	b=a8uOGtoXXJs5Kx1yImlZW9PlDlzXH1Tn3VJSTbJZ+3eaquCf/hvUWTozRpiLnANCiIKM
	 skjq5TQLaXcvpFiVuN0RCgmIXCRsRWL16nDmc4emJSuR5URVlqwfkV0xVr/I0hhglsHzh
	 a+mKcvi18n2MZECILVnrm72OhryHW4SjSljCS0FFVUw3pWkHyQKRACeBW0D2ADS9bYfI8
	 t6/z3Q9vc3+OWL6HOszrewnzQEHprvamH+XhMiKx4mw2boIENv0FiuMSVB4wWnuedSsxA
	 TNJ/9a7fdo57jW01NpqI1SIjuqv/pL+CLplY0hvPEqQX0eIt49HtbFuF1+olH9P39Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F93606A32D
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 08:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40F93606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.204])
	by APP-01 (Coremail) with SMTP id qwCowAC33vhYPOxqvydRAA--.29170S2;
	Thu, 05 Nov 2026 16:20:40 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v2 2/8] riscv: Add ACPI support for CPU initialization
Date: Thu,  5 Nov 2026 16:20:29 +0800
Message-ID: <20261105082035.133680-3-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAC33vhYPOxqvydRAA--.29170S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyxXr13Xw18uw4UJF47Arb_yoWrXry3pF
	yqg3yrJrW5uFWSq3sxJFyUJw1fJF4Syr1xXrs3G34fXF47GryDXFWkt34Utr9xXay8Way3
	Zan5Kry8ua13Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

When a DT is not provided, discover harts from the MADT RINTC
subtables (ACPI 6.6 type 24) instead of aborting in cpu_init_acpi().

Parse each RINTC entry for hart_id and ACPI UID, record them in
thread_info, and mark the CPU present only if it is Enabled in
the RINTC flags and SBI reports the hart as available.

Also add the RINTC MADT structure and the MADT types introduced
after GENERIC_TRANSLATOR so the RISC-V interrupt controller
entries can be identified.

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 lib/acpi.h                | 27 ++++++++++++++++++++++++++-
 lib/riscv/asm/processor.h |  1 +
 lib/riscv/setup.c         | 28 +++++++++++++++++++++++++++-
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/lib/acpi.h b/lib/acpi.h
index a62cd3a9..f6c92d28 100644
--- a/lib/acpi.h
+++ b/lib/acpi.h
@@ -226,6 +226,19 @@ struct acpi_madt_generic_translator {
 	u32 reserved2;
 };
 
+/* 24: RISC-V Interrupt Controller (RINTC) Structure (ACPI 6.6) */
+struct acpi_madt_rintc {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 reserved;		/* reserved - must be zero */
+	u32 flags;
+	u64 hart_id;
+	u32 uid;
+	u32 ext_intc_id;
+	u64 imsic_addr;
+	u32 imsic_size;
+};
+
 /* Values for MADT subtable type in struct acpi_subtable_header */
 
 enum acpi_madt_type {
@@ -245,7 +258,19 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_GENERIC_MSI_FRAME = 13,
 	ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR = 14,
 	ACPI_MADT_TYPE_GENERIC_TRANSLATOR = 15,
-	ACPI_MADT_TYPE_RESERVED = 16	/* 16 and greater are reserved */
+	ACPI_MADT_TYPE_MULTIPROC_WAKEUP = 16,
+	ACPI_MADT_TYPE_CORE_PIC = 17,
+	ACPI_MADT_TYPE_LIO_PIC = 18,
+	ACPI_MADT_TYPE_HT_PIC = 19,
+	ACPI_MADT_TYPE_EIO_PIC = 20,
+	ACPI_MADT_TYPE_MSI_PIC = 21,
+	ACPI_MADT_TYPE_BIO_PIC = 22,
+	ACPI_MADT_TYPE_LPC_PIC = 23,
+	ACPI_MADT_TYPE_RINTC = 24,
+	ACPI_MADT_TYPE_IMSIC = 25,
+	ACPI_MADT_TYPE_APLIC = 26,
+	ACPI_MADT_TYPE_PLIC = 27,
+	ACPI_MADT_TYPE_RESERVED = 28	/* 28 and greater are reserved */
 };
 
 /* MADT Local APIC flags */
diff --git a/lib/riscv/asm/processor.h b/lib/riscv/asm/processor.h
index a3dab064..5a1df355 100644
--- a/lib/riscv/asm/processor.h
+++ b/lib/riscv/asm/processor.h
@@ -14,6 +14,7 @@ typedef void (*exception_fn)(struct pt_regs *);
 struct thread_info {
 	int cpu;
 	unsigned long hartid;
+	unsigned long uid;
 	unsigned long isa[1];
 	unsigned long sp;
 	exception_fn exception_handlers[EXCEPTION_CAUSE_MAX];
diff --git a/lib/riscv/setup.c b/lib/riscv/setup.c
index 8c22120d..f1121573 100644
--- a/lib/riscv/setup.c
+++ b/lib/riscv/setup.c
@@ -48,6 +48,29 @@ uint64_t timebase_frequency;
 
 static struct mem_region riscv_mem_regions[NR_MEM_REGIONS + 1];
 
+#ifdef CONFIG_EFI
+#include <acpi.h>
+
+static int cpu_set_acpi(struct acpi_subtable_header *header)
+{
+	int cpu = nr_cpus++;
+	struct acpi_madt_rintc *intc = (void *)header;
+
+	assert_msg(cpu < NR_CPUS, "Number cpus exceeds maximum supported (%d).", NR_CPUS);
+
+	cpus[cpu].cpu = cpu;
+	cpus[cpu].hartid = intc->hart_id;
+	cpus[cpu].uid = intc->uid;
+
+	if (intc->flags & ACPI_MADT_ENABLED) {
+		if (!sbi_hart_get_status(cpus[cpu].hartid).error)
+			set_cpu_present(cpu, true);
+	}
+
+	return 0;
+}
+#endif
+
 static void cpu_set_fdt(int fdtnode __unused, u64 regval, void *info __unused)
 {
 	int cpu = nr_cpus++;
@@ -63,7 +86,11 @@ static void cpu_set_fdt(int fdtnode __unused, u64 regval, void *info __unused)
 
 static void cpu_init_acpi(void)
 {
+#ifdef CONFIG_EFI
+	acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, cpu_set_acpi);
+#else
 	assert_msg(false, "ACPI not available");
+#endif
 }
 
 static void cpu_init(void)
@@ -226,7 +253,6 @@ void setup(const void *fdt, phys_addr_t freemem_start)
 
 #ifdef CONFIG_EFI
 #include <efi.h>
-#include <acpi.h>
 
 extern unsigned long exception_vectors;
 extern unsigned long boot_hartid;
-- 
2.47.3

