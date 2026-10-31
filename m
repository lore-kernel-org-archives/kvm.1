Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793411735;
	b=NPndxB6urX3iyN+wNBF7tO1+vF1Au2rLsXc46UvuqEvRvXqkJX7UkKG8WuqT5l43lIv6
	 TcL2C1CRUHZt77vUuCOKe0MG6T1tX2SLDH1o9W1IwmPXrcoHuo8JOR1b23R8uln3tUWqw
	 toSqkG0V+djIp6JPfv0x7ORVrOp2uY/K441OXyMninqBapw4idFudyL1v3iR93ZhZ6uxB
	 dPqZ+cPybUBM3J67zpwOpM8MJTxfJEeUO3ipqNgAEgW+bIsb+YEJ429YEGMK3soUZH1QL
	 PdWUiuHVjoO2xKbPurYMTACl2vtSz2G7tg2MN3vz/uh0H1/yum1FKPVqE89X2qkl+Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793411735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=L2o29doa9iweGy825AZDWyjKjFpPQ47IdlCL02by6zg=;
	b=ZHALO1NDkbGYENFwBhOXOGYBlYIkyINKpUqHCzQ+HFEH13UtuXhsri7TOTWeVoYXrsI5
	 xPgXqqYRmSi/7wzZheapTq3K+izsPQ+m3acRXjHnpPxfFh0mcPRqizqImWcVuG1pKkGhW
	 JEdquS796zP8DOzSXqcsLOzqDLKNU87SSxeIWfKQ/DdlVrF6HM86ZFy3LYa+GMd8wI6Ka
	 1YKytBpkoHPSQOKB5HZPaAaPNGx3JnWLJ4qHn0BgCCXlzU19WvyDNGpOHa85wM/tsoTTx
	 ssc8SLyANZdXUHcNwSqciC8zWtSoZ4qH30S3KMBcNlx1WEGZpgci93UpcF17rMA5rfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F96tyXGV;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706CB606A31A
	for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 01:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 706CB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F96tyXGV
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2eb0a52d605so26905ad.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 18:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793411735; x=1794016535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L2o29doa9iweGy825AZDWyjKjFpPQ47IdlCL02by6zg=;
        b=F96tyXGVmJkDVU46Xzh9DewGvE3vfWZ7yJmgTzVsmi0CoIQZtkXJtpCSsq8gnwnqaI
         aoSBql31GrHSp4jTBb9lhxs8B7jkI6Jz8mzLvXlcCjM58XXuSsgIL/Yz3nOf789q5a7G
         OS1nCEK5GG9d058MSfOfdJ0FXGNyhwJAAjT0GQD3YrOFed4MeCK+kYzI8m1WtIfk3cWj
         KVVm8Dn0NYB11xlsMD6swOhAaCqaHt3kJXN+CkhdDEaaLAWjObz7Bfq/8+xkNUHSIqVX
         yCksSeYaSdWZVry+US2Kiia1SV2Z6njlrKVMKe7EZWcavVZXvR2jyOD30DXKs5T4qdEk
         rA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793411735; x=1794016535;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2o29doa9iweGy825AZDWyjKjFpPQ47IdlCL02by6zg=;
        b=pXGhyyF1cTNN4mHsuzxaaRIzc1VaogGGd78r9c3Otp0q835lhWp1Tt0rTuPwN8jzpi
         UVwuxoRDe6eQUWrjP8Jb5ZT3LJQo8UAw1CrBc27TOubauDXQCc8B4DE2idWobW+5G6Ic
         go5LWXxtF0mBj3FEpPqf6mAW1tI3RUCaS0P9mcolDUVTbyE7ZkPgls6AA3q5LxjF5mr2
         jPM6zj3BfPx4qiQbqNEiUmyapeg6zQCEH3YJjbCV2WnSViqBez4UKIjRrLZXPV7B0kUl
         vVNgG1oDAtypiMir5aTnrm5tWskyenBqdPIetQ0tZ2uvjjV/qJkBd4e+11Nf/0fU5cly
         NkBA==
