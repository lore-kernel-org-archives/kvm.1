Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789B376469
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786185270; cv=none; b=mdyh6cJUbhi5dSZ5Cl8W4sa9JvUN/GkSTbQzOeHGdSuOVyPrSTeB1guPA6o7i3vBqXgx2eRVl9SShh8mttcK2pkID20a5ykdeX6COa1B1gnTyWfsiImIeayn6g++PyQzlnE733VnVn3FhzqfBhr63S99YuTk2nVS1d4qsrPFOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786185270; c=relaxed/simple;
	bh=8cLsyOrjXGvoCCKeyA9EG98ua8ktDWJeJNjwpR7WQKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQUVe/GihfP0Dn8nxiRYAjhW4dohf1l2Jqiwp4MtLl25pWDoL3SCI/l8Di4jwwoN8JdIuuLAdxsiZZoAT7sMmW+CSgjIHKPpyOiqUHgQILK3OlRaVe6yeVm7HwlIgwQnvuhPYiN7e80yM1p4ch3nqwIVgtgQqKUEMLyOAScTY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOxI4qUd; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOxI4qUd"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so347481a12.2
        for <kvm@vger.kernel.org>; Sat, 08 Aug 2026 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786185268; x=1786790068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LMt2HBv95FWkEezOYc96XrHhu7tFutq5B2cwfp/ralY=;
        b=VOxI4qUd8ZYG6z0foxa6r2QAkVviy27w2Gsn1NMKAIyTci4cdvDpRDD1nXK2e7GLBK
         YZzoZLqV64xDJxUkxFl5zGLCClrzCgIanrSHfxNprxmFBFgZw0QOb+1DZhnWTY5UIgbc
         Gn4l/a9sSsR6P9nXPERZCB6ac8/F6vo8ZgOs8C4CtJzm4fR6H0jWP7Zl2hA57Q2tzd5n
         NZBN4Om21wGN6AYUkEpc/SZbwi+CKULMd5ZIBFRgv3tDzeL0A89h57FkPtgv1vg0VIlN
         7WzpXPgncAyf4CgnsDiYnkO7MteEXbV9MPTlx61TArBBo3JX8W5bfhHhVERrylPCAOgq
         kWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786185268; x=1786790068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMt2HBv95FWkEezOYc96XrHhu7tFutq5B2cwfp/ralY=;
        b=FARDrZjY190kTrnubZvKk9UIf0Gk+iclhW248YBdTlhpsHTt+4JrGvhLEhNaq5SoLn
         poEEtWXneIQvbX2j8ERw0lErCwjnDw2+tFplomY/yfYznne+oGeQMZd29gE0uFzmQmqx
         eoHFgE/HRuUsdkLMjTpLTWorjna7QEusYZcbS8lshF3eoIEKweZhSy6tAFu/w6tMJ4Nj
         +7JOFXRneaORzlz6a5AGF/boguIih3uk4vpmEvpZVYg4vY3WPcFSzEMXZhhFFCgWWzXY
         A435fH/Ibr5CCIIOZt6vMhGdRnBAEWHyyV34uGUo7rQ0+tPBdWLBhU0UPkTg8HxXpVW1
         lbVA==
X-Forwarded-Encrypted: i=1; AHgh+RriSkxX1FbGoJyg5pMsetpdGPhHtA08WxN+Lq+WMVn0537Rrzj+7w6RxeBF490ZSiYLRxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIlpbhgiqnBFV4TFmUXAXmtNHnlEAkNc+PqGWxSg1NDuljIOvG
	D+Yqnkt67Ra67WrbfHl7XUNO90lJAjBNYxYtgrd5lp0CX0YGVC5IbbXh
X-Gm-Gg: AR+sD107S02gdpjYJ6a08FCGl67SzrFGz97L0IcliyTlk2ufLYz06Fq28sV8gjs2v3/
	Jp/LMy4+0Pk5R32QR5yrCbZTzslBQTJR6TF1eICrZq7VbxDGQDyaRP6HUG0ahvxnQzPLuTYhqft
	1Awx4pod4MFB2eGOR+RIYAdaf7ToCskl/9eL503Mh/apWthEwb2I7RslT2+eiGuQ3rz5ZGmbvFV
	1LY9SIECnTXTCwo9w42TuotOKBG/nJuYy+ykmGxOCkHYSckymoPxjNTTRWB2gXgdfrf1FK4OIP6
	ZIzZrbBwmNp1gQ4OkYO6oYarn90eS/9nUB7vREQdy3WV4M8AhXeophjam1jAp9aT8f7MGOhAQrE
	Z2Hs980lN9eE+CoQ0nLP5W3z6M9ZL8vaKL60zb/6hFYu6/309RSBPTjgqPMXP2sxUAfdisHY2Cs
	8wDJPCXH04fqHMa1sEYuoPwpttSL3Afmrj34mN3XFOP88qixhSVajpomWzlnKdr1rrDAfWjOc=
X-Received: by 2002:a05:6a20:3d0b:b0:3bf:b1d3:393e with SMTP id adf61e73a8af0-3cbc01011aemr11771109637.2.1786185267762;
        Sat, 08 Aug 2026 03:34:27 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86d3fcsm18060034eec.4.2026.08.08.03.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 03:34:27 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Tiwei Bie <tiwei.bie@intel.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost/vdpa: reject VRING_NUM larger than device max
Date: Sat,  8 Aug 2026 18:34:15 +0800
Message-Id: <20260808103415.101261-1-physicalmtea@gmail.com>
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
---
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
