Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88720314A73
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468842; cv=none; b=TIvae1vwhfGHibBf5EC6/Sv6WXeFO2wUbwtQhl1x6bt5tXejphqmgAdOue8bd2qE2dtJEumw0vab6z43jBwhI1aJhY0p93IB93Wt1r2ii9ZCAzVZSgg4aRHrHViNG4XNqcc/UAe4ypGPVFOGoooMqu2b4pAv+DHOCcXuDNTG+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468842; c=relaxed/simple;
	bh=W+ClzpbdxAho7SOjRqsyxCEb21UGH/sycxFU5jECovU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcKbTOGuTIu6BpVAgCSlHv7y+0IJ8mbj7gJlR0jyvQgWRiOiuKSB8ISdihGTzz0KTJPmRwwIwwXeMCAGmSAQCiWiqZhOIzIGT44QC2GTAXhwddg82g/ckVZtkuGKsU1ZAUfUfByagZr2u40RaHGUK/b1kVBrwT6Wd9cvayxi+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fny62pEO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fny62pEO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780468840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFui4GNakjjw5JO9Fpd/aZjcBIoQaZIheDaZ5Ws+Z+M=;
	b=fny62pEOvYrgTZeDAuZm8/LFrB6RXD8VWKrxp2qsnnnO+L4GvPmmWxQJPP/DWzmTay3kc9
	iWwmuIZgGYsaPHQlrqngaTx5cuJ5S/EUXGZv7lqqwhBlAYhglwhORSJLtG18A8xsm1AB4d
	3F5EClRyW82j7JwrGftIdotqunrCAuI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-n6Xvih7dOt-01C0DWH8-FA-1; Wed,
 03 Jun 2026 02:40:39 -0400
X-MC-Unique: n6Xvih7dOt-01C0DWH8-FA-1
X-Mimecast-MFC-AGG-ID: n6Xvih7dOt-01C0DWH8-FA_1780468838
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56F881956096;
	Wed,  3 Jun 2026 06:40:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C6DE30001A1;
	Wed,  3 Jun 2026 06:40:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 4625F21E6A08; Wed, 03 Jun 2026 08:40:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@mailo.com,
	pierrick.bouvier@oss.qualcomm.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH v2 05/38] MAINTAINERS: Drop stale F: from "Overall KVM CPUs"
Date: Wed,  3 Jun 2026 08:39:59 +0200
Message-ID: <20260603064032.3733394-6-armbru@redhat.com>
In-Reply-To: <20260603064032.3733394-1-armbru@redhat.com>
References: <20260603064032.3733394-1-armbru@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

We neglected to update MAINTAINERS when we moved the only file out of
include/hw/kvm/.  Its new location is covered by "X86 TCG CPUs".  Drop
the stale line.

Fixes: a09ef8ff0a (hw/i386: Rename 'hw/kvm/clock.h' -> 'hw/i386/kvm/clock.h', 2023-06-20)
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37741e21c4..15793b088e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -471,7 +471,6 @@ S: Supported
 F: */*/kvm*
 F: accel/kvm/
 F: accel/stubs/kvm-stub.c
-F: include/hw/kvm/
 F: include/system/kvm*.h
 F: scripts/kvm/kvm_flightrecorder
 
-- 
2.54.0

