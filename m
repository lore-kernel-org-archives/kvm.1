Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27107335BBB
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663360; cv=none; b=kXjxs8RDoqoNOUxTjxISFqSdcYT2NwwogmncUFqOCZcYIc3yfCxARrY/3WDF+8rZsxzpw3gVQ+1V2xIf+Kd/M3k7i4kxZG9d1fhsEloOpY0GA26PZaDb2uCxRqDgTjrn9S62Ke3PJpDycsTCex5TxpcyNEN1qGLehlO1E/SEG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663360; c=relaxed/simple;
	bh=zoIMJrccZY0ljOJzOdO289pVY44K9AtZaROD/mLUnN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1unfCDRuPnsS/goHFL0jZPbWsFYGeX3jHqtOJEPeK9+ytd1yxuKKp/1Fvnzx18Y07B1kL8hkqMgFrAcWrTCbXpmG9hKibyCz+SfvcByoIXgmORakNt2X+GPqXKhzqkwyEl6mjUWhTxuvcceZ9REEkqOT9KVRwP3wdbvnt9jMco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9D03r7J; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9D03r7J"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cede6375caso51365ad.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 16:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786663357; x=1787268157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O6zTNUvhCr4kYx+co1eaUK1ut6aQypeR2ZuMTnUh8p8=;
        b=j9D03r7Jbh0eMHbUH7b1yZ15fIqHpQvm20fHbEkxK0kxasXgaTaG3fz4JsM7lFGPWk
         maMrLePYRsaJ1Kds5AtEOTcbCmJXjLlsLdpYUBXT5XxoMY4QaOcF9UhXlRlPFmqybegs
         UXGYwO5XND+ETIqrMwYirhlOZxuxZCZQmsEoLfGvGINpoEpQa3zEwYcM7KokVsOa+bfg
         AFP3GIo1rTNMFDFHQYgRggoEHafA0sW6w8VKJDjIy6KPkEKwkUdoRBEBI2Q/iXgh7xJs
         IHkh6iBxZj+SVulBFXL5FAyRdO6CqCxJaKcay00PikgUkusa+lXMadcPC2UM/JnNUATH
         840A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786663357; x=1787268157;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O6zTNUvhCr4kYx+co1eaUK1ut6aQypeR2ZuMTnUh8p8=;
        b=LgrteLM+/4h1TPGedW61GXrb2uAkRW21/ou0msklvl7a6Y0Yw5g41MHwr2kCRCzVnJ
         K8x4LZ4rnK0l9iJ290BoGP3G9iSDAE3gKtBhW5MagAmB7x12mrYeqOH0YN/a+MXWqicL
         NgdMMWS3Amcklaw8XpNzgO3EQpOWL+kiRUjnrWyj6eMACSWmYfOleABTQKFtPzqfseBU
         185S3q0WtLOwjrCP3oN86gInYtAkkWdse+QxdtdOR7GCWSA1TtWqAf0K8YWJKR71JTm6
         cW5LYBUOVBjsaOkVi2yG6L6d7DVP/vcxCtyZAs6s39TDGE539ZqAqTwn2VwDIn+qONrY
         2Urw==
X-Gm-Message-State: AOJu0YykfasUvxZ3nlJTDWyDO/9mJWbsbVnDaeGgck8/PP8CjJMRk3hG
	yaM7JiKlj/eY/Ll6IxCKTXLgUCTDqh1gKNwsqnQhBpJ+RU+x1p/C+owRJwcHsfyhsw==
X-Gm-Gg: AR+sD13FU/6wxGlE84cdLawi0xccco8NT0UEcEdDSkZ2VpnBdxIggRvdks+nCxt6P/L
	LlXyD/HYm6aqbZVlE/fnlGUD6/NWfT7wGbIvedtEc2KnyaMP4795Ojw95r2ddm3iliJJTBOHuLD
	ah1cB/oheQc3A+Qi2gGQFUxEoF+cybs+ZYuEzJJhXpSWgyaqtwbwKTUYsx/T+oztXpl9TYh3vJa
	jBuTrC80CZPFLHpyaDvE6VQKYQ5EJsXAq8XXH/Cjqg60FEDQG4TMfcK82I1wQPdc9sps3mPR2L2
	cSDY2j6pSjjFsRpulFnsGpOp+GMZe9TIJG3Xvs2KEAyh7mmvndsF4VCq9FMpe48junmdJJ5A8lv
	cqjw0oGyNnRXOTWylqv4blcL43YQBwuvJTmxWjFXWYAw4zDrwY9V7qX7IL1NMVJ3H++PG2DvEjt
	YbWKMgcnZJBL3Cqz1erDVoypDNi16p7zfpdGFit6nNaL1af0OIGUBkJkUftW/KwHCRY/zeBfJk5
	LbbwwqP6khGV4Zr5ZaUl3lQK5IjnvXtAiyLpbTto4zfTIyze1kx8XwLILs=
