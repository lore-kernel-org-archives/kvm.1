Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655332;
	b=3dlHIpepRQJ5LlIQMcxJZGI47ERzPIibQYj+zowZtszRmiqaiHgYBNDO7P8ssujskbMz
	 3Yyu+4d1EHdiSU6XVqAU7LbSUVewrFgataGAtXK/7frGFKNBuCMua28Z+wLAlwAl9L8Oz
	 MvMBqF7dfUfjKJ1e2PaAvVG1ufss98gKnAzgWVtJjlLSWfYmPQprxLW1NQJeAlBWKDhPn
	 exaFxhMIFrGGcsDCLnoDe3F544o7bzRPkR/YrJx5pdbgWfr/P5YnWU2WrpLIc1z20QGnH
	 RtsOoAsfmIdYXyrXOGnVjFc1Ojt6c1yR4PJTRZ2BXMm0odoOWrUtEZZF7mvHsKy+u+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655332;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zvhOHxXZZ6+gW30M8bWPkm6olFasKYVgZ/doazJ3cr4=;
	b=tBhjxWNjJbLLt+5ljNwEWMXkV55+L4en9Qx0Hs3vseTI13zPfP0BFm9zvG5lpP5lDjeP
	 x8m0dJUIuZMjWKyhJXLZs2CVZLmlMHPuTi0Zxtozf7NAafW7LeYTAtPA1iUTz+q1PreX0
	 uWSZZ7+HCLr10dGMIUBMYJNwSTVKPBXVQengXsZlsZ3GKW091N3eQ+vyLD743+HAH2euf
	 JV4WmchNYLGsrTGvdLhbnUa3Ubf/Od0oSrIjrXakHb6v3r64EmHkqQeZPISKNpHfCss6z
	 hbs/lMzaQuxcgARaVUOOBgaXSVaLJusd1wE8Of8b+YRcjlixXX58JaVcJWVd/P49CWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="LJ4/1KpC";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF166082BD0
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 21:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEF166082BD0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LJ4/1KpC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ADF51595;
	Mon,  2 Nov 2026 13:35:28 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0345F3F673;
	Mon,  2 Nov 2026 13:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793655331; bh=GaLxJ3a/0pIXn9up5YlZHldzskDf9/12B6QBi3vWyNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJ4/1KpCvFpF4U/addp7bZgR50m+HWlBJFQWwJKPxLGUGUgRTZfGcHp0DW8Vl1low
	 l2Ho0wSPwD3BFAI2gEGdMENexgOPgFt9RslxxG+mVGbT7q4Xwp6y0dIrkHZA/oFcGL
	 eZ/bIHz5v38ztCnbjm4xnLDu3IAOJvwy0Ex7pOt0=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v4 17/23] arm64: Generate GICv5 PCI INTx specifiers
Date: Mon,  2 Nov 2026 21:34:07 +0000
Message-Id: <20261102213413.4136118-18-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102213413.4136118-1-sascha.bischoff@arm.com>
References: <20261102213413.4136118-1-sascha.bischoff@arm.com>
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

PCI interrupt-map entries currently use the GICv2/v3 SPI type and an
IRQ number with the SPI base subtracted. GICv5 uses a different SPI
type (matching the hardware) and zero-based SPI numbers. Use the GICv5
encoding for its INTx entries while retaining the existing encoding
for other GICs.

Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arm64/pci.c b/arm64/pci.c
index db87db8b..91265f67 100644
--- a/arm64/pci.c
+++ b/arm64/pci.c
@@ -84,6 +84,8 @@ void pci__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 		u8 pin = pci_hdr->irq_pin;
 		u8 irq = pci_hdr->irq_line;
 		u32 irq_flags = pci_hdr->irq_type;
+		u32 int_type = gic__get_spi_fdt_type();
+		u32 int_id = irq - gic__get_spi_base();
 
 		/*
 		 * Avoid adding entries in "interrupt-map" for devices that
@@ -108,8 +110,8 @@ void pci__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 			.gic_addr_hi	= 0,
 			.gic_addr_lo	= 0,
 			.gic_irq = {
-				.type	= cpu_to_fdt32(GIC_FDT_IRQ_TYPE_SPI),
-				.num	= cpu_to_fdt32(irq - GIC_SPI_IRQ_BASE),
+				.type	= cpu_to_fdt32(int_type),
+				.num	= cpu_to_fdt32(int_id),
 				.flags	= cpu_to_fdt32(irq_flags),
 			},
 		};
-- 
2.34.1