X-Forwarded-Encrypted: i=1; AKwUvBzoFoFGvulcaZjgdGBOg0GsOPBwQIPapmfjK3VKBaMYxupou/zws8zXuaHu+/Up+9dMio0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwQBi4wdSeEX3xr2HcWTb0K0zlAz2S+YlESLLlS05k9+CWOe8l
	2Su75bNdXoBcYEfBYjJAAAV/1ve0Gilx1V5n8zAFgUhr3xJ3yS/ZJgcm6CmIZRxDng==
X-Gm-Gg: AYBFou1yJ6FEenW6MFyfsNsnfTmJZFXe3QUaYl5I8Tf554ire2MABS0kdgpBb7FZLmT
	KSF3bch7Xe8vxvnydyIBitDmDb10a4D8h8l+md3EHeR+z07Z/pR+hM8OeMUzo5p+p5gNlOanf6O
	Yvq1Fni2yjpuaJlRdZlC+1kq7DQO1D+FET015KEtn2Rfu8kwyp004319z59TmuCIERHLjvtSYbb
	dUvkiwJsdAiH3fmC0olUaJ1K4KF1sTj92anGbIkqVgEQMfLDRHCNXELC4997H3Snz5DyF+FMF+2
	xGmxFJePDuaS5rGvHBRSM2qVo55MzTAue/FXc2VrDoHxHlFVp6EvCPl1mghoU0DO3vhVGX2dB1s
	Tv18D60KVXZL1HGp47v28NKNKwrW5EECLD+iDktaaCt9xodyg0920ryzXSZA/s2DhuGEsmmHkvd
	CbMRKLox4dqLkJDCOUD9h0VJE99796V5tJqY4/x63cpjIEUGRvo/mVXYiMefBfxRDXSvWsWfVn5
	RsOyTYdLBOoiy8TVd47Tg6yvlorf0g9+a+ui6ecdcLS3pRulCy8kgNeMdfTroT4B7N7x11MXEkX
	L6lI8LdvZYpCnWuAQ6sH5N0xnvGYVOvokLJz2q4QH3C6Cm3eN/+Ofe7RkcdJou622JTc3vpGyqS
	UbqE86ypcyS3Wl5H7vypf5delZJrsBI/12lFzEnS2vf0=
X-Received: by 2002:a17:902:fdab:b0:2e6:f400:5655 with SMTP id d9443c01a7336-2eb1ebe3d33mr14502875ad.3.1793411734199;
        Fri, 30 Oct 2026 18:55:34 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98afe3sm10181261a91.12.2026.10.30.18.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 18:55:33 -0700 (PDT)
Date: Sat, 31 Oct 2026 01:55:29 +0000
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
Subject: Re: [PATCH v6 08/18] iommu: Add APIs to get iommu and device
 preserved state
Message-ID: <auVJWkRz7C_Cs78m@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-9-skhawaja@google.com>
 <7e73da77-3cd2-491a-9ea2-68263f2b5d71@linux.intel.com>
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
In-Reply-To: <7e73da77-3cd2-491a-9ea2-68263f2b5d71@linux.intel.com>

