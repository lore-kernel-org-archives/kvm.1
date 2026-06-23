Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF636376BF1
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174418; cv=none; b=aOS6MezAo4Jx4gkDNZG462dLsXAqh+u/dgHbEDllr5UQtNbRdEzLuKSkKKO3Q9Qmgqi7a3nIzz7zXECG/jMXuO6AOTsrCZBsWI32ppJeRVhufHHs4tvZYxHY75uHZ/fbXIVZFXJYzE7OasJ73WJVo0t9jnXCr2sQeXm63THd7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174418; c=relaxed/simple;
	bh=Mvpv5fk7EqlynV6gqt/65OUkuuW/xeN1GfXtNQ6g2Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeDQA//m/BiTQicFKgB/AVkQV2oLHgdSH54+hHQHNl9+QqqSTPCjSQHDI/SDwg+4diiUts5Ktnh0LwFEy9Hz5bwnAyhYhUiAsGQtJqrMeQRJHPGwv1zxxAYvdmTVH5+Ww76nplZFyQkyQlH5baTfbkDPkfEFmecDdMsrWPyNgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JA+0VnMw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JA+0VnMw"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c69fa0b1f8so23745ad.0
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 17:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782174416; x=1782779216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dnnvmp3kEWC924WaK9RNBF9LgizMYwDhSueWIubs0Ho=;
        b=JA+0VnMwY+WZCRNOQdgAnx4k+0Eo+pO0RvYE5f439LuTrrz31FSmtCbRnORvQHryFg
         Qa6WkIv3nqxmNNG1+ot3bAQgL6P7tAddRJ78JBB/ZrdMIzkU0RZn9BVpcrfJy8qP9RZC
         C3ZZSCfIAkAovMed5BhL8+Ip5ENVU6UDjFYVMzuz+wD7kiHxRSM/+Kbx46jDAhKtZrSE
         BNcrwR3yWiTmkJ3NM9k/UN6bHuNbgBtQVhPjNYfjuhHrw3kFBR2oMLnLhNJNsc4Zhgtf
         rzzOvb6/WQTQfGukw4BQDr8HfeQD1Jw2wYzWkyByGSPqkdRw50732GhTTiDkpy2/aJY+
         XsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782174416; x=1782779216;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dnnvmp3kEWC924WaK9RNBF9LgizMYwDhSueWIubs0Ho=;
        b=eiLDexd52pjmLe+9OXDO20NhuRlLVgG+D7yX7oE9WSlSQqN1N1ySAXsQ1LjZT8ndSu
         my7WD0X4/To8vR1vkKLkRMRfUKk9e/xkykEFOk6goRE+/kI0/pm1flv2an0NLUT6O3hd
         mTjCyP7g7GeP3Vz+6OGZ6n86FNlEAu1lC7kYU31xR5fUIra68CBiOETHvWECxZ5aviJC
         plwAQna82SlcxJA6ZoApdYpJcdpG2msyqmwobjzkpoAMlf0G9WmxnzYWtNDD4nJP2+17
         VTjEt9WrRyu+60n2Z0oG5x8W+V17ei9/YvCvkI5ZSO76Us3UNGbJ0HQAQ1ELzT8oQstU
         Cvhg==
X-Forwarded-Encrypted: i=1; AHgh+Rremr/EJRoTRjHqRnGSElgBMdvZGYoVpXDMlrfCjq2vAOY6Ay2zvucZVe+MID3gSqxML+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+eWTfHz6DXZEW54ygD5dVhxMfcamqLBfXg/kQ3JoUpfr+phfA
	kcdqnIlv6t1TYKyinlkrU7mVRnKPjphHT2kvDKYLsBbTbNtmpE6/pCcmerNUzthVWg==
X-Gm-Gg: AfdE7cn61bWIEG4w8WyM0WEd8dk/AJN3GFDKatO5MgmKQ23fKfe4Q49YLfNUg3m2sWn
	U77D4IpD2um5UkaRynrDZb2jc3uOT6jyUZDwiSqueQYbRMEbiAps7eD0xGEPgO09lt1nPOhFGOx
	J6NnRITt1fGJjhN8TpwhMY9Jx4aWwijwmkOeRUs9xsMrUcxAaGHoWG0jN1F6kgrNXbdwUQhpYCN
	/74bRD5cTbPvrs5B+YbJrE76skFWWf4P3bkcqN7ldXeqNMQHpBIFksPcShuKQVbgzktHYlBEGB3
	aAvH4VIjqvey53JItLTLmiH9EO8r75c/JV3lwQnzsAO1psXV27lLbrYToDaIsc1i2Gis7oc9zvs
	qKzQ+aIp3Q5QyQUlVuK3HSI1l/xFyVpviFbsuIzjHbD2maVWucE0Lu2S1ZZPvrbEc8kX1xBrIt4
	/KyyJFIyUGcT20HHydXMlwjMBAHBpPOLEry7uxLZbOpNkoq912VwG3RC3bDv+461fXIpQSFEBGQ
	/0CCVLM
X-Received: by 2002:a17:903:2c7:b0:2bd:63cb:c5be with SMTP id d9443c01a7336-2c7c7067d97mr672265ad.5.1782174415306;
        Mon, 22 Jun 2026 17:26:55 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc563c6e1sm8052094a12.15.2026.06.22.17.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 17:26:54 -0700 (PDT)
