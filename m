Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873603B9DA6;
	Thu,  6 Aug 2026 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982503; cv=none; b=hgMvDNYbn7SUuOYajm3Y5QnoIbsqXx0nCrRVC0OSpBazOKcA22Mt1GeikdWwW1lu5BhLw1lz21ucKDNcr3YkgtxelPvgpcRwFBtFra48UfF4bH/7mGFk5t8GwURsKjE8J33QnknCOHG6EE+rBn+Qn1Wuu0zpuqtw0kmn4PC/d0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982503; c=relaxed/simple;
	bh=SrwofF6fkmtOFWRnvfCn/7l/BmUSaJg3/yEnOArDwjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QnQn8F/+Do8VmkdugphK/3cNux1DZovANfT75kZNrbOmj2+ROscJpePBOptuLDt24Q3NSvPycr1zH7baDXnJj5V0NEWopB/DCiKRF41WLUH2wxQT4cGhEOcIfESDaSv6KQt4+AfP3oJA541lmXBXrQ1/Sq7ua0F5Ect/7wuCfE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Dx2KAj7nNqRNsKAA--.11729S3;
	Thu, 06 Aug 2026 10:14:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDxzMYi7nNqCFQlAA--.58013S3;
	Thu, 06 Aug 2026 10:14:58 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Arnd Bergmann <arnd@arndb.de>,
	Xi Ruoyao <xry111@xry111.site>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] LoongArch: KVM: Enable separate vmid feature
Date: Thu,  6 Aug 2026 10:07:39 +0800
Message-Id: <20260806020739.2149268-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260806020739.2149268-1-maobibo@loongson.cn>
References: <20260806020739.2149268-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzMYi7nNqCFQlAA--.58013S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With CSR GTLBC shortname for Guest TLB Control Register, separate vmid
feature will be enabled if bit 14 CSR_GTLBC_USEVMID is set. Enable
this feature if cpu_has_guestid is true when LVZ is enabled and the LVZ
version is 2.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/loongarch.h | 5 +++++
 arch/loongarch/kernel/cpu-probe.c      | 6 ++++++
 arch/loongarch/kvm/main.c              | 4 +++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 2a6bc99177d8..a20fb68d8ac4 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -138,6 +138,9 @@
 #define  CPUCFG6_PMBITS_SHIFT		8
 #define  CPUCFG6_UPM			BIT(14)
 
+#define LOONGARCH_CPUCFG8		0x8
+#define  CPUCFG8_VMID			BIT(8)
+
 #define LOONGARCH_CPUCFG16		0x10
 #define  CPUCFG16_L1_IUPRE		BIT(0)
 #define  CPUCFG16_L1_IUUNIFY		BIT(1)
@@ -350,6 +353,8 @@
 #define  CSR_GTLBC_TGID_WIDTH		8
 #define  CSR_GTLBC_TGID_SHIFT_END	(CSR_GTLBC_TGID_SHIFT + CSR_GTLBC_TGID_WIDTH - 1)
 #define  CSR_GTLBC_TGID			(_ULCAST_(0xff) << CSR_GTLBC_TGID_SHIFT)
+#define  CSR_GTLBC_USEVMID_SHIFT	14
+#define  CSR_GTLBC_USEVMID		(_ULCAST_(0x1) << CSR_GTLBC_USEVMID_SHIFT)
 #define  CSR_GTLBC_TOTI_SHIFT		13
 #define  CSR_GTLBC_TOTI			(_ULCAST_(0x1) << CSR_GTLBC_TOTI_SHIFT)
 #define  CSR_GTLBC_USETGID_SHIFT	12
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 74d31f260dfd..fc68f695d49c 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -241,6 +241,12 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 	if (config & CPUCFG6_PMP)
 		c->options |= LOONGARCH_CPU_PMP;
 
+	if (c->options & LOONGARCH_CPU_LVZ) {
+		config = read_cpucfg(LOONGARCH_CPUCFG8);
+		if (config & CPUCFG8_VMID)
+			c->options |= LOONGARCH_CPU_GUESTID;
+	}
+
 	config = csr_read32(LOONGARCH_CSR_ASID);
 	config = (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
 	asid_mask = GENMASK(config - 1, 0);
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 72c1d23156e5..712b078db0d5 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -359,7 +359,7 @@ int kvm_arch_enable_virtualization_cpu(void)
 	write_csr_gcfg(0);
 	write_csr_gstat(0);
 	write_csr_gintc(0);
-	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
+	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI | CSR_GTLBC_USEVMID);
 
 	/*
 	 * Enable virtualization features granting guest direct control of
@@ -382,6 +382,8 @@ int kvm_arch_enable_virtualization_cpu(void)
 
 	/* Enable using TGID  */
 	set_csr_gtlbc(CSR_GTLBC_USETGID);
+	if (cpu_has_guestid)
+		set_csr_gtlbc(CSR_GTLBC_USEVMID);
 	kvm_debug("GCFG:%lx GSTAT:%lx GINTC:%lx GTLBC:%lx",
 		  read_csr_gcfg(), read_csr_gstat(), read_csr_gintc(), read_csr_gtlbc());
 
-- 
2.39.3

