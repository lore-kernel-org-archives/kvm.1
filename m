Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792686706;
	b=XktePYz6+p4uoSKZKaCYGH3Dhb7/M6dR7nwtI0GOR6B0yDpIVbgdCaoZnfxGrxL/cEH7
	 sYu2zVApPizTUfItM6JS/8THTMlhfhjUGpMBHh5tMRUBFcE5H7p8fBlPtC1Vj4R+M+6wE
	 izESkJUGquQVSJYeBcQFEh6V288CQyP2rMAeKg4grwh9lPTqq24vAUuwU56/aaHun9g1y
	 bjlbJG1fSKIZKqtSpznpTTrdS8LUUje3wAM1vMwVPXp1V/2j7rI+qGmyqE/qDCLGsSwxr
	 JGsiyp/bO/bRqOFdL+5LM/E8QwELXaEZ772Ztc1vujZvf3pJwJHnBuUS1WncLx8LQMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686706;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=D5UmFIxR9IHItWy0AJVLUgt5oLSnXfEJdHTIkJhtjnU=;
	b=SktElBD/uzULd4hsnFRUOam8UBEdzk8GS55zX55s6emsIeHS3RWCX60qf9wIiPELq0L8
	 noqxOb4Q6COGtBdC5/2zhKRqYHqHjw002tG7hK2XnGfnnEP7BoUUWUtQc8Ag2qWeVtWyx
	 xFQzB3Jt/iXszRCkd1bVLDUU8iPFEATf5vIjzbC4TFbk2uZdXXpZJQK3wBHSY5jXm5jKr
	 LUsKXP8magCakc/QHDQrMdft5CBY1TXRmqfqDTpMWf6mubxCUMjnVqlCF0o8nbDRvFeJF
	 F7W3/eyLJD5I/PtaI1hBPJND7SUJ5vdh2S6HBuBp18tJH9clp00LsL7blzjAwWkZzEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEsZuRJg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB2606A31D;
	Thu, 22 Oct 2026 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEsZuRJg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792686705;
	b=QLtE61UIPMAhox0mnORqFJutY7Hget2/0S9UyZvDyT4Shb9G2naBcoxgwCUzuHYewj2I
	 i++JLkg1Ky4TxJYkMlqk8Tuu+Vs7UeeJB0xMk5nlnSWioJolNYYm7Oqga+W2krCpI2nvs
	 IqLRPPgYdXQccdsMZYYzNgCjI0pmNdEglaIMe0TxcZUeayGqdtAsVG/VLnc/6K0rX+Mcu
	 f3vTHvEnXoJSVUNzFWA5TVGqYhvHI930a0qhi14I/LA1ugRV6puieAY/zCUjIFDnt0NTt
	 5nHbrmiYfejc/1Ar06vRMo2TRuFl1nrpTLUBgWVBPrMN/5EqM3jJg667lRY8u25N/JA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792686705;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=D5UmFIxR9IHItWy0AJVLUgt5oLSnXfEJdHTIkJhtjnU=;
	b=UO7v1vmA5ypIQfKdGlR1qGTFy00qQkLGp3V1qQComAFVs8D/tJ3Xd/VZ0aH30p7eq+eF
	 U3oqNaR7060XRiFSQCMuRM8bF0JbGAovp/77hheFVULhPFIDuLScK3zlGeo33hHNNe07+
	 tBvdjPm9qo/k/GLQzLbg64tHdiSLm3M3AzhNQNXApPbNW94I/DjZiC26nDaiO+fVbNcLU
	 gMv6o/DsPGp8WT1kF0Hn4g8znpelpigQmNZxu5ZjLKxRKz3ey/30RX2gf5RC8UsYFPNT9
	 0Xs/ZfyqYmwBmAzy2P81CYggtkltYJQyixC+Kb0C7Oi4UeenMRcp/3Q1DCWs7fbUFwg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A39EE1F01829;
	Thu, 22 Oct 2026 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792686705;
	bh=D5UmFIxR9IHItWy0AJVLUgt5oLSnXfEJdHTIkJhtjnU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NEsZuRJgE86QWv/zvbNwrMWw5xf+AsMQ4HAUdx5AIYY2Cojf8d2oeTEsSuamY/bV+
	 wwAEY3W4dv6x72Xku515uwBhcxujFwiDPhZT1thJjteMx+vzYxfcLtLa11f+txE9mp
	 NhZB5Dt9AmFeV3ykqivhbQsg1cAD0d59nYzu0EhJjPbUA+kSmV4lX5uf/8qu4mcJlz
	 iH9inIYOfi86S6RmxxprwAPDjL4RevbGFyEBfYzX4sCNVKuvNf3AJDF7/9y0EukXB+
	 k75U6YsBVrOzTIsPtIzi45xTYLKbEid+RhrdGAIs9v5tdAvaZ+YNgq0lstDiopaGy5
	 L8B6b7dz/Isnw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 37DFD41E6F;
	Thu, 22 Oct 2026 16:31:44 +0000 (UTC)
