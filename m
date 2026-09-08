Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA637A846
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845983; cv=none; b=UsuLpnuIqsASZq/qHK0QfZ+tbRwKkpnmRIuYMe6lVx0RdmZG/2Ceyhpi1NpBkTifzn3qUpmAN+loqTTXF3xi1kX9c7TeAgOdIdPWUCxoaQO3snSpGnvWKe0Uncxx2PllkPemZ/WFFxExBzS6rHDOHxmy2TYjd0N2fAe7aTNz2YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845983; c=relaxed/simple;
	bh=TCgPEL0DIPtoJrnu9N8c+v3mKdDbypOHTaZzZn4UrHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f15E/MByp1hNNJbAJLWG4TbPxc40uBkUezwpVzSgVvFB7x/3BzeeIo2J9T6AIJw2JjzzPVGmMYZxI2Q2j7HyrvnBhxKbTWT3/2SPPVC6qO73LIFm7sHkWsaA4SaPW788AiLr+zQsspaBo4hQiKENYFlmB2WYsViKCoBEn16SqaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohgUi+Bi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohgUi+Bi"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so42196695e9.2
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 22:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845977; x=1789450777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=69M0Zjk6fuHd53vao9gFafQcNB6wevMJ2l/Q6J8x1Ec=;
        b=ohgUi+BiQmHpomizhYpg/IL8m5w9FmnfjscMHO+przxJ8Qe1B6b5bg3eb65wG17s+g
         se4F04vsyZ8HCCX5a9+kqNJ4vaM/yDuchrC7DVphRwPzLcreEOqHSZYC8adxZPk4MNnS
         0auC1PCfRwDgEhxS6/1pxXch5ZDufyg9jS8fNBeVAusDBEN45heVHfMfxDE9A8kzGyRr
         eS0OkdH6QEqnXJNK1Dr47c+kG3JGlT+WPBvVY/+ohMuEz2tXlJncc522FT2BDXvfupV9
         F+2weaBwqSdE/Zrjl9bwvBxPCLxWoohT+ks7s7+N4K0mVNd9gxQUocb/8VTXNvO+9xpy
         yGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845977; x=1789450777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=69M0Zjk6fuHd53vao9gFafQcNB6wevMJ2l/Q6J8x1Ec=;
        b=X57SxBYtp4BiEGt16LRmOftsHY505Bl+77E6yYjqhI7H5YIgIUsPIKdDTnRCJCmSAI
         fs13VflIoO8o/qY/MUUwQeTh4u3BO7pEz+Es2JwvSiNjUzqdn2D5W5NfDqXHfF+uw/WS
         SebbIjc8GVOw5b/rzHLQVumH6DpeUvmamyQf6NiZaVdDpX08ZYLRVPVDZdoo6uotIW6C
         ylbXvxuSx2RTEpYVNd+ooGZJBMxmJvRh2A7J1H51m6bXIGDNyuyPxZd66N6i26r+l/f+
         zikWfp34GJQg6deXXZD7HjZ9AVV5Q5RH1lqOrCgH20jLwUkDyGIDqMoGvTgY+Nky8j3x
         W7RQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOG49oO083XaR/ukVvhCdCSY2gjw7a8Dqa0Ra1itL805pZmb7pN4oVtWA0PnnVWHQDwsQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nlf94zLyWS2/0dqYWy0Kx0+idhTAxzrl1OsNFp3tRSrzpWJSqY
	Qw9rE+fHFfLhVG4qhiWeo2naWh/Nx/VzX/q9lCn1rcJ6MLAbmvWslNbS
X-Gm-Gg: AYBFou2UOyk+a09r8HUhDVPl2jUPp8kVHB4Tr7wxEZGI82xKZL2HFWh+I1VT/DKODy5
	OccWfGUyfxKM0A1k63gImVeyh+2wv4FM4gVkjJE/FVevaK7D3M0FhDZGLWKRPIpAQ+g5IzTLJLg
	+CXc7IQ/qQygdtPzn/MOFxXpkBN+qCb5rpWoFnHYcoDNu36q2z/Z1SsJc3B96q3Gtd8DdYZ2jBv
	ava9rZHGCjnPBPORgIGX9ubnpsYZcaKe1dlDcUBwWWqEtnQDpvDkqOLQ4z6p8gq01wFYA17v9Qr
	Ox2DshEzFIB7g1/dkDsQUfscQHkorJMzhFCGQwFPWZJkGOc0P2r04pfUfgIj/sglN/+3Sm6MkSZ
	gq2J9bEdAHmOroseOIyxuPVdeCpvlXB2vBYS9EJdkghK06yGhzLANC10lbh9eSLbBJRCAey4+bQ
	/Duk8g0F/jcBdm2jlQT8U86JfsS0WSjVE4N9+1qdXa49AhDh0/Tyozv9K5+cTN5yksx6lcd0zp5
	Zz1P4vOPc7fTOd1Q8zQUrm3c5hyDucmauiGdyyV8vE89WGyJDgN/1ey3wnwV+M2mWKboJReEVas
	GuLMz6tJPFbMV3e/QEbSBXXKNTDz8CPH6VtP3t3wiQ==
