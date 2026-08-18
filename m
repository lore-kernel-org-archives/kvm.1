Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4653D339714
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787027193; cv=none; b=QdDMXliJz6pq3U154baJga9PMl18gbeI7tUOwZ0UzOqXfpJ/xYIUlLkc+j4OvGqOQyrikCSvZ8qOxGrl1sXDz+IZ3MgUY9JbYt6KaWhKGNoVwXFfp/LpB0dmYjQymOqLThKSqeRm77i7KOV46uhzq59EA4oM1TrtABDvftCI8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787027193; c=relaxed/simple;
	bh=0EL2LR7po/s9DUjjNqlWFSV+gjd+xJ1WILPheMV+JFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kCgd9c0snDRFDknzgIFhZgXD1TroevYEfSBJC4Bbfa1ctB5KFFwYjs6NLJ7fQQAaAc2SHb5DHgfeQsOwL9hP4HOS4zZDvXgCCquCUHVxmFZdVmVG+b4z4Zh6/TITA0ZPmwW0vXnlMc8lYwRAad0eNX2RSyeJpn5AD+eqIY/aH38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOqN33aI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOqN33aI"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so5434533a91.0
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 21:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787027189; x=1787631989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WjmxRYlcS6K8pKZdReOoWwINkSByDyWzsirONrxxVnM=;
        b=fOqN33aIBXf0FKQDGweWmi5sNbXbXR8vF7juCxZCb8dRSI93aXRZC5muYsJkv/aj5I
         Ao9PMk2AcVGsfyz2xoEvNdml4OvPQ/Wf5phH/xzl32h/aZedMzbL4wc8zkIA5TGSgYnj
         rEVUex20XsYevxPckd6iqdI7VBzWLpohEDJmeb7Zu6p60Gcm5hYv4jOFa4GqVHs1j6k8
         Hf474Tu73CvasonRW3WfH3pmqE/V7FrYBMjHvB69j//IkPjx84md1WOL+Rd7zjh8tSiN
         bF+y3jkCs6g60NL2OTHGQgy2o7SwAK4KBFJfFlGyqPPS1A5xpEsISfhiuUzXbGQq789n
         aubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787027189; x=1787631989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WjmxRYlcS6K8pKZdReOoWwINkSByDyWzsirONrxxVnM=;
        b=bD6fPqeVYekL2jANZBNh7n7l15djNKgbE/wPaSa1NFNrndjk8nJAQEIg9wCRd751Kx
         XOoRo2yd5okc4nlc3/42sKgLtN1bdwcNcIOD/9hSZZkiZ3IR/mMXeemGkWGO78HMTJts
         jEvPFXcD3Sy1MK6Ws6AasMkAnNBYsx/jxrwZ6IH+6VM1Pf7pRJNu8utrKgdwgJaiMRIE
         E2lBQVTx0Jgh96Kx43pIA2up3IUyFO3fgqkPdLuE3/6XNJKiODlbbcLfUX35GQi/UbSr
         4dKj5Tw+gmARssVYJOY7d7xaRHeqA8Dy7lhhD5Vns1cnf/m7BHQRQTpFuwrUWC2Dkl/u
         a4Mg==
X-Forwarded-Encrypted: i=1; AHgh+RpBUNY7YrTWMZKKhzMQas/LppDyJteS5kjk0FN1Q/EO3iyt2MkU6lKZYD9nUkm5txnJGcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ePiVbuqNumunZtMhH6oQ+kX5cYnNeTAb1huXHDqKDE9jL+xV
	kbG2oXMToxhfmyu7HwyFDm4P6sBFzaCnONdK0P+PBeJg6q/M1RweHlgN
X-Gm-Gg: AR+sD10aZ1RX3h6YKRNxxNZqR0yF1MYZFP8U4dR14dBlwtaoCppWC+s8CSI0HKTyTy5
	+Tmgl5q/n+HUPbDFeiQX6apVxCwwPIHvgMET1aPHb0YtAOAOs2QHSvLCX4rrSTxgApth+7eMJUa
	CjgsDH6qi1WbFUto/y9dQ4fo5g8TplDkn/ICvdNt+mZUmjWTA4fVPuo7yRD6UYIYfQy+PXkwZZ6
	UTyqlicv1JBvHMymPy6/FX6Ov5IjV+MGl71XpIazPxFdwVWgW4pJgs8JJpYKLYnAUyzw9RhCj6J
	m2ndir+8xDZHdgWT+W1L0e0lhDOn2Kmh18SQMDMWRchCcW2FtWhJ0EJjEQdRbg12GZgU00CahoG
	ETf7naFNtDk2uwbb52k5VHBmucVaDJsIFXhaZh02eASTDwUjxjNK6M3IYRa+JJCOUIkPXhlINLl
	70HoLdn1dfNdwCo7A1giBNzcWw2TZigdNo0GB5xATGjtDfkYao1pZ6W3ySWjragab2
X-Received: by 2002:a17:90b:1801:b0:37f:e1af:df22 with SMTP id 98e67ed59e1d1-3955aa0826emr5406167a91.17.1787027189224;
        Mon, 17 Aug 2026 21:26:29 -0700 (PDT)
Received: from jia ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d1b0143sm4527762a91.0.2026.08.17.21.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 21:26:28 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH v6 0/3] vhost: fix device IOTLB feature lifecycle
Date: Tue, 18 Aug 2026 12:26:10 +0800
Message-Id: <20260818042613.281125-1-physicalmtea@gmail.com>
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
virtqueue backend is attached. The device-wide IOTLB is dropped first, each
virtqueue then clears its IOTLB pointer and cached ring access under its own
mutex, and the old table is freed only after every virtqueue has completed
the handoff.

A successful live mode change leaves the backend attached but invalidates
the cached vring addresses. Userspace must configure the vring addresses for
the new address mode before data processing can resume. When
ACCESS_PLATFORM is enabled, the usual IOTLB miss/update protocol repopulates
the new table.

Changes since v5:
- invalidate desc, avail, used, logging state, and metadata on IOTLB
  transitions;
- apply IOTLB mode changes while a backend is attached, following the
  per-virtqueue handoff suggested in review;
- apply the IOTLB teardown to vhost-net as well as vhost-vsock.

Jia Jia (3):
  vhost: invalidate vring access on IOTLB transitions
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared

 drivers/vhost/net.c   |  8 ++++++--
 drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  1 +
 drivers/vhost/vsock.c | 10 ++++++---
 4 files changed, 66 insertions(+), 6 deletions(-)

