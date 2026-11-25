Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795571078;
	b=XoA/g45lWhbsl2EBrJ8Lc5TYel9ZIOo454xNRU/RgjPRWodJzRnK3h/FyaiCqg5ueo4g
	 NKQiO02/Rtah/yAEY3aXpRTM0lsVsMZxXQLyIAWMZEX7BoD0haC45ZBgT3kgROOpkLn7s
	 zkDMIB2VupzNVXrAEXI6VMPgS6V6rdWTph4r6k6HchJTzw05VOtEMX2u49RYcniaSxRPT
	 gQ0AaeQK6DmRC43HXY38LVurrQRMjYtqGhrEsiQ3xmx5Q5XOeanVlyTdTBjbnRk0iKLpR
	 D4+1eIgY5DAqsY4x6fy+SCLLqlbB612bfOt1gxLL0X5eqmOSPfo3mlumXYgFWwGU0Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571078;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=WVBecoOToF5qO/iCHUP6JTXCYBb7MEy9S8KZ+Qc9a6o=;
	b=cum9q78vpTld76Ve0+5766jPEsaslxHaKFjBcw4S+f52JX457zQtQ2dSlXcHyh0diUzR
	 MRbZC/QDQB6iri+sJpoHJWzoEg2KR4O84XauIBggbQr7moYpVDICFZvC/R1Zbmi7XQ9rp
	 yoJbgBSpGcX4XfOf6TpAeIT6VTLk6kAcYrs57ddN9Vcg9YtOzRtSH1BtuIj3q+wlwo062
	 FKwYPicoZFGYgcrRtPFBA30JUU7usy2bJ/3yso4YOJrIY67ur515oU3ie+i9xdcdS3M7q
	 dlqfzomnDMqNDeOy3SBMS7KASKRpzs7ChPSWapPyPKmt7WQSyI6xziqmGETgwZys1KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305C3606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 01:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 305C3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.240])
	by APP-03 (Coremail) with SMTP id rQCowAB3gJF8PQZr2tm8AQ--.22634S2;
	Wed, 25 Nov 2026 09:44:29 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v3 8/9] riscv: Capture IMSIC addresses at boot time
Date: Wed, 25 Nov 2026 09:44:08 +0800
Message-ID: <20261125014409.79852-9-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAB3gJF8PQZr2tm8AQ--.22634S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtrWUur17Cr47Kr1rGw1rWFg_yoWxJFy5pF
	W5C3W5CrZ8CF4xW39avF1Dt34fKFnYkr17KrWxZ3yrZw4DJr95Xr4kK34vyF9xJayUZa13
	uaykKFWYkr42qaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjb_-PUUUUU==
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

Tests may want to use the IMSICs for MSIs and the upcoming BRS tests
want to confirm IMSICs are present. Provide those tests the S-mode
interrupt file addresses at boot time. Parse DT IMSIC nodes from
cpu_set_fdt() via imsic_init(). On ACPI, copy imsic_addr from the
MADT RINTC entry only when an IMSIC structure is present; ACPI
requires OSPM to ignore RINTC.imsic_addr otherwise.

Co-authored-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 lib/riscv/asm/imsic.h     |  8 ++++
 lib/riscv/asm/processor.h |  1 +
 lib/riscv/imsic.c         | 86 +++++++++++++++++++++++++++++++++++++++
 lib/riscv/setup.c         | 13 ++++++
 riscv/Makefile            |  1 +
 5 files changed, 109 insertions(+)
 create mode 100644 lib/riscv/asm/imsic.h
 create mode 100644 lib/riscv/imsic.c

