Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBA33B583D
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073797; cv=none; b=r7oWFTbZ/Ym4MPSQSElk+pNHu0RPbPpN8L96xb/Z3hxf7LyH6j+6ud+nYXbM3EEnjyH0BoawtgDNfNpq6dh+pLITCzuXoKmZVJ4UXhhsMal5sojyOg0GTA7lO+bs6D729qfipD8bTab+GUgV6wBitLaTyTDNs9a/FCLboAnyajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073797; c=relaxed/simple;
	bh=d8VlqqZzOtSELbayAIMPnJLZklCs4+y9xUGeB+gdnjQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=S1bnYkNd17eNPFhfEbYHlGiJZGBimjPpWg+GOaJ5m6QEKjtS4SaD7gZ5OebOGBNsQNOoB7pqv61RNpcSkWVJblwwwAffd3k9yx2iDzcAYc/Vhr258huGLeJNDbEOloxqPhxu1ArZTZRMkIbdtwucaeBkYakdzvuO+RCp6vjsKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddYU409n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddYU409n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776073795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HvLvl2APD79k2nrxxH0xkJLfyuUGGZmmE8cOXg/kcwI=;
	b=ddYU409n7rG7VacWOZGy7tpfzm9sq6TB5nu9c7q1+imngYHbbcirkNbyEvcW7gpScEbAeb
	Oqq5QZBCD4CELE0Iw59PEdc/rxC9J3JSTEzXQ32fnxpVO/BDraY/MZVQ8qbBnYt3OXVZHl
	EBp9IKVGso9qk47BxflqHT9SG5dbEbo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-eorGxrb8N0CiV0p58nB_yQ-1; Mon,
 13 Apr 2026 05:49:52 -0400
X-MC-Unique: eorGxrb8N0CiV0p58nB_yQ-1
X-Mimecast-MFC-AGG-ID: eorGxrb8N0CiV0p58nB_yQ_1776073792
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC4DE18002C0
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 09:49:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.124])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6FC871956056;
	Mon, 13 Apr 2026 09:49:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [kvm-unit-tests PATCH] x86/eventinj: Fix flush_cache() macro for the newer versions of Clang
Date: Mon, 13 Apr 2026 11:49:48 +0200
Message-ID: <20260413094948.14505-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Thomas Huth <thuth@redhat.com>

Clang v21.1.8 from Fedora 43 complains:

 x86/eventinj.c:347:2: error: variable '__l' is uninitialized when passed
  as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
   347 |         flush_stack();
       |         ^~~~~~~~~~~~~
 x86/eventinj.c:39:33: note: expanded from macro 'flush_stack'
    39 |                 flush_phys_addr(virt_to_phys(&__l));
       |                                               ^~~

Initialize the temporary variable to 0 to avoid the warning.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 x86/eventinj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/x86/eventinj.c b/x86/eventinj.c
index e72efa16..7f68bdb8 100644
--- a/x86/eventinj.c
+++ b/x86/eventinj.c
@@ -35,7 +35,7 @@ static void apic_self_nmi(void)
 	} while (0)
 
 #define flush_stack() do {						\
-		int __l;						\
+		int __l = 0;						\
 		flush_phys_addr(virt_to_phys(&__l));			\
 	} while (0)
 
-- 
2.53.0