Date: Tue, 23 Jun 2026 00:26:51 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 12/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <ajnGMjFxhNCbW0To@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-13-skhawaja@google.com>
 <01f53c50-f585-49a0-b7a2-fdf002049aea@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <01f53c50-f585-49a0-b7a2-fdf002049aea@linux.intel.com>

On Mon, Jun 22, 2026 at 01:44:06PM +0800, Baolu Lu wrote:
>On 6/15/26 07:37, Samiullah Khawaja wrote:
>>Reattach the restored domain to the preserved device using restored
>>domain ID. While reattaching do not setup the context and PASID entries
>>as those are preserved during liveupdate.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  46 ++++++++++---
>>  drivers/iommu/intel/iommu.h      |  17 +++++
>>  drivers/iommu/intel/liveupdate.c | 111 +++++++++++++++++++++++++++++++
>>  3 files changed, 163 insertions(+), 11 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index cd40e274482b..91b67ccba011 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -1311,10 +1311,16 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>>  {
>>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>  	struct intel_iommu *iommu = info->iommu;
>>+	struct iommu_device_ser *device_ser;
>>  	unsigned long flags;
>>  	int ret;
>>-	ret = domain_attach_iommu(domain, iommu);
>>+	device_ser = dev_iommu_restored_state(dev);
>>+	if (!device_ser)
>>+		ret = domain_attach_iommu(domain, iommu);
>>+	else
>>+		ret = intel_iommu_domain_reattach_iommu(domain,
>>+							iommu, device_ser);
>>  	if (ret)
>>  		return ret;
>>@@ -1327,16 +1333,20 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>>  	if (dev_is_real_dma_subdevice(dev))
>>  		return 0;
>>-	if (!sm_supported(iommu))
>>-		ret = domain_context_mapping(domain, dev);
>>-	else if (intel_domain_is_fs_paging(domain))
>>-		ret = domain_setup_first_level(iommu, domain, dev,
>>-					       IOMMU_NO_PASID, NULL);
>>-	else if (intel_domain_is_ss_paging(domain))
>>-		ret = domain_setup_second_level(iommu, domain, dev,
>>-						IOMMU_NO_PASID, NULL);
>>-	else if (WARN_ON(true))
>>-		ret = -EINVAL;
>>+	if (!device_ser) {
>>+		if (!sm_supported(iommu))
>>+			ret = domain_context_mapping(domain, dev);
>>+		else if (intel_domain_is_fs_paging(domain))
>>+			ret = domain_setup_first_level(iommu, domain, dev,
>>+						       IOMMU_NO_PASID, NULL);
>>+		else if (intel_domain_is_ss_paging(domain))
>>+			ret = domain_setup_second_level(iommu, domain, dev,
>>+							IOMMU_NO_PASID, NULL);
>>+		else if (WARN_ON(true))
>>+			ret = -EINVAL;
>>+	} else if (!sm_supported(iommu)) {
>>+		iommu_enable_pci_ats(info);
>>+	}
>
>Instead of merging domain restoration into the attach_dev path, how
>about adding a new callback to restore a preserved domain for a device?

Even with a new callback, the driver still just fetches the restored
state and takes a different path. I am guessing we can just do the
following inside the driver to keep it clean:

static int intel_iommu_attach_device(struct iommu_domain *domain,
                                 	struct device *dev,
                                         struct iommu_domain *old)
{
	struct iommu_device_ser *device_ser = dev_iommu_restored_state(dev);

	if (device_ser)
		return _intel_iommu_restore_dev(domain, dev, device_ser);

	return _intel_iommu_attach_device(domain, dev, old);
}

This keeps the separation you want without touching the generic ops.
WDYT?

With the new callback, this check is just moved into the core inside
__iommu_attach_device(). I am concerned that later down the road when we
add PASID support, we will add restore_dev_pasid().

>Something like:
>
>diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>index b2f614367074..e61409f2d9fc 100644
>--- a/include/linux/iommu.h
>+++ b/include/linux/iommu.h
>@@ -748,6 +748,8 @@ struct iommu_ops {
>  * * <others>  - treated as ENODEV by the caller. Use is discouraged
>  * @set_dev_pasid: set or replace an iommu domain to a pasid of 
>device. The pasid of
>  *                 the device should be left in the old config in 
>error case.
>+ * @restore_dev: Set a domain that is restored from the previous 
>live-updated
>+ *               kernel to a device.
>  * @map_pages: map a physically contiguous set of pages of the same 
>size to
>  *             an iommu domain.
>  * @unmap_pages: unmap a number of pages of the same size from an 
>iommu domain
>@@ -772,6 +774,9 @@ struct iommu_ops {
> struct iommu_domain_ops {
>        int (*attach_dev)(struct iommu_domain *domain, struct device *dev,
>                          struct iommu_domain *old);
>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>+       int (*restore_dev)(struct iommu_domain *domain, struct device *dev);
>+#endif
>        int (*set_dev_pasid)(struct iommu_domain *domain, struct 
>device *dev,
>                             ioasid_t pasid, struct iommu_domain *old);
>
>Thanks,
>baolu

Thanks,
Sami
