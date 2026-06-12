Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5EF35E949
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276447; cv=none; b=j6FLefBrw5nW+CpXz/FcRenKY1F+q1a3LZI6lxmx9EjTq0hHUNBT8a8NFt8GxIoZQXA6xLl2m1/5yHQUSc+MMz37yNQ8GvQGgH7+js3+pD04BBUwMu42zI3tGPH/EECkEcOsmF/HbjqPooA2IU9EYCyAaUkJ1SoDENdudftH/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276447; c=relaxed/simple;
	bh=hYSRYjMPMxI1GzWpT7bxOFdiqcUGpvzifQdkodIai14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzmFcg2Ogl+SULU17NmWKpTszHcgBK10wo3/EytSXVC6BFCsI0fNt7YBX43lptNu9McI1mQxvrXvzlN4e/p1tN4jzy459EFVBJ1sZejNb4PqsH27hlU0Dz9XYlSO37EpVxcEA4kTV9nqBP7b3cEAcjkCxhtq1hv+3unibrFUdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FQaB69UP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQaB69UP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781276444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vnbWX1Uf9fJ5n9pZHlTP11jwn1zRPMTrBKBQXMgAwWk=;
	b=FQaB69UPSIlxjlX6E6u+mcgjzeenemFJl19oGhwlOP86hsNWcHW2X+fM6gIQApMfeIAOB9
	+fjsX+RrnpuYW1yJ+g06nTWgIp8e6FwBd02JNF9yG5+guFVWOThIN8YVbFn+Zk1dIrzD+/
	M3ffzMclR26IOcreudlrapZKIKolK2Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-U72KixcsNn-blwR5AsKDsg-1; Fri,
 12 Jun 2026 11:00:43 -0400
X-MC-Unique: U72KixcsNn-blwR5AsKDsg-1
X-Mimecast-MFC-AGG-ID: U72KixcsNn-blwR5AsKDsg_1781276442
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1885A195609E;
	Fri, 12 Jun 2026 15:00:42 +0000 (UTC)
Received: from intellaptop.lan (unknown [10.22.65.135])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15C3A1955BD4;
	Fri, 12 Jun 2026 15:00:40 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH] KVM: selftests: access_tracking_perf_test: bump number of NUMA nodes to 32
Date: Fri, 12 Jun 2026 11:00:38 -0400
Message-ID: <20260612150038.1277394-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

It's rare to find a system that has more than 4 sockets,
but a system can have more than 4 NUMA nodes if each socket
exposes its chiplets as separate NUMA nodes.

In particular, our CI caught a failure in this test on a system with
two sockets, each containing an 'AMD EPYC 7601 32-Core Processor'.

Bump the limit to 32, just in case.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tools/testing/selftests/kvm/include/lru_gen_util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/lru_gen_util.h b/tools/testing/selftests/kvm/include/lru_gen_util.h
index d32ff5d8ffd0..49c8139d398c 100644
--- a/tools/testing/selftests/kvm/include/lru_gen_util.h
+++ b/tools/testing/selftests/kvm/include/lru_gen_util.h
@@ -14,7 +14,7 @@
 #include "test_util.h"
 
 #define MAX_NR_GENS 16 /* MAX_NR_GENS in include/linux/mmzone.h */
-#define MAX_NR_NODES 4 /* Maximum number of nodes supported by the test */
+#define MAX_NR_NODES 32 /* Maximum number of nodes supported by the test */
 
 #define LRU_GEN_DEBUGFS "/sys/kernel/debug/lru_gen"
 #define LRU_GEN_ENABLED_PATH "/sys/kernel/mm/lru_gen/enabled"
-- 
2.49.0

