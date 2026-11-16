Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854580;
	b=kWS+NF+5623FPsXG+lHOBCsO9SJAXfaH3gGKvsmBlsdrpXAhxexQtA2dlfri+K55BZ/L
	 GYDcVMzRiwRxloNYVvSWQ/5YBpVxwbI+JWAo8f1AzpFb7JBHKkl54v0fz9RR1xYLAV9MT
	 mwcXVEIFUtYWgkAzGU4FZUHjj2vAgW/OXOQEr3RaX4HPXBqtsjKAPnVx5QG+eOXls9RxO
	 0bfOsvk+JcPylNPZ4ZototvgZnpng223AdhSANfZxZ8tlb0jP7BpwtW6ihViF7QW7uD9P
	 KS4DAuwiUV0oNxgpHofM+OtpAEs53/CV4M04Ng+ON1zCDM1SYjpWIPt9uFQZbLr+YFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=kjMr3AIwgDt4kWmPjLUo+CbR6vTX24G//bvOLGHgweI=;
	b=C+TygjRCfs2UXdl8UX97zi2Lv4Ws7j5g8H0PcAFJixEmDrKXbyqxq/sL5Op8wI0Pg7ES
	 Xf95PZ6TXMSEd3jGZgLevUuL+2+JJPSHLdwuE6SResc2bShkB4wNfrt8CInFA8jxEiUzK
	 tw7PTtdBwl9B1gDyI5rgsP9SytnW1n+uIjN5dZzl86GOq4u73yxZtrhDU6DcporqDHQGH
	 IzgNe+3/T4fV+Qc4a1Skr4KJa/t0hjiHVCyer0hK+mVAqiZT+dUzXsbchBate2Hx/QzUz
	 CGExN3I8/aX+s0MvJjYM22RIZvMX6NAoyKfWn7uQo1zMlqiZK21ZdJ5yXUSAlp1bpWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="RLoyRgj/";
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2D606A330
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 18:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16C2D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RLoyRgj/
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2efc4a84e75so5325ad.1
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 10:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794854579; x=1795459379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kjMr3AIwgDt4kWmPjLUo+CbR6vTX24G//bvOLGHgweI=;
        b=RLoyRgj/Aup0KZTYcDOF9MZLpoUahr/nmnLDkvog1bmhLdVEgqE3I0Lk6p/70uNTrb
         xrM6sm1lYrikJcPztxu1AAaQ8vvWE8lASu9Bby2bFVwGUEH14hf3Y+CUT+M0Efa7PiHF
         u7qjjh8TX8V+qH/paojehtWFVDqQaivcYtqYDyrYHudSPhYzzAF7pWFHX0QxWLOFvynH
         ZoaOfsnZmqUpddE28FyZxTLiKFoycgd76E2hmWGrPNN+wU4iOuAsYsGRoHCHsnKcgf41
         mkcW6JAjDmdzCQpte1dIU4S8rRXN73RtvuWOdCORwxguLPQOiUwuFxKLdkxVKjnoSLaW
         T+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854579; x=1795459379;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kjMr3AIwgDt4kWmPjLUo+CbR6vTX24G//bvOLGHgweI=;
        b=NxK2hCSmgoi1vKkFYE4L614e+KK2bXOBIm/ekbrrVih/2QRP7E0x+L36JuWarzIzo4
         vT7Oki7kdKrixiYtzCE3KBA4D5lcR7+tAdMMMg0L6kAha0KXyZrCE/w0zW32RIIVnG3f
         RRcTyXvuu35RpPuQUeL2HLDFgPguN+rO/lbn+r+emtVBWmb2L0O4j4S7qlT1pmdG1C5e
         8MkZVE6DsauDK4LXXmoU/7urQ3BXRYCvCCQRtVFQvUNKfcIXGisVjht3Heuigg/ObOlP
         1EDCs1WZQvqiWwJdOF6xjBoSwoJOuPMYBrrzSWZ6wKF3o/BytHp4OvAJCxS47q36NeqU
         7PeA==
