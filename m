Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866858;
	b=qVe8amP/oKaPj4W7vfiuNGQ40asX+Reijgwo0uRw6Yi8GyKsieg3DWOeS0qfPjcKLZQu
	 Ex8KJvVRj9uj6lSpN+3lAkpBuJFvBjB/D/s/g5P3w1pEXYh9E7ZdhyKwJEdAp10f1ydSx
	 43mrq+avBA+Mrbfi72v9cRM7snOXLicLVtdZwgDtvDQ5fNhe6DkK2Lg8OL2dadp5h/PeW
	 3oSib21ejBEKUp5ESUG9+ZtjC0gSjjOsSiXgfxZpw1tLVwFLrhFCcJl0H4QJSOmrLk+ZA
	 z0fAQ7fq+8haEHkq/B8zfdIdEuAVJOzjUlsNYADrIe8bpXtC+M4g1cUk8UjwZsnjfgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866858;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=8zJPGLiq9NwOVCu5eNMc9T8weiHjCvGYK47vX4y33fk=;
	b=YpiNhQq6uO0+4TXMRyx2AVOIvfR1f0s+Ko1mRCjmpUqadgS9av9XHRbGsnuOc61FCl0g
	 9lCQeu4K4Ilp0OrGHhAZonVu3XjAz6d9ElW5ODa+EUVT1Mc4nL1j2d3DllhGiK38Snip+
	 ySpG/Tt3c3iyhRgHBegVTJh5A8yWTXx9HB1dgnRxK1bIgxZaY4ukE4MKJuceQkCg64TR0
	 j5hN9XjySQed5ywfTYfIq1dwE4HQR9EMjKRkIv/VQK9qyuRgv6sE7O++i3aBz61W5Grjl
	 NZZPsf9YhEywkKHokqrq5moZRQ5utgPANsebBSyZdWdnJWtS2N9YBJtfVjMBNKU9g9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59414606A328
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 08:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59414606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.204])
	by APP-01 (Coremail) with SMTP id qwCowABnVf9bPOxq_CdRAA--.2987S2;
	Thu, 05 Nov 2026 16:20:43 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v2 8/8] riscv: Add BRS SBI requirement tests
Date: Thu,  5 Nov 2026 16:20:35 +0800
Message-ID: <20261105082035.133680-9-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:qwCowABnVf9bPOxq_CdRAA--.2987S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gry5tFWxWw47Jw43CFWrAFb_yoWftF1DpF
	WkGF90kryrJa4xA39ayF1DGw1ayr1rWr1vgrykC34rKw42qrW5Xr1vk34Fyr4rWFWrG3y3
	uan3GFZ8uFsrWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUUMKZJUUUUU==
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

Add a riscv-brs unit test for the SBI rules in the RISC-V Boot and
Runtime Services specification:

  SBI_010  spec version must be v2.0 or later
  SBI_020  HSM must be implemented
  SBI_030  TIME is required unless Sstc is present
  SBI_040  IPI is required unless IMSIC is present
  SBI_050  RFENCE is required unless IMSIC is present
  SBI_060  PMU is required unless Sscsrind and Ssccfg are all present
  SBI_070  DBCN is required when ACPI SPCR Interface Type is 0x15

Parse the extra ISA names used as skip conditions, and add the RFNC
and PMU extension IDs needed to probe those extensions.

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 lib/riscv/asm/isa.h |   3 +
 lib/riscv/asm/sbi.h |   2 +
 lib/riscv/isa.c     |  12 +-
 riscv/Makefile      |   1 +
 riscv/riscv-brs.c   | 265 ++++++++++++++++++++++++++++++++++++++++++++
 riscv/unittests.cfg |   4 +
 6 files changed, 285 insertions(+), 2 deletions(-)
 create mode 100644 riscv/riscv-brs.c

