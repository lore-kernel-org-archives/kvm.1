Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866857;
	b=Sa9KonXVOi8/SjTEu9NlLcJqQ5YdfnVpTbu7COUOJXTi/5dxmWvpTuRybpYPGe1gsELj
	 +UTbtu0skKDY4eu2/7qpTHiR+zk+U/0lVI+XokWesmYXvCX0vl0xAWmAazet9A2wQ4Tku
	 ZjG4LLpkMmPuLOHj3WAUW7FsoPIhFPsT0ZKQaFfWuv3M3ceuhW0UzD7PRNnDyvRStRhCG
	 dXWDpNjWCpNXcyjmWQ/Q/QOQV75Rh9+AtABT48WIykBLMikfB4RU/OFxHk0j2GhzolrHP
	 4pEWqZNenRrK2MxY3gHeGJTkvA6rtiP/SALakSmL/ao1TaRN96r16GFRlNvdV6cUarA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866857;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=A+/F+EwP6gEMu0jRCxTda03GH84HVKp/PE6q27DJ7A0=;
	b=DzXVDTn7OYK8vy2a70veovK0RvjBzG1tfWmvh6heRQjqFe2Sj/wVTYp/KKo3ZpLXG03R
	 TQ+FT/imeG2gouZwfD1D2FR7lMhGDjygH8Y8ZHvfalecGBlfoLngclFKrsvxLefDQAT+o
	 JZU97gNA7URy/EAMon/mXdnjjRMMBhp6RfpAzZH1MJs/B/ErVAbHZvrFDpFi81lDhubDj
	 5ePXydAZnlxVv/6mjfoOBfGDj4+S08FTUESuIJSKTmB6No0FkR7HfsMnL4u4SYmiN3xaB
	 X+SgUxHvcwwqv+jyEo//LCCyaxC0iSLAp+pJDC+Pm5H23GWLmi9ELok1LIj5cCaE6Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FAD606A32E
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 08:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40FAD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.204])
	by APP-01 (Coremail) with SMTP id qwCowAD3HvlXPOxqtSdRAA--.3162S2;
	Thu, 05 Nov 2026 16:20:39 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v2 1/8] riscv: Initialize the ACPI RSDP from the EFI system table
Date: Thu,  5 Nov 2026 16:20:28 +0800
Message-ID: <20261105082035.133680-2-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAD3HvlXPOxqtSdRAA--.3162S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3Ar45Wr47Jr4fKFyUKFg_yoW8CFyUpa
	yYyFW5GrW8GrWxJ3sayr1jk343Ar4SgFy7J397Aan8Aa15ZrWDZF1kta4avF13XFyrta1Y
	qan29ryrWan0y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUaQ6JUUUUU=
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

On EFI boots without a DT, ACPI table lookup needs a valid RSDP.
Fetch the ACPI 2.0 table from the EFI configuration table and
register it with set_efi_rsdp() before cpu_init() and
timer_get_frequency().

The RSDP lives in EFI_ACPI_RECLAIM_MEMORY, which the RISC-V
allocator does not reuse, so there is no need to copy it aside.

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 lib/riscv/setup.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/lib/riscv/setup.c b/lib/riscv/setup.c
index a30aa0c4..8c22120d 100644
--- a/lib/riscv/setup.c
+++ b/lib/riscv/setup.c
@@ -226,10 +226,31 @@ void setup(const void *fdt, phys_addr_t freemem_start)
 
 #ifdef CONFIG_EFI
 #include <efi.h>
+#include <acpi.h>
 
 extern unsigned long exception_vectors;
 extern unsigned long boot_hartid;
 
+static efi_status_t setup_rsdp(efi_bootinfo_t *efi_bootinfo __unused)
+{
+	efi_status_t status;
+	struct acpi_table_rsdp *rsdp;
+
+	/*
+	 * RSDP resides in an EFI_ACPI_RECLAIM_MEMORY region, which is not used
+	 * by kvm-unit-tests RISC-V memory allocator. So it is not necessary to
+	 * copy the data structure to another memory region to prevent
+	 * unintentional overwrite.
+	 */
+	status = efi_get_system_config_table(ACPI_20_TABLE_GUID, (void **)&rsdp);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	set_efi_rsdp(rsdp);
+
+	return EFI_SUCCESS;
+}
+
 static efi_status_t efi_mem_init(efi_bootinfo_t *efi_bootinfo)
 {
 	struct mem_region *freemem_mr = NULL, *code, *data;
@@ -273,6 +294,14 @@ efi_status_t setup_efi(efi_bootinfo_t *efi_bootinfo)
 		return status;
 	}
 
+	if (!dt_available()) {
+		status = setup_rsdp(efi_bootinfo);
+		if (status != EFI_SUCCESS) {
+			printf("Cannot find RSDP in EFI system table\n");
+			return status;
+		}
+	}
+
 	cpu_init();
 	timer_get_frequency();
 	thread_info_init();
-- 
2.47.3

