Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124892;
	b=tZiozVir2pfo7SQyVDdMTxYFM66VhR9sWJmlh5omDi1OI++TSwfAaTs9dC0hGncGQbwr
	 7Oc2pFDaQN+Ruze1FfZfMIPYjY5y3gU5F9KnyfFNd+actPW0zL70/HkrneVINfBYY3qNZ
	 fpnF3FTgTc4qCdqw2QJmfCAslTF5Cy8OsOrxIqc8Yf7zMCC0Pbheyl5xKCyajsci2ggAH
	 FZe8W0UpC9Th+bWU9AsnyhoE5oKUgz2h5AjY3+mzsDwimoB3MynUMlT4cOH/AJkRRs4Yi
	 J7DG3sQTMjXujOvj3Y3JUJRLbbum/72leE6X+ZbZBjEwgYbbjMxU1FNV4c89CX9FwGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124892;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=OR3eA/OEI8JQI9niPlwkL7rz2xDS90J8dFRNMLbMsFA=;
	b=YOO8F8SfjkojgKRGxD2dFMMDhIyOSy7Q0X+QLBsrnjkuv7cLXAsoJFryKNMyuudy1rIU
	 Rc9GOITizJ4K4hNTCt968dCMTLodNygZnFhVrLFmpsH7rzDqNYlrP4EPraZBugtbaUmU4
	 xgkMIdJPr1lNsBKr4BwiuLMY5lRfIf6pOJtkYEsKY3/3avkN69sqEt6IbxJmEEmSf0q6G
	 UjK8Ejx1b/30OMPZPQ2cqYx5HjYahLk29DgsQFxdIF/gw917L0KrPYI7Ng2jS3+fk56+7
	 WLClqgd1CMVxFexs97yzRXVdsYj/ec/jbd7lhd6Y/4YldcB/Frm+POc5ZwATswrgDdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cjMheI3y;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1934C606A31D
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1934C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cjMheI3y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793124891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OR3eA/OEI8JQI9niPlwkL7rz2xDS90J8dFRNMLbMsFA=;
	b=cjMheI3yeWba4m+k+DRnp2aMMYGxfEut/Hmh1VnHF0KlLUWyHcT/asidHqrmjtc5w84kUO
	Ue2M3RpEzQWeJ1nFEOOn08Yql4zs38TYUf7YDWhHPJxo8MhaYwGoXAZbyA5o3Uspk3XsTW
	zAUp+d4H+mwbEQHNJqpxZLtH2FtAP1A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-hFjnCr8qMIidUk_D93z-dw-1; Tue,
 27 Oct 2026 14:14:47 -0400
X-MC-Unique: hFjnCr8qMIidUk_D93z-dw-1
X-Mimecast-MFC-AGG-ID: hFjnCr8qMIidUk_D93z-dw_1793124882
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA8621955BC4;
	Tue, 27 Oct 2026 18:14:42 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 835921800586;
	Tue, 27 Oct 2026 18:14:35 +0000 (UTC)
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
Subject: [PATCH 04/11] hw/ppc: mark 'pseries' as a secure machine
Date: Tue, 27 Oct 2026 18:13:53 +0000
Message-ID: <20261027181400.1752951-5-berrange@redhat.com>
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

The 'pseries' ppc machine is already declared secure in
docs/system/security.rst, due too its intended usage in virtualization
scenarios.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6d994644865..7fe3202f635 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4750,6 +4750,7 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("pseries", __VA_ARGS__),       \
         .parent = TYPE_SPAPR_MACHINE,                                \
         .class_init = MACHINE_VER_SYM(class_init, spapr, __VA_ARGS__), \
+        .secure = true,                                              \
     };                                                               \
     static void MACHINE_VER_SYM(register, spapr, __VA_ARGS__)(void)  \
     {                                                                \
-- 
2.56.0

