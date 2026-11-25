Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795571080;
	b=s5wIEd4lZyrl4pdOcg3FDW/dfNue7WBFenv3UKeNMtjlT7WBtkN2XtLk3iW7mNObHUN1
	 od65vxaGiXGvsD8F7d/8qNb/fVg6/ZYGtngZsCOqIA6/jy414JAAEchch1pzwDEFSievl
	 kMUxm+AxOuUDk668bmrC2XuZVCUAgPyrDmuVF7JEACTD56zbsXHLvcEl3p0oFTvRAyiH/
	 NCGMZKnOUuFCsbD2qSpSeYaUuej9oZm12immbADfSoj7JrEsnQM0mkSNbKYMfz1o5tnCI
	 46n3RNRMTU2kDsuCVVhplaZHOUky5QWANchaHOEm8oSCwhsLRcM24m/RpocGaUEHQ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571080;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=bJ0DNjkGsvPoRVlTWXCehVrDZmbssgFq8zP3rn57cJc=;
	b=jPlvHtCYzvFb5I7odw5i39WN8FjHvSPpPAggOycrQrObAXtjLo+rIVK1+np3lbIiQaZ6
	 uKRuakYFTdJvaQrHjPpWwqOlIasxheYoqsmGry4n/HwqiREKSnRj3YVhlQqmSkmXV6IVz
	 +bOorItmVXMPVX4ovzH0+5zIkG/VCrh7Wbk+XBkLJmoqPcE/CpEc/9EowArJgRGgIieYq
	 nhGYH1czQiFjfMAFicVWZ2WQVuMrEMNdKcP5JV0esDR54V70QveGzSCFRWXoa/8ZnToqA
	 kux6BoDfODOGAf38awN/3rhBCaYuAyuA7s7QtnHVCoMvU2eNMMavEEZrOBUgAXG+mrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E04606A33A
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 01:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37E04606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.240])
	by APP-03 (Coremail) with SMTP id rQCowADH05R9PQZr4Nm8AQ--.742S2;
	Wed, 25 Nov 2026 09:44:29 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v3 9/9] riscv: Add BRS SBI requirement tests
Date: Wed, 25 Nov 2026 09:44:09 +0800
Message-ID: <20261125014409.79852-10-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:rQCowADH05R9PQZr4Nm8AQ--.742S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFW8CFW5Xw1rWw1UXw1UWrg_yoW3Gw13pr
	1kCr90kr98JFyxA393AF1DGw15tr1rXwn0gr4UCw1rKw47trW5Xws7t34ayr45XFWrGr9x
	u3ZagrZ5uFsrGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjb_-PUUUUU==
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
 lib/riscv/asm/sbi.h |   8 +-
 lib/riscv/isa.c     |  12 ++-
 riscv/Makefile      |   1 +
 riscv/riscv-brs.c   | 192 ++++++++++++++++++++++++++++++++++++++++++++
 riscv/unittests.cfg |   4 +
 6 files changed, 215 insertions(+), 5 deletions(-)
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
index 289a6a24..987ea1de 100644
--- a/lib/riscv/asm/sbi.h
+++ b/lib/riscv/asm/sbi.h
@@ -44,13 +44,15 @@
 enum sbi_ext_id {
 	SBI_EXT_BASE = 0x10,
 	SBI_EXT_TIME = 0x54494d45,
-	SBI_EXT_IPI = 0x735049,
-	SBI_EXT_HSM = 0x48534d,
+	SBI_EXT_IPI  = 0x735049,
+	SBI_EXT_RFNC = 0x52464E43,
+	SBI_EXT_HSM  = 0x48534d,
 	SBI_EXT_SRST = 0x53525354,
+	SBI_EXT_PMU  = 0x504D55,
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_SUSP = 0x53555350,
 	SBI_EXT_FWFT = 0x46574654,
-	SBI_EXT_SSE = 0x535345,
+	SBI_EXT_SSE  = 0x535345,
 	SBI_EXT_DBTR = 0x44425452,
 };
 
