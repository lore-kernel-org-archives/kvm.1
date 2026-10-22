Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792686706;
	b=UuDhUOr+33SYXP2g4hBZESo7EUhG5quSodDUr4kTfX32pIDTAl5tKSBab1k0qlURedWY
	 WWSndOI2gxBsh753cEv7M5WHFXGw8LBkRnJKyUoR4kmi6skUc4seJsHp++3Q/xvUWyXXT
	 28sXD/o6u0f4A2uuDnw4e0OfQhRF04vA+dMdnKBGfrkrZYLiDKJjVqAX+TFiuAl+eAVbx
	 velD7LWuveaVlWi49R6cKi+e5+euJO5UHtokGS/i90f8roxgkVuR+Aw4Emwj6ZAWirzA9
	 lDXoDtlEL0eeiPjHSyverzN4on1C3yC22ssOmErcKdqS6VxRIO3z1fIeGTLQ3UNR1WQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686706;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zfmkGR26biULCCpkdz9z11eYXUUcEbs91FqVrijv5ks=;
	b=oPtWKqB1BB+7Q3U/RHCPDsDquToPbQmlaO1i6uZmFkAX57ZpxAzz0TTILHRJEzSoCnnc
	 YqlnVxXp/Z7dKlqkKKBMG66jjaMuN4efE3CUliVVvq9oYCuSF6o0gX0D1ZVqSdOA6Fjhx
	 cAEN1MgfoKRYuLvAINE1u1Vu2DjWfO+w4bM4GkDj4kGlMvlM+NERX+It5/fk6VXgjY8JD
	 Vf1v7QHJKrf56B9X4xrQZt5AtdPopA6wDQGF+3/4MEWu8TxAUubFHzYJTurcVc4BkiBdS
	 JTlXveVatHBbtILIUT/G0O4CD6g+OZSo1hIZSL1BiZhq5jmgum5J/OXaPUgjdvC8I2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZjzKOwL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95A606A319;
	Thu, 22 Oct 2026 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZjzKOwL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792686705;
	b=K/37uFVFSmBkmV9YKzdmrv9o7VvPhU7wfIHP4VjYi2eTjiTsEwHwSumBfEsJ9WcBDt4e
	 1+mtE12EuLewiXInOEZfu6wU2DuSAsWGrw8iL8+NLQze49+jEGRYcEbSja3mto3fIS0Ql
	 moY5qCv9NFqhtgsss5DO29L7XM9MzjaI9NsXGVOPWNiV05p/O89OWFzr3qSMERJag+70R
	 F7vOx3MfI26gtIgW5WgUHyjNnYYGcVhl62hANBuJNlSjztMYqsL/S9hpINHntN7rrQuQF
	 bZFq0TZ84aYLGl+lFXR3m9Ci5VRpmtQgoariD6AqmM4maCPlIc052AREqckOO3aduQA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792686705;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zfmkGR26biULCCpkdz9z11eYXUUcEbs91FqVrijv5ks=;
	b=QxvMpDbdaAdt+kTx0Uds7z1t9RdM59tHMcqoUojxizJJ80K5hKqSfnmKcHhN9RxHs403
	 nLGVYFHkMEuWqnCHGTVeZ180YPwHX0aKxIYT34QwCOz56YsHBbiEZfjtO0naOVMhlFyMt
	 aRerAv30sVLAsiDOdUDAQ5im9Y8qjkicqXHxta4dZeR1ePE4VkqhHYMnyZxZx684UGVkm
	 gzu6C7S3RTYhfYYVKrxmwvz8k4ioRGbrc/p07cZaFjMCj2i05a18praC+OqVjiDesOBH+
	 pQBUjFICp7Pkpt+edwDlYFSkqxVLcLwPrrzrTmL/syELOO0hEB5x0GxCOdE6pApZvRw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9C13A1F01828;
	Thu, 22 Oct 2026 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792686705;
	bh=zfmkGR26biULCCpkdz9z11eYXUUcEbs91FqVrijv5ks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gZjzKOwLlnrWNf528ajgJyDycB8+FA/GCFzOq76ThxIGVwta9IY4l3nttw6qbdnBI
	 nuydHg6Bt/3zsmkD8FGoxhWSwVlw4rjTyakwDibAIkx9Km490YBWgc5eLbUq5SaSlJ
	 Oc0+yQ5q70yCHi5Gz5Rh9sUrEhnfw420kd/F+9scGZcteukgdpFWV8lOTdr9gJP5vA
	 dvBwn/VMT3Rbsj06/d74y30hdirbzTLnUIkqP7bA0VzrGvHhWKjpATIKvcqu19lEhX
	 cn5UyXvW7noMfIJPsiDpxhWY6uk4M4r36oxcjf8Bn4qpkb1/KFo5PhRrvpArHwvibu
	 vhDweVnFp10nw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 305F741E73;
	Thu, 22 Oct 2026 16:31:44 +0000 (UTC)
