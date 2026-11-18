Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024721;
	b=TdZnCV/SRFmIdtA4LpEwkKTQiO1Zg+lwGlulcoDD3IFEln+Nr3keuIG++WR1uL8HRz+y
	 fT1Ky48OfUmPaNvNHR9GX2jPP7s4GPfUejyyvUZjrWr9BNuMte5WMiWwPUk3gtZHTN5E5
	 yQcDC0sUr+qHQpz7VHqk+lnJVaNt4cyfAdqutxTj4rb59OCmX9Xo9X732QTsqd3vDf9Wf
	 Dtu6jprDeGakKjSxpvaldU6SlDH9oKl5n+FEsyqYGSD9xBfilDUp9qSFSUC4u2Hhl1Ddu
	 uTd7asib8+No3XGAn5fnyMmJH4pfmhxnd/kAM8ttkdZ/Ts85fa09ydpt3DlW6NlpLGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024721;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mn4Ggx29d50a4IUkBOUR4ytr+bcX51/dhy/wZQOyd28=;
	b=oisBXM5weFzK6V+xvunHy+R9QEdaGM/lj9nNXCflrjRhxa6PfMU4E3uPi8PGqVJoIuh8
	 7TpGyHLkmPhJCxzSs8I5bPktecSKln+IF9FQXnPYIxFjEIUGI+ODpzmqtAhEg1Zpndequ
	 U9xyBVOiJj/V4yO8XkPx2iGU+SHRu7l2Jwony0shgP8KnKQxUyay29uhK8IJTYw70Y00K
	 zF+5eyupgeI6Q0DMJ8LDgMQZS3Q9YpfGmoyw9WKvYs1PxGpPX/wfhqG3njCUpfZMLX+Ft
	 mnlfLDG1hJiiss8eUJSUADVS3bMuR3AldROQSfGRyVIpRALLtW0CmKzMyLiR2DtMX/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Uw05dw+L;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0EC606A320
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE0EC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Uw05dw+L
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EADEA1596;
	Wed, 18 Nov 2026 09:58:36 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94E323F632;
	Wed, 18 Nov 2026 09:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795024719; bh=k6zuUWy43e72ltP4EH+msPflCCVb8GSqJKNp9NcCmcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uw05dw+LN6eq9XZZGsws1lR3GWlyq9Vhw/kXnUwTz7gmS0ppptdgM5zdiOSdH8Ffr
	 nsSz0ISoAxK6CDucO8Mcp55TBWDhCe7SrDDFGimW4XfhOoId3/dsSCxK6Vveuh9nuf
	 tFxQnW019mMV/LnCL/6WBgtg38DCXliK1Nyhp6RE=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v5 08/23] arm64: Start GICv5 SPI line allocation at zero
Date: Wed, 18 Nov 2026 17:57:40 +0000
Message-Id: <20261118175755.1946977-9-sascha.bischoff@arm.com>
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