diff --git a/lib/riscv/asm/imsic.h b/lib/riscv/asm/imsic.h
new file mode 100644
index 00000000..c011b106
--- /dev/null
+++ b/lib/riscv/asm/imsic.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASMRISCV_IMSIC_H_
+#define _ASMRISCV_IMSIC_H_
+#include <asm/processor.h>
+
+void imsic_init(struct thread_info *ti);
+
+#endif /* _ASMRISCV_IMSIC_H_ */
diff --git a/lib/riscv/asm/processor.h b/lib/riscv/asm/processor.h
index 5a1df355..fa0c7356 100644
--- a/lib/riscv/asm/processor.h
+++ b/lib/riscv/asm/processor.h
@@ -16,6 +16,7 @@ struct thread_info {
 	unsigned long hartid;
 	unsigned long uid;
 	unsigned long isa[1];
+	phys_addr_t imsic_pa;		/* S-level interrupt file, INVALID_PHYS_ADDR if none */
 	unsigned long sp;
 	exception_fn exception_handlers[EXCEPTION_CAUSE_MAX];
 	exception_fn interrupt_handlers[INTERRUPT_CAUSE_MAX];
diff --git a/lib/riscv/imsic.c b/lib/riscv/imsic.c
new file mode 100644
index 00000000..38665c10
--- /dev/null
+++ b/lib/riscv/imsic.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IMSIC support
+ */
+#include <libcflat.h>
+#include <bitops.h>
+#include <devicetree.h>
+#include <asm/imsic.h>
+#include <asm/processor.h>
+
+struct imsic_info {
+	unsigned long hartid;
+	phys_addr_t imsic_pa;
+};
+
+static void imsic_parse_fdt(int cpu_node, u64 hartid, void *data)
+{
+	struct imsic_info *info = (struct imsic_info *)data;
+	const void *fdt = dt_fdt();
+	int intc, node = -1;
+	u32 phandle;
+
+	if (info->hartid != hartid)
+		return;
+
+	info->imsic_pa = INVALID_PHYS_ADDR;
+
+	intc = fdt_subnode_offset(fdt, cpu_node, "interrupt-controller");
+	if (intc < 0)
+		return;
+
+	phandle = fdt_get_phandle(fdt, intc);
+
+	while ((node = fdt_node_offset_by_compatible(fdt, node, "riscv,imsics")) >= 0) {
+		struct dt_pbus_reg reg;
+		const fdt32_t *prop;
+		u64 stride, off;
+		u32 guest_bits;
+		int len, i;
+
+		prop = fdt_getprop(fdt, node, "interrupts-extended", &len);
+		if (!prop)
+			continue;
+
+		/* <phandle irq> pairs, since cpu-intc has #interrupt-cells = 1 */
+		for (i = 0; i + 1 < len / (int)sizeof(fdt32_t); i += 2) {
+			if (fdt32_to_cpu(prop[i]) == phandle &&
+			    fdt32_to_cpu(prop[i + 1]) == IRQ_S_EXT)
+				break;
+		}
+		if (i + 1 >= len / (int)sizeof(fdt32_t))
+			continue;
+
+		prop = fdt_getprop(fdt, node, "riscv,guest-index-bits", &len);
+		guest_bits = prop && len == sizeof(fdt32_t) ? fdt32_to_cpu(*prop) : 0;
+		stride = BIT_ULL(guest_bits) * SZ_4K;
+		off = (i / 2) * stride;
+
+		for (i = 0; dt_pbus_translate_node(node, i, &reg) == 0; i++) {
+			if (off < reg.size) {
+				assert(reg.size - off >= SZ_4K);
+				info->imsic_pa = reg.addr + off;
+				return;
+			}
+			off -= ALIGN(reg.size, stride);
+		}
+		assert_msg(false, "IMSIC interrupt file beyond reg regions");
+	}
+}
+
+void imsic_init(struct thread_info *ti)
+{
+	struct imsic_info info = {
+		.hartid = ti->hartid,
+	};
+	int ret;
+
+	if (dt_available()) {
+		ret = dt_for_each_cpu_node(imsic_parse_fdt, &info);
+		assert(ret == 0);
+	} else {
+		assert_msg(false, "ACPI not available");
+	}
+
+	ti->imsic_pa = info.imsic_pa;
+}
diff --git a/lib/riscv/setup.c b/lib/riscv/setup.c
index 547851f5..e9563ad4 100644
--- a/lib/riscv/setup.c
+++ b/lib/riscv/setup.c
@@ -16,6 +16,7 @@
 #include <on-cpus.h>
 #include <vmalloc.h>
 #include <asm/csr.h>
+#include <asm/imsic.h>
 #include <asm/isa.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
@@ -52,6 +53,14 @@ static struct mem_region riscv_mem_regions[NR_MEM_REGIONS + 1];
 #ifdef CONFIG_EFI
 #include <acpi.h>
 
+static bool has_imsic = false;
+
+static int acpi_find_imsic(struct acpi_subtable_header *header)
+{
+	has_imsic = true;
+	return 0;
+}
+
 static int cpu_set_acpi(struct acpi_subtable_header *header)
 {
 	int cpu = nr_cpus++;
@@ -62,6 +71,8 @@ static int cpu_set_acpi(struct acpi_subtable_header *header)
 	cpus[cpu].cpu = cpu;
 	cpus[cpu].hartid = intc->hart_id;
 	cpus[cpu].uid = intc->uid;
+	/* RINTC.imsic_addr is ignored unless an IMSIC MADT structure is present. */
+	cpus[cpu].imsic_pa = has_imsic ? intc->imsic_addr : INVALID_PHYS_ADDR;
 	isa_init(&cpus[cpu]);
 
 	if (intc->flags & ACPI_MADT_ENABLED) {
@@ -81,6 +92,7 @@ static void cpu_set_fdt(int fdtnode __unused, u64 regval, void *info __unused)
 
 	cpus[cpu].cpu = cpu;
 	cpus[cpu].hartid = regval;
+	imsic_init(&cpus[cpu]);
 	isa_init(&cpus[cpu]);
 
 	if (!sbi_hart_get_status(cpus[cpu].hartid).error)
@@ -90,6 +102,7 @@ static void cpu_set_fdt(int fdtnode __unused, u64 regval, void *info __unused)
 static void cpu_init_acpi(void)
 {
 #ifdef CONFIG_EFI
+	acpi_table_parse_madt(ACPI_MADT_TYPE_IMSIC, acpi_find_imsic);
 	acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, cpu_set_acpi);
 #else
 	assert_msg(false, "ACPI not available");
diff --git a/riscv/Makefile b/riscv/Makefile
index 348a30a7..f90992ab 100644
--- a/riscv/Makefile
+++ b/riscv/Makefile
@@ -39,6 +39,7 @@ cflatobjs += lib/on-cpus.o
 cflatobjs += lib/vmalloc.o
 cflatobjs += lib/riscv/bitops.o
 cflatobjs += lib/riscv/delay.o
+cflatobjs += lib/riscv/imsic.o
 cflatobjs += lib/riscv/io.o
 cflatobjs += lib/riscv/isa.o
 cflatobjs += lib/riscv/mmu.o
-- 
2.47.3

