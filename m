Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793474393;
	b=t7z/pq94pSDcaQzmdQVTpWmGKIE52IYoZNu3wy4GvptufbYxx3nN1HoBTYKKVUsyaGbQ
	 HLpNMWhz4OSjtzVZonzx9bdK0Ao2quxT+esJvN5fgPAqIGtjO3lTwzN8MMjfsy3q6Ktil
	 AahsUgMzMcJZeL821pVS2I1+bvTceDPfh6r6I35Jq4IbK9vJiZc+15qOf+WSzlxDdu3w4
	 8UywTtx8qx6PQ1cE+7VZ3MzsTEvvx4h1CmoXpuckCuxGAcKcpyWgfIT19u/A57E21UHHI
	 GdjtgearJMra8nnBFeqUEIIoC9INKqSBAxalqqlnCl7joFvB5r/UqSvjGP9rOTZtA5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793474393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=FI17lU+UEkaw3gnc3aMhItamMlJeUZRGnzTnl6hwNL4=;
	b=rrJh//lT0Pp+VoPd2KJQTOdK3109ceSQGbj/Ai9Kr+N3UFTCRMDpA8YyPeCgOs7dZ/k9
	 PO3I5OHRK+SdAj1akcniabpzI+lyXz3s0tlwRD/T+PIHTlwi7EXH+ubY7i6HwJT5LtpBR
	 cJngqTPKe4nOe3J+Lm8tGfFv4cEcOFxR32NEyjc/sWqi1MxE6X2E3iOUBL0pq/NxSXo5E
	 Tj5c5Bd3ZG0S0Y0nAO/NDg8BkIFtRkv3aSGVsrUg+VuEIBuolXgsnwJqbcHvIyUjJcSiv
	 GXioxQcIEJhU2QXnr/dgL8rABcZ+ZeBA5cLxjokxiJLDwoxCXfaY97EpAgO48H9suqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AQ9L6qY1;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440C606A31C
	for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 19:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2440C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AQ9L6qY1
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2eb0a52d605so38335ad.0
        for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793474392; x=1794079192; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FI17lU+UEkaw3gnc3aMhItamMlJeUZRGnzTnl6hwNL4=;
        b=AQ9L6qY10DoFWioK3v4cR1xnHBuarXec5BHFdQbg5mauJv2W8uW6hMdv4MECZCwKwG
         TNwcJ5SSXjfSELYTUlY6PxcC2/b3uJiOodyavwNJBPKnJWxNXtb6F86um6/vpbmGr5XM
         +KAEudfowPotOxclYKP2qg+KhPA6es2vOgmejvSRaY7CCK728WbMLm5jA/8pd1laPfcy
         Oti6dFmbxEqxhpVLlQONdkuAz4paaMcPPfhYz9sIA+EQ6IEE8gbT/9JNKVT6ViVUhder
         9+hGzkSKyxmkoBGMVhEkOgpn5bQLg/TzIWesI1hu/w54Qojpfa4vb1eAWGKuWmRGEbgK
         0Ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793474392; x=1794079192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FI17lU+UEkaw3gnc3aMhItamMlJeUZRGnzTnl6hwNL4=;
        b=m7LRJAkL60vLSnP6omC9UaVxpSjWe9xZ3SKZb/gZx8fjCECTbxlmSxcGElwz4F92kK
         y+Nqg24LI2vQB2pGaNQKUV60Kh3+GaL2fv7CINgjdAEXRKHOoXxRI/VpelTeup+2BZR/
         /O0aqLOimxwdtqmjixwsvHxQvi7dv9MG8kCXGpqRwpFzRqlNTwvXeMYeqps5SzAqVSOX
         ExyXWjt776W4kN5HNnaFPRR0bJzJIWfK5zmNnsHb6iF1c9u9iUDmJJ4A+dXse9s/ZERS
         NyN9z8c90vWXE2k8afqTaktiACs+XG64T/P89oNAXZ9lSSv10b1XJ/BeRv4m4rYF5wtX
         jhaQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7u4E7mKPleEbxQ0ntnTehvN0bO96xt6EJ3idP7a3PEHI4H0Ynv078S2Exzc6RhKxZEUs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNM7vk3Zg7ZoqlKc7/53dHJmgDIjKxcR0SvoISuTtu+OzNwr4C
	AcDrA7/62N10+pjZnpbadmHfN6fPsmGPzJkyadEL+BQeNDXAuaXSPlmAllwBhc1h2Q==
