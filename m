Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795571075;
	b=143yQJu0pC4n5YNdry+PiEbrPKDjLRSRSTyJ4IHdVs/kmCve5QmEp+oAvFBw9wGTiMyv
	 olHR84jCpkggrepygKWxg8eGgwba8/OrNJxA8Rzl39nHvQWm/dnN+UuDJW+qOP7TJJqk4
	 NZ8mcZtlTthjAQ0U25rAoNJHZ2QTL/410gjrLFScAbaST1UsORR52RgYQeXo7zDvPXJkf
	 iSmNL8aaov0hXdREGdC+t20JpmTr1RsjxuQEVnDHlStN8N39dwUNBAGPJVrOqUUIY6cYc
	 afCHSth5IO5ZIwbEFhoP8eFh0HnsbWeHr49eQa3r4JTIjqIaC1tfEl+G3uR+5wkNK5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571075;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=eFOY0CQQlTSyWkA2Qp3PYS2trDO4YoGVM2mbdYBlzng=;
	b=NJBA0YodTo7vtDdUF5baYLMCcOHGm4A+nTMENae0nfJc64octa9xdQ+TxjBUpCYb5Rhf
	 EJpgbeQPkGdvjFCY7ixCL8OcDwWvCGwxwEpK8Tjfr5oD24HNA1PRqxiJTckkEe0y+ZfgT
	 BpsnAHNtMw+MglquEO6WLSZtfNnS9pVFsktGHvBV7b1UoCF8DO2Ipty+yASFg9HnixADL
	 cV0LgUUAkiWgpBpV+vKtwNeP68IpePcyZOSY3fhEYHEjfe2CYk8lE5XgMjAQoeHlV41sA
	 iljLGy0qsnvbSumq/FuSBBoQt+gUnP0RAPT323xyLPJQ6wKCcvz9zAMkIaHTKtPSD1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00397606A336
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 01:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00397606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.240])
	by APP-03 (Coremail) with SMTP id rQCowADXqZp8PQZr0tm8AQ--.25273S2;
	Wed, 25 Nov 2026 09:44:28 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v3 7/9] riscv: Initialize ISA extensions for all harts at CPU setup
Date: Wed, 25 Nov 2026 09:44:07 +0800
Message-ID: <20261125014409.79852-8-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:rQCowADXqZp8PQZr0tm8AQ--.25273S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw45ZFyfKrWUtr15ArWfGrg_yoW8AFyfpF
	yDC3W5KrZ8WFs7J3s7trnYk34fK3W7Ca1xtFW8A34Fva1UJws8JrWDG3s09F17JFW8Xa1a
	93ykGry5AF45ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUeQ6pDUUUU
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

Move isa_init() from thread_info_init() into cpu_set_fdt() and
cpu_set_acpi().

thread_info_init() only promotes sscratch to the current hart's
thread_info. cpu_has_extension() reads cpus[].isa from the boot
hart, including for secondaries that have not started yet, so ISA
parsing has to happen while enumerating CPUs.

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 lib/riscv/processor.c | 1 -
 lib/riscv/setup.c     | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/riscv/processor.c b/lib/riscv/processor.c
index b055acc9..ddecc25e 100644
--- a/lib/riscv/processor.c
+++ b/lib/riscv/processor.c
@@ -81,7 +81,6 @@ void thread_info_init(void)
 	unsigned long hartid = csr_read(CSR_SSCRATCH);
 	int cpu = hartid_to_cpu(hartid);
 
-	isa_init(&cpus[cpu]);
 	csr_write(CSR_SSCRATCH, &cpus[cpu]);
 }
 
diff --git a/lib/riscv/setup.c b/lib/riscv/setup.c
index f1121573..547851f5 100644
--- a/lib/riscv/setup.c
+++ b/lib/riscv/setup.c
@@ -16,6 +16,7 @@
 #include <on-cpus.h>
 #include <vmalloc.h>
 #include <asm/csr.h>
+#include <asm/isa.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
 #include <asm/processor.h>
@@ -61,6 +62,7 @@ static int cpu_set_acpi(struct acpi_subtable_header *header)
 	cpus[cpu].cpu = cpu;
 	cpus[cpu].hartid = intc->hart_id;
 	cpus[cpu].uid = intc->uid;
+	isa_init(&cpus[cpu]);
 
 	if (intc->flags & ACPI_MADT_ENABLED) {
 		if (!sbi_hart_get_status(cpus[cpu].hartid).error)
@@ -79,6 +81,7 @@ static void cpu_set_fdt(int fdtnode __unused, u64 regval, void *info __unused)
 
 	cpus[cpu].cpu = cpu;
 	cpus[cpu].hartid = regval;
+	isa_init(&cpus[cpu]);
 
 	if (!sbi_hart_get_status(cpus[cpu].hartid).error)
 		set_cpu_present(cpu, true);
-- 
2.47.3

