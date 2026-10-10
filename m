Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8772264A3
	for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602866; cv=none; b=IEq7PkO9kcwjagzpEzwkh87rB7rLXSQS5oY66q4zqI65p6nCrGeoh3O8YW6vR4qsulgbEzsV13pQIm+fs+ilzEasTld3+Ap7CYer1SchJ9lTEBh2JRJZaiX81pgXltqEenZkqU9HR9wldSoPdwboza0jkYsxNUVOknavI274A4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602866; c=relaxed/simple;
	bh=bY/lFkbzuL0wWuJJ/NycYQnLQsKUteIgt6DpWGrrrTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQv0J+uTmvAZbpA2tRG/dtE06zJVEWFv9F+ldfuO5n+zsgERE/yKiTYT9jFuZySv9sLHJzXMiWXuuHs6i/sGa1BVTZKhUSr9QwPev2tShAgabBpJD9imrDSdd8/GTsDy/J4Rmexn8/0V7iCRqfpvCC7VyRHoFZCIzbwTLkZuQVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bfLm9VTh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfLm9VTh"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8623790f8so11375ad.0
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 20:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791602865; x=1792207665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LXRGckOxSl9+/CEvwJi4Okj+sE0MNttNQkzUsECyRvQ=;
        b=bfLm9VThgTkyWTLMqQY1MOmcuIYZJgQYLntqQ740a2jncjfw25Ij/Go3Y9J7s+zyD6
         H2xzK2uJS4184v/clAMoA/OLYIUArzpR0Mv3LHdlLEjLaVoF1FsgNK1IzZGC/aU/e9gv
         Z23oDa5o+/bMfy6Z7Ws8X/3KA+YyeJxQp76j55CG0CoAxq3LlBI1UU3h1tjjUmRncT0H
         +DUb9+wsfXEnBxrEcTacPmJR1tP32kab0Ou/MYWsxM/DYqJZf8Mc3sSuRpgeQ9zXgIQL
         qrZfUR8lJBNUd3hwTYi0CL9BJgX6+vv+YoOhPSJQiPgKBW1YCDRuy1k+qBLtZBvnpGb8
         e82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791602865; x=1792207665;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LXRGckOxSl9+/CEvwJi4Okj+sE0MNttNQkzUsECyRvQ=;
        b=NezqelrxAi2VVqpe5Etzz2FF42t1juUEc+A2MzrkaDVtGIGgbyobobW3n1c4yefIKN
         reVOMpbljNdFbHFKASd8ZHyEcl2SkpYyYIz4D1pXJ0jyBVpnVcpkYKhWsb6Jg7AyNESz
         wsdDmRrbaxS+TmnvrylDSXZO6i148+/cY/sqVvV6uQFvc2HAeU6Ypct1BcgUv79iQ/as
         /9HjPzGqgR56TZcdfqwyOsYajT2ROhOHMcZZLkl350DUueRZx3W6VFUJ1ybQN0a8w7Lu
         dmIxPz1cFoNqqD4SA+Y8guy9lRvCjNJQb6axqMI6udpedHF2f6RF+tQzhzV1x+WPZ+zH
         7eiA==
X-Forwarded-Encrypted: i=1; AKwUvBwAZkrXWbp3R2F73EHNy3uZR7KZbVEbO/pHmpqVOYUJwDQBikyJWHKwMHhKR7Q82L12vsg=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0A4wPqfyHfGr9izBCmxIweip/AvYVrNO2eoPKHfa6idi1k6Oq
	3UYbwNTSh6vb+CJ/Ytjku4W9GqLN5AeOr1LR5ntaEl10wfYLm1Gw8QjuCwPvWI/z7Q==
X-Gm-Gg: AYBFou3KRACnbYX/R9fI9fkhGVFWmkR6X4MKUzu1QhF8wos0IcytAINju6kGajDD5F0
	flS4IloTcm31eAjIbh6GCJnJb5bwSyMOnnwhtDe+Sci9dCAbLdwH3YWZAgwNYO+PjY7YPgPPdYg
	I9yW9SWxIf+0DyPxxFhzj2srOZcKNUDm0tgX6csTEIi4KbTq0doktfzAklRqXCLdjp1kgoy7NzT
	9ZhnbDfLb2cIuJWGJhIGGZxOk5ptiOlp9+gtB1s+HE6rONVpKaLbz1aRBKLxF2xzSdd6ufZf95g
	jlaYURd/qzecoM5JAR5GCTmhgrt/3Ry1+X+qdDJSLSlW67qW4zsTrvL6DpoibvWkS8Myp02aSnF
	gjj0nm82DMjdZCD0PHfFmM9RvVVCeszw6fMfiXrY2p6CWNoL6bv/eTpjFte523TG/KVVrIuHA3y
	mSayeBeNUVP8WRUI9xN8p+Bb5hIDehx8oCejvq8Tslt7CHzZGzEECTUIuAsQNOG7y56rlKtbm7Q
	wGZKyKR5v7k23NxZl5LoEaA+Ml87/qGc1HCH3jEhHXp+Vgrkq9meQyPd6s5oq266sI=
