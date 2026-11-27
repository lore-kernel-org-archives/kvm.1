Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798981;
	b=JuDTsMKFoLDkos9jvGYy8zD0NeJUhBC0rOGMfucNkY8XbGERLR6RfTGQjAIE9FhMqpPD
	 Qa/k+labcUglt0iUbOv6NfGa7SzhRasSQoH9/GlbbW4BiDyOS7jDdvzYXRP7DCpj7XN+9
	 r1GqBz52YfWzGdXjEAYZ3XeJQ2vL1l65y25IrFKxppnc/Ju3CbR/33JSfAahmjd4aC/NN
	 8zVdds25l5RV/WhcG3X3cCjY+IjLQPbMfLl6q+ZOyUwpS1iu9DfnNN53+5xkGv/OzVamk
	 W47SYYcWGxmOySc6X1/N9Ia9YWL3oSWbg83myIs5x3xABty6kn/KOGUb9sIvuRi4CZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798981;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tVFHv5fcDxduoe5rLK81/cHawUIwJ7k88sNX30nlvJU=;
	b=5EMRoeziKP+STbOtMNa2tprAgH+Ct75eQmph5M7ycWRskdpuI/apoMN64LshFJoikdd1
	 R4STGebwJ604RsT2StWpB/GegDaJaY5yRTYpvHVClKJkluiqO/G6Ke30Hm6cATh+IM+FE
	 UebVb3+UqT2v6Ezd7KGn5uKYckoP2li0aTnfIWAQdziOGDwv7b9PKeC/ZJ5UcGnGbUDPb
	 LbHjMSHnwmkvUcWo1Wa5SHF6fFjRUcsSVprpIQfc8srMa1UMlDaEiVsTRh/AfgER4S9sW
	 aWUgnZIAbZY1YE3RFErCGtoofBqUKCK+ZADHwMkMb8SdPIGj5nzHkHS9VDIBJhrbVcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dYvoilDT;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ED3606A31C
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9ED3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dYvoilDT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B2D5169E;
	Fri, 27 Nov 2026 09:02:57 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF13E3F632;
	Fri, 27 Nov 2026 09:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795798980; bh=CZm0vDwtQsuU0m2+h4bJjr5Hus88SeA5JbAb2h2Ly1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYvoilDTdRCe2wA9z9acC5aahCeC/z3tulviwL+4i+xAQKTeZgA0EqCNk47A6D6ke
	 zdClWNzbvLjIC4aFE2dNVrwX4oEZG4rek/RU4opEUb1Yr9OW4QP8BB3fzxuu47eWMv
	 GFbBB8Rm1twXn74IsC4PnNrKWQeHWLe9kfdYkJ0Y=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v7 17/23] arm64: Generate GICv5 PCI INTx specifiers
Date: Fri, 27 Nov 2026 17:01:39 +0000
Message-Id: <20261127170145.4138182-18-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127170145.4138182-1-sascha.bischoff@arm.com>
References: <20261127170145.4138182-1-sascha.bischoff@arm.com>
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

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
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

