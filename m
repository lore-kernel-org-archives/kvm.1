Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124945;
	b=0e/qa14h4iUF2lQlv5dTYXdeV+rlHh9TU0HfKo2V2f3DBG1MFh95BvS8+HRxigRVYGf1
	 IGtsryFo6l7mxxe5gHUm1jLoInVenkZs48OPtRi3rOlYEhKZJPIDhGraB9HtMLc01VJ9l
	 xedaJT30P6q8UEpD2QRO67Zdogw1epo+1NrnL3N1kmFeAqHU5wbBioNc8bf50pwci0T9t
	 LLR18CLu/3jwy5JpGzfat7tyLAMqKYLlb9uKyMdoigQCjxDu5uDxDvPzBXn3xMYd0eTYG
	 F5+i9fKwC7RkbWWJ/rZPvaDVzh57W8zbSg2ez8k5z/hd9aSKrPYOKGePkaLpkCi6csw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124945;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=sKIoYOrDenZa1R+DPeUDUjirn8ohaLCMSKPzoV+nbNc=;
	b=X1qJsn0F8XlT7OelaSZx5x4hGq1O+JRJMSHWcA7XR71IhzYHEioJ6yH5cQ6TPdxsDFAl
	 RzmUQOjt1xiao0uaGBHvwhXRUVyVHLwDpH49W518stLerBNflRGw9pLtQgv8CXzvlTkUN
	 36KpvlD5eS4r0zl7evGooa+B+zUvTRKMPlBMKCt7Os3b3i8qfbce1h/lVXCQe1sQewSGW
	 IXCv8fRA7crE8f4ZMcIXuRwiPA9RMBN4B+TsitheRy0iFPEqnDHfWk7i1CSvThfsM62sp
	 bHTjSkuhU3CkQLediLn9HEpy9d5hxQ9SEr3Up/dMMtXID7OYAeGOi5qcmijVknE2DHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LjQ78Nfb;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F94606A320
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34F94606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LjQ78Nfb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793124944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKIoYOrDenZa1R+DPeUDUjirn8ohaLCMSKPzoV+nbNc=;
	b=LjQ78NfbhoyXzO8M5HmTpIz9g81qJYwxItXL1NddQKolMxvBZVZC3usHQ2wP1kSQcpt2Z2
	Sx6IWrs+K7CucJ5wPjBdxz4y7js2zSDNC5leLMtahj8dr4WYM456JZnqXa1aodahnocPby
	MtLJRjmd20W/0tHQMQ73/Fw9RCNqzUE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-JOn5XFgQOvy5Nv457LYFkw-1; Tue,
 27 Oct 2026 14:15:40 -0400
X-MC-Unique: JOn5XFgQOvy5Nv457LYFkw-1
X-Mimecast-MFC-AGG-ID: JOn5XFgQOvy5Nv457LYFkw_1793124936
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 575E019541AE;
	Tue, 27 Oct 2026 18:15:36 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BABAD1800586;
	Tue, 27 Oct 2026 18:15:28 +0000 (UTC)
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
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 11/11] accel/nitro: mark 'nitro' accelerator as secure
Date: Tue, 27 Oct 2026 18:14:00 +0000
Message-ID: <20261027181400.1752951-12-berrange@redhat.com>
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

The 'nitro' accelerator is used with a real AWS deployment and
thus is considered to be secure.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 accel/nitro/nitro-accel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/nitro/nitro-accel.c b/accel/nitro/nitro-accel.c
index a1e97a9162e..a1489b8019a 100644
--- a/accel/nitro/nitro-accel.c
+++ b/accel/nitro/nitro-accel.c
@@ -251,6 +251,7 @@ static const TypeInfo nitro_accel_type = {
     .parent = TYPE_ACCEL,
     .instance_size = sizeof(NitroAccelState),
     .class_init = nitro_accel_class_init,
+    .secure = true,
 };
 module_obj(TYPE_NITRO_ACCEL);
 
-- 
2.56.0

