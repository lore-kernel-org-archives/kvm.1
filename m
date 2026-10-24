Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806943;
	b=EDSRqKEfz6D3JUQ88Yh9+wYj062MDXNyWScDhXhr1/ZQBq5o1WYMoh1aP/2bI+TZ0ugI
	 GQVdpBHDqqljlux6OqIjM+w/lmQxRkpJTtfZi8zKmJkYReeeCNTZmTn59Kz8dQ9NiAJob
	 0dICr2RapteTLAwDtYn7prcYlnFnrePEKrmNcky+M7c6HXbF8HoSJC/vDXSXrg+3H8fkH
	 v/234QWZgdF0Y6ev/aXCeVL/sG4nb48GR9JNy/adxBusAXndy8iUcE9bMbjeUuvzoFjkr
	 GyX0u18tFy3ggIBXNjrRFv06YAuhkXmSW1xKb/jj5SbhhBHaylaFzjRyRh4IIlh43/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=NgwkcAh7G7TyRAJ1hK5wESY+6h2tjx7+XcYt+feArG0=;
	b=P3L46oRAVdWhXA2mcIOQp1dTdDuJuscm+5A0YC1SL8wZj2BvAyyG4XGE7iHR6MZHlk3P
	 HY6ApjmgW+DY6Zhv5ERQPjlW7Pfmlw56IaITtO432vJZP0JoCpa233LId41KhWkSTgOou
	 0p1gwPfR2p4OKB0QnzOfgtCtSJRCnOCfYWsceuxW0mCEOObMpczqRuWa6dyN/vLtpMWoi
	 sxy6CMecDshIMe4adtfz/oAREW35DRwRmTbvIS1ateKyeWMZkNfwrNMdTtDCj+Vq69cdf
	 brvxQmsA/ZB4EVGVLAlyk3U7fwP2XnC9qWw7YwwHnZL+zKk2nlJ2IWanig5qwn+1JJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Nlbsh4UO;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB83606A31D
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 01:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EB83606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Nlbsh4UO
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-17dc865c94cso1463538c88.1
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 18:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792806942; x=1793411742; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NgwkcAh7G7TyRAJ1hK5wESY+6h2tjx7+XcYt+feArG0=;
        b=Nlbsh4UOoFahNOoAuPj9v5HGS1pWjjXyDelKFUfWeIl/2wsq76INs9hLZSw1vRPHLP
         PHUdbHiAcP2EYgQl4gowcoeh7tvDjvjksgmM+ACgDSdPeLJRQMeW3G91mctym84XiPkp
         JzJ5un+AD4vb/0YTZJiG5tVFwR+9NDlSIjvFrlTVIgvG+OJ5SZm2pYyeJ5oxZZyhp/vT
         LALC5IojEVkKlPHfITvWrT2nHkhC7Gr1KxKdfDlE2TYa0aehuG8PZbdyXOcD14zoPhIj
         JZ2hhzqAyZKvtNSmrxziWKv3L3VM0mNhlyCsk7dPIEfBTmjF3wrUMk+RpuAyICwQkqmf
         Lnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792806942; x=1793411742;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgwkcAh7G7TyRAJ1hK5wESY+6h2tjx7+XcYt+feArG0=;
        b=fPzyri6dR+qOL4o4pDMyZRx04HmeK1GF+1LuFgZrm7yF2dFuStwb5JUI+txvYM4peY
         zd8B5ESrY4E4ywfRg77Y1x3SIm4FfU0At/eaLvyiHid2oGwmYzlP95oUBfM34EG2niZH
         H+tyafoHULJG/mBQaBWRQ37qaUB3KMDHHFnKMsZnREUqiEcSrdvHoj9aYmblJRm3sy8g
         dG6wcZIiMhMa0j6IF6EhoKtyPI785CGYY2XItRLmWTJhMXzKoO8eT3QR9RxbVAE8kOAG
         YE7nOrvkWEuZEqa6EuUu6+Aiv9p8AYBViXOI0SYxJDXjHxWA9zay6Y3VEdKlUV1HU0ZH
         S6/Q==
