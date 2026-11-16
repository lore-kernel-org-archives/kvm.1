Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847841;
	b=NmraQbGizt9lqgDxj1+UZ9uhTaJd+icNoY+8qEJTXYakEu7+4tINmv9xZRQISFE8XQgS
	 QP/kzq/CVfFOXQwTNABq5lmeikjjQ/j0sAfqxrSMWG6ND8dXPL+tRVn8InoQoKJrTpRJ6
	 ZZ+7PB6yeIxQha0gfJGdj2g1JY84OSWC5JbmEyK9IVjDtysFksrt6T5djLaVflEYbjrf1
	 GJlUStvkdhdHlCVgPvVxK9bCFScfQJV36Y6wQqmJTpSP30Q13+Q7gM+GQ6gedP9Q+RDcP
	 x8luvbp0tIznBh0Qeg0HGcC9tjvNXFKnFCxLc/nDCSxpmhUX9PTSYXJeSD/cDA5dSNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847841;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=NIkcB0xFVInRVan0YUgAxqPrhANw4KC3xtWTa3NWmiE=;
	b=19gdbr3zDUwzMvmFSu5MWB/k8nh/BXlzWzs6YF4ZmiZVN3vgB4w/pLf8fxiRdtyqst9p
	 jVCA9YmKhqrgU7jyeWYsp/eZrz9MDPNx4RuzOqjtJoMs+Q2ttsCcf/EI7QeftUc6jYxWH
	 RFcFegboI2DyU4qREW2YKmWrRc1CgXlsah9/h/fQQlIMz8bQ0QXyZwH4w6tod9oFDJcrN
	 sgArLJ1EZfvah81W8uBcfS8JqzDAwXDZW8kna4kjKJXA3+Esq368MCfhTTYgc32den1k0
	 3K2c7XdhFXyjRMokX9Y3G1En1y9wwIYBFy/gIeop08HXFN/54UkjuzlwB4S2liv02aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fKv8unhj;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5431606A32A
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 16:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5431606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fKv8unhj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794847839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIkcB0xFVInRVan0YUgAxqPrhANw4KC3xtWTa3NWmiE=;
	b=fKv8unhjHurlRq7508NbrTl8qz4nA+YTAi+7IUNnHr5Lmt1yw6fjcUfzvG8tL0ltvGrlV4
	ImOtoKH3qz3P2kHOaEeiaymek06phTo/YBeRDX83ZwvuGnReHEwAUsL73YVPAElmaY/D37
	4ArHAmH92I7GGmdegw/110evycRyq+4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-4TvjXVxqOGu-um8TZYAVbA-1; Mon,
 16 Nov 2026 11:50:33 -0500
X-MC-Unique: 4TvjXVxqOGu-um8TZYAVbA-1
X-Mimecast-MFC-AGG-ID: 4TvjXVxqOGu-um8TZYAVbA_1794847831
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40DD91955EA8;
	Mon, 16 Nov 2026 16:50:31 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 24AB9195B3C7;
	Mon, 16 Nov 2026 16:50:27 +0000 (UTC)
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
Subject: [PATCH v2 5/7] debug/mem: name coroutine stacks
Date: Mon, 16 Nov 2026 11:50:00 -0500
Message-ID: <20261116165002.30939-6-jsnow@redhat.com>
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
2.56.1

