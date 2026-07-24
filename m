Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E1381EBC
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784873371; cv=none; b=etAn+deGK+rrzzYr5CiVan3Sgo8Nm4NmoTtbivLb0/Fan8+eKTEfn91FeM1iSVOzcfoIV2z8Dp9o+nmTayjB/VbFQIbOkeg72mGP3n6tXo6yXWCvnIM0H5ora8R0y4NJXpNDLcYtmL0xzBvV/UKkNeOhKbNp1KG/usmlx7dWacE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784873371; c=relaxed/simple;
	bh=Yv76Uc6eNIRwoHRE5OWMEIz+p5C5RfrnI2mMnfhCH1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FnwYtNaBZD4E908yrKqmkMkjJoMHt9K2cJdysjjvY9i9H81cOIU45MDXlB5+2kYXItq1VSmgfjVNFPSuoJieRU8GoPpFg2mtPX6s7NpRpNqcnBtnrJfvgO+SGK4OoQzy7R/Hyg30n7/VRZcL43PjStUonQzSSaScS4Zuc464Jy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2T7Kbof; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2T7Kbof"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485b358552so45497b3a.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 23:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784873369; x=1785478169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0SdJQwjXICAfEV1ZszzabJCCVlp1hRyGFUjJs/6dLPw=;
        b=q2T7KbofyhGeHoGdsQSjwRswiqqGoG5Lukr1ewBz4eBPhC76ssUOHZclIda7uWb6q5
         fNDXQAiJ65/WDKaQbsR4oG2sItbtFb+hirPVN4LZk2xxuu2Oz3EILPUcgAN5WWWIHBJK
         iqldQDgaRz1eTJ5rkq1r1lykgUICB4yv7XI/jnif9o5ZPXj5kYfLe9knK5vbsl3DvPUA
         elRVKiURKKPVF5eJLbyznvyAnaqZ0c7LZX/qaJiysbeQz8+oLQpZuYQvfaZ5gDYqepXu
         AdU4xMiXpBa9p5zP5Auu0dVLPO6LNj3nm8ccHOD3SRnhBm4MAjonrl64OviiNdx406j1
         aMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784873369; x=1785478169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0SdJQwjXICAfEV1ZszzabJCCVlp1hRyGFUjJs/6dLPw=;
        b=SHBNwraELCvnM5rLY9ZmLvYmLMDweHB84ZkVvO/QwJq0EoiBdTiRJ9jT98VmK5g7Ad
         3bLfMTss//Yux7rVRnhtGlugj5ji/J79euZliR5LvupZZaniss+2XA92tmAxPLvTA/Zk
         FopNetnYznFuU1ZM7UpQEIqQDhhoIBgYEmkSDGATkyjda6Ub7TfBUQXV8yYmF2aH+CMq
         GIRh0wEG/zg5YpN/rG2jX5hqXp+XCQp5hm/oJHq/AiL1I+vp5Lldv5Ap4JKuBLyCcFck
         7TddRhupO8GX+tWTFbu68pRZ3cVIcHR+vumpNzWSUU6LxJzLARrQVw5lT6zsxmq2afob
         vomg==
X-Forwarded-Encrypted: i=1; AHgh+Rob+ASHkWS52r+icBsZ2GKrOIjrWZW/TVGmU9nW1E0FmRbdH3x3fM628LFpRpGWQIoneVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIdycWsTQHKkhEu85iTmolJX9zduCJPHG09wIMXzCzF4DaGgS8
	SgnjGwpfMbei6Sn2b0t754VhEobTQ1Q3Xzdp+Z2s/Pk1nXC7Gsvvl0BN
X-Gm-Gg: AR+sD103DZUDbpvzWZL164y0PbKJk4mdbBGFGp691fmhV62qvfav3ns0JQrBIoP7o2J
	a/stqs+3e93PfmfjFp1N7RLmxS3hnH/QET1jrf/3rF5Q5oCbe94S8vlHWQALY8HCNPC/ozyaR+p
	sHqHYDf2Ew0Ko/Bd9Z5ahTkWRRbuNbQhTOBRsoYKQdR3cwNzfuXK5Tr5YPDf7861lBrWNRIYzA+
	hNIDZ+bsqgEpQVeo5pcv+sn/neL2iZmYPBDW+DjUTqrHfxnvNmbg/F0+Oz7nJ/GYOwO4xThjPTC
	fzP4mUX8JluBHykoDd1J2B6czONl2Dn2b6CMMywvt69nYbCo4Z+quoc8TXURCMxPCz4uhxliweG
	Liq7BxIhYrb7ET15ffsXJEi8jap9Z6qZtUDFqDsq/CB3CzHM5rDZCQv6pX2Pepdq8Jp662pQV48
	AKvvjP
X-Received: by 2002:a05:6a00:2d2a:b0:848:63fb:fda5 with SMTP id d2e1a72fcca58-84e2c1b9f89mr6544139b3a.41.1784873368593;
        Thu, 23 Jul 2026 23:09:28 -0700 (PDT)
Received: from jia ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e172984b0sm4133451b3a.27.2026.07.23.23.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 23:09:28 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: michael.christie@oracle.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v2] vhost-scsi: flush backend after device ioctls
Date: Fri, 24 Jul 2026 14:09:19 +0800
Message-Id: <20260724060919.1569170-1-physicalmtea@gmail.com>
In-Reply-To: <20260721073639.1532488-1-physicalmtea@gmail.com>
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
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

Changes in v2:
- Shorten the changelog and remove investigation details.

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

