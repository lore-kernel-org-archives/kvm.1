Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847830;
	b=Q80kJUgW45KwNvGZr3eijvGJQ/gt5eRKTLqQf2vCJqioZIE+yO7wJrq3csdu/CFRcCKf
	 4qOQAVHsdsbtftwhp7T1PZlx+wQCNZGwMfVmk4qMvwsAxMpkpL0OcG+890GvH53uH11oN
	 4QmQ+yekZZKYbdAxl3N3pfe6Yc4JjGgclnuT9Rnz+dyBhV5juUeu6BrcbAjzvVS09WAYv
	 cFtyp94l8ivTopUYDXPE4X6vHvFatyhGbxouZA03PIAxTFr3uXcjfYio67aHueis0PM4w
	 YJzdZbQUUTdqkc1IFFiGiVKl29HttWtayqfIQGLjWbLE6jaAeB4VfyZoemOE8sqSHxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847830;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=JSlihkLJpIlxY9tcrA9GhmKKT3bZReqpBGh+tfoa3wk=;
	b=lrCkbbWozOZYruG1Sv8SdCIrOnezNyZHBG3cGX9U2hRvUsSopLgZsf5ebecFCzjN+7qL
	 YNaPOZ5mbYBdDxISH/cbaSvCuybU1ZoNtnM5ALEeJxWGbWNOmaxVduENbw/XqwIMwpN5Q
	 3aRY+bkBjP/Mplvn7OKzp+mwlryTEtzrsLSpHYbc9EtCbCv2UESrDuMpU9SpJC7HI9+6g
	 dXqxYIeujQOZxqL1x5jOSPEcXqCFG8yi6GeItMWPSXG/SViWtpnssHQV9OuT7qeiagyBr
	 qQSVJkx+yG23bjYlxVUTYHbwvdJLuBvSRZmx0mPbHtVa2Tyk94ynvo5t/H1vNbq17kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fMvylNuh;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35D606A322
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 16:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E35D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fMvylNuh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794847829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSlihkLJpIlxY9tcrA9GhmKKT3bZReqpBGh+tfoa3wk=;
	b=fMvylNuhDupoFJ58NGCEJkDMJeSqU7oTsZIfshB5eYx8OmxcpeRH5JxIt8i6ys+FWUBw2G
	d49zdNgXdWCP3jU7Xyp3YnilOEQqqsh9q6YPNNvy6qJf8Bxmg/yGZmPO9+KQ9G8qc3wLrG
	tFxOjBZwjoTvX/aDmqS6/p76Ofolj7Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-yGqqOj_WOveyFYXSrH9_ZA-1; Mon,
 16 Nov 2026 11:50:24 -0500
X-MC-Unique: yGqqOj_WOveyFYXSrH9_ZA-1
X-Mimecast-MFC-AGG-ID: yGqqOj_WOveyFYXSrH9_ZA_1794847822
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B798B180055B;
	Mon, 16 Nov 2026 16:50:21 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 007FE195B3C8;
	Mon, 16 Nov 2026 16:50:17 +0000 (UTC)
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
Subject: [PATCH v2 3/7] debug/mem: name <reserved> regions in mmap-alloc
Date: Mon, 16 Nov 2026 11:49:58 -0500
Message-ID: <20261116165002.30939-4-jsnow@redhat.com>
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

For mmap memory reserved by QEMU, give it the name "<reserved>". This
will show up in maps output as "anon: qemu: <reserved>".

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/mmap-alloc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index ed14f9c64de..2133b2c9bda 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -22,6 +22,7 @@
 #include "qemu/host-utils.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
+#include "qemu/mmap-vma.h"
 
 #define HUGETLBFS_MAGIC       0x958458f6
 
@@ -152,6 +153,7 @@ static bool map_noreserve_effective(int fd, uint32_t qemu_map_flags)
 static void *mmap_reserve(size_t size, int fd)
 {
     int flags = MAP_PRIVATE;
+    void *ptr;
 
 #if defined(__powerpc64__) && defined(__linux__)
     /*
@@ -174,7 +176,10 @@ static void *mmap_reserve(size_t size, int fd)
     flags |= MAP_ANONYMOUS;
 #endif
 
-    return mmap(0, size, PROT_NONE, flags, fd, 0);
+    ptr = mmap(0, size, PROT_NONE, flags, fd, 0);
+    qemu_name_vma(ptr, size, "<reserved>");
+
+    return ptr;
 }
 
 /*
-- 
2.56.1

