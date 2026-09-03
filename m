Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B6472093
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427779; cv=none; b=f01XpFTX98xC/VX4HM0cdjcbeI6E1eTrsJH4S/qmiDSVCs2ORcnmFXv7eaZRxbX5vlPoa1juIEmgRtm/1maH/vZivApebyGsUy3ss2ekQfz6TLc0HC247g6kfTzCIArG7KI6+5eecblqb20kGgqTscFo6OyXNEsKsPuELDtkG68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427779; c=relaxed/simple;
	bh=97tOsgvmm7X1epfGoYPiV/SmrI1Y4zgVj/hv/un0+0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jM2ymu5R5biVR0+XAZn5TTi9xAZsjVG3oIkMdhZRoz7P4AL+ZacbG4UySGWg9YcTsHY8q7X7X6Nb4o/yo/x/SEDWyxse1Zk18tQxNPNEQef+7/uvFt3a3b+xj4gj6p8jijkeuJ1E5rKOKU3ZrX349ahQ4ZlmLTA6uVD0j0CNCGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFaHxRuO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFaHxRuO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so17452555e9.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 02:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788427776; x=1789032576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vxgMPMXFY5ML7LzmKL13A6JFIKTjcrgE7JC1G5UiQIg=;
        b=sFaHxRuOuHkqCOOwEGBJxH/ZNQOy6ZeN2CEsl65SdBzyhK6CUIBqfGs34W1jPCnM3j
         zBKCTzq7A8/Q5uEjK0YvHSAq9uMaxMeKCjyDcl8a0WRAuX8j17jZfHxaEwleNUOFSzqN
         onCEtYtCgBtgLEul+CF9HAMj/tVHgQnFDQbPsjHM1BDlxr/Sx8faWF+BlgaA/bJyXwSM
         J4aohh5YdXkbXHwi7l3SrVcSFOnWhL0pM3bPKVG7SJp6ymREmFYY4e9/rvu/nZIsIpge
         zrwaaDvyRZojM8bIEnfVHZnvpe8SkAtUoeh8r1YqahMS8bE+jBDJAQcouJeMu/3kg0VY
         ijhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427776; x=1789032576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vxgMPMXFY5ML7LzmKL13A6JFIKTjcrgE7JC1G5UiQIg=;
        b=YBv6JTesMGsR0bPPB0I4yNu3FnuBsSXX1Y+d17E4EG47xckOuGCaUxyeChrSeYbuiB
         e50abV0WOhUI/ji688hlwSumo6a5cUnZJQk824EFHEPSUz8KBqp+IcZ/tZYXkGXZYFMZ
         EGSMesaXVFe72UPHUyNldWiDkN+JFWr1SenZhjnOsPhBEyg/ttr8DqVsOtw2Zdy+UMvb
         4TLD7rlZledz25jzn0i3xGjAq0Vz3fHPeKGSBponCK0SkNxaQ0WzpV7ip/d5MtmYtXnR
         Bj1UrePrw9ieGaI5SEWA8jHjkd3vJsizlvbpAuxUq/caPsPCPY1N8L95bdIaCw2VMZwl
         Wt0w==
X-Gm-Message-State: AFuF++nr1DxB7rK2+AmBdRz6fSeJqrdoBrYWUV1r+8y9Dqmpgtg/3W3V
	gRSGnk9qWbLw0Z1I1kUyYKBi/nLT8ZQ9k3PI+fukBJaRoAIiQK+5gNDb4v//bg==
X-Gm-Gg: AYBFou1/rplkTuSMQL+VYkmzxKQTPLZgJeXfMq1bxXdx4G2TqH/ZaTxfD2at+noa4pi
	pq0kLqcb3YT5PlwiEfam4YxlWV1M+ufNbj40jEoTTvMqU0ZOvVO7oxF/Yp1c0QsP5BbQ6I8VCp/
	5e82N/7OEdIoi6POhpKwMAqb3xBFF9cAn1mgGs9EHIwQkP/CawYcZSlcAtGIBDh8Dju93JY9NvI
	MRYKKLx47PcCkmxD//bJikqvHmyS9BUcwNjoFiXQSwSB1m3331gfmhAUO5pG/IuliQRa2haIK9P
	6w/51aIFJRNy3PQcmDA9cwuNQ9nZXdTPCbrWrkosClaY3KobrZWcufoi5x1NvwTB2y1yP/cFkGu
	J3xc35MWeFb1stWV/QLXMllDSZ1cfxMziSnzsmoEeOXhkjyRfJ/SMh3eeRzMM9Q6RtRHXKaHmYC
	jJMQXVgRJ0QpoAnzMPkmcxG8SEQzXpbbw20YOGJOcso/ybp5RKTE9Yw3KpyfON1I13csU=
X-Received: by 2002:a05:600c:8705:b0:49c:dca2:ac47 with SMTP id 5b1f17b1804b1-49ce57ec7efmr197647145e9.2.1788427775572;
        Thu, 03 Sep 2026 02:29:35 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.114.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d587csm60133625e9.4.2026.09.03.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:29:35 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH] vfio/cdx: keep logical vm_pgoff in MMIO region mmap
Date: Thu,  3 Sep 2026 12:29:32 +0300
Message-ID: <20260903092932.526-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Fixes: 234489ac56130 ("vfio/cdx: add support for CDX bus")
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
