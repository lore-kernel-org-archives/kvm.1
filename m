Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2332147E6
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823608; cv=none; b=EO/79ld+eF0j9hYOYqVn0J+iF1in7uQf0QLUHwFFhox4ph5O5ztDkEMC2jk30ie0qtIFVxzLKvwwhEZr0HaZw4itUG9817xN/tgCWVneqSEYjUi0eVRLT9+P2htECwC5JHLPESWSUzYhQMILKRVM40NC5hYKj0kq9Ecm22ejiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823608; c=relaxed/simple;
	bh=aP0+RRXIgMn66e98KbKmeqqZSAJftYY0Hv2Ucv5x3xI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hIlbwExyLYg+AS58B0hx4FE+uAIosrWlY7s+Ovlxx+SABWwxZc/sX4JGG9l2fZa3uFug4pW6tumLBcLQ23j8zBY3r/Kf+u1NXhGEvoboTztwjEyedV3kRa9xuymdkQusIC1ks2uJMUd4m7F+sm2G7I/MoEDJKtDyS00F+HSxGt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSfdr2mv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSfdr2mv"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce98cb8165so7991485ad.1
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 23:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785823606; x=1786428406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WjxoV0tL8kSvsYtiWC0e5PWggVMkESpJYPzZ3/qyCk4=;
        b=jSfdr2mvB8mYFMHuN/JKPHMnhQgp7TCMtEGqZ2dweitevJiQMrnL57XaG9NJwJvG6z
         kwGc/HbA5H1EFe3M5SW9153dLMWihXlpuFSY2wiz1oaIz3+N2yAYAY2x/CUes+Za2qG3
         ItZ35kKBx7PAKh8LhEORQsh7b9LO/iRO72SMMIWT3mYQUXW4pcsWsDyL68yxOEH1V2bV
         6Ivx7fJhnNcZUeviNKi0txZA3i92B9eBp8Uoy+rrYP6KeDkxQl9xmC4072EeFi+vZuIS
         vO2goADuZV4IjCHmKBaeZ6dl3LU9oiLwUSq8N5+k8oA6gxgMF4pxASou+/VEpNgyDvr+
         ut4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785823606; x=1786428406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WjxoV0tL8kSvsYtiWC0e5PWggVMkESpJYPzZ3/qyCk4=;
        b=escjVWe7FV1I2jWejE3E90DOgsA29HZ9a8rLlMirXzPIJ/WDTa94Y3bQyLIfHKdY09
         bGKVR3UggmfYZ5fokFMlouzeURBYVBk9kVH0t/bG+981deyJiKNGgorlhbHcYXM23828
         IPZwkCUtymBuqQGSwjYzMX82hwgE00sYN9FsG69vNRBOBFqikpgzkLkAE3IWwClLQ7b8
         n1nd+DWGL381O1lq8psDSgOd+rJE6nY1VMgckrnsKMIvQcyL6vRQBaExay3pSUvHZh6+
         F1jCjryKjplOQNzykL8biFRA2FtU9FHwVMwfzWnZUEtUL7bbT05cVjTsLQqDOYq4sYem
         Ucyg==
X-Forwarded-Encrypted: i=1; AHgh+RrbtRkdwZOo0lvRzMTGvYo0Dd2Ej8dTAOeiVnGowZJdsuN7ccSxGVKq4ITp0XGN5t0CpyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgweE6aLpzkzFmP/HYKZTw+FlXrWCzDh2Ih7ok9OpMHlUNwslP
	HVQA7UIiMNpMWPi184XQKno4412a6D4kYnbR7oTRYXfhu7evN7tzKdkc
X-Gm-Gg: AR+sD12OyqBrgxNPHhx8b+dbKo3ojDyC65nF6W4jt2XjlE9IYeFVcNDpE1LWi5nrzaN
	Ej4SlFTQ/K5LebNVstXuScVX74pE7GILBdHUjCYyn2yKlBTpc642EbqWRt7pViNQypkt+0x0uRw
	pVB452QoE+WWsWxm/GV2ZbjsM3+0f7DFEDKjGtlWlMD4pBTfE9vGAXacUGXL5a4CsDHdaBNqTSl
	fDMy/QAgfgtIvzR3XLpSnDEPuvVa9tv6ebWNeWSbR8qhpL424E9RQ92vjTOUvhJkPTkgWH+/Nzz
	vfx26idOre3AnzbHrWSro0u/w6BK3WbXD026IUoG9zQNdOp1vl+JSZZeUKWPTAlEozJ2QHAGErj
	r10qRhO3vOCVtE1ZcCHEn8eF87LsNnZ9wr8DFEP3iLq1UHXntOFUm/4bfYLtL05h1WkCjYdYLTL
	4fhn646KcecEuaa1tJPYSjmud5Ww2JWWgfDcwkqU2+bOp8VKCID1k1yItPHdO4QtJG7uYhhuJxS
	Q==
X-Received: by 2002:a17:902:ebc3:b0:2cc:89ce:2f07 with SMTP id d9443c01a7336-2d08aa1b2bcmr21504545ad.1.1785823606239;
        Mon, 03 Aug 2026 23:06:46 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa012bdfsm394425ad.33.2026.08.03.23.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 23:06:45 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: michael.christie@oracle.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: pbonzoni@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v2] vhost-scsi: flush backend after device ioctls
Date: Tue,  4 Aug 2026 14:06:31 +0800
Message-Id: <20260804060631.6444-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost-scsi translates guest response descriptors into userspace iovecs
when commands are submitted.  Target-core completes those commands
asynchronously, so VHOST_SET_MEM_TABLE can replace the memory table while
an in-flight command still retains response iovecs translated through the
old table.

If the old mapping is reused after VHOST_SET_MEM_TABLE returns, command
completion can write the response to an unrelated userspace object.

Flush the vhost-scsi backend after vhost_dev_ioctl() handles a device
ioctl.  This waits for in-flight commands that can still use the old
response iovecs before the ioctl returns.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Changes in v2:
- Shorten the changelog and remove investigation details.

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