X-Gm-Gg: AYBFou0HjF/zfyXS44BSizrWpbYA2mLeS7QEM58ZkGnjuEGxzvCGk+abn7OEOtJbmfJ
	vUSnuNsWcqJGh1th2Nyh6VvsKGSHFcRnp6Tr6WPEhH64+WbTbfR7BukZZNav08Kemb3MnB3xNLl
	j8+FkwTRYHsT8rsI0psfP16kN1oIudWgbIdycY7/QA0tl83Gr1GuzXdg/iy97icrwfm8jGJOHGV
	MHgV35ZUU8959QAHeMFllhAt7tmH23WJtKTCgnyD6y1cf080XCCl0DGPOCEvr7lf2eSEp/ovz0a
	wJaH1XyocL69J34I0rKPZOuMtIgPQmBmP8x39BHCiZzkLMeTC2BBvZN9TQ3xk1CvuWdZyQt34UQ
	wPimefaafhEtvkGtf4YDyIapYrGqbBVNwP8i/4PYyttVGHTG+mwnCwG8qISW6v26poCBnrRoLGW
	gvFEW+Chl0Olt+nWOx40fbEluheMy9UEz6ANXRhgkMVnPd6amam+xtrAT+mNKGy3mABBbkClpz3
	+qiP1EQq5sSZqebE+MSjVyV43U2mnCsHUwV87n4zVESNJcHVVMc4vfp6y7O3SiAf4gAqrigG37C
	uvmr0dUJLCvb+zd8Sbrva6WrQZSIUPzeVhqvqBJt8H/qHwPG8c6A0K3ROD0QRYoU/wA+++c6YB6
	vB2QgWRTnQhL8ueZBDfuQuQ==
X-Received: by 2002:a17:903:3c70:b0:2ea:4a1:e8a4 with SMTP id d9443c01a7336-2eb1b8c029emr17343335ad.13.1793474391728;
        Sat, 31 Oct 2026 12:19:51 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d429fsm12698201a91.2.2026.10.31.12.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:19:49 -0700 (PDT)
Date: Sat, 31 Oct 2026 19:19:47 +0000
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
Subject: Re: [PATCH v6 05/18] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <auYtwy3DjRxq3Upi@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-6-skhawaja@google.com>
 <df75f891-05a0-4d47-8705-d6a00c81ff97@linux.intel.com>
 <auTzN4NWuKsBvIZU@google.com>
 <38384919-f0e5-4c93-b71b-065b96a74c38@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38384919-f0e5-4c93-b71b-065b96a74c38@linux.intel.com>

