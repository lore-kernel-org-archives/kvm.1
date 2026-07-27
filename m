Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4754908BF;
	Mon, 27 Jul 2026 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137472; cv=none; b=c5WUCVWbXPHOewHoGzA/i3NaptED+WgLlTHbeNpfFZnWjA3LtSuvZM6ddJEgwNc/pvq/BFgKzP4bExPGnUmj2F3RSJYvUH4JlnOxgi/YZyn7giexa5u0SIN5N0ae6eu9sst5pGDgZicpJPLi0GcqlZmEyMDxvGJvadh5BERVxWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137472; c=relaxed/simple;
	bh=nzIUANyQ67sj0RajWKzCUMVp6O1CkNspOyvI5v3HwlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=apOlxtGSeDQZ5BlIsHOFelneOt4+NQqrW6pZYIh7FEFzppcDSkGut3Mi87PHRh2QxWCofvy0e/WNEb9RxqyuVDJIsMbQj/QChdQadXuNJygTEQTQ5Iv6pAeHWHUcunQYP3mvMX3jwWIJ7RNckLLJX/pCvljO5GPbRDWBMXF3dzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cxg+g7CWdqwqkHAA--.4057S3;
	Mon, 27 Jul 2026 15:31:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxLsfqCGdqOz4aAA--.51743S4;
	Mon, 27 Jul 2026 15:30:26 +0800 (CST)
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
Subject: [PATCH 6/6] LoongArch: KVM: Enable separate vmid feature
Date: Mon, 27 Jul 2026 15:21:09 +0800
Message-Id: <20260727072109.2151675-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260727072109.2151675-1-maobibo@loongson.cn>
References: <20260727072109.2151675-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxLsfqCGdqOz4aAA--.51743S4
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
 arch/loongarch/include/asm/loongarch.h | 2 ++
 arch/loongarch/kernel/cpu-probe.c      | 7 ++++++-
 arch/loongarch/kvm/main.c              | 4 +++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 2a6bc99177d8..4c4249446a61 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -350,6 +350,8 @@
 #define  CSR_GTLBC_TGID_WIDTH		8
 #define  CSR_GTLBC_TGID_SHIFT_END	(CSR_GTLBC_TGID_SHIFT + CSR_GTLBC_TGID_WIDTH - 1)
 #define  CSR_GTLBC_TGID			(_ULCAST_(0xff) << CSR_GTLBC_TGID_SHIFT)
+#define  CSR_GTLBC_USEVMID_SHIFT	14
+#define  CSR_GTLBC_USEVMID		(_ULCAST_(0x1) << CSR_GTLBC_USEVMID_SHIFT)
 #define  CSR_GTLBC_TOTI_SHIFT		13
 #define  CSR_GTLBC_TOTI			(_ULCAST_(0x1) << CSR_GTLBC_TOTI_SHIFT)
 #define  CSR_GTLBC_USETGID_SHIFT	12
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 74d31f260dfd..cbf1dafac0a0 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -135,7 +135,7 @@ static void set_isa(struct cpuinfo_loongarch *c, unsigned int isa)
 
 static void cpu_probe_common(struct cpuinfo_loongarch *c)
 {
-	unsigned int config;
+	unsigned int config, version;
 	unsigned long asid_mask;
 
 	c->options = LOONGARCH_CPU_CPUCFG | LOONGARCH_CPU_CSR | LOONGARCH_CPU_VINT;
@@ -221,6 +221,11 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 	if (config & CPUCFG2_LVZP) {
 		c->options |= LOONGARCH_CPU_LVZ;
 		elf_hwcap |= HWCAP_LOONGARCH_LVZ;
+
+		/* Separate VMID and VPID with LVZ version == 2 */
+		version = (config & CPUCFG2_LVZVER) >> 11;
+		if (version == 2)
+			c->options |= LOONGARCH_CPU_GUESTID;
 	}
 #ifdef CONFIG_CPU_HAS_LBT
 	if (config & CPUCFG2_X86BT) {
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 86b1af823e2b..43f5b40786f2 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -365,7 +365,7 @@ int kvm_arch_enable_virtualization_cpu(void)
 	write_csr_gcfg(0);
 	write_csr_gstat(0);
 	write_csr_gintc(0);
-	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
+	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI | CSR_GTLBC_USEVMID);
 
 	/*
 	 * Enable virtualization features granting guest direct control of
@@ -388,6 +388,8 @@ int kvm_arch_enable_virtualization_cpu(void)
 
 	/* Enable using TGID  */
 	set_csr_gtlbc(CSR_GTLBC_USETGID);
+	if (cpu_has_guestid)
+		set_csr_gtlbc(CSR_GTLBC_USEVMID);
 	kvm_debug("GCFG:%lx GSTAT:%lx GINTC:%lx GTLBC:%lx",
 		  read_csr_gcfg(), read_csr_gstat(), read_csr_gintc(), read_csr_gtlbc());
 
-- 
2.39.3

