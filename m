Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793419057;
	b=fv16wB3RlfhjH6dThYIcLqY+MH4WLMB6Kn9aX21vCiRgYU+Wgz7FDDNxPpfxuR9JkQtO
	 kip0LMhS6N9c1JLdQxiY68T+7/o/hnkpXw2lTobWJWnOvz0bOEV/ArF07iUi3UQ+RL+2D
	 ceFXKOQ9O34vQa3rBD1j6rJQMiM086+QP5rAZ5YAacwTR3QNtrJuyAXZV9jPHuypszkvF
	 3+uLKDgZu3/D108zb0Ith/uUN0CtnrO+dw0sBC00mSdIyceARAsX8EJw4Stn+VHiwQNAr
	 Wx3HZaTdfNW5Z2MfXd3+H5ERzge1XNCoZmoKouxCIKu+x7WjkFSzDsGSJs+HiJiPT2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793419057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8jDkWnNhNjZqKQIv7pGifKaP1FfWkuWc7CK6zb7zNeY=;
	b=cTlj6NwbVB3ZF8IEve31jDUCDIcve88OrDZjLZmXHdN/OKMGm1fM/D998+V0ipRAApXq
	 tM/pmN5jp28F1lcJtXfzjhIOSvHDDCd50bRHfNdLUZf9v5drYvoEkGC/oDvh5BokDdQdy
	 xUwIcOX/qms6vZCzXtJMvQZuutMcxGMZv3NMoPVsU5DDB+I3hlCAQyRQD6yLLa3aQh6Kl
	 1nKSTgIKEWlKdPuQpFzCBlDUaoDs78za58cBX6E9MLPS4eq0y6KFQV4OlnuleBlDGoZg6
	 7KSjhCz17FlBxlLFPMhnbpz2v3HVaZgEltLy5P3LQaSOPA0GXEMVSo6X7ZmPp9U3eFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h+IVmTE7;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C38606A31D
	for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 03:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7C38606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h+IVmTE7
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so17845ad.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 20:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793419056; x=1794023856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8jDkWnNhNjZqKQIv7pGifKaP1FfWkuWc7CK6zb7zNeY=;
        b=h+IVmTE7YS2vVMxJn2EgHy/dgU6tm3Kx58IDUbnIc0/m6YEZHedyFHkEgk5wovIKz+
         QawUiOlVrvE/PhRwK64PRGlQYD3rGRLncoNKxjhRU5RhZzY3eSViC+1o04TRvfvlRokg
         DdJU+qrgY0s0JzqW1pE/dirU2baPdE2aDNSzAhB9wygTPw3hdM7UFvG6vjk5QiGXIylY
         d7lY/tx9A8G3fKkW2cZkOCuGcmE9q1E5Q7zyLW73yd7UOU5o9QVHwW/bRot9rzSTRmJQ
         UhnYlKhehtaMEtKj/xdBeDI6uMGWZejUqleoPFOUkLBTcWdUOxXY+FgN4yp9MylM00ub
         vpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793419056; x=1794023856;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8jDkWnNhNjZqKQIv7pGifKaP1FfWkuWc7CK6zb7zNeY=;
        b=GBuNfum9+U3nQ6GwEKkzj7ouWMcHBoXVuF6btonP0Ithy2B4d/NxiZno1JsMcRYMJg
         9va7KQ12//4KuwOjoKBpK0d9nP6AuVz3UBCV0rFIBzEt9chhOHma/W5Ned9Nhrt/yovx
         EP8QAsBbKFr+gLLsubwIO7AKuevZtqzgwRCFfl5ViOww6+EspitqO+DghUCs0SvS5Jgm
         Wn2cRvuWqkoIffafnwhJWJ6phLTixN3thliQbrQN/FCQEZbI4Ut08BAu7VJ85jpXsEl8
         MEQs5saSyEqUNXbURVy2/Xh/tZd0Bj8Zm5B34YpnpLm3FvUA/Yi482z45evErx5KOqrm
         vinA==
X-Forwarded-Encrypted: i=1; AKwUvByc8DzHQQKcpnTG6tI6E4F5xX1KtVpUO2FzA1/WVV/VYtoCMkrFHlhJvkwWIlJOKpACNsI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJimSAsA4y6PduK51VYPls/BmRvnqsTwx9a4QyCN0+xABhrGnPg
	DHGcnLg96jdBMwffhmLvFKTbvPH+0WmShZWeCe6TVekQ/OimPWFyQEKtewxJv3ZciQ==
