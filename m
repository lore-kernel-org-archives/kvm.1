Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B64AE8CF
	for <kvm@vger.kernel.org>; Sat,  5 Sep 2026 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788621684; cv=none; b=l9swnC2C30F0FPT2fyQ0t9NlcBEyGkYmtHcDDfp3AyMq4lZVv/RMSZr7Ao+tvvjbsAdaOnGQiWZFCznJhaDRhKTCTV/ssLxQd2NDXv75/joLbppSCWYcGvCcpz0bDiffv39RE+Le5MhAhMCdj50lcNBBerR5UE1uDK6igMOpHwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788621684; c=relaxed/simple;
	bh=o5w8meMgR85hvsqu/UmribMxya6NB2BOgGgde6W9CO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHMJW3vKyOdVVjPEeLJTpXL7PVJ2nuLolWrRPBv9PVohcZ/ogl6nXlQ6u3KQl7G87ZA+z98jB2xeRGEIZTQcFVhmz7GT1ncHovqd59IkbF0FGi5XdJswwm0ZWbAAIC1Mt0Zc3LI9M4hX+7PWpIPT7OwL/hE8CGsdkUx6Xx2sKR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbvhTyH7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbvhTyH7"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49cd9add88aso14600465e9.3
        for <kvm@vger.kernel.org>; Sat, 05 Sep 2026 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788621677; x=1789226477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tpulPZddhuPwIKcjBWNAE6zpuXjOxSBLaTnXCz35ckk=;
        b=NbvhTyH7qp1LqFtym4BpLZ6lCm0AN4zXFSMecOiTNDnWkmNZyNxgt+rx5TUMde4X/T
         ZBxh28b48bjrbBKTfbWwxcw9Mtkww//VhWq4IJ5N+3fwFhdUEtkdnMYm1OjGJwbrAqnS
         qqOMaKRsJdAYslhnqmMYUN1RIInA6xqpj5CZyvSTnS7B82xtYQoPfEQKEXB9I0uSMcWl
         SMHJLxWUataM6blAR9dXtKAP1VQPzlw9rsg2o8vF9aQ/8v/muU06wsYN7yOVmKJBOcLb
         7i6GqX3xcQ09G+dO+J8QGocTEN+DX3gbNV1NUL7gxyev1Sglc+J3bRp4ZTbJki733GL+
         Eeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788621677; x=1789226477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tpulPZddhuPwIKcjBWNAE6zpuXjOxSBLaTnXCz35ckk=;
        b=VMfsdB1e9zDlef3Z5dL/s3IQG1shQQByq2auBOJ+KiDrFpG5EFOxLMIrRNmaeCcDne
         +dg6INcv9iTXth4puRgN6CcaWcETqeM7xoksVL+bwefwSpk83M1D9wrDiZLRMUvuJ9+Q
         ZTMLl+xYClrY7ntYi1q2X2CqjvpFsO9z1IOVI1vOy5W0BOtfZMTjpabetsb3FTnUniTE
         OpTG3uy5Mq1NvfRCqMjZrohFSo44dzyQTVf3hZAKyhMyG6sHCA3frRCO8K3PYb/5UZjI
         JRN7KX+uarnZHwzSB2b35qXcz3bLtSZdVcA04goD0S77GdwL/M75hUaXIc+mHF0D9gK7
         JrEw==
X-Forwarded-Encrypted: i=1; AKwUvBzQhHeSF/xIYKklX0k9Gl64Jb38QPpWBkb0+M/u77snV9n/UFoncKG8QS2GnbjTMypGbCA=@vger.kernel.org
X-Gm-Message-State: AFuF++kV6i/jr3d1eo+UHNiNjwgDLYApY4x04yC5o5I91J0DZfkTu9cO
	kx6o/Di4kQGSZU7ckwQFO7tPIpYM5K+9pNYq5bcpP5uxFVQLstYt5L39
X-Gm-Gg: AYBFou2vd/HLa3DSodSwPqHnOKlRN8xM6H8ng3tn17Pkvj8g4LNA7B2olhfplUaKJEn
	gQePibJWdQ4P9Yr3F2ggUzlZDtEwbadavWD3QgteO1yqD8nEBwZAm24pevhISBLCb4jcqrOXeHh
	QBs7HmhY4/b8HYNQzVWvG+NVkLBn8CtmOiys1bBAGfGQFPbkARhIuPZDUmklpBxWRpgZ5K3Zh3Q
	JQT7r7eor1MubRxj7KAWK1bP+f/o3swnYYWTb32Ffyci8XcaLF2okvcEF346qYQ9fOFeAsWi2Tc
	V2wJ8+PdP6wfddo96ZhrgRzXH9yTAEKb0GX5SeZnibi+zuKjI47ly/4mNhtGvltz8XETuiR6PNB
	kvf1NjyKkhNO8jSSA8oY2RjC65w2BULmJkCL5K7VNW3F20KqOfqEFgBddOmNEa8tjZGywpc5hVO
	6m75xPouk7t5g/I6wbqK9BT6f2sIFvVbwrsZvboCzutjgMH+1/1ySM10ImV5gGPpbhTve8m8oex
	HkMsKoBSbOAgO2bCuKesnnWnfQU1q4P55TOuOIbIUKmmathr/Kr94Jh3zGpwKKN8A9j2ZAicfAh
	j4OLPx4tAcoDqxk2u5DAp5zT8kDJL++pRSJdmzU361NMyaKP5/2P5VNYBG2dGYNhOqU=