X-Forwarded-Encrypted: i=1; AL+hErFDX2JW3eH69J2eCtvXgyY9cUU+h3qOVF+iCJDPYukuBG0LcgN0khVneAR5pibi/BCNYd0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+J6xiiCur40lnjWG6sNiFzD0cKGZqBEE8xb4gqG1Jw1/aUYdRB
	AHZpmiz/zcCiijns+IDkzD/fY85b8zpA4f8Zac143hftWwmUBTbzGpYONMxa1Kl8vA==
X-Gm-Gg: AZFdTZfYg6wh2qvcYjykj1vUD7HKcrsGPg0hRpCXMnD3gMnc2GV9B6s3/Avc8PXug33
	cNKAvn+2ggixdLEr66fzquhGNkUDN6LggUomWU9TF5wcvbDISo21WTrUxg2K/xX7UzUDJRerKMx
	ZUiiyaw+TfTCK/qIp+7osgzwiLcGDOR4Qs2rWna7tOUZ5yWRiy3O9jHky/Rgz6jD1iq9O1O3JDr
	jPVEvyGYLBZzaAUWKJM89rqKJlO8d5hANbngKr0s0zQi7BYmimEkZpfDHBVrKFUf7ZdbH55r8yy
	p0PN+4xFW5vR7beJRTcyxIFXRQmjLtccCWGCoXQjBqFYg02sjb0oHmrxWefhsdc6smoRnMKVTZ/
	/MWL+LuuW/8Nscy0aX4p5E1Oj8wd5xxi6sS69GsBrp6dR9843kef1D95H8SJ15korKEWsm+1fUw
	HRSkY8hRdOxLHWVdGaFQ4guSYBS9FdDcNh1T6myOeVbTJT4XCyvPEsXKiafDktUH2B53ffMpTvF
	igKVSLzbry4BG6sRLY06LYl8/JFcd08RnipqO12SLLE9eQSsZHvZLVwZ3Rq9gth2qMGmrmH87U6
	zS+5IqZh+QQtc3z3ZRkX10hlCPP8hmGX9Yf4pNAZ+3ID9OdvASgxq/CL8qKlU7TzN6CXL7PHoJD
	m5yyAoakqE7JD4U/rHbhZ7Nh/typUZcfIswVyJwQvR5I=
X-Received: by 2002:a17:903:46c6:b0:2cf:9ec1:ea6e with SMTP id d9443c01a7336-2efda91f564mr483475ad.8.1794854578745;
        Mon, 16 Nov 2026 10:42:58 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b245f0c3sm9315847a91.0.2026.11.16.10.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:42:57 -0800 (PST)
Date: Mon, 16 Nov 2026 18:42:54 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v7 05/18] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <avtMVRYk59ilQMlG@google.com>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-6-skhawaja@google.com>
 <5dc1b3a3-8e9d-4771-b70a-ace7d5b919df@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5dc1b3a3-8e9d-4771-b70a-ace7d5b919df@linux.intel.com>

