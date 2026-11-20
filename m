Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173101;
	b=GRp2wAN1xgvKNhif28tXmxLWZGRVFGYMFECGPNeQxXbM0yYwFEpwIq6wuF8HTpV6WvUk
	 m5gh4dwcFvpv3W/U8f+JjRSye2mnMvymSO5lDgZm+P0l0ECZRsmqoMaFBusVjtvN3AGCi
	 4bs6oNfu8hBSoFMhyjFttgA1Zwpsbg2uCTY8bpkK+EvjNpjVBZYMVbQLDI+UM9eoA1Xci
	 kMIeHOl/1IsuCGc9yxr4wTTjjjTaAt1vUqI4gXJqAn4zM89xHTJuiqvczMkKhlrYsYQlA
	 bEhoWSvG8HjRNdPuW/9prYIyL6QHGke7SPzP7kcnfek+FObdZJhpW19s0NKRX3fF1/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=cJsM+MQDScvHYXZpHmUi9y/qw9WP8MQjdcWo+D8X4wU=;
	b=CM5Sv71C45LeT+FYTEOsYECREG7rO6BX+Zlc41Sz9e/iF1HAgKhRu4MAR80CRys9sNbx
	 u7DHE/zYxPWOoKt8Zz4OyI8/6kE9bhrUInogaQ502DRcRSDxFMD9uHtm+Alxct/uMQP23
	 WYMsG6V2IDi7VN0ODT87p1fEXi8YQhUr5UhLuOizkfSbdOZzQ8VewIUZA6yaI8gaIa7mV
	 35WSahmDQU+dsUTDDASGt+V5XZsazNz5h5dJ2p4692ocIbxqqff6YePEgUIGRMAHed6Cw
	 bhdg3+52EhirJMI679L4rZ55biiMHYFKlPaj9ib0uQ9biqXLS6h6008rpIdSp/wo9NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CnCAGgbb;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0784D60A5BC8
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 11:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0784D60A5BC8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CnCAGgbb
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso5803975e9.0
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 03:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795173099; x=1795777899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cJsM+MQDScvHYXZpHmUi9y/qw9WP8MQjdcWo+D8X4wU=;
        b=CnCAGgbbEqFA9jzaANJ+NwiS72MZwGiwPVI4mGe4oZS+cFWLanYLm5knHTkil4TNaX
         dpstToWTnnhWXhEy94X+q90MyF04FWEvSWyZWsK4C+Pk5W0+kG3//tIAxH7gS6v/XlNm
         DxvIL3LPq+fD02ayh2h+6FXDDFttLt8NtUX/T3wHysmyfXrxh7eiNv+J8pfWiGI/c1Qz
         TehOsuEtSNgvf+rzhq67zS5UQqc3D3HtOSlufRXLYvhv6/VTsgH7aQmyWOq6Pd92/gVL
         sLpC/6lGIPGLpy9Z1i7WI/LnujNOtMr3cHvsfKRNMgjsUVHYqhT4HRJpvD6w5UW+IaX5
         1hCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173099; x=1795777899;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cJsM+MQDScvHYXZpHmUi9y/qw9WP8MQjdcWo+D8X4wU=;
        b=Tc/dqST6W37sX6nSqFVE3L3diGVKVzurK0dYD76ek/dX/pb84ht+mtXYsSWqzBsdI9
         usDrWlmDdPe31I1DhXgvGP4zgYAZQBeBmSAEJ3WfHmhjvLAfCzESp6E1fOHhlz6JhYIX
         CIfuqt2VeMBuh8UZ/K0/OUAKa8UZ6dn8xUZF6e8oj/VlU76MchNRwsvGcmce1TOG+veb
         dFWW68C8F6nLkWMj+YkWaBXyrFlIWoS7GrcmuRm+UHI05zGswS+GLARjJfo3C4c6CZHI
         Tzo/TRuThn9a4POLW2ULg0NsvQm2ZbQrch0ePb31pWVIDM1cqB9nE7R1ljmMB+eC2Yt9
         vwiQ==
X-Forwarded-Encrypted: i=1; AL+hErGG+lFvylRIYgWBv3hixJ+8x8ClFNIZEdL02NjD7HJYClLidKmdZhm/B5HZiSRyls16Jng=@vger.kernel.org
X-Gm-Message-State: APuU4Z8P+ynA8gzhJlFCTfb/4laINETQL6vhCI9RabUPfvr3qFon0XiH
	suiMgU92UmrcSJcxFJrXpe/XXWAyVFHvMpuOdqb6fEgJ28gSdzcTWjI1SAAV3Uimf4Y=
