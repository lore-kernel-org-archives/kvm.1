Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2A3C81B9
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537604; cv=none; b=CbKON5SLCdtdLeXvU8ZQ32WGhnOAh/q6gIFdYbq/DV+UfFIPM0lcDhXBdMbEO+Ier5bXT77Jdd4hBgSFbFpwtI6qvD2dNBWzUqXkslUtJvrHCTxn1GEN1rJK4bLNCVvxDFLYrp3RQOFwSNvi7nRCgkcSm9SFIv2dD2iRw4nQ5jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537604; c=relaxed/simple;
	bh=o6QS22hcefobTL4agDYyTXy5uvYvNFggHdA5faPCDDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L5mPyTQxIGoy8ySrohH3CEsAIrnS0kboCCMQvCgkCm57neNwZ73nnvhqGSWtWn6j4LrIdXE6JHt6zPBl+Z9Bde0r4gCHNCqlhtVm4mY15qFppxKcgmpCDqF65Jins3Jk6eMpt3CxMwp3UmuUvPaR2g57rSWac6ZgjZFTF5MdwxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Va8swiqd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va8swiqd"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so4166605a91.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784537603; x=1785142403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZyobmQNbF473X4YAV4bIq6NV92V1jhbfZhYiYWm1O2k=;
        b=Va8swiqdVFiX+D7XVwMrLVd4zK/t/RDx3lEzr4Ka1merZH+AioaOuSx6h71mkZb5n1
         sl/GFU2plnHtZ2CIjS2XNeId+pzpAHrFWSMx0MFLx9fyjfYuPir+7faWHhExa79UlubW
         xJU0YSCFMb5457KUXwkIPWwAI7Why3j6gK9UhXdGIB0HW/O2jgCn765wON43vT5CYiYN
         x1s9hbZoCMUsZlmRhMCK/gnytXxkDGcIxAcDNYdMZ9uhzGxh7PEzCmLLHYWwahCqsb2E
         /BAta5YHU+Mc8LGFOkpthw45Bf/TPmbsYyohS2eho14nvbMHs+KGa8soD0/QUhkoTerr
         ruEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784537603; x=1785142403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZyobmQNbF473X4YAV4bIq6NV92V1jhbfZhYiYWm1O2k=;
        b=epcpc9usZiBifUnpeS6Fli6PsyMoUXYc97Q04UrKYdJsldSlAA5aezIPz4MBdOEoG1
         axyP8L3aCnbB7/g2RcN/Dz9N99s6dUAiv7AD4I5bD6ulj/JhL0G21lZX6VJnQttuuxyt
         1S+LEnO6fbcpPHxP2xb4R30SiVxHDmjq/mpwL7HD8VHCEVTZ6bS97foPV6hDdplpc/HD
         n64w33C9Bn9AvGPz5sjWAPNX2FEqNIpolCYsPYiPlPT2Rh48yocVBg+FsBfaXMuUBzAN
         qXN/Yf0AkMPyg+0DlWTQOnz6hMxyoNOBJZBZkC7GBbiVBIoPr+ZfnXxvQ3xjYgBV7lts
         J09Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp1ImBPLKdfuj3Y8lyg1EvlXYlI4/zj7H5BWX4ELCEuDu7OsbSUi164RiiLlND5sGbmZQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpmXcwDnCuAYCfSSAICS5Fimh0masMFozbSjy8IK+c+HNQgQ8x
	6c2jDNq6cYMx4Gg/1NHaH1R/Pp9IuL3KVkpiI46XU/4sBApjIPLqWG/H
X-Gm-Gg: AfdE7cni6Kzg8aCPBgLZVXNRmTnz8bt9y5HX2427x7dfZ9kBV2knmJ876Um1vp6kJF4
	dvNSOFqJQaliR0tvhJsF98kDjIAZZ71Lt25LgHCkWtljMQy0kCS8ZIBjo0uxagVdmwvVhs9Tc/C
	aKLFeltqewAMGE5n9jWFu0rTR2SuRFgVvkXk6qf6dBF2bSxafGOLkJwXit3xwusugiKSE4DtdGX
	yWweJ0f/458zdJYGo3t+1JuyOY/6oThBbPiiHvIDF/VWE8gxSH/Aw2QOAM0a/6H96mwuGciuWdD
	9PkPwn5C74y2Kb8EG0RjaHxiGSSmtukQR1sbJql9iX5lroRuuZl8nZelgLwHe7vOZbchfGB+7nQ
	n3LUjJbuiz93qm+o29/lJtCBvNxGgo2fotlFq/mjydFo1CsoIXvvOBsxrPKfo5sZwEGO++d9SxY
	c+2ZAv
