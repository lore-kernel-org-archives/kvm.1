Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847834;
	b=1rPvBZ1Zcx9w8SIFvKo6H5vUkhpKZOM8p7W/2Fe/xTz30J2njFQ7q7KWoIP5GxH60tcM
	 Qa/pzybrARqNGo49/YW1nBcJ4ZmM+sIk6nLQMFpcmpiE4+c45TkDg1TwMuSGDceOK1IEf
	 pEHveKCAFMw/JXQl2dfDGKsfbZPsOAwK1Qffv11iMCN6yGHpVd7sNm9EiLNLFhcempc+f
	 55QcLsym+PtsbD1lPtOrTez8n9FpTJFfBdjFqVm9Dc7itlHhNn/i5VatSEt5doOyoEu8K
	 8xJtXzylKobslnODdiwWA2PumIoLENQ8yjgPICu/yyo6g3W7e4u72J01yjfnQLdVjKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847834;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=CRoYJNo2Ut/C9F0PKvSMgrpZBQkzD9p9HmTEG0fAlqU=;
	b=HkAwtCWIfwWCA0USUeV2UKwOg36gdRfi38GKdUTAMQtEfKuYFEXClH8Ys1JfRwisIjSn
	 oJBPEIkJvqP7lLwSETcbQrhy/r76ODSyLKstFqpwcuaB4j623oF+ihpgeJSA+1Og3ElkJ
	 4oFD6VNb9a+6NKjAguh3qeLWoVHnAgEq6W9jcFP1emi4t1ySnNb8ZmGvGzsbK5HXOlMpv
	 DdVtyVlPhg1X/JK+VQ/3aVUyUP5/Ffoethq7QpipK5wOubiCbaha8AGDLP99t9vYEeOgj
	 40ET5vN9AJ15hkE/bJEbp9XBxr5fqYu3MA3RCFm/SNenHTEr1/mIvjlNyHfL4vP3oSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BY5lOkMi;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9723606A31C
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 16:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9723606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BY5lOkMi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794847832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRoYJNo2Ut/C9F0PKvSMgrpZBQkzD9p9HmTEG0fAlqU=;
	b=BY5lOkMixy2ooPbOeSCsw/nNEm1fFjTYRP36H6FaY3KmlucGVaqz9XgAIe1QDprVs0aehc
	px1uBVV3AH9ewHDwwjKIekb3gYRxMYgC9JqOXH3GbLv+wvhKG82LEqQ7OTdpUPMjoEoSnl
	pLZZPd061Jd4+IljqldxwIo0evVUYyw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-zsTcbiazNmSDz6sDb0s-AQ-1; Mon,
 16 Nov 2026 11:50:29 -0500
X-MC-Unique: zsTcbiazNmSDz6sDb0s-AQ-1
X-Mimecast-MFC-AGG-ID: zsTcbiazNmSDz6sDb0s-AQ_1794847827
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CC5D18002FC;
	Mon, 16 Nov 2026 16:50:27 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4272C195B3C9;
	Mon, 16 Nov 2026 16:50:21 +0000 (UTC)
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
Subject: [PATCH v2 4/7] debug/mem: name pthreads
Date: Mon, 16 Nov 2026 11:49:59 -0500
Message-ID: <20261116165002.30939-5-jsnow@redhat.com>
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
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Signed-off-by: John Snow <jsnow@redhat.com>
---
 meson.build              |  8 ++++++++
 util/qemu-thread-posix.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/meson.build b/meson.build
index d7bcb581c18..ef961df2f64 100644
--- a/meson.build
+++ b/meson.build
@@ -2878,7 +2878,15 @@ config_host_data.set('CONFIG_PTHREAD_GET_NAME_NP', cc.links(osdep_prefix + '''
     pthread_get_name_np(pthread_self(), buf, sizeof(buf));
     return 0;
   }''', dependencies: threads))
+config_host_data.set('CONFIG_PTHREAD_GETATTR_NP', cc.links(osdep_prefix + '''
+  #include <pthread.h>
 
+  int main(void)
+  {
+    pthread_attr_t attr;
+    pthread_getattr_np(pthread_self(), &attr);
+    return 0;
+  }''', dependencies: threads))
 config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(osdep_prefix + '''
   #include <pthread.h>
 
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 089606c93fb..967e0f15f6d 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -17,6 +17,7 @@
 #include "qemu-thread-common.h"
 #include "qemu/tsan.h"
 #include "qemu/bitmap.h"
+#include "qemu/mmap-vma.h"
 
 #if defined(CONFIG_PTHREAD_SET_NAME_NP) || defined(CONFIG_PTHREAD_GET_NAME_NP)
 #include <pthread_np.h>
@@ -362,6 +363,13 @@ static void qemu_thread_atexit_notify(void *arg)
 
 void qemu_thread_set_name(const char *name)
 {
+# if defined(CONFIG_PTHREAD_GETATTR_NP)
+    pthread_attr_t real_attr;
+    void *pthread_addr;
+    size_t stacksize;
+    size_t guardsize;
+# endif
+
     /*
      * Attempt to set the thread name; note that this is for debug, so
      * we're not going to fail if we can't set it.
@@ -373,6 +381,28 @@ void qemu_thread_set_name(const char *name)
 # elif defined(CONFIG_PTHREAD_SET_NAME_NP)
     pthread_set_name_np(pthread_self(), name);
 # endif
+
+# if defined(CONFIG_PTHREAD_GETATTR_NP)
+    if (pthread_getattr_np(pthread_self(), &real_attr)) {
+        return;
+    }
+
+    if (pthread_attr_getguardsize(&real_attr, &guardsize)) {
+        goto cleanup;
+    }
+
+    if (pthread_attr_getstack(&real_attr, &pthread_addr, &stacksize)) {
+        goto cleanup;
+    }
+
+    /* Though there's a guard page, it isn't actually marked RO, so
+     * just label the entire region */
+    qemu_name_vma(pthread_addr - guardsize, stacksize + guardsize,
+                  "pthread (%s)", name);
+
+ cleanup:
+    pthread_attr_destroy(&real_attr);
+# endif
 }
 
 typedef struct {
-- 
2.56.1

