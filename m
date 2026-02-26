Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AA836B043
	for <kvm@vger.kernel.org>; Thu, 26 Feb 2026 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114422; cv=none; b=th9VQvDMMw3acGkrrZ+lKxHjCgTnUVqnQFZcx+k24FfXXTjZwxoiSxWi/Wn9Dtgkk5eHqEa+oKhIokE2gZYVKfkbsmZkMB+gbB75nBSGOHLa8c6W6l1tv4GGPvNvX3R759P2hGPqSXaE53sPQsgaURA0GnHIPVb1qU01/aZbUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114422; c=relaxed/simple;
	bh=qGMy+9B/VDohah3Jf8ZMby2bn9uFEjN7eTWiDdVP4iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAJ/iP0eDy1U+nmov1U6D/AzC2Kmm/4SITNbL6yubHa6+cbkbIidQZPCe843YmPJzbyCyVgwKNSKLq5Z6kxUZG1x6o2qU+PB8uUh/WLdeCvDaO761eybtVsFm/0RklIknaFOyAkj9KE0G5+50LnsbEyCBmY2Lkf7yd79XXWj00Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUiSdgLc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUiSdgLc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772114412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0fag7QDI9+TsFrYsYMuq+MvAPEZW2et9VpqeBxsP3bI=;
	b=KUiSdgLchalaEmGMVhvKlDSyv5yJFNvO4p82V9eRpPxSEhodalEv8ZwcFMBPJtLnoIzC8l
	+dsdMlAQUixK2bTL4pJV5GxVh9HoQefmBPAhwm+CtI0A/NoqG/epVP0BxwK7sCn4Op78Ev
	Qpd/FPsKwCYj/yixgnVGu+DtCBjlexI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-fYlLySYMPPiwFCHvAZgZHg-1; Thu,
 26 Feb 2026 09:00:10 -0500
X-MC-Unique: fYlLySYMPPiwFCHvAZgZHg-1
X-Mimecast-MFC-AGG-ID: fYlLySYMPPiwFCHvAZgZHg_1772114408
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C3A218001E3;
	Thu, 26 Feb 2026 14:00:08 +0000 (UTC)
Received: from localhost (unknown [10.45.242.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A7873000225;
	Thu, 26 Feb 2026 14:00:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Ben Chaney <bchaney@akamai.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Fabiano Rosas <farosas@suse.de>,
	David Hildenbrand <david@kernel.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Peter Xu <peterx@redhat.com>,
	kvm@vger.kernel.org,
	Mark Kanda <mark.kanda@oracle.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 01/15] system/rba: use DIV_ROUND_UP
Date: Thu, 26 Feb 2026 14:59:46 +0100
Message-ID: <20260226140001.3622334-2-marcandre.lureau@redhat.com>
In-Reply-To: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Mostly for readability.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 system/ram-block-attributes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index fb7c5c27467..9f72a6b3545 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -401,8 +401,7 @@ RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block)
         object_unref(OBJECT(attr));
         return NULL;
     }
-    attr->bitmap_size =
-        ROUND_UP(int128_get64(mr->size), block_size) / block_size;
+    attr->bitmap_size = DIV_ROUND_UP(int128_get64(mr->size), block_size);
     attr->bitmap = bitmap_new(attr->bitmap_size);
 
     return attr;
-- 
2.53.0

