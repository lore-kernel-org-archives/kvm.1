Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2794FD7B8
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675348; cv=none; b=bYaZpObxcUo4h5438w3anaIyJi4XXiOFQmyZMyPPEImiMyD0SymiFes0veBRby/tBL1kVhiDQa/Ue2MF2yEiTAmufhc/D3c0xORvJ8xQWWIIkuepRlN0nFLGLhnF+4MZx5V4Gays/rnCfbyYc5SozkhoB/B4EwxIcgrK41FmNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675348; c=relaxed/simple;
	bh=iqpbgIcuh9iCNLrVRX9mzEdLHHas24ifzA5YROCsukA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXUm5/g2+PIFrquZWwi0EkSGzScNqExmNK4xD7s4Nch1EoCu9UHTICo8Fp/CxpeWcn4U3IsnkJgGJ7fb0ebSLZ+Qo5DcfL5AIK2Qj5AHPeZ+Fs6ykb8G2qMb6vhiTDllZgJ0gZZV92sOzYNlPr40Yex0WPetO3NR1eXG/zDNzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qia0z73Q; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qia0z73Q"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso29324555e9.2
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 02:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790675342; x=1791280142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hyio1wh95j9ctU9oUBQpxlfVjmmC3Y8u2BtQy9SpKZE=;
        b=qia0z73QzLpAIv+K8rlTXHfSiRLSleR3pKNKYHmD2UKy0pxHqu25+neIpqSku+SBfz
         EL8TauKzaCPvmdBXimGPqQ1bP8Pgx7gtA0vn6MHdfnU0UvH7UIDTiDq8JooA76lNKl4K
         Wg5j+95r+s2F+COdVEJ4np6uAWmAZDq1DvIxyQ4uWfdEKcwcalAkI9/p2lfWConzs+ee
         vPILN7XZ/Kjnt8sgoNP4ugnBP9pbcP6X2DZ8tNKaBLyzqrxYtsXyjq5UQrGfDml6h9R5
         K0ZgGGOmPCOE1BuKUYyPSLlKDfvpl+dwrHRFi26DiavSNjyPnSOEq91N8FqIAnYGLruU
         SiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790675342; x=1791280142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hyio1wh95j9ctU9oUBQpxlfVjmmC3Y8u2BtQy9SpKZE=;
        b=h47ZcX957mwqdQ9+cR2E4y75lQ/psUHWjtNh4TSOZfmu3Eu+mBg1SNt4V+YH33l4r2
         84yXET3cT9gIkDoLPWFPMcmsAzDobG1hSgXNYOwEEok/+Iixgym37epk55+60L4TUsuI
         wk6LnYk/yydmkWKTBpguRh1moViPfCvPwd1HHPzEhjVfJ8VyYOTPIq++eVZwT7ENMUaf
         oTGYDDzA37hEsA9d5LtuZ2l3q38dNNnIkDtCS5iQlK+kA2yeURhhg9bMGFS23BI5wS9M
         cK0rdvipi1mt4cqCW7/ITDX/zr7jYl3ZIKUsgNY4nC3MsXxlsWh6+Cyl7VA8jgtNAevQ
         5xGQ==
X-Gm-Message-State: AFuF++nSuzRCD+i60jduOSLqgg4KmPxudqcCXpl6tEEy2qbrk7uoOfjJ
	0bn1UAyhKgB2NLzS5SaroLiZILRAJQT1Q6UhRubqsNfyFoYouPwt02Re1XxVmw==
X-Gm-Gg: AYBFou0NAJi3ap/c/ocinx0PUl/oaPzUs2oiVVyR6/F6OXwIbEvcalhKQz2jz+4XnH0
	UXRMB119+xD0Yzg3AIRBjDI9XQXNVCv7BsmDuGc8F8/snfeDuhplNXqJ/MkvQECK8pbJVHlaGLd
	sTAcNXZkNAG0Er3vVhbr+h/pnKvYJWraiE37ALOU5ogbz8kGEVsfNKBWMYQK0HdY3EMbTTW7xj/
	Aku0A9lWR7ONsDSYNDjLdNuAvq/SaqQT9+oARITNXsx6dGFhRVNSvn3gt7TBTAfX3kXJ7auuDFc
	o2X5O31z9FuszaYpwksSPOrZzUIAPnDr8K6phqDdSiFTCVTtkSxqzI48YQL8gnt7Ge4ZbL5MDlO
	ZkQxvxhQZ39dcV/0Og/3YJQl4UlyFYLKKri40sKJpPgCiNs0bQ+ZXqKzwzA5FfyXOclhYuOu4E5
	Q/YjTx5tgJUT/+MPAvAO8GW4nMAcmSwRg4cn9qbYLx7lddK9eth8eP18p09GHVt8fK+fQ+9O6Lk
	+27
X-Received: by 2002:a05:600c:4504:b0:49f:ff09:3b57 with SMTP id 5b1f17b1804b1-49fff251664mr125841895e9.10.1790675341793;
        Tue, 29 Sep 2026 02:49:01 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.113.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9b72fsm89821455e9.9.2026.09.29.02.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:49:01 -0700 (PDT)
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
Subject: [PATCH v2 4/7] vfio/platform: keep logical vm_pgoff in MMIO region mmap
Date: Tue, 29 Sep 2026 12:48:45 +0300
Message-ID: <20260929094848.7439-5-suruurism@gmail.com>
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

vfio_platform_mmap_mmio() overwrites vma->vm_pgoff with the physical
frame number of the MMIO region and passes it to remap_pfn_range().
The VMA is inserted into the device file's mapping->i_mmap interval
tree keyed by vm_pgoff, which VFIO expects to be the logical file
offset: the core links every device mmap to the device inode's
i_mapping precisely so that unmap_mapping_range() can revoke all
mappings associated with a device (see vfio_device_cdev_open()).

With a raw PFN in vm_pgoff the interval tree entry lands in the wrong
coordinate space and unmap_mapping_range() cannot find the VMA,
leaving stale MMIO mappings behind any revocation attempt.  Keep
vm_pgoff in the logical VFIO offset space, as vfio-pci does, and pass
the physical PFN to remap_pfn_range() explicitly.

This is defensive hygiene: none of vfio-platform, vfio/fsl-mc and
vfio/cdx call unmap_mapping_range() today, so no reachable
stale-mapping issue exists.  Keeping vm_pgoff logical preserves the
VFIO core contract for any future revocation path.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---
 drivers/vfio/platform/vfio_platform_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index ab531318f170a..e8cfa76ad7f87 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -559,9 +559,8 @@ static int vfio_platform_mmap_mmio(struct vfio_platform_region region,
 		return -EINVAL;
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
-
-	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+	return remap_pfn_range(vma, vma->vm_start,
+			       (region.addr >> PAGE_SHIFT) + pgoff,
 			       req_len, vma->vm_page_prot);
 }
 
-- 
2.53.0

