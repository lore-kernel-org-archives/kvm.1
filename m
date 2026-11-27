Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798977;
	b=Yi1YJP1b9yLy21QW6NI+dxuFwWkKE1JidOQ35Vd4Yw/8QEkkrYwuQLzJwyYv5CsEozcc
	 f305ZAZoV4GkSg9BGmGNjgEQQu9/Y1c6sHcspABt9sEwkEQR6THp5oqX8nNcgE2ZvEww7
	 /let/K0f93f/eVKR4EGNkqmKmTsnYN6rYeULd8NAFAS2Ho3FcwAscz9jWcsM/sv32aWc4
	 P3uld755yrG+ethjV+gGD7sWFrP56sG4vUUdwYO+3U3t6ZrlkRfXUFZRFQRpje5iNzP8a
	 FT23pecgb0pD8ZzcBLaNksp3so1322Tdku7k2OjYozaLyZ9bpwCPBCOFqmddHZuGZOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798977;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1CDcARMABjSy8wBRDAxeUfNt9pwXWP3pgN8SPO0L7hs=;
	b=Cg/AMK7ViutA5VQiWm+b/KlMquSed/T2XexUtL+uwHkAhvTTaLUCfKgbbsrZ01SQdisL
	 K85O97mp+gFh58f+6gEp09FdcTGw/MPCUeW021g3nRb0N9G76HSgE91t/hNVCQ+KBHmZD
	 PNr9HRK+pjYIIwk54gXhnL5vm7hlXr8OxI7wG/X/pugCoXOlMitgLLUnE4jD5tisemKdE
	 8evzOTTKEf9/rJy1xk1xQbN8xgGLXY9RSxbuHOqHY29HEHn8bDOSQs5IpZsjYAq3zRDoL
	 OQVZM/oKDhWl+ERSkdvyUId1s4KHs3GPm6sUFnDoqdwAiv8aRnevWpUidLEH1PgIomA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=h1obFyq6;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4D6606A31E
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D4D6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=h1obFyq6
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32AD91E5E;
	Fri, 27 Nov 2026 09:02:53 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE7DF3F632;
	Fri, 27 Nov 2026 09:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795798976; bh=7YJ+Bc5IuE6NLDnB1G1TVkKbj+QVpiEFyKhvJKpIERo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h1obFyq6ARqAe9I+LV8xqLja3EvDF4cJNfuXkew1z4YOxh/e347p2XVYbjdd5vuCW
	 94KA7XG4jT4MfePTEASOb739w+EXkbAVz/udj3nG3uRaFXT5IIpDKmhWXP8stGd4+i
	 htt9u+kyumZOpKYcZ8djrdTDNDDrHTj+KffiKCjc=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v7 16/23] arm64: Generate GICv5 SPI specifiers for platform devices
Date: Fri, 27 Nov 2026 17:01:38 +0000
Message-Id: <20261127170145.4138182-17-sascha.bischoff@arm.com>
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

Use the GICv5 interrupt type and absolute SPI number for platform
devices. Preserve the legacy GICv2/v3 DT encoding for other VMs.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/fdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arm64/fdt.c b/arm64/fdt.c
index 363b3ace..b6f268a5 100644
--- a/arm64/fdt.c
+++ b/arm64/fdt.c
@@ -67,6 +67,8 @@ static void generate_irq_prop(void *fdt, const u8 *irqs,
 {
 	unsigned int i;
 	u32 *irq_prop;
+	u32 type = gic__get_spi_fdt_type();
+	int spi_base = gic__get_spi_base();
 
 	if (!num_irqs)
 		return;
@@ -76,8 +78,8 @@ static void generate_irq_prop(void *fdt, const u8 *irqs,
 		die("Failed to allocate the interrupts property");
 
 	for (i = 0; i < num_irqs; i++) {
-		irq_prop[3 * i] = cpu_to_fdt32(GIC_FDT_IRQ_TYPE_SPI);
-		irq_prop[3 * i + 1] = cpu_to_fdt32(irqs[i] - GIC_SPI_IRQ_BASE);
+		irq_prop[3 * i] = cpu_to_fdt32(type);
+		irq_prop[3 * i + 1] = cpu_to_fdt32(irqs[i] - spi_base);
 		irq_prop[3 * i + 2] = cpu_to_fdt32(irq_types[i]);
 	}
 
-- 
2.34.1

