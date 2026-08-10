Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB878C1F
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786323808; cv=none; b=QCGBj/aWBAGP/xCS9IlWxJY6b+JMB6tfkrxcWKE9SNBofOK9x56/BFKLtfG6Ig+rUoc4juOmonBXXjiaY/BCwEP0JcZlQhgdur6yhIaa35IhTZbcYPWGkukJ/UbiKfqUA5YUc2EtHxOpXeGYciqD8uHZhtxuuVqqJTCcEWY2yg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786323808; c=relaxed/simple;
	bh=/UNLEhTBAnch36SgaK4rfVGlQTG/rEakKekLFDXlBQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=upk4C7vAAWZw0VWJDLwbUzFwO4PoActwh5nyOJsbppo5aIMZrDoqC8NwoTtlROOUiVWK+QSJ9OWxHFfDJzlj9Cny9bxGUmwqAg8X/jG/O4WMYr6USkUu6nosDJSNZVrMm7Zq8fKTmEFhIwXSgr4tvs7O6wshIZMwKyT/Nq6doOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGwPP3m+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGwPP3m+"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e347638adso1398182a91.0
        for <kvm@vger.kernel.org>; Sun, 09 Aug 2026 18:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786323807; x=1786928607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MbbU/F/djf22NMRk+tFA6K7hMv5blZDiEPyCufD11oE=;
        b=kGwPP3m+84MyCsrHaaTZx34HjnPtRt5oHJl2VtkddFBH/Q4o5kj7S3V7u3ytKySR86
         zREW5/Lt7AoMcqgNRktRp83vbQ2z7/Bv9qOjzgVPaFerPzm93v7zyQnpT9Dmte740Aiu
         7x7y4wJHn/T64staKBqy9Mssud5PqLcWQa2FEisIPNJh6+ft8/UpnONDdTtOqoIfwN6z
         vQNgzjKpVdOZDLVtnmcyi3uHKVp7jCer8bPFQH98gZXscyUG1kcLmLYmX17E4HhPulyF
         qc8ntXQlposFtb+/4LzSifw8hOVJ1IUa4lkiUOFVOcm8OB5ZRj7FasDjckeVmnui2md6
         wuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786323807; x=1786928607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MbbU/F/djf22NMRk+tFA6K7hMv5blZDiEPyCufD11oE=;
        b=i05Dy25SRP5IeaZxGZ+YyVfrS8Wedk5TaECnDHVmmfU3qspGyffSGXTA/zFHL7YAx/
         2bm+43uo3uRuYnzWnUNp+iJr56XBof4Wr18nKeqUAs5urXfsiKSuegVV1x99XBFzjUJ4
         qGo51ffQh24HQUEJ6VgRDgSVJMh4y1ZThiCgKm+cCQwAhCwpiqJk+nebFOJvPT6vC/DK
         A9S2gyECtfKQTYq5LYJKY7ZYk4lxnTZDKCOVGpIpboLM+C2nLrzKqn4K7/cW0MAjUC0e
         CGuuCbMF/8swNjHHhQbbsG/dh1xh9Ak+d/IXf8thUHF3z/pAmRrao1PWY6HAAbuqlVjg
         JOgg==
X-Gm-Message-State: AOJu0Yxa6VcrcvfmG+YpqgAiE0CXsYVLbXEJHcnoDLYY9PoGm/AUNx5c
	yXePF2EjD3takIsrGWDkvKjFv6ee2ek1xmqeuOtNK9tGYcpt5x0/OiH0
X-Gm-Gg: AR+sD100Y7HG+T6zOnS3gwBMVrdhwGfqUOuVNs1jVA8mk0laWExbUw+TnOPsAr0cnbj
	8Z9Qk/bwipIfVnCeihhOX630SdQy6mOcmuDgG0e40JDc8iqlc+OVynEwL2avLr3WDNc1irb7zHZ
	Af854Ap+JUBaoyl15VjBnFY2E6JH+u9rNS6ddtvwcnovIkU75VzfejKu7t5mTlCQLKRyF/qQa3x
	wBCsv62KYb3S4O/SzPOUgUpJvj3ZGs6Dr2HmSTLPyOe/Sv1fAFsXYsCcyTlIKRCHPauGNL6cPQo
	zhmhUkepVsb7JcXlESpVQQfF6B4X2qR0vR1i8fFkGlGTfagV8h+yN4wHTM/XuukwES9vVL5J+NF
	SOzUMYkQ3tgclSR0t/LDJk+Gxcsp+2qOdZ3J/7FLoSFMZCoP0pY1HPaQlmESZfhJO8AfQ7vYXwP
	lX7fOxa2i+g6mcUlBLLsprsvUZumtrC5Z/lyBz8YlXi9NR2O93TUbUOHrAd6A=
