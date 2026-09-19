Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94882C21F4
	for <kvm@vger.kernel.org>; Sat, 19 Sep 2026 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789823891; cv=none; b=Shto6i0htFb8CgpW4xu8s6lGvwD4zuoOs6v1hR8WvE6lh3IhKUqD2plIFGNJFOeUivjIGRRsjeA7y7mwjMpAxG4PnuJsG44+I8nKiCYZXqPCzQ9eOq6jVB5tJL8qfesR/OC4fHPEHQ84BEsh7GqOBP3O89kv9Qw/BZQ+VdWCZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789823891; c=relaxed/simple;
	bh=CsmY2C0LUhQFV2xkI5Vula3YY7rYEiZTWt4OODXOZMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DL1phnyex6yRmYe2sayXr1sBncSJkuAGHSDAFfnZqIv2j6VBTUGuHxvmauLjn82weYSnIYqq2VAhmeGF2LFsStWJZwpQMj++O9+zzAIifyRHS7FigzBhMb7xC4hKR424DuKR2f+S59CjuNJ284QiJQqLj6ZznjFSktnpxnC0X7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5T4SkdM; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5T4SkdM"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4c79fso728445a12.0
        for <kvm@vger.kernel.org>; Sat, 19 Sep 2026 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789823889; x=1790428689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JsTGylBrKeTBmgAOYV6+2j7T7Vnx2su+clGWmC3zkts=;
        b=I5T4SkdMoeg+bxeMvG5McZrykI2Poa08KbsvifYwWq+TYVoL9fB/y/qsEEORnF5QmA
         MjgaaxhJMT9bRZb3eIXVpRLSFHV1DPZw7LRKEdsfCtlLdvy4fFlMCzESs8v9Lm9Qjyhm
         SPi1thXSJ0vYYg1d/L0fhUzzo10gtT4OAKgylP6uIxWI50yk2RnIAQI6Sb0onhsOOtyY
         X3d2pFU4TZGnOzm2PKycIUKKxYJSb9H8biM+PSKdyGioE23LV0o4sR7cqvjRIaW1Z17n
         fItzu3tjyVDmezvW4HcnMoVaquIgjRc/NBLre01b1arThe+BwbsTKylZnnUyPYrw0i8p
         HNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789823889; x=1790428689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JsTGylBrKeTBmgAOYV6+2j7T7Vnx2su+clGWmC3zkts=;
        b=KLoE9B7HlXX8raSQQWG4dDEFoGqqfKS9Z1ThLj3VwQXtiqVEZth0qoxIqLXjrZcWiS
         pQeHAREc8WJpwcdT7xTju+axf87P1zpoH3KX2AZah6nU0uDnuCN00QpAX8WSy/ksorha
         zUFsYC/0KWf5bDChXm0XeWzMVFlQwPQHsDem/Po5IZrf0oJyFDrz4ClgfBJXZaLPqtWj
         MqEpnsAGUCbfJ2ex5+2hvPMivOJZoHTLW7wmmas5GnhElxSl2lS0lTep44RO/TV7kOcw
         MRqetUraPq7lXoPRnTnKf8Z/D8qKnXW9NFYr8tPmuD1voRFWcahKMo0gBbXLCHLgPub/
         Dg5A==
X-Forwarded-Encrypted: i=1; AKwUvBxdqV+WG9jC6W0RJDT/5E6yEkIyZY8EqeRNG2v754ML4gWxIM4gklw/XE/r99BOmPhj7BU=@vger.kernel.org
X-Gm-Message-State: AFuF++n4ceTxq9ezH+4Sc6hpPtp0jWFNewCtLGcjCSPlwpCYfa4GA8aV
	C1s9elYOwD/We5uPpyJzNwCsx4lfSGhzTiv2jTKtc4oAozjuHBAVi6/q
X-Gm-Gg: AYBFou3uVy8hZIMAT5YUfKnPqARTKjGeKYLsyKLX5MGks4mqJ/S3OgD4CN6no3PrmXG
	q2NSIFpHO9TM+OtU1kuPGwf8O6YwOP+5KuTB3vtElL0Smmfa9JGhE8V+SlpausxbxhJBb+zQ/1J
	0f07f6kK2QL5ZolN6f9xyOZOtuyUyE4V2FogIZIAWGq1JvwJHAmO2d6v/bqD8HZ/lpXZMgoSkFq
	c1nBPXRlitn6fGnzDr/DGEhSFGr01YXZ2IyG+e/YgoU2x/nWlhy6RV0GmO4zsh/xmFHqq6xhj0v
	+CKo29wRSLpo8W14XUbhmWgggpGiKzc8ACwNPUQgLahPiS1YbmVBE4HWHe9ptnVbMc10wV/72f+
	N9+XSQN67uMaDU4DsaN7NM/Im+1bS2r4rVfPz8VSDgFIf3+ChIBpVeer9DBGtLoduDIXHg+LV+T
	7u6bzkzYtn1H5xw3KwpN6Quv2Uib2Z6MXn6VeHVtGQDLrXHfdsb2hWTPdbkHv/dcFQQMDn5g==
X-Received: by 2002:a17:90b:5706:b0:39e:6c6a:209e with SMTP id 98e67ed59e1d1-39e6c6a234emr3242069a91.63.1789823888812;
        Sat, 19 Sep 2026 06:18:08 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a023cf10bbsm1276314a91.3.2026.09.19.06.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 06:18:08 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost: keep vring addresses stable while the backend is attached
Date: Sat, 19 Sep 2026 21:17:44 +0800
Message-Id: <20260919131744.131030-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost-scsi keeps the response and bounce-buffer iovecs until the backend
completes the command.  If userspace changes the vring addresses while the
command is in flight, the completion data is copied through the old iovecs
while vhost_add_used() updates the new used ring.  The guest then no longer
sees the completion.

Reject changes to the vring addresses while a backend is attached to the
queue.  Keep accepting the current addresses so userspace can update
VHOST_VRING_F_LOG or log_guest_addr without stopping the backend.  Queues
that have not been attached retain the existing setup behavior; userspace
must detach the backend before changing their addresses.

Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fabric driver")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vhost.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 44cac11b68d2..074590838de5 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2150,6 +2150,17 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
 				a.flags & (0x1 << VHOST_VRING_F_LOG),
 				a.log_guest_addr))
 			return -EINVAL;
+
+		/*
+		 * Commands may retain iovecs derived from the current ring
+		 * addresses.  Keep the addresses unchanged while the backend
+		 * is attached.
+		 */
+		if ((vq->desc || vq->avail || vq->used) &&
+		    (vq->desc != (void __user *)(unsigned long)a.desc_user_addr ||
+		     vq->avail != (void __user *)(unsigned long)a.avail_user_addr ||
+		     vq->used != (void __user *)(unsigned long)a.used_user_addr))
+			return -EBUSY;
 	}
 
 	vq->log_used = !!(a.flags & (0x1 << VHOST_VRING_F_LOG));
