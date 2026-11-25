Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795571075;
	b=3gpkOM0njTv1gjcu+VNlU3SArGyt3vRN0nhWT6GyZ9HIJo2DtkfMEehLKthH4+IIJ/9A
	 dNnSd0eQTxyXuE2lnYyQoemSSkOvv/4Nj/Tockzju3sYcmfM/C/Hcgs6GkCPABjax/rrs
	 Rk0SRLRv8JxPLvNYKx/QYMCltyFVkq6Zoc4TE4n9h/hh7mAxgYVu3ibRClTcP8QRlJyJX
	 z7aT76ZPSdjJ7iALkUC66GBRfBkdNoh3DUuPsgjiJF0iveTWSCLvdBWR0odKNcgglCd5T
	 lrliOMVAsTRL1PgwJHL7x4+qBsW/8fHCuTTWRbekHhiqBGwXETQ1NJYz8w0qhckl2zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571075;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=qm0rbR7G2S9gtV2Dcou0qDMKFeEykEny7FJTj8ANYhQ=;
	b=BaPEG8UVGf+WWs5eQqZw1Ql+dM2wncTnGzMJodsikTPWiwSj5jV5YisWOqD4ER2woW9U
	 vGAqqM36n0An3bu1G0r8qvxs1zEk7AkVSg+5D5AXskWSu9uetiK7gv5g3LXHRz3MQb0s2
	 gqHBnKil1vgHXpeYfj6a2gVBftowyxtH+pmlUIpD2yROFHjId0FPydC7zRlopFTx/HuXm
	 MU7eM0GqGRh7zIuEjb4trXqh0KYcQ7c3vmGtXouBYJ951Rm3vK/YQ9ayRr0XJXAFAOF3x
	 ZwdqjwTGFAtBUHLW6Qyflv3uHj/bw2SVB8qU8oW4A+2RIpMK66DIPuYj8DJCECyZEIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784C606A32D
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 01:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7784C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.240])
	by APP-03 (Coremail) with SMTP id rQCowABXYZJ6PQZrudm8AQ--.23020S2;
	Wed, 25 Nov 2026 09:44:26 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v3 3/9] riscv: Add ACPI support for timer frequency discovery
Date: Wed, 25 Nov 2026 09:44:03 +0800
Message-ID: <20261125014409.79852-4-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:rQCowABXYZJ6PQZrudm8AQ--.23020S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4UCrWfCw13Jr45XrW7XFb_yoW5Gw43pF
	s3KF43Jry7ta4fWwnxXrn8trn5tw1vkF18Kr42yrZxuF4DJa4DJa1Yqrn2qFyfX3yDAay3
	Kr1rGFZIgr4YgrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUe_MaUUUUU
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

When a DT is not provided, read the system time base frequency from
the RHCT instead of aborting in timer_get_frequency().

RHCT Time Base Frequency is the ACPI equivalent of the DT
/cpus timebase-frequency property and is the same for all harts.
Keep DT as the preferred path when one is available.

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 lib/acpi.h        |  9 +++++++++
 lib/riscv/timer.c | 35 +++++++++++++++++++++++------------
 2 files changed, 32 insertions(+), 12 deletions(-)

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
index 18063b7e..4400b6dc 100644
--- a/lib/riscv/timer.c
+++ b/lib/riscv/timer.c
@@ -12,25 +12,36 @@
 #include <asm/setup.h>
 #include <asm/smp.h>
 #include <asm/timer.h>
+#include <acpi.h>
 
 void timer_get_frequency(void)
 {
-	const struct fdt_property *prop;
-	u32 *data;
-	int cpus, len;
+	if (dt_available()) {
+		const struct fdt_property *prop;
+		const void *fdt;
+		u32 *data;
+		int cpus, len;
 
-	assert_msg(dt_available(), "ACPI not yet supported");
+		fdt = dt_fdt();
+		cpus = fdt_path_offset(fdt, "/cpus");
+		assert(cpus >= 0);
 
-	const void *fdt = dt_fdt();
+		prop = fdt_get_property(fdt, cpus, "timebase-frequency", &len);
+		assert(prop != NULL && len == 4);
 
-	cpus = fdt_path_offset(fdt, "/cpus");
-	assert(cpus >= 0);
-
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

