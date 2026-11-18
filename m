Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024751;
	b=u2EbeSUCtwOChg0T5j9U1s9l84x/CvHbEBWZVv5Ckd5JG/Zqq8vMxzoYzrcUAOZaLp2z
	 fPkmTUqTd+pSn5e9Y3gwTD8Fvr/JHr3ZHl+w5sQG2HpsySPqrmLsdsgB1oH/vn7BSkl+v
	 d/WknUjnXopzHTnrUprwp1sPBhACXJdA6a6wN0FKCQQsSMrv4ngyL1RsPsYrhfdfFp6pU
	 n1oHOe1w9lepZcNQqL+oT8vqVhH0EqAIJyjFWpcy7cQ6GJ7b3eP2Vy3K5mxg+k1rPrRDH
	 LHcZpAsCPffyWGsXXmGdw1hkf6qZaZogzqqO51l+9HEDltDHf4A84gbkJfbyy+8eNxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024751;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HTo05RBj3y4hvuDtxye5VcS0OpIbiG4DQPfPMCmpV9A=;
	b=ljeywm3bKLVi+tQHY3mWISnYQEdgkPaWjkOSGUhy94xfaCdyq9AjfEsNhqd4UQM10tE6
	 GZJv5Zc1/V0+r6YDakh5/py1MI0zCgr7wfGZ/z4irqfI2rEKsPOb/0mWuKrZ7pMz0eK3f
	 Ae+Nc/1LRg/2f8NjGif4V5CMt0yTP1UYjaw/gzQmRPky7tSF4BvPP++hmnyOAlsmi0INd
	 AhtJ4la9LoSqNTSkjAHT1EyuNn/A31ywGwzyJsSACzdj2v2U0ACbOHIbPywwikRJGuBuC
	 1WxyCDRJy5PKzAmPW+b4T9HUPbz82cK+f/N46VQUAAqhvRMF+rrJDS6oduPVGK7iw3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=N9o4qiCG;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426A9606A32F
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 426A9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=N9o4qiCG
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5A861596;
	Wed, 18 Nov 2026 09:59:07 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E6373F632;
	Wed, 18 Nov 2026 09:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795024750; bh=8yrs4gsSwEcKjiP13a3N4elKx2UY7onTNUl8hLFf1nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9o4qiCGcrnXNFcqlv9uI+yAreICU2rIQKtP1fJKVXbic3h89BnGWbbH+eaooqTTM
	 bf4RThnnWCOG2djsPcGTMEsS3tSjDGJhcFEZrk6mQVaDc++RchWRIzQtMiIfqEYcqw
	 aYEZ9JHZEJ+eAEO5iTF7v1hs+HFvhPgiVYZA3A0k=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v5 16/23] arm64: Generate GICv5 SPI specifiers for platform devices
Date: Wed, 18 Nov 2026 17:57:48 +0000
Message-Id: <20261118175755.1946977-17-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118175755.1946977-1-sascha.bischoff@arm.com>
References: <20261118175755.1946977-1-sascha.bischoff@arm.com>
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

Use the GICv5 interrupt type and absolute SPI number for platform
devices. Preserve the legacy GICv2/v3 DT encoding for other VMs.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/fdt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arm64/fdt.c b/arm64/fdt.c
index 5413956d..e92ae044 100644
--- a/arm64/fdt.c
+++ b/arm64/fdt.c
@@ -63,11 +63,13 @@ static void generate_cpu_nodes(void *fdt, struct kvm *kvm)
 
 static void generate_irq_prop(void *fdt, u8 irq, enum irq_type irq_type)
 {
-	u32 irq_prop[] = {
-		cpu_to_fdt32(GIC_FDT_IRQ_TYPE_SPI),
-		cpu_to_fdt32(irq - GIC_SPI_IRQ_BASE),
-		cpu_to_fdt32(irq_type)
-	};
+	u32 irq_prop[3];
+	u32 type = gic__get_spi_fdt_type();
+	u32 intid = irq - gic__get_spi_base();
+
+	irq_prop[0] = cpu_to_fdt32(type);
+	irq_prop[1] = cpu_to_fdt32(intid);
+	irq_prop[2] = cpu_to_fdt32(irq_type);
 
 	_FDT(fdt_property(fdt, "interrupts", irq_prop, sizeof(irq_prop)));
 }
-- 
2.34.1

