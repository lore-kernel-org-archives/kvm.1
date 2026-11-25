Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795615928;
	b=h3dtt5w2X1+nLEqAAlTfALbaJ8Hs+3R3UVvyAh7INLcGfKDY0LdX6DDHovlsmTuSfKUi
	 3FDUuMxWuR0vSOETbD3uTABbPVOYjgsLBuUHgo6dz3xVup9OJeG+J9kcshIzPw4Ah9s0G
	 mADd86iXLJDhl6VuaMIeMg4cZG+hLwi+dJTEK2/p2f4MFDI1FBDoBZKYwc+ZBCryzDrTb
	 SP9cJK2On6DUrewNkODVMDPTacgM8dDRs6Ms/iGU6QDyzpC8KioP+JsLGOqgbe4hWtqwz
	 gkVprjfWDbxzcUtltMjwToyyoI9HKGm8JMdSMBspYl7GMiqxYfcMVpR31yzQ7lo+8bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615928;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iGzxZDraoWUDG8juQ5rDSMcrAFNeRPcy+J3hkWIqvY4=;
	b=llpuXa2IugEcV2FbhngwRinUvzQeWb+e1ufNF8Z9y6I8td7Q4q6bX09k1koXSu27Qw0e
	 zX7Yda6GIalHGXNUNlm6wwDSh35zgk4mj9q1OEEwJwa6ZnqHbZfEO1B8fOqrDAEosKHMF
	 H6eudRhKXEUmEgccetWRgjAOJV0WMzVGeozw7h2dfK4heXrn0IyzlKX+RlcrGgQuz13QJ
	 zOANP2KgSud0dgDXuUsxKWKYsIgQf0rreLgEmhrbKapDmRinyn2HNgJP55RvsaUWSsVKN
	 TaYkCSKUUC/uTnTuULDo5QkBLaNYRLCR6lxvtERA4+iU4+dg6VAUcSqWsJvGZAGe+zA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIZPtCcv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D3606A69D;
	Wed, 25 Nov 2026 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIZPtCcv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795615928;
	b=O5PD5f/U9y2Uf0oPCkIXR+Lxs2/CQqFdlR/u4kDoDUTDdXUn+xULTiPTIfTENzOd8jcF
	 ad2EsIDJzgFiE7WjYE4rjbnp/mgB3m30LPJiG5QzzQ9l+1nYHjRMyKWKTIiUIS6Qmwqpz
	 oAt5xzrszYt58DQ/1sems99ivt3ub6oxsYQmdhWfmF0uy+j16ezfj22P0y+yoBRpxmwq9
	 QsxhdSZLA0x9iSIkPs39EfHbB/FO6bCELtFXQayFf69szVeuPt7Y+C2XFFKYOCj9phcv9
	 +Uwz703PbMZCHmgEAPFM6Ji8gxDolxd+1Kdal6+Tt5Wlpysb6Ztc4PbOm2jwEmV+WXQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795615928;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iGzxZDraoWUDG8juQ5rDSMcrAFNeRPcy+J3hkWIqvY4=;
	b=h/HxTRhT2TLxj0BexIZWCalOEfL6xuzDkmG6XI8zFcOX3vIc5zoH8Fhx1x/te6rPwzj3
	 j0bkKQ72HtUHFJBYGLkDvNgDBXcKmYe6r24GK9c1h/f2Y24D2CB0VRD2yIbaAWC/CZJa8
	 jmayF/3ftolhGXZ1XDT8ugvC6k1SvdT3DXFQeWF8vPU3ysB7DIl5/zhExzsNZmrI4wEZ4
	 GNr6esSYQdRdyJDrnHLQHGI6pQifSf74Ne9xGz2pPUwMgB0jD2a8JoFsFr26IciFDegdn
	 XAJ1HCSN1dSokrQJx3vbcpyvPccalMJuA5UJ0pq1URRVds6e81wP2fWclN1Ysm11gNw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C7E3F1F000ED;
	Wed, 25 Nov 2026 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795615928;
	bh=iGzxZDraoWUDG8juQ5rDSMcrAFNeRPcy+J3hkWIqvY4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kIZPtCcvJ5h8rzrWxNNAitHiAa2chnIC/oVHytO7g3rHz2WvEI/NQfUUL6636NK0C
	 hFXMfUxkHbQZY00VvtAnEHvuZVAr0wkGJqxhpT4qHPVc+0zHR/gmgp1OwBV7b7VDg5
	 mMP3JvAZV5ApcyI47xaRtIaGxdF8mf0Jdd7GM6srWX1W76fZ+bkE7Uq3A2jTHl3X/r
	 omvKjzOdMhz4CSeTl9QFX2zWMVAc1N5co7XLDb4AFUHct4Os2TiRNKarmrdgn9vZZS
	 wv564VWWeow4CFhz3iCYI4wtLyaHKbczz6ao8AK5Bu0q9fxrziYE1pn3RAy9eyWY21
	 +mzHjrfl7texQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 554414CEFA;
	Wed, 25 Nov 2026 14:11:55 +0000 (UTC)