On Sat, Oct 31, 2026 at 01:34:00PM +0800, Baolu Lu wrote:
>On 10/31/2026 9:45 AM, Samiullah Khawaja wrote:
>>On Fri, Oct 30, 2026 at 01:12:31PM +0800, Baolu Lu wrote:
>>>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>>>Add IOMMU ops to preserve/unpreserve the device state handled by the
>>>>IOMMU driver. This is IOMMU specific state of the device that needs to
>>>>be preserved for liveupdate. These ops can be implemented by the IOMMU
>>>>drivers that support preservation of devices that have their IOMMU
>>>>domains preserved. During device preservation the state of the
>>>>associated IOMMU is also preserved as dependency.
>>>>
>>>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>>>---
>>>> drivers/iommu/iommu-priv.h       |   2 +
>>>> drivers/iommu/iommu.c            |  72 +++++++++++-
>>>> drivers/iommu/liveupdate.c       | 189 +++++++++++++++++++++++++++++++
>>>> include/linux/iommu-liveupdate.h |  76 +++++++++++++
>>>> include/linux/iommu.h            |  33 ++++++
>>>> 5 files changed, 371 insertions(+), 1 deletion(-)
>>>>
>>>>diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>>>>index 1f9f886b2c10..6b0ef210b32f 100644
>>>>--- a/drivers/iommu/iommu-priv.h
>>>>+++ b/drivers/iommu/iommu-priv.h
>>>>@@ -21,6 +21,8 @@ static inline const struct iommu_ops 
>>>>*dev_iommu_ops(struct device *dev)
>>>> void dev_iommu_free(struct device *dev);
>>>>+bool iommu_group_is_singleton(struct iommu_group *group);
>>>>+
>>>> const struct iommu_ops *iommu_ops_from_fwnode(const struct 
>>>>fwnode_handle *fwnode);
>>>> static inline const struct iommu_ops *iommu_fwspec_ops(struct 
>>>>iommu_fwspec *fwspec)
>>>>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>index b486b8bbd1fc..a66363789ca9 100644
>>>>--- a/drivers/iommu/iommu.c
>>>>+++ b/drivers/iommu/iommu.c
>>>>@@ -18,6 +18,7 @@
>>>> #include <linux/errno.h>
>>>> #include <linux/host1x_context_bus.h>
>>>> #include <linux/iommu.h>
>>>>+#include <linux/iommu-liveupdate.h>
>>>> #include <linux/iommufd.h>
>>>> #include <linux/idr.h>
>>>> #include <linux/err.h>
>>>>@@ -328,6 +329,47 @@ void iommu_device_unregister(struct 
>>>>iommu_device *iommu)
>>>> }
>>>> EXPORT_SYMBOL_GPL(iommu_device_unregister);
>>>>+struct iommu_dev_iter {
>>>>+    struct iommu_device *iommu;
>>>>+    iommu_dev_iter_fn fn;
>>>>+};
>>>>+
>>>>+static int _iommu_for_each_dev_cb(struct device *dev, void *data)
>>>>+{
>>>>+    struct iommu_dev_iter *iter = data;
>>>>+
>>>>+    if (dev->iommu && dev->iommu->iommu_dev == iter->iommu)
>>>>+        return iter->fn(dev, iter->iommu);
>>>>+
>>>>+    return 0;
>>>>+}
>>>>+
>>>>+/**
>>>>+ * iommu_for_each_dev() - Iterate over all devices attached to an IOMMU
>>>>+ * @iommu: IOMMU instance
>>>>+ * @fn: Callback to call for each device attached to @iommu
>>>>+ *
>>>>+ * Return: 0 on success, or negative error code.
>>>>+ */
>>>>+int iommu_for_each_dev(struct iommu_device *iommu, 
>>>>iommu_dev_iter_fn fn)
>>>>+{
>>>>+    struct iommu_dev_iter iter = {
>>>>+        .iommu = iommu,
>>>>+        .fn = fn,
>>>>+    };
>>>>+    int ret;
>>>>+
>>>>+    for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>>>>+        ret = bus_for_each_dev(iommu_buses[i], NULL, &iter,
>>>>+                       _iommu_for_each_dev_cb);
>>>>+        if (ret)
>>>>+            return ret;
>>>>+    }
>>>>+
>>>>+    return 0;
>>>>+}
>>>>+EXPORT_SYMBOL_GPL(iommu_for_each_dev);
>>>
>>>The function has no locking against iommu probe or release, so the
>>>callback can read dev->iommu while it is being freed or before it is
>>>fully set up.
>>
>>It is only called from intel_iommu_shutdown(), which runs after the
>>other CPUs are stopped and interrupts are disabled, so probe and release
>>can't run. I will rename it to iommu_for_each_dev_unsafe(), document
>>that it must only be called at shutdown and drop the export, since the
>>only user is built in.
>
>If it's only intended for the intel iommu driver, then it should be
>open-coded there. There is no need to add an immature interface like
>this to the core. It could be misused in the future.

Agreed. I will open code it in the VT-d driver in the next revision.

>
>Thanks,
>baolu

Thanks,
Sami
