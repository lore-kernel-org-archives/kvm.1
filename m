Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124930;
	b=NQv0bk0ZhI0SG3z1zMUP2JIY8imi/2MkVDsf64stnXMgMwj3i74MZqPWJC8zIcSXDdAa
	 QxqKkF5abeippLgdouLqej48eHDINr3Xvx3lXPrZHKxaFHS+pR8vQrRmgoyeWqQEPlsdS
	 EjCVcKUw8RvjwfNa7/WMyPA40CmrLn3NaukXijBGa8W8y+2n82lisW6a3u7WPMqbhVcTF
	 lXbdkxXV/MipiquYYgGXUti0es2Dge4gWtR5UXTSNXfSBZ5VOVyq/g7LNOKdiGiyZ5JMd
	 9bqe848GsUUsEwGl2q67hQRDH0TXwnrvExNfDHvt0+vbmb9YsNLS7egNbYu7UjZ0rww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124930;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=LUwBxGM3xjpChBFYaFDJkfG6EUPdlIElSL7fPYhzNRY=;
	b=c9hy3pbcGf+KRaFa4GtkBDe+7icJf6YIDqlMeVYBupyKFFnFkNcQtb2YM6gJEOXJrpyS
	 U/PEh2hluZF/evfqq0XzJZxks75Nw0s6RIxQ8f6tBVj7qnJaoIlJkrEQtUR3FRVfhoMeD
	 ktV8uLRbl7vUv7TsgKPHlbX5+fWBguywm7jmnoIWuLBFpeQXdQQSTir8XZmiMTHyAytcc
	 PE1GTKOvhovNr4oHPC+FaXkG3APtIjYPsh55zG0qKrlzIrXS/9QUTWh0kDwxfetylbMHt
	 nMs+HITxQHFsDt5pw3C8SVQzJuk4k7nKCRh0aVQSq9ROeirawi9jrDNuDc+AExtYzuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WhnXh1YT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E90606A31D
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5E90606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WhnXh1YT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793124928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUwBxGM3xjpChBFYaFDJkfG6EUPdlIElSL7fPYhzNRY=;
	b=WhnXh1YTJPj0WmoiiQDfXmyjxDXkIdy19kt/FrPTvggBjcu7dEZzrb02o+oQa5n11Xos/X
	MzLdLF9yyIx19Ejdln9/K/Bjd2/IXbNIDT4mHfSzU/wZ1AJkex3WSaMWv/hR1NliehPOru
	C1XKIkaXYHjkYOXd7WiTNMkooyuguG8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-zdO1gxORNhKJ7rxNn7TBjQ-1; Tue,
 27 Oct 2026 14:15:18 -0400
X-MC-Unique: zdO1gxORNhKJ7rxNn7TBjQ-1
X-Mimecast-MFC-AGG-ID: zdO1gxORNhKJ7rxNn7TBjQ_1793124913
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E99B1955F00;
	Tue, 27 Oct 2026 18:15:13 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0B1218002B1;
	Tue, 27 Oct 2026 18:15:05 +0000 (UTC)
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
Subject: [PATCH 08/11] hw/nitro: mark 'nitro' machine as secure
Date: Tue, 27 Oct 2026 18:13:57 +0000
Message-ID: <20261027181400.1752951-9-berrange@redhat.com>
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

Unlike the 'nitro-enclave' machine which provides emulation, the
'nitro' machine is used with a real AWS deployment and thus is
considered to be secure.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/nitro/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
index 88d01960a01..2e88e150c93 100644
--- a/hw/nitro/machine.c
+++ b/hw/nitro/machine.c
@@ -261,6 +261,7 @@ static const TypeInfo nitro_machine_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(NitroMachineState),
     .class_init = nitro_machine_class_init,
+    .secure = true,
 };
 
 static void nitro_machine_register(void)
-- 
2.56.0

