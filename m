Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866867;
	b=DPDa1DwocO4XM6soVPF4Oly4/WwSS/UkFltpvufe8KRXMFVnEpkqpUwfHEkbBR49kBYr
	 KcnFgTCV7Ll96kYLV3vEj729/uw4VW5uBn801XOZbIdRIqVgg9q63LshtLiRv5XvzpXWx
	 Xuv2Vx95GGk5I/RU/SPIav5L7WZSZN3Q6nfHM9ZylBTOt6cNFVDlbi4tCaw+sK2oul3Os
	 jxP683KxlFdMwzxAtGc16Lz1ZkA/pUgyc83GjHSYOHj97rsnfgI1+YagfMEoIdcYKJVAx
	 x/lfJFzfRsrln1f4na5ak9eaiJZHsqmRxFGpR6RBSUTjkintvYP8oKNEPE+jFR7JJcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866867;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=GQPlZS0ThlW8ARB1A9vQ16a2xVlhrXJt8Jk6pUCHY7w=;
	b=Hbmqv7rMlN3iFkGBfPiho1H9Pcoa31XU8hkcKxlyMRXHYaJLRaS93txlbMWyGb0CpT1O
	 10RcqgNIO0mK5I2rhX3rUizpmVOUrpX1I2dPknXefhrpbytAo+RDhfpsptyq1z5W6CrzE
	 IdRXHuopmL7rzFGlI5iDqb5kjJBUiVR1+8kYcppYKEKi5VnoPWfTQPZxTavyH8ankJzIY
	 gbxlqzP9G2yx8Ikakybg6May8lraTN7j18eDQ4Znu33GYNf9g07K0iml8iyqbjacrohiQ
	 9/hokGGZ3f6NygShWRT4EAiLGECd5LPo0O4xYlSAFg1uoue8nXVokPcA7o10sM5ImbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A0606D805
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 08:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 879A0606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.204])
	by APP-01 (Coremail) with SMTP id qwCowABXgvxZPOxq0idRAA--.3359S2;
	Thu, 05 Nov 2026 16:20:41 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v2 4/8] riscv: Add ACPI support for ISA string discovery
Date: Thu,  5 Nov 2026 16:20:31 +0800
Message-ID: <20261105082035.133680-5-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:qwCowABXgvxZPOxq0idRAA--.3359S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWrtw1DuFy8JrWktrWrZrb_yoWrtw1fpF
	4fK34YyrsrJa1xW34Sq3yjvw43GrykCr4xtrs3JaySyw4kGa4jqF4kKF1rZFyrJan5Wa1a
	vrs8KayjgF1UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU8a9aDUUUU
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
 lib/riscv/isa.c | 81 ++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 102 insertions(+), 7 deletions(-)

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
index bc1c9c72..91c7302c 100644
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
@@ -83,32 +83,92 @@ static void isa_parse_fdt(int cpu_node, u64 hartid, void *data)
 	isa_parse(prop->data, len, info);
 }
 
-static void isa_init_acpi(void)
+#ifdef CONFIG_EFI
+#include <acpi.h>
+
+static void isa_parse_acpi(struct acpi_table_rhct *rhct,
+			   struct acpi_rhct_node_hart_info *hart_info, void *data)
 {
-	assert_msg(false, "ACPI not available");
+	u32 offset;
+	struct acpi_rhct_node *node;
+	struct acpi_rhct_node_isa_string *isa_string;
+	struct isa_info *info = (struct isa_info *)data;
+
+	if (hart_info->uid != info->id)
+		return;
+
+	for (int i = 0; i < hart_info->num_offsets; i++) {
+		offset = hart_info->nodes[i];
+		if (offset >= rhct->length)
+			break;
+		node = (void *)rhct + offset;
+		if (node->type == ACPI_RHCT_NODE_TYPE_ISA_STRING) {
+			isa_string = (void *) node;
+			isa_parse(isa_string->isa, isa_string->isa_length, info);
+		}
+	}
+}
+
+static int acpi_rhct_for_each_hart(void (*func)(struct acpi_table_rhct *,
+						 struct acpi_rhct_node_hart_info *,
+						 void *), void *data)
+{
+	u32 offset;
+	struct acpi_table_rhct *rhct;
+	struct acpi_rhct_node *node;
+	struct acpi_rhct_node_hart_info *hart_info;
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
 		assert(ret == 0);
 	} else {
-		isa_init_acpi();
+#ifdef CONFIG_EFI
+		info.id = ti->uid;
+		ret = acpi_rhct_for_each_hart(isa_parse_acpi, &info);
+		assert(ret == 0);
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
@@ -116,10 +176,17 @@ bool cpu_has_extension_name(int cpu, const char *ext)
 	int ret;
 
 	if (dt_available()) {
+		info.id = cpus[cpu].hartid;
 		ret = dt_for_each_cpu_node(isa_parse_fdt, &info);
 		assert(ret == 0);
 	} else {
+#ifdef CONFIG_EFI
+		info.id = cpus[cpu].uid;
+		ret = acpi_rhct_for_each_hart(isa_parse_acpi, &info);
+		assert(ret == 0);
+#else
 		assert_msg(false, "ACPI not available");
+#endif
 	}
 
 	return check->found;
-- 
2.47.3