X-Received: by 2002:a17:902:e88e:b0:2e6:3f5:8f2e with SMTP id d9443c01a7336-2e87bc1caecmr1258995ad.3.1791602864275;
        Fri, 09 Oct 2026 20:27:44 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab39238608sm6549877a91.17.2026.10.09.20.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:27:43 -0700 (PDT)
Date: Sat, 10 Oct 2026 03:27:39 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 06/18] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <asmupccDpWIFdQsG@google.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-7-skhawaja@google.com>
 <asW6q0UPBX+Y/YL0@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <asW6q0UPBX+Y/YL0@nvidia.com>

On Tue, Oct 06, 2026 at 08:21:15PM -0700, Nicolin Chen wrote:
>On Mon, Sep 21, 2026 at 12:48:22AM +0000, Samiullah Khawaja wrote:
>> @@ -827,6 +838,8 @@ struct iommu_domain_ops {
>>   * @singleton_group: Used internally for drivers that have only one group
>>   * @max_pasids: number of supported PASIDs
>>   * @ready: set once iommu_device_register() has completed successfully
>> + * @outgoing_preserved_state: preserved iommu state of outgoing kernel for
>> + * liveupdate.
>>   */
>>  struct iommu_device {
>>  	struct list_head list;
>> @@ -836,6 +849,10 @@ struct iommu_device {
>>  	struct iommu_group *singleton_group;
>>  	u32 max_pasids;
>>  	bool ready;
>> +
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	struct iommu_hw_ser *outgoing_preserved_state;
>> +#endif
>
>It'd be nicer to align the naming.
>
>There are:
>	struct iommu_hw_ser *outgoing_preserved_state;
>	..
>	struct iommu_device_ser *device_ser;
>	..
>	struct iommu_domain_ser *preserved_state
>
>Maybe use "_ser" for all?

That is a fair point. I will update this.
>
>>
>>  /**
>> @@ -890,6 +907,9 @@ struct dev_iommu {
>>  	u32				pci_32bit_workaround:1;
>>  	u32				require_direct:1;
>>  	u32				shadow_on_flush:1;
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	struct iommu_device_ser		*device_ser;
>> +#endif
>
>Missing its kdoc update.

Will update.
>
>
>> @@ -1206,6 +1226,28 @@ static inline void *dev_iommu_priv_get(struct device *dev)
>>
>>  void dev_iommu_priv_set(struct device *dev, void *priv);
>>
>> +/**
>> + * typedef iommu_dev_iter_fn - Callback for iterating IOMMU attached devices
>> + * @dev: Attached device
>> + * @iommu: IOMMU instance
>> + * @arg: Private argument passed to iterator
>> + *
>> + * Return: 0 on success, or negative error code.
>> + */
>> +typedef int (*iommu_dev_iter_fn)(struct device *dev,
>> +				 struct iommu_device *iommu, void *arg);
>> +
>> +/**
>> + * struct iommu_dev_iter - Iterator for devices attached to an IOMMU
>> + */
>> +struct iommu_dev_iter {
>> +	struct iommu_device *iommu;
>> +	iommu_dev_iter_fn fn;
>> +	void *arg;
>> +};
>> +
>> +int iommu_for_each_dev(struct iommu_dev_iter *iter);
>
>It isn't very necessarily to expose iommu_dev_iter.
>
>iommu_for_each_dev could be simpler:
>
>int iommu_for_each_dev(struct iommu_device *iommu, iommu_dev_iter_fn fn,
>		       void *arg);
>
>Also, arg seems unused?

Agreed. I will update it to this:

int iommu_for_each_dev(struct iommu_device *iommu, iommu_dev_iter_fn fn);
>
>Nicolin

Thanks,
Sami
