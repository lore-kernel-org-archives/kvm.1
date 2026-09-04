Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE14917D6
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483227; cv=none; b=USyGJe66SLJMy5HNk3Hzc5aDy193DqoKly51E3B6xdgqSwYYGdqx867212CB1FYdfmdYG+ub4Wrn2J3JGkG5d2PVpOF6PwVEpX5sZby23Swz510Ydbtn7XAX66qTFDwu8klN5K1D0qvYCrj8gAycPcGsHIBvEd6yJOhaR1LePQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483227; c=relaxed/simple;
	bh=0ZpfWwRDAHgu1mRcWZVQMtXirmVz5qsYIzeHiB+CHr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qLUVSKcTvMvvYDPLfKiVnSoDm0KNtQCKLrhQdlmlMTLZesDrsm7VGlv8r4SYGO+dI2Lh3fMdU1qHQNUfKNOpzPstEJPINxNbTxy2oFZHggiAd16k/r714b9w5f7uDgA1kvPwfy/ZWCLeo+ZIVawxr45a0WXJGVVSfeWcXa54MW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAl2MJFB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAl2MJFB"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc147d86bebso492804a12.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788483226; x=1789088026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2el8XyfB2FMbOrmCud+3jZOtrXhR6MDItbmJqyOOTqQ=;
        b=cAl2MJFBgyOCpkwE97bNjJlzvr6OWg5YVgTAaMHpgiNDVPihn2QTCWTzWB9KXdwYSj
         7w0jUYeELjdjxtVpaVFQ4DfKao31tvdjtuHbnGlNCfXOu61ZkNexOfs9pySSMJrz9x+0
         o8DRD3ESp1IoXt+c6c9x+tHXSsBiBc+grHM7Iz0PK63UzsfTN6h3UGLGAXnrAQV2qBMT
         IZVQj/YgnIFyYpQvQkyMvzzsPQ/JGZoyo77aST7VgrL06gRJeWwxdw7H53qR06cgeMOt
         qmtgORdvz0TAene4buv/bNet4Etdfy7y3o1rr3UKNOuHIQblEkbIY3r8q6UevwQd8wo/
         EWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788483226; x=1789088026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2el8XyfB2FMbOrmCud+3jZOtrXhR6MDItbmJqyOOTqQ=;
        b=ZCJ/umW8mQkzItj2c+UbVpC2O/NEOsNM7T0oz/cFFUnor8Saqui+xJtXszKzM2s3rj
         w7cssS6AcuhoPiMQX0+FBbmwurwALeaKctYLkqSwO/1b6+usJ4X007DBM6wH7KVcaJiF
         yyu6OK3SVlSpKoceNqceYcvoQlUnObgr9QQPgnXCJz8l3kO8KfwCe1bMHh9fltF4hxaq
         mg5bWWHSrAwu578m9F/kvfWy9wQd7UsBg7oFPMhi/kX8DlYctz/K5oqS+TnkLJJvVwAZ
         HWNTfuTy1Os4Q5eX4mnioYgiiM7eARnlwVJTNddod4ABM/I/Mtq6Gkta2M4q4UaCjJgX
         XcXA==
X-Forwarded-Encrypted: i=1; AKwUvByKmMEWEoz6gRZfWbSxewmbTv27ce5/qqrvG5odpyofmEDePIka3UAdPmGbHzfO1A0/+UQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mp3oV7PSQVh9H70Y2DNOdy4KGuTZkPHLp4veejvKh0Omscpc7U
	pWwl8f9IODzUPSl8wULTeqH3kJK74EoXA8Xd+MkKc/q1TmrEjo1qNDx6
X-Gm-Gg: AYBFou2rueMBJJyqu7TDHj0xA5BWvfvYYP2thu6pi5BCAglQA8Fov/rZ1IaIol7dqbm
	JvJhyAL2nTPxslyoJ5vtRA5LbQuuvpjsRk5BP8sanUXx78NI/JoF9eqoU6Uvw3yXg2nMBb6++p7
	l5VeOm4jQL+iSkTL2xgXoivCpHS6U8a7ZwLcrRTEDgiXUAh/kvEkbEsz6+DV6lmbRxegsctGke8
	+w8YsCMSfx4ww1O+rA8HH80jixuVqNWKZ8qv6xIHDRKAprdEG+64zzu0BSYysC1DCkkmZfesXif
	JiRdwmJG8EPrc5WZ+D9oExKPQRCziGDO1L01i2dDlSmgCJfn/pG7ZYaahyRVH2oXATbzswGY/6Y
	BHh3Q5xRSLZo03YTu03ZM8+BUZ0zJLphm+9Pq8EPuxzGE3rmnyNwds8xRWRcVNJodB/07vg3z/b
	3JMxr8dnO0E3jpQmeCFyv6nBozS8f2twMnbj5CTGg6fmfn9KHn3tetcdI/o40I
X-Received: by 2002:a17:90b:4490:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-39b279ad968mr1194020a91.0.1788483225951;
        Thu, 03 Sep 2026 17:53:45 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc081sm7701712a91.6.2026.09.03.17.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 17:53:45 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jaswangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Asias He <asias@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost-scsi: fix event queue iov out-of-bounds
Date: Fri,  4 Sep 2026 08:52:40 +0800
Message-Id: <20260904005240.502787-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_do_evt_work() uses vq->iov[out] after vhost_get_vq_desc()
without checking that the descriptor chain contains an input segment.
vq->iov has UIO_MAXIOV entries (1024).  A chain of 1024 output-only
descriptors yields out == 1024 and in == 0, so the length check reads
one past the end of the array.

With a host-side harness that sets VHOST_SCSI_SET_EVENTS_MISSED and
kicks an event queue filled with 1024 OUT descriptors, UBSAN reports:

  UBSAN: array-index-out-of-bounds in drivers/vhost/scsi.c:611:14
  index 1024 is out of range for type 'iovec [1024]'

  Call Trace:
   <TASK>
   dump_stack_lvl+0x5f/0x90
   dump_stack+0x10/0x18
   ubsan_epilogue+0x9/0x39
   __ubsan_handle_out_of_bounds.cold+0x50/0x55
   vhost_scsi_complete_events+0x55f/0x5a0 [vhost_scsi]
   vhost_scsi_evt_work+0x17/0x30 [vhost_scsi]
   vhost_run_work_list+0x8e/0xd0 [vhost]
   vhost_task_fn+0xe1/0x210
   ret_from_fork+0x348/0x540
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Require at least one input descriptor before indexing iov[out], and
treat a pure-output chain as a missed event like other invalid event
buffers.

Fixes: a6c9af87363c ("tcm_vhost: Add hotplug/hotunplug support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/scsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..9b5f07f52b0c 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -608,9 +608,10 @@
 		return;
 	}
 
-	if ((vq->iov[out].iov_len != sizeof(struct virtio_scsi_event))) {
+	if (!in ||
+	    vq->iov[out].iov_len != sizeof(struct virtio_scsi_event)) {
 		vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n",
-				vq->iov[out].iov_len);
+		       in ? vq->iov[out].iov_len : 0);
 		vs->vs_events_missed = true;
 		return;
 	}
-- 
2.43.0
