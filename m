Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477518A6DB
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786168271; cv=none; b=twxdL4DmVy1BmA6LZhuMaB0ELbpyPsx6LgbOLtI5s71HdZk3nkO4/o1J/5z7Nkr7AhLiQrdq3km86W+OUR3lOBSPh8aft7dn7dY7WZAVnuFIzwiQaYlU6t4wobYRREfR0fafDibIlOe+C9769g9WcYHhZd3R+KVGVsLWORUKWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786168271; c=relaxed/simple;
	bh=AjeuuCqEyoYjE4ci6yTOZufut4JLGI/lWmyhdM5KiwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPkoVpOn0P7J2TFTXBrV1LvMxUL9Yn6IBPABqqnIypdhP0mJg7JcbIvKWmTkc7UD4griaEaOXoWRltDlB9pXAk0NWXhdvdoM2PaKwf24y5WXz7QtEiQ+4wX4gr6oXCKBcOJ5Tj2tKMU18n0L+55HN8Wq6aezrC47YSt6kb2vj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=systemssoftware.dev; spf=pass smtp.mailfrom=systemssoftware.dev; dkim=pass (2048-bit key) header.d=systemssoftware.dev header.i=@systemssoftware.dev header.b=Y/k1fihX; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=systemssoftware.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systemssoftware.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systemssoftware.dev header.i=@systemssoftware.dev header.b="Y/k1fihX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemssoftware.dev;
	s=key1; t=1786168265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GkulbZmOs+Mth+//HgBbAZCXbWi5X+zveQaLFheV+3w=;
	b=Y/k1fihXWuDDMdpGfUY64PpSAcewF/r2/MdP76OvuL+IYJ6GTZLhDoSIHnKIHSGp/+pL4f
	mQ+d4l5vlfjqIWSboLoFFwknxSmjHZU5ii30uvGbiSdoNLDdm07Klg5Z0zfa/hr/kq0I8g
	s+gn5+KaUzkkWFjMzJCjB47eSNHwIAlIoWA8dioPkywMaLhMVe8qATwJifXTDR2aVwbctV
	RMW3mAoPjzQJfuAIbj1f4S9+vgg66e7czrq4Ja/W7+mWCWFqN4lTG58pQfelNYjH0dEqjv
	xv9RwGiR+11ujndZlbjyroz8SnancoE5qE2bWJYWGJS+eCTlZhqM6HNrz2Hi7g==
From: Sainath Grandhi <sainathg@systemssoftware.dev>
To: kvm@vger.kernel.org
Cc: kvm-riscv@lists.infradead.org,
	Andrew Jones <andrew.jones@linux.dev>,
	Sainath Grandhi <sainathg@systemssoftware.dev>
Subject: [kvm-unit-tests PATCH] riscv: Add Zicboz CBO.ZERO tests
Date: Sat,  8 Aug 2026 05:50:40 +0000
Message-ID: <20260808055040.2093-1-sainathg@systemssoftware.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a test for CBO.ZERO when Zicboz is advertised. Read the cache-block
size from riscv,cboz-block-size and allocate three aligned blocks.
Execute CBO.ZERO at multiple offsets in the middle block and verify that
the containing block is zeroed while the adjacent blocks remain
unchanged.

Skip the test when Zicboz is unavailable.

Signed-off-by: Sainath Grandhi <sainathg@systemssoftware.dev>
---
 riscv/Makefile      |   1 +
 riscv/isa-zicboz.c  | 168 ++++++++++++++++++++++++++++++++++++++++++++
 riscv/unittests.cfg |   4 ++
 3 files changed, 173 insertions(+)
 create mode 100644 riscv/isa-zicboz.c

diff --git a/riscv/Makefile b/riscv/Makefile
index 348a30a7..f4a97575 100644
--- a/riscv/Makefile
+++ b/riscv/Makefile
@@ -15,6 +15,7 @@ tests += $(TEST_DIR)/sbi.$(exe)
 tests += $(TEST_DIR)/selftest.$(exe)
 tests += $(TEST_DIR)/sieve.$(exe)
 tests += $(TEST_DIR)/isa-dbltrp.$(exe)
+tests += $(TEST_DIR)/isa-zicboz.$(exe)
 
 all: $(tests)
 
