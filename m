Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23514052CD
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128786; cv=none; b=t6R9ThcAC55Fvb6qmQttRRpLtiZSabDwUQXRqCycSocUqZnjA3AAbVcBYwo1ZqH5lAfKEvn2ir7tDwOzhHUGfhgwb3PW75tn8NRIwGCRRicwDY2iiTcbBKcKI4zTMjZIIWNMerdoPOYWatGsdu75vDAQvFyvpP7z1S8+L0/A5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128786; c=relaxed/simple;
	bh=k6veVcbdMYtnCTYSPsQo4dfEkHOtd7/pm7jM7tctsp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HjKHLHX6X3ih/B7blxyyezs23UKovObnUosbgeYgGt5qRKAb2dhiUKIBCMgQkjgtdYZ6/uIHt4GZN0tCXtrTpDkFRiHMTNgL0qPLK55ijCQYPI7pxjjvtwR4nTVYG+MIt7+2yKMzZ5c7446I2GafdIYyzsJQfwrgHxVg60OzZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XN1gKiqs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN1gKiqs"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47de0093c42so660362f8f.3
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 01:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128783; x=1787733583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fje4etQPnJMZ273NClwRY+zJPLBaH6wZ2nXYH67K/58=;
        b=XN1gKiqs/hZYRuFRCExagYPnYlw1mMGavmN7bzrEuVS66TLGv5DGxs7G195g8n5EG7
         hIg0Lwacvwk0yQweJgPeGDFA4jd9r7Sbit5ICjArRLTJNm89njwV+56Wc8DgjHWCDVRK
         apquni9P+asicZJnpmGkyYuPRpglbGs6UnyBzeUoH0vW5zdJURL1mKa1gwE2FmIscI7I
         Qv1fg1jHbzXdlxSE3VIOas+q6K6Yuaku6xxWn3iNdLCiUSA6eUauZKldLku+5Z9UDESq
         AMrEv9OCZCPsdyUWXObdoIRrKnu3++LnQZyzFQzPva+xY1Hd7imXzJ19rhYUHYSRp6X7
         55GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128783; x=1787733583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fje4etQPnJMZ273NClwRY+zJPLBaH6wZ2nXYH67K/58=;
        b=Su2L4b1SzZ4yvy4Qj+xGBBjRqcZ16Eu9JZwnsdi1Tw/mba66Px37lJbMdEFET/S1Dd
         OUydLFgyiWmLIdor/BgiBJiEcic67LPe8Cfi+M5Lm1jxZM4c4P7m51GaYju7uNg3HtuD
         PthlfckbA3KfTUBxNIp0Tm2N5m1bqyVq6ceB873+z765fcNPt2LEInHCxHIKxtKx5x/Y
         sW2FiswWf/kChCq6fEzm8QQxIwLzg2vyDH5PP45tTUSyWvkdRI2NhGTlRBxz4bNS230g
         6BF/mtZKfQ95XVr1CpGm9c6s0k1/kAHgmnOQk874lgeYYN/i4TYykl0O9uvEy+j+L72e
         eXRw==
X-Gm-Message-State: AOJu0YyI8WHOaO5wlT2mChgQVR0bV/CQFCmFiNCV6bTDBqNUA12b62z7
	5nK6eAg09UQ8Z9PF1bNvDnpOXgmBDgeOJycQ+V/U2tJfaI+t4QnipJchZv2KQw==
X-Gm-Gg: AR+sD10YZ+T8eUFiuRrnFRjmOd8wD/bXJSp9R1/L5Hj6rmr8Wt+6o2jMeFPSHFZj+ok
	H4NvImRalp6+1W50JHizszXXdgE+18fTqenn9g0n4KSECQt7YYOpHeuO6LNot3TxRkzGp76N+Pe
	q066xUYOwGxxl+pV4DelZ/DFT6G+2GhoSVXouacBVeYqo+FdmL07qZ/h/Ld+Mlk0UzriU2qThlK
	JgBd4PQ+2w1s021ahql0YLCvGsyExcWsw0HeHjWfm8TAPPhtXr11hCxPoA5Bw6G8LaYBcur0Oev
	v8akf/DttegGvuCDdohMCzjhmJZgxekr94DlDN63pCn/McWztZSVEY4Iq70uMwkzTGYQQECoEz/
	MZPxoQG0Tu4iO1wiZccCBg3EH3DZCGrli9sh7uNhD4bTmyH9JemCBPbzczYFzNPOo/9XAEH+74j
	qMo9kbgQREuTUdzQAQq96N14AJVRq1b2JvE93qFV/+/L++XqUwMVGujTdi3nqHt54evuwR
X-Received: by 2002:a05:6000:70d:b0:482:552f:ef68 with SMTP id ffacd0b85a97d-482b1ff5862mr4803846f8f.19.1787128782984;
        Wed, 19 Aug 2026 01:39:42 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d059bsm3813928f8f.36.2026.08.19.01.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:39:42 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	alex.williamson@redhat.com
Subject: [PATCH] vfio/platform: prevent read-only region mappings from becoming writable
Date: Wed, 19 Aug 2026 11:39:39 +0300
Message-ID: <20260819083940.1374-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_platform_mmap() rejects writable mappings of regions without the
WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect(),
writing to MMIO regions the platform marks read-only.

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445) and
drm/panthor (CVE-2024-53071) and ptp: vmclock (commit
a5edadbae57e2298a56cf7a4e774a027905a331f).

Fixes: de49fc0d99e6a ("vfio/platform: initial skeleton of VFIO support for platform devices")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -594,7 +594,11 @@
 	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
 			&& (vma->vm_flags & VM_WRITE))
 		return -EINVAL;

+	/* Prevent read-only region mappings from being upgraded with mprotect() */
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
+		vm_flags_clear(vma, VM_MAYWRITE);
+
 	vma->vm_private_data = vdev;

 	if (vdev->regions[index].type & VFIO_PLATFORM_REGION_TYPE_MMIO)
 		return vfio_platform_mmap_mmio(vdev->regions[index], vma);
