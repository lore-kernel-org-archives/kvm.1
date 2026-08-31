Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B073DB645;
	Mon, 31 Aug 2026 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170084; cv=none; b=sxzb+hXobklP/bNEZZmehn0u5sdoIkHVYtx1MFKvDbHoPdVaFh+cRqIx9JGAmfMOh79opFJWdl70BHlO5mfrsJwBy36ymYYcchrGVHN6v9blumGMjy/QYTrSuko7dTbOHI17AjPMIRNjc/QdVBA7amaDYUAa6yDI7f6LvCQkzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170084; c=relaxed/simple;
	bh=NcaRNW8y7jjiWV9pcdQk/a8UC7sWrWckxCmIlEOilbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oVX0WodPQjyFnQDkBHFg5Gkyr2QD+7LyIhXcZrFiuo+FhFNE+P2OKevP//GuJD/GN9ovl8/FSoCywiCtYB4htVV9q03dafNh9l7FHjFRtB1D1Us8yHgoemJVk1oql42HSQUqM3wHNNHy/k6hG0oNp6zJJ4Uns17SixQn89aV0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxntJgT5Vqyt0GAA--.19232S3;
	Mon, 31 Aug 2026 17:54:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxKs5eT5VqDTYYAA--.20453S5;
	Mon, 31 Aug 2026 17:54:40 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Arnd Bergmann <arnd@arndb.de>,
	Xi Ruoyao <xry111@xry111.site>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] LoongArch: KVM: Enable separate vmid feature
Date: Mon, 31 Aug 2026 17:47:16 +0800
Message-Id: <20260831094716.4016652-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260831094716.4016652-1-maobibo@loongson.cn>
References: <20260831094716.4016652-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKs5eT5VqDTYYAA--.20453S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With CSR GTLBC shortname for Guest TLB Control Register, separate vmid
feature will be enabled if bit 14 CSR_GTLBC_USES2TGID is set. Enable
this if S2TGID feature is detected from cpucfg8.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/loongarch.h | 5 +++++
 arch/loongarch/kernel/cpu-probe.c      | 6 ++++++
 arch/loongarch/kvm/main.c              | 6 ++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 2a6bc99177d8..88e3bdfd4971 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -138,6 +138,9 @@
 #define  CPUCFG6_PMBITS_SHIFT		8
 #define  CPUCFG6_UPM			BIT(14)
 
+#define LOONGARCH_CPUCFG8		0x8
+#define  CPUCFG8_S2TGID			BIT(8)
+
 #define LOONGARCH_CPUCFG16		0x10
 #define  CPUCFG16_L1_IUPRE		BIT(0)
 #define  CPUCFG16_L1_IUUNIFY		BIT(1)
@@ -350,6 +353,8 @@
 #define  CSR_GTLBC_TGID_WIDTH		8
 #define  CSR_GTLBC_TGID_SHIFT_END	(CSR_GTLBC_TGID_SHIFT + CSR_GTLBC_TGID_WIDTH - 1)
 #define  CSR_GTLBC_TGID			(_ULCAST_(0xff) << CSR_GTLBC_TGID_SHIFT)
+#define  CSR_GTLBC_USES2TGID_SHIFT	14
+#define  CSR_GTLBC_USES2TGID		(_ULCAST_(0x1) << CSR_GTLBC_USES2TGID_SHIFT)
 #define  CSR_GTLBC_TOTI_SHIFT		13
 #define  CSR_GTLBC_TOTI			(_ULCAST_(0x1) << CSR_GTLBC_TOTI_SHIFT)
 #define  CSR_GTLBC_USETGID_SHIFT	12
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 74d31f260dfd..e849ebacd268 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -241,6 +241,12 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 	if (config & CPUCFG6_PMP)
 		c->options |= LOONGARCH_CPU_PMP;
 
+	if (c->options & LOONGARCH_CPU_LVZ) {
+		config = read_cpucfg(LOONGARCH_CPUCFG8);
+		if (config & CPUCFG8_S2TGID)
+			c->options |= LOONGARCH_CPU_GUESTID;
+	}
+
 	config = csr_read32(LOONGARCH_CSR_ASID);
 	config = (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
 	asid_mask = GENMASK(config - 1, 0);
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 0099d0f0b803..e43ed4c11d31 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -358,7 +358,7 @@ int kvm_arch_enable_virtualization_cpu(void)
 	write_csr_gcfg(0);
 	write_csr_gstat(0);
 	write_csr_gintc(0);
-	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
+	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI | CSR_GTLBC_USES2TGID);
 
 	/*
 	 * Enable virtualization features granting guest direct control of
@@ -381,6 +381,8 @@ int kvm_arch_enable_virtualization_cpu(void)
 
 	/* Enable using TGID  */
 	set_csr_gtlbc(CSR_GTLBC_USETGID);
+	if (cpu_has_guestid)
+		set_csr_gtlbc(CSR_GTLBC_USES2TGID);
 	kvm_debug("GCFG:%lx GSTAT:%lx GINTC:%lx GTLBC:%lx",
 		  read_csr_gcfg(), read_csr_gstat(), read_csr_gintc(), read_csr_gtlbc());
 
@@ -399,7 +401,7 @@ void kvm_arch_disable_virtualization_cpu(void)
 	write_csr_gcfg(0);
 	write_csr_gstat(0);
 	write_csr_gintc(0);
-	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
+	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI | CSR_GTLBC_USES2TGID);
 
 	/* Flush any remaining guest TLB entries */
 	kvm_flush_tlb_all();
-- 
2.39.3

