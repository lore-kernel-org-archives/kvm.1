Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258E33D507
	for <kvm@vger.kernel.org>; Tue,  3 Feb 2026 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120235; cv=none; b=hOMNfHbFhLsmz/kRn/jJ55BswBH/PIvwLjVH9vXv03Hsx9u5JVaeAJgD3rrYY9/x3jnr6LiVZgwOltv0WY4IdLQn99n2Gr3VWqHafAKSY+c2D+0iVBm4oNrpSgxeZqrDuIwvVCHp9785d8w3/Pl9ZCZ04FVZ2TvIsfyYrijMIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120235; c=relaxed/simple;
	bh=iGCV7uQb4+uA+9NBBE7tLh3lksYPvYjJqnsLoNx7ARM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcKMFR3g2uUjzo6Y7Q/EX+ppF6z5xV/yZSHBPnh73cxT16hZSvKBdDqIJrkGCV93kjR3K4G2cQ2pa+sieg8dNAjVDAb8lq1/g+Wb6IWzwPDSpSLYMWDGFaP+POCQr75xNzeLLaRIZJKRbRkdf6jqJea/0PeGPrXLhWxOF1a9TMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYBtD5+z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYBtD5+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770120233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeUdPIwin4GXCOHm1PtZBkwiEuXj89BYMFu+KGQfKm4=;
	b=CYBtD5+z1yEs7J5mqG7l2aMRDQgFu5Fkdm/jD9nB1r8tI3rvWm6C2qseNWwmMg2vQM/B35
	5JfmaOX/d/iwXq3KTs2/OKJmdoiVLNHozqwVOlvnTGtKnpkKOmUsgschAwspyWoTxUmwkf
	zdZLikLdiqRyAPmI9FuzCx+zJC2etMA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-fqGLuXVfO1mIKDGwsjPA-w-1; Tue,
 03 Feb 2026 07:03:50 -0500
X-MC-Unique: fqGLuXVfO1mIKDGwsjPA-w-1
X-Mimecast-MFC-AGG-ID: fqGLuXVfO1mIKDGwsjPA-w_1770120229
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D2981956052;
	Tue,  3 Feb 2026 12:03:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA334180094B;
	Tue,  3 Feb 2026 12:03:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 981191800623; Tue, 03 Feb 2026 13:03:43 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Ani Sinha <anisinha@redhat.com>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Eduardo Habkost <eduardo@habkost.net>,
	Zhao Liu <zhao1.liu@intel.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	kvm@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 03/17] hw/uefi: fix size negotiation
Date: Tue,  3 Feb 2026 13:03:28 +0100
Message-ID: <20260203120343.656961-4-kraxel@redhat.com>
In-Reply-To: <20260203120343.656961-1-kraxel@redhat.com>
References: <20260203120343.656961-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Payload size is the variable request size, not the total buffer size.
Take that into account and subtract header sizes.

Fixes: db1ecfb473ac ("hw/uefi: add var-service-vars.c")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260114104745.3465860-1-kraxel@redhat.com>
---
 hw/uefi/var-service-vars.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index 52845e9723d3..94f40ef23684 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -593,7 +593,7 @@ uefi_vars_mm_get_payload_size(uefi_vars_state *uv, mm_header *mhdr,
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
 
-    ps->payload_size = uv->buf_size;
+    ps->payload_size = uv->buf_size - sizeof(*mhdr) - sizeof(*mvar);
     mvar->status = EFI_SUCCESS;
     return length;
 }
-- 
2.52.0

