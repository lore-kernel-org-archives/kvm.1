Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173104;
	b=TZf+VroZmJAKgFMicDlJswhJClIlf+lj3J0gbj/A/dQDkgCaX4l47mM1DUjMNXtQFt+3
	 p+OfMkMSqIr7jJuFbXUNkHK3P144aab2IZU5rDSIIMWZH8I0iIjAqt7uJz8mg8QE411l3
	 3xTS6aV0T4pfM1dLwz/jSQkxVPnzJXeKlHAYa/8hhATt6/zuCNWkuCVn4IcpFvinR+WNn
	 Kxu/Oa4d88pqRCXQ5xSUtSePRtITQg6BLh34xjVmoTGDJOyEGLwe9HWLHR+iF2Qqmqkdb
	 D5kU33Cea0J35RB1niaiWxROMsMf6r3gHNG5o8y9TevZNHtzJya0Dz6wVV3uMwc//TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=LvlKqVyRHhYvlUCPB8iGyJoia7M8Y3oMPiJsyGR4j1s=;
	b=2LkMADtU0E/pp0UCHBkKx1NFdm1Cl5ji81TAi3xM0+BkRbAo5n2gaumyT2zpQFKmR5EN
	 Fr6e4BLK4+Z8DK9KiZhfVEKJPAHvyWQKPfTvQ0rDRgfNzUmBEFH1IO1E5Qv2tGvRtQmT4
	 kxnZLuOc0yUGV5gjdvV1zViRe/q159BUPb4/QFFMlqx7HxCaSSxE7h0iNmWes52Yf9iM2
	 dA0aTGaQcjjKxnGiPD5efEWxOOpVPObr0TWmulVI7dxajuORgvT2E6Ljd6sNcXOj4koXu
	 OboE3GpT/6R3d2chqBY4hC5xrbtl/KxHZSKAWVQwvZPVAI5Z1uFcO9mcO6MpyJedcSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aDWBOkEZ;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161960A5BDA
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 11:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8161960A5BDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aDWBOkEZ
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so3954615e9.1
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 03:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795173101; x=1795777901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LvlKqVyRHhYvlUCPB8iGyJoia7M8Y3oMPiJsyGR4j1s=;
        b=aDWBOkEZ4qQRUHVhnFnZXjz6gFJEBlNyEyOoHl3cV5UW6Rq7wSX+1fES1TXbs+3IN+
         IAKYtLt20bq7t70W79xhmgxqItOqQijVxo5iyutKZ8jQe1SJ0c8ax6LFcFKQD4/pFVW4
         Scvf+gg55pm8RdsI6l503C/MgY7Jt/K0LEifX++rJZPpsAb41pguop94McXiGc1R57jR
         FWm0KPgHb8+GbMuAMQaM6CEjHnVaWvkGjKpL0Zwmz+m1lkmBwIH1hVaHU8FL9W489041
         MhdVrJqCpXT0gVwTihwed9HE5FTyyCmxQAMbMtU/vnweUAG4HMgIO82NKmvfP5w5TadQ
         9Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173101; x=1795777901;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvlKqVyRHhYvlUCPB8iGyJoia7M8Y3oMPiJsyGR4j1s=;
        b=sAF0oUxxrOS2SAGy8/EwQt1jpu9MB3ioYCkqbZYNb+4E7+B9ul5xNrz3ZXS7qLBl5H
         2fBK1kn7lShgOMd5IpNjBYuBM72d0ZWGsf7/CaAg18h+oWznoQsUlNw9Nrp6wRMv8rKP
         NyaKqYAapgOkzCSitdHjSgyY5QPQJCAwWqkCluWTKHI6PMTsKXYps3dUd9N0pmnUqKsg
         upS5aY7BMUPy0+KYeDlzN0UKRIRTzWly3/LYP/rpFmIZZI4qMxIrUczt7ipgsLXWlOXj
         3ObNWtRzaTtesxqf/NpBqc8ZGpdgcqrrejEOk1KAWojHjQop9ksm12r9tH9LPIZZHRsj
         fQpA==
X-Forwarded-Encrypted: i=1; AL+hErG3fAsfGEKTI3UT5+Bf4GBlfiwZ63CXRTHaWk8DBXGQc6DUzz+Yu/avTv/CdeGb1N1jYl8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sUOuctKXRPuIweXBqSGLNurzvBfvX7GizRITesujuXeQ7r/j6
	Rkdgb+lPx1TEgBeqmxpvr6p5ReOo/SGoWzQH46uKJ2O8dWPjeGe91be2WueJZMZokAU=
