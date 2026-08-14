Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D771415F2C
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692565; cv=none; b=P+VP33NipKUkF4kIFA9trCNoZfnh0lmGOPBU556wWWzna915m2zO9zs9pNgExpQy/7axklWoYQ9iwLzNHJtT/gSQXjhkZTzPNjUsCz76IgqenII8vq4tbiYkBrFFGbkphH33Ox0UazjRZGflzVQQYfGs/fkfcWT6V1X4kPrlENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692565; c=relaxed/simple;
	bh=A2c/1UfoUVZwjPKT93Tz38x84LdjXaLsxnnPNTXjSOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtDzu9n5YRqGymZPbfw5aORAzOzlGdBf2PZpW80DZgKZEvw3+3SN9Kb3Vppko6nFmKD8HJk5p+1sjOeqLVTdehk95Whs+Olr0lKjL2XFca6frZv2w45EVL3sIRnQWtpOiapyFcg3njzPiGLcNciOe4C23oPJ+6VN39P0JdW5gYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYJ/tA7Q; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYJ/tA7Q"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1345026a12.1
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786692557; x=1787297357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CbblxrsuoqHEDjKyrMAHXwYMuYA31QBlUn7tIsEpyi8=;
        b=NYJ/tA7QHL31bSmY/qmTDkoTVJCbGI3lO+41PaSNKW6qXACb1r18aP4mzMB9XHXiRp
         cIbqS8DcN/veVtWLgO4e++WZY73fRXf/cpM4WsgvLXNp431ByCZ2rNDXERN0X/JN/dF5
         /0pJSO028bVUDG6KvOoEqjENIdQ+ngBdc2UyFuedH4+bqKYEzfG+gWF+QCNwJRMRHRe/
         Ge1smsw3lt6gVxUk5PGdKjvkeGa/9tueH6o9K+MMcomWbGw7ZDWg3FKM62I8K5GdeJ0t
         Meq/YlJFWt5jTYkvSP2Z4k6/GtKA+59dAzhJxyPrcYLP+ECkgaZvIx+Gt6/2IPW76U78
         yU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692557; x=1787297357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CbblxrsuoqHEDjKyrMAHXwYMuYA31QBlUn7tIsEpyi8=;
        b=ZKYXk1XXytycUIqpQx8RNRmGI3NFzOXpbZEPR6MYd6DSy+xjZN34QbriQ3fhZNBe3M
         lw0z6wfoOpGROnUuu4tSpbcmAq1gdKgBtI7DSObpPydb7tWI5PF2EEMRcYcnZL5YhHwg
         uKiJf7W/byG6rOwU2v1MvW4kRbFVTGLtPKKacbVcUjCD2JabUC63PgHUw9RgdB7d0F4A
         I/TKhj8oKhNAkKNF4GWT8+Fc8x8a4wHQRfqoCz4oHLUPcVqFIQuA/3qUgIrx0n6meZ/P
         rWyG2GHAHBOgt1XpK0TCL0XCZRkI6YlpKgpdQ2KTVC93fzIhf/9eGUkoVNqgHSIc3A8Q
         3dww==
X-Forwarded-Encrypted: i=1; AHgh+RrmdSnZAm0XRGY50bbwi8viDgATFSr6aKO9Aac4gl0jArA3AFZ14mn234VN62t2SMWS0N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlxnUhYd+dkmmU6YRpq+zIsD3j64tI4Pioy9PHpI0Svk4PHoC7
	5m8B1v7GHOV3dqf4qm6ndjH5d/oUaWaH/3b61AepTvmUr/GK+S82T/oV
X-Gm-Gg: AR+sD13TLalgxsCJLs5eSQ94NL0bHVqeIEP68a8n/oxrd13+RWBIhi6dnNi8IHsNClp
	i3ciRlqPeOjGNztWAr37QREABSP1Vxa3HuuYIwS6e97tWuj6S18DvDiADanCieS/hlKFOvCcyMo
	yoAudQiLNmcbdPt5dTNHDy86ZYoYssUFPhUgOfwRha7SGM58GTJwdwtZQigdMP0g5wXV5WJQJ2j
	XmLf/pxS4DMiQGrQOLXQ4D1Aoij8MzfLABZEN06/EQyNKhQfLZhLlzzG3FLaxrowAsKZM4qOwvN
	2RIc2Iys9WbMcHD1YCcL1q4tfC/Q3zbSvXbjqkEYK95ONiHnA77O/MtLKts2+4k5amNNqkzwCT6
	c2kOKi591nyhX7DxKA9ivcx1j8bCdnCYCm01lNtnT/k+iiDSJeQbHlah8G3iyAQJfB0tpSrSCFy
	s3+gAar9RBSisXXgypCVCq9GpxYKDjHsf+VlctK3PkJS1iVP2z7skDtun5MTtoW4Fn72HO6mDqw
	A==
X-Received: by 2002:a17:90b:33c1:b0:390:b3c5:e2c9 with SMTP id 98e67ed59e1d1-3933b0d5d31mr2565281a91.17.1786692556330;
        Fri, 14 Aug 2026 00:29:16 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394e920ba18sm1460185a91.0.2026.08.14.00.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:29:16 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] vhost: add helper to clear device IOTLB
Date: Fri, 14 Aug 2026 15:29:01 +0800
Message-Id: <20260814072903.124991-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814072903.124991-1-physicalmtea@gmail.com>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device IOTLB is shared by vhost backends, but clearing it requires
dropping each virtqueue's IOTLB pointer and metadata cache before the
old table is freed. Add a common helper for this teardown sequence so
backend-specific feature code only needs to decide when the table must
be cleared.

The caller must hold the device mutex. The helper does not update
acked_features; backends continue to update that state in their own
virtqueue loops.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vhost.c | 24 ++++++++++++++++++++++++
 drivers/vhost/vhost.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 269efad90369..7eaa61d9ceeb 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2283,6 +2283,30 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
 
+/* Caller must hold the device mutex. */
+void vhost_clear_device_iotlb(struct vhost_dev *d)
+{
+	struct vhost_iotlb *iotlb;
+	int i;
+
+	iotlb = d->iotlb;
+	d->iotlb = NULL;
+
+	for (i = 0; i < d->nvqs; ++i) {
+		struct vhost_virtqueue *vq = d->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		vq->iotlb = NULL;
+		__vhost_vq_meta_reset(vq);
+		mutex_unlock(&vq->mutex);
+	}
+
+	vhost_clear_msg(d);
+	vhost_iotlb_free(iotlb);
+	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
+}
+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
+
 int vhost_init_device_iotlb(struct vhost_dev *d)
 {
 	struct vhost_iotlb *niotlb, *oiotlb;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0192ade6e749..3c75e8089373 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 			    int noblock);
 ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 			     struct iov_iter *from);
+void vhost_clear_device_iotlb(struct vhost_dev *d);
 int vhost_init_device_iotlb(struct vhost_dev *d);
 
 void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
-- 
2.34.1
