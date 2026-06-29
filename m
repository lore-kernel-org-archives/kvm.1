Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3CFBE1
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782697539; cv=none; b=G3FXejNQG+Me+pVOH5ODx0MX6BWb/gjx9/LVTFxjZ/J3OR2PhH9noTDZQhSQKjM4U9mjqU+GDKCfK6ETQqdi0A23omJygwq8sDlsKkiL0yaP50PMjuj6S5ZR2RZbYgmDdBMl5VLdWk7qbol6FTTozXUkvDv0v7T/xpfz8Kb/eiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782697539; c=relaxed/simple;
	bh=yntFMUzD/ii2OqD5HS1hjbqyMZks/DiA0fVR83FEiGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=JoGT6qT+kf1Oeb9pk2l2040IJ0D+7uMWu3PKZ9LbPHbJAJThnKdV1J4Vqlke+SRT5r+D8Q0+/+kSrtzDw4wanjVZuYbPhpjmIGzym+TAvGLljED8SmHKC98vUAxVV15mOc3hhT6Lgrnbc+jWqgbKOyK4U3nRaEuulRaE5u/Mov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMJdHDH8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3OF/izX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMJdHDH8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3OF/izX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782697536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AehoOCJmWEBUGxUzdNE1sQa+qNVdV0emwrzzm73CHcA=;
	b=IMJdHDH8BhSK7JkRrELOVBja2DlkKb9sli0Rq9+9QLmWGcu77FCOaN8oWje6iKWJNeWzNI
	lPb4qGyWuJwE1SUju0VJASCP601tbyvFmWnODLxC6qNXZM1EQGlqGgOVRHrHmuuTQBhqjd
	1cND8fPteIc6o2NN3C7XSjpefev5CQ4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-qTctaGg7PIuI0N9UJPsERA-1; Sun, 28 Jun 2026 21:45:35 -0400
X-MC-Unique: qTctaGg7PIuI0N9UJPsERA-1
X-Mimecast-MFC-AGG-ID: qTctaGg7PIuI0N9UJPsERA_1782697534
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d97955899so1788421a91.0
        for <kvm@vger.kernel.org>; Sun, 28 Jun 2026 18:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782697534; x=1783302334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AehoOCJmWEBUGxUzdNE1sQa+qNVdV0emwrzzm73CHcA=;
        b=d3OF/izX3rU51gbaUdW3k9SQtb4pNVa6/DYQSxvmqYQM/8L3Y60WiKeT7Ol915xwye
         H2JcP1xJygJyQEwigWELDTV7rB681DuHtw5gp+nf7Jb2dBVwb/ms+yqAxnmEylFMeam+
         JdjZ98ncJJc0WItzXkVw5zFr7JSemM2GEL9R23Vtl5ATa4/eddN/8WlIC1ojm4VqQNXu
         JbwPO66mz0ONWlVEZH+XiJTMYmwTzJiw2VS9n08AHd+WbvrUlOAPthdE0HI3PXCLHPcJ
         GRKJWSfyak/DiNxjjMyQJePJdIxnBQs5uWicDuTJcSHHa5u2oDyqcj4hMlSoW08AiG4V
         8zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782697534; x=1783302334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AehoOCJmWEBUGxUzdNE1sQa+qNVdV0emwrzzm73CHcA=;
        b=lRU+c1vQZmDiCYKd5S06sMyMFBVfygpRiZq3AuYtU7joYWKJB081npQYz3TJmAkX1Q
         6FHR/scxlWWfFekFu/ydwTht5clAiOBEX7s0pIVP/QVwdiRPHoIX2UoKsv+n7eQL/Yrf
         u/oqtD+42MmLMRAMOO8Ao2TtMDUlTcgi9ixQJIjJJ8HQZkVFIQYsUD+pySh8fW6EUozR
         /X+bR2q+xDvtnpcxPBZitmenwwKBDYiWdNpL/YwO6WQo+c4ICNObb5dqcFzCqRgHOSqb
         G83n6G+c2Ezaryk+eW7aCNXK8yUkxOo5a+FECVQqml3D1cjomzKw9xWRwfnBboSipaRB
         vYYg==