X-Received: by 2002:a17:902:ea03:b0:2c9:bd54:cf with SMTP id d9443c01a7336-2d3aef5eff0mr4207285ad.4.1786663356848;
        Thu, 13 Aug 2026 16:22:36 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394e921709dsm39472a91.0.2026.08.13.16.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 16:22:36 -0700 (PDT)
Date: Thu, 13 Aug 2026 23:22:33 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <an5JbIzz40svS3xe@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260812045325.2733631-2-alex.williamson@nvidia.com>

On Tue, Aug 11, 2026 at 10:53:19PM -0600, Alex Williamson wrote:
>pci_reset_function() and its locked and try variants are intended to
>provide a function-scoped reset.  The bus and slot methods supporting
>this interface refuse when sibling or subordinate devices are present.
>SR-IOV VFs however, are not currently considered in this scope.
>
>Correct this oversight by testing for non-zero VF count in calls
>through the pci_reset_function() interfaces.  This test needs to occur
>under device_lock to avoid races with .sriov_configure.  It should
>also occur before pci_dev_save_and_disable() to avoid calling
>potentially destructive reset hooks.  Tests are therefore added
>to each of pci_reset_function(), pci_reset_function_locked(), and
>pci_try_reset_function().
>
>The __pci_reset_function_locked() interface remains a low-level
>primitive depending on the caller to perform such tests as necessary.
>The vfio_pci_core use case of __pci_reset_function_locked() is pulled
>through with this test.  Other use cases, such as xen-pciback, that
>don't obviously support or prevent binding to SR-IOV enabled PFs will
>need to decide whether VFs are possible and can be preserved.
>Additionally, direct callers of sriov_enable() that do not hold
>device_lock (lpfc) are considered a preexisting, non-compliance issue.
>
>Fixes: dd7cc44d0bce ("PCI: add SR-IOV API for Physical Function driver")
>Cc: stable@vger.kernel.org
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
>---
> drivers/pci/pci.c                | 19 +++++++++++++++++++
> drivers/vfio/pci/vfio_pci_core.c |  4 +++-
> 2 files changed, 22 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>index 77b17b13ee61..b40b00c0c0c9 100644
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -5222,11 +5222,22 @@ int pci_reset_function(struct pci_dev *dev)
> 		pci_dev_lock(bridge);
>
> 	pci_dev_lock(dev);
>+
>+	/*
>+	 * Reset of an SR-IOV PF necessarily resets any active VFs.  Such resets are
>+	 * beyond the scope advertised for pci_reset_function() and variants, refuse.
>+	 */
>+	if (pci_num_vf(dev) > 0) {
>+		rc = -ENOTTY;
>+		goto unlock;
>+	}
>+
> 	pci_dev_save_and_disable(dev);
>
> 	rc = __pci_reset_function_locked(dev);
>
> 	pci_dev_restore(dev);
>+unlock:
> 	pci_dev_unlock(dev);
>
> 	if (bridge)
>@@ -5264,6 +5275,9 @@ int pci_reset_function_locked(struct pci_dev *dev)
> 	if (!pci_reset_supported(dev))
> 		return -ENOTTY;
>
>+	if (pci_num_vf(dev) > 0)
>+		return -ENOTTY;
>+
> 	pci_dev_save_and_disable(dev);
>
> 	rc = __pci_reset_function_locked(dev);
>@@ -5290,6 +5304,11 @@ int pci_try_reset_function(struct pci_dev *dev)
> 	if (!pci_dev_trylock(dev))
> 		return -EAGAIN;
>
>+	if (pci_num_vf(dev) > 0) {
>+		pci_dev_unlock(dev);
>+		return -ENOTTY;
>+	}

I am wondering whether we should return EAGAIN from here, since this
function is used by vfio_pci_core_enable() during open and it doesn't
fail the open on ENOTTY. Basically whether we should allow the user to
reopen the device if the reset was skipped previously? In the previous
instance of open, the device was setup with vfio/iommufd and the vfio fd
was abruptly closed and the reset was skipped. But the device went back
to the IOMMU default domain and that is probably an Identity domain. If
we allow the device to be opened and re-enable busmaster without a
reset, is there a chance that device would continue to DMA based on its
previous setup/context? Probably unlikely?

Note this is different from the current vfio-pci behaviour where device
is always reset during close.

Maybe thinking with too much paranoia about it :D.

Thanks,
Sami

