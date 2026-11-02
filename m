Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655311;
	b=4iFcWVLMzn08WlwDParoM3m6MpsNqhiBEd7voGZixGjmpLNUnDtFRP5I/WbhqvC8tKdm
	 29mxCGF/FoYADgk3OCWt6ZtcMFRKMwJa5eA9YgPOEMoJzh6x+xrv0qvbh+SjWtRvvlQtX
	 mHVg1ygAKXEZEr11r7VKUO6FA9ZtnG08mT/tduwJA2yMIL64jY9wqhVw95oFjBVEXuar5
	 edNay0A7jN9cRzhFC0VlfQFOPI+ocUa+hfH9TmJpznijtAVMUqOXrdIzys0UQQ6FckEXy
	 9MjfhSVf0d/C7iuicqhq2u4vak740T/hIc+2RbyA7IsHX/uo3cVlV70vRMAYUQHh5Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655311;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YTdHceFIHuX2hn25hTLrg/0uXYJWfR396YcPpUWiUT0=;
	b=HWyvxhWFiCzlkR0pOt9CjAWNsftp4iIpHa68Q19r86L1M07CIGhef9VoMc9aJ4Bl9Fde
	 Du3+6ydrYYsFt98FeohIScr3LvHw0NpNd8aavhEcBztEj7QRFPohPdvNrBCNliPGnSQcX
	 w7jCYaLc79fN2ETn43Ornb4dnMiRnFNmCqnzxTa0xXSLhQzNYT7k5HFCY//B993k7JI2X
	 w5Ch4uQ6oIutvLnzFxuK7XopSVvGNa1bBQr9G786THgrMWNVjYQKP1u9lDEvu1Swm8Qyg
	 0fTdHyQ9/8v0PuPvsnAf4lJBc0kPtICv8M8G/xEqK8iSgcC1fLPLl1yA+HJxB6LDlWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="iMq/+Shb";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E28606A329
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 21:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4E28606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iMq/+Shb
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E25D1595;
	Mon,  2 Nov 2026 13:35:07 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38CFD3F673;
	Mon,  2 Nov 2026 13:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793655310; bh=8C9yB5pmXzwd06VKtkpuJOCFLJcSxezaZOYd3a+Syi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iMq/+Shb7TJSwGxwdj3ICOAAqXqEa1SXonURkhisYrY17r0jG7xj1usiUfg+k3fOD
	 e89klJLdRaeiSwTdZfAoySfCpZxCzj5kea8QW+h1b6PCSPZHjskuUjqXQ+EiuXCXjf
	 ojxFgG0ec9ZLGSSCuVIFITvgLKss0lMYJvD0xSvM=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v4 12/23] arm64: Describe timer PPIs for GICv5
Date: Mon,  2 Nov 2026 21:34:02 +0000
Message-Id: <20261102213413.4136118-13-sascha.bischoff@arm.com>
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

GICv5 DT specifiers use absolute PPI numbers due to having separate
namespaces for the different interrupt types. Keep the existing
GICv2/v3 specifiers by subtracting the legacy PPI base for those
irqchips.

Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/timer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arm64/timer.c b/arm64/timer.c
index 2ac6144f..01b9875c 100644
--- a/arm64/timer.c
+++ b/arm64/timer.c
@@ -9,16 +9,18 @@ void timer__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 {
 	const char compatible[] = "arm,armv8-timer\0arm,armv7-timer";
 	u32 cpu_mask = gic__get_fdt_irq_cpumask(kvm);
-	int irqs[5] = {13, 14, 11, 10, 12};
+	const int irqs[5] = { 29, 30, 27, 26, 28 };
 	int nr = ARRAY_SIZE(irqs);
 	u32 irq_prop[nr * 3];
+	u32 type = gic__get_ppi_fdt_type();
+	int ppi_base = gic__get_ppi_base();
 
 	if (!kvm->cfg.arch.nested_virt)
 		nr--;
 
 	for (int i = 0; i < nr; i++) {
-		irq_prop[i * 3 + 0] = cpu_to_fdt32(GIC_FDT_IRQ_TYPE_PPI);
-		irq_prop[i * 3 + 1] = cpu_to_fdt32(irqs[i]);
+		irq_prop[i * 3 + 0] = cpu_to_fdt32(type);
+		irq_prop[i * 3 + 1] = cpu_to_fdt32(irqs[i] - ppi_base);
 		irq_prop[i * 3 + 2] = cpu_to_fdt32(cpu_mask | IRQ_TYPE_LEVEL_LOW);
 	}
 
@@ -30,4 +32,3 @@ void timer__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 		_FDT(fdt_property_cell(fdt, "clock-frequency", kvm->cfg.arch.force_cntfrq));
 	_FDT(fdt_end_node(fdt));
 }
-
-- 
2.34.1

