Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795571081;
	b=1XxFXw6ERNMAl/+FvHyLRSR4O5ewgHvZYruJEgUkyG9hHdEMFQyb+C8i8Hdev55+VzaT
	 7vdD1i5V6Y1I6WZhUdLBnRvG5temGWkk0ZvS/9O5gw0SGvcCpqpEAY/Yg9+TPSU3cN2P2
	 UhrlZHnWTyPkfNTeL5ndk4jCguox8vUOoGTK3y4u1iHKtfqh08EIwOsAOnyR9mEKtX9aJ
	 4qO0GErXvplcFsRQJZxNwER0nPTnI1+w4ojyfa52NUNhwY2DJQpywUWgGpmQSNrHQprmD
	 jfXSw+toyWyFK0z2rRF0qERG2m47zJpUkaqkaO+TlLg6Ceq9ciZmy1fRQC5/c3fm7Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571081;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=rRBC4W6YHy05fv+iNeOWdOxjAZ1ryLxKDHh4W+4JIxs=;
	b=E6mLgMoDuxm7Rcpy7GQUftcUfvjh8NjHs/l4ypSSZlYCibmUkYe68QhBCsJmDYaO121M
	 wsSiyFUORDbmrXRP3riu6GaM+Ec24cAngor7wjyyAD/vrs2s71ZCQrtQaeLLAFEkw6eus
	 E7iPhz7yo9I5lYMkhwxd8q4vGWYyIT6Fawh7ARppblFwRFZ1txWkkzN1keP3b/EY63dh/
	 10MqxDVFcALObJmxYXtZ+gwpO25NBvRzcGkadoPgkI9DUVhmYO30LGCD4gHEppvlF3pE5
	 9G8vvbnscyveWdfzDGToFY1F2mfVzTV1bJKShqeeEKDfPTAA+gaqvbz1lsk69ywy8dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1B606A33E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 01:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69B1B606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.240])
	by APP-03 (Coremail) with SMTP id rQCowAD3yZp7PQZrvtm8AQ--.748S2;
	Wed, 25 Nov 2026 09:44:27 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v3 4/9] riscv: Add ACPI support for ISA string discovery
Date: Wed, 25 Nov 2026 09:44:04 +0800
Message-ID: <20261125014409.79852-5-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAD3yZp7PQZrvtm8AQ--.748S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWrtw1DuFy8JrWktrWrZrb_yoW7Gr17pF
	4fK398trsrJw4xW34Sqw4jvw43Ar1kCr4xJrZ3Ja4Syw4DGa4qqF4kKr1fuFy5Jan5Wa1a
	vrs8GayjgF1UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUeQ6pDUUUU
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

When a DT is not provided, walk the RHCT Hart Info nodes and parse
the referenced ISA String node instead of aborting in isa_init()
and cpu_has_extension_name().

Match the current hart by ACPI UID (DT still matches by hartid)
and feed the ISA string into the existing isa_parse() helper so
extension detection is shared by both firmware descriptions.

Rename isa_info.hartid to isa_info.id so the same iterator state
can hold either identifier.

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 lib/acpi.h      | 28 +++++++++++++++++
 lib/riscv/isa.c | 84 +++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 103 insertions(+), 9 deletions(-)

diff --git a/lib/acpi.h b/lib/acpi.h
index 0589669b..d5e238a9 100644
--- a/lib/acpi.h
+++ b/lib/acpi.h
@@ -334,6 +334,34 @@ struct acpi_table_rhct {
 	u32 node_offset;
 };
 
+#define ACPI_RHCT_NODE_HEADER_DEF \
+	u16 type;	\
+	u16 length;	\
+	u16 revision;	\
+
+struct acpi_rhct_node {
+	ACPI_RHCT_NODE_HEADER_DEF
+	char data[];
+};
+
+enum acpi_rhct_node_type {
+	ACPI_RHCT_NODE_TYPE_ISA_STRING = 0x0,
+	ACPI_RHCT_NODE_TYPE_HART_INFO = 0xFFFF
+};
+
+struct acpi_rhct_node_isa_string {
+	ACPI_RHCT_NODE_HEADER_DEF
+	u16 isa_length;
+	char isa[];
+};
+
+struct acpi_rhct_node_hart_info {
+	ACPI_RHCT_NODE_HEADER_DEF
+	u16 num_offsets;
+	u32 uid;
+	u32 nodes[];
+};
+
 /* Reset to default packing */
 #pragma pack()
 
