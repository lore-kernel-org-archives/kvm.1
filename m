Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124870;
	b=CQ/IF6S/Kug0spmWzp3o48s68WQ5X02s1t/ChuWcj7h8LrRsjY0vqXCrsrAzaeu//cyp
	 S8E5bBYzPpJnpKMECDgKwwPRF3ba7tP565gt5jR8BqOeE9rtMGwObr9wqo3c99ts6qJcA
	 C3HeW2tQsB7Bbe3J+bpSuUibS6Gk1arIzoMlCOn2nQ9VetX20Qs0JtpdqKeVY5r6+I5Zn
	 d5WJJSeJ7zwKbtFloD+KmdJ/dzi5guxGHps/lq+0jHIqZr8wlLyktoddwFjrR1nhZfyfg
	 /9kP1kd1E/rTEy8PF6lVXjsbO5hj/S9FT985UMEl2e4gOgq75aXj9AiwCMegtHVrUNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124870;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=AjGVXU5aS/ksj0LQ/51NqYabIHtfhW7qM9VfFUaebJo=;
	b=A/MKGt8JhiH1APFvwbxq32YDWTqZpo/BJucH0GLsCVh+0nztdxWDH3X1VXwnPI6Ddqbj
	 x+819fRnAdPvmUWaZAGyG9wVNyyerkQaxwt2jJuxbkBPqd4hUvNEtdjZLu3MufsJklJxg
	 Hbc6tLyO2OhNU8C0ZKvwA1iHcVIUhGPVKKaGMBOKq+uOuJJWbBoQXwoA8m5ZTNJlHnRL9
	 Uwfvo6P6hhQg58VK/4K3Xkt3U+xcL3+vlGvO6Qj1ewC7UdPVtB+bD97BB0Tc+HQuN2jvK
	 AYeJxia4ABWfUMTyFJI8ONggfqGnPdiMl+JcwD4o+dp6F7rCxpSFldjcCo7bcNadUeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eirGs5Uh;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6F5606A31E
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF6F5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eirGs5Uh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793124868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AjGVXU5aS/ksj0LQ/51NqYabIHtfhW7qM9VfFUaebJo=;
	b=eirGs5UhTUM+gyhj+CW/AenbixCDMQxNV1jdXDS8tohDmerLKpaIogUEQxtPxSKq/f+Fyh
	3PnZvZMN8+cKpXnKRpePU1Hc31Q2j2USa3FERjlQDrScBtqcJV3qcCWMnXQy3P/ymy9rTJ
	FVTSGeEAlZZoKAzQlgQVZ8ZAbziKGYY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-P2CkRgR_M8Cknl4287nnmA-1; Tue,
 27 Oct 2026 14:14:23 -0400
X-MC-Unique: P2CkRgR_M8Cknl4287nnmA-1
X-Mimecast-MFC-AGG-ID: P2CkRgR_M8Cknl4287nnmA_1793124860
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7115D195411E;
	Tue, 27 Oct 2026 18:14:19 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D5A0B18005B0;
	Tue, 27 Oct 2026 18:14:10 +0000 (UTC)
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
Subject: [PATCH 01/11] hw/arm: mark 'virt' as a secure machine
Date: Tue, 27 Oct 2026 18:13:50 +0000
Message-ID: <20261027181400.1752951-2-berrange@redhat.com>
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

The 'virt' arm machine is already declared secure in
docs/system/security.rst, due too its intended usage in virtualization
scenarios.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0d56197dace..43b9212edc2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -133,6 +133,7 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
         .is_available = target_base_arm, \
+        .secure = true, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
-- 
2.56.0

