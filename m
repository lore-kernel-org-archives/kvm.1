Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A4A3191D6
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786188313; cv=none; b=OBiYlquNNBmJ9ZqIQjC/IYk2kwGD4OI39QSKexN/ge18VvEooOg+reoHZk4giVWLE31kfwu6F1zlQSc2aMe4IDNqvKFAbYDBiu45rZ/QA9J3IznwwdK0Tv/cGTB+ow7kL5+2JBxkms6hFMX9hwwRiStSIrBEnPD01+24uMznhbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786188313; c=relaxed/simple;
	bh=S06gw4GaTWEIrO/scYSHRfENLicYT3okDY8QqVj7Uok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZuX+Js73XHMw3mCNqPBWCcHJuEOWkUvBb/fa9a5OPfc4AfT/qOWDBtWFdeAY8K/TN0XTtYUFnGz988B5NcVmabnPazN1iR0casgv7Gv1P5hWjS8UEHWu9MKPvPuVqd1bOdomtptTG7lIUHlJ5NzylGXuqLdTY0Nl8YwNXmiucik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtqnjQya; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtqnjQya"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-caf45fc5202so213542a12.1
        for <kvm@vger.kernel.org>; Sat, 08 Aug 2026 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786188311; x=1786793111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1TJD+ZNU8p0QF/zIOcyyYdEmIZzKa2aJynIM7jFFyUQ=;
        b=dtqnjQyalO/IWF2SeSYvrwd89YeBlK75DMQjFDjs+J2gmCeXbX5xr2rg86TD43iMzr
         km6I9I4Pd68ojPU72rttKGH/Glun7B8DxXDsTjh7pcRlBUzE7MHFS2h0k7m3BKkRIcwl
         8MhBQBXFoBHw42vRSGKlx0qE1dWx7KX8+a0NtUiaf7Q2qnfq4jgD/r2PxDnds8oTuO3v
         VWuU53GxKU7HUiUz15M1pSmvyIzy/AaX8ruhk0ZaQCLecHA0gsqJUF25pros+13O75t4
         ggLFzWfFPsley2ULRYDNesAb2rK3HQv6d4OXM8a/7Vh3bUfU+oPZCxJxUHlhRKsRonb7
         hpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786188311; x=1786793111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1TJD+ZNU8p0QF/zIOcyyYdEmIZzKa2aJynIM7jFFyUQ=;
        b=ZgfdpXZPa57hjkCj82GTRTLDAJLOiFjLU3cgTs6FRuPueQihvVfEDnlKS22pCfqPYq
         yGQbOIQQZARj/G48BTY3O2MbHktjaJI6LvcCORXeE5dAQrt9GLC7cZKVEIJnOjiIALBw
         nm/lhn642e8lhXHTbeNk0uXmZ31Gsx+Sb4g5u5hKYzG2ikvlAHVgu7pK07QQo07xV8e8
         hOjtnTzYiWD+lk3UL/JWEHT9tD1bBgQPLwtflbvfgBfzqSaFZo5EfAkGP084JdUBa9Xp
         w7WWznUBMreXO28CLehCO70gO6W+39XEY7BNQy0gLzLbaC2ZnQF3vafmFXYjxomi7COL
         NO5g==
X-Forwarded-Encrypted: i=1; AHgh+RqR6sNZ11KMaB9V9WSY+tWpTVsl+/OolSkijAYGz51g8qnlehQbj5FhsBwnAch99oOwXSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zM1vHO3Y9t9kueIhx2njVNcDzEnhj0jdl68wDE7ytnCgrzXj
	cH7I3Nuv/DjiW8nuNertKX1rRyUyMIxPdDL6Gqt/SaX1vfiBA3pd7c9N
X-Gm-Gg: AR+sD116tA9qXAabGCJYKlFZJKXAHY/1PNuSABLFiecI0/m1+80dTRoIpzmFpo6x2l2
	gH0SQIuUvIdEvrmFb/HpwGxpbILYH/8eyqIk24xkoovgcotYhwLMHSTp43jNR0xt0w7CRdbqqAB
	/ksdQHiL/IFKaZkVqRtsCIYLKjLQnS1iJEu8CUgexoliz61U9wTlFREfZoKmVsXpWW0r7Lsv3Vs
	KfJbgXyGEmHtmCtlRvkgcdqBGgirHcA2jHA5FPo9kzvax6di5u+ptl3liB+jJGaHPEERr/HSwo9
	/CNLrMJCqn7gv8NfNKE+XIMKWiWrdaa7aGf4saIjqYCbdzt0s6m5JxZ8O99ITCp7VI/hieQeoA7
	tJLsLQhSYx6CVqFamxWpDdJR/hEMQiwnA6f0tAaaJ+iWsycSBt2yLlXXzfNsiy/2WyFCMJ0Cl4t
	r+9RgE6JJx9AuFpAhxeLmKIqsUpftUpNpsN5tN6lmMOYU6cucKDeOp5BjtWtyk8ymhQteWDCw=
X-Received: by 2002:a05:6300:4045:b0:3bf:83f3:b810 with SMTP id adf61e73a8af0-3cb85ef7f63mr36662806637.29.1786188310005;
        Sat, 08 Aug 2026 04:25:10 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebee8d0sm17746334eec.24.2026.08.08.04.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 04:25:09 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Tiwei Bie <tiwei.bie@intel.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vhost/vdpa: reject VRING_NUM larger than device max
Date: Sat,  8 Aug 2026 19:24:58 +0800
Message-Id: <20260808112458.101616-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vring_set_num() only requires a non-zero power-of-two that fits
in 16 bits. vhost-vdpa then hands that value to the backend through
set_vq_num() without comparing it to get_vq_num_max().

A local process with access to /dev/vhost-vdpa-* can therefore set a
queue size larger than the device advertises. On the vdpa_sim backend,
the worker then walks descriptors beyond the mapped descriptor ring.
KASAN reports a 16-byte out-of-bounds read, corresponding to one
vring_desc, in the vringh IOTLB path:

  BUG: KASAN: out-of-bounds in _copy_from_iter
  Read of size 16
  copy_from_iotlb
  copydesc_iotlb
  vringh_getdesc_iotlb
  vdpasim_net_work

Check the requested size against get_vq_num_max() in
vhost_vdpa_vring_ioctl() before calling vhost_vring_ioctl(), and return
-EINVAL when the request is too large.

Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
v2:
- Add the missing Signed-off-by tag.

 drivers/vhost/vdpa.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275fa0d0..b2083e1ef150 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -716,6 +716,13 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				vhost_vdpa_unsetup_vq_irq(v, idx);
 		}
 		break;
+	case VHOST_SET_VRING_NUM:
+		/* Reject sizes above the max reported by the device. */
+		if (copy_from_user(&s, argp, sizeof(s)))
+			return -EFAULT;
+		if (s.num > ops->get_vq_num_max(vdpa))
+			return -EINVAL;
+		break;
 	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
-- 
2.34.1
