Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510083;
	b=gAwwMG0iG+y2vpKZpPI2VfwwyHyqrGE+J8AOREuxAE5ehpwRixuKCzthQ4Y4j3n6B0az
	 Dmu2czsVfjhiV/qbpaD5P+EGd9AspS4P1myw/+GF2GnSlRLLQrpllMqlzD/LeILDOSOFn
	 DvBj1GoRVquFCb83/SMwEhm3hkW4wqMVnqOrLxcbsLZLAEmNdEZvvzApOrluqNr0jdy3U
	 dPaT+1ZsdkRcRTOKx9oItFkXyDjFJ9/9rufqLEfcUyUDPPzhGy7fyadSVbCYzR7TQXSMj
	 lENAGYY5nANXVLk+O0YZkH/d8bKpbA/m+mDpqrDWuKX89sM/6NGwATjDcVPgrplPIQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510083;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=FSMjDfW2T1XSqaO7Z7hkdLLVctrFywse/htaeda2kjI=;
	b=iI9hnym6hUi9q0qZjV0RnsdKxFyEQzdYTS3uX+nTzB8ozBhP/F4hbezNGZtI/auIXByL
	 XaoHyoJ3kDIuuz4EhC0/hvGPRs1/KQ8OI9Xm1jBEOuXyynTaY3F2CAVABNzVogpKgRHBp
	 4SB1Yu6Sg16+vmLeFWuxf0GqOSLTZSZadFEKUDNe69hbnFKY/On1lNEm4lHaSI03MEg+7
	 ItbPH61nf+KCQuC3uKjZbePN97Wo2XzjYyu88wWwKgr7HhPCy++o0nSUVQTU8SH1GlRbm
	 2bIU1wbtJothzAgpDvB6UB2HZ2YphMnKBkwCc+JCdKilEML6VJOAVuCvXaxSz/5D/2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=PR0p5wkX;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F3606A31E
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 15:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A65F3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=PR0p5wkX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792510082; x=1824046082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FSMjDfW2T1XSqaO7Z7hkdLLVctrFywse/htaeda2kjI=;
  b=PR0p5wkXJXYqHjz5X6Y5AQRpQtHOyEykHBwzMqYI8kjTs9XpCLO3m0Hw
   HMqzI0IbpUUB2XhrA9ep2Sj9LyTc6KcrCw69JmE+xnp2x7d38YoEDZKAu
   r8xh6lRgPvGeoTcJT7BX1kvhjyT2hhZUyOccMEO6qPuT0xtt7GDvzS47L
   ZC6SyaJvJsXuqZZp/aTz5POUrleC30eSA36lglhBV2k5ppJwBQYadnIZT
   YTnJFD+wsjZsnNq9tDixqGSpHNhm+OP0E5PXXpWNamiAgTpCSIX82Hra5
   7kBjRVZbGoTJmBDbRmA1A9L0wQtPWy0dyhQtQvoOIMTjYlBVAbd993zGY
   g==;
X-CSE-ConnectionGUID: UQjKrmrmSbKuqGsve8G0Tg==
X-CSE-MsgGUID: oL4Ai8YjRyGmVjUOYknFug==
X-IronPort-AV: E=Sophos;i="6.27,168,1787011200"; 
   d="scan'208";a="31626825"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 15:27:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:6272]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.90:2525] with esmtp (Farcaster)
 id b9d57236-edd2-489b-b426-a02456740f34; Tue, 20 Oct 2026 15:27:59 +0000 (UTC)
X-Farcaster-Flow-ID: b9d57236-edd2-489b-b426-a02456740f34
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 20 Oct 2026 15:27:59 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 20 Oct 2026 15:27:58 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>, Andrew Jones <andrew.jones@linux.dev>
Subject: [kvm-unit-tests PATCH v2 7/8] efi: fix load_options_size conversion to character count
Date: Tue, 20 Oct 2026 15:25:24 +0000
Message-ID: <20261020152525.57694-8-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020152525.57694-1-gmazz@amazon.de>
References: <20261020152525.57694-1-gmazz@amazon.de>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

load_options_size is in bytes, but options_chars is used as the
iteration count over the u16 load options array.  Divide by
sizeof(u16) to convert from bytes to UTF-16 code units; without
this, the loop reads past the end of the load options buffer.

The original Linux kernel code (drivers/firmware/efi/libstub/
efi-stub-helper.c) from which this function was adapted performs
the same conversion:

    options_chars = options_size / sizeof(efi_char16_t);

This was lost when the function was ported to KUT.

Fixes: 85c3c524 ("lib/efi: Add support for getting the cmdline")
Signed-off-by: Giacomo Mazzola <gmazz@amazon.de>
Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
---
 lib/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi.c b/lib/efi.c
index f396bd71..d1be2bfc 100644
--- a/lib/efi.c
+++ b/lib/efi.c
@@ -134,7 +134,7 @@ static char *efi_convert_cmdline(struct efi_loaded_image_64 *image, int *cmd_lin
 {
 	const u16 *s2;
 	unsigned long cmdline_addr = 0;
-	int options_chars = image->load_options_size;
+	int options_chars = image->load_options_size / sizeof(u16);
 	const u16 *options = image->load_options;
 	int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
 	bool in_quote = false;
-- 
2.47.3

