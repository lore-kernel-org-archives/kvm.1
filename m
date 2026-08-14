Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959204137AB
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692570; cv=none; b=V5G6y9QuqiDaH/XHnqHb6RBYY7FdzK4x1bcbaa95P5g88kxryFthFtFjyc+ZeamawjzRbSLlw/39m+93wO527SeaiPb+BqMi/X8xd8dnGJwnhkn/0dwdKDwqgQRM82udwykGYGHEqBc9YwfJX+tEZ0HsOGng4fdZL+C4+hPZFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692570; c=relaxed/simple;
	bh=y6rMr9v8RkMQDzFniTx5ksD4K7N0krZyH7ayvc6VZdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e+iOx24yJtEwHJnZqqgR+2Wn14xtTJIYZRyXS47ueZP/zs5F7w8nnIja76LxLT5m5b0OKT1q97fEBs2BfxcOmBrKpIbKDqHs4fzPtPWnsX+81ztUFJBx6aExNmE2YZanbQ+pO0/QDC2sGmcLgtk8sO2Pxmcncw5fQFsem97u/ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9d1/ETA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9d1/ETA"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84eb992a881so426540b3a.2
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786692562; x=1787297362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=whRMOBoocsT3J+VYRBCXYaXX4rPKx8GaSyd74snbzsw=;
        b=Q9d1/ETAnHSXU+zBviKGHhUrrKLa6gHe9Qv/QkqfAnmi63ZwDEX5Jd+jQQOhmSO5Fb
         mHMpUT4ujklD/Th/BKMRitASQLOJ22BI7qQjauwIIKRNTWq9fdcxmrj8XhFmooswD/fl
         5DA9rPGG7RwsPjkwjyK/zBErjBsbNB+D2UPcQ4O+1t59Q05HJPojCR1TS/ip6mx9htim
         +AERp20+eGVX7x+QAhNMi+5f/o+/qKDhwm2FltscdotztRcbd8cNwFGzEWZKA3eImp84
         Q78nztKcZe/xrOCO8xKTyBAfa4bSLeQHl1GZ0lGh0WEwuin0tIJKLCFAe7I19e5vmmWx
         eBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692562; x=1787297362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=whRMOBoocsT3J+VYRBCXYaXX4rPKx8GaSyd74snbzsw=;
        b=g543ucjOzM2fmoZ+CHiI5+K7Dhm30c+/MwXg08jenH3o4fy8mF7/vdMvxH89YAFqqK
         H5whknypbRQgGoSbxDGu7JhaDhhGD7Nn9y096cGRznu6i6B8L0u2nJe0yUh4W3woQxqP
         Y7n9uYIWSmZiBG02xQhxHlBgOj8TYBQQs9RZI9hprc10NJ2y3EiMBD0M8PutqI2PAzv0
         y3Dpb1IZma4w+Qh26A8v51HcQ0QPsrTlVFHserSqmwNXEd6mzDhlBQhHjs+9Jna4bwDo
         W9yYlHhNUG6xxY6ICKEL8bJMd3AxaqNUCHFNrN/HIAheIQ3vUjkooJM/cSfMd13KMqoH
         5pJg==
X-Forwarded-Encrypted: i=1; AHgh+RpAjC8SUAQ8oIYOTE5rs/llNns7Gldae03AlIesyi7r7TGGVaGEgnCDIRENRnuCQPD/QaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb7zyXQ19XHOFAeE0EqVgGr2jp2s7Pmf/YMZf1kdqh1Sf4vlIb
	HmwScq/PmBoMFqx4OgMjwyLSJBL7N3k+3fpYOpE3sUtIcGi2cJcYVS0d
X-Gm-Gg: AR+sD10gwxVSqsHV8dUocVOyVQHt9mTNR1C1R+mHTtIYwfeXuHPfKvwEL7M2rMqiYdG
	VCsF3FIbNNTi6+UW/EwXWhgzHES/2GUwf38nO6vzyKGrMWrbHRgI7DkFRpMWLwrYDEZcsUw5fk7
	dWxb9ALpDwngSY3y406Fg8X21NlhmexHVbPAdWcwGIXm1N1RTs7c303WaxIDkHcwSfRPZybcuKF
	Z2gS0dyyXcfmLK+F8v3perbEEEI7X5V+46pWPpUsTptdT1inCwYGPVuPWLB2BMgigPddbQMXcKx
	kQs5pXjQdCN4Qbi2h/jp2mzUNSd6xAPcDBE+d18IjR4i0rtMUdMzxSVWG+f86mW7e0sfKxvp9uZ
	h6JYOVXZhcmIvb3LnrIH3JYj1qtuQ3XKMkZz7cxyI5B7Lk7Kt70s49U0DFtVC4AWRvcboecUn0i
	Uk+15z2s5uSEsrtMpNjG1SaYzZ7Y34TJKqsssfurGk8EswHuQVVjUn4tcFKR+15uU=
X-Received: by 2002:a05:6a00:1793:b0:847:9c3a:b77f with SMTP id d2e1a72fcca58-84fde314673mr3794400b3a.35.1786692562070;
        Fri, 14 Aug 2026 00:29:22 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d249b39sm93258b3a.47.2026.08.14.00.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:29:21 -0700 (PDT)
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
Subject:
 [PATCH v4 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Fri, 14 Aug 2026 15:29:02 +0800
Message-Id: <20260814072903.124991-3-physicalmtea@gmail.com>
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

vhost_vsock_set_features() leaves the device IOTLB attached when
userspace clears VIRTIO_F_ACCESS_PLATFORM. Descriptors can therefore
continue to use translations installed before the feature change,
including HVAs made stale by a later memory table update.

Use the common vhost helper to detach the device IOTLB before
acknowledging a feature mask without ACCESS_PLATFORM. The helper clears
each virtqueue's IOTLB pointer and metadata cache under its mutex, then
frees the old IOTLB after all virtqueues have dropped their references.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..b69c260eaeff 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -863,7 +863,11 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	if ((features & (1 << VHOST_F_LOG_ALL)) &&
 	    !vhost_log_access_ok(&vsock->dev)) {
 		goto err;
 	}
 
+	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    vsock->dev.iotlb)
+		vhost_clear_device_iotlb(&vsock->dev);
+
 	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
-- 
2.34.1
