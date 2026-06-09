Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E2731986C
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014387; cv=none; b=mrRCKr76q7VCMOM6q0gM2HSw7/cIgYaVBJsG2gUMhXD84nKQZ/NoS/CGEcYjhpY6FRnrZsEZYiwN78+Ehs5IhhWMJ0aIPDvoZDNLKxVMzs0m7AT1B/TSWPEpEuL1DKrLId1IhRsr78qXbYfkWiyd5t9LF5ZsFue4nguvS02eJp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014387; c=relaxed/simple;
	bh=zIgrUazTOQlab1mP9nGHFXOhsSZEeEkzSrpgfFlSCX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bs5gjyYOScLSYSevKYHbqm5mSXU584A4XBsaRxM7AKPrde2fQ4r+O3YksW2YgPOfiOCU3gvDgj1GeCyVcXEFnHLhKMyj/6LKJfzJOOlzUWoIDIkyo+tXV1T1CIkSs4Ygvxos/vWMwGmnSAmRTD2ejw/HnEuiQB0PcAgrGu3ZAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=bWmh6WY0; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="bWmh6WY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781014385; x=1812550385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bixjatcNkd037fpTCjGvUATEOH/+VOSOSP0C2XYYacw=;
  b=bWmh6WY0l3UqC1APFmt7wMRsQTT8//or1t6X6XOIlvITwXwLmaSweE1B
   VldGrtG7Qvf+cIzvpYmIcVlnBRQcvMnKzJMsnXhFH5CAhXfyjJJJAZmxS
   Dz+oi/JpSQSWCLAessSZrB15H7VyXf5mZAdW9PTG+x8FMTegs1mzUcmAr
   +rbsH5isN/iPGKgIp5I4MnIBooUKz8wwgoAi1DW3zxHgby3P6PnWxovnY
   YjMe2B7lyiL4dZukgE4krBLU6RV0eAzb/SEE6HQAPvIDpEFyyCCcj1cbY
   eS5tNEcp8eavG7lqBhkUueBedQHyh9tvGJ2QEdCDHDq0faezet0UC53jq
   w==;
X-CSE-ConnectionGUID: oc50yHfrTlCHjy2sJhfNHg==
X-CSE-MsgGUID: jL4MFlrpTPe/BOL5FMAJzw==
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="21209770"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:13:01 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:23200]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.27:2525] with esmtp (Farcaster)
 id a0ea2cbb-8527-4add-ab57-4e2c41403e79; Tue, 9 Jun 2026 14:13:01 +0000 (UTC)
X-Farcaster-Flow-ID: a0ea2cbb-8527-4add-ab57-4e2c41403e79
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:13:01 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:13:00 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH 7/8] efi: fix load_options_size conversion to character count
Date: Tue, 9 Jun 2026 14:08:59 +0000
Message-ID: <20260609140901.95727-8-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609140901.95727-1-gmazz@amazon.de>
References: <20260609140901.95727-1-gmazz@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

