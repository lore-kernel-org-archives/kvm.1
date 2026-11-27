Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798945;
	b=bKbkiHlHhOmp3eogl+FTqGFKMd6k9dGZxpZVyXRXRt9g/oXJiqHYS4ObRZMTyTyst2kx
	 K7SEyGWef78Ve+WI3RXGDGbWa/YbqO7lkpbFYas+TObdcsza5aJAd4ZNDOsFj4Gk/TOsw
	 RndTvGavXTBtDxCr3EZSrmUa8cx56SCcQnC9y35N8U9EIQMDUxlgFfQ1Es0BNluVcCfBA
	 nST/3+DXUG9o1IE1grJF1wf3IxvSn6IR3Alm2yuDhruVr3zZmXAS6ImJZU/OUIi9Fd+QH
	 0JUBleBR2V5KcL/kIHpnmPnjwhH3FNxRo9DSv67shYhQ0Mbyfc+a98gEUEsxycX//6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798945;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mn4Ggx29d50a4IUkBOUR4ytr+bcX51/dhy/wZQOyd28=;
	b=rm1cgKEOsOZFKiidRTQ9ATeb3pICWYe/rfDVxkk2lJb5Z1JNAs4C9Of/f1mywYBLD356
	 Pn4b64/7U8KXKbz5lkhs6TzxIaagpS8HTm9tp3UVcGeEePf68ctZM38RieaPruUAVp1oO
	 XoMtW0Bvg5tDJ/xdjg5siorAIxYZ23H1qJV3yh6bMNi1F2qZ344wKylSvQFeOPZzI6WJt
	 DzGOFe8JlQvxrvH53t1IudifUFKOj9AZDNlsRjOfG5R4WMlYXbj2qZ4xjvk/10O73MoqN
	 1J9nHsvSRLa4JQA8rPBkglvFHma1fy+a6HRFVvUkTrbybGHZbcewJ3biFuyaqUHfqVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NXW0aazq;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D21606A32E
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D21606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NXW0aazq
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 679FB1D70;
	Fri, 27 Nov 2026 09:02:21 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBE343F632;
	Fri, 27 Nov 2026 09:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795798944; bh=k6zuUWy43e72ltP4EH+msPflCCVb8GSqJKNp9NcCmcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXW0aazqy6I9TWZm4fCIpzi+vtgcxfMlaiFzXd+sRtfcfpafnpThmkZCGSbejD/OW
	 c/2a+/xyU6nxknx9BlvOLHisvWzKwX+R3eqwz8VbOfp0e2YDe0Hie+Aka4E6PTEJtf
	 OyP0rv1x0iTcpQ2Ko7lZwxeqoimRxDfz4z2oyQOw=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v7 08/23] arm64: Start GICv5 SPI line allocation at zero
Date: Fri, 27 Nov 2026 17:01:30 +0000
Message-Id: <20261127170145.4138182-9-sascha.bischoff@arm.com>
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

GICv5 SPIs start at zero, while earlier GICs use an offset of 32.
Select the zero offset before allocating any interrupt lines.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/gic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arm64/gic.c b/arm64/gic.c
index df5689a7..58644036 100644
--- a/arm64/gic.c
+++ b/arm64/gic.c
@@ -234,6 +234,9 @@ static int gic__set_spi(enum irqchip_type type)
 		break;
 	}
 
+	if (gic_spi_base == GICV5_SPI_IRQ_BASE)
+		return irq__init_irq_offset(gic_spi_base);
+
 	return 0;
 }
 
-- 
2.34.1

