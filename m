Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250773;
	b=C8yLrZr7ccSsgKsz9KqHtBtK6TXwOfBu4qD/YfYHxix0FHiIMoTIfuVazncWSzaITXXL
	 bQskg9aI/nvIaDrHbn7+yM/zqtfORjIJAzBYAqUuHBEf8PC3Mnx7ZYwVt+8ojtm26AU3L
	 EvnGCfmcZbZzbCeEt+CE1f8pG+0mMFkuchv2cAsJuKOWi5vHmCC/JQBduCTzdJrHo2Mmk
	 hSs1O+E4Ui1DFmpWC1GBcp2Wi/Bc1BM6KWmW3ZHykiF6nqht4zUWiaSNwxVITcITDNZrn
	 2iX9uTToz0jEYvZ6J+ZWl+Xv8R4SWUvAHRdF8qoWseap0kfiDHYu3xAnmFY5u4DOpFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250773;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=VufcRdivSFDOtCXyYchwGh9ii+BaoE0frA+jUSq792o=;
	b=rZMF6ie/EjOv4BYy5+WQFcfSh70MvKtfq6/K84rvOVoIEYcXf0ZQsjhYtW9iIrGQoOwv
	 2P0ZJMQRnOIpI5+aHQI0huPVhwUpIoIhWDMrbbheloswlDN+RsswPraU5sfY4U4TQwvZx
	 XvkgAK6rjSR/jdbSljRnfdSVQhoYtBwYXJLUk1wkvgocPRd5zQ1mXNWaTy4jTdCpuyriA
	 bBrhGBVyw1jgLs2GDuZf2LfY+Dlk7Veo1UaeCJDEQu8YMOV8M7sneO4twcoGUABAK1r6E
	 /Q4+fbgvIyPKOWUDC8YwbubhkD0kVdprL+Ak8+wz2LZIXSWr6TTO/8SCKu97pnyrwtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b9alZENm;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991E606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 18:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6991E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b9alZENm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794250772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VufcRdivSFDOtCXyYchwGh9ii+BaoE0frA+jUSq792o=;
	b=b9alZENmP5RuEjI5eYskoWsb8kNY4TmR5kZg6jYiE+tSHEjZ1LaIggWu586mthFlkL/t12
	SJg9Af/5KaRSlbffcDRUnXW1pk7JmNqxS1v4jXehHoJT5LgEYSW6AzZJgSzwmds+4g9nMv
	Ox4iVKl64gVpIjppInL9l0WfEGiNIQQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-lrIugugqNHC6N9MjxKk_Pg-1; Mon,
 09 Nov 2026 13:59:29 -0500
X-MC-Unique: lrIugugqNHC6N9MjxKk_Pg-1
X-Mimecast-MFC-AGG-ID: lrIugugqNHC6N9MjxKk_Pg_1794250767
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 435DB19560AE;
	Mon,  9 Nov 2026 18:59:26 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 086391956087;
	Mon,  9 Nov 2026 18:59:22 +0000 (UTC)
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
Subject: [PATCH 4/7] debug/mem: name pthreads
Date: Mon,  9 Nov 2026 13:59:04 -0500
Message-ID: <20261109185907.3220584-5-jsnow@redhat.com>
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
 meson.build              |  8 ++++++++
 util/qemu-thread-posix.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

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
index 089606c93fb..353fc1a4be5 100644
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
@@ -373,6 +381,32 @@ void qemu_thread_set_name(const char *name)
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
2.56.0

