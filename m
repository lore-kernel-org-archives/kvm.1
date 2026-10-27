Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124900;
	b=ExRpepGDxr44K/WPA7xGr4et5Jd9S6BCDgLOKHbTLOWU+TxazTzyZUOiygKCvnU3DINm
	 SpITJRX3TdT7k2QNDHsZpKhluKnnIB7JgrDpDz82fuSfSettXNW1AZRC/zfYrnVPFCc71
	 x+kI6cQNN4fzCu+SJGGQqXs+rLaxKY3bi9bxpPVokxe9Iow+d1P0lUsy7I33rfxzp5ZLM
	 bY+S6zgNy1ptp+npvEx4IYfX20gH98YYP6ilPYT4ZWszcSxOCeaFuuG3z4a+bhQObMKet
	 LokuryWR8n2aEc9joCiR535iJqmDEEQbIY4lfgenzhLMrP4ECpUOQWFbWRickNL2DIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124900;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=ffR5lWwVfMJeNQwVyhdMmRrcn+pHfvHRaFQfo9M/AZg=;
	b=a3DrNIsjJEP5qk9L+kEGuUQMwz9ob5Gb6VYOP3Sx9djl7OsrTI8S9jMUdjqaWm0K7lfS
	 Ba2SUdlfuoWKn3JJH9QrQHN+djQhu5Qf7/zU7OQezcJUcftgMuHDRe9mq8+Glt1HL5UBE
	 RtPh0YfUvXbNZ+mmZ5BtLUUfgPOv0j2xg6lhxxNYrGB3CJTe6VjZGdhzWonJJ4M9Q3yxh
	 CAZwNF+tA2TvEFkYwVs+gFg6eydO4/GGl7gRiT+mXp4Ok5x31KEdksbZZbv0XXgGtGe2Y
	 GZRf19T/q4pI/3nXab1bCG42kGICIdmt2g2Jyr2BVoWb1/IJbhdMSI6fTqmgGrFdo7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P73QSLpT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B2606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 463B2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P73QSLpT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793124899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffR5lWwVfMJeNQwVyhdMmRrcn+pHfvHRaFQfo9M/AZg=;
	b=P73QSLpTDRPjgzGQo3Gi6mlvXLuMM4FETjSKCOX2FuDgYAIAXud+39bOeTQ36c8AEl+2bI
	XUXjLwjayvDswDwiJRAacv2e5rOilSDcROovgkWqzwehDMcfj9hd3iNU3cadmxRHX/iXK/
	/IMIsNN3vaKFBsLdwPU3w2ttVVhWN7s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-Q22TEt-IN-y5e0rsPUvSgQ-1; Tue,
 27 Oct 2026 14:14:54 -0400
X-MC-Unique: Q22TEt-IN-y5e0rsPUvSgQ-1
X-Mimecast-MFC-AGG-ID: Q22TEt-IN-y5e0rsPUvSgQ_1793124891
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCFFD1955E87;
	Tue, 27 Oct 2026 18:14:50 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14FD91800586;
	Tue, 27 Oct 2026 18:14:42 +0000 (UTC)
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
Subject: [PATCH 05/11] hw/riscv: mark 'virt' as a secure machine
Date: Tue, 27 Oct 2026 18:13:54 +0000
Message-ID: <20261027181400.1752951-6-berrange@redhat.com>
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

The 'virt' riscv machine is already declared secure in
docs/system/security.rst, due too its intended usage in virtualization
scenarios.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/riscv/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f6..489ebae4105 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1200,6 +1200,7 @@ static const TypeInfo virt_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("virt"),
     .parent     = TYPE_MACHINE,
     .class_init = virt_machine_class_init,
+    .secure     = true,
     .instance_init = virt_machine_instance_init,
     .instance_finalize = virt_machine_instance_finalize,
     .instance_size = sizeof(RISCVVirtState),
-- 
2.56.0

