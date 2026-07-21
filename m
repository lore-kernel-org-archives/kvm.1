Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01BB434409
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619426; cv=none; b=ZgdycpXdaJVYbmllo+KhMZ2anjhP/qSvUXZFp+db8lkfMaqDdvAs3PEkfcyGgeKxYZAks0RpnpBnUQESgwisAqJ1CItafnn0JlU+mar6DOEroVQKAA/R4M1DYrs7yyL2X5/k7QrDHbReEYyT6S6vyuUjVyOC9SG9jttNATo0ZwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619426; c=relaxed/simple;
	bh=PBJgJTVktA6dk4pRBadGmyyYxpIPFy/6kLS3RcLYINk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C8JhihDO1kWLzUVKtjYda6NZHKiTiRPIUD9u6k7XdeFQCxEp63tq0jDbxT+dLv8z/zgqeNAZyVcUp/R0e6xgVKfVSMvHz8cg9hBm1WyWmJbbHSjQUly6agZg5btYA/kYdXKwEvSQGaD2bf4kaIgb9xHYNfnUAj+cxmYhKRnFpDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwTAeriS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwTAeriS"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dcbade417so9161482a91.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784619424; x=1785224224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=35d5h6tDV+eeR0qT67WDhTn7rqN/E2touheot1irCJc=;
        b=OwTAeriSR0SXhCuEDSNWf5ABehzQEn9lCc8GVy43GCe6hFM2R9V2ncGsrN++bWpUwO
         SWNCnlDguSyQZSuGqP7xi0v0l6N1HK2lqZysA75VAVBT/tdfX0BfGuC7z/xuylt6nCYL
         0302ht3PRiruJRMXJfgQBOISOY9o0Hlhn/KTMQKgs1mExLYR9/fwSd2/1GUYXeR2Z34B
         MuWE47wkKRAL7plDjFNwvbw5zCSVhldkCsazyzYl6VC+mawQfBL1dDqoASmHnVtKE/Sl
         OVH9gW+zHOJexdpJHq/MTBSGkLdYg4bOvjva/q9aMve9jZ3xRjJtMUqttCc9pF6BkBcr
         vf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784619424; x=1785224224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=35d5h6tDV+eeR0qT67WDhTn7rqN/E2touheot1irCJc=;
        b=TgWbl33RIRj9dWVG935Cu/x6ay4aoc6Bcd30MB6Dp6rwS8dXzKX2vQe0EARTJwk/lN
         VuE0NvkHTl0uyAie2WyYoJKxM49nWcWK587js8ILVrU0pDgdRG/vErZI0uFP7r+svPqC
         4kIwh/HWej5YjZ9e0bOPughae/0JHR6JY20JTmXCFIEqKDqzD0IhNfkHPxIfbwDuWVub
         9gG5csQzo0me7KHGVuYU2xbRrxat6VxvCnXKTQhIHQkkrVJvZtzf0lcss6m1OkS5lbmK
         qhyDlPH3QR0A6vMqdg0xJBl+rrwTW1P7S6LEeT5Ea9kgKlA7Y8LkLHg7/9kNVOlrZ0oe
         7Hdg==
X-Forwarded-Encrypted: i=1; AHgh+RpYYktUDqq5KY6sJx5tOhMVO4qwURBxhJMTwAnw1HJh94e8yuG74t4qulmbthzwDCealvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFkiHAMdAVOYPvXd6D4pG6Lm/t6LHuWU2zogBHdo9HMolbmg64
	eUhBhzh4oaiOInh7blNrQKC/p+0BnBw1/uJgmLr7X+NjeYoK10+/unaN
X-Gm-Gg: AR+sD13poyruZ3SsR2RyW702UARBnweORZgAI/NFevW0NiwhCC7DQ21SB7U71qdZ9gR
	OrITFBhKNMcONAALaNuosEEWUA3E72IgJw5FgZ3y8P2A3U/eAzeUVRehYYezobv0c2PE3BVi2gx
	DdJq2BFmeP3ZAGihbYgGlUXbJ8BOWEXwTLzRcLaUYKKqt+m5hQ0mJO5tKU8+Kn4NBL5FFd+pOuW
	MSM64IIoCSf1/zsr1g4LA2qZQDJ2CRYPsqpVB/hwGVaJuj5wtdk7ACaM5GX98fdgYnDU9MmvEaP
	DW65Bi5dk+mWsH9hV9RyeSrZxSZwCr44kkEW4TWK/ufnSkXngX3MuQS9yQ5uQuHTEfbEPt5nRMr
	hcNARYlVWZVqpS8Ul1C5Nw8h4K+P/eHV+whXqMIpWp4wpMz/whuJxNhWd7ZLrobC3hkFJqg==
