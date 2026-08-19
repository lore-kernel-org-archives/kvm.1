Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C999F4252D5
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128792; cv=none; b=b1qkGYzUfkldA3t0WqShVbeHphjWAHIOzc/pX2djmd4/pE+zjJafVnkoudpZ6bhjHEKiqAOx9XwW596f9F3skvUQ/VIZiwXBRLT2foVRPQQp7w004ciI48GP4jYF3N2HRdsezN8fCrXhUa1+A/p+R9ebmPOae3/0gFEDPDPrRc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128792; c=relaxed/simple;
	bh=lV3H2tb2qiMnCClXMs0+wmrc43ydlEATktuhAe9EyR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kAk+SKhr+2Tz5G98QeN/BWrYFF0rigbHXE2ViGL8mNQU7rLhYf/bNWtbKrEEb/Uxuj/Qn+Ps3TqImpZWk4Sa24GwVXsxL06fopP0/o7f2+mzbr19pm27YZL+tXN1pTlYHAVOk7vexOfYAZzbirCX8+s1+1NVSg438AAeI7U5mDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw1r3Suu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw1r3Suu"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4996f1ee4a4so5763015e9.2
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 01:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128789; x=1787733589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UORZ+icp2lmX+P7JbOJDudH0GncJTos6NcrZjknca28=;
        b=mw1r3SuuP8K1aEv2+l0aFJWKdsOR7wnG00iyyvUrnMyyCTjC9rps9yYGHE51st70Xm
         JujOYkZnfPAMvc/AQXBozcWiDeSnyh6J9srZ0d1Q8ejxRr4/MjpKGHiH/ErQkkUNXYzK
         0r9sXW38ZblraA8B2TQz4brEU1UQ/HqGuHCwTvFdXnubyHgUj2nMwntUXUFFIh1hQiex
         6iPB8EjYr/S5/hNyUUiYaq7Qnctt0pTQlbbnn73+wNeIBjed/zd3XtJv9Xl36QiApK/B
         0CKiaNHCILIFB2ENz3XbPpG+eeD15X5nZTZOgfUzsD9delARqgYT39nA3M+tRaxtok6a
         6wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128789; x=1787733589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UORZ+icp2lmX+P7JbOJDudH0GncJTos6NcrZjknca28=;
        b=PFyFF69i2r4FKGC/zOmuZWT9AsSq++AZavKK5KMJi5OrzTC8WADlgvCEc/IV19zmGW
         5CNgX0asUdcET5ryT+YE/nze08+NWJZXwCjUdstRnkdbUrQawp6nlYruwsnlXEJbAPWj
         h8XemwCKt5Cfs8seJEF780ef+72duAP7NqjZ0pJooTrsWIn11GhwwYntYNw5f2oL89hL
         llk5VAFLHgCrO4huTmevaIf6XvXaA+rd286KAimn2592hsUvlGmubAZGw480DonhPOhH
         vf5jJFKyL//ruW57jz8TfC20AtsnuFJTGBuKQvpOvneHU7PrvBka5x6j4CulbYEAgy2C
         4CHg==
X-Gm-Message-State: AOJu0YwPEVSm2Ywzk3iQQ2qGpfw3byIEfblkSSJoA4Neqtu8DSwVJ/i8
	QFuUDDqLUO9zJNskTVV29SupgKCZjpIcvbTlX5gL1otu2L3sW3fC9I4SUI6iCA==
X-Gm-Gg: AR+sD13FubR6G+w2F/1QQVkFTveYeyuxkpwgpiJal+Nxg1OP96SFqCifkgJJ228ueW7
	qlY50lJ7TMKAXlkee9mhczLs4ub79Mbz9AP48bTjbPtRjOmdGeMKm8FaIeQNsKf+rPiDOpQNDsA
	5RQIaBUA1Um5BAiHqXBW92+BqaKJ/BNQlRL/jBFbagqBW2BWAQbb0YWNQP6oqcXFxwmA3yVK8eb
	E3vYlS/SttIFKnusMMqFU0VqfXyuX7FLuWzcmF1hpfCCF4xCcM6d0/VR84FMHJwdz0bggd+ZHbM
	s9jFT807lNxl4TjG3NdnYQU8so9vFlWkB4K2Pt5aAvdxto1b60LehfmC3EXC3OQWi74pSmWmXMw
	B3K2p2A6jlcWvWiDPian/cXC09ALYtdwhwMF+KYZDgvEs+K1bWC5P1WILuJ6JwWVAHPGjtz0wlI
	HtPkT3LFbiE9LCXTM0o+Sem3M/3woCKri20eOmMhAzmdIXxXcY0FrdX53+lmWw84+x6rAE
X-Received: by 2002:a05:600c:6748:b0:497:fecd:5b00 with SMTP id 5b1f17b1804b1-499aa1d0670mr56106685e9.9.1787128788828;
        Wed, 19 Aug 2026 01:39:48 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0dd3c9sm44758655e9.12.2026.08.19.01.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:39:48 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	nipun.gupta@amd.com,
	nikhil.agarwal@amd.com
Subject: [PATCH] vfio/cdx: prevent read-only region mappings from becoming writable
Date: Wed, 19 Aug 2026 11:39:43 +0300
Message-ID: <20260819083943.1391-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_cdx_mmap() rejects writable mappings of regions without the WRITE
flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect(),
writing to MMIO regions the device marks read-only.

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445) and
drm/panthor (CVE-2024-53071) and ptp: vmclock (commit
a5edadbae57e2298a56cf7a4e774a027905a331f).

Fixes: 234489ac56130 ("vfio/cdx: add support for CDX bus")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
--- a/drivers/vfio/cdx/main.c
+++ b/drivers/vfio/cdx/main.c
@@ -284,5 +284,9 @@
 	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE) &&
 	    (vma->vm_flags & VM_WRITE))
 		return -EPERM;

+	/* Prevent read-only region mappings from being upgraded with mprotect() */
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
+		vm_flags_clear(vma, VM_MAYWRITE);
+
 	return vfio_cdx_mmap_mmio(vdev->regions[index], vma);
 }
