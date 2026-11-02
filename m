Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655296;
	b=Rg+x50OpYy13HGoiAUUy/u+mvrXXvlwA7AJ35xzMMouHb60JPypLJz/JnKLc+eKxSFQo
	 I3eq6NWgXCQaFBQUDYI7rM8zpNKqInfhwF7PWenILBevKcwHCmhsS2CyCAyaLXZy2S943
	 Y88GmG8bD6Is7Rnv019cAnc/ubW2mXNgDg4y67oZoVCGwaA940g6EQGWNC3EXt8JcxEm6
	 L2s3M/Gy4BkHWhffgJFHZ4XY/GKXr1HhVe/JO2sKMk6NFtVJNjFYwBBeGmBkaDl7UKZEk
	 TEY2LBMLrd3QYI75KKqi13nwsBOC4h/HTsD7kOobQig+zlMwnFx9DZ1s3dW4/dbgqHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655296;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=srKSyCS4Ru2zUf0gjuvs1S6oRHT6jks7X3qvi0ipRVI=;
	b=UZstTkqtztczCR8q1YTx0iPMDFUMDg8DcfWpdDIvu9ufmxaWiXut1qODoKgS1INvJbkP
	 rQ8EknbooqVJKVfsBkYKd0q5tk/m8goyU4hC4Smpo8blrN0nwjUgdKarwk2G6hVnq6Jx2
	 ApvgHsPGxhpAyeXQNLOf9rmy6vmU9JHrYVvCkiAAxoTluGzL0Nac2lG3prMYwulNxmPL0
	 4J6YmGbt1XlO+Kgdg/JY9iEq+x1qCFWh49Rsc/rITH+U67LxqFgVOMlgrLQpcvKFA3Ik2
	 sCftDR2096QSAXwpxqphlTQRs3UnJxtAhhbMIssY1JowXeme7QbWEfNqaXHYQ2haREw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bjANUts8;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644F0606A32F
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 21:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 644F0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bjANUts8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC31D1595;
	Mon,  2 Nov 2026 13:34:51 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93A373F673;
	Mon,  2 Nov 2026 13:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793655294; bh=hWceZWLZ+2f/fzIv2zN2OspNTB8e4OnpKfuZZ4Svkcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bjANUts8tLTjNLLKfVAUomSszK0mpS2NQn5d8kXMuW9R2NMzIAHVrUQkyx/UitcLD
	 dxdfBUd/23L7PFUWZI9ke6LFKQAH2f9yCw5IjH200I/1mHjaptTZui1fhDdHwh4ydC
	 o3jITvb5D7nq15VsmxE4115hCdBoW14hkFPkYeEI=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v4 08/23] arm64: Start GICv5 SPI line allocation at zero
Date: Mon,  2 Nov 2026 21:33:58 +0000
Message-Id: <20261102213413.4136118-9-sascha.bischoff@arm.com>
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

GICv5 SPIs start at zero, while earlier GICs use an offset of 32.
Select the zero offset before allocating any interrupt lines.

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

