Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC62C11ED
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619143; cv=none; b=HbFywHcvnocvNIYhBkGoVaKSpo7I/ynz7a70KxZ646d6sGf3Yzd8uqLNmnmJVkNhCbIVmWFrJzSCV6+FSMySYcEa1lb7ejbvp6HdecqvZpynpcjR7jqCOl9DHysWw46svNPFmxW9KyVCDHPDaCQtrGQ+d/3RMvAFpm1iSGjWhPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619143; c=relaxed/simple;
	bh=JJ9s6EXYd8A6IBGfE9x5tI1Y7hIRtXXfqLkuA6zDkzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzEnIJVL057dnUz0nfH6gfkbRu4QCHbe72AmFh2Fe6X3Yr4EdZCIy5oy5MCntLED3oZ60YXfmB+NqG95V19Cu/3QfWvGn3v56x77Ft/tajumBzcCY8ujjO82I5m1YGLcGryD29gsabsvbVmnO5utWy55tsg7glXLcEIwpf0gghQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkeoJNbV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkeoJNbV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JzUxiWgZKU4O9M4M3xcPRJsDXu15tLrDMHHzBytk4Q=;
	b=PkeoJNbVe/dge9spNlEMSuViugDhY2zQ6HFkxgQo3ZSb4Iwg1Sy4dOI4VpauIFydVT+6s1
	Q8UqEGkz/U5Y3rbUEp/9buq53P7kGQs/9hzAm9BDM4E2/d9rW/BGq0xQKzjN8c/Vq6Wdrj
	BPRlK9SdT52bXVPIt18N2htdZAi/R9Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-_BZLUMrgO5OwUxmnCD4LLQ-1; Fri,
 27 Mar 2026 09:45:37 -0400
X-MC-Unique: _BZLUMrgO5OwUxmnCD4LLQ-1
X-Mimecast-MFC-AGG-ID: _BZLUMrgO5OwUxmnCD4LLQ_1774619134
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31BC0195609D;
	Fri, 27 Mar 2026 13:45:34 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A55C180036E;
	Fri, 27 Mar 2026 13:45:27 +0000 (UTC)
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
Subject: [PATCH v2 11/15] osdep: Remove unused strings.h
Date: Fri, 27 Mar 2026 15:43:57 +0200
Message-ID: <20260327134401.270186-12-kkostiuk@redhat.com>
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

We don't use strcasecmp/strncasecmp anymore. Also, we don't
use any other strings.h function. So this include is no more
needed.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 include/qemu/osdep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 92856decd4..3718fae351 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -114,7 +114,6 @@ QEMU_EXTERN_C int daemon(int, int);
 #include <stdio.h>
 
 #include <string.h>
-#include <strings.h>
 #include <inttypes.h>
 #include <limits.h>
 /* Put unistd.h before time.h as that triggers localtime_r/gmtime_r
-- 
2.52.0

