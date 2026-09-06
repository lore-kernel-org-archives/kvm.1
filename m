Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DBF17BED0
	for <kvm@vger.kernel.org>; Sun,  6 Sep 2026 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788697975; cv=none; b=Iwz1ziLF/nottTV1l3yn08lBz1DiuwjyDxRQUzeoM9VZ6MGZMn2IECJWn35tq9riqhlXVU+ork5HYH1IHysiNAXDR97tOlDa9Y1kGmjXt7Hqlk6fK3VPMDdZIb3EW8sgXSMIcdGgC8l/FD+TVYHg7lHZfmrSUMsrE4ga6eDuGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788697975; c=relaxed/simple;
	bh=QZpRjrHV+J4MMT8is78qjt/sCIzgcyFx0mMCFc30Gro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FjGsPVByPD9UQXQ7gtqbvFkVqAXkZpVROT0naJBpJadlLu/27kXJiS8evWTnSExjj5DxKB9dKbrU6eCOBGGkLhlhsZr5QC0JNAb1vPiF+f8VYlL094CZpNsNgAilu88Tkl134sbnX8NB3YXOTPvcjnaACBGGDsH0nOV5SV6S+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3pa+Xd5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3pa+Xd5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b0dd3c9a0so23644235e9.1
        for <kvm@vger.kernel.org>; Sun, 06 Sep 2026 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788697971; x=1789302771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jIibNgs8Krb7tg9X0n9WFATE13lNyIMC7DEY7kH1e2s=;
        b=E3pa+Xd5L2QTd+u5ohrvljLYXn7SyYO8d4hL3eHRHII3LWI5ZbFtRX0cPIaWkAlsH4
         0BLpGteEQI6/ZX/48k/UbTPhQwV1eQAuNzDEqZcYJssT3WpnxLVytL1ARdOu9N9LsJmc
         +771jqF6MEZHv/ePrFWATHLVNxcbuRTFF7Suv53x6oql6p3i2qOT2iY1j5eBucysouUS
         vwfBZ7SZNPBhepcVQ/GluJrLLfzz428MZ+yLu3D0hM+kNzmZJuMV9k6Abgm0wmv9V8Qj
         kj1Ab0ShcweKtxfWg2B6Brngf97CrWgooeJwKPkBFDVCpV1pb+AvPbMckDgVbmjtSa5p
         SZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788697971; x=1789302771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jIibNgs8Krb7tg9X0n9WFATE13lNyIMC7DEY7kH1e2s=;
        b=hIuZKnVEFi+Kx0rGuo4hUFHgqneMhfJv2TXZQefwkMBWrI6wKxooBa2wNEjbKcZcqT
         +XdRslUKnM3tbJXLNUpApoM7KwfOYQDANpFtRAIRe1OTRDtr4n9ShUJERYy6P0PulHt+
         tZiyfWoObE8l/UzUC28FgJjq+AMJovB8FCaA0YjtE5pVC14HBjF5pu28q5T30FSvT1ad
         5kmj5xESPDUrRapRZllfrMqiQaOZ2vsSJ1ZNUOXUf1IRtEzL2yXUUcxogbUesXfBQEle
         HWiRQKIWM8lIAc6SaOjkSKLUcNtj/te04QjDkJy7Z/LWYGYEAU5AYpvGYV1EW3TgSi1k
         VVWg==
X-Gm-Message-State: AFuF++kuMwEiCKfvBtsmTlKdCeRFnBmNONxB/M5I1d1/OB44O+1PTpOd
	3kRHHEfUTC+oVb2kvI30eLwJI5iUhtiowiiQqZWexPmYY51qyHXnvhdwQ1Q4dA==
X-Gm-Gg: AYBFou1ju2SQMiC2Pyv0XoaamlLxH2U+P/Mc2GPSCUoIyptM4+HDIp71nPr4l2K9ZbS
	9oRbYhn9fTZH8erTGSPbu1w9ojqEK+2/4VEEP3qm2j1I2cJOD1DuxPqdzYwjVUTTFu5gIcKbvox
	DBkWogjS0jmVrGF9cj74UgrxnTRJG9JQQ7hQLnmg/toiFcyeFz+eK8gyN4DB7752j0uhsKUsiZa
	qzAhg8aui4IiRW8h8PewAAWJq87u6ozP1parck8fSi9KlmsTTrXoggsMv1jJ8oEGFJTrdMtN8Ri
	qtFO3vrGfKLNviUVYvkEtOFgnQ+HW7P+RfqcCVwpEXbHsahFCsnPkqXBqWnqFTjXMuD7yZIT53C
	3cpaPqKM7odxyxWlsRXDHCFuRC32uyhLLXUBm95TAbNAgnoAd43bRfSjeOftsBpz/cbcwgKfHEs
	bYJhm3HvIGaFjr4QE5684tvXTs7kSZtdTpV8owdS0GJBz4kUOAI8dgu95jWJeeCY1ykZjt
X-Received: by 2002:a05:600c:860b:b0:49c:ee20:e787 with SMTP id 5b1f17b1804b1-49cf7fe62e9mr350730675e9.1.1788697971132;
        Sun, 06 Sep 2026 05:32:51 -0700 (PDT)
Received: from SurHub.localdomain ([102.218.51.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6023edsm307138535e9.7.2026.09.06.05.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 05:32:50 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nipun.gupta@amd.com,
	nikhil.agarwal@amd.com,
	alex.williamson@redhat.com,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: [PATCH] vfio/cdx: reject non-shared MMIO mmaps
Date: Sun,  6 Sep 2026 15:32:45 +0300
Message-ID: <20260906123245.10884-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_cdx_mmap() accepts MAP_PRIVATE mappings.  A non-shared mapping
with VM_MAYWRITE is a COW mapping, and remap_pfn_range()'s COW special
case in get_remap_pgoff() then overwrites vma->vm_pgoff with the
physical frame number:

	if (is_cow) {
		if (addr != vm_start || end != vm_end)
			return -EINVAL;
		*vm_pgoff_p = pfn;
	}

The VMA is inserted into the device file's mapping->i_mmap interval
tree keyed by vm_pgoff, which VFIO expects to be the logical file
offset: the core links every device mmap to the device inode's
i_mapping precisely so that unmap_mapping_range() can revoke all
mappings associated with a device (see vfio_device_cdev_open()).

A raw PFN in vm_pgoff lands the interval tree entry in the wrong
coordinate space, so unmap_mapping_range() cannot find the VMA and a
stale MMIO mapping survives any revocation attempt.  Without this
check, a MAP_PRIVATE mapping reintroduces that corruption even with
the logical-vm_pgoff fix in place.

Require VM_SHARED as vfio-pci, vfio/fsl-mc and vfio/platform already
do.

Fixes: 234489ac56130 ("vfio/cdx: add support for CDX bus")
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---
 drivers/vfio/cdx/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
index b31ed4be7bdc1..6d208db0896d6 100644
--- a/drivers/vfio/cdx/main.c
+++ b/drivers/vfio/cdx/main.c
@@ -271,6 +271,9 @@ static int vfio_cdx_mmap(struct vfio_device *core_vdev,
 
 	index = vma->vm_pgoff >> (VFIO_CDX_OFFSET_SHIFT - PAGE_SHIFT);
 
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
 	if (index >= cdx_dev->res_count)
 		return -EINVAL;
 
-- 
2.53.0