From: Moe Mahhouk via B4 Relay <devnull+moe.flashbots.net@kernel.org>
Date: Thu, 22 Oct 2026 16:31:42 +0000
Subject: [PATCH v2 2/2] virt: tdx-guest: Poll Quote status with exponential
 backoff
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
Message-Id: <20261022-tdx-guest-quote-poll-v2-2-7543c6eb2d36@flashbots.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792686704; l=2835;
 i=moe@flashbots.net; s=20261021; h=from:subject:message-id;
 bh=qSVE+hw1y6dS8lKhF55oe4BwZY0z5PC+umOVM8RdJVs=;
 b=Rd5lKcb7G0lbmQa+sbSVtrW/ii30WTcmvTRyosbGzigOVfjWjbpLDhs7VwADVmo74iAgjyxUd
 J2wjHqerY0ICEdFvlU7hYMFOKlbDVIxSdYtTzxAu0VamilZEO7JzAwT
X-Developer-Key: i=moe@flashbots.net; a=ed25519;
 pk=hJTKfjLno/YESrpxMIKDJk34GM+/8Tol+24XK2b4xf0=
X-Endpoint-Received: by B4 Relay for moe@flashbots.net/20261021 with
 auth_id=1259
X-Original-From: Moe Mahhouk <moe@flashbots.net>
Reply-To: moe@flashbots.net
Content-Transfer-Encoding: 7bit

From: Moe Mahhouk <moe@flashbots.net>

wait_for_quote_completion() sleeps for a full second before it first
checks whether the VMM has completed a GetQuote request, and then
rechecks once per second. Every Quote request therefore takes at least
one second, however quickly the host answers.

With a local Quote Generation Service the VMM completes the request in
a few milliseconds. On an Emerald Rapids host (KVM, QEMU 11.1, Intel
QGS), back-to-back Quote requests through configfs-tsm took 1021-1024 ms
each; with this change they take 6-12 ms at HZ=250. Since quote_lock
serializes requests, the one-second floor also caps a TD at about one
Quote per second, which hurts users that bind a fresh Quote to every
connection, such as attested TLS.

Poll with an exponential backoff instead: sleep 1 ms first and double
the interval up to 100 ms, so that a fast Quote is noticed within a few
milliseconds while a slow one costs at most ten wakeups per second. The
sleep stays interruptible, and the timeout becomes a deadline in
jiffies.

Signed-off-by: Moe Mahhouk <moe@flashbots.net>
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index a5a53174f9d9..000fff4ef6f5 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -16,6 +16,7 @@
 #include <linux/set_memory.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/sockptr.h>
 #include <linux/tsm.h>
 #include <linux/tsm-mr.h>
@@ -271,18 +272,24 @@ static struct tdx_quote_buf *alloc_quote_buf(void)
  */
 static int wait_for_quote_completion(struct tdx_quote_buf *buf, u32 timeout)
 {
-	int i = 0;
+	unsigned long deadline = jiffies + secs_to_jiffies(timeout);
+	unsigned int sleep_ms = 1;
 
 	/*
-	 * Quote requests usually take a few seconds to complete, so waking up
-	 * once per second to recheck the status is fine for this use case.
+	 * A local Quote Generation Service usually completes the request
+	 * within a few milliseconds. Poll with an exponential backoff, from
+	 * 1 ms up to 100 ms, so that a fast Quote is noticed promptly while
+	 * a slow one costs at most ten wakeups per second.
 	 */
-	while (buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
-		if (msleep_interruptible(MSEC_PER_SEC))
+	while (READ_ONCE(buf->status) == GET_QUOTE_IN_FLIGHT) {
+		if (time_after(jiffies, deadline))
+			return -ETIMEDOUT;
+		if (msleep_interruptible(sleep_ms))
 			return -EINTR;
+		sleep_ms = min(2 * sleep_ms, 100U);
 	}
 
-	return (buf->status == GET_QUOTE_IN_FLIGHT) ? -ETIMEDOUT : 0;
+	return 0;
 }
 
 static int tdx_report_new_locked(struct tsm_report *report)

-- 
2.34.1


