Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F463ED13E
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619082; cv=none; b=bx+s+pzr+PTMHHYBfb0RJ/JIpC7pDde6hmAI1cwwrWjIgmJnmpDLRideR9HqINKqu7RwwGJe7RqbEGDlaSrQv47N1VuqK8wcJUnMZafFgokFTwEXbcouOMZkSfJY8JaxMN/z2biuYltj7NwwP82hO4Sn+TNHGF61jqJsHLAFQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619082; c=relaxed/simple;
	bh=aweLAlOcWhX1kBXrex1n6R9tukGsy6gxEskEHHaajuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kjx+csl729MrQZvDDAr9qU3JYlKbr1QkTo6uTjhiLoXWXBYJC5TRvdzlthSkojL7m3k8zf3T6h1dKup/u6Twb7yk5Wdc5HSRCbOuqWLOFTrO22QwwhsiQGSqUh0wOSn2CEhmM3Xrc8UYMu1HUvDacjS9C6OZ0J4HHNcHlz3uxI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X73FJhM7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X73FJhM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CchJGhUuuvvblu2UT/R6MNYAdi5C/aV9FBoBW6aVsYY=;
	b=X73FJhM7W5Q+0gKVJMjUffcJmrJm/AkwmQ1JH6AIqq7cBRTf1qNEPfOsz7Gw6zvu5W/nA2
	JmnI/NPY8N3Dku78NABi3Av4M9YnpnjmsiQIcQqVRvmxDELcUPZvzHnNWL48UCIln5SfSn
	XAuUl+sYF64nPtnEvQXvE4lwhNKAnwU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-w73SYVBfPsmpuZQBgO4lYg-1; Fri,
 27 Mar 2026 09:44:38 -0400
X-MC-Unique: w73SYVBfPsmpuZQBgO4lYg-1
X-Mimecast-MFC-AGG-ID: w73SYVBfPsmpuZQBgO4lYg_1774619076
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCDDB195608C;
	Fri, 27 Mar 2026 13:44:35 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 129BC1800673;
	Fri, 27 Mar 2026 13:44:28 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org,
	kvm@vger.kernel.org,
	qemu-riscv@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 03/15] block: Use glib2 instead of strcasecmp/strncasecmp
Date: Fri, 27 Mar 2026 15:43:49 +0200
Message-ID: <20260327134401.270186-4-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-1-kkostiuk@redhat.com>
References: <20260327134401.270186-1-kkostiuk@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This is a change in semantics. g_ascii_strcasecmp() doesn't honour
locale but strcasecmp() does. But this is OK for at least one reason:
 (1) QEMU always runs with the C locale so there's not an actual
     behaviour change here
 (2) we want the comparison on url prefix and it should be a plain ASCII
     one, not to do weird things with "I" in Turkish locales,
     so g_ascii_strcasecmp() is better as it's explicit about that

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 block/curl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 66aecfb20e..bb72962d25 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -871,8 +871,8 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }
 
-    if ((!strncasecmp(s->url, "http://", strlen("http://"))
-        || !strncasecmp(s->url, "https://", strlen("https://")))
+    if ((!g_ascii_strncasecmp(s->url, "http://", strlen("http://"))
+        || !g_ascii_strncasecmp(s->url, "https://", strlen("https://")))
         && !s->accept_range) {
         pstrcpy(state->errmsg, CURL_ERROR_SIZE,
                 "Server does not support 'range' (byte ranges).");
-- 
2.52.0

