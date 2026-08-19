Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807B425893
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128796; cv=none; b=als+PzLaK5OwnMjDsiHmKBOjeJOxOf1SA9B264eIVz0roeUfFmzHrYDh/ERWsL2k7YTQL1BdL6R75UYJAM8Qh20cit8upRoKBK8hkM8fMmVPHVbdmA5UOzLcz63vxkPGleAUYewiDKnSu9oYbIo1i2YG1eGRCu45QC+oPXjTBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128796; c=relaxed/simple;
	bh=UmLSjR5vN/pqFUICwJ0uRR2Xb4U0t7SCQgme0ppWNls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OEki++MddMOj+ODX+zABoUYOPZBHaUfP75Xy8zxVdOh85liRfex0BHwzIlQjTb5Z90WgVGWK0hwNKflOd+acz1MCR4nMAoqXZuk36Bwp4KSWOzH4hW37NmChf65LxDBmjga5MeHJT21oKxrHKVoSzGVBh8H6TfhUEDvlSxD0OF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsfdPaXU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsfdPaXU"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49557167508so7766995e9.1
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 01:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128793; x=1787733593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FCAXhmh1ysx49XvDb1i6Lpx6/sN5RWuZrnkbED6pwZs=;
        b=bsfdPaXUPduE1z/kLVo9063QiRwJZktDWqbdicJjLj07glJaeEVCLeqxZbAu4vselg
         wMV2c+1/BAXGmUqW/m9IhHHqxvafGqzWzud2GtZ8CP0W0VtquRwyivTwzS9J5Oa/kZ6o
         M11rcrYJ41ax/ktXbL+fJvhZ+9NnI8SwCuRo4Aus0+ighmmbYs34PiXboPVicol1M147
         /Ig3SPQCADNb14YwFcEZQZ0kXFAPK0MYY17N75Te/D05P4aoJP6kiBqGB92C4rVnbSHP
         Jpdx6ycxR4jGZAguYJbEilrbORmY2wfraam5KChRzPESmVF9/7LVgyBgiTs3ighJ5d0V
         DQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128793; x=1787733593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FCAXhmh1ysx49XvDb1i6Lpx6/sN5RWuZrnkbED6pwZs=;
        b=i2Fuc0bwjMW4z2nE+oel0bYkQyJK+8nh5z7yx+LZYmlQkjgJ272B2pqVNV9IupvkOi
         usJWYj+AhrWo4lspkOpuAIGMJmQ94yKZi49I9zUITAP5bbypEynm18bcznNH7anR8xCc
         2OLwKXBlDFGODYgCEENWqAlc3R6hx1W7n6jYFaE2YnDPp/0IkH1kYiCdlzXr7bWPfzEP
         7R49A2+Ki4dF7tkyoxdxDcD1jKt/NpIrXv56PaKDV7g/+9exl8dmDiRk6KF23lFbTMG7
         sGLzulRHk3TvQYO7ZKT5MXPikvNMGLemXYS/KXfVhrdjO3HKd2o1CwTqo8inxmBirUoY
         h0kw==
X-Gm-Message-State: AOJu0Yzo5s9nariE5aRIgiKFyzH4foZW9ZLHwiVo8vPEzV+2JLt3pb61
	PDRHvRh5fDX9/kwSgC2jknlVnFBjPuMMPIoJtxqaqDAsA+NKcGF24C4qGWoHhg==
X-Gm-Gg: AR+sD13YAWV7plikwyD5zQnXyBl1NIVDHxPhT5r+H0ilNb4VlWjcalAtaNPlgH+u2/w
	t9cTrij+TXH0KLCLTrm2XjPbH8IuW2Ng+OmqpUnL+uIQK585nRKe78rSc+Y9cmKM7kZasDGDZ7J
	5RKWaDWXApNl73E/lw8rW74NSQVFQXBo4dHr/obMcY/lSu+pYpkQrcVVmn8lsjJhbvaBkBADDup
	uDtDuXtwM3eaTcHtBZ6fa1Jv8K4KDeBYyFFd+fDddA9LiRXr0B9vFb69HYdmg2vzyao8dWNyEFA
	azgghvML5BhMSfyanah9FJHJwbs6+IzcGwTl0jVpmThcZwbnMSweMu8DwbfUGDQItyAFVWhucL9
	1SACXtnekWyDNxC4RPFPg/0S8scbfRnsa6XJ6p4+1sWQvMmnlouLWpxBMz2P3V5jWrRTLT6GITD
	amP6h8BJ6Z+60ikhsiV5j38eA3D2mzzCHzVUK0HTzKcQtkvydEpkPXBs0d/aTCaSIzzuPL
X-Received: by 2002:a05:600c:8b32:b0:496:c06b:9fb4 with SMTP id 5b1f17b1804b1-499aa200efcmr52486565e9.14.1787128792869;
        Wed, 19 Aug 2026 01:39:52 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9aa1594sm42869985e9.0.2026.08.19.01.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:39:52 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	alex.williamson@redhat.com
Subject: [PATCH] vfio/fsl-mc: prevent read-only region mappings from becoming writable
Date: Wed, 19 Aug 2026 11:39:49 +0300
Message-ID: <20260819083949.1408-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_fsl_mc_mmap() rejects writable mappings of regions without the
WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect(),
writing to MMIO regions (e.g. response portals) the device marks
read-only.

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445) and
drm/panthor (CVE-2024-53071) and ptp: vmclock (commit
a5edadbae57e2298a56cf7a4e774a027905a331f).

Fixes: fb1ff4c194157 ("vfio/fsl-mc: Add VFIO framework skeleton for fsl-mc devices")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -406,7 +406,11 @@
 	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
 			&& (vma->vm_flags & VM_WRITE))
 		return -EINVAL;

+	/* Prevent read-only region mappings from being upgraded with mprotect() */
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
+		vm_flags_clear(vma, VM_MAYWRITE);
+
 	vma->vm_private_data = mc_dev;

 	return vfio_fsl_mc_mmap_mmio(vdev->regions[index], vma);
 }