X-Received: by 2002:a05:600c:4e46:b0:49b:910c:7703 with SMTP id 5b1f17b1804b1-49cf823f160mr260148885e9.9.1788845977155;
        Mon, 07 Sep 2026 22:39:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:36 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
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
	linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 0/6] virtio: fix and add callback synchronization hooks
Date: Tue,  8 Sep 2026 07:38:11 +0200
Message-Id: <20260908053817.26065-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the callback synchronization series. It is based on
Michael S. Tsirkin's linux-next branch at f49e6cf91942 ("virtio:
synchronize callbacks after device reset"), which already contains the
core change and the virtio_input teardown reorder from v2.

Patches 1 and 2 fix two bugs in virtio-ccw's existing
synchronize_cbs() hook. After a fallback from adapter to classic
interrupts it selects the wrong lock, and the classic interrupt handler
only takes the matching lock when notification hardening is enabled.
Patch 3 adds SRCU tracking for remoteproc callbacks, which can sleep.
Patches 4 and 5 replace the RCU fallback with synchronization against
the UML IRQ and the TmFIFO callback locks. The fallback already covers
these IRQ handlers and spinlock sections. Patch 6 adds SRCU tracking
in virtio_vdpa so callback synchronization does not depend on the
context in which the vDPA driver invokes the callback.

The UML, TmFIFO and remoteproc reset paths do not themselves prevent
new virtqueue callbacks. UML and TmFIFO only clear a status field, and
remoteproc does not wait for the remote side to acknowledge the reset.
Without notification hardening or driver-specific teardown protection,
callbacks can still start after reset. The new synchronization hooks
do not fix that. The TmFIFO hook also does not synchronize with the
rest of the FIFO work item outside the callback locks.

The virtio_input loop change from v2 (continue instead of break, so
events the device already completed are still delivered) and the
event buffer leak are sent separately.

Changes in v3:
- Rebased on Michael's linux-next branch. Dropped the core change and
  the virtio_input patch, which are there already.
- Split the virtio-ccw fixes out of the core patch, one per bug, and
  the transport patch into one patch per transport. The CCW and TmFIFO
  changes are functionally unchanged from v2.
- Patch 2: added a Fixes tag and described the existing shutdown
  case. Removed the dependency note on the core reset change.
- remoteproc: read the queue pointer once in rproc_vq_interrupt(), and
  synchronize with callbacks in __rproc_virtio_del_vqs() before
  freeing the queues (Sashiko). Place vq_srcu next to rvdevs so the
  hunk also applies to mainline, which added attach_work after index.
- virtio_uml: compare against UM_IRQ_ALLOC instead of a bare negative
  check.
- virtio_vdpa: use SRCU instead of a per-device rwlock, so the
  callback tracking uses per-CPU counters, and cover the config
  callback (Sashiko).
- Rewrote the commit messages. Corrected the RCU fallback description
  for UML, TmFIFO and the vDPA simulators. Dropped the claimed simulator
  reset race: the simulators disable bottom halves around virtqueue
  callbacks and serialize reset with the worker's mutex.

Changes in v2:
- Moved callback synchronization from virtio-pci into the core, as
  Michael suggested, and added the missing synchronize_cbs() hooks.

Testing: the changed objects build with W=1 without warnings, with
clang on arm64, x86-64 and s390 and with gcc on SMP UML, and the
patches also apply to current mainline and linux-next. The runtime
tests from v2 were not repeated on this version: the input, rebind and
shutdown checks on arm64 MMIO and x86 PCI covered code that is
unchanged here, and the remoteproc and virtio_vdpa hooks have only
been build-tested. No remoteproc, TmFIFO or s390 hardware was
available.

v2: https://lore.kernel.org/r/20260905152059.89560-1-kmehltretter@gmail.com
v1: https://lore.kernel.org/r/20260818040433.66986-1-kmehltretter@gmail.com

Karl Mehltretter (6):
  virtio_ccw: fix synchronize_cbs() after interrupt fallback
  virtio_ccw: always take irq_lock in the classic interrupt handler
  remoteproc: implement synchronize_cbs() for virtio devices
  um: virtio_uml: implement synchronize_cbs()
  platform/mellanox: mlxbf-tmfifo: implement synchronize_cbs()
  virtio_vdpa: implement synchronize_cbs()

 arch/um/drivers/virtio_uml.c             | 10 +++++++
 drivers/platform/mellanox/mlxbf-tmfifo.c | 15 ++++++++++
 drivers/remoteproc/remoteproc_core.c     | 12 ++++++++
 drivers/remoteproc/remoteproc_virtio.c   | 37 +++++++++++++++++++-----
 drivers/s390/virtio/virtio_ccw.c         |  6 +---
 drivers/virtio/virtio_vdpa.c             | 34 ++++++++++++++++++++--
 include/linux/remoteproc.h               |  3 ++
 7 files changed, 102 insertions(+), 15 deletions(-)


base-commit: f49e6cf919425cc55f10fd7cda7e0fc895df4cc0
-- 
2.39.5 (Apple Git-154)
