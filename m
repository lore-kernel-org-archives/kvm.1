Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124944;
	b=psPwBtAo3smlUDjSoFXJZiLQkrEpDtxnEyA2LAmCHgT+CZdjS38xoQgVCdZnr+EzFxPe
	 yHzwsiFdBhM90DumAxEG0UFeksRkU/Wpq+fsT+XXUGt0hIxP8BStuq/FM+xCmvpdcTwAV
	 9t/5SNiXll4GzB/V86YlR2kUq2spsSlY221MXz8Ne6h+4nF2FN/eZJYSKpF4todv+8y8u
	 MI/UWfSui4wHYmflMYcYDijmes9mktwHt3I5Koboko0B128ZjAg69fC/1eORa1/hhzaIx
	 IU+6sZiuL7mxXd124nfi00EWYEAlm1VRLnZi4RnLyov+iCK8dedRQGrop+D3rg/Am9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124944;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=buIH4vNJ8worC1Ayihr2YWFbS43gZwwGin2hAsqsREk=;
	b=I+H3DvOhTr1A2ERxZ9GK8IVoNoBW10BDN2PzzQkGTFaUow8iPtO6qUKqG9eIgbBdQVHi
	 cbObVgnTHgFlEJpnq5k/gUxsOeMP1mTXew34Tg6EIkqDjd4tv2mrGnWg46ycH3oJu2sGY
	 IwqzfQUYhWEFBg1cGi+5D4EcLLagBYDLHcDmbBe97yCxEgBhbESjVTSiqnr8RjQhPTrEp
	 0LCtB63V8dyi9ncLc+AJjd7DtCu80reYlajyCLpZx1Xv31uCrvcVL1a+x1cARwQ4a8iG0
	 oQOa91HRWGus494zCsAmSdZ0WEpQViyLYr0n04ELZYMuGMzPvuMLYFz76aCXkZOKxnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VOtzyEFt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F3606A324
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A34F3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VOtzyEFt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793124942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=buIH4vNJ8worC1Ayihr2YWFbS43gZwwGin2hAsqsREk=;
	b=VOtzyEFtzKrXYlzDeYF7GYoL+u9NHQCwsj2HgIxg2cXn1Wx5ySmHfi1PbEoPL7lb2ttn72
	uwhLQtxu16hVFLsJFLhT1YgOwEgDCquwccqYaZ4tCtH77Jq0vWTpJ6X3wyUiWn2xRwwuJP
	GkhxbKOLZuGqxZGzK/5TjL680ka+ly8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-cEwpYKv8NwSl2l1n83HM6Q-1; Tue,
 27 Oct 2026 14:15:32 -0400
X-MC-Unique: cEwpYKv8NwSl2l1n83HM6Q-1
X-Mimecast-MFC-AGG-ID: cEwpYKv8NwSl2l1n83HM6Q_1793124928
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AB521955F61;
	Tue, 27 Oct 2026 18:15:28 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1369118002B1;
	Tue, 27 Oct 2026 18:15:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Anthony PERARD <anthony@xenproject.org>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-riscv@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Chao Liu <chao.liu@processmission.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Amit Machhiwal <amachhiw@linux.ibm.com>,
	xen-devel@lists.xenproject.org,
	Sergio Lopez <slp@redhat.com>,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Xianglai Li <lixianglai@loongson.cn>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	qemu-s390x@nongnu.org,
	kvm@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
	Song Gao <17746591750@163.com>,
	Eric Farman <farman@linux.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 10/11] accel/xen: mark xen accelerator as secure
Date: Tue, 27 Oct 2026 18:13:59 +0000
Message-ID: <20261027181400.1752951-11-berrange@redhat.com>
In-Reply-To: <20261027181400.1752951-1-berrange@redhat.com>
References: <20261027181400.1752951-1-berrange@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Xen is servicing virtualization use cases which must provide security
and actively maintained.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 accel/xen/xen-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index bb2d02cb221..94f20e1d29a 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -147,6 +147,7 @@ static const TypeInfo xen_accel_type = {
     .name = TYPE_XEN_ACCEL,
     .parent = TYPE_ACCEL,
     .class_init = xen_accel_class_init,
+    .secure = true,
 };
 
 static void xen_accel_ops_class_init(ObjectClass *oc, const void *data)
-- 
2.56.0

