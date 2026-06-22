Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7519363C7F
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782170875; cv=none; b=MbaqvPQLfgFjUvKF0zkHMBEXuajaIQTAsovnnVZlozMAvnbvqJ/cwDCyr/AnG/igeuKKZDGOxQv/CV6QYI+1InqUaS/c0QVA4dqAUiHMqyR9VbeVNsooMS+ycD3ZiUcO4rQm5ItFZsoR3mvaLdFVr8pu5RSZJGCOSB+8vb9Wjm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782170875; c=relaxed/simple;
	bh=lwVDuCan41sfTJTnrOrdE1tC3q2gBSoCWyBPW5RUdWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3Q70RqcjKhoDaT8/uJWEsO16zk3DOfAdlxARonEXNYsibr0BdzgdJG2S8XADK9kYHdctf+VQzYdtiAREkNEltOUBV+UJzMgevZw665ap3cwyZOm5GJayhWpcllil1huDtr9o36mm3UVOX7Xvg7bH5h56+8tYenAM2ftzTAbkHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vI8N5A2d; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vI8N5A2d"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c6a4eccab1so9865ad.1
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782170872; x=1782775672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wp+dObOPQcCrEViDJa1TZgNuuO73gOCATlytODnl2CU=;
        b=vI8N5A2dkuuC6ZlMglc1nJv4JSKiYLHkIVecLahyg96otfvreNAoaguj+tu8rx7qXP
         HtC49j+CCjL3Q3agyzgPdsOh1F8xO8xYXGfGerCBG7hlKDcJIVry1UdgiX76xQbEkkIi
         59G0k6g/BXR8H4SWaEh6ZSllFTz9cgs3xQrNRLz6j1nEcDSNY/GiWEYwIxYh13DSk1aJ
         PrpRLSia4t9gdlU2qounMYkX4jQ9x5k6DzCPxt+JknJVeSEjfC4JoE1zodUX7qvUJCsX
         caGnY8f4OcLcIa3eFqq/fCq3xAZpfbaXFvPePK3TAr5IB3rwDW0A7nb7STyi0KLpig2k
         2Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782170872; x=1782775672;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wp+dObOPQcCrEViDJa1TZgNuuO73gOCATlytODnl2CU=;
        b=QP8Hvl1d8VfIvAYkXLhRMqfkAIJKdWeESL7FiDC8BmYD4T9JHAUnC0E+8kK6Abk/pf
         rCdKCQaAfIJx2Byx9nM1Cotkp2HLrWMb/WE7nMfhB6gumUTdNJsIoCq+EilH+l7fWgzT
         6f4GieA/IqrDHcZexAtLizQ5LVShdk/oDROVFMcfBg0++c1oLZBHZ0WSn1zul4A+tddV
         z9fcMK9gkYzLGeN3gohgXBKRxe4zMWaCZu/RUj9c60BiEDcrniHqSPZq7I3x+p27H+0p
         mVedSrHfl2FNUgeDdd1TLTzccxwpPznKDIChE6fqAHf/VW5qbGcKnGVSrFRz9VQC1r0s
         RLBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrl1htQnGl9D3ZxKP/UDMYsyvLEuDD9ckOiCs8mbQ6ftk7FDThRH7cBVpuPHHGzov3jim0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMAfMz3N7sY1brQY1uaPgShoU7Nwg+cG1/RSTvSytTWkUIxubU
	DlJNZQusAgPOVbj0w1KuBToo8XU8UPpp/F7D8JjXgJ7ZFR+yWHicy4NL33wvTY0dOg==
