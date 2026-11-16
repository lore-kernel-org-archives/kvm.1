Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847825;
	b=ddqSEPdDaTlHMWyFb/ILXLcgMzrVOgvuvV1SBKXHqCfmKIsI2qd8aXhA300i7wm98uZL
	 rezzlOEN9MImc++6RxcRJDFo9g0MAqB5LHKTeLQX/r8LyhDbjLCBhVi9KmcLif9/EPmsL
	 kgC8e/hK4X589/7RnUEmYv+kOypYubWVXMofjMDDWVheAZwx0USl047oEj05rEp4cc0H/
	 zKzrvDyfTBRPE7aSlmCtW/YZc21ZQL1dZ0OPICcYf7+ROcU7bsox1Jqx1wzWh595V7JMP
	 /KqSsMSVtbnzPR7HTXRGxz3dKFb/E5aL1qLlhQSjYNm7fvNtVmAsKWfrKZWRS3LcxZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847825;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=ekrPifKeZKSKlAlu0PgB8G/oDkp8oZ++mIkvY8WR1Xw=;
	b=Vq68ON5rh81aW/rb/kcJbz77bSHq9QpLnxhuqIWHqWVjeNcRxNKwAKulNxIMh0E/0Nww
	 YiaDqU4xb+RVRMoHjXMDQmLUMouwu1fym2KhuXaOoY8lfYIlYLcNQmGW2vg5Uoly3lESj
	 oiO7JBJELezVifux4m9MWt0lrc4obbJ9krCNMC6uNk7Kw/xTrshxcoqTVh7tMAAzo6qPy
	 ftufgaMSsI3flDNZrTXScGrL36gPSGB0SQHlxisIDL7hgY7MyH8dksI98izzGl9efzPwP
	 BVUNSvf0Dv6nK6vo77wDoJcUvTC8qGkBawTO7qdFBNGTYVQAPV8BqmQCUgd/T3b76ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="ZCQ/JGdG";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D02606A31C
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 16:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8D02606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZCQ/JGdG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794847823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ekrPifKeZKSKlAlu0PgB8G/oDkp8oZ++mIkvY8WR1Xw=;
	b=ZCQ/JGdG0eYVOqimeDz5JRNgNbm+Mx7oU31bnK60yCGupeTAbv4xQC7oaLsKWvLhVRGz/p
	Vx4kn2TZuEk/v1U18Hco00QPFE8M15mWfJsdkRgS0y416UXXUgoe2Oznz4tTQG6iQmRnFD
	n0gFa0GpBRN2ngbES8QR3RUrSG5gSLk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-8lYezrWfP5qJWvLzQ-03nA-1; Mon,
 16 Nov 2026 11:50:22 -0500
X-MC-Unique: 8lYezrWfP5qJWvLzQ-03nA-1
X-Mimecast-MFC-AGG-ID: 8lYezrWfP5qJWvLzQ-03nA_1794847818
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96FF919560B9;
	Mon, 16 Nov 2026 16:50:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7C59195B3C9;
	Mon, 16 Nov 2026 16:50:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	kvm@vger.kernel.org,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Fabiano Rosas <farosas@suse.de>,
	Alistair Francis <alistair.francis@wdc.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Stefan Weil <sw@weilnetz.de>,
	Peter Xu <peterx@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v2 2/7] debug/mem: add tracing to qemu_vname_vma()
Date: Mon, 16 Nov 2026 11:49:57 -0500
Message-ID: <20261116165002.30939-3-jsnow@redhat.com>
In-Reply-To: <20261116165002.30939-1-jsnow@redhat.com>
References: <20261116165002.30939-1-jsnow@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/mmap-vma.c   | 6 +++++-
 util/trace-events | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/util/mmap-vma.c b/util/mmap-vma.c
index 7a50965d496..46ea98f1134 100644
--- a/util/mmap-vma.c
+++ b/util/mmap-vma.c
@@ -7,6 +7,7 @@
  */
 #include "qemu/mmap-vma.h"
 #include "qemu/osdep.h"
+#include "trace.h"
 
 #include <errno.h>
 #include <stddef.h>
@@ -36,6 +37,7 @@ static int qemu_vname_vma(void *ptr, size_t sz, const char *fmt, va_list args)
     int rc = 0;
 
 #if defined(PR_SET_VMA_ANON_NAME)
+    int err;
     char strbuf[VMA_MAXLEN];
 
     assert(sizeof(VMA_PREFIX) < sizeof(strbuf));
@@ -49,8 +51,10 @@ static int qemu_vname_vma(void *ptr, size_t sz, const char *fmt, va_list args)
     }
 
     rc = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, sz, strbuf);
+    err = errno;
+    trace_qemu_vname_vma(strbuf, ptr, sz, rc, err);
     if (rc) {
-        return -errno;
+        return -err;
     }
 #endif
 
diff --git a/util/trace-events b/util/trace-events
index df549646d12..5ffc6cd205c 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -117,3 +117,6 @@ module_lookup_object_type(const char *name) "name %s"
 
 # datadir.c
 load_file(const char *name, const char *path) "name %s location %s"
+
+# mmap-vma.c
+qemu_vname_vma(const char *name, void *addr, size_t sz, int rc, int err) "name %s addr %p size %zu: rc %i errno %i"
-- 
2.56.1