diff --git a/lib/riscv/asm/isa.h b/lib/riscv/asm/isa.h
index fb3af67d..6516c869 100644
--- a/lib/riscv/asm/isa.h
+++ b/lib/riscv/asm/isa.h
@@ -13,6 +13,9 @@
  * by name not tracked here with cpu_has_extension_name()
  */
 enum {
+	ISA_SSAIA,
+	ISA_SSCCFG,
+	ISA_SSCSRIND,
 	ISA_SSTC,
 	ISA_MAX,
 };
diff --git a/lib/riscv/asm/sbi.h b/lib/riscv/asm/sbi.h
index 289a6a24..c92a66dc 100644
--- a/lib/riscv/asm/sbi.h
+++ b/lib/riscv/asm/sbi.h
@@ -45,8 +45,10 @@ enum sbi_ext_id {
 	SBI_EXT_BASE = 0x10,
 	SBI_EXT_TIME = 0x54494d45,
 	SBI_EXT_IPI = 0x735049,
+	SBI_EXT_RFNC = 0x52464E43,
 	SBI_EXT_HSM = 0x48534d,
 	SBI_EXT_SRST = 0x53525354,
+	SBI_EXT_PMU = 0x504D55,
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_SUSP = 0x53555350,
 	SBI_EXT_FWFT = 0x46574654,
diff --git a/lib/riscv/isa.c b/lib/riscv/isa.c
index 91c7302c..6aa27948 100644
--- a/lib/riscv/isa.c
+++ b/lib/riscv/isa.c
@@ -39,8 +39,16 @@ static void isa_bit(const char *name, int len, void *data)
 {
 	struct thread_info *info = (struct thread_info *)data;
 
-	if (isa_match("sstc", name, len))
-		set_bit(ISA_SSTC, info->isa);
+#define ISA_MATCH_AND_SET(ext) \
+	if (isa_match(#ext, name, len)) \
+		set_bit(ISA_##ext, info->isa)
+
+	ISA_MATCH_AND_SET(SSAIA);
+	ISA_MATCH_AND_SET(SSCCFG);
+	ISA_MATCH_AND_SET(SSCSRIND);
+	ISA_MATCH_AND_SET(SSTC);
+
+#undef ISA_MATCH_AND_SET
 }
 
 static void isa_parse(const char *isa_string, int len, struct isa_info *info)
diff --git a/riscv/Makefile b/riscv/Makefile
index 348a30a7..7da7526f 100644
--- a/riscv/Makefile
+++ b/riscv/Makefile
@@ -15,6 +15,7 @@ tests += $(TEST_DIR)/sbi.$(exe)
 tests += $(TEST_DIR)/selftest.$(exe)
 tests += $(TEST_DIR)/sieve.$(exe)
 tests += $(TEST_DIR)/isa-dbltrp.$(exe)
+tests += $(TEST_DIR)/riscv-brs.$(exe)
 
 all: $(tests)
 
diff --git a/riscv/riscv-brs.c b/riscv/riscv-brs.c
new file mode 100644
index 00000000..2813fa73
--- /dev/null
+++ b/riscv/riscv-brs.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  RISC-V BRS SBI requirement tests
+ *
+ * Copyright (C) 2026, Institute of Software, CAS., Xiang W <wangxiang@iscas.ac.cn>
+ */
+
+#include <libcflat.h>
+#include <devicetree.h>
+#include <asm/sbi.h>
+#include <asm/isa.h>
+#include <asm/smp.h>
+
+#ifdef CONFIG_EFI
+#include <acpi.h>
+#endif
+
+static void check_sbi_010(void)
+{
+	struct sbiret ret;
+	unsigned long major, minor;
+
+	report_prefix_push("SBI_010");
+
+	ret = sbi_get_spec_version();
+	if (ret.error)
+		report_fail("sbi_get_spec_version failed with %ld", ret.error);
+	else {
+		major = ret.value >> SBI_SPEC_VERSION_MAJOR_SHIFT;
+		major = major & SBI_SPEC_VERSION_MAJOR_MASK;
+		minor = ret.value & SBI_SPEC_VERSION_MINOR_MASK;
+
+		report(ret.value >= sbi_mk_version(2, 0),
+			"SBI spec version is v2.0 or later (current %lu.%lu)", major, minor);
+	}
+
+	report_prefix_pop();
+}
+
+static void check_sbi_020(void)
+{
+	report_prefix_push("SBI_020");
+	report(sbi_probe(SBI_EXT_HSM), "HSM extension is implemented");
+	report_prefix_pop();
+}
+
+static void check_sbi_030(void)
+{
+	report_prefix_push("SBI_030");
+
+	if (cpu_has_extension(smp_processor_id(), ISA_SSTC))
+		report_skip("Sstc is present, TIME is not mandated");
+	else
+		report(sbi_probe(SBI_EXT_TIME), "TIME extension is implemented");
+
+	report_prefix_pop();
+}
+
+#define IMSIC_SLEVEL_IRQ	9
+static bool hart_has_imsic[NR_CPUS];
+
+#ifdef CONFIG_EFI
+static int acpi_collect_imsic(struct acpi_subtable_header *header)
+{
+	struct acpi_madt_rintc *rintc = (void *)header;
+	int cpu;
+
+	if (!rintc->imsic_size)
+		return 0;
+
+	cpu = hartid_to_cpu(rintc->hart_id);
+	if (cpu >= 0 && cpu < nr_cpus)
+		hart_has_imsic[cpu] = true;
+
+	return 0;
+}
+#endif
+
+static int dt_intc_phandle_to_cpu(const void *fdt, uint32_t phandle)
+{
+	int intc_node, cpu_node, cpus_node, ret, i;
+	struct dt_reg raw_reg;
+	u32 nac, nsc;
+	u64 hartid;
+
+	intc_node = fdt_node_offset_by_phandle(fdt, phandle);
+	if (intc_node < 0)
+		return -1;
+
+	/* cpu-intc -> cpu node -> /cpus */
+	cpu_node = fdt_parent_offset(fdt, intc_node);
+	if (cpu_node < 0)
+		return -1;
+
+	cpus_node = fdt_parent_offset(fdt, cpu_node);
+	if (cpus_node < 0)
+		return -1;
+
+	/* #address-cells / #size-cells live on /cpus, not on the cpu node */
+	ret = dt_get_nr_cells(cpus_node, &nac, &nsc);
+	if (ret < 0)
+		return -1;
+
+	dt_reg_init(&raw_reg, nac, nsc);
+	ret = dt_get_reg(cpu_node, 0, &raw_reg);
+	if (ret < 0)
+		return -1;
+
+	hartid = raw_reg.address_cells[0];
+	if (nac == 2)
+		hartid = (hartid << 32) | raw_reg.address_cells[1];
+
+	for (i = 0; i < nr_cpus; i++) {
+		if (cpus[i].hartid == hartid)
+			return i;
+	}
+	return -1;
+}
+
+static void dt_collect_imsic(void)
+{
+	const void *fdt = dt_fdt();
+	const fdt32_t *prop;
+	int node, len, ncells, i, cpu;
+	uint32_t phandle, irq;
+
+	node = -1;
+	while ((node = fdt_node_offset_by_compatible(fdt, node, "riscv,imsics")) >= 0) {
+		prop = fdt_getprop(fdt, node, "interrupts-extended", &len);
+		if (!prop || len < 0)
+			continue;
+
+		/* Each entry is <phandle irq>  (cpu-intc #interrupt-cells = 1) */
+		ncells = len / (int)sizeof(fdt32_t);
+		for (i = 0; i + 1 < ncells; i += 2) {
+			phandle = fdt32_to_cpu(prop[i]);
+			irq = fdt32_to_cpu(prop[i + 1]);
+
+			if (irq != IMSIC_SLEVEL_IRQ)
+				continue;
+
+			cpu = dt_intc_phandle_to_cpu(fdt, phandle);
+			if (cpu >= 0 && cpu < nr_cpus)
+				hart_has_imsic[cpu] = true;
+		}
+	}
+}
+
+static bool all_harts_have_imsic(void)
+{
+	int cpu;
+
+	memset(hart_has_imsic, 0, sizeof(hart_has_imsic));
+
+	if (dt_available())
+		dt_collect_imsic();
+#ifdef CONFIG_EFI
+	else
+		acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_collect_imsic);
+#endif
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		if (!cpu_present(cpu))
+			continue;
+		if (!cpu_has_extension(cpu, ISA_SSAIA)) {
+			report_info("CPU %d (hartid %lu) has no Ssaia",
+				    cpu, cpus[cpu].hartid);
+			return false;
+		}
+		if (!hart_has_imsic[cpu]) {
+			report_info("CPU %d (hartid %lu) has no S-level IMSIC",
+				    cpu, cpus[cpu].hartid);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static void check_sbi_040(void)
+{
+	report_prefix_push("SBI_040");
+
+	if (all_harts_have_imsic())
+		report_skip("IMSIC is present, IPI is not mandated");
+	else
+		report(sbi_probe(SBI_EXT_IPI), "IPI extension is implemented");
+
+	report_prefix_pop();
+}
+
+static void check_sbi_050(void)
+{
+	report_prefix_push("SBI_050");
+
+	if (all_harts_have_imsic())
+		report_skip("IMSIC is present, RFENCE is not mandated");
+	else
+		report(sbi_probe(SBI_EXT_RFNC), "RFENCE extension is implemented");
+
+	report_prefix_pop();
+}
+
+static void check_sbi_060(void)
+{
+	int cpu = smp_processor_id();
+
+	report_prefix_push("SBI_060");
+
+	if (cpu_has_extension(cpu, ISA_SSCSRIND) && cpu_has_extension(cpu, ISA_SSCCFG))
+		/*
+		 * TODO: OE_SBI_060_010 also requires Smcsrind and Smcdeleg,
+		 * but they are M-mode extensions and not present in the S-mode
+		 * ISA string (DT or RHCT). Revisit if BRS clarifies how to detect them.
+		 */
+		report_skip("Sscsrind and Ssccfg are present, PMU is not mandated");
+	else
+		report(sbi_probe(SBI_EXT_PMU), "PMU extension is implemented");
+
+	report_prefix_pop();
+}
+
+static void check_sbi_070(void)
+{
+	report_prefix_push("SBI_070");
+
+	if (dt_available())
+		report_skip("ACPI not available, DBCN is not mandated");
+	else {
+#ifdef CONFIG_EFI
+		struct spcr_descriptor *spcr;
+
+		spcr = find_acpi_table_addr(SPCR_SIGNATURE);
+		if (spcr == NULL)
+			report_skip("SPCR is not present, DBCN is not mandated");
+		else {
+			if (spcr->interface_type == 0x15)
+				report(sbi_probe(SBI_EXT_DBCN), "DBCN extension is implemented");
+			else
+				report_skip(
+					"SPCR interface type is %#x (not 0x15), DBCN is not mandated",
+					spcr->interface_type);
+		}
+#else
+		report_skip("ACPI not available, DBCN is not mandated");
+#endif
+	}
+
+	report_prefix_pop();
+}
+
+int main(int argc, char **argv)
+{
+	report_prefix_push("riscv-brs");
+
+	check_sbi_010();
+	check_sbi_020();
+	check_sbi_030();
+	check_sbi_040();
+	check_sbi_050();
+	check_sbi_060();
+	check_sbi_070();
+
+	return report_summary();
+}
diff --git a/riscv/unittests.cfg b/riscv/unittests.cfg
index 9e9f58d9..990f03db 100644
--- a/riscv/unittests.cfg
+++ b/riscv/unittests.cfg
@@ -22,3 +22,7 @@ groups = sbi
 [dbltrp]
 file = isa-dbltrp.flat
 groups = isa sbi
+
+[riscv-brs]
+file = riscv-brs.flat
+groups = riscv-brs nodefault
-- 
2.47.3

