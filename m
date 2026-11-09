Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250771;
	b=hV+o8pG0Xorx9BW7F7b52v6zvYzlLSCBUfOHFx2wfXBCnHO0jYLtDGa7SfasvJi4EZwu
	 BXyT3hhrqMTzQDnCOJfSqYJvd+V03fx7wBwVdieORRgH8pmKA+uet2S5HZCuWlJStO++1
	 9NuvKguC2EujhelNjUe2YO3dt4WA2fGFp2606LFYFFgLZ5Cyf9rVFu1kOzlSPpmJYUo3r
	 /u+01TWoNqpujr0tXKKfT0jnu8xeKIGxcIYIWHhCcyGHxRzZ73kLAew5ho1pAGtvgL/Dk
	 eVSKXNS1oX2QusuO8E/1UJfBFRkwUj4bpn68W58gHINbrf9/R0SiIllQGQu6TUdrtOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250771;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=5LNh5reSh+NvyeWrxM7NVu1un75hnLmQqK+4v90MiUo=;
	b=2tD1nWEiBmRxQubPeanLQXc1Ekv4XmtDEuFGkykmNQhg40mGatm5Cn8pikyOLXaTNkrO
	 EDPRUuK43VJ4J3VPP1yqQlcuW1Z6LoObnRRt//i3pyqSWbkNKeO2ohhOyK0n3+HwN21ht
	 ah+f44xgFLhC4xtHJ5FFd6JDdJhCGCl8eGNxW+8M7t8l4sqNvnkIJAzjo8PISGljO7gYZ
	 hvUulNdY/EcRr1puhWKoa1RWeqidmPCy4/U46rtXVz+TkyAW9yLD+G6xJBOZrakhVadsv
	 7PzMzANj4QX52q8f3sPesabGjdMcOV5ge1zE5GoCwWmAWK3re/x5UtT5qs6wzxTEadw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bw6Laizs;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA4606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 18:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EBA4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bw6Laizs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794250770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LNh5reSh+NvyeWrxM7NVu1un75hnLmQqK+4v90MiUo=;
	b=bw6LaizsdsFodPN3Xn5Bhslb2E8V+VmhjIrO3Zr+qTiaUFf/GV5G/lDIn7BYjNmQkCSB4E
	tOHpOyv76+ZEVvqpWPHQ9l6bmY0uMVXpZ/HpWvAxt4XDf68qBunnk64lbGHt7P6tqL6qgq
	FtyOLTwciRTCLRcImud+IV0PsNpwyvw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-4sYdBX3CO0ydzcpUbvpdJg-1; Mon,
 09 Nov 2026 13:59:24 -0500
X-MC-Unique: 4sYdBX3CO0ydzcpUbvpdJg-1
X-Mimecast-MFC-AGG-ID: 4sYdBX3CO0ydzcpUbvpdJg_1794250762
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7064180059D;
	Mon,  9 Nov 2026 18:59:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 96C7E195608A;
	Mon,  9 Nov 2026 18:59:19 +0000 (UTC)
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
Subject: [PATCH 3/7] debug/mem: name <reserved> regions in mmap-alloc
Date: Mon,  9 Nov 2026 13:59:03 -0500
Message-ID: <20261109185907.3220584-4-jsnow@redhat.com>
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

For mmap memory reserved by QEMU, give it the name "<reserved>". This
will show up in maps output as "anon: qemu: <reserved>".

Signed-off-by: John Snow <jsnow@redhat.com>
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
2.56.0

