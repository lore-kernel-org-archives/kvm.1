Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492830;
	b=plUL4HdV2trh48qhEnk91MGo9pxFlhlPM8b2SK36Q133U1jpxpZti1MNraHhIR9fT29k
	 Wbb31JdbDVO84L/hfIVnx0jZkGsnoi9SAA+XOE7sDxN5a4Hgc9jnI3R89V6TkV0lqjCPq
	 AXNRWpeQUIesmt2fQ2owPiYm2xtx4LX6q31tIlOFd41eKsH8O5qkOt5eIfrLFh/tvBtDz
	 OEfv5g379WvoLcefzylhPVjPmxhsR4+2efH1XShkLtdvp7UrZgpZcScbjTmOs7tWbLTB9
	 83PT/su+tDgpoiklXIAq+dCViZrWSDumoe6LMD4PlnPX14fxfGFP12CBLf9xpjJWgvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492830;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:X-Mutt-Fcc;
	bh=VIDP3nx+FxbnMIBjBfYFZNsQEwlHUezNmijwKASBZA4=;
	b=kZUFTL3NX4MqdK/4DxgMPsdd6qO2wAT199qBXY4FvoJda9yijhg44nDKU5ODgJO49Cyb
	 W1iTxiuaCWhyDmb4EsGJq3Fz659NM4NBd3pSRMORsSVdUL9Iy/eBsWa1PEd1WsZ2SRopJ
	 dLbT8pSFQwoqnKH+cRuTSrnUtE+YBGo/HNyal8x0SRYxY6yiAmPzG3WWr7SCMxWicVr4n
	 hUeUMvZNXlRl9Lk/hu9JG5zJTRI84Oj5tL9cWFxQBwQhzd8MOukOz96NUFZy+HdlZ16QW
	 is8zUi/t6C7hbNza/BOw+Hi7s/8CULHlxBUjy9PJu8S3iqPeuN77mfs/tE2/quUHj8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RmdHq4N7;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MabU5TfZ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4C606A31D
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94E4C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RmdHq4N7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MabU5TfZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792492828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VIDP3nx+FxbnMIBjBfYFZNsQEwlHUezNmijwKASBZA4=;
	b=RmdHq4N7uHME6HBybqJQuPI3oaUxpgLWAL0fiClnHcx6Fgu09FS8E1LXsuI76+3nWbcK++
	Hpf0l2raqDdKuTwZvOEKmcfhngdxVqwUWpzVkwOjb1cGTRKBAbGrKc8WIm/3yAQrZZFcsF
	Lbnp/7aEfhgIuF0E+gpPABJ5xlo84gc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-wQGM-MBgN3iBFWELyCk5NQ-1; Tue, 20 Oct 2026 10:40:27 +0000
X-MC-Unique: wQGM-MBgN3iBFWELyCk5NQ-1
X-Mimecast-MFC-AGG-ID: wQGM-MBgN3iBFWELyCk5NQ_1792492826
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1de9dac94so19990295e9.2
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792492826; x=1793097626; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VIDP3nx+FxbnMIBjBfYFZNsQEwlHUezNmijwKASBZA4=;
        b=MabU5TfZonnq5TntfkPQWhWGO+2UMdIlT2+GY4PWW/ZAaI860X3HZpwjka0lZo8jXn
         vEZ9Nw2LWW1eXuMa+u2L0MA936C+BErZKwZjxsZfznXQNnSBeHjgszmoq+bdcyuO25P5
         RKMiLAshO21FIY4sGd2gJs+ZY4Aq4B9Yke4Ak+OExDrfNIDujAx5bz9VhrP07JgLtkjT
         it7F89YFaJ8MtWW9NZV1TGMDJKfbYqJ7uPxBqNa5R02+peIRUxUe+43I84GeVd3ctCtL
         gnxYqyM5TVvLki0SWSga3qBvMMArEToyOQ2MxTxXsC/RlYXUnx/PtPrbPa9P1PZwWIvn
         mbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792492826; x=1793097626;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VIDP3nx+FxbnMIBjBfYFZNsQEwlHUezNmijwKASBZA4=;
        b=nuYJ+6fzdcn3FEf3G/fhObvSlQctk7nchDOoW25x5sRIZzhC9GyAlKPDIbQ5st2WQc
         MdFTwzKdT/Ar/tnXQMbno+Nrn5d/wFfkhT4UHBCrJQSt0dC7rxaAaliu8x2+OxxPVvCT
         1xdKY1sZX18fG4tdgWyr2M0Aa+WoFlg4A1dD7WYACTgnh5XEdR7DMLDxzIZLrhboncWV
         KcxiMskaDc067MkZ9pYzaI1b5ZnV2EZz0HiluXYhpa5CpX6sKR7JV0pH6Vjc8asVxR82
         s4WYCklmWH43CGBcRyh8EwXBo8Sl+pwoKdensYDfpki3oMRuvfdiotCtsTXkSkCEq45b
         7PLg==
X-Gm-Message-State: AFq9FYKCCiilmcNf9Vz8DQJzWx8vIMqgLBUNk+5UpM5pkhOsCxioWLBY
	W0ANGOe+mQPA30FVLlx9h5htyjfMlY7svo6DY2mt1U1EpCwB7EHLDQEgS1JAD5PDjvN2aZGmhVG
	JMjnAI/41Kyz6L09gOup04YPtSJ++9ukF38vqvIFjrrFYWnuvtv6gXg==