X-Forwarded-Encrypted: i=1; AKwUvBz1OfXlhYPvQQB8mtn0kBirAC2C73cd9lezKyze2VHIZisMUs8tu12uPTh3pGxj0C4dOes=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAMQt2hoQu8FbkfTFNOp0NkCyyz9U+2XEZnWl9YO4NTQT6CStv
	E/6UIdcnqBuEqeUe7sn/1jk4aXZLFeUv9JU6CJO8MZxAPfOs6OjV1BbitYqomSJAVGAFh2aa4CS
	QhISLBwSeLeGhNh1DRVozsA+lJw==
X-Received: from dybta14.prod.google.com ([2002:a05:7301:6f0e:b0:368:2c6d:de10])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:e990:b0:197:b597:c441 with SMTP id a92af1059eb24-1993f3f1820mr1399557c88.47.1792806941376;
 Fri, 23 Oct 2026 18:55:41 -0700 (PDT)
Date: Sat, 24 Oct 2026 01:55:40 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261024015540.538758-1-almasrymina@google.com>
Subject: [PATCH v1] vfio/pci: pass FAULT_FLAG_WRITE to vmf_insert_pfn_pmd/pud()
From: Mina Almasry <almasrymina@google.com>
To: Alex Williamson <alex@shazbot.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org, Ankit Agrawal <ankita@nvidia.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

vfio_pci_vmf_insert_pfn() unconditionally passes write=false to
vmf_insert_pfn_pmd() and vmf_insert_pfn_pud().

In insert_pmd() and insert_pud(), write=false skips marking newly
inserted PMD/PUD entries dirty/young via pmd_mkyoung(pmd_mkdirty()) and
maybe_pmd_mkwrite(). Furthermore, when vma_wants_writenotify() is active
on a shared writable VMA (for example, after CLEAR_REFS_SOFT_DIRTY
clears VM_SOFTDIRTY and calls vma_set_page_prot()), vm_page_prot is
downgraded to read-only so insert_pmd()/insert_pud() with write=false
installs a write-protected huge PMD/PUD. Subsequent write faults enter
wp_huge_pmd() or wp_huge_pud(), which invoke vma->vm_ops->huge_fault()
to upgrade the entry in place. Because vfio_pci_vmf_insert_pfn() passes
write=false, insert_pmd() and insert_pud() see !pmd_none(*pmd) with
!write, do nothing, and return VM_FAULT_NOPAGE without setting the write
bit or splitting the huge page, causing an infinite write page-fault
loop.

Pass vmf->flags & FAULT_FLAG_WRITE to vmf_insert_pfn_pmd() and
vmf_insert_pfn_pud() so write faults properly mark huge PFNMAP entries
dirty and writable.

Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
Cc: stable@vger.kernel.org
Cc: Ankit Agrawal <ankita@nvidia.com>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Assisted-by: LLM
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da860e2..204d959086e9 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1745,6 +1745,8 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 				   unsigned long pfn,
 				   unsigned int order)
 {
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+
 	lockdep_assert_held_read(&vdev->memory_lock);
 
 	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
@@ -1754,10 +1756,10 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
 
 	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP) && order == PMD_ORDER)
-		return vmf_insert_pfn_pmd(vmf, pfn, false);
+		return vmf_insert_pfn_pmd(vmf, pfn, write);
 
 	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP) && order == PUD_ORDER)
-		return vmf_insert_pfn_pud(vmf, pfn, false);
+		return vmf_insert_pfn_pud(vmf, pfn, write);
 
 	return VM_FAULT_FALLBACK;
 }

base-commit: 076d7e989cb69f6ded7d60f2a080eb909930061b
-- 
2.56.0.257.gf7497c7d27-goog