X-Received: by 2002:a17:90b:4a0f:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-392823340e5mr16894066a91.5.1786323806331;
        Sun, 09 Aug 2026 18:03:26 -0700 (PDT)
Received: from gmail.com ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff64b1dsm10138275a91.13.2026.08.09.18.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 18:03:25 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] vhost/vdpa: reject VRING_NUM larger than device max
Date: Mon, 10 Aug 2026 09:03:00 +0800
Message-Id: <20260810010300.132959-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vring_set_num() accepts any non-zero power-of-two queue size that
fits in 16 bits. vhost-vdpa then passes that value to set_vq_num()
without comparing it with get_vq_num_max().

A process with access to /dev/vhost-vdpa-* can therefore configure a
queue larger than the device advertises. With vdpa_sim, the worker can
walk descriptors beyond the mapped descriptor ring. KASAN reports a
16-byte out-of-bounds read, corresponding to one vring_desc, in the
vringh IOTLB path:

  BUG: KASAN: out-of-bounds in _copy_from_iter
  Read of size 16
  copy_from_iotlb
  copydesc_iotlb
  vringh_getdesc_iotlb
  vdpasim_net_work

Cache get_vq_num_max() immediately after reset. Some backends derive
it from writable queue-size state, so querying it after SET_NUM may
return the current size instead of the device capability. Invalidate
the cached value before reset so a failed reset leaves SET_NUM
disabled.

For VHOST_SET_VRING_NUM, copy the complete vring state once and use
the same index and size for validation, vq->num, and set_vq_num().
This ensures that validation and use operate on the same copied values.

Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
v3:
- Copy VHOST_SET_VRING_NUM once and use the copied values throughout,
  avoiding the double-fetch race in v2.
- Cache the device-wide maximum after reset so mutable queue state
  cannot break a later legal resize; fail closed if reset fails.

v2:
- Add the missing Signed-off-by tag.

 drivers/vhost/vdpa.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 692564b1bcbb..f2eedb0464c2 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -53,6 +53,7 @@ struct vhost_vdpa {
 	struct cdev cdev;
 	atomic_t opened;
 	u32 nvqs;
+	u16 vq_num_max;
 	int virtio_id;
 	int minor;
 	struct eventfd_ctx *config_ctx;
@@ -229,7 +230,9 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_vdpa *v, u16 qid)
 static int _compat_vdpa_reset(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
 	u32 flags = 0;
+	int ret;
 
 	v->suspended = false;
 
@@ -239,7 +242,14 @@ static int _compat_vdpa_reset(struct vhost_vdpa *v)
 			 VDPA_RESET_F_CLEAN_MAP : 0;
 	}
 
-	return vdpa_reset(vdpa, flags);
+	v->vq_num_max = 0;
+	ret = vdpa_reset(vdpa, flags);
+	if (!ret) {
+		/* Some backends derive the max from mutable queue state. */
+		v->vq_num_max = ops->get_vq_num_max(vdpa);
+	}
+
+	return ret;
 }
 
 static int vhost_vdpa_reset(struct vhost_vdpa *v)
@@ -641,9 +651,15 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	u32 idx;
 	long r;
 
-	r = get_user(idx, (u32 __user *)argp);
-	if (r < 0)
-		return r;
+	if (cmd == VHOST_SET_VRING_NUM) {
+		if (copy_from_user(&s, argp, sizeof(s)))
+			return -EFAULT;
+		idx = s.index;
+	} else {
+		r = get_user(idx, (u32 __user *)argp);
+		if (r < 0)
+			return r;
+	}
 
 	if (idx >= v->nvqs)
 		return -ENOBUFS;
@@ -652,6 +668,23 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	vq = &v->vqs[idx];
 
 	switch (cmd) {
+	case VHOST_SET_VRING_NUM:
+		mutex_lock(&vq->mutex);
+		if (vq->private_data) {
+			r = -EBUSY;
+		} else if (!s.num || s.num > 0xffff ||
+			   s.num > v->vq_num_max ||
+			   (s.num & (s.num - 1))) {
+			r = -EINVAL;
+		} else {
+			vq->num = s.num;
+			r = 0;
+		}
+		mutex_unlock(&vq->mutex);
+		if (r)
+			return r;
+		ops->set_vq_num(vdpa, idx, s.num);
+		return 0;
 	case VHOST_VDPA_SET_VRING_ENABLE:
 		if (copy_from_user(&s, argp, sizeof(s)))
 			return -EFAULT;
@@ -765,9 +798,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		ops->set_vq_cb(vdpa, idx, &cb);
 		break;
 
-	case VHOST_SET_VRING_NUM:
-		ops->set_vq_num(vdpa, idx, vq->num);
-		break;
 	}
 
 	return r;
-- 
2.34.1