X-Gm-Gg: AYBFou2Yn40IFe9bmyL9XMefZmKwmmQE1LmOzB1I8wwatf55bZzwZT7td2txsbATxEa
	xK90SUKY7o8lK/2CDdriRE6ekw6r43ZyXIteUgR7gBKLmAqmc8yn0x+RBVV83F5gNQW82v3cLFe
	SmeilFM/wtqjmrh3faI6kH+m/pEir3ncUcGNXyn1rxWZQ68/7meaoTL8wefFzXnffBhn3pazHs7
	dHFxiYCt3c1NjT36RFt7bWF7A4G8p7ylfsFFF3Uqqbn30OGKMNw2WHBIQpOk9ubEODRkinqULJc
	0ZjxSX4jJM12qeUe88oG2kW7TRbMp1NfTAL1UHqAPwl5w2cssrZ3jiIqLuFzbiEmiMhTC+JrN/k
	XG7iIOBuLbzXeeud4NWMNI55gf/dfF9wBpzS/2sjmxwZcZPUhaPhm+02xvxr1Shqb42utKyQYRx
	n6pTPxYviuaO/7SiZcM80kwffe943iz006Q4wEBsl+ukn4j2c++efuVlKb/ydYMBxYqe97mcYdF
	TkjADYKpdjBRyypJYmICOCLWHvirvYAR+ilWgvGofK6y1RX0gOv9kOE/ZDySuuAoDMxd2kU4Q/4
	tn7sGvUo/m2lvTX+lICeoUg69CgtGIYNi26BDZoJmGeiRGOufa0/RSca61ON/1+fU7sLWesI+v5
	XjMDFe7Q5TiAuS3dm
X-Received: by 2002:a05:600c:3b98:b0:4bb:7033:c92f with SMTP id 5b1f17b1804b1-4bb88826810mr53126695e9.11.1795173100811;
        Fri, 20 Nov 2026 03:11:40 -0800 (PST)
Received: from localhost (p200300f65f19a904be03815e1634e776.dip0.t-ipconnect.de. [2003:f6:5f19:a904:be03:815e:1634:e776])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb88f148aasm25552865e9.0.2026.11.20.03.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:11:40 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v2 05/10] uio: Allow untainted use of driver_override
Date: Fri, 20 Nov 2026 12:11:06 +0100
Message-ID:  <190f97fdc22c161c4721283a2beb20bb477f9e56.1795171088.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2138; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=iCUi/7tI/zgEkK4zQSmtLg1qQ9fsMtrvvDC7LGhhuns=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrACrTI/ZTGZ5YUYLg+hewc2YLCRqh9DJjAObYH uU0wg5v0smJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawAq0wAKCRCPgPtYfRL+ TikhB/91CrSUe0WLbAkxv/SKrwgCyHDlQP/ZyGjOoKNTEMIEV/ql4vVu9pMRDw6sHcxLfLYl9/H rIhWYQ2bf49lE1MoG/fCG8BD04CU82cvNj1qID0PlF/Y4W+6ls38K4tyflWGBfZZCxxirnW1QIx zDiWB3NW2veRL+r6Zka116LLr88v2PKOy+HsvWogO22SrxIOs5BSmfVn8KULg/MKVGAhYDycSw8 AS06RrlsL86KNGd9D7fKdhyZUZZO0KGGt0MVBMMh2ER7V0705/JMbK1cCtVwsDJy2s45E3HrNS2 69fihF7+EhGPXckf0p8NlRnPsHwNsOhRYJu6IMPJTGIT5tYw
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

uio drivers support being matched to devices using the driver_override
mechanism. Add .support_driver_override = true to continue having
this mechanism work for them without tainting the kernel.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/uio/uio_dmem_genirq.c | 1 +
 drivers/uio/uio_hv_generic.c  | 1 +
 drivers/uio/uio_pci_generic.c | 1 +
 drivers/uio/uio_pdrv_genirq.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 263c1ebc2d57..71992431770e 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -309,6 +309,7 @@ static struct platform_driver uio_dmem_genirq = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = of_match_ptr(uio_of_genirq_match),
+		.support_driver_override = true,
 	},
 };
 
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index dff92dcbb10d..255c2b5730f6 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -407,6 +407,7 @@ static struct hv_driver hv_uio_drv = {
 	.id_table = hv_uio_id_table,
 	.probe = hv_uio_probe,
 	.remove = hv_uio_remove,
+	.driver.support_driver_override = true,
 };
 
 static int __init
diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
index c0cab3adb7b0..9785df9fc5de 100644
--- a/drivers/uio/uio_pci_generic.c
+++ b/drivers/uio/uio_pci_generic.c
@@ -140,6 +140,7 @@ static struct pci_driver uio_pci_driver = {
 	.name = "uio_pci_generic",
 	.id_table = NULL, /* only dynamic id's */
 	.probe = probe,
+	.driver.support_driver_override = true,
 };
 
 module_pci_driver(uio_pci_driver);
diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
index 87e43821ab0c..022178248962 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -261,6 +261,7 @@ static struct platform_driver uio_pdrv_genirq = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = of_match_ptr(uio_of_genirq_match),
+		.support_driver_override = true,
 	},
 };
 
-- 
2.56.0.rc1

