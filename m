Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792602999;
	b=BhY+SLsD17POOfeJDfJi2xd+hAxO8EZ6QKZrJ3H4+FmVVXCcqEq0/hD00sV+ek2kxPHu
	 8tZWkCfMgAf5MV1Tn/QzAwZKlgps9mQA1jT0M6xIzqhaNTu+R4PU4uyo18bi4hcywnJ/l
	 lWkw8QQbC8Tap/zML6q7p4+hlVm+rNt79iAAN9JrZccJcVLsgVRwupsEVXQekpwct5XPO
	 XQkK+REAiCfJihOUNiAvIyWgnRlCAbogs3vlWd/I5budwSteWOdrl5ZM+Q1neYyyGDpXE
	 44lSjzt1V3mR/g08jXsRIyZDKCx4tSjexc1CdvS+gYgZAj/SfP7XUdukagMwuUNxBaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602999;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=osRbuQ/Bkf4fHB+3iFdZWVyxGfpI6q99uA9VbpH4+zA=;
	b=hNpJTReemmJUDn5vGx0KuAafqq1Wrwaz1nn8tqQHKvbSlBtDzqxMF4gR4qXY7aRmHaUM
	 jAeJLyuhBaU1SGbKnCT/QYD7V9yQ9AD52jMed503S4F9VxuPF6UBRQgbwDsqnoX+JmJgL
	 nmHPY6JJwfBzGkTPSSfJwZjNPcp8hiFaoUdKN/vjdKa9ZfA1YH+j0Jqer3yL+B6lrvRl8
	 dAgP6FdlG1oVWr0KHJwJhFVr1998yMiUG325ra+k6AVNyI2YgDMhRewiVD+moKfVWPRhn
	 LYulseXdruq9EGsdYGpqoYhUAY72dHFNpJarrclz45gfQWNxm879TrByCOG1HEjSBIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WULuCDb1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA862606A319;
	Wed, 21 Oct 2026 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WULuCDb1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792602998;
	b=DRlQjR2pd/lMPyQfa/+IhJp7lZXCbA6dMkTrN1BHT/l8a3r0VIv1QcdR1mbneFfiwnyg
	 G2f6ploQ4H5lpTpJlqHgKwV1qzynw+kb0q82jUxxsKCEksdtJf/RyW0K7qJtxYZS7dJVd
	 4gX0ME+mPUavZ5zdEMDNO2lwCMVT1PKOhd1lSCCGdirfU0NsQ+luNSQOhnDqLezo9uk5G
	 2jqH4O+V8V1iYgCBAN7/B6ajgOR71jlVHoAYhr7bEYE/21fo6Wjub/YmuXLKR1U9xMzY2
	 xrkPhaNnzpBQjCsDXdTHUeU/g3RnWwS1nKjjkHzI4l4C2ZKpNaHSa+YQrabcYHXvcUA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792602998;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=osRbuQ/Bkf4fHB+3iFdZWVyxGfpI6q99uA9VbpH4+zA=;
	b=SsLxtVhSYEAEQlYYyoo3/756rg/EpqV8dIsYB/umDzIWNtavivZBEjo4rSg40Zo9bgyB
	 JrkItE783k01L/fJohV7F/gRssbKulYGL/AaxWCxJ10xx5fHgnUbmquk8j9Idhe2qkat5
	 PVYwHO3g4SlV5Tc19hy1xEEBhbk6X4G4rhGBXvnogfN95EhXzvQK3hAOj9eo5cM6piIz2
	 6Oyi+gSP3tGCSnp0s77sl0aKsI88lVaY+T180qASaxc4nrf2gg3WugXhlMuTsLAxyaQ6e
	 K/oBChE1oqd2FHIRLdfG0NA9W9PscWfdwweOBY7Yb5+lx//ThHb6aB1d37jAjQZb6pQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AC8231F000C1;
	Wed, 21 Oct 2026 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792602998;
	bh=osRbuQ/Bkf4fHB+3iFdZWVyxGfpI6q99uA9VbpH4+zA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=WULuCDb1uAoVNb9mO6Srz96qBl7FPsOJ1kTxorP4QEALAhfJvOahsHPoVU3cAuZso
	 ieSmdyZHouz4Xht9GlPW9RkfAYYQ3YzmFSEhf73SXbtE0F7NuRgXxQDz/E/9SO969Z
	 KhzYT9b7ZV3VZm9rpb+BUMkMy8MV/1t0imx7r5i3mlWhmtfjFVmlKlV/ntvKHzk+zZ
	 LMZPUOYF1nK1YNurhgjDHnci8PjT+l00KTnW6WUZQOy+d8IyVyT8Ta9L/Dywep9YsP
	 2gND7YUxbG77ZZQaoZNo4CApO9IgLKCg8pJZs0Q+DzBiiF55Batd7bd94JIEX2Akep
	 eynXO+JmMhAIQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2902F400AB;
	Wed, 21 Oct 2026 17:16:37 +0000 (UTC)
