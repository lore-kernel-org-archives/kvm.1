Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495F19539F
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619152; cv=none; b=M4iiRFVS0otDYnJS5ooBGglgEPHdKSGeB7SHh+vjOvDhzcEThI82wGlCvSwKWEKMjyFO4IX9P+GU4t8gQx+8FvdKsI/VR2rlzwY+qZ9aQND9ofZt3tdJLonOanavyq2Jx0hs7NFUnozUcWh9Qbx4HSloTaR6B/BKcSEmJYd6pdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619152; c=relaxed/simple;
	bh=JUhYp1jmNrDkMUY9Y/AKEoGrCYstNTgXV1+gNf0ZruQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8XDXGcIX+4NlGGonij/cmF3PBMZvjoNZs1puG3O2fujJsjJEEyWaTK0qCROkqSaOZ1/E7aP6Mbfa2zMZve1O2llLHt4WEDCRGfsamXmdh+MfUfeHLbtmgx3yQ5mQThdOSiJUDlW/VzKHo/4BUjchqqtzy08oDJpU98OxvTxolo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKfOFGzq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKfOFGzq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ad41TAA6YD+wE+pjIIDI/pzYRaxv7ZiF31pSiHV1SGM=;
	b=dKfOFGzqFJmHdd8AfbpUjWBBQDCZpie9NTvcjAprCJoTWoR0MpUSJjFI40yOHZC75cW+AE
	umAt7IHMSSJo2pled7XMiLMKI6q78sefaQUoPq6U9BegXntLpjxhzy6tItWeHbJxdcASTn
	2mLLIvXAcYkcG73X3yibKDpGAUbt1K0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-eeEIbjuLNOCEFgbMnnTnVg-1; Fri,
 27 Mar 2026 09:45:46 -0400
X-MC-Unique: eeEIbjuLNOCEFgbMnnTnVg-1
X-Mimecast-MFC-AGG-ID: eeEIbjuLNOCEFgbMnnTnVg_1774619141
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 161B518002EE;
	Fri, 27 Mar 2026 13:45:41 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CDD1180036E;
	Fri, 27 Mar 2026 13:45:34 +0000 (UTC)
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
Subject: [PATCH v2 12/15] util: Remove unused dirent.h
Date: Fri, 27 Mar 2026 15:43:58 +0200
Message-ID: <20260327134401.270186-13-kkostiuk@redhat.com>
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

This one is OK to drop, because the rewrite of path.c in
commit f3a8bdc1d5b26 removed the uses of the dirent.h functions.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 util/path.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/util/path.c b/util/path.c
index 8e174eb436..72a255890e 100644
--- a/util/path.c
+++ b/util/path.c
@@ -5,7 +5,6 @@
 */
 #include "qemu/osdep.h"
 #include <sys/param.h>
-#include <dirent.h>
 #include "qemu/cutils.h"
 #include "qemu/path.h"
 #include "qemu/thread.h"
-- 
2.52.0

