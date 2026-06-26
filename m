Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36EC27FD75
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782440456; cv=none; b=eFnjm9GqsisRKpaXdPrFUgzXBfP+8u6wtV6Thhh1wkyTbc2qkTtgaSTqctSR9ARbCO6gkWzBO2dhZNOsoaFtuXNp0v2wfmAkhmSki06UgIW3q9oAas8UHvRpQYSnSzWHWDnfDET330GJEr7nWjhqIIGtCMNvD/BRx0fec/DO3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782440456; c=relaxed/simple;
	bh=gHGXhrZOWUzF27PW7grMsw/KKp/8O4H77hQXuFerhXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=NFFiFwfXdH/V7TWY3t4a2Nm3BA/Kc2SvmfVbiqW4PxgbD+E6w2OlZh5gvnOmulD5M6fTbSn2Rv3ckdR5zEhYZ4NGs+pF/KM3eCQk7kIJ584EOOhlEneq70ZVB4efes36WDjbmccigoKv4Sh7QkHc19eY32uUG5N4gIpkZmsVHJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgwVNOx2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ducSIqfj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgwVNOx2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ducSIqfj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782440452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OxGcjxwlLcC8nEz7JDYi3CbjxSnldr+NBxZJ+E8h6AQ=;
	b=PgwVNOx20sWZsSxq0jG0Ge4XMuwT1TmvTL01em9ckk06ZRvIGTh5ekhraRx7vRaTN6DEP0
	Q1JSE7w6vaomDIawoICgw14uEd/yRH3woasWwJCVfv1rMBdBTzpGgdgwLVPbMibci2ncmL
	5E+Jlcc1LTzI7UOaVKLJM/XIEyuRviw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-Ivvp5KueMqi6H12s_TFyNg-1; Thu, 25 Jun 2026 22:20:51 -0400
X-MC-Unique: Ivvp5KueMqi6H12s_TFyNg-1
X-Mimecast-MFC-AGG-ID: Ivvp5KueMqi6H12s_TFyNg_1782440450
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37e0a18a511so303529a91.3
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 19:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782440450; x=1783045250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OxGcjxwlLcC8nEz7JDYi3CbjxSnldr+NBxZJ+E8h6AQ=;
        b=ducSIqfjmKIM+oTbaloCJ/yM8WwITncJLlv/ltZwbSvo9cKqbdibfsf8uI7nwAQmRa
         7svGdkB7iscYMd9Abq9BPBt3JoTK/3ng+uVVGNMjdIJgBUCj041L27zPFmRdZ+OYe5xK
         gdmOk8Wd8GD78mtR/t/OhWrORKrNH/53oo9YH2pdJqhFxNyAkMg7FXZWRxArtRqpylz+
         89RTyxtvwt3YEExrga+npuW0gVbqexLHzcAHBP0fB/s0bUiK8MaymJWMOsejA+Hjc2Fa
         rzj/5w2Q9q2glwI8sJTYByPkhUvwFTVcTFwsCBHslm06gxmWX9C0gdYxfgpe7GDifA/n
         cuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782440450; x=1783045250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxGcjxwlLcC8nEz7JDYi3CbjxSnldr+NBxZJ+E8h6AQ=;
        b=aDLlZqU486rFZGMr+Rfr6wawFvCQZTMj0cwpJ9RHc7nRKfZvBX/4YqzH6IOzzEMNVi
         J7LyYoLzjDhrHdna24vjR9rEpoqT2ioLeDLInmg8QVVyyKvOdhQQc2wBNl0oQUolenXU
         SHboT3SN1I6YscrbM80U8MouI5D31DjxnArIy8BA1daVsTZ1oddLvsHdOYS/Pi3jjOYe
         GGN0r/MLGVvzQHepO6p6rUwjbLEBeVmKBUP9lhje7LmSylrV8BNPGoVfgrntmJvbiqsX
         zHaXYRFdE0T294zED008SkPQWfVhFDAUuPbvnLwXKr6rqP8Mh5seIGgN0Oba9q3dUdU/
         5GUg==
X-Forwarded-Encrypted: i=1; AHgh+Rq8fgXu+LORubYKMFvlTCfcKl1waWmDIXEtkYDDOhjSq5HAatyDwqvFNKLuXf25vlPUalo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Vzb8ejcYloWFd1kvbpuMWLfPrKYXaJaDjhDwa7MvajE9LzSI
	Ibk3h8jVBABRFORn9vHY7Cq4m8eaaZBGouJcZmLpfO8Kf3JARkDh/fEFQwfAEz8GPVxrnq3NF+Y
	NZ3LKCWzUslTB2ew0jZW8EYXewNLXsLGxLYoxlIsvYIcGAIzZcJ7rOg==
X-Gm-Gg: AfdE7cn/3//Ve7LrLrZ5BT6lO8GuBtEN7RLdanAo+pnZglUJVxGxdTJy/JrlPgm8LSr
	TwJJSJeL6kdmmx5V0ESoP0ETM+ZcXVTrzvNL2m5rQ+U6G/hp4yMM3SKPXKcN+KSgTipUySUMleB
	4V3IUTaqojg199BsZP20KxalItTfzrKP6B9sscj1iwRwDZBJWnyNWUuxbaJ67uT5qj6kRK8Opaa
	ico5JS49xBtP/LJrgCMDAJ+5zHasRE1rdgMCpHeuAU9hscM1gVAhIO4Wd3Tq3+EYxvbBCszc1dX
	8AOCcZgTnVU55ZoGsGRKMRkSC01ZrlUj9p0IM3WOL1ALj1Dve6vwLz2t4MB/z64MGJXIH5z7d+2
	b+7zCJ2Htmao1M2wKfOzfhg==
X-Received: by 2002:a17:90b:4fcb:b0:36b:7ad1:df70 with SMTP id 98e67ed59e1d1-37dfa19c345mr4397824a91.2.1782440450096;
        Thu, 25 Jun 2026 19:20:50 -0700 (PDT)
X-Received: by 2002:a17:90b:4fcb:b0:36b:7ad1:df70 with SMTP id 98e67ed59e1d1-37dfa19c345mr4397791a91.2.1782440449574;
        Thu, 25 Jun 2026 19:20:49 -0700 (PDT)
Received: from localhost.localdomain ([208.115.228.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e058a010fsm1284571a91.7.2026.06.25.19.20.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 19:20:49 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH] MAINTAINERS: Update Jason Wang's email address
Date: Fri, 26 Jun 2026 10:20:38 +0800
Message-ID: <20260626022039.96139-1-jasowang@redhat.com>
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
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

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