X-Gm-Gg: AYBFou2CCM6dSHicETSbqqJ3IYhU/YuDIDHqjw0KcsiYHLJQx48QUTU0rkzrbmdK/Gy
	uREttg9ia2wHuGOeLSTAd6xGVPgULFw7+J9dI+vYS4yDVIJxN8qgoiiE309QWWg94uzJLkmHIWs
	JuQq/CamU7aHnMIykrN3DBJSXvhlr8u8OesJlNWSEVLox3kjWg728SPW8dZ4rYqdKMxkF/r8wnj
	+zPuwpyH3agoAFnyXVAd1d24hZi4goAqEoClWCKsGjzIzWtZ2U/XnfJEnv2uny6gUfwVYht4tHZ
	/htd0WzcVdlYLIChw+dOk88IYazBYXJbSrcLw6xrQTWw9S2gS1byzs2n0Qoal7yqKHrx2g==
X-Received: by 2002:a05:600c:1c19:b0:4a1:ec5b:dca with SMTP id 5b1f17b1804b1-4a1ec5b0fb6mr118201105e9.15.1792492825853;
        Tue, 20 Oct 2026 03:40:25 -0700 (PDT)
X-Received: by 2002:a05:600c:1c19:b0:4a1:ec5b:dca with SMTP id 5b1f17b1804b1-4a1ec5b0fb6mr118200305e9.15.1792492825235;
        Tue, 20 Oct 2026 03:40:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d6dbf12sm5345167f8f.1.2026.10.20.03.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:40:24 -0700 (PDT)
Date: Tue, 20 Oct 2026 06:40:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrey.drobyshev@virtuozzo.com, den@openvz.org, jiri@resnulli.us,
	kmehltretter@gmail.com, mst@redhat.com, ptikhomirov@virtuozzo.com,
	sashiko-bot@kernel.org, tanglongjun@kylinos.cn
Subject: [GIT PULL] vhost,virtio: fixes, features, cleanups
Message-ID: <20261020064022-mutt-send-email-mst@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

Hi Linus,
I have a bunch more fixes under review, but let's get this off my plate
first. Thanks!

The following changes since commit 48a4ee65e677559776349128e6a81a6041986c99:

  vduse: return compat ioctl results directly (2026-09-08 03:58:27 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to c69023b5e16e5ffe9368603dca76d85bd544ee57:

  tools/virtio: add missing device-id/virtio.h wrapper header (2026-10-08 18:30:04 -0400)

----------------------------------------------------------------
vhost,virtio: fixes, features, cleanups

This adds CPR support for vhost.

Plus some fixes, notably for a host of races we had when callback fire
around device reset.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Andrey Drobyshev (3):
      vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
      vhost/vsock: re-scan TX virtqueue on device start
      vhost: synchronize with RCU readers when freeing workers

Karl Mehltretter (6):
      virtio_ccw: fix synchronize_cbs() after interrupt fallback
      virtio_ccw: always take irq_lock in the classic interrupt handler
      remoteproc: implement synchronize_cbs() for virtio devices
      um: virtio_uml: implement synchronize_cbs()
      platform/mellanox: mlxbf-tmfifo: implement synchronize_cbs()
      virtio_vdpa: implement synchronize_cbs()

Longjun Tang (1):
      tools/virtio: add missing device-id/virtio.h wrapper header

Michael S. Tsirkin (3):
      virtio: synchronize callbacks after device reset
      virtio_pci_modern: move avq cleanup from reset to del_vqs
      virtio_pci: drop callback sync on reset

Pavel Tikhomirov (2):
      vhost/vsock: split out vhost_vsock_drop_backends helper
      vhost/vsock: add VHOST_RESET_OWNER ioctl

 arch/um/drivers/virtio_uml.c             | 10 ++++
 drivers/platform/mellanox/mlxbf-tmfifo.c | 15 ++++++
 drivers/remoteproc/remoteproc_core.c     | 12 +++++
 drivers/remoteproc/remoteproc_virtio.c   | 39 +++++++++++---
 drivers/s390/virtio/virtio_ccw.c         |  6 +--
 drivers/vhost/net.c                      |  4 +-
 drivers/vhost/scsi.c                     |  2 +-
 drivers/vhost/test.c                     |  4 +-
 drivers/vhost/vdpa.c                     |  4 +-
 drivers/vhost/vhost.c                    | 26 ++++++++--
 drivers/vhost/vhost.h                    |  5 +-
 drivers/vhost/vsock.c                    | 89 +++++++++++++++++++++++++-------
 drivers/virtio/virtio.c                  |  2 +
 drivers/virtio/virtio_pci_legacy.c       |  2 -
 drivers/virtio/virtio_pci_modern.c       | 15 +++---
 drivers/virtio/virtio_vdpa.c             | 34 ++++++++++--
 include/linux/remoteproc.h               |  3 ++
 tools/virtio/linux/device-id/virtio.h    |  2 +
 18 files changed, 215 insertions(+), 59 deletions(-)
 create mode 100644 tools/virtio/linux/device-id/virtio.h