X-Gm-Gg: AfdE7ckvnlPjJiaTi5f6w+WkIzB0LqZArtsvs1FsVlNLqOT69honVg6HUfmWTWmhBSH
	6WuwgTq09AEng8kqywUoaejcTwVlffzTgDHbNWPYw6s/WkPSpjjZUMQF6weUNi/vYNoUPXM0BoJ
	4647tLWrq2ruN7cqhf2BlSDzHgXWtHbvYPA8e+n8bWUhIUtgVssPGWJd+4LAuwTEQFrDUjVOnjZ
	3jSlcPYDPJvnj8LFXu6zOmQtQ7xJOW7ehFGUpjzz1IG3OmM524tQ10sJC63sBN79inl9DmvAAZo
	2LgrsqVbPksnB4aCcPkft1HeYtfj2TPKL6ug73ABzadkiEtOdY5M+/Wjp1yjU74wnsK6ycq0lLy
	QG2zc+7bfQOtOcQdElDrkU30VSDVjaWcRSWraiSqWqvhOaicete/vmNj67u2Y8iB8LThtBTcPXU
	4SkrRnxxhLAFFQEyMaTE4eolLUp+W1P9qCUUozAxAq/EKmpimmtSiKYy+FRwwvyCOVmfTUcf9Zf
	xgYDz44oFaWk9TgPYc=
X-Received: by 2002:a17:902:ec83:b0:2b4:641a:6b7c with SMTP id d9443c01a7336-2c7c70ec5damr540285ad.13.1782170871493;
        Mon, 22 Jun 2026 16:27:51 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af57asm97554325ad.13.2026.06.22.16.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 16:27:50 -0700 (PDT)
Date: Mon, 22 Jun 2026 23:27:47 +0000
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
Subject: Re: [PATCH v3 09/18] iommu: Add APIs to get iommu and device
 preserved state
Message-ID: <ajnAcPp13wXSiw8l@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-10-skhawaja@google.com>
 <ce3f6eb2-99c4-4582-a11b-a5578b62d401@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ce3f6eb2-99c4-4582-a11b-a5578b62d401@linux.intel.com>

