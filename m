Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D53ED100
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619078; cv=none; b=DtqBbcdaRGtyBWzUoffr8LDyjc+pH8uVjpOpqwZjlfXL/kQQ68PiLEKJlRkZpRyh77r4RYjVuHgvv9zXV8oTOeZIsd6CZeWJ4n7kDx/IudpdI1K9Y0k7m9l1AS3La56NjBar/AkLkH+C8GwRwg/Md2QBgrSMCpPyvY+2Fi8FZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619078; c=relaxed/simple;
	bh=TuQMAVRAJxrzq/tS10AseQ9k+kvoyjcqhgzB7bM9jCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXHdArPNQbxtrtrEFpPwlE+4zQH5QvbOjjT+xZFL1O+l/h9GJNrBvsI8vT4Hai7L6n+E8pUOSXhzaX9zSHjBJimAdrl9pYfTDPBOEN+vQ5W2DDl1DW8VXZMq46CI9yfMmOHG7T/aHsb3Ta+wtYJAN5rQPOpb4Hc7ZxfP84252zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2+kupT6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2+kupT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wK++K2CoaU+1nBZXDiwSJy/xa8eFj9BxrAie3nEs+A0=;
	b=B2+kupT6Y+MUdn5FBqqkUnGQnyt6nwB0pJ33AOHmWtENUHJ3UVRADAkV/SAx3Y6CI+WABZ
	uSudS4UcT6WznqZUF6gFgGGZhpCGrYMMa7jzkLbm0z6jVx6nMM0qJT95vSehq2gROsFIcB
	g1knKBvb5cZZScM47t0DIZWKugGpNRM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-eKE_EECHOjGuccS_QI1DOg-1; Fri,
 27 Mar 2026 09:44:31 -0400
X-MC-Unique: eKE_EECHOjGuccS_QI1DOg-1
X-Mimecast-MFC-AGG-ID: eKE_EECHOjGuccS_QI1DOg_1774619068
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99DDD18002C9;
	Fri, 27 Mar 2026 13:44:28 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37D081800671;
	Fri, 27 Mar 2026 13:44:20 +0000 (UTC)
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
Subject: [PATCH v2 02/15] qom: Use g_ascii_strcasecmp instead of strcasecmp
Date: Fri, 27 Mar 2026 15:43:48 +0200
Message-ID: <20260327134401.270186-3-kkostiuk@redhat.com>
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
 (2) we want the comparison on class names to be a plain ASCII
     one, not to do weird things with "I" in Turkish locales,
     so g_ascii_strcasecmp() is better as it's explicit about that

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qom/object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index ff8ede8a32..e5c0c2f53e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1193,8 +1193,8 @@ GSList *object_class_get_list(const char *implements_type,
 
 static gint object_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
 {
-    return strcasecmp(object_class_get_name((ObjectClass *)a),
-                      object_class_get_name((ObjectClass *)b));
+    return g_ascii_strcasecmp(object_class_get_name((ObjectClass *)a),
+                              object_class_get_name((ObjectClass *)b));
 }
 
 GSList *object_class_get_list_sorted(const char *implements_type,
-- 
2.52.0

