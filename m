Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334220;
	b=FhUTsyokj70dXW5Gf7jjJN5Z2p+khNYuAqdukKjx54o9IkYOf0CbGtsyPlbSINcMF6VR
	 E+CDUPrJeZFuYCocpChiyrwH/aWj64dmr+/Jd2EmgjHYWZp4ERq4T9h5ttkkDovUGig7i
	 OL3Y4wHimX5NIcEFh4+BR4Ir2jd7xQLj/mrbnRH1E4E5PPANxFw2Yn/mFMpJonUDtowmq
	 d0IEdAkeO20IlecC5O/f8DfKHRVeEGM4BiyYtCO5LM/VdM/aBshgIyKLqlR8bmfQjCnWP
	 /d43XIDzZ7u5Yzabas92MDGKaVcEZ/rCAiegLrJu6TvDBV1jzyKp0vyAN3pvuInjhQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=S6qrCm3VJbLk2H2beVEtsK8a9baQ0SAzBEfNGb4zgPg=;
	b=ajgF74SskJXJ/2wn5lTFjkrntzVJWzQF3Ib+29SZjs/EckiQV5T2JQCctKzGRQ4xpzqN
	 KXhDflKQ2zoBKvzXpRjVxWrhi5cmAMPXb1YJsy5waSYkwyh0SM5aZUx+bdK1Kzvf7DOlz
	 oEV2tqFm6CIH6u6X3d3FgQltpkhSjJ0SvzvN3Mi4c9iXQL36kpIVK5RvhQz+mrA906zta
	 nSva4/pvl9l40N+gtBk2GsUg/8U0dGauBl7fG8xbjRlx0j41GG2/QMhr0csZWmvXVThBG
	 n4tgi5cuWFukR67q14abUX4nrN2If7JeUwJMdKtkI+JTWZuqrcv50i5aYgAstkzeC0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Qp186+H6;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CBC606A335
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 04:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46CBC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Qp186+H6
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-833e671ee9fso426798a34.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 21:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334219; x=1793939019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S6qrCm3VJbLk2H2beVEtsK8a9baQ0SAzBEfNGb4zgPg=;
        b=Qp186+H6nDG5dCHQ8CdatqiicdYdxzaOBmc1LQWJBRsEPtK1ukFV7bQmGhHYAS1ycJ
         vBLzVJW9poHdLm71gzPv0JWD6g/TL5VvTx1RDFza6oZD/BktGHeR3tSHcW/7+nPS6ckB
         QrzVdOgTVsZgtzTYDVDE925yffkK/YUl6WG+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334219; x=1793939019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S6qrCm3VJbLk2H2beVEtsK8a9baQ0SAzBEfNGb4zgPg=;
        b=XxB7QPzV/FI0bohyeS60IPnFLyNaHdtRLiWRe7+AtniwwDEKOM+axW4osvRXcE3rDT
         eWKiwFp4oAK2uSS967Qvk+m1DWWfHcII1f7MU09peK/A3hSiaAbvByyyeiAoigRJaviv
         /47RSRcVz0WP5kaW7PrumSQz9ytTA/Vddy+fKV5W7mN/cUR1VJJk5a7WP+4Yt+zzmi3d
         6Mwcp+lcr1GTXOAuhceRjPD+2IgKFn6YWejnh7aV6Lx3r6LX6N/QBzCJEFLH+icaQef5
         DJhzws3wp2So9eV5H56xNtsfyYiPiY6BfZpLkIYA8ErECuPfSpTu+QG/z7eMQz0FKQMN
         ghGg==
X-Gm-Message-State: AFq9FYL0Z8J0qZtqphQZ0+4djnevtw2Cr+ArIoiW1k3cxolJhdNCcO0S
	2pkTXSgUyYVWI7t8TAAtm+ZzHeGahumM0H7MBd4lGDy5u5C/eLU2UVUqNiEs3vW/4c/fk6XoEkv
	GChAoHpg=
X-Gm-Gg: AYBFou3j/xnYkBt/JeEITbNxkfdxxyQBNSYF85hQIUsEKI9IOfDkyJCzoO3lN3/jU9K
	bE3oqA4d9ds1nG0b0tptwQbHO6vvS3idiHf/YxImZgUepDVKImTR4SQZvMtySFU+iO0xHb00pj1
	xeo5aphL8TYTk9zGVRG1A21CLemjrYuXMtH8FMKi6bqTXQrPnyw3v4K/kP4xjvNO292IST1zeGj
	QhaLL98b3Km7iGuths3x5zpYbsauIZ2BKQL/JfByVvXIkUnqZ0V7neX8WQ7sMSB0vdLsjMIR3C8
	uUCXm6oYiNEG3tkOIIj0U3vUrxmEyYKO2boJnorG6PhxMbpKKHeSftnv/FYRpCRXx2+uPRo5mv+
	71izlzt1QQS7pNG7DiMxnjqmiEAFNsRq+iRblxLeHzIT1bj6AX1UxbL5rIZnpZ+9a+drtKVXvf8
	tHkIBi4WW4AnT0cLf8Yc6fuVS8PFuLkbIEc2lipxvT8IBA23spgCwYC8aewfonPWYexXDWgogV+
	hC8Hq3QO7uJyfL3hQmRWfLf+PB/XMchTOSz4A0E8nGJ3z9INuQ+ih0lDOqjf/0LABL9LMcbQXO5
	tWkmHjcW7DXse3bSnrf3PA87naJKsR01DpXWPrKjF2r92TGvX5axxKFGndLvdVFKEioTGOYVufA
	HIj1RkV4GLNxXxFSmo/ScQ3iBKrv5SIk=
