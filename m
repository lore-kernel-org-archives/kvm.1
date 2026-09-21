Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC5D497B73
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993436; cv=none; b=NRWMZsgad/NApzqfeq5NeGk9qF233oYABNmZsVl3YgOxNZDKOBZve05odgKQ07HctT0capAjcgyrqUL/oZDzL6OeUeImPEHsrFJx+YfUhDlyDqsrCeEImiur+gvuXfXvIbd2LfCCxBLN/K3697hc8hSfRhEY/XbWdESgLPkSdjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993436; c=relaxed/simple;
	bh=T3FwPjlvnscQHR8jx5/rkQBZvadbHM0UeyhMOsIsDU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGqjO8zh5FagPlOOKDCjMS606cN2+fQMTCJ491aLwKtLj9y4fgjNbnMYspGrQr6o/gLGjnS512AewkKaC4nYjrDmJxX/nYMAIL1IvlJUhzQ56yhqnxmrIbaw866Ujw564OzMaX8lCTidvX5sKmNZV0qXrWt/In+Dw7MBxhUfAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Amhr/CNQ; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Amhr/CNQ"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a605844571so3465909a12.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789993432; x=1790598232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JE3HCQjPuIhn0lobZGGXaWXmcnd2kPkISnJT/NhU4vk=;
        b=Amhr/CNQGrSpEEWqX041ZVx/vyi1+48y2+h2e1kp1NDJjnlO8zbiFcy/jUrzdHQ93l
         dZCjK6jfoCM6dF9+LGmh1e7l14RFhj+lLd71q7Z6EhhUY5rg6JiyujkCM1DfGv2tqtPY
         dYp6u/RIDl4g8PXX8PE7rEvUT/mYl/+1b0+f7iyIinN/ddbvFsInY1I8y58qdfQuvl/K
         54HZEygdF4Iqzr/wJRg2/Rs0uhgHbykR96bKLnlCxqHSK6U1u+Lpz4kYUpmo30P8e8JK
         WwU1+QWeSPBbPXRdAzoignh+BD55ldtyOrcn8LCnS2xgbrmIv0TeZKGnvXkk8FogxjBZ
         O2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789993432; x=1790598232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JE3HCQjPuIhn0lobZGGXaWXmcnd2kPkISnJT/NhU4vk=;
        b=ejItsKuLa5hb47zIHYs41dtaXu3dwfOdl651/t4BZWOzPGDfbTU4NtKlMezfd0sUfc
         gRvZJ73qHh2KrRm+v0hNFvXht8yagkk2lJH+cI8Va8v/G23lX/XKR7jF/Y4Q13y0mQLE
         klltNTpkcWMtASYJhjJoYgLgnvn9wr7jUMfaSoujM18wgdqqxPJTfeCtX4m0pgvNduKA
         HaqfL/NVLtOaCqsE2xJmt1GmImmSVZGIRCggNw15BoFUc/TNaxchWkFrqGxA+HITomJ2
         YCRhwnQs5WtzbNN29GpHDOVPK0eJixZvKZHJSuzUpJKVlFMerXTKHOgOR+NLIBAgzyFt
         jIrQ==
X-Gm-Message-State: AFuF++kO70bgPUtLUnqP/BAqOGxcdNs7OTAbFsdV/qIqjLFlPYTrSJ3P
	DxqGc6OYQbiXQ1uYA/42DPCI3Lbi5bB1VNq2LCCzsCnAD8q21WL04oleccv/5Q==
X-Gm-Gg: AYBFou11/Vs4tW7tnGwUSHvv33Uijeo/lIXj232PiY7ihZi2Xx79USrxXzDQz3GjFJ1
	YE0N4HORJ0gbBahWZC0WTcl3kWRE2/hyzQx0RqUS9CS0VaAV5oU6OsAq9O5QCeIWtXLmNF/bABN
	Scg03/mc0c0lNarErhzQmROvd36dAGoSrHfQ3W2wHY20BBRE1zW8BRmlDdk0pdl3g5AO3Zj8Fs9
	LCIPjH5Vq23A+4YDDfV7RttsVARk+LA2uldeBwMZnGB46SEZILBEffPhKLOpjHRor1clKvQZ2fC
	iXoEkcF1olRKwdUgvtpQdfUdqgx8mARIGYCX7iPhT+iSv84qtnSX61B/hbv9zU6/kV7WzNHIOW2
	uI3h6lv95fRjx72bQAkFA7MH5HAQrWHgORVuX6nExR2edBgkksKM4KZQGH2LPp/IPAeztQ4+s0/
	j0vLmFrAqn9lAIlfvqpvvdVdNcjC9P52yr+wSmMKOk2bFi/rcibxJlPMif2rcrWlFowP3Ml0Rmx
	BMRsg==
X-Received: by 2002:a05:6402:52c3:b0:6a9:cae9:471 with SMTP id 4fb4d7f45d1cf-6aa5478b9dcmr7776900a12.21.1789993432123;
        Mon, 21 Sep 2026 05:23:52 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67b5eddcsm4228761a12.0.2026.09.21.05.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:23:51 -0700 (PDT)
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
Subject: [PATCH 6/7] vfio/cdx: keep logical vm_pgoff in MMIO region mmap
Date: Mon, 21 Sep 2026 15:23:33 +0300
Message-ID: <20260921122334.2099-7-suruurism@gmail.com>
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

vfio_cdx_mmap_mmio() overwrites vma->vm_pgoff with the physical frame
number of the MMIO region and passes it to io_remap_pfn_range().  The
VMA is inserted into the device file's mapping->i_mmap interval tree
keyed by vm_pgoff, which VFIO expects to be the logical file offset:
the core links every device mmap to the device inode's i_mapping
precisely so that unmap_mapping_range() can revoke all mappings
associated with a device (see vfio_device_cdev_open()).

With a raw PFN in vm_pgoff the interval tree entry lands in the wrong
coordinate space and unmap_mapping_range() cannot find the VMA,
leaving stale MMIO mappings behind any revocation attempt.  Keep
vm_pgoff in the logical VFIO offset space, as vfio-pci does, and pass
the physical PFN to io_remap_pfn_range() explicitly.

This is defensive hygiene: none of vfio-platform, vfio/fsl-mc and
vfio/cdx call unmap_mapping_range() today, so no reachable
stale-mapping issue exists.  Keeping vm_pgoff logical preserves the
VFIO core contract for any future revocation path.

Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---
--- a/drivers/vfio/cdx/main.c
+++ b/drivers/vfio/cdx/main.c
@@ -257,6 +257,6 @@
-	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
 	vma->vm_page_prot = pgprot_device(vma->vm_page_prot);

-	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+	return io_remap_pfn_range(vma, vma->vm_start,
+				  (region.addr >> PAGE_SHIFT) + pgoff,
 				  size, vma->vm_page_prot);
 }
