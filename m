Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B3A19539F
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619158; cv=none; b=j/dJah5LLjMr6mzYr+ZBLIKjyMlNl1vC12TEdWUqe4m40QqUu8x/g9mQvOnvjDfLZTzM17BzyE+5U6qczSNcTPsExOBZn71Cyg77UVZN/4dAktnzO8k9O0B5dxbagHskgxecTttRkvOssttbbfuo+RYswZo/s94Tt3oggrvUp/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619158; c=relaxed/simple;
	bh=c3mVjb6wN+TobTFUpN6z58EA3mk11MtqkXu9Q9Krryc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+RmPK2ONN6/bhGhH9e31e9ZKnTApP8l1qKovZZd2+4RoJVX1lWQoaCPgJRofTn9zqnhb3z4UfTErrqvyI9BQY1Llu8N9heQ6o9a9eyHwKULYyO4kMSZjrQvhElDaKXT4Fq39Dm7YQGvK/PtlCO390FJw6GWKiGOqiNb4e1aowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUpvz4/S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUpvz4/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=al9ExX2ImXT8VgwUSzpMpZ+eHQjM6CUZRhwAlfG5NYk=;
	b=GUpvz4/ScR6HJbxTLf/jb1HJYQ1nEbbRsp8xJYVsrs6LQYh0ctv9FztLZTwiumL6muxm11
	+4Jqvcu2mEB0Pv+/+VlA5TKAdEwntucVoeMIpA6e0ATKmeWa3oqHJsPEfB6sU4FW6+f3hw
	NxtxARCqOgWmddRbzM99c/niMkviiLc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-elAPclLFP-ixny2BGczEcw-1; Fri,
 27 Mar 2026 09:45:52 -0400
X-MC-Unique: elAPclLFP-ixny2BGczEcw-1
X-Mimecast-MFC-AGG-ID: elAPclLFP-ixny2BGczEcw_1774619148
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C4791944F0D;
	Fri, 27 Mar 2026 13:45:48 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80F871800671;
	Fri, 27 Mar 2026 13:45:41 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org,
	kvm@vger.kernel.org,
	qemu-riscv@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 13/15] util: Remove unused sys/param.h
Date: Fri, 27 Mar 2026 15:43:59 +0200
Message-ID: <20260327134401.270186-14-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-1-kkostiuk@redhat.com>
References: <20260327134401.270186-1-kkostiuk@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

We dropped the use of PATH_MAX in commit f3a8bdc1d5b26 (which
basically completely rewrote the path handling).
Now we don't need any sys/param.h defines.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 util/path.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/util/path.c b/util/path.c
index 72a255890e..e1565894d2 100644
--- a/util/path.c
+++ b/util/path.c
@@ -4,7 +4,6 @@
    The assumption is that this area does not change.
 */
 #include "qemu/osdep.h"
-#include <sys/param.h>
 #include "qemu/cutils.h"
 #include "qemu/path.h"
 #include "qemu/thread.h"
-- 
2.52.0

