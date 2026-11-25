Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619706;
	b=FxH5CEggkvUetFrCLbZzO3Qr9DibzFggj7a/8LHyB9Uev59/0iac91kHy1ICM82lMqkh
	 mTQxouMHYEu5iqQ6yrlrT/1bnNbG1R6s7OwUIPVM1XzdXkF717iqW9MAPlk0fXIFO+V1y
	 gn6OOrWMJJh4bHAtVNqrHdzHXTy8Oq0zEigdETOuA56Wg5YGwjMvkBZ0U25Izi3YEIppM
	 2IHc4GeNG9JIhrkYXHe3wnc0hOfS0ISNOBQYCePForwRCgn3MVCP3F+WUyruzy47qcE9D
	 mtMMlt15sj3Vc7CKgJC5A4eQkyNzXQjfBdtALpeqAGMBcifnVBD0Xx0mizSo3sQM6Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619706;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HTo05RBj3y4hvuDtxye5VcS0OpIbiG4DQPfPMCmpV9A=;
	b=36oialEEmM6VdNYVBnzMejCeXbBuMKoVTAjmMJX+a5b4kf+lmkf2jkXFCkpU1+M+nnGM
	 HcJHTuRgQtcC1y41PG1xsFOmlpwU5I/L6usqZGfMlf2UCBUQh7Nre1qkNQUhxpyH5DVJT
	 7Mo9tl5zDXhdDfHCfkQYmlNKx7X20QG22icj/UuTqBf//fSVLLbSZaAT8hD29gMlel/I2
	 CuAM+pUg2/M19mUCiR9bVq/UmAloNTTfdJKvdKwMNNLOoG9Ov1qeSyikI/Ip2xxcnouHp
	 tSkEDMi7R2Ra7njODv1VkEMIxwAC/7HVdNg52pEScgn7DbvYtJyue7+OEMO3DnVhxsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=akvzzD1x;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A837F606A32C
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A837F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=akvzzD1x
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18F362F;
	Wed, 25 Nov 2026 07:15:02 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6F3C3F86F;
	Wed, 25 Nov 2026 07:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795619705; bh=8yrs4gsSwEcKjiP13a3N4elKx2UY7onTNUl8hLFf1nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=akvzzD1xj736g/KoPb3BLhwVN8sSRrxy4TKyXpCoCog+6kI57sFzlPGyT7sYhEGSm
	 Lp0BauFt/O9kyb8tVlADiT2A3Dv7+DYkUTFVQytmeY9Ros5UgLwOpuTArCZxFI4iy7
	 edyI2iThimCDB00PVmSHpAQK+ZQcsqmphTQOL0to=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v6 16/23] arm64: Generate GICv5 SPI specifiers for platform devices
Date: Wed, 25 Nov 2026 15:13:49 +0000
Message-Id: <20261125151356.2875108-17-sascha.bischoff@arm.com>
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