On Mon, Nov 16, 2026 at 06:19:11PM +0800, Baolu Lu wrote:
>On 11/10/2026 12:08 PM, Samiullah Khawaja wrote:
>>Add IOMMU ops to preserve/unpreserve the device state handled by the
>>IOMMU driver. This is IOMMU specific state of the device that needs to
>>be preserved for liveupdate. These ops can be implemented by the IOMMU
>>drivers that support preservation of devices that have their IOMMU
>>domains preserved. During device preservation the state of the
>>associated IOMMU is also preserved as dependency.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/iommu-priv.h       |   2 +
>>  drivers/iommu/iommu.c            |  32 +++++-
>>  drivers/iommu/liveupdate.c       | 191 +++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h |  76 ++++++++++++
>>  include/linux/iommu.h            |  21 ++++
>>  5 files changed, 321 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>>index 1f9f886b2c10..8a14d38a3e70 100644
>>--- a/drivers/iommu/iommu-priv.h
>>+++ b/drivers/iommu/iommu-priv.h
>>@@ -21,6 +21,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>>  void dev_iommu_free(struct device *dev);
>>+size_t iommu_group_device_count(struct iommu_group *group);
>>+
>>  const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
>>  static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
>>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>index b486b8bbd1fc..932325e0af41 100644
>>--- a/drivers/iommu/iommu.c
>>+++ b/drivers/iommu/iommu.c
>>@@ -18,6 +18,7 @@
>>  #include <linux/errno.h>
>>  #include <linux/host1x_context_bus.h>
>>  #include <linux/iommu.h>
>>+#include <linux/iommu-liveupdate.h>
>>  #include <linux/iommufd.h>
>>  #include <linux/idr.h>
>>  #include <linux/err.h>
>>@@ -626,8 +627,8 @@ DEFINE_MUTEX(iommu_probe_device_lock);
>>  static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
>>  {
>>+	struct group_device *gdev, *gdev2;
>>  	struct iommu_group *group;
>>-	struct group_device *gdev;
>>  	int ret;
>>  	/*
>>@@ -661,6 +662,13 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>>  		goto err_put_group;
>>  	}
>>+	for_each_group_device(group, gdev2) {
>>+		if (dev_iommu_has_preserved_state(gdev2->dev)) {
>>+			ret = -EBUSY;
>>+			goto err_free_gdev;
>>+		}
>>+	}
>>+
>>  	/*
>>  	 * The gdev must be in the list before calling
>>  	 * iommu_setup_default_domain()
>>@@ -697,6 +705,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>>  err_remove_gdev:
>>  	list_del(&gdev->list);
>>+err_free_gdev:
>>  	__iommu_group_free_device(group, gdev);
>>  err_put_group:
>>  	iommu_deinit_device(dev);
>>@@ -3543,6 +3552,27 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>>+/**
>>+ * iommu_group_device_count() - Get the number of devices in a group
>>+ * @group: The group.
>>+ *
>>+ * The device count may change after this function returns, as devices can
>>+ * be added to or removed from the group. The caller must recheck it if it
>>+ * needs the count to stay the same.
>>+ *
>>+ * Return: the number of devices in the group.
>>+ */
>>+size_t iommu_group_device_count(struct iommu_group *group)
>>+{
>>+	size_t count;
>>+
>>+	mutex_lock(&group->mutex);
>>+	count = list_count_nodes(&group->devices);
>>+	mutex_unlock(&group->mutex);
>>+
>>+	return count;
>>+}
>>+
>>  static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>>  				   struct iommu_domain *domain)
>>  {
>
>[...]
>
>>+/**
>>+ * iommu_preserve_device() - Preserve device state across live update
>>+ * @domain: Associated IOMMU domain
>>+ * @dev: Device to preserve
>>+ * @dma_owner_token: Token to identify DMA owner of this device
>>+ *
>>+ * Return: 0 on success, or negative error code.
>>+ */
>>+int iommu_preserve_device(struct iommu_domain *domain,
>>+			  struct device *dev, u64 dma_owner_token)
>>+{
>>+	struct iommu_device_ser *device_ser;
>>+	struct iommu_flb_obj *flb_obj;
>>+	struct dev_iommu *iommu;
>>+	struct pci_dev *pdev;
>>+	int ret;
>>+
>>+	if (!dev_is_pci(dev))
>>+		return -EOPNOTSUPP;
>>+
>>+	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
>>+		return -EINVAL;
>>+
>>+	if (iommu_group_device_count(dev->iommu_group) != 1)
>>+		return -EOPNOTSUPP;
>>+
>>+	if (iommu_get_domain_for_dev(dev) != domain)
>>+		return -EINVAL;
>>+
>>+	pdev = to_pci_dev(dev);
>>+	iommu = dev->iommu;
>>+	if (!iommu->iommu_dev->ops->preserve_device ||
>>+	    !iommu->iommu_dev->ops->unpreserve_device ||
>>+	    !iommu->iommu_dev->ops->preserve ||
>>+	    !iommu->iommu_dev->ops->unpreserve)
>>+		return -EOPNOTSUPP;
>>+
>>+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>>+	if (ret)
>>+		return ret;
>>+
>>+	mutex_lock(&flb_obj->lock);
>>+	if (!domain->domain_ser) {
>>+		ret = -EINVAL;
>>+		goto out_unlock;
>>+	}
>>+
>>+	if (dev_iommu_preserved_state(dev)) {
>>+		ret = -EBUSY;
>>+		goto out_unlock;
>>+	}
>>+
>>+	device_ser = iommu_ser_set_alloc(&flb_obj->device_set);
>>+	if (IS_ERR(device_ser)) {
>>+		ret = PTR_ERR(device_ser);
>>+		goto out_unlock;
>>+	}
>>+
>>+	ret = iommu_preserve_locked(iommu->iommu_dev, flb_obj);
>>+	if (ret) {
>>+		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
>>+		goto out_unlock;
>>+	}
>>+
>>+	device_ser->attachment.domain_phys = virt_to_phys(domain->domain_ser);
>>+	device_ser->iommu_phys = virt_to_phys(iommu->iommu_dev->iommu_ser);
>>+	device_ser->devid = pci_dev_id(pdev);
>>+	device_ser->pci_domain_nr = pci_domain_nr(pdev->bus);
>>+	device_ser->dma_owner_token = dma_owner_token;
>>+
>>+	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
>>+	if (!ret) {
>>+		WRITE_ONCE(dev->iommu->device_ser, device_ser);
>>+
>>+		/* Validate that no sibling device was added concurrently */
>>+		if (iommu_group_device_count(dev->iommu_group) != 1) {
>>+			iommu->iommu_dev->ops->unpreserve_device(dev, device_ser);
>>+			WRITE_ONCE(dev->iommu->device_ser, NULL);
>>+			ret = -EOPNOTSUPP;
>>+		}
>>+	}
>>+
>>+	if (ret) {
>>+		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
>>+		iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
>>+		goto out_unlock;
>>+	}
>>+
>>+out_unlock:
>>+	mutex_unlock(&flb_obj->lock);
>>+	liveupdate_flb_put_outgoing(&iommu_flb);
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL_GPL(iommu_preserve_device);
>Only devices in singleton iommu groups can be preserved, and no other
>device may join the group while preservation is in progress or the
>device remains preserved.
>
>Could we simplify this by adding a flag to struct iommu_group, protected
>by group->mutex? For example:
>
>@@ -72,6 +72,9 @@ struct iommu_group {
>         */
>        unsigned int recovery_cnt;
>        void *owner;
>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>+       bool liveupdate_reserved;
>+#endif
> };
>
>A helper could check that the group contains exactly one device and set
>the flag atomically under group->mutex. Device probing would reject an
>addition if the flag is set.
>
>#ifdef CONFIG_IOMMU_LIVEUPDATE
>int iommu_group_reserve_liveupdate(struct iommu_group *group)
>{
>        int ret = 0;
>
>        mutex_lock(&group->mutex);
>        if (group->liveupdate_reserved)
>                ret = -EBUSY;
>        else if (list_count_nodes(&group->devices) != 1)
>                ret = -EOPNOTSUPP;
>        else
>                group->liveupdate_reserved = true;
>        mutex_unlock(&group->mutex);
>
>        return ret;
>}
>
>void iommu_group_unreserve_liveupdate(struct iommu_group *group)
>{
>        mutex_lock(&group->mutex);
>        group->liveupdate_reserved = false;
>        mutex_unlock(&group->mutex);
>}
>#endif
>
>The reservation could be taken before calling the driver's preserve
>callback and cleared on every failure path and after unpreservation.
>This would avoid the second device-count check.
>
>Any thoughts?

This looks good. I will use it in the next revision, and use the same
flag on the restore side as well.

Thanks,
Sami