diff --git a/lib/riscv/isa.c b/lib/riscv/isa.c
index c03bb19b..38418e3e 100644
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
index f90992ab..8b3bb99a 100644
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
index 00000000..0591d3d0
--- /dev/null
+++ b/riscv/riscv-brs.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RISC-V BRS SBI requirement tests
+ *
+ * Copyright (C) 2026, Institute of Software, CAS., Xiang W <wangxiang@iscas.ac.cn>
+ */
+
+#include <libcflat.h>
+#include <devicetree.h>
+#include <asm/sbi.h>
+#include <asm/isa.h>
+#include <asm/smp.h>
+#include <acpi.h>
+
+static void check_sbi_010(void)
+{
+	struct sbiret ret;
+	unsigned long major, minor;
+
+	report_prefix_push("SBI_010");
+
+	ret = sbi_get_spec_version();
+	if (ret.error) {
+		report_fail("sbi_get_spec_version failed with %ld", ret.error);
+	} else {
+		major = ret.value >> SBI_SPEC_VERSION_MAJOR_SHIFT;
+		major = major & SBI_SPEC_VERSION_MAJOR_MASK;
+		minor = ret.value & SBI_SPEC_VERSION_MINOR_MASK;
+
+		report(sbi_mk_version(major, minor) >= sbi_mk_version(2, 0),
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
+	int cpu;
+	bool has = true;
+
+	report_prefix_push("SBI_030");
+
+	for_each_present_cpu(cpu) {
+		if (!cpu_has_extension(cpu, ISA_SSTC)) {
+			has = false;
+			break;
+		}
+	}
+
+	if (has)
+		report_skip("Sstc is present, TIME is not mandated");
+	else
+		report(sbi_probe(SBI_EXT_TIME), "TIME extension is implemented");
+
+	report_prefix_pop();
+}
+
+static void check_sbi_040(void)
+{
+	int cpu;
+	bool has = true;
+
+	report_prefix_push("SBI_040");
+
+	for_each_present_cpu(cpu) {
+		if (!cpu_has_extension(cpu, ISA_SSAIA)) {
+			has = false;
+			break;
+		}
+		if (cpus[cpu].imsic_pa == INVALID_PHYS_ADDR) {
+			has = false;
+			break;
+		}
+	}
+
+	if (has)
+		report_skip("IMSIC is present, IPI is not mandated");
+	else
+		report(sbi_probe(SBI_EXT_IPI), "IPI extension is implemented");
+
+	report_prefix_pop();
+}
+
+static void check_sbi_050(void)
+{
+	int cpu;
+	bool has = true;
+
+	report_prefix_push("SBI_050");
+
+	for_each_present_cpu(cpu) {
+		if (!cpu_has_extension(cpu, ISA_SSAIA)) {
+			has = false;
+			break;
+		}
+		if (cpus[cpu].imsic_pa == INVALID_PHYS_ADDR) {
+			has = false;
+			break;
+		}
+	}
+
+	if (has)
+		report_skip("IMSIC is present, RFENCE is not mandated");
+	else
+		report(sbi_probe(SBI_EXT_RFNC), "RFENCE extension is implemented");
+
+	report_prefix_pop();
+}
+
+static void check_sbi_060(void)
+{
+	int cpu;
+	bool has = true;
+
+	report_prefix_push("SBI_060");
+
+	for_each_present_cpu(cpu) {
+		if (!cpu_has_extension(cpu, ISA_SSCSRIND)) {
+			has = false;
+			break;
+		}
+		if (!cpu_has_extension(cpu, ISA_SSCCFG)) {
+			has = false;
+			break;
+		}
+	}
+
+	if (has) {
+		/*
+		 * TODO: OE_SBI_060_010 also requires Smcsrind and Smcdeleg,
+		 * but they are M-mode extensions and not present in the S-mode
+		 * ISA string (DT or RHCT). Revisit if BRS clarifies how to detect them.
+		 */
+		report_skip("Sscsrind and Ssccfg are present, PMU is not mandated");
+	} else {
+		report(sbi_probe(SBI_EXT_PMU), "PMU extension is implemented");
+	}
+
+	report_prefix_pop();
+}
+
+static void check_sbi_070(void)
+{
+	report_prefix_push("SBI_070");
+
+	if (dt_available()) {
+		report_skip("ACPI not available, DBCN is not mandated");
+	} else {
+#ifdef CONFIG_EFI
+		struct spcr_descriptor *spcr;
+
+		spcr = find_acpi_table_addr(SPCR_SIGNATURE);
+		if (spcr == NULL) {
+			report_skip("SPCR is not present, DBCN is not mandated");
+		} else {
+			if (spcr->interface_type == 0x15) {
+				report(sbi_probe(SBI_EXT_DBCN), "DBCN extension is implemented");
+			} else {
+				report_skip("SPCR interface type is %#x (not 0x15), DBCN is not mandated",
+					    spcr->interface_type);
+			}
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

