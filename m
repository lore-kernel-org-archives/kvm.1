Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600372;
	b=mML1AhRITQZ0Q0+bwu4t9x3nek0B0o6IExdndrCV7T9R/7hv7hHe9whkwV6YQyeQ3omh
	 zdw6NV14eOLZXpkKXmq1sKkFRac8pWo+qL0n5eLsLHYT8Jld71qcqJiJ3QoCSAceoRV0K
	 w740GODfeYumQBNYtPgvqzCEMFBgSl59acT8Cx9Y6bOcLbdBGBuhPyz4hZgzdRXu1ygFN
	 iYQ/YMpSgxa83/vGXEcyRJW7RKDvTPWAp46RXiWlR57mN8RY3bF1ICpCyXN2Shlfl1FuO
	 G/dPW1+VER0GoJ2OsWWlu2PN85rQCico4E0LzzHBCEVkToY+bKHHV4VNCpRfXQpmS7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600372;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=10yZLh8hPPLWb86UtjEQBBrvb3K+69MRCSe8pZYeX/Y=;
	b=kplTKuk8CVlWsZuKjQublUs5OV0dwKu/i+viXicqj4MI3TTS78X84cvzK+B4uxnRKVCH
	 p5HNsLKgyjqURSURiNZSSxKTDOFthmc2LVglbx3S81mRyv8NaVhv5gRFwd/7jccgXOlR7
	 Wn4ohaIK08Gxf+5ULIoqrXQeuIj48nt0LlcIDLT1g6hh8dDvjFeXHwyAkjg0ATWqU4m78
	 Rl3SChAyfqZKzc64bWwMhFemg/xPVWMARFA9IHm1jo9oicwEG+5SPh+nnfNHLcRd+k+vp
	 yVJAiGMmcD563beZ2gqNmXWwLFBbz55j+L9wcqMnhaQ+MeV7j+118H0Lqegmm7exuZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G+bTZL7B;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF36606A32F
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF36606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G+bTZL7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792600370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10yZLh8hPPLWb86UtjEQBBrvb3K+69MRCSe8pZYeX/Y=;
	b=G+bTZL7B0vbAMRm8I+p3a2Aekif5XxmLVylG/6O9F3Ex3YjfbHJ/0vCkDwU5VrU+frJ0iu
	HVQqJS7aGjLOe30f//LpcksQlJ6olHXmDcIGhz9lWyJI90EwFCdv5vVVhZPI6JQ/vl6BbQ
	ttJkX+MDpD6rVn7ZoEK7rD7B1dD+ToA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-gynGLf-qM4SnTryflJGB7g-1; Wed,
 21 Oct 2026 16:32:47 +0000
X-MC-Unique: gynGLf-qM4SnTryflJGB7g-1
X-Mimecast-MFC-AGG-ID: gynGLf-qM4SnTryflJGB7g_1792600366
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50EBF1956071;
	Wed, 21 Oct 2026 16:32:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D73518005B7;
	Wed, 21 Oct 2026 16:32:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 3D6D91827598; Wed, 21 Oct 2026 18:32:40 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Ani Sinha <anisinha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 10/10] backends/igvm: fix parameter area entries leak
Date: Wed, 21 Oct 2026 18:32:38 +0200
Message-ID: <20261021163239.1131460-11-kraxel@redhat.com>
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Stefano Garzarella <sgarzare@redhat.com>

qigvm_directive_parameter_area() allocates a QIgvmParameterData entry
for each parameter area, allocates the data buffer, and queues it in
the list.

At the end of qigvm_process_file() we iterate the list to only free
the data buffer of each entry, but never the entry itself, so all of
them are leaked.

Let's also free the entry itself and remove it from the list. We could
avoid the removal since the list lives on the stack, but it's better to
leave the list consistent.

Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20261021082459.72038-1-sgarzare@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 4b9d78630863..cf8b762d824c 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -1086,7 +1086,7 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
                        bool onlyVpContext, Error **errp)
 {
     int32_t header_count;
-    QIgvmParameterData *parameter;
+    QIgvmParameterData *parameter, *tmp;
     int retval = -1;
     QIgvm ctx;
 
@@ -1186,10 +1186,11 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
     retval = qigvm_process_mem_page(&ctx, NULL, errp);
 
 cleanup_parameters:
-    QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
+    QTAILQ_FOREACH_SAFE(parameter, &ctx.parameter_data, next, tmp)
     {
+        QTAILQ_REMOVE(&ctx.parameter_data, parameter, next);
         g_free(parameter->data);
-        parameter->data = NULL;
+        g_free(parameter);
     }
     g_free(ctx.id_block);
     g_free(ctx.id_auth);
-- 
2.56.0

