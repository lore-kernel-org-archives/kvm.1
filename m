Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250781;
	b=ZJz5KAmgmm6H13sp3454SnlNKefn1djd+DG984zASzZF2OIAfpUiu4gS8feyjj3WQ8JG
	 OQ+kBO/lxPRoroHIsnvIEeeyFYxQRhMPPf1E6iRMitVdaLmdfXKRmqTnun711520uycVe
	 WjTiBqCqqdzDPI2p4KbFJViZD7mT1THIlWZgLZuhJGCyt0dV7HdbpuZULrAFLYfSvGEzu
	 u+zEJVGssE39fha9/VRv0OhBWt0ndaG/D6NIE94eSa7O2SfKwUBnxbThjf2qM3tJaIjxM
	 0P40uupjX1zMXcZnbKGUrAGgQI3mlxD8dEWUBFlkI4/tCcU71sIJNT8KCDQGKDp8e3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250781;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=R8AIIl3lqxkoUiy2gww46SkIgsFvv8BhihUMvgLblus=;
	b=KOxC9b4/HpWq639jvhgVpdscz9UXxSf6bqPpgthsTYtWzB5rI6ExJPCLWN13C60Ss3GS
	 xoafw3vGWlgBB4e0b4L0JxfBtWSSuWfV+ZQTGYrb/96S39wO7GPf748v4jBKKsvrXIfze
	 Eq8sJidd7h7o4w1yhuPsRJSc9ekh9F4TJqTobvn/eJMD364R8tmYjP/8uhSxKChZZLukT
	 PmMtvvhuodnUG2qVaxWZ0pvQp3pBMgqs4d0wiLatnMSt5IBQTQETsqG/1sEQ7F4gIgZ/f
	 kWRFttdjB48uBA841v8cYGGYqQwKira+Nk6i8MyH0695m3V0646dE0utJJjXHR6p10A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VlQo6VJv;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849EC606A321
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 18:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 849EC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VlQo6VJv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794250779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8AIIl3lqxkoUiy2gww46SkIgsFvv8BhihUMvgLblus=;
	b=VlQo6VJvPpSADeHe8pxtvmfP2qL22HIYu/9yqpm0Y1uTF2NsDgx5EMbavsL9ckbTvlU2P4
	Ff1BcSxdUOubwZsr6g2ID5WS700pbWkT2Pdc5YiV5fgZ0PAoH99N6KwQJswfoKFpdLVwLJ
	g9Nnx1XSB9M3dE7Bp+xx/RR9Dm2TPnE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-Z7wKWRe6OneiSd1nS9wdAg-1; Mon,
 09 Nov 2026 13:59:34 -0500
X-MC-Unique: Z7wKWRe6OneiSd1nS9wdAg-1
X-Mimecast-MFC-AGG-ID: Z7wKWRe6OneiSd1nS9wdAg_1794250772
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45C8B1800654;
	Mon,  9 Nov 2026 18:59:32 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79FB6195608A;
	Mon,  9 Nov 2026 18:59:26 +0000 (UTC)
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
Subject: [PATCH 5/7] debug/mem: name coroutine stacks
Date: Mon,  9 Nov 2026 13:59:05 -0500
Message-ID: <20261109185907.3220584-6-jsnow@redhat.com>
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

Simple enough.

RFC: Is there a better name we can give these to help tell them apart
during analysis?

Signed-off-by: John Snow <jsnow@redhat.com>
---
 util/oslib-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index dc001da66dd..454579c72df 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -60,6 +60,7 @@
 
 #include "qemu/memalign.h"
 #include "qemu/mmap-alloc.h"
+#include "qemu/mmap-vma.h"
 
 #define MAX_MEM_PREALLOC_THREAD_COUNT 32
 
@@ -742,6 +743,8 @@ void *qemu_alloc_stack(size_t *sz)
         abort();
     }
 
+    qemu_name_vma(ptr, *sz, "coroutine-stack");
+
     /* Stack grows down -- guard page at the bottom. */
     if (mprotect(ptr, pagesz, PROT_NONE) != 0) {
         perror("failed to set up stack guard page");
-- 
2.56.0