X-Received: by 2002:a05:600c:6209:b0:49c:fed6:cd3f with SMTP id 5b1f17b1804b1-49cfed6cd4dmr81095545e9.23.1788621677280;
        Sat, 05 Sep 2026 08:21:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm267779515e9.1.2026.09.05.08.21.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 08:21:16 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] virtio: synchronize callbacks during device reset
Date: Sat,  5 Sep 2026 17:20:57 +0200
Message-Id: <20260905152059.89560-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_reset_device() promises that vq callbacks have finished when it
returns. virtio-pci waits in vp_reset(), but other transports can return
with a callback still running.

Call virtio_synchronize_cbs() after config->reset() and drop the duplicate
waits from both PCI reset methods. Add the wait to virtio_device_shutdown()
too, since it calls config->reset() directly. Keep the pre-reset call under
CONFIG_VIRTIO_HARDEN_NOTIFICATION so callbacks see vq->broken.

Always take irq_lock in the classic virtio-ccw interrupt handler so it
pairs with synchronize_cbs even without notification hardening. Use
is_thinint to choose the lock: airq_info can stay allocated after a
fallback to classic interrupts.

The transport reset must still stop new callbacks before this wait.

Fixes: d9679d0013a6 ("virtio: wrap config->reset calls")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/s390/virtio/virtio_ccw.c   | 6 +-----
 drivers/virtio/virtio.c            | 2 ++
 drivers/virtio/virtio_pci_legacy.c | 2 --
 drivers/virtio/virtio_pci_modern.c | 3 ---
 include/linux/virtio_config.h      | 6 +++---
 5 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index bab6cad3fd5c..552d77998012 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1062,7 +1062,7 @@ static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	struct airq_info *info = vcdev->airq_info;
 
-	if (info) {
+	if (vcdev->is_thinint && info) {
 		/*
 		 * This device uses adapter interrupts: synchronize with
 		 * vring_interrupt() called by virtio_airq_handler()
@@ -1204,13 +1204,11 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 			vcdev->err = -EIO;
 	}
 	virtio_ccw_check_activity(vcdev, activity);
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	/*
 	 * Paired with virtio_ccw_synchronize_cbs() and interrupts are
 	 * disabled here.
 	 */
 	read_lock(&vcdev->irq_lock);
-#endif
 	for_each_set_bit(i, indicators(vcdev),
 			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
 		/* The bit clear must happen before the vring kick. */
@@ -1219,9 +1217,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 		vq = virtio_ccw_vq_by_ind(vcdev, i);
 		vring_interrupt(0, vq);
 	}
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	read_unlock(&vcdev->irq_lock);
-#endif
 	if (test_bit(0, indicators2(vcdev))) {
 		virtio_config_changed(&vcdev->vdev);
 		clear_bit(0, indicators2(vcdev));
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 75bb4ffe3b87..ad1c50b8a94e 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -264,6 +264,7 @@ void virtio_reset_device(struct virtio_device *dev)
 #endif
 
 	dev->config->reset(dev);
+	virtio_synchronize_cbs(dev);
 }
 EXPORT_SYMBOL_GPL(virtio_reset_device);
 
@@ -424,6 +425,7 @@ void virtio_device_shutdown(struct virtio_device *dev)
 	 * Some devices get wedged if this happens, so reset to make sure it does not.
 	 */
 	dev->config->reset(dev);
+	virtio_synchronize_cbs(dev);
 }
 EXPORT_SYMBOL_GPL(virtio_device_shutdown);
 
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d9cbb02b35a1..8115aa39e01e 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -98,8 +98,6 @@ static void vp_reset(struct virtio_device *vdev)
 	/* Flush out the status write, and flush in device writes,
 	 * including MSi-X interrupts, if any. */
 	vp_legacy_get_status(&vp_dev->ldev);
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 6d8ae2a6a8ca..c9e21317c51a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -559,9 +559,6 @@ static void vp_reset(struct virtio_device *vdev)
 		msleep(1);
 
 	vp_modern_avq_cleanup(vdev);
-
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
 }
 
 static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 69f84ea85d71..8684a1e268ee 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -71,9 +71,9 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  * @del_vqs: free virtqueues found by find_vqs().
  * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
- *      The function guarantees that all memory operations on the
- *      queue before it are visible to the vring_interrupt() that is
- *      called after it.
+ *      Wait for running callbacks to complete. Memory operations on the
+ *      queue before this call must be visible to vring_interrupt() calls
+ *      that follow it.
  *      vdev: the virtio_device
  * @get_features: get the array of feature bits for this device.
  *	vdev: the virtio_device
-- 
2.39.5 (Apple Git-154)