X-Received: by 2002:a05:6830:4490:b0:81c:37e2:2012 with SMTP id 46e09a7af769-85d3652e9e4mr823151a34.15.1793334219235;
        Thu, 29 Oct 2026 21:23:39 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d351e77c8sm1162541a34.2.2026.10.29.21.23.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:23:38 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: kvm@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] vfio: Publish the container after all fallible initialization
Date: Thu, 29 Oct 2026 21:23:37 -0700
Message-ID: <20261030042337.74512-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

vfio_group_init() publishes /dev/vfio/vfio before vfio_init() has
finished. The optional no-IOMMU backend is also registered after the
misc device. A concurrent open can therefore obtain a container while
the module is still COMING, even if a later initialization step fails.

The failed-module-init path frees the module without waiting for these
open files. misc_deregister() prevents new opens, but does not revoke
existing files, leaving their vfio_fops and callbacks in freed module
memory. An unprivileged first-autoload race can trigger this by exhausting
the global task limit before the IRQFD workqueue creates its rescuer.
A subsequent VFIO_GET_API_VERSION ioctl reports:

  BUG: KASAN: vmalloc-out-of-bounds in __se_sys_ioctl+0xaf/0x120
  Read of size 8 at addr ffffffffc089df70 by task vfio_race/1484

Move container initialization out of vfio_group_init() and make it the
last fallible step in vfio_init(). Register the no-IOMMU backend before
the misc device, and unwind both resources in reverse order. Once an
open can reach vfio_fops, module initialization can no longer fail.

Fixes: cba3345cc494 ("vfio: VFIO core")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 drivers/vfio/container.c | 22 +++++++++++++---------
 drivers/vfio/group.c     |  9 +--------
 drivers/vfio/vfio_main.c |  8 ++++++++
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/container.c b/drivers/vfio/container.c
index 003281dbf8bc..bd245e23a55d 100644
--- a/drivers/vfio/container.c
+++ b/drivers/vfio/container.c
@@ -577,29 +577,33 @@ int __init vfio_container_init(void)
 	mutex_init(&vfio.iommu_drivers_lock);
 	INIT_LIST_HEAD(&vfio.iommu_drivers_list);
 
+	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU)) {
+		ret = vfio_register_iommu_driver(&vfio_noiommu_ops);
+		if (ret)
+			goto err_mutex;
+	}
+
 	ret = misc_register(&vfio_dev);
 	if (ret) {
 		pr_err("vfio: misc device register failed\n");
-		return ret;
+		goto err_noiommu;
 	}
 
-	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU)) {
-		ret = vfio_register_iommu_driver(&vfio_noiommu_ops);
-		if (ret)
-			goto err_misc;
-	}
 	return 0;
 
-err_misc:
-	misc_deregister(&vfio_dev);
+err_noiommu:
+	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU))
+		vfio_unregister_iommu_driver(&vfio_noiommu_ops);
+err_mutex:
+	mutex_destroy(&vfio.iommu_drivers_lock);
 	return ret;
 }
 
 void vfio_container_cleanup(void)
 {
+	misc_deregister(&vfio_dev);
 	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU))
 		vfio_unregister_iommu_driver(&vfio_noiommu_ops);
-	misc_deregister(&vfio_dev);
 	mutex_destroy(&vfio.iommu_drivers_lock);
 }
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 185f359f75d3..a7089eff3039 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -907,14 +907,10 @@ int __init vfio_group_init(void)
 	mutex_init(&vfio.group_lock);
 	INIT_LIST_HEAD(&vfio.group_list);
 
-	ret = vfio_container_init();
-	if (ret)
-		return ret;
-
 	/* /dev/vfio/$GROUP */
 	ret = class_register(&vfio_class);
 	if (ret)
-		goto err_group_class;
+		return ret;
 
 	ret = alloc_chrdev_region(&vfio.group_devt, 0, MINORMASK + 1, "vfio");
 	if (ret)
@@ -923,8 +919,6 @@ int __init vfio_group_init(void)
 
 err_alloc_chrdev:
 	class_unregister(&vfio_class);
-err_group_class:
-	vfio_container_cleanup();
 	return ret;
 }
 
@@ -934,5 +928,4 @@ void vfio_group_cleanup(void)
 	ida_destroy(&vfio.group_ida);
 	unregister_chrdev_region(vfio.group_devt, MINORMASK + 1);
 	class_unregister(&vfio_class);
-	vfio_container_cleanup();
 }
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 4e5d738ccf4b..8f780049b7c4 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1824,10 +1824,17 @@ static int __init vfio_init(void)
 	if (ret)
 		goto err_alloc_dev_chrdev;
 
+	/* Publish /dev/vfio/vfio only after all other fallible setup. */
+	ret = vfio_container_init();
+	if (ret)
+		goto err_container;
+
 	vfio_debugfs_create_root();
 	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	return 0;
 
+err_container:
+	vfio_cdev_cleanup();
 err_alloc_dev_chrdev:
 	class_unregister(&vfio_device_class);
 err_dev_class:
@@ -1840,6 +1847,7 @@ static int __init vfio_init(void)
 static void __exit vfio_cleanup(void)
 {
 	vfio_debugfs_remove_root();
+	vfio_container_cleanup();
 	ida_destroy(&vfio.device_ida);
 	vfio_cdev_cleanup();
 	class_unregister(&vfio_device_class);

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
