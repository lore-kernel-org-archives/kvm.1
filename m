Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124929;
	b=H/dahG3dYNnNbA0Lnuu3TOiQn4BRECNf0ACf1xUHFTUnnDq/d0TRQDM97vNMMzaQgsH/
	 J8kH/z2GA2TzQlLqFxrEjE7GX2LlcgHodevxM6Bs3JVyKqoM20mj45J2fv1X6eW23hbxO
	 SPBm8/hDO06XO2ojYN4NT09reHw0O3nBKJJdg10z/LOHLmM+9afNGOOALlpY8xjOTfZ1F
	 VqNu/Yfm2V6UloMA1g/ukoOknAa0gIXw8la4oUjXJo7WS5gn4corRoDGZqwX3+0pj0CHz
	 L7FrqPz3o3XdlrfzDqyKEKL2+6QpwpUPBBWpEAacNb51vofvUmjwYZvagRt4wEkwLiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124929;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=4Pm6nA/KY6PE4TLQmdMM8j973NLZ7jXiNqYHwm4lj4k=;
	b=4K8J/BLbB/kb/GkGTtblLFG+zyc0yA6d4RKcv8pf636I7ehtJ1VV0ck4fWDzkXqbbFYh
	 76tcsdhU6aTR/hPEd9Ch4Jjt9oJ+LD25fH2DiOm2yWPJjxosLzM2j+Votf16HpZVM4rNp
	 Ah/Y2y4weDKjNpd1a5i5sJ38zrOAGRBHIj2iSG2W3+g8x3lOWB7fEqD7YIdtmM1UHs6eO
	 Sp4zSIzM2S1BzfJPunnA9ddDn6H6ztCPgcOeASFGWfQtLetzih4mXCgviBarNVBKqoZkc
	 digvHnnvI5DO2SdxOX+135Zg9tFZtgsPZOv7X85HEZ3n7v/Cf4LtWpnR+QeeSu8s1yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cCaOyjmo;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69141606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69141606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cCaOyjmo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793124928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Pm6nA/KY6PE4TLQmdMM8j973NLZ7jXiNqYHwm4lj4k=;
	b=cCaOyjmoeXuq5/nPviT5BBp4Q4P/K+VWdBR2m52iOn1NPubdxzL+kH6vBRw799XeKP8TGh
	hCYVfHBXzrFApN39oTfVfqRa/GcrzSnHKY8oqviQENxywh3xgdVbPuxd2GF57umrBsK0QT
	PkZapb28EySI+MAJg7S6QyiCD8jrsZA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-IAhZ7yWWMa6sTZNfrhwzSA-1; Tue,
 27 Oct 2026 14:15:24 -0400
X-MC-Unique: IAhZ7yWWMa6sTZNfrhwzSA-1
X-Mimecast-MFC-AGG-ID: IAhZ7yWWMa6sTZNfrhwzSA_1793124921
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B70581954236;
	Tue, 27 Oct 2026 18:15:20 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6FD8418002B1;
	Tue, 27 Oct 2026 18:15:13 +0000 (UTC)
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
Subject: [PATCH 09/11] accel/kvm: mark kvm accelerator as secure
Date: Tue, 27 Oct 2026 18:13:58 +0000
Message-ID: <20261027181400.1752951-10-berrange@redhat.com>
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

KVM is servicing virtualization use cases which must provide security
and actively maintained.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 accel/kvm/kvm-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index db8fba53f33..66bc7f3a83a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4353,6 +4353,7 @@ static const TypeInfo kvm_accel_type = {
     .instance_finalize = kvm_accel_finalize,
     .class_init = kvm_accel_class_init,
     .instance_size = sizeof(KVMState),
+    .secure = true,
 };
 
 static void kvm_type_init(void)
-- 
2.56.0

