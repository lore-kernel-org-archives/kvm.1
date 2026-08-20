Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D03C3F7B
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213066; cv=none; b=Q7VGpeos27rhLBO4gQ7Dlk8caNEqely2Vj5Wms0eOfTp2EQxn0bEjERSOVRATfLtd875AwLV3nK4CwB9kiqa+hw5BmcpbSuf6FI1GQMs0BFnjkTm4ERYPP7jv48/1g1/rXTmZqTw4S+jpiDnom50qdbvUJsZXaxvSslqFsgydGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213066; c=relaxed/simple;
	bh=ru4qweuJqGlhKUthy5/6S5+Rr1FUsZoR9Bxo6pxBe84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WdgvOnQsazeatUFwEG47D4aJfrLh7FfL8lSrwE8YTgQI8i95I6d++tZpROUkBhjyB2tr5qtv7t7EfUSWwvdFbiBbY1n4ZUQCrCEO4Qd7TwDjDxjvO2M+F4QdjHB5TmTwSMUebVqql02O7g7VCfokO01qUKm2Mjm4M3p2N80pmV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWGuLFLL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWGuLFLL"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cab973140bso23473725ad.3
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 01:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787213063; x=1787817863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x78ErVeCRHN6nIR5BE2bLaNonVUmCkwh6pqCr+oiUKE=;
        b=dWGuLFLLZEHINFCmRVl/uuhojokA6rfZWuDUqiyBBNXrK/SzTAQ+59pPbGpdNCCWu9
         WbQPszq+BbQxq0yUfJGmIKh3VJqlk9DzJkVGWc+cY6xfD0lzQFMM31zkKZW74qEMLmq7
         mFV+lvRJwUdwZQnStAOgr7j+K5QP6iEnPJpDfcoHu6h/ZKdMAn7bOcrlw2LwLKtHkb4J
         r+6F+Hqih4v6ZXpImURcasZlGZhbeuHlevRLAY4wwiRfvzt/FSYckTv/C5L8B1cTPrvw
         oQaZ0dJUheX9x2F3PpQqCYSxT4o4jm3OnTLbU74VFPkvb9XYHOFK+4u/lCRv1OO3G0/v
         N3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787213063; x=1787817863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x78ErVeCRHN6nIR5BE2bLaNonVUmCkwh6pqCr+oiUKE=;
        b=cZFBghXorzlL45SHwQafVBl4NRNiGXQeM84kM0Gnzv71byVVp0AWefxGdKq/SP6cTU
         FGD/WTm8BcJYKm3OrHR/05EukBQJRXiryzq7hCGHUVTK922RG5HL8wOGQYcALIfGi4QK
         S1TNn1hvMFtdqMAj71lkCcffqSNXdSHTYp17emDaa8tiwTN/90mSnuyWAtm+sVBamAjD
         jGhHiU9MKnYEo7GxAPLLmNN65E58p18ijNVj/TnDV45n/n0Q1iVo0DR5+kLbiv5DQnTF
         pU2Ld3Sau8ygjfMGhUy5CTWluF/9HEu6TZOHKCiZbnK3za4wbXbeBtbZpSdgyltOVmjV
         FFVg==
X-Forwarded-Encrypted: i=1; AHgh+RpSXrAQw4zi1RNfht7lIjVuKGOeFlmg6Cc0FSVvgv73gvEdKQmXgaSubL0G3JVBlhdjAKA=@vger.kernel.org
X-Gm-Message-State: AFuF++ni/rTRXUJL9jPSgnNuQyEY9GmWKAUaC6TebjL01feDbpZpoxUK
	JkBu+Q2WOIf9zfaBa2NLFlqC2SZvs/abXfhmfX9qQWyuud3KoHomH9N9
X-Gm-Gg: AR+sD135KHOWKljp7soFVkCJfaPFS3pZso4guDggi8R6BfYUAcKTRS/XthYQ1WCTrOK
	xa3ndZLYQTp2Z/lsVdDPQ2BFSA6E1cNeAbXCBxSZFzo1HOmUuCvD8RUuwuKcqGYzYh6mr/uZsyA
	2Vkm+DuPVxk8w9WfCuR2wZRYMwkFu4WI+Kgym7AN2ebJbcQMHqoVGAT5xoQn5/F8bP6xYNDuwv/
	wKq2mRCJYuWCijdVBTmtJnvXxWZX6f5jPYuQc5G+FluD4JodtKnZqv1UoiByC7rS/5i0BtmmT7E
	DX7E4zf4O9rkgN/JHVQ5kP6pwa+syFBOUZsawUKL5PtapES2El8lb0SrI9ZHugpg9QCXqzrIeUs
	fIUHVQ1a6LHQvHpD88LgPhLAtLrZPu4DbfV9ujBZy/yGt1e1xc/+V6Eezz2k2l5PwIcOKRQ5TcS
	lrtualie62pxZa2rWMNxE/SR507DW3RkeczWIOuHdk3H8QWSIzInDu5pJ4PcdDtk70ukSICQ==
X-Received: by 2002:a17:903:3887:b0:2d1:1a18:4d0a with SMTP id d9443c01a7336-2d5fd740167mr200442945ad.9.1787213062229;
        Thu, 20 Aug 2026 01:04:22 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36e175sm3556075ad.50.2026.08.20.01.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:04:21 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] vhost: fix device IOTLB feature lifecycle
Date: Thu, 20 Aug 2026 16:03:29 +0800
Message-Id: <20260820080332.313933-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both vhost-vsock and vhost-net can leave the device IOTLB attached when
userspace clears VIRTIO_F_ACCESS_PLATFORM. They can also replace an
existing IOTLB with a new empty table when a later feature update keeps
ACCESS_PLATFORM enabled, for example when updating logging.

When the IOTLB mode changes, the vring addresses previously supplied by
userspace no longer have the same address-space meaning. Leaving those
addresses installed would allow an old IOVA to be used as a direct
userspace address after the IOTLB is detached.

This series invalidates the vring access state during IOTLB transitions,
makes IOTLB initialization idempotent, and uses a common teardown helper
for vhost-vsock and vhost-net. IOTLB mode changes are applied even while a
virtqueue backend is attached. The device-wide IOTLB is dropped first,
each virtqueue then clears its IOTLB pointer and cached ring access under
its own mutex, and the old table is freed only after every virtqueue has
completed the handoff.

A successful live mode change leaves the backend attached but invalidates
the cached vring addresses. Userspace must configure the vring addresses
for the new address mode before data processing can resume. When
ACCESS_PLATFORM is enabled, the usual IOTLB miss/update protocol
repopulates the new table.

Changes since v6:
- rebase on the current vhost tree;
- remove blank lines between commit trailers;
- drop unrelated error propagation changes from the backend patches.

Jia Jia (3):
  vhost: invalidate vring access on IOTLB transitions
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared

 drivers/vhost/net.c   |  2 ++
 drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  1 +
 drivers/vhost/vsock.c |  4 +++-
 4 files changed, 58 insertions(+), 2 deletions(-)


base-commit: b282418bc366194677eafd1dad180d92254586ac
-- 
2.34.1