On Mon, Jun 22, 2026 at 11:10:55AM +0800, Baolu Lu wrote:
>On 6/15/26 07:37, Samiullah Khawaja wrote:
>>The preserved state of the device and IOMMU needs to be fetched during
>>shutdown and boot in the next kernel. Add APIs that can be used to fetch
>>the preserved state of a device and IOMMU. The APIs will only be used
>>during shutdown and after liveupdate so no locking needed.
>>
>>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/liveupdate.c       | 75 ++++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h | 31 +++++++++++++
>>  2 files changed, 106 insertions(+)
>>
>>diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>>index 2d782023407d..90750e78cd2a 100644
>>--- a/drivers/iommu/liveupdate.c
>>+++ b/drivers/iommu/liveupdate.c
>>@@ -18,6 +18,17 @@
>>  #define iommu_max_objs_per_page(_array) \
>>  	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
>>+#define iommu_liveupdate_for_each_obj(_arr, _obj, _idx)			\
>>+	for ((_idx) = 0, (_obj) = (_arr)->objects;			\
>>+	     (_idx) < (_arr)->hdr.nr_objects; (_idx)++, (_obj)++)	\
>>+		if (((_obj)->hdr.flags & IOMMU_SER_FLAG_DELETED))	\
>>+			continue;					\
>>+		else
>>+
>>+#define iommu_liveupdate_for_each_arr(_arr)				\
>>+	for (; (_arr); (_arr) = (_arr)->hdr.next_array_phys ?		\
>>+	     phys_to_virt((_arr)->hdr.next_array_phys) : NULL)
>>+
>>  struct iommu_flb_obj {
>>  	struct mutex lock;
>>  	struct iommu_flb_ser *ser;
>>@@ -216,6 +227,70 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>>  }
>>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
>>+int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>>+				    void *arg)
>>+{
>>+	struct iommu_flb_obj *flb_obj;
>>+	struct iommu_device_array_ser *array;
>>+	struct iommu_device_ser *device_ser;
>>+	int ret, idx;
>>+
>>+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
>>+	if (ret)
>>+		return -ENOENT;
>>+
>>+	if (!flb_obj->ser->device_array_phys)
>>+		return -ENOENT;
>>+
>>+	array = phys_to_virt(flb_obj->ser->device_array_phys);
>>+	iommu_liveupdate_for_each_arr(array) {
>>+		iommu_liveupdate_for_each_obj(array, device_ser, idx) {
>>+			ret = fn(device_ser, arg);
>>+			if (ret)
>>+				goto out;
>>+		}
>>+	}
>>+
>>+out:
>>+	liveupdate_flb_put_incoming(&iommu_flb);
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL(iommu_for_each_preserved_device);
>>+
>>+struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
>>+{
>>+	struct iommu_hw_ser *iommu_ser = NULL;
>>+	struct iommu_hw_array_ser *array;
>>+	struct iommu_flb_obj *flb_obj;
>>+	int ret, idx;
>>+
>>+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
>>+	if (ret == -ENODATA || ret == -ENOENT)
>>+		return NULL;
>>+
>>+	if (ret)
>>+		return ERR_PTR(ret);
>
>Why does this helper return both NULL and an ERR_PTR()? Is NULL
>considered an error case here? Also, why are -ENODATA and -ENOENT
>treated differently?

NULL indicates that no preserved state exists for this iommu HW, so
setup normally as cold boot. ERR_PTR() indicates a fatal parsing or
corruption error in the KHO tree that the driver needs to explicitly
handle or abort on.

liveupdate_flb_get_incoming() returns two different errors for two
different missing-data scenarios:

-ENODATA: The system did not perform a live update.
-ENOENT: The system did perform a live update, but no data was preserved
for this specific FLB.

 From the IOMMU driver's perspective, both scenarios simply mean "proceed
with a normal cold boot," which is why we intercept them and return
NULL.

But as you suggested later, I will add kdocs for these to document all
these things.
>
>>+
>>+	if (!flb_obj->ser->iommu_array_phys) {
>>+		iommu_ser = ERR_PTR(-EINVAL);
>>+		goto out;
>>+	}
>>+
>>+	array = phys_to_virt(flb_obj->ser->iommu_array_phys);
>>+	iommu_liveupdate_for_each_arr(array) {
>>+		iommu_liveupdate_for_each_obj(array, iommu_ser, idx) {
>>+			if (iommu_ser->token == token && iommu_ser->type == type)
>>+				goto out;
>>+		}
>>+	}
>>+
>>+	iommu_ser = NULL;
>>+out:
>>+	liveupdate_flb_put_incoming(&iommu_flb);
>>+	return iommu_ser;
>>+}
>>+EXPORT_SYMBOL(iommu_get_preserved_data);
>
>These two helpers are intended for use by IOMMU drivers, correct? If so,
>please add kernel-doc style comments to document their usage and guide
>how drivers should use them.

Agreed. Will do.
>
>>+
>>  static int alloc_object_ser(void **curr_array_ptr, u64 max_objs)
>>  {
>>  	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
>>diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
>>index f9528c94979d..5ad006892cbd 100644
>>--- a/include/linux/iommu-liveupdate.h
>>+++ b/include/linux/iommu-liveupdate.h
>>@@ -13,6 +13,8 @@
>>  #include <linux/liveupdate.h>
>>  #include <linux/kho/abi/iommu.h>
>>+typedef int (*iommu_preserved_device_iter_fn)(struct iommu_device_ser *ser,
>>+					      void *arg);
>>  #ifdef CONFIG_IOMMU_LIVEUPDATE
>>  static inline void *dev_iommu_preserved_state(struct device *dev)
>>  {
>>@@ -28,6 +30,20 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
>>  	return NULL;
>>  }
>>+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>>+{
>>+	struct iommu_domain_ser *ser;
>>+
>>+	ser = domain->preserved_state;
>>+	if (ser && (ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
>>+		return ser;
>>+
>>+	return NULL;
>>+}
>>+
>>+int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>>+				    void *arg);
>>+struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type);
>>  int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
>>  void iommu_unpreserve_domain(struct iommu_domain *domain);
>>  int iommu_preserve_device(struct iommu_domain *domain,
>>@@ -44,6 +60,21 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
>>  	return NULL;
>>  }
>>+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>>+{
>>+	return NULL;
>>+}
>>+
>>+static inline int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn, void *arg)
>>+{
>>+	return -EOPNOTSUPP;
>>+}
>>+
>>+static inline struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
>>+{
>>+	return NULL;
>>+}
>>+
>>  static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
>>  {
>>  	return -EOPNOTSUPP;
>
>Thanks,
>baolu
>

Thanks,
Sami
