Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1449B5A8
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993434; cv=none; b=M2lli45e4byaEsvqdi0RGNBx0N41ekxXkiL3x6NFnr554XrNdBBuyrY+pHaXMMak+Sdm8GrPlEEayW07v1Qa4uItC0VX28E4X5SRvYzD6ZRHPqqYWbh+VPXRK8QvmyXQ78FGXJXSoj2Akv0jYHx0KSzepRBbV02b4o701oD+GMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993434; c=relaxed/simple;
	bh=lHBCLvD9CFWwUxarJDk4h3SsAeacuQKNyNWI8I1jmRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDRb6d9WnyW9N7ht7IQRfVLLdUKJX3YoUV86dH0pZ1uHpXD8pD/DxyzqgTgJuFEUfDQvuB9JKW2o/n6iI+V9XE7BfLEW/rwEv7Yts1yZY1vq07LrEFsUbxU8eo1w9idYuxKKsh4uh7xLzJvjFU4BtGv9nWJ0uY6m0orhq+RtLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MO/WfLh/; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MO/WfLh/"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a803458ba0so3777428a12.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 05:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789993430; x=1790598230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0DZFsAd1gCt8HtlyNvooZMCa7qVbQcWPBgvKmJUoZ8A=;
        b=MO/WfLh/O5Sw2ACQyyAwmvsdCMEMYB5jKDO/HT+hz+8YG+y/r96MqBDtwQMGjreJyP
         1TRWCjJmz3C2fJb/D2WJcf92s4tjY1ox7SqS5pZGnNJH92iqKD9r6AjIqi/MYSOOAfUm
         guXGqjIrDYFTgw2V+3vd2PgeZp0WIMcSy/zouI3PXkzGtspcf40/U+4qa7bAglg16SZK
         TRfeqb8s84dKzz9uU6r3ZiUF0Vs9W+YBBPSO2VZZYmhxblc1YeRuR0b3OG4rkMqTeocx
         wqguDOossWfI/4hsEcrzwyoWfoTXyJfiW5JkuH5PAYd5l0JCAWOeC/5sr29+XPQUYxOZ
         79uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789993430; x=1790598230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0DZFsAd1gCt8HtlyNvooZMCa7qVbQcWPBgvKmJUoZ8A=;
        b=cERyZZ7a1IE5MlNm6wFAsT1t5NIBgfspVBOv2FSdcezUbHG7AiGXGHCZNZ6Z6hOI5Q
         hqv+nvBt9wotjvVrrH2Rioq/mP4pto7a8gG+Iq8kutTKJIy5WFZW50/H0TW5YQwT8GsD
         X/VcK5pvHd11UL+PaYhzEWd0QyvYzHqWpz0L87xXRlXqwOujY61Fa/NtaaN99RLPjCzE
         6YUpQbq0kg9THs+FGzGJSGsdIQQD17FKKFwQlOz2hFOsVjlS6rd92gEKa545/wlNxWW5
         0GIeBcrJDQKJpbsX/s+iR3NoPvz/NUjJPEkFF8FgySX59CWsBiAhkwERDpr1HoXjTT0J
         +x0w==
X-Gm-Message-State: AFuF++l2q7t5uM2wJW2BvAvIOJIahaEU/IdEbvgeYBk1XIZ/BNamwl7Z
	Xun3EVwD71F8utSZ4OX4B1Z6tOCe3nGsf9OjA62pRgZUh7Wb7RfDQ1UGG0PDSA==
X-Gm-Gg: AYBFou0IWuevHtz3sYpa33jKP1eD4aygCFcn59i+rmbxAvoDWLHPIRxGh40RLvvDdmH
	X3bQuUV4L/hYf2GJU1Zt/y+GZ4JJSJvIZmSPLv7nkfcbvdKn+GTLfHvHJN+6zGq8VS9gx8bvAWu
	NhNNn3KhZWe+CRltWwm9DcpRXGqIi1QDio63IZZVudZSdv0mJ3gehBWKtWFI9N0M7YKxzyLUqbX
	2CHpja5zIa1ZtqCQlt1mFtf9otGnuOA8zpOYSg6scpH4bAwVHu0zka66RUUpNxhmk+ijtrZKKyW
	dl5SESXQlG1MZHU4WF12iQDIlrvwSaP6sCWkBHquv3AtvWKtph5pQNK2Quj3ezHwFhcUkknKtgx
	5dRPSa0eP5Tx7v2OCxvuJ5o1wkLwJ7In+6zYsHp/TJsSXi7BGR1TJasH+0dfIcPw2E7TZsugQgJ
	5VTwO6+XbS/4p6Up40BbRJhKZGEDa3Do+b2b432o+rrk2eB16UxjsX9azWaZO0SYRSOqkeV++lL
	aeKEg==
X-Received: by 2002:a05:6402:21d3:b0:6a7:ee56:6156 with SMTP id 4fb4d7f45d1cf-6aa5637bd3cmr7056944a12.24.1789993430163;
        Mon, 21 Sep 2026 05:23:50 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67b5eddcsm4228761a12.0.2026.09.21.05.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:23:49 -0700 (PDT)
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
Subject: [PATCH 5/7] vfio/fsl-mc: keep logical vm_pgoff in MMIO region mmap
Date: Mon, 21 Sep 2026 15:23:32 +0300
Message-ID: <20260921122334.2099-6-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921122334.2099-1-suruurism@gmail.com>
References: <20260921122334.2099-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_fsl_mc_mmap_mmio() overwrites vma->vm_pgoff with the physical
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

Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -369,8 +369,7 @@
 	if (!region_cacheable)
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

-	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
-
-	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+	return remap_pfn_range(vma, vma->vm_start,
+			       (region.addr >> PAGE_SHIFT) + pgoff,
 			       size, vma->vm_page_prot);
 }
