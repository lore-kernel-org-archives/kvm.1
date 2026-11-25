Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619687;
	b=TXe7l4cSSgBi/NpGxHGqY9FIuKFUV7fZD+Q4KMVSdKwGlNm2vNONjMW9Azf0PNEAPnCr
	 QVlRhZpUYYvGXmSQWcKkIl3+mnziDEyArwiSVZNUe9xvEg3eKFATr/XqQI49UjCKxWLLc
	 RhfyW9BIvFXxZtalqpjJV20yv06PAALRhdgRGdluUI2n8jOhMyMHz2A/QZttXUO+Rs11B
	 /AwrFFDqjgt/HeD5EfPSFwbk3N0EZlpNoYEQ0cs6Uyv9m8wrGvR6iGGL3iFtF+EGxiqeB
	 6t/kaSKbktcO6NfTscRTUMNli/BwTvviuLcCkelLBHtw00e5txVjiE20yubiCTJTfwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619687;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Uv+QrL1hb3E8q8qlaPr/w05HjKdbUi66ksFf6isyfiE=;
	b=rhNOANjWACC9RltqoT9+Cm9QvonCzCko5YwMgeCYyraO3ON9UP8abrXDbHCBLuTusUni
	 JlfDnrSKa4hIqXtgkjW5WNkUKbAcCRZ1rhu7/Lkqt9qd7n40zRsH4arnDMq0ZGuunPmsN
	 sgDebLxsyglH8KhNGAcrciAu9VC03lUXtV1SB8AI9OHYG17ui0pRvoXvaqtuQ6oF7UjVI
	 0F3HZ9B420RP7aR6IiIME5r5TIrdLVQjZFXD+Zfmx3D5M3QMhbZw4/kRoymrPoqHyyuRU
	 nsI6qdDm69mMyP7J9+WIlUNK8qmV6zuGTk3+YFVhgagbkXDk7q1UnCP+C1IbZul4xxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Du1S1RZb;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18124606A323
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18124606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Du1S1RZb
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DF181762;
	Wed, 25 Nov 2026 07:14:42 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BE5C3F86F;
	Wed, 25 Nov 2026 07:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795619685; bh=rbFPjXaJgnyTNgicAecmcozOK/secmLDCqj3ux6hUws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Du1S1RZbht3t2P2R8/ZTMTKOoLzBRmA3AqxhVlXE7H7xX6Ej/MYKv4W2yKCy8hWlC
	 qJts7RZHuEJ2kT39BFSMAR6RIV7qrpCWTKbVUwt1DKlrwTvm4hZhLEYbFOFI7OBnbU
	 BTLwapV4ft83RjJvl1osN1rFoFjlr2QXwB3NZQ2M=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v6 11/23] arm64: Describe the PMU interrupt for GICv5
Date: Wed, 25 Nov 2026 15:13:44 +0000
Message-Id: <20261125151356.2875108-12-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125151356.2875108-1-sascha.bischoff@arm.com>
References: <20261125151356.2875108-1-sascha.bischoff@arm.com>
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

Use the GICv5 PPI specifier in the DT. KVM also expects the PMU IRQ
attribute to contain the GICv5 interrupt type in the upper bits, so
encode it before setting KVM_ARM_VCPU_PMU_V3_IRQ.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/pmu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arm64/pmu.c b/arm64/pmu.c
index ef7faca1..b3026d50 100644
--- a/arm64/pmu.c
+++ b/arm64/pmu.c
@@ -214,16 +214,17 @@ static int find_pmu(struct kvm *kvm)
 void pmu__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 {
 	const char compatible[] = "arm,armv8-pmuv3";
+	int irq = KVM_ARM_PMUv3_PPI;
+	u32 irq_prop[3];
 	u32 cpu_mask = gic__get_fdt_irq_cpumask(kvm);
-	u32 irq_prop[] = {
-		cpu_to_fdt32(GIC_FDT_IRQ_TYPE_PPI),
-		cpu_to_fdt32(KVM_ARM_PMUv3_PPI - 16),
-		cpu_to_fdt32(cpu_mask | IRQ_TYPE_LEVEL_HIGH),
-	};
 
 	if (!kvm->cfg.arch.has_pmuv3)
 		return;
 
+	irq_prop[0] = cpu_to_fdt32(gic__get_ppi_fdt_type());
+	irq_prop[1] = cpu_to_fdt32(irq - gic__get_ppi_base());
+	irq_prop[2] = cpu_to_fdt32(cpu_mask | IRQ_TYPE_LEVEL_HIGH);
+
 	_FDT(fdt_begin_node(fdt, "pmu"));
 	_FDT(fdt_property(fdt, "compatible", compatible, sizeof(compatible)));
 	_FDT(fdt_property(fdt, "interrupts", irq_prop, sizeof(irq_prop)));
@@ -248,6 +249,8 @@ int pmu__init(struct kvm *kvm)
 		}
 	}
 
+	irq = gic__encode_ppi_irq(kvm->cfg.arch.irqchip, irq);
+
 	for (i = 0; i < kvm->nrcpus; i++) {
 		vcpu = kvm->cpus[i];
 		set_pmu_attr(vcpu, &irq, KVM_ARM_VCPU_PMU_V3_IRQ);
-- 
2.34.1

