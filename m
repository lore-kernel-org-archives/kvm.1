Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792869444;
	b=2qYrS/lcoePlN6/ILAuACGcUCezpLxbYMZmQV/URBZ7+5FgNTqEkGN9aQaEtqRN3lcOx
	 952Wd+pvIPLlsH1YOwl//SmSmwReUyDRLPTNwMYjkEpA7ehb7aCRcS2cD6n9eQYuYfLW5
	 cl6Tuo9TwVPLvfLtVgfFp18c/0MZM8wEWL7QgRtTRylBu+BZxucxDLhgRDIZdt1M/eLOV
	 MpMyvG4RS9fuq4BDYefw4bf0an5zkVOGZsjr3D9WBjyx2T/mRHvf+QxpjnJCAJSwRJ7Q3
	 ubVowX6C9zPnDkpHRthHI2UM3FAcktb9KT5pk6kejKp2Wzl00lr+ooCbvMVnjLk5HTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792869444;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PsSHICQMngmsfiR6ihZH35CFAKnW+vhUGN8xKml/XKg=;
	b=BAJL6Yraz71HlyoxZOiFqYGWH3+F7gp1wRNax8StCVAUbNCMz3uCAdB0uCBatAEUD/9Q
	 8l0NblthBQnKcXhzSsRBXFvQUij5mstObaXO1i7KagxOXIXmtA78apO/gltrJveCTrI+B
	 BDr/zfsUD4Q0ukT+oGlCl3FtdGyp304gqAHTK/7ZSqOVq+lbecZKiLuRBBu/rHlrgP14N
	 flReNYJe+4YSuJR+vCiqP9kDdnbG1uIl91smeqlyjJ9XJE9J+ZCOriAcv1SJ4N3bNTT7e
	 7tsUeLkxICzx46LH9rPf6pr06pbVNyfC8YeIpPDkOB/cupLEwtLfrFhKMATP+UJwuXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XmVBSWuU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA56606A31B;
	Sat, 24 Oct 2026 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XmVBSWuU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792869443;
	b=D6fmOh5kRqjXIIJSieCmI3/1rS6H4gTJUpgBEVSIbf6FELRgTWlZwwXHrTug4pBM6PgU
	 UmQ95UHSYJ8HNADolSh8nislZVq9pJCcpl//ttyD2JOfq7T4PoUjK6dkz/yYa9bMx2x69
	 8xrjFaEcekoKLhayx3B0kmxafXUODjsFazFjNwHcTIE57bOvAW6LF+OMWtIFDB0ieLNJN
	 yclN3/RQJUJrhwr3ac4ibgUuSoEGLOlG2rkyr+Te3et9DEtBNlrLGaaVz4ww167hIl4at
	 JrFSmH1pXFvt+8gG/QDdcgf7P2eVX38qpWcnbmtoq9YItas3R5P4nniPVic8Oc9hs/w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792869443;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PsSHICQMngmsfiR6ihZH35CFAKnW+vhUGN8xKml/XKg=;
	b=kA0izmDqlofbLjeuFZmfvuyhCX7fn4uYXIvBNoWqq+aLDip/2Co7J1Ic9CdGLFn8P6tf
	 tNqvEXNpecZ6OA177jWu/GKoNy2UroeUKzQvWZ7txUpXP+DSW8gRR3/g6c6+dy1YJUoVZ
	 /gukeZ139KHXzG8b/fxOckIbZxCSsu6uMGheUiiDlsjJQRLQW1y1D02qcYcUMiqFh3LUZ
	 1HV2yuTKSbbpHZE+ZujuU8p+rcppqixNhIibWvPxnDWV/VW2hbb3u/veKBsTPHuBs8xHH
	 i8Ic16jYzH4+qGrPAKAoh0EPJDTh2fGLrbPsLri7iAHjKWOcTUZdxJMr2Tj8vEq6zFA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C64BB1F01828;
	Sat, 24 Oct 2026 19:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792869443;
	bh=PsSHICQMngmsfiR6ihZH35CFAKnW+vhUGN8xKml/XKg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XmVBSWuUHSiDwHrjMVIb7JY1Rz4ak7ka145DFb7/Ti1utnwwLls9M0GT54XStRRFX
	 wkmUgk8qqW+49ZkdQ02lwDpn/pkUqRcbXnFvMBJjKWODWalV5RR9c+5bMeABFCv0no
	 +Flm/B9X5kCqgGkTBpPdwNrtjMzAvLiSczWdIq8e+yBuFeP/amwmIQAPkkT5wMVJtJ
	 a/JeIStZ1fqEcgCtJvKdf6TJ47vNtw7DuZ2r2D546i6vXKhUTchycIvIAHeLMp5kXJ
	 czPwlge3ViBHl3qywzgNIq5k7Z80EDwzCgGenh/1CJTXGFwCorOkMV/jkEgbN1h77Z
	 4UqdXYqF66GJg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3A8CC44880;
	Sat, 24 Oct 2026 19:17:22 +0000 (UTC)
From: Moe Mahhouk via B4 Relay <devnull+moe.flashbots.net@kernel.org>
Date: Sat, 24 Oct 2026 19:17:13 +0000
Subject: [PATCH v3 2/2] virt: tdx-guest: Poll Quote status with exponential
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
Message-Id: <20261024-tdx-guest-quote-poll-v3-2-6a83bb767314@flashbots.net>
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
In-Reply-To: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
To: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Erdem Aktas <erdemaktas@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Dan Williams <djbw@kernel.org>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jun Miao <jun.miao@intel.com>, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Moe Mahhouk <moe@flashbots.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792869441; l=3161;
 i=moe@flashbots.net; s=20261021; h=from:subject:message-id;
 bh=9wLrH7YqqH84MzZMatdM4i6m5nN1ejaqoVcq375fEBE=;
 b=eLxTF7RjCr/NlBZDcr2wIPJaLyGbKqnr+6cYoqZXkprSmTHNs7XnnNu4EuYvkREcOKAz0DYte
 ctdRoi0YC4aBRkWIqLWL+tED/gTHUk63Yw+afTF5T9sQN8VdaISjYxf
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

Poll with an exponential backoff instead: double the sleep from 1 ms up
to 100 ms, so that a fast Quote is noticed within a few milliseconds
while a slow one costs at most ten wakeups per second.
msleep_interruptible() rounds up to whole jiffies, so at HZ=250 the 1, 2
and 4 ms steps are one 4 ms tick each. The sleep stays interruptible,
and the timeout becomes a deadline in jiffies.

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Moe Mahhouk <moe@flashbots.net>
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index a5a53174f9d9..d58c8eccb26b 100644
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
@@ -271,18 +272,25 @@ static struct tdx_quote_buf *alloc_quote_buf(void)
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
+	 * within a few milliseconds. Poll with an exponential backoff of up
+	 * to 100 ms, so that a fast Quote is noticed promptly while a slow
+	 * one costs at most ten wakeups per second. msleep_interruptible()
+	 * rounds up to whole jiffies, so the shortest steps take one tick.
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