X-Received: by 2002:a17:90a:d44e:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-38e4b3d0fdamr13257377a91.1.1784537602406;
        Mon, 20 Jul 2026 01:53:22 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb69bsm25224068c88.11.2026.07.20.01.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:53:22 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	michael.christie@oracle.com
Cc: pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject:
 [RFC PATCH] vhost-scsi: Serialize completion notification with callfd updates
Date: Mon, 20 Jul 2026 16:53:06 +0800
Message-Id: <20260720085306.1519294-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During userspace stress testing on a KASAN-enabled host, a host-side
callfd replacement concurrent with ordinary SCSI completions exposed an
eventfd_ctx lifetime race. The test requires access to /dev/vhost-scsi and
a host process that can issue VHOST_SET_VRING_CALL; on the default device
permissions this normally means root or an explicitly delegated service.

The test used TUR completions while closing the old callfd and binding a
new one. The unbind form tends to produce a NULL pointer, while replacing
the callfd after closing the old file makes the old eventfd_ctx eligible
for release.

vhost_scsi_complete_cmd_work() drops vq->mutex before calling
vhost_signal(). VHOST_SET_VRING_CALL updates call_ctx under the same mutex
and puts the old eventfd_ctx before returning. vhost_signal() does not take
the mutex or hold a reference to call_ctx.ctx:

	if (vq->call_ctx.ctx && vhost_notify(dev, vq))
		eventfd_signal(vq->call_ctx.ctx);

	CPU 0 (ioctl / callfd replace)		CPU 1 (vhost worker)

						vhost_scsi_complete_cmd_work()
						mutex_unlock(&vq->mutex)
						vhost_signal()
						  /* load old ctx */
						  vhost_notify() ...

	VHOST_SET_VRING_CALL
	mutex_lock(&vq->mutex)
	swap(vq->call_ctx.ctx, new)
	eventfd_ctx_put(old)	/* free */
	mutex_unlock(&vq->mutex)

						eventfd_signal(old)
						  /* use-after-free */

On the reproducing run, the worker ran on CPU 1 and the callfd ioctl path
ran on CPU 0. KASAN reported:

	BUG: KASAN: slab-use-after-free in eventfd_signal_mask+0x6c/0x110

The use stack was:

	eventfd_signal_mask
	vhost_signal
	vhost_scsi_complete_cmd_work
	vhost_run_work_list
	vhost_task_fn

The freeing stack was:

	eventfd_ctx_put
	vhost_vring_ioctl
	vhost_scsi_ioctl
	__x64_sys_ioctl

Hold vq->mutex across vhost_signal() so SET_VRING_CALL cannot swap and
release the context while the completion worker is notifying the guest.
This gives the completion and callfd update a clear ordering without
changing the vhost API or adding a new lock. Other vhost-scsi response
paths already signal while holding the virtqueue mutex.

A private eventfd reference taken under the mutex would allow signalling
after unlock, but it needs additional reference-count plumbing. An RCU
design would require broader vhost-core changes for all call_ctx readers
and additional eventfd lifetime rules. Since callfd changes are a
control-plane operation, extending the existing per-virtqueue critical
section is the smaller complete fix.

This is an RFC because keeping vhost_notify() and eventfd_signal() inside
the virtqueue critical section extends the lock hold time slightly. I'd
appreciate feedback on whether this is acceptable or whether a
reference-pinning approach, taking the reference under the mutex and
releasing it after unlock, would be preferable.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..7f46bc0de3c2 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -735,10 +735,9 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		vhost_scsi_release_cmd_res(se_cmd);
 	}
 
-	mutex_unlock(&svq->vq.mutex);
-
 	if (signal)
 		vhost_signal(&svq->vs->dev, &svq->vq);
+	mutex_unlock(&svq->vq.mutex);
 }
 
 static struct vhost_scsi_cmd *
-- 
2.34.1
