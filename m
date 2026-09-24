Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F3B3CF032
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 03:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221208; cv=none; b=XheIiF8oGtIplCdqSPjRxgAd/5ucUo9KoS3UImJN/gKzX2lrLPOhLbkSPBy7ib6RVLkpHmNIM5QHr9ZsZDG9Jmt3p2SDRvG57LPJY9EEcBPSK/5IGjHq4mglSidsPDUCvapkCGXs7JXtFwXPNgFpay10KsbQISko/tNqiI/lRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221208; c=relaxed/simple;
	bh=ipEoCe62kAnNo/mkuL/5ZJJeJWni8j5pEIBr3EvPr6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3Vhki9Ly/MmqpUsBpEoUwYlAB0MQ9f+Ibf67jvLyu9ngYYl5eZMdx7HzcQ0LlCWGmNaS4isQYQayrrw6cg881NhtONpbzsLXowC0y/7VQEgK9pGGZ20MkUAz/OnB/snkC8KV9VIkH3DLOtgS3OhbM7hdDb1O8Uy4xSlZGTwc9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.201])
	by APP-01 (Coremail) with SMTP id qwCowAA3D_OGm7Rq707JCA--.1196S2;
	Thu, 24 Sep 2026 11:39:50 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	pbonzini@redhat.com,
	thuth@redhat.com,
	Xiang W <wangxiang@iscas.ac.cn>
Subject: [kvm-unit-tests PATCH 1/7] riscv: Initialize the ACPI RSDP from the EFI system table
Date: Thu, 24 Sep 2026 11:39:39 +0800
Message-ID: <20260924033945.176581-2-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAA3D_OGm7Rq707JCA--.1196S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3Ar45Wr47Jr4fKFyUKFg_yoW8CFyUpa
	yYyFW5GrW8GrWxJ3sayr1jk343Ar4SgFy7J397Aan8Aa15ZrWDZF1kta4avF13XFyrta1Y
	qan29ryrWan0y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUIPfdUUUUU=
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