On Fri, Oct 30, 2026 at 02:03:01PM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>The preserved state of the device and IOMMU needs to be fetched during
>>shutdown and boot in the next kernel. Add APIs that can be used to fetch
>>the preserved state of a device and IOMMU. The APIs will only be used
>>during shutdown and after liveupdate so no locking needed.
>>
>>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/liveupdate.c       | 88 ++++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h | 70 +++++++++++++++++++++++++
>>  2 files changed, 158 insertions(+)
>>
>
>[...]
>
>>+
>>+/**
>>+ * iommu_get_preserved_data() - Get preserved data for an IOMMU HW
>>+ * @token: Token used to preserve this IOMMU HW
>>+ * @type: IOMMU type in preserved state
>>+ *
>>+ * Gets the preserved state of an IOMMU HW using token and the IOMMU type.
>>+ *
>>+ * Return: struct iommu_hw_ser on success, NULL if no preserved state found.
>>+ */
>>+struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
>>+{
>>+	struct iommu_hw_ser *iommu_ser;
>>+	struct iommu_flb_obj *flb_obj;
>>+	struct kho_block_set_it it;
>>+	int ret;
>>+
>>+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
>
>iommu_get_preserved_data() returns the incoming state, while
>iommu_preserved_state() returns the outgoing state. The naming is
>confusing.
>
>How about using "preserved" for the old kernel before kexec and
>"restored" for the new kernel after kexec? For example,
>iommu_get_restored_state() would be consistent with
>dev_iommu_restored_state() and iommu_domain_restored_state().

Agreed. This makes it consistent. I will update this, and rename
iommu_for_each_preserved_device() the same way since it also walks the
restored state.

>
>>+	if (ret)
>>+		return NULL;
>>+
>>+	iommu_ser_set_for_each(&flb_obj->iommu_set, it, iommu_ser) {
>>+		if (iommu_ser->token == token && iommu_ser->type == type)
>>+			break;
>>+	}
>>+
>>+	liveupdate_flb_put_incoming(&iommu_flb);
>>+	return iommu_ser;
>>+}
>>+EXPORT_SYMBOL(iommu_get_preserved_data);
>
>Why are different export macros used in the same file?
>
>  EXPORT_SYMBOL(iommu_get_preserved_data);
>  EXPORT_SYMBOL_GPL(iommu_preserve_domain);
>
>Should these all be EXPORT_SYMBOL_GPL?

Agreed. Will update.
>
>>+
>>  /**
>>   * iommu_preserve_domain() - Preserve an IOMMU domain across live update
>>   * @domain: Domain to preserve
>>diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
>>index cdf8a82b7f1d..10fcdd41c7a1 100644
>>--- a/include/linux/iommu-liveupdate.h
>>+++ b/include/linux/iommu-liveupdate.h
>>@@ -13,6 +13,16 @@
>>  #include <linux/liveupdate.h>
>>  #include <linux/kho/abi/iommu.h>
>>+/**
>>+ * iommu_preserved_device_iter_fn - Callback for iterating preserved devices
>>+ * @ser: Pointer to serialized device state
>>+ * @arg: User-defined context argument
>>+ *
>>+ * Return: 0 to continue iteration, or a negative error code to abort.
>>+ */
>>+typedef int (*iommu_preserved_device_iter_fn)(struct iommu_device_ser *ser,
>>+					      void *arg);
>>+
>>  #ifdef CONFIG_IOMMU_LIVEUPDATE
>>  int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
>>  void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
>>@@ -52,6 +62,46 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
>>  	return NULL;
>>  }
>>+/**
>>+ * iommu_domain_restored_state() - Get restored state of an IOMMU domain
>>+ * @domain: Pointer to struct iommu_domain to get restored state of.
>>+ *
>>+ * Return: Pointer to restored state on success, NULL on error.
>>+ */
>>+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>>+{
>>+	struct iommu_domain_ser *ser;
>>+
>>+	ser = domain->domain_ser;
>>+	if (ser && (ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
>>+		return ser;
>>+
>>+	return NULL;
>>+}
>>+
>>+/**
>>+ * dev_iommu_restored_state() - Get restored state of a device
>>+ * @dev: Target device
>>+ *
>>+ * Return: Restored state pointer or NULL.
>>+ */
>>+static inline void *dev_iommu_restored_state(struct device *dev)
>>+{
>>+	struct iommu_device_ser *ser;
>>+
>>+	if (!dev->iommu)
>>+		return NULL;
>>+
>>+	ser = READ_ONCE(dev->iommu->device_ser);
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
>>@@ -88,6 +138,26 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
>>  	return NULL;
>>  }
>>+static inline void *dev_iommu_restored_state(struct device *dev)
>>+{
>>+	return NULL;
>>+}
>>+
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

Thanks,
Sami