From: Moe Mahhouk via B4 Relay <devnull+moe.flashbots.net@kernel.org>
Date: Wed, 21 Oct 2026 17:16:32 +0000
Subject: [PATCH] virt: tdx-guest: Poll Quote status with exponential
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
Message-Id: <20261021-tdx-guest-quote-poll-v1-1-919a87812ecb@flashbots.net>
X-B4-Tracking: v=1; b=H4sIAG/z2GoC/yXMQQqDMBBA0avIrDswCbRir1K6aOJEp4ixmaQI4
 t2b6vIt/t9AOQkr3JsNEn9FJc4V5tKAH1/zwCh9NViyN0PWYO5XHAprxk+JmXGJ04QUWhf8teu
 IHNR0SRxkPbaP52kt7s0+/1+w7z+kcMDgeAAAAA==
X-Change-ID: 20261021-tdx-guest-quote-poll-0f7bfc59900b
To: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Moe Mahhouk <moe@flashbots.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792602996; l=3676;
 i=moe@flashbots.net; s=20261021; h=from:subject:message-id;
 bh=ovLjrwfOdsN8YV/HwtnnZX45Tn33AdVlaLj2iyiZxOg=;
 b=NerAd036wmkMOdNkDJm5yKzKT8DYx11lgGw4sGyYs33FluB7iBSKnw0ovprvbNvjeyeRTOoib
 Chgkf+bdwTWAe2iY3uOW0Za4az4NHjcAknw5+o6DNLQwK+5cV3GQbYR
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
QGS), 40 back-to-back Quote requests through configfs-tsm took
1021-1024 ms each; with this change they take 2-3 ms. Since quote_lock
serializes requests, the one-second floor also caps a TD at about one
Quote per second, which hurts users that bind a fresh Quote to every
connection, such as attested TLS.

Poll with an exponential backoff instead: start at 100 us and double the
interval up to 100 ms. A fast Quote is noticed within a few milliseconds,
a slow one costs at most ten wakeups per second. The timeout is
unchanged, and a pending signal still aborts the wait with -EINTR.

The latency was found while measuring TD boot and attestation times.
The code and this changelog were written with an AI coding assistant,
Claude (Claude Code, model Claude Opus 5.5), which also ran the tests.
Tested on mainline a804c5742 in a TDX guest (KVM host v7.0, QEMU 11.1.2,
TDX module 1.5.34, Intel QGS) with 40 Quote requests per kernel; builds
with W=1 and passes checkpatch.pl.

Signed-off-by: Moe Mahhouk <moe@flashbots.net>
---
The GHCI SetupEventNotifyInterrupt mechanism would avoid polling
altogether, but it relies on the VMM implementing that service. This
patch keeps the existing polling model, which works with any VMM, and
only removes the fixed one-second floor.
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 11d741da3..5cb7365b2 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -16,6 +16,8 @@
 #include <linux/set_memory.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/sched/signal.h>
 #include <linux/sockptr.h>
 #include <linux/tsm.h>
 #include <linux/tsm-mr.h>
@@ -271,18 +273,25 @@ static struct tdx_quote_buf *alloc_quote_buf(void)
  */
 static int wait_for_quote_completion(struct tdx_quote_buf *buf, u32 timeout)
 {
-	int i = 0;
+	unsigned long deadline = jiffies + timeout * HZ;
+	unsigned int sleep_us = 100;
 
 	/*
-	 * Quote requests usually take a few seconds to complete, so waking up
-	 * once per second to recheck the status is fine for this use case.
+	 * A local Quote Generation Service usually completes the request
+	 * within a few milliseconds. Poll with an exponential backoff, from
+	 * 100 us up to 100 ms, so that a fast Quote is noticed promptly while
+	 * a slow one costs at most ten wakeups per second.
 	 */
-	while (buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
-		if (msleep_interruptible(MSEC_PER_SEC))
+	while (READ_ONCE(buf->status) == GET_QUOTE_IN_FLIGHT) {
+		if (time_after(jiffies, deadline))
+			return -ETIMEDOUT;
+		if (signal_pending(current))
 			return -EINTR;
+		usleep_range(sleep_us, 2 * sleep_us);
+		sleep_us = min(2 * sleep_us, 100 * USEC_PER_MSEC);
 	}
 
-	return (i == timeout) ? -ETIMEDOUT : 0;
+	return 0;
 }
 
 static int tdx_report_new_locked(struct tsm_report *report)

---
base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
change-id: 20261021-tdx-guest-quote-poll-0f7bfc59900b

Best regards,
--  
Moe Mahhouk <moe@flashbots.net>


