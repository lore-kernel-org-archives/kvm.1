Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96C318ED2
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 03:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221207; cv=none; b=WRmRQU3dyYpmaXEpbzlXAOXyi5HJ6sOcZq3kXD4yCsKABLw1la5K0dcKIR4kneWNzqJZ4qnFvIr3tpAlXYvSxkEidp+mt8LroiuENR4EHdLktl/5d1FROti7BKdKx/Dw8L62vKimcMSgHkMwDbXnfn7/lWt0Nx4rVDmoPrTf2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221207; c=relaxed/simple;
	bh=uZciejCL5QocPtyjj1oWPKyaBQtaGbNz/cNwd3//vPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XowMFBh6C1s72tFbtpJjr6srHOwzE3swCYgHIgFSO9y0I6Q4JBCJY1tjP/iW0ygDMI9RMVTtlWqrOjY7gxd4efqQTZbIVrPNpeNuE4DOq68MBAzsIMyAQOsIgzoASmzk7X4cZn4UtnMCCVBla0pI62EunFB7f2BXhh0cT5rg7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.201])
	by APP-01 (Coremail) with SMTP id qwCowAD3zPCIm7RqIk_JCA--.1087S2;
	Thu, 24 Sep 2026 11:39:53 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	pbonzini@redhat.com,
	thuth@redhat.com,
	Xiang W <wangxiang@iscas.ac.cn>
Subject: [kvm-unit-tests PATCH 7/7] riscv: Add BRS SBI requirement tests
Date: Thu, 24 Sep 2026 11:39:45 +0800
Message-ID: <20260924033945.176581-8-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAD3zPCIm7RqIk_JCA--.1087S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry8CFy5XrWDtFyUtrWrXwb_yoW3Xr4kpr
	ykCr98K3s8Ka4xAwn3AF1DGrn8tr1FgwnFgr4DCw1Fga17trWUWFs5t34avr45XFWrGr9x
	C3Z3GFZ5ZFnrW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUb2-nUUUUU=
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

Add a riscv-brs unit test for the SBI rules in the RISC-V Boot and
Runtime Services specification:

  SBI_010  spec version must be v2.0 or later
  SBI_020  HSM must be implemented
  SBI_030  TIME is required unless Sstc is present
  SBI_040  IPI is required unless Ssaia is present
  SBI_050  RFENCE is required unless Ssaia is present
  SBI_060  PMU is required unless Smcsrind, Sscsrind, Smcdeleg
           and Ssccfg are all present
  SBI_070  DBCN is required when ACPI SPCR Interface Type is 0x15

Parse the extra ISA names used as skip conditions, and add the RFNC
and PMU extension IDs needed to probe those extensions.

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 lib/riscv/asm/isa.h |   5 ++
 lib/riscv/asm/sbi.h |   2 +
 lib/riscv/isa.c     |  14 +++-
 riscv/Makefile      |   1 +
 riscv/riscv-brs.c   | 171 ++++++++++++++++++++++++++++++++++++++++++++
 riscv/unittests.cfg |   4 ++
 6 files changed, 195 insertions(+), 2 deletions(-)
 create mode 100644 riscv/riscv-brs.c

