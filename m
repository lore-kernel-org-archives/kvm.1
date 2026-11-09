Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250773;
	b=vYkyYT03Z2jTQKHehCmBVCwITw7a291Aagpme37E+8C+TJouSJ32IETBS2Dgpc/N3J2j
	 5khHl+F77W8rctN0U2OqgvhXf0o4bgezfauK8xQFxFbHrX3C5Ipb87PpRKT5xXBjBzFCp
	 7BlEOutUNojtxQq0WX3aahm9vEetTplQhHbnK2DIXO1GyaU+w58ifz8m/DWvwMrsNaAjl
	 hf6/YDOGOkgjw+BL48mbLER+pwAO6QUNaPxeDbLQ8RQsFG27MvHBrAuDh8L5ehNTe0slp
	 whbgZ900+Pu0IsYPwqAgbJLhe6goocPzuLRIv60wve3wuIxZ8RF8uTLogTSkQpQA0ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250773;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=FeG2iVfFCj3eeKpRFunQ9Lno80LNeMsj8TqH/TijHYQ=;
	b=tR37oCmt0YC0sPK2/ucYyyyvrIKekuOqhrgUGpTePwNg/dCyRrl+zlvl8tSwSIW7zxkg
	 sUEOJM5igoc8CEM4nnNbCn2V3oVGkjJo9yIVMsVfJ8QX0VOPWwDnsqUNDcJwIl6EmNoan
	 zObIFG1zB0Z+DeHXtYkJXO7DCCHLxVGWfR4Vh0Dt34GUh5Oi4+vvDf02bbHHkt8BBy+lP
	 Xs2+BTh7ANMWYIK+Zldyi6u8jQ+MBXCjCielFJLRSp7AMd/KS7bCYCivlE9ccrBu1oRwz
	 6zAdx8pzzxCv1zf4pAlV0vEtaB5HT3PCtkE6WCtigf1Waz4WbzFzx7ZbhnLBd/naQnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ClFPmVl6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E061606A326
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 18:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E061606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ClFPmVl6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794250772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeG2iVfFCj3eeKpRFunQ9Lno80LNeMsj8TqH/TijHYQ=;
	b=ClFPmVl6w9MlBI0PL/16HfZ/ke/afUiw+LrzgMSbGQ3ndfBILUtslDhbOTaA2GOJz5HfTW
	NDW5H73j5+2relbnTS9YjN1wZMMy0ZvijtHaxS7IGJMqLkMMW/dU0CoflnHKBk4a1xBF7q
	KG5QjVxY7zIwwC0glCZ+fMyhEC2judU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-c7EJXxBqMOO7x5dAD2cMjQ-1; Mon,
 09 Nov 2026 13:59:25 -0500
X-MC-Unique: c7EJXxBqMOO7x5dAD2cMjQ-1
X-Mimecast-MFC-AGG-ID: c7EJXxBqMOO7x5dAD2cMjQ_1794250760
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 618871955E83;
	Mon,  9 Nov 2026 18:59:19 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A3391956087;
	Mon,  9 Nov 2026 18:59:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Alistair Francis <alistair.francis@wdc.com>,
	Stefan Weil <sw@weilnetz.de>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 2/7] debug/mem: add tracing to qemu_vname_vma()
Date: Mon,  9 Nov 2026 13:59:02 -0500
Message-ID: <20261109185907.3220584-3-jsnow@redhat.com>
In-Reply-To: <20261109185907.3220584-1-jsnow@redhat.com>
References: <20261109185907.3220584-1-jsnow@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Signed-off-by: John Snow <jsnow@redhat.com>
---
 util/mmap-vma.c   | 6 +++++-
 util/trace-events | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/util/mmap-vma.c b/util/mmap-vma.c
index 7dcef3b7455..93ca7f608d7 100644
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
2.56.0

