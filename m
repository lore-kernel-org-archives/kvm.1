Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBD4FD788
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675343; cv=none; b=MnBiL7CJxt44CBjx8TTGzfG/B4Iyi0/9H+X8qt+gJJx5Oya6vVSrYYoCXvx3b1TndFkcPAMg1gXawuUOD8F/sS8VLS0tS7mMajJA7TsIed4jyqcejvKsfYrRxzRKdt773z7zLDkmxvTsJ1OH4XO/4A2cM9Zv+e3sGI48N27OvhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675343; c=relaxed/simple;
	bh=KYw6laLYfLK835VlX2EP/m7oFfMcnni8ceHKQo+76fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYuAyU5lJ4wHUxZBZdgev6WUuJZuPMu4+A+y/ibiJXV5QyeLIojxk4iTom46kQU8vHW9BjqGWsQyfOTKw6ScmOjaMIHgIfRX+7UNLmfj+6SkY9ewseoft1C9C7aR/unCfDR2wK3nNaaSjlVl/tfPslrUqjJrklN25P8fsxX6Jd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNN8oq7P; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNN8oq7P"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so31305315e9.3
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790675338; x=1791280138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QuVBrqbNGUgL/1PEKz8umL2PwU8bfUdabSd70PxO4y8=;
        b=LNN8oq7Pr9tacX4N/3+JmbUr82Vza+COP6Spg2LpGQNskQiFvpOkOCRIE8eDeqe0dx
         JOiAZ8BiiYwfHX0sNXzu2j3oeCi8tyUNjriSJewxVymUOMhYFFjzkX3RYqyYRzP9LivN
         Xl9a8BY5OFCH2QZKpPjdnJ91OD6EU68W+zO/UZOUJI1JyWbL318buUXhgYhAMptntNph
         3kovva97fCNUK6fG2qckIxX/y14BbI/JVdXKrSYsie2qV22D173se0TB2vam2rH5RN2a
         n1Jfc/Ntd6B1UDTg0xouYF03Hx42ne7Xylkq5YwvPW8eR7CryeE+J29cdbp7unqNVyVX
         rWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790675338; x=1791280138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QuVBrqbNGUgL/1PEKz8umL2PwU8bfUdabSd70PxO4y8=;
        b=yGQzTXucKBUDMHDbr1qBmKCPRuUAsvZSkpUYqLkrPVuCFw8AP6KjnXp6n6uPCMp4Xd
         +bZNCMe8/Ia5n4cOPLQlL2GvJUapsvovu5nl7UVdAKWPbZHrRiuROYjBBe+bpq0WRR6c
         0gqGx8mDHwV6fige+VMjN14HbagdESvJka33afmUJKrmzj5DtmFYuiM7GNPlz5hdTyJX
         FJMiiojMEbE1FafYzQtMquSwHYShFgxUbjFwHmzv2TjyxsTXGL4Djg5nGuKRA71SulUQ
         u7XyBHacn2jt7wN+rjDfqfg8FUo+iJJGuVgStzsZcROmgQiUxdG5EfsHPrG6U1pnwRWe
         J1rw==
X-Gm-Message-State: AFuF++mBcmkhgbCBbU12AWv7PnRdRCxgU63g9qfPligOZyjDP1z+SCis
	Yx5wkLrVjeG+25Bogwryzm2sUUFKL0h+JvSCBN7eO4UUmgsmDUlSzM8vuYXLDw==
X-Gm-Gg: AYBFou3wX0/WrgxJlmdNJcyT7OrM0hSnkULHeJNKo0JcGkbraeKUIPMY3rJVkgcTWZ5
	PBSr/1upiCXrjcTfhepQCtcEAwsmqvrBIzpgPcDaNkGPZgAhSe/6zsbdQQjLZYsZyCUHHM4CREh
	3PVRmW95eSyzJYcsGa+KndBYHtEpGYXPsRD4j8xZ57pHT5xtqQYQjpu1DVT2awkahHykb32lfPV
	ZTOw5JKWrWkzo/Yyq2BnIqm1lQfj944K4yblPeLMIezYr4ScA6GwmDEvOzdKnMNt6S/JOCanF7g
	oefMwiRpsNP21uLpVHpFFtkSHAxp6dBrKgLIdOLYuknqyMTX+15GVup2tnp9O2vMdxjOEt66Nzi
	PO+8XW+XQQ5fdN4DP+sDyKz0EXQnump7EOT4+SF1mVmtUiPeQaIXF6SPWk/ABrhN8IuxzhgrFup
	r6JVwCqdX0dWTfeI0N0ZWsGrS7qcLXXu1v9WOmDQHPFFAZEEDWXxvnxiwmrnwO2GHCd9tzTKKmy
	wR+EGBay2hoXGo=
X-Received: by 2002:a05:600c:638f:b0:49c:ffab:551f with SMTP id 5b1f17b1804b1-49fe66d8112mr265725355e9.22.1790675337786;
        Tue, 29 Sep 2026 02:48:57 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.113.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9b72fsm89821455e9.9.2026.09.29.02.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:48:57 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex@shazbot.org,
	eric.auger@redhat.com,
	smostafa@google.com,
	praan@google.com,
	ioana.ciornei@nxp.com,
	nipun.gupta@amd.com,
	nikhil.agarwal@amd.com
Subject: [PATCH v2 2/7] vfio/fsl-mc: prevent read-only region mappings from becoming writable
Date: Tue, 29 Sep 2026 12:48:43 +0300
Message-ID: <20260929094848.7439-3-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929094848.7439-1-suruurism@gmail.com>
References: <20260929094848.7439-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_fsl_mc_mmap() rejects writable mappings of regions without the
WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect().

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445),
drm/panthor (CVE-2024-53071) and commit a5edadbae57e ("ptp: vmclock:
prevent read-only mappings from becoming writable").

Note this is defensive hardening: the fsl-mc bus publishes all device
regions with the WRITE flag set, so no device can currently reach the
read-only path.  The guard costs nothing and keeps the mmap() interface
honest if a read-only region ever appears.

Fixes: 67247289688d4 ("vfio/fsl-mc: Allow userspace to MMAP fsl-mc device MMIO regions")
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/vfio/fsl-mc/vfio_fsl_mc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
index b4c3958201b25..5a6cd78dcc06a 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -403,9 +403,13 @@ static int vfio_fsl_mc_mmap(struct vfio_device *core_vdev,
 			&& (vma->vm_flags & VM_READ))
 		return -EINVAL;
 
-	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
-			&& (vma->vm_flags & VM_WRITE))
-		return -EINVAL;
+	/* Prevent read-only region mappings from being upgraded with mprotect() */
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)) {
+		if (vma->vm_flags & VM_WRITE)
+			return -EINVAL;
+
+		vm_flags_clear(vma, VM_MAYWRITE);
+	}
 
 	vma->vm_private_data = mc_dev;
 
-- 
2.53.0

