Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3307D470E96
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427774; cv=none; b=KisxUnM+U0q9RDX8ZdXSU0GicPwhz4hOQE65pQC0YP5dvsfVtr+U1pbs9BQpsImvB1ZSMh9W1yO35XLFNjZESN9dPIJJ7hNRfY4NnRa+1tlqQg1nYSziujvAW5MbCDCciEwZcdCJ0EZPf0fSWM+glqQYgGwI6zUNqSl6SNzimhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427774; c=relaxed/simple;
	bh=slMj07LDzh+7KKdhde6CDLMQ2ONvmT8oZoEQIoEqyBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LMRTOIke5crSbZqqO77fPyc+URQljnoqVz/NeoM+yKS+9jRK5SjVeM18jx7SqMintzBlN4PSX+eaQTURFxFSCAZ0vGCdxTwTVtMeEDTBN90NhJd+Sxzpvu8669CaK/B5gaKS3dNHO9qY14TFZItlKW6wKvgO/nVYnX2QwdjfhYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpoEpwpn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpoEpwpn"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4843efcbdb2so1390716f8f.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 02:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788427771; x=1789032571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iTlhcsnqzkHfBDGujwqi+RIHWDNjq6XrFKufOw7QT0g=;
        b=XpoEpwpnaisuEWYNzitEQl+0qAU0xS/aS3EsiYQ/z0uHL++798cAXpR/Q9N/g9rtE9
         UmasRCOxrkt2asK2UZGplffd14VsGirzSpi7dAjKOiz1pSuLrNshMQVKds/9BBN5vgJd
         wvAM71e3UH1IukJWgxDzTH1fu4w0w0zb9hNX2bpe1ZwZ2MNBoRiD/v5thmdnZ5Se2v9s
         +M5inA+Am9nMegsGHmdRd9Ox8bAyxUHS6vHQDpu7WxJiMSSI/mcMxcVDLE5U9y3Fb1FK
         Wh5zp3q767ucbKFTPY8wR2hrYonVVdteULcYYdilfkNqBS2HS/P3S4UtVWcPvqr23tmX
         AlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427771; x=1789032571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iTlhcsnqzkHfBDGujwqi+RIHWDNjq6XrFKufOw7QT0g=;
        b=fPbSCrsDPQR/cd9PxxAn8/Vz+4tgJ6ld8lic3Naw/wG2lMa7/INnf5z6sUZ2HOfO1q
         +B4e1CPeoUR9CcscwP/omsKg/yN9OHtYn54VRnlPiTRlARUuDqVZQfLkJ2A1TdS2wI5l
         4zOdV9FoaYIzLTfkfiMbBcbzSibuEuDFQj1T7TUg2h7ogjJ/4z717S6/E537KeoanMAI
         lKh0YfUfnDdeS/kOrZ7TFRTGY67CobEjSMRxnY5rM1cHSJi+Nj5ABLqJDkVV0OUkT78h
         5bHpb/uT9n73sGf6gxCEyMkF0f19/TLz+5r9b2vOLVlPoM/R+VXEV0uL4FWXpK2Rzckd
         z44A==
X-Gm-Message-State: AFuF++nAP2EWawaAP/bsD3kUReuQz13xhuVBPs7e3uHdGYeodQPB/TBj
	/dMG/zGTimXdu4cQR5FeaBMcXn3a9+aTvtEEh4ZGdOudRGHgM6V5eZvP/rAyWA==
X-Gm-Gg: AYBFou2bpno0V+EuJFTGsTx+SS1HVaWk1ew0gF7HoBMA8WmIt3VAsLuWKtzb7wtjEsI
	PeAqjhQLRaeXMoprCZ0OGvJL2D8ecrEVqD+BQpyHywSWpQZ2Cceb93or18E8qRpEy4MaVpWy49M
	2PE2YxpLJi6KfU8QKE3hrwBfmGJEC8Rfc7JY7ObJ6V1wPwJ8MIB/h4mhxuzxZ7LmEqIysi+zmPZ
	oGaRj1lYOPVe2D6pLAnR4dS4SHDGAlsubyXi5xEg+jUUnZCbmKBYE3KxzMqyZkkJb3WZiWrNF2X
	ryy6uaZHm779CDiiBFBoJuHt6cj2NgJm9+nZrt5pi03tJivzxL/tHUfn/PLBetwPLVLh+TR216W
	vhMjOIHvAQQNaRgT+rT5ErrxlKoWQ6pYg8pX4x1FKMah2DwJoYAj1MQjGUqTYT8kKPByvSozOTd
	MHyekGwsoJcmt1HvlZ+0oFs4cVOxIJ2XXAQtwviGHdklZNjmmifemUxmc49JJl7WZ7qhA=
X-Received: by 2002:a05:6000:18a9:b0:482:f724:f4ba with SMTP id ffacd0b85a97d-484913c37dcmr19695539f8f.19.1788427771368;
        Thu, 03 Sep 2026 02:29:31 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.114.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed30c0sm12772159f8f.24.2026.09.03.02.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:29:31 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Eric Auger <eric.auger@redhat.com>,
	Mostafa Saleh <smostafa@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH] vfio/platform: keep logical vm_pgoff in MMIO region mmap
Date: Thu,  3 Sep 2026 12:29:27 +0300
Message-ID: <20260903092927.502-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Fixes: fad4d5b1f042a ("vfio/platform: support MMAP of MMIO regions")
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -559,6 +559,5 @@
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
-
-	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+	return remap_pfn_range(vma, vma->vm_start,
+			       (region.addr >> PAGE_SHIFT) + pgoff,
 			       req_len, vma->vm_page_prot);
 }