diff --git a/lib/riscv/isa.c b/lib/riscv/isa.c
index bc1c9c72..c03bb19b 100644
--- a/lib/riscv/isa.c
+++ b/lib/riscv/isa.c
@@ -12,7 +12,7 @@
 typedef void (*isa_func_t)(const char *, int, void *);
 
 struct isa_info {
-	unsigned long hartid;
+	unsigned long id;
 	isa_func_t func;
 	void *data;
 };
@@ -74,7 +74,7 @@ static void isa_parse_fdt(int cpu_node, u64 hartid, void *data)
 	const struct fdt_property *prop;
 	int len;
 
-	if (hartid != info->hartid)
+	if (hartid != info->id)
 		return;
 
 	prop = fdt_get_property(dt_fdt(), cpu_node, "riscv,isa", &len);
@@ -83,32 +83,91 @@ static void isa_parse_fdt(int cpu_node, u64 hartid, void *data)
 	isa_parse(prop->data, len, info);
 }
 
-static void isa_init_acpi(void)
+#ifdef CONFIG_EFI
+#include <acpi.h>
+
+static void isa_parse_acpi(struct acpi_table_rhct *rhct,
+			   struct acpi_rhct_node_hart_info *hart_info, void *data)
+{
+	struct isa_info *info = (struct isa_info *)data;
+	struct acpi_rhct_node_isa_string *isa_string;
+	struct acpi_rhct_node *node;
+	u32 offset;
+
+	if (hart_info->uid != info->id)
+		return;
+
+	for (int i = 0; i < hart_info->num_offsets; i++) {
+		offset = hart_info->nodes[i];
+		assert_msg(offset < rhct->length, "RHCT: offset is within the length range");
+		node = (void *)rhct + offset;
+		if (node->type == ACPI_RHCT_NODE_TYPE_ISA_STRING) {
+			isa_string = (void *)node;
+			isa_parse(isa_string->isa, isa_string->isa_length, info);
+		}
+	}
+}
+
+static int acpi_rhct_for_each_hart(void (*func)(struct acpi_table_rhct *,
+						struct acpi_rhct_node_hart_info *,
+						void *), void *data)
 {
-	assert_msg(false, "ACPI not available");
+	struct acpi_rhct_node_hart_info *hart_info;
+	struct acpi_table_rhct *rhct;
+	struct acpi_rhct_node *node;
+	u32 offset;
+
+	rhct = find_acpi_table_addr(RHCT_SIGNATURE);
+	if (rhct == NULL)
+		return -1;
+
+	offset = rhct->node_offset;
+	for (int i = 0; i < rhct->node_count; i++) {
+		if (offset >= rhct->length)
+			return -1;
+
+		node = (void *)rhct + offset;
+		if (node->length < sizeof(*node))
+			return -1;
+
+		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
+			hart_info = (void *)node;
+			func(rhct, hart_info, data);
+		}
+
+		offset += node->length;
+	}
+
+	return 0;
 }
+#endif
 
 void isa_init(struct thread_info *ti)
 {
 	struct isa_info info = {
-		.hartid = ti->hartid,
 		.func = isa_bit,
 		.data = ti,
 	};
 	int ret;
 
 	if (dt_available()) {
+		info.id = ti->hartid;
 		ret = dt_for_each_cpu_node(isa_parse_fdt, &info);
-		assert(ret == 0);
+		assert_msg(ret == 0, "DeviceTree: Failed to parse \"riscv,isa\"");
 	} else {
-		isa_init_acpi();
+#ifdef CONFIG_EFI
+		info.id = ti->uid;
+		ret = acpi_rhct_for_each_hart(isa_parse_acpi, &info);
+		assert_msg(ret == 0, "ACPI: Failed to parse RHCT");
+#else
+		assert_msg(false, "ACPI not available");
+#endif
 	}
 }
 
 bool cpu_has_extension_name(int cpu, const char *ext)
 {
 	struct isa_info info = {
-		.hartid = cpus[cpu].hartid,
 		.func = isa_name,
 		.data = &(struct isa_check){ .ext = ext, },
 	};
@@ -116,10 +175,17 @@ bool cpu_has_extension_name(int cpu, const char *ext)
 	int ret;
 
 	if (dt_available()) {
+		info.id = cpus[cpu].hartid;
 		ret = dt_for_each_cpu_node(isa_parse_fdt, &info);
-		assert(ret == 0);
+		assert_msg(ret == 0, "DeviceTree: Failed to parse \"riscv,isa\"");
 	} else {
+#ifdef CONFIG_EFI
+		info.id = cpus[cpu].uid;
+		ret = acpi_rhct_for_each_hart(isa_parse_acpi, &info);
+		assert_msg(ret == 0, "ACPI: Failed to parse RHCT");
+#else
 		assert_msg(false, "ACPI not available");
+#endif
 	}
 
 	return check->found;
-- 
2.47.3