X-Forwarded-Encrypted: i=1; AHgh+Rq6whKbrFuE0vO3JThuUIDlVaBW9eePVoKQLslsudoJlcx03ctLjqtTBTl8HHQFDTNjkqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzX5USCYbQhFK+O4gtx345F71ZH3F4NwM72M7kj/xAbht9Lm6r
	r3QrwLijnQ6UNniYFxsJQ5FBNiEzuU1exRq7K+xbYiI1PErDsHSa449/BiQ91rCXmIhl8dQf/V4
	hWwuuJTK553AZMYWv0jL93I28JDvEu4SX491kQJjBzJ54s0M72h6fEA==
X-Gm-Gg: AfdE7cnM2hMYNXIt4+Py0wkUYadrSS6n7VzpHrzwNuDM2Rmvv68sVmtSXSgbg1dOEYU
	xzWXQiutBrri6dzW3smNwcNx8MdlcQcxV0uV1PhUEz3W6ABr3JiIpr3Nf4Bwv9fyqrnlozoqJ4W
	568obdFAeDQbf6lWmkkuZsJ4l9LgTZGx76dvUx9Elh40uK7g5c3Ol7ULbBo9FryhEZbbIPJ6gt2
	cUVsdJ83zrnDPDDgSOC8Pwos5X0VLOhZvMedrJRz7k1ei58AjZJFVxi2dnG5iLGJVrly3g0JGFN
	NCKTKSPxENC54z/x298GZF5wCQFFxt5xVph5gvWhzJXepu29ltwLGsLcM2iIuh5e5K7cJsFHI7D
	A4FQ6lClpk8LUEho99KHYbg==
X-Received: by 2002:a17:90b:1fcf:b0:37e:a40:e71a with SMTP id 98e67ed59e1d1-37f81594261mr7017629a91.14.1782697533953;
        Sun, 28 Jun 2026 18:45:33 -0700 (PDT)
X-Received: by 2002:a17:90b:1fcf:b0:37e:a40:e71a with SMTP id 98e67ed59e1d1-37f81594261mr7017618a91.14.1782697533423;
        Sun, 28 Jun 2026 18:45:33 -0700 (PDT)
Received: from localhost.localdomain ([208.115.228.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37f464b5dadsm4464301a91.5.2026.06.28.18.45.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Jun 2026 18:45:32 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2] MAINTAINERS: Update Jason Wang's email address
Date: Mon, 29 Jun 2026 09:45:24 +0800
Message-ID: <20260629014525.16297-1-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

I will use jasowangio@gmail.com for future review and discussion.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- Add mailmap entry
---
 .mailmap    |  1 +
 MAINTAINERS | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index 23eb9a4b04f4..e7e639aeb23c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -373,6 +373,7 @@ Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@opinsys.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@nvidia.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
+Jason Wang <jasowangio@gmail.com> <jasowang@redhat.com>
 Jason Xing <kerneljasonxing@gmail.com>  <kernelxing@tencent.com>
 <javier@osg.samsung.com> <javier.martinez@collabora.co.uk>
 Javi Merino <javi.merino@kernel.org> <javi.merino@arm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..40d9641cbc7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27520,7 +27520,7 @@ F:	drivers/net/ethernet/dec/tulip/
 
 TUN/TAP DRIVER
 M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 S:	Maintained
 W:	http://vtun.sourceforge.net/tun
 F:	Documentation/networking/tuntap.rst
@@ -28512,7 +28512,7 @@ F:	include/uapi/linux/virtio_balloon.h
 
 VIRTIO BLOCK AND SCSI DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Stefan Hajnoczi <stefanha@redhat.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
@@ -28541,7 +28541,7 @@ F:	include/uapi/linux/virtio_console.h
 
 VIRTIO CORE
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
@@ -28619,7 +28619,7 @@ F:	include/uapi/linux/virtio_gpu.h
 
 VIRTIO HOST (VHOST)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
 L:	kvm@vger.kernel.org
 L:	virtualization@lists.linux.dev
@@ -28634,7 +28634,7 @@ F:	kernel/vhost_task.c
 
 VIRTIO HOST (VHOST-SCSI)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 M:	Mike Christie <michael.christie@oracle.com>
 R:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Stefan Hajnoczi <stefanha@redhat.com>
@@ -28674,7 +28674,7 @@ F:	include/uapi/linux/virtio_mem.h
 
 VIRTIO NET DRIVER
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
 L:	netdev@vger.kernel.org
-- 
2.54.0