X-Gm-Gg: AYBFou09IQBm/MUxk32btoQ4/M7IRg8ZTjQaIqOawTnDv5dCBjcTvefIrO5fqHwO+sV
	DuMQ+vFYJ2god4S1GshInbwUyEnm2TalNHiIyTLrLkR39lf4MD0tws7jCjSVGHZ5YNZC+7FXGCh
	KaoMRE2br5rkspqJpZ8qY4HlJBTm1+gZ2pzPJZSnRZqCQWb84PKnsgivm0WtE1+5CV6fvkMARXd
	OZQmWJJqN7ZHfJTldapmMhs6jlrXk1TJ7R9KwbjUllYLRSqkRbh3goJLJWMFBR9CCLwF7e2jinh
	7hRggi80fc43nCrWWuTaK5F5eMQHzIlM/XwtU6xWwmnlxKQAa5WoUOWYIUjAA8xLvUbWxf9JHeJ
	UTPOj3Au9ZJ4ef77+p22bWZ/demy30KFXIOBJaS6lg6Q+aQjJ0IDsY5VMCqoQhnrfBIMQZNEYk+
	6VB64hHPLsBYW1Pct8ddpkolMrEwk5nP5GSv5ac7fC18t50hk0fcqP0FpD33t7PDKfCfom2UZif
	8yJcxmS3wdJ3vMqLstVTt5QYRME8B44sjqufd1P2qHsn8gSypzG+58v1kHk9ftcMTJhtk3gEUe6
	CUCUZRy73KcGDFEZ1OPEiVhuC9cgJQoA8ZWKoSreiOtRF2FDU335VvlfiH0Jd1VvWQBb2dfNewL
	cex3KwB4MbWFcPx6Z
X-Received: by 2002:a05:600d:6510:10b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4bb8881de57mr39648455e9.26.1795173099366;
        Fri, 20 Nov 2026 03:11:39 -0800 (PST)
Received: from localhost (p200300f65f19a904be03815e1634e776.dip0.t-ipconnect.de. [2003:f6:5f19:a904:be03:815e:1634:e776])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb884ab091sm110162205e9.11.2026.11.20.03.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:11:38 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v2 04/10] s390/vfio: Allow untainted use of driver_override
Date: Fri, 20 Nov 2026 12:11:05 +0100
Message-ID:  <a53e12ad841fb18e45b3cf7a4580846943ed0c6d.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=KVkwXeeDf67yBEMp7oUHRQtChMTeOlX43NbtH/KeOAk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhmwGrYvrt8oZ1tuWmU/b73WXTdFsZ91iafF4ge1RU/U3p lTP2cTdyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBE3lix/3f5F7BD8V6NmNW2 s7duzvu1LMMlVuvUhJLk6JyuRJVHZwq+hQQ8WXU5/9fbHBZTlqNJOlnnPmrm5LU8WSFXWFvMGtl RsvOfSmCOZwmHzrETZ89d0azbv2nm8eTWNp2wdQHJaYrl6tde/v30/AKf64SLLpbcS36dvdvune SssVDTwsn3jp9EDFczz2y+tJgZaW8mdMo3WC9b8rnlS1Ja0lq3fZVRlok7+kpS8ve1pOgsdMtJt 9LQ5fD516reuXu/U3GMTvvRlDLWRknP6WnP8o88z5Rzd7/9zU9C+1a9gdmfZXYMdVmW8uu9WPK3 c/H55U2+83Cj6qWg5xmvkoQkP1QukF47Q8Nnktm8nd8A
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Alex Williamson <alex@shazbot.org>

The vfio_ap and vfio_ccw drivers bind devices through driver_override.
With the introduction of the support_driver_override flag in the core
driver struct, it's now required for drivers to declare themselves as
driver_override compatible, otherwise driver_override bindings will be
denied or generate a kernel taint.

Set the support_driver_override flag on the vfio_ap and vfio_ccw driver
structs.

Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/s390/cio/vfio_ccw_drv.c   | 1 +
 drivers/s390/crypto/vfio_ap_drv.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 7546bd137e4e..77765cde87f7 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -375,6 +375,7 @@ static struct css_driver vfio_ccw_sch_driver = {
 	.drv = {
 		.name = "vfio_ccw",
 		.owner = THIS_MODULE,
+		.support_driver_override = true,
 	},
 	.subchannel_type = vfio_ccw_sch_ids,
 	.irq = vfio_ccw_sch_irq,
diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 8e69ed286bb9..2d47dc643269 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -62,6 +62,7 @@ static struct ap_driver vfio_ap_drv = {
 	.on_config_changed = vfio_ap_on_cfg_changed,
 	.on_scan_complete = vfio_ap_on_scan_complete,
 	.ids = ap_queue_ids,
+	.driver.support_driver_override = true,
 };
 
 static void vfio_ap_matrix_dev_release(struct device *dev)
-- 
2.56.0.rc1

