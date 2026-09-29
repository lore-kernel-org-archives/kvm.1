Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669664FDA5D
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675350; cv=none; b=eP0dtWkJrT+x3AHdVaVN9o95VTL52QTNLmehB1JmpsV8t5bdHRBX4xSV20cTm69MbA8JAWmfETYPvrDGFo/4M6mUgjKg5QgewoNSbCQ45ucuD7I/dNRcRWkFVQX1okFdUOzxhON14FE0EAjo5w5/PWr62AjiYKsya+cdtmatzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675350; c=relaxed/simple;
	bh=4mtz3F9XvkhZzi1HVdRKJIb48VIOMWlFxg7+FHKbMzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFu62onyeknb2ZLUb8fSOu/WRDHVQq/VSHshqwWJdgnaR0soZq8lCqu3T0CISjbFLa7apvfa+d3k89wsIRe3EhuudPuhTIr7/sGfCNF0fW7AcCcZ4cUdPnB5kvNQzsxMphpp9092G5oZN2IQq7MAYeJmxmxCwv2+LBqob83f0Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsG3Ikxn; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsG3Ikxn"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so30187855e9.3
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 02:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790675344; x=1791280144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bzjWScFRE8+J0efyr1jf3tpnLnL6de369Jd4yW9gblM=;
        b=IsG3IkxnmspscEq/vGOvzKGaqAL0/P/zmEI8ysqzU9SL47ofyN7EeG7fQpZ8p/zgNI
         ClOOELnSpRrsl3KGyDt7tlDlpicpdEwV9CgiCH9smQB9yDU/jsAMtpEmVnP/TboL9WuY
         y2XmfZ8juIi4SmEDSYQLWM7utMjiZk20oUSFH5orbuqVB5JLn1KYdYFSE0VG5e6IjnDU
         hEaL4oVvNe7g9I9drfEvOz9XNWKYOGg2AIreQ/LJiR31XoskqrdcfVdfARlZR6DSzUX9
         NcZ5qJ6KyHNh4DUSZ7IGVZdguddMX1uVB1rlJcH3VU+wfWxFXVXvpMzHEe6DeV8facVi
         rjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790675344; x=1791280144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bzjWScFRE8+J0efyr1jf3tpnLnL6de369Jd4yW9gblM=;
        b=ett+7kicvHyTAUCKDqo12BjJbWb9txh0k/UEWQrgDxnfLTtcunkAqbSb+y+s4uLhjz
         YSVw9kVzMGGSVtIIYiJsbut65Y2p8nI7KnvmVMQno8rGGxE/fumR+Glh2GGPhg0huPzc
         A+55mFiAm5sb2ZBPhh7u+ZPktRE2O/QLZdSB/LxsdTTmLTXSuMqxelo5zh68p8e7RAuh
         yvC8RsEPnQtFyylci0Vu5WzO2IHKXacfV+hxdh0vrwPh5hl6LxHyb4Sv12tcHENjbJqg
         OrHvTT/7MWdXrv48lopW2R8H5WuzNgkAwmAR3JFJCYIu/S8rwqnH2QtNjJQnPzoV+q7z
         +lxg==
X-Gm-Message-State: AFuF++kESdlUO5NjYhsIT3BnLss2fCOsY85raJOD2NTYmM6MvndncYss
	IYG7KypysabiEy65rLP4l3s+bFZmneaB9eAXc+w4EtOGKA8ua7g0cABwg/A6gg==
X-Gm-Gg: AYBFou1OWTmTOZQA0pDVqxWkQC9YZHFNMfLtsS1EGxZb1d6z3YcKohNstgdIxZQ9By4
	Fc5ROS0MKrrIN87FyBuzyA49Dhdf+ppUhGFiNM7R5HPc3shXGn0X2eUjexOlG/r43twW/3ALn41
	moA8vJPPUg4DS51b6zGlPXh/6u8uPjjDRNbzlbfFdwC+evXanZEw5OCU5+mRDKhL8kl7umAf76M
	2od+W44M0+1+7OUUQg8RXdsHd6pDFXO//O5RbZJp6kqpNpTzQcbtD9C5ZpCyfv7+0sawCcHNXxV
	JXnoPAmBlebcNK0NtbRILAWBSiyYi5XgXV0DwxiytReX4PrPtIaieaId3ZcBLgM7TNYN+ouAmGX
	51e2FXXWDQTpa5YRYUTp3njI61byhdvmLshK236JUrdvMB4jzgT1FheimEjL3qaGIe4lMVBc9vO
	FghcoTrFxrwBjCItQnLlUL0lqntL5AMTlQ3Ua5+GbBnGEFkESZyZY+RsI1+dtdHFtxk8yHDhkyD
	68b
X-Received: by 2002:a05:600c:34d4:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-49fe66d1279mr239605565e9.10.1790675343795;
        Tue, 29 Sep 2026 02:49:03 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.113.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9b72fsm89821455e9.9.2026.09.29.02.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:49:03 -0700 (PDT)
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
Subject: [PATCH v2 5/7] vfio/fsl-mc: keep logical vm_pgoff in MMIO region mmap
Date: Tue, 29 Sep 2026 12:48:46 +0300
Message-ID: <20260929094848.7439-6-suruurism@gmail.com>
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
 drivers/vfio/fsl-mc/vfio_fsl_mc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
index 5a6cd78dcc06a..15b05b8c0c908 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -369,9 +369,8 @@ static int vfio_fsl_mc_mmap_mmio(struct vfio_fsl_mc_region region,
 	if (!region_cacheable)
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
-
-	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+	return remap_pfn_range(vma, vma->vm_start,
+			       (region.addr >> PAGE_SHIFT) + pgoff,
 			       size, vma->vm_page_prot);
 }
 
-- 
2.53.0