From: Moe Mahhouk via B4 Relay <devnull+moe.flashbots.net@kernel.org>
Date: Thu, 22 Oct 2026 16:31:41 +0000
Subject: [PATCH v2 1/2] virt: tdx-guest: Fix timeout detection in
 wait_for_quote_completion()
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261022-tdx-guest-quote-poll-v2-1-7543c6eb2d36@flashbots.net>
References: <20261022-tdx-guest-quote-poll-v2-0-7543c6eb2d36@flashbots.net>
In-Reply-To: <20261022-tdx-guest-quote-poll-v2-0-7543c6eb2d36@flashbots.net>
To: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Erdem Aktas <erdemaktas@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Dan Williams <djbw@kernel.org>
Cc: Jun Miao <jun.miao@intel.com>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Moe Mahhouk <moe@flashbots.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792686704; l=1829;
 i=moe@flashbots.net; s=20261021; h=from:subject:message-id;
 bh=YaSIvAAyOdwGXioa5qC1w+XfaeHGA1mdgyIez+tbqmI=;
 b=gop851gcNfC9FdA8rDtgApXoAypDqEwm9vBsHIfarMsYKnB/wXH8uxG49GfAyZWG28NmwFcMs
 CHj3aeTmSQIDQj74Yoa2z9lMdTPaMxAk5xsdwb459xgf5rydkSrLnRA
X-Developer-Key: i=moe@flashbots.net; a=ed25519;
 pk=hJTKfjLno/YESrpxMIKDJk34GM+/8Tol+24XK2b4xf0=
X-Endpoint-Received: by B4 Relay for moe@flashbots.net/20261021 with
 auth_id=1259
X-Original-From: Moe Mahhouk <moe@flashbots.net>
Reply-To: moe@flashbots.net
Content-Transfer-Encoding: 7bit

From: Moe Mahhouk <moe@flashbots.net>

wait_for_quote_completion() counts the seconds it has waited in i and
reports a timeout when i == timeout. That gets both outcomes of the
last second wrong:

- If the request is still in flight after the last sleep, the loop
  condition increments i once more before it fails, so the loop ends
  with i == timeout + 1 and the function returns 0. The caller then
  returns -EIO instead of -ETIMEDOUT, without the "GetQuote request
  timedout" message. Before commit 0f409eaea53e ("virt: tdx-guest:
  Return error for GetQuote failures") a timed-out request even
  returned success with an empty Quote.

- If the VMM completes the request during the last sleep, the loop ends
  on the status check with i == timeout, and the function returns
  -ETIMEDOUT for a completed request, discarding the Quote.

Decide on the Quote buffer instead: the request timed out if it is
still in flight when the wait ends.

Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
Reported-by: Kiryl Shutsemau <kas@kernel.org>
Closes: https://lore.kernel.org/all/atoHWgQF-0vlTRK4@thinkstation/
Signed-off-by: Moe Mahhouk <moe@flashbots.net>
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 11d741da3b35..a5a53174f9d9 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -282,7 +282,7 @@ static int wait_for_quote_completion(struct tdx_quote_buf *buf, u32 timeout)
 			return -EINTR;
 	}
 
-	return (i == timeout) ? -ETIMEDOUT : 0;
+	return (buf->status == GET_QUOTE_IN_FLIGHT) ? -ETIMEDOUT : 0;
 }
 
 static int tdx_report_new_locked(struct tsm_report *report)

-- 
2.34.1