X-Gm-Gg: AYBFou1Mn4zqZHNt4GndbTpPo5LR+D850G7w8/Uw+enBnnT23Jlq8FMMM8K5SM+IC1b
	oqp3Zmb6X+7VMHBtjy5bjCllNA7A/MJGt7DtzO6442VsVdPJTJQBnH9qZkHB+AChY1XjF554nKj
	LxUE5+nyGMIWOopHaul+d+KKvBwPfhEkkRAWAjlvYGXyMSs5FzRyNHabOSPrHzwwmb4vDzN2G6W
	yewRqu7TeMA5mO9k4yskRjHn9BxHhjM5Hk0wOjOsTcGHWG+oA7d5hRkTMb/pMCBnbVVXrBnXQFk
	9fRZr0iyeKMgWsjAvuA5L4H880m/kDRGfBwo/zgxT0j+3fbRqQ99KTFtcOdKSaEc79XYLE4M7GN
	tvOROspDzHF4MmJctAqkRl/wHMaO98Mc/ORUzjQFjTG6sHahxHQNnP7uGYIgtOk0bdGj96gz4rt
	mh5ydy3o6eMSkzDdTxFjxPhB7FYEeR4jF15FD6yeFD6+vymXUpVBUjcEXAv6Qlr2ZLWegiWmWJp
	YiEpoVfcWwm2ahkUQV+JqrpQNHKb9RGn9ZA8Dve4qlNZ3MB4Y40CrdRjpXXiZVRlnQkIXocyIZ1
	YC/Hw1x/jib9Q+1Q+1pLzW97Ur+Z97AiFEm3svwNbx9rPiFE0LGyjXnYxuwypidQ0j0wix73a5U
	XJrcNSduP/XWRFLNKq3c3fA==
X-Received: by 2002:a17:902:c40b:b0:2c7:f0cc:dafa with SMTP id d9443c01a7336-2eb1ebe546cmr12291235ad.5.1793419055560;
        Fri, 30 Oct 2026 20:57:35 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d429fsm10473502a91.2.2026.10.30.20.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:57:34 -0700 (PDT)
Date: Sat, 31 Oct 2026 03:57:31 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 16/18] iommufd: Add APIs to preserve/unpreserve a vfio
 cdev
Message-ID: <auVj8rCNJ8O5fwi1@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-17-skhawaja@google.com>
 <07a7f12c-3cd8-4c03-9304-af89c32e0b46@linux.intel.com>
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
In-Reply-To: <07a7f12c-3cd8-4c03-9304-af89c32e0b46@linux.intel.com>

On Sat, Oct 31, 2026 at 11:31:47AM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>Add APIs that can be used to preserve and unpreserve a vfio cdev. Use
>>the APIs exported by the IOMMU core to preserve/unpreserve device.
>>
>>The LUO token of the preserved iommufd is fetched and returned back to
>>the caller as that can be used during restore to get the restored
>>iommufd.
>>
>>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/iommufd/device.c          | 156 ++++++++++++++++++++++++
>>  drivers/iommu/iommufd/iommufd_private.h |   6 +
>>  include/linux/iommufd.h                 |  29 +++++
>>  3 files changed, 191 insertions(+)
>>
>>diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>>index a664c70a6fe7..c8ea2e288240 100644
>>--- a/drivers/iommu/iommufd/device.c
>>+++ b/drivers/iommu/iommufd/device.c
>>@@ -2,6 +2,7 @@
>>  /* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
>>   */
>>  #include <linux/iommu.h>
>>+#include <linux/iommu-liveupdate.h>
>>  #include <linux/iommufd.h>
>>  #include <linux/pci-ats.h>
>>  #include <linux/slab.h>
>>@@ -686,6 +687,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>>  	int rc;
>>  	mutex_lock(&igroup->lock);
>>+	if (iommufd_device_is_preserved(idev)) {
>>+		rc = -EBUSY;
>>+		goto err_unlock;
>>+	}
>>  	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
>>  			    XA_ZERO_ENTRY, GFP_KERNEL);
>>@@ -868,6 +873,10 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
>>  	int rc;
>>  	mutex_lock(&igroup->lock);
>>+	if (iommufd_device_is_preserved(idev)) {
>>+		rc = -EBUSY;
>>+		goto err_unlock;
>>+	}
>>  	attach = xa_load(&igroup->pasid_attach, pasid);
>>  	if (!attach) {
>>@@ -1747,3 +1756,150 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
>>  	iommufd_put_object(ucmd->ictx, &idev->obj);
>>  	return rc;
>>  }
>
>Why is there no such check in iommufd_hw_pagetable_detach()?

Detach can't fail, so it is blocked in the caller,
vfio_df_ioctl_detach_pt() returns -EBUSY for a preserved device. The
other detach path is unbind on close of the device file, which can't
happen while LUO holds a reference to it.

