Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582773F1649
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619127; cv=none; b=Lxk8Sc/C/41a0z1VwTwOx6/azTf3vv61bqcferTJqejPkTOWR164uco3knjbtrNHyzt2tfutRlVeA2sE2J3gptNvQZyvTjC7eCzidjIuSAZ4KkmzS8Kk7QaFdB9irN8KV1Qq6gcIzz0n8Klo2TfvqjtJQfCBuv6IC5OiVS0W/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619127; c=relaxed/simple;
	bh=JBe6x0ZB+ZaAYsks2eVA67fy09VsIhMt1SWvUoeakCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKCxUA0v0PnBn1roH5u6qK4l9lIqck33A/0+Gm15gAbaHw/5td5aGzwbM5dIVNdL97PtkDJQDySZPSRto0zrjy4O+Sbz154SYX/1jQwmIl/GGBGZKlEaykOtWmOy+18WdW++H3ujZ5U8Ydef2alQz8IWUg1vFf3Veks/dYdGLMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDbULAp/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDbULAp/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i84rNdfgM/w8ABJ8HnJy4pqINDmLOPX/1RnRroOZru8=;
	b=PDbULAp/9IB2iy1+P9cpdGDo9uXIB62m+qTQSPoQDpf0FnPhJT3Lqg5S/Oetem3e8Ubc5R
	nNL6MjhYhxrTAciBMkkcIXIbVIDk+cKL+66rsNHnjGNlemJn/cjCNq9TT0ZWYxGwzKmDW8
	g7UzFNyVX063C4DlIZXzoGGY2kvFtSQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-Z_076GK5MCGHZmv2dVLcfQ-1; Fri,
 27 Mar 2026 09:45:22 -0400
X-MC-Unique: Z_076GK5MCGHZmv2dVLcfQ-1
X-Mimecast-MFC-AGG-ID: Z_076GK5MCGHZmv2dVLcfQ_1774619119
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E2ED180044D;
	Fri, 27 Mar 2026 13:45:19 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2232F180036E;
	Fri, 27 Mar 2026 13:45:12 +0000 (UTC)
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
Subject: [PATCH v2 09/15] target/xtensa: Use glib2 instead of strcasecmp/strncasecmp
Date: Fri, 27 Mar 2026 15:43:55 +0200
Message-ID: <20260327134401.270186-10-kkostiuk@redhat.com>
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

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 target/xtensa/xtensa-isa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/xtensa-isa.c b/target/xtensa/xtensa-isa.c
index 630b4f9da1..c564af340f 100644
--- a/target/xtensa/xtensa-isa.c
+++ b/target/xtensa/xtensa-isa.c
@@ -370,7 +370,7 @@ int xtensa_isa_name_compare(const void *v1, const void *v2)
     xtensa_lookup_entry *e1 = (xtensa_lookup_entry *)v1;
     xtensa_lookup_entry *e2 = (xtensa_lookup_entry *)v2;
 
-    return strcasecmp(e1->key, e2->key);
+    return g_ascii_strcasecmp(e1->key, e2->key);
 }
 
 
@@ -513,7 +513,7 @@ xtensa_format xtensa_format_lookup(xtensa_isa isa, const char *fmtname)
     }
 
     for (fmt = 0; fmt < intisa->num_formats; fmt++) {
-        if (strcasecmp(fmtname, intisa->formats[fmt].name) == 0) {
+        if (g_ascii_strcasecmp(fmtname, intisa->formats[fmt].name) == 0) {
             return fmt;
         }
     }
-- 
2.52.0