diff --git a/riscv/isa-zicboz.c b/riscv/isa-zicboz.c
new file mode 100644
index 00000000..76a2d209
--- /dev/null
+++ b/riscv/isa-zicboz.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Zicboz cache-block-zero instruction tests
+ *
+ * Copyright (C) 2026, Sainath Grandhi <sainathg@systemssoftware.dev>
+ */
+#include <alloc.h>
+#include <devicetree.h>
+#include <libcflat.h>
+#include <string.h>
+
+#include <asm/isa.h>
+#include <asm/processor.h>
+
+#define GUARD_BEFORE_PATTERN	0xa5
+#define TARGET_PATTERN		0x5a
+#define GUARD_AFTER_PATTERN	0x3c
+
+struct zicboz_info {
+	u64 hartid;
+	u32 block_size;
+	int property_len;
+	bool found;
+};
+
+static void find_zicboz_block_size(int cpu_node, u64 hartid, void *data)
+{
+	struct zicboz_info *info = data;
+	const fdt32_t *property;
+	int len;
+
+	if (hartid != info->hartid)
+		return;
+
+	property = fdt_getprop(dt_fdt(), cpu_node,
+			       "riscv,cboz-block-size", &len);
+	if (!property)
+		return;
+
+	info->found = true;
+	info->property_len = len;
+	if (len == sizeof(*property))
+		info->block_size = fdt32_to_cpu(*property);
+}
+
+static bool get_zicboz_block_size(size_t *block_size)
+{
+	struct zicboz_info info = {
+		.hartid = current_thread_info()->hartid,
+	};
+	int ret;
+
+	ret = dt_for_each_cpu_node(find_zicboz_block_size, &info);
+	if (ret) {
+		report_fail("failed to walk CPU nodes: %s", fdt_strerror(ret));
+		return false;
+	}
+
+	if (!info.found) {
+		report_fail("riscv,cboz-block-size is missing");
+		return false;
+	}
+
+	if (info.property_len != sizeof(fdt32_t)) {
+		report_fail("riscv,cboz-block-size has invalid length %d",
+			    info.property_len);
+		return false;
+	}
+
+	if (!is_power_of_2(info.block_size)) {
+		report_fail("invalid CBO.ZERO block size %u", info.block_size);
+		return false;
+	}
+
+	*block_size = info.block_size;
+	return true;
+}
+
+static inline void cbo_zero(void *address)
+{
+	asm volatile(".option push\n"
+		".option arch, +zicboz\n"
+		"cbo.zero 0(%0)\n"
+		".option pop\n"
+		:
+		: "r" (address)
+		: "memory");
+}
+
+static bool block_has_value(const u8 *block, size_t block_size, u8 value)
+{
+	size_t i;
+
+	for (i = 0; i < block_size; i++) {
+		if (block[i] != value)
+			return false;
+	}
+
+	return true;
+}
+
+static void test_cbo_zero_at_offset(u8 *area, size_t block_size,
+				    size_t offset, const char *name)
+{
+	u8 *guard_before = area;
+	u8 *target = guard_before + block_size;
+	u8 *guard_after = target + block_size;
+
+	report_prefix_push(name);
+
+	memset(guard_before, GUARD_BEFORE_PATTERN, block_size);
+	memset(target, TARGET_PATTERN, block_size);
+	memset(guard_after, GUARD_AFTER_PATTERN, block_size);
+
+	cbo_zero(target + offset);
+	asm volatile("fence rw, rw" ::: "memory");
+
+	report(block_has_value(target, block_size, 0),
+	       "target block was zeroed");
+	report(block_has_value(guard_before, block_size,
+			       GUARD_BEFORE_PATTERN),
+	       "preceding block was preserved");
+	report(block_has_value(guard_after, block_size,
+			       GUARD_AFTER_PATTERN),
+	       "following block was preserved");
+
+	report_prefix_pop();
+}
+
+int main(int argc, char **argv)
+{
+	size_t block_size;
+	u8 *area;
+
+	report_prefix_push("zicboz");
+
+	if (!dt_available()) {
+		report_skip("device tree is not available");
+		goto out;
+	}
+
+	if (!has_ext("zicboz")) {
+		report_skip("Zicboz is not available");
+		goto out;
+	}
+
+	if (!get_zicboz_block_size(&block_size))
+		goto out;
+
+	report_info("CBO.ZERO block size is %lu bytes",
+		    (unsigned long)block_size);
+
+	area = memalign(block_size, 3 * block_size);
+
+	/* Every address within a block must select the same containing block. */
+	test_cbo_zero_at_offset(area, block_size, 0, "block-start");
+	test_cbo_zero_at_offset(area, block_size, 1, "second-byte");
+	test_cbo_zero_at_offset(area, block_size, block_size / 2,
+				"block-middle");
+	test_cbo_zero_at_offset(area, block_size, block_size - 1,
+				"block-end");
+
+	free(area);
+
+out:
+	report_prefix_pop();
+	return report_summary();
+}
diff --git a/riscv/unittests.cfg b/riscv/unittests.cfg
index 9e9f58d9..30594fe5 100644
--- a/riscv/unittests.cfg
+++ b/riscv/unittests.cfg
@@ -22,3 +22,7 @@ groups = sbi
 [dbltrp]
 file = isa-dbltrp.flat
 groups = isa sbi
+
+[zicboz]
+file = isa-zicboz.flat
+groups = isa
-- 
2.53.0