>
>>+
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+static bool _iommufd_device_has_pasid_attachments(struct iommufd_device *idev)
>>+{
>>+	struct iommufd_group *igroup = idev->igroup;
>>+	unsigned long start = IOMMU_NO_PASID;
>>+
>>+	if (xa_find_after(&igroup->pasid_attach, &start, UINT_MAX, XA_PRESENT))
>>+		return true;
>>+
>>+	return false;
>>+}
>>+
>>+/**
>>+ * iommufd_device_preserve() - Preserve an iommufd device across live update
>>+ * @s: Live update session
>>+ * @idev: Target iommufd device
>>+ * @iommufd_tokenp: Pointer to store outgoing iommufd token
>>+ *
>>+ * Return: 0 on success, or negative error code.
>>+ */
>>+int iommufd_device_preserve(struct liveupdate_session *s,
>>+			    struct iommufd_device *idev,
>>+			    u64 *iommufd_tokenp)
>>+{
>>+	struct iommufd_hwpt_paging *hwpt_paging;
>>+	struct iommufd_hw_pagetable *hwpt;
>>+	struct iommufd_attach *attach;
>>+	struct iommufd_group *igroup;
>>+	int ret;
>>+
>>+	if (!idev)
>>+		return -EINVAL;
>>+
>>+	if (iommufd_device_is_noiommu(idev))
>>+		return -EOPNOTSUPP;
>>+
>>+	igroup = idev->igroup;
>>+	mutex_lock(&igroup->lock);
>>+	if (idev->liveupdate_preserved) {
>>+		ret = -EBUSY;
>>+		goto out;
>>+	}
>>+
>>+	if (_iommufd_device_has_pasid_attachments(idev)) {
>>+		ret = -EOPNOTSUPP;
>>+		goto out;
>>+	}
>>+
>>+	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
>>+	if (!attach) {
>>+		ret = -ENOENT;
>>+		goto out;
>>+	}
>>+
>>+	if (!xa_load(&attach->device_array, idev->obj.id)) {
>>+		ret = -ENOENT;
>>+		goto out;
>>+	}
>>+
>>+	hwpt = attach->hwpt;
>>+	if (!hwpt_is_paging(hwpt)) {
>>+		ret = -EOPNOTSUPP;
>>+		goto out;
>>+	}
>>+
>>+	hwpt_paging = to_hwpt_paging(hwpt);
>>+	ret = liveupdate_get_token_outgoing(s, idev->ictx->file, iommufd_tokenp);
>>+	if (ret)
>>+		goto out;
>>+
>>+	if (!hwpt_paging->liveupdate_preserved) {
>>+		ret = -EINVAL;
>>+		goto out;
>>+	}
>>+
>>+	ret = iommu_preserve_device(hwpt_paging->common.domain,
>>+				    idev->dev,
>>+				    *iommufd_tokenp);
>>+
>>+	if (!ret) {
>>+		igroup->num_liveupdate_preserved++;
>>+		idev->liveupdate_preserved = true;
>>+	}
>>+out:
>>+	mutex_unlock(&igroup->lock);
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL_NS_GPL(iommufd_device_preserve, "IOMMUFD");
>>+
>>+/**
>>+ * iommufd_device_unpreserve() - Unpreserve an iommufd device
>>+ * @s: Live update session
>>+ * @idev: Target iommufd device
>>+ */
>>+void iommufd_device_unpreserve(struct liveupdate_session *s,
>>+			       struct iommufd_device *idev)
>>+{
>>+	struct iommufd_hwpt_paging *hwpt_paging;
>>+	struct iommufd_hw_pagetable *hwpt;
>>+	struct iommufd_attach *attach;
>>+	struct iommufd_group *igroup;
>>+
>>+	if (!idev)
>>+		return;
>>+
>>+	igroup = idev->igroup;
>>+	mutex_lock(&igroup->lock);
>>+	if (!idev->liveupdate_preserved)
>>+		goto out;
>>+
>>+	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
>>+	if (!attach) {
>>+		WARN(1, "IOMMU_NO_PASID attachment not found");
>>+		goto out;
>>+	}
>>+
>>+	hwpt = attach->hwpt;
>>+	if (WARN(!hwpt_is_paging(hwpt), "Attached HWPT is not a paging HWPT"))
>>+		goto out;
>>+
>>+	hwpt_paging = to_hwpt_paging(hwpt);
>>+	if (!hwpt_paging->liveupdate_preserved) {
>>+		WARN(1, "Attached domain is not preserved");
>>+		goto out;
>>+	}
>>+
>>+	iommu_unpreserve_device(hwpt_paging->common.domain, idev->dev);
>>+	igroup->num_liveupdate_preserved--;
>>+	idev->liveupdate_preserved = false;
>>+out:
>>+	mutex_unlock(&igroup->lock);
>>+}
>>+EXPORT_SYMBOL_NS_GPL(iommufd_device_unpreserve, "IOMMUFD");
>>+
>>+/**
>>+ * iommufd_device_is_preserved() - Check if an iommufd device is preserved
>>+ * @idev: Target iommufd device
>>+ *
>>+ * Return: true if preserved, false otherwise.
>>+ */
>>+bool iommufd_device_is_preserved(struct iommufd_device *idev)
>>+{
>>+	return idev && idev->igroup && idev->igroup->num_liveupdate_preserved;
>>+}
>
>How is it different from
>
>	return idev && idev->liveupdate_preserved;
>
>?
>
>Device preservation requires a singleton group, so these two are
>effectively the same. However, the latter seems more straightforward
>given the function's name. Or anything I overlooked?

Agreed. I kept the group counter for supporting non-singleton groups
later down the road, but for now they are the same. I will use
idev->liveupdate_preserved and drop num_liveupdate_preserved.

>
>>+EXPORT_SYMBOL_NS_GPL(iommufd_device_is_preserved, "IOMMUFD");
>>+#endif
>>diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>>index 69d902b69b82..4760fffd2512 100644
>>--- a/drivers/iommu/iommufd/iommufd_private.h
>>+++ b/drivers/iommu/iommufd/iommufd_private.h
>>@@ -507,6 +507,9 @@ struct iommufd_group {
>>  	struct xarray pasid_attach;
>>  	struct iommufd_sw_msi_maps required_sw_msi;
>>  	phys_addr_t sw_msi_start;
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+	int num_liveupdate_preserved;
>>+#endif
>>  };
>>  /*
>>@@ -524,6 +527,9 @@ struct iommufd_device {
>>  	bool enforce_cache_coherency;
>>  	struct iommufd_vdevice *vdev;
>>  	bool destroying;
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+	bool liveupdate_preserved;
>>+#endif
>>  };
>>  static inline struct iommufd_device *
>>diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
>>index 6e7efe83bc5d..80382aceca18 100644
>>--- a/include/linux/iommufd.h
>>+++ b/include/linux/iommufd.h
>>@@ -9,6 +9,7 @@
>>  #include <linux/err.h>
>>  #include <linux/errno.h>
>>  #include <linux/iommu.h>
>>+#include <linux/liveupdate.h>
>>  #include <linux/refcount.h>
>>  #include <linux/types.h>
>>  #include <linux/xarray.h>
>>@@ -213,6 +214,15 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
>>  int iommufd_vfio_compat_ioas_get_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
>>  int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
>>  int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
>>+
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+int iommufd_device_preserve(struct liveupdate_session *s,
>>+			    struct iommufd_device *idev,
>>+			    u64 *iommufd_tokenp);
>>+void iommufd_device_unpreserve(struct liveupdate_session *s,
>>+			       struct iommufd_device *idev);
>>+bool iommufd_device_is_preserved(struct iommufd_device *idev);
>>+#endif
>>  #else /* !CONFIG_IOMMUFD */
>>  static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
>>  {
>>@@ -397,4 +407,23 @@ static inline void iommufd_viommu_destroy_mmap(struct iommufd_viommu *viommu,
>>  {
>>  	_iommufd_destroy_mmap(viommu->ictx, &viommu->obj, offset);
>>  }
>>+
>>+#if !IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE) || !IS_ENABLED(CONFIG_IOMMUFD)
>>+static inline int iommufd_device_preserve(struct liveupdate_session *s,
>>+					  struct iommufd_device *idev,
>>+					  u64 *iommufd_tokenp)
>>+{
>>+	return 0;
>
>Why does it return success when IOMMU_LIVEUPDATE is disabled?

This is intentional. vfio-pci live update works without IOMMU state
preservation, so with IOMMU_LIVEUPDATE disabled the device is still
preserved without its IOMMU state. Returning an error here would break
that. I will add a comment explaining this.

>
>>+}
>>+
>>+static inline void iommufd_device_unpreserve(struct liveupdate_session *s,
>>+					     struct iommufd_device *idev)
>>+{
>>+}
>>+
>>+static inline bool iommufd_device_is_preserved(struct iommufd_device *idev)
>>+{
>>+	return false;
>>+}
>>+#endif
>>  #endif
>
>Thanks,
>baolu

Thanks,
Sami