diff --git a/lib/riscv/asm/isa.h b/lib/riscv/asm/isa.h
index fb3af67d..8a124881 100644
--- a/lib/riscv/asm/isa.h
+++ b/lib/riscv/asm/isa.h
@@ -13,7 +13,12 @@
  * by name not tracked here with cpu_has_extension_name()
  */
 enum {
+	ISA_SMCDELEG,
+	ISA_SMCSRIND,
+	ISA_SSAIA,
+	ISA_SSCCFG,
 	ISA_SSTC,
+	ISA_SSCSRIND,
 	ISA_MAX,
 };
 __static_assert(ISA_MAX <= __riscv_xlen, "Need to increase thread_info.isa");
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
index b0257979..f5e2a61b 100644
--- a/lib/riscv/isa.c
+++ b/lib/riscv/isa.c
@@ -39,8 +39,18 @@ static void isa_bit(const char *name, int len, void *data)
 {
 	struct thread_info *info = (struct thread_info *)data;
 
-	if (isa_match("sstc", name, len))
-		set_bit(ISA_SSTC, info->isa);
+#define ISA_MATCH_AND_SET(ext) \
+	if (isa_match(#ext, name, len)) \
+		set_bit(ISA_##ext, info->isa)
+
+	ISA_MATCH_AND_SET(SMCDELEG);
+	ISA_MATCH_AND_SET(SMCSRIND);
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
index 00000000..0d4a8f47
--- /dev/null
+++ b/riscv/riscv-brs.c
@@ -0,0 +1,171 @@
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
+
+	report_prefix_push("SBI_010");
+
+	ret = sbi_get_spec_version();
+	if (ret.error) {
+		report_fail("sbi_get_spec_version failed with %ld", ret.error);
+		report_prefix_pop();
+		return;
+	}
+
+	report_info("SBI spec version %lu.%lu",
+		    (ret.value >> SBI_SPEC_VERSION_MAJOR_SHIFT) &
+		    SBI_SPEC_VERSION_MAJOR_MASK,
+		    ret.value & SBI_SPEC_VERSION_MINOR_MASK);
+
+	report(ret.value >= sbi_mk_version(2, 0),
+	       "SBI spec version is v2.0 or later");
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
+	if (cpu_has_extension(smp_processor_id(), ISA_SSTC)) {
+		report_skip("Sstc is present, TIME is not mandated");
+		report_prefix_pop();
+		return;
+	}
+
+	report(sbi_probe(SBI_EXT_TIME), "TIME extension is implemented");
+	report_prefix_pop();
+}
+
+static void check_sbi_040(void)
+{
+	report_prefix_push("SBI_040");
+
+	if (cpu_has_extension(smp_processor_id(), ISA_SSAIA)) {
+		report_skip("Ssaia is present, IPI is not mandated");
+		report_prefix_pop();
+		return;
+	}
+
+	report(sbi_probe(SBI_EXT_IPI), "IPI extension is implemented");
+	report_prefix_pop();
+}
+
+static void check_sbi_050(void)
+{
+	report_prefix_push("SBI_050");
+
+	if (cpu_has_extension(smp_processor_id(), ISA_SSAIA)) {
+		report_skip("Ssaia is present, RFENCE is not mandated");
+		report_prefix_pop();
+		return;
+	}
+
+	report(sbi_probe(SBI_EXT_RFNC), "RFENCE extension is implemented");
+	report_prefix_pop();
+}
+
+static void check_sbi_060(void)
+{
+	int cpu = smp_processor_id();
+	bool skip = true;
+	bool has_ext;
+
+	report_prefix_push("SBI_060");
+
+	has_ext = cpu_has_extension(cpu, ISA_SMCSRIND);
+	if (!has_ext)
+		report_info("Smcsrind is not present");
+	skip &= has_ext;
+
+	has_ext = cpu_has_extension(cpu, ISA_SSCSRIND);
+	if (!has_ext)
+		report_info("Sscsrind is not present");
+	skip &= has_ext;
+
+	has_ext = cpu_has_extension(cpu, ISA_SMCDELEG);
+	if (!has_ext)
+		report_info("Smcdeleg is not present");
+	skip &= has_ext;
+
+	has_ext = cpu_has_extension(cpu, ISA_SSCCFG);
+	if (!has_ext)
+		report_info("Ssccfg is not present");
+	skip &= has_ext;
+
+	if (skip) {
+		report_skip("Smcsrind, Sscsrind, Smcdeleg and Ssccfg are present, PMU is not mandated");
+		report_prefix_pop();
+		return;
+	}
+
+	report(sbi_probe(SBI_EXT_PMU), "PMU extension is implemented");
+	report_prefix_pop();
+}
+
+static void check_sbi_070(void)
+{
+	report_prefix_push("SBI_070");
+
+#ifdef CONFIG_EFI
+	if (!dt_available()) {
+		struct spcr_descriptor *spcr;
+
+		spcr = find_acpi_table_addr(SPCR_SIGNATURE);
+		if (spcr) {
+			report_info("SPCR interface type is %#x", spcr->interface_type);
+			if (spcr->interface_type == 0x15) {
+				report(sbi_probe(SBI_EXT_DBCN), "DBCN extension is implemented");
+				report_prefix_pop();
+				return;
+			}
+			report_skip("SPCR interface type is not 0x15, DBCN is not mandated");
+			report_prefix_pop();
+			return;
+		}
+		report_skip("SPCR is not present, DBCN is not mandated");
+		report_prefix_pop();
+		return;
+	}
+#endif
+	report_skip("ACPI not available, DBCN is not mandated");
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