X-Received: by 2002:a17:90a:c885:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-38e4b538938mr18875650a91.21.1784619423827;
        Tue, 21 Jul 2026 00:37:03 -0700 (PDT)
Received: from jia ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e92169cebsm1070482a91.11.2026.07.21.00.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:37:03 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>
Cc: Paolo Bonzini <pbonzoni@redhat.com>,
	Stefan Hajnoci <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH] vhost-scsi: flush backend after device ioctls
Date: Tue, 21 Jul 2026 15:36:39 +0800
Message-Id: <20260721073639.1532488-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost-scsi translates guest response descriptors into userspace iovecs
at command submission time and later completes those commands
asynchronously through target-core. Device-wide control operations such
as VHOST_SET_MEM_TABLE replace the memory table under the device and
virtqueue mutexes, but historically returned without waiting for
outstanding SCSI commands that still hold the pre-update response
iovecs.

After such a replacement, completion may write virtio_scsi_cmd_resp
through the old host virtual addresses. If the owner has already
remapped those addresses, the write lands on the wrong userspace object.
The kernel tree has carried a TODO for this since the 2012 split of
vhost_dev_ioctl() and vhost_vring_ioctl():

  /* TODO: flush backend after dev ioctl. */

A userspace test kept a READ(10) pending, replaced the memory table so
the response GPA mapped to a new HVA, remapped the old response address
as a victim page, and then let the command complete. The completion
wrote the victim page (victim_changed=yes) and left the replacement
page unchanged; a later TUR updated the new mapping instead. So the
pending command retained the pre-update response address across
VHOST_SET_MEM_TABLE.

That same 2012 change deliberately avoided a second backend flush on the
vring-ioctl path: vring updates already flush where appropriate, and an
extra heavy flush would hurt when kick or call fds are reconfigured on
the data path. This fix does not reintroduce that. The default branch
still routes unknown commands through vhost_dev_ioctl() first; only a
non-ENOIOCTLCMD result flushes. Vring ops such as SET_VRING_KICK/CALL,
num, addr, and base return -ENOIOCTLCMD there and fall through to
vhost_vring_ioctl() without this backend flush.

What vhost_dev_ioctl() actually handles on this path is small:
VHOST_SET_OWNER, VHOST_SET_MEM_TABLE, VHOST_SET_LOG_BASE,
VHOST_SET_LOG_FD, and the optional fork-owner ioctls when enabled.
Flushing after those is fine: they are rare device-wide control ops,
and SET_OWNER normally runs before any inflight SCSI work. Call
vhost_scsi_flush() so pre-update worker work and target-core inflight
commands finish before the ioctl returns. As with the existing net
pattern, any non-ENOIOCTLCMD result flushes, including failures that
may have applied a partial update such as VHOST_SET_LOG_BASE.

I later noticed vhost-net and vhost-vsock already use the same device
versus vring split.

This is a control-plane barrier only. Ordinary submission, completion,
kick, and call paths are unchanged. The owner is expected to keep
pre-update mappings valid until the device ioctl returns. Completion
copies the response and signals from the vhost worker without needing
further userspace progress, so waiting in this ioctl does not leave the
owner process stuck on itself.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/scsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..c3e8f1a0b2d4 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2424,10 +2424,11 @@ vhost_scsi_ioctl(struct file *f, unsigned int ioctl, unsigned long arg)
 	default:
 		mutex_lock(&vs->dev.mutex);
 		r = vhost_dev_ioctl(&vs->dev, ioctl, argp);
-		/* TODO: flush backend after dev ioctl. */
 		if (r == -ENOIOCTLCMD)
 			r = vhost_vring_ioctl(&vs->dev, ioctl, argp);
+		else
+			vhost_scsi_flush(vs);
 		mutex_unlock(&vs->dev.mutex);
 		return r;
 	}
 }
-- 
2.43.0