From: Moe Mahhouk via B4 Relay <devnull+moe.flashbots.net@kernel.org>
Date: Wed, 25 Nov 2026 14:11:51 +0000
Subject: [PATCH v4 2/2] virt: tdx-guest: Poll Quote status every 10 ms
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
Message-Id: <20261125-tdx-guest-quote-poll-v4-2-d89f26854b88@flashbots.net>
References: <20261125-tdx-guest-quote-poll-v4-0-d89f26854b88@flashbots.net>
In-Reply-To: <20261125-tdx-guest-quote-poll-v4-0-d89f26854b88@flashbots.net>
To: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Erdem Aktas <erdemaktas@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Dan Williams <djbw@kernel.org>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Jun Miao <jun.miao@intel.com>, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Moe Mahhouk <moe@flashbots.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795615914; l=2710;
 i=moe@flashbots.net; s=20261021; h=from:subject:message-id;
 bh=ZJ2AKpTdfk8nnjvMdjII9JPQIlMg0qVyJ6/cNAQLTWE=;
 b=wI2fSczMhX/mxKYtl2J1z8aeVnGsBDgKSZSGKGgAeWbkOWb9jePYRrpaFb3+vuATW/qQdCI/E
 94ZvL/SDmvrDOuBjUzTO+Dvc5VZdEya49VfgPXeLfK1a8AAFjyftNnW
X-Developer-Key: i=moe@flashbots.net; a=ed25519;
 pk=hJTKfjLno/YESrpxMIKDJk34GM+/8Tol+24XK2b4xf0=
X-Endpoint-Received: by B4 Relay for moe@flashbots.net/20261021 with
 auth_id=1259
X-Original-From: Moe Mahhouk <moe@flashbots.net>
Reply-To: moe@flashbots.net
Content-Transfer-Encoding: 7bit

From: Moe Mahhouk <moe@flashbots.net>

wait_for_quote_completion() checks the status of a GetQuote request
once and then sleeps for a full second before each further check. The
VMM has rarely completed the request at the first check, so every Quote
request takes at least one second, however quickly the host answers.

With a local Quote Generation Service the VMM completes the request in
a few milliseconds. On an Emerald Rapids host (KVM, QEMU 11.1, Intel
QGS), back-to-back Quote requests through configfs-tsm took 1021-1024 ms
each; with this change they take 14-21 ms (median 16 ms) at HZ=250.
Since quote_lock serializes requests, the one-second floor also caps a
TD at about one Quote per second, which hurts users that bind a fresh
Quote to every connection, such as attested TLS.

Recheck the status every 10 ms instead. msleep_interruptible() rounds
up to whole jiffies and adds one, so at HZ=250 a step takes 16 ms. The
sleep stays interruptible, and the timeout becomes a deadline in
jiffies.

Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Moe Mahhouk <moe@flashbots.net>
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index a5a53174f9d9..25fa2a875c44 100644
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
@@ -271,18 +272,21 @@ static struct tdx_quote_buf *alloc_quote_buf(void)
  */
 static int wait_for_quote_completion(struct tdx_quote_buf *buf, u32 timeout)
 {
-	int i = 0;
+	unsigned long deadline = jiffies + secs_to_jiffies(timeout);
 
 	/*
-	 * Quote requests usually take a few seconds to complete, so waking up
-	 * once per second to recheck the status is fine for this use case.
+	 * A local Quote Generation Service usually completes the request
+	 * within a few milliseconds, so recheck the status every 10 ms.
+	 * msleep_interruptible() rounds up to whole jiffies.
 	 */
-	while (buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
-		if (msleep_interruptible(MSEC_PER_SEC))
+	while (READ_ONCE(buf->status) == GET_QUOTE_IN_FLIGHT) {
+		if (time_after(jiffies, deadline))
+			return -ETIMEDOUT;
+		if (msleep_interruptible(10))
 			return -EINTR;
 	}
 
-	return (buf->status == GET_QUOTE_IN_FLIGHT) ? -ETIMEDOUT : 0;
+	return 0;
 }
 
 static int tdx_report_new_locked(struct tsm_report *report)

-- 
2.34.1


