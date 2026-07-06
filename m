Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34F041610F
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342469; cv=none; b=q8ndbipfHViyUZ0AUQ3EVMIAoDPl9pe/Zny58nPSNUNzdPxH4VJPMYsfxzGAo9YXJTPHf0ONh0cb9qRyEmQQUqP994vdB5Q4uAgn9TP6ptIsd1lr3Xe7w5ZgBaB8aIgGV/z2x9rqJ1ryn+ACDmZqiId5V/CSg5CV8VLg8G/fq+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342469; c=relaxed/simple;
	bh=/764FwEy+oMuo7XRT7vkFLChejFIabvQLxH4PU5NCcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrxQ0qt1wW3FVRS/3507O3Xq6SmLMFVeM8qaBmTeMjAev9+9ewaW2hw8J0Mg89nzWY8/ah2rHj/7qZESu8UoPEexkthbqvsge0c4tMCirJstrPxkjvyCXqlqAucapLNDTOmBpbrkPPm/YKuNki04P/7VBQxV8LZYD9FK2ikopwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJJ5wkp6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJJ5wkp6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783342466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjemWcUQ0wpFl2+FNiO5wmSYq4+Q2OjQyjJjPZdkMWg=;
	b=SJJ5wkp6o24NQLDQxUycsdDl4+2v/BE3/0bJT7nYbmCXTo9odmm3ndtbfXvw1Q+oRrI76d
	6GxMVUm7R7bOqSGInLvJ4rBWHgbXgWohcJMUzlsPHz2ZL6x1tB6zC1HfShueSJlNMns6yi
	ZcQxsWl4U+G1tTml02qVsy0lf2wAj4Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-zkzl4vEzP9uchR0_0-0UWg-1; Mon,
 06 Jul 2026 08:54:23 -0400
X-MC-Unique: zkzl4vEzP9uchR0_0-0UWg-1
X-Mimecast-MFC-AGG-ID: zkzl4vEzP9uchR0_0-0UWg_1783342461
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BA0D18052C5;
	Mon,  6 Jul 2026 12:54:21 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B41E18005A4;
	Mon,  6 Jul 2026 12:54:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 06 Jul 2026 16:53:50 +0400
Subject: [PATCH 3/5] ui/vnc: validate color shifts in SetPixelFormat
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-fix-v1-3-4b83a70e9f3b@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
In-Reply-To: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/764FwEy+oMuo7XRT7vkFLChejFIabvQLxH4PU5NCcw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqS6Vn1pJsbMg3g1eXZo+l/L8WFjY5KQc0mY9DU
 x7SYRDucf+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakulZwAKCRDa6OEJdZac
 5XU7D/wP1pv3zX9sft85OhZ3zGBmE7dWsseE5uyBlreG9+RXoPzYcBGRYOk6ZUEKG13KhuYfgM2
 4rXQ72FNi6AhinHVKgKV4DzaZyq6gOQ2Ey4VOm01NXlkZH+xfcYR0cvsySv2lvyeATPQ/1h3DDa
 nR70QceDIGokm5dcYNNmWhylR8ndbwTyQoqQLpSKQ0dvWVfn43XkV9FsKsZPCYXjfmYmWO1vNW7
 uv4BnG2ngavZA5+jIoKcF8rydInTIC+YkIETyij/xPpnJ72+vl23PK2q+2ozyM5Uy+clktyw+xV
 v6weXFQ7pA2v6s+C11Jg/kmeJzDTKm3AfNkgr3x3AyNNJj/zLgsEWfOlcsg43TqjXdbhr1Js1/2
 YvZtF3qauo1yn2birZbJrcT8FvsI1CyMTseq54OeEuVf+iiop0Hda9MkTSwkgmh+UhLEIBhkKrU
 jMrvv1TSM4qTlMl08Mdu0cC3efALLTdxz3OUEwi2BPc9eS0scxPU9dqxWxV3Ccrw3R/CVQuJe/z
 h+pEqYyO/VZeGLr5oPPvCF7PeQbHkakceh/Oc/XJVSnsXAXbEr8EHlCEZEUu6jNyrDClIctEIZ+
 GFiQbu35XyKlkBOnAV1wdSwqj9lttwKDCASwexJ16BHHWXwUPKabMFikTQw8vUZsH5uW0lLcdnX
 UU9CHkOmYWCpmyA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

A malicious VNC client can send a SetPixelFormat message with shift
values >= 32, causing UB mask computation
(e.g. red_max << red_shift where red_shift is 255). Apparently, this is
not covered by -fwrapv.

Reject color shifts >= bits_per_pixel before computing masks, and cast
the max values to uint32_t to avoid signed integer overflow when a
valid shift (e.g. 24) would set bit 31 of a signed int.

Fixes: 9f64916da20 ("pixman/vnc: use pixman images in vnc.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3948
Reported-by: huntr bubble
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 559d3954b87..94a38242c56 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2276,18 +2276,25 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
         return;
     }
 
+    if (red_shift >= bits_per_pixel ||
+        green_shift >= bits_per_pixel ||
+        blue_shift >= bits_per_pixel) {
+        vnc_client_error(vs);
+        return;
+    }
+
     vs->client_pf.rmax = red_max ? red_max : 0xFF;
     vs->client_pf.rbits = ctpopl(red_max);
     vs->client_pf.rshift = red_shift;
-    vs->client_pf.rmask = red_max << red_shift;
+    vs->client_pf.rmask = (uint32_t)red_max << red_shift;
     vs->client_pf.gmax = green_max ? green_max : 0xFF;
     vs->client_pf.gbits = ctpopl(green_max);
     vs->client_pf.gshift = green_shift;
-    vs->client_pf.gmask = green_max << green_shift;
+    vs->client_pf.gmask = (uint32_t)green_max << green_shift;
     vs->client_pf.bmax = blue_max ? blue_max : 0xFF;
     vs->client_pf.bbits = ctpopl(blue_max);
     vs->client_pf.bshift = blue_shift;
-    vs->client_pf.bmask = blue_max << blue_shift;
+    vs->client_pf.bmask = (uint32_t)blue_max << blue_shift;
     vs->client_pf.bits_per_pixel = bits_per_pixel;
     vs->client_pf.bytes_per_pixel = bits_per_pixel / 8;
     vs->client_pf.depth = bits_per_pixel == 32 ? 24 : bits_per_pixel;

-- 
2.55.0

