Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0652853F2
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773968743; cv=none; b=eQ++1DA8tTmM6j6hV3xzsYkuCvtlKb3qe4ljJwP4CxIHm/DpFpsJGkLkSChkDcduzYzbRL0fhovF3Z34775iR+lXWJLuRMWsAmDgdqUCDeXkQaWJpJjpQcf3G7plOIpKp+EXwUT71ElRFbHN0PrVYaGIkYeICsKYeUdP8GQrnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773968743; c=relaxed/simple;
	bh=QIqXKeW1izdWNR8jM1NhwLjTo9tqpcgolnf5WC9Fg60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0qLV4UVo9u4wpbKh/mOYAaOOMlPNolYuo84qhn+M1LjoqWMSrFiPXFJT3R3EAUvryxUi864IT0/JErnduqwb/PRZbnnHdZcFrMw/RtBK3k0gGyqIslz2tO5X6ywFm1gfN3FquXAF4kjDdVQ1e2wygm3HfpmYFTOUrphryzw480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QX6oqucH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QX6oqucH"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so40115ad.0
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 18:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773968739; x=1774573539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xTn3hK2jgdEVmDsb9ax7KRypVVI5dKtyHQlrYUlMo/M=;
        b=QX6oqucHCmpTNXMM7EleN+m74DkIEC0zIFaGMl/igtGkOKapdJ5+uvk/espDqmtnpF
         7JgOLp2fqWeK7P3j6pT8BDnWyPvIGT9YlhurV0mc/pDkWDwev7wsXmnZY4Qk32Av46Tx
         +vOwFj9D7VffPqpskUioOMTArKl8nuQPnAbjiAdA3xbo2MgdG3UuruG7XMhtox641hxf
         RjgFV0O388/oz5wAGFBOJEgm9TDtaHdHaDjGdY7BMg4efyGfkcZMv8qgMtmn1DrEprue
         p9YQ0Ct6BQZjDC4/indkGHBQBW+np5K4cl+aGS+ERD1oPLNpV291HPwk4Ire4kQpKG0G
         WZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773968739; x=1774573539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTn3hK2jgdEVmDsb9ax7KRypVVI5dKtyHQlrYUlMo/M=;
        b=gEbRwRxMDjjcRcU0xsebGBFnHCnAmjw58heOlWHmKfjMFKSn3bvalVr/SsEFj5cPIN
         0k3buPTFPJ5N329HFVo/+Mr5HP9rK5keQ3ewdxi0drDhcSPjr5E85VvSeI64cd4LbuLX
         AxV6u0TOFUl6ExG+KGgvdhAM8m9irc+QEBR6ZEcFVrw+WVw9OFQnry/NFLwi/zHCJld0
         BnHo/EUKvqvmzozY1hCUXgKzvQnCnd/HQjA6ZC/jOQmpf/E4JtqgwywCwK2BTaBluoEA
         irOoUMmmIIggIIs4ppsNW3kbO64qrqFW5j+3B7ienXGxwXIJmA5ld5QJtDK5o9f0DaIn
         2OGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJK2P71PcomG7TisvfFlp8GDuHloXNRCN287XLi8eM4cB1Oz14qj8NvgA/BCVvSlmK6go=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaZHfA60OzSWabHMwEfLmSd11iB4Yvs2w9r35V6rcF3RRCS8F
	2b1EthMgA/lu/ehjcO54fjtXaNsOojvhZGhXpB21hxpE456sC5/oQ8kphVVDxvdXLA==
X-Gm-Gg: ATEYQzxYSEiGerdY15V9Yz6tlqj1SBTubl7rW/fW+ZOw2KTiOezXpA9j2MRcuEbm9Rc
	NolxOOUOmWdko5Po2Q1yASssIsNZWYEOWYc+bZftYx/Ws95K/ji7aYQi9L8OcZMPf6B0ApRKuiW
	RF/9i8Ikrss6E3jWYfGdRdvBDCSrWgnyWxe/E+O8UDzkg0/TCl/JQL52o4XQcwiLXCI1ybpBra3
	9pXTtLImyBSOC1QGmeVbNRrBJODPpSvm1xh8Ei8V85fJAh1dLaXW01qEQDJlaZz//K6nfH+v9Re
	66SdNvigDr1f9+D7M9/p5wPO3JbvYRW6yP4fFYZSL3S2mG1Z1AgUK4VWeCFV2HdpWEXrjqurzRl
	cj9JkZgWJBZqedBwpARq3eJIayajmhN6/wO1ROsnWEIUY6oUm59xtddreMl3o3ndZI8mXEMi0zm
	+Ls27N93OE9YIm373SzwPCDeQaGSY8H+CBSTegtcI2NHvYZEuAfrP2OBbBrQgtOg==
X-Received: by 2002:a17:902:d544:b0:2b0:5cc5:9405 with SMTP id d9443c01a7336-2b08366b3bfmr1001805ad.1.1773968738628;
        Thu, 19 Mar 2026 18:05:38 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836b97fesm4163285ad.84.2026.03.19.18.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:05:38 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:05:34 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 07/14] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <abyX6xWTK4R5_vDp@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-8-skhawaja@google.com>
 <20260319190137.GA3983821.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260319190137.GA3983821.vipinsh@google.com>

Hi Vipin,

On Thu, Mar 19, 2026 at 01:54:27PM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:41PM +0000, Samiullah Khawaja wrote:
>> During boot fetch the preserved state of IOMMU unit and if found then
>> restore the state.
>>
>> - Reuse the root_table that was preserved in the previous kernel.
>> - Reclaim the domain ids of the preserved domains for each preserved
>>   devices so these are not acquired by another domain.
>
>Can this be two patches? One just restoring root table and second one to
>reclaim device ids.

This patch is restoring the state of the preserved IOMMU. The domain ids
are part of the iommu state and used in the context entries that are
being restored in this patch, that is why I kept these in one patch. I
will reword the subject of this patch and add a note on this in commit
message.
>
>> -static void init_translation_status(struct intel_iommu *iommu)
>> +static void init_translation_status(struct intel_iommu *iommu, bool restoring)
>>  {
>>  	u32 gsts;
>>
>>  	gsts = readl(iommu->reg + DMAR_GSTS_REG);
>> -	if (gsts & DMA_GSTS_TES)
>> +	if (!restoring && (gsts & DMA_GSTS_TES))
>>  		iommu->flags |= VTD_FLAG_TRANS_PRE_ENABLED;
>>  }
>
>I think we can just check in the caller, init_dmars(), and not call this
>function. We are already modifying that function, so no need to make
>changes here as well. WDYT?

Yes, I think we can move the if outside.
>
>>
>> @@ -670,10 +670,16 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>>  #endif
>>
>>  /* iommu handling */
>> -static int iommu_alloc_root_entry(struct intel_iommu *iommu)
>> +static int iommu_alloc_root_entry(struct intel_iommu *iommu, struct iommu_ser *restored_state)
>
>Nit: Since we are using iommu_ser at other places, I will recommend to
>keep it same variable name here as well.

Hmm... that is a good point. I think I will update the other places and
change it to restored_state/preserved_state to better reflect the
context.
>
>> @@ -1636,8 +1643,10 @@ static int __init init_dmars(void)
>>  						   intel_pasid_max_id);
>>  		}
>>
>> +		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
>> +
>>  		intel_iommu_init_qi(iommu);
>> -		init_translation_status(iommu);
>> +		init_translation_status(iommu, !!iommu_ser);
>
>Just put 'if' here to avoid changes in init_translation_status().

Agreed.
>
>> +static int __restore_used_domain_ids(struct device_ser *ser, void *arg)
>
>Nit: Just curious, why two __?

I will remove these.
>
>> +{
>> +	int id = ser->domain_iommu_ser.did;
>> +	struct intel_iommu *iommu = arg;
>> +
>> +	ida_alloc_range(&iommu->domain_ida, id, id, GFP_ATOMIC);
>
>Should we check if allocation succeeded or not?

Good point. This should not fail as we are reserving these ids during
init. But I think I will add a WARN here.
>
>> +	return 0;
>> +}
>> +
>> +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>> +					       struct iommu_ser *iommu_ser)
>> +{
>> +	BUG_ON(!kho_restore_folio(iommu_ser->intel.root_table));
>> +	iommu->root_entry = __va(iommu_ser->intel.root_table);
>> +
>> +	restore_iommu_context(iommu);
>> +	iommu_for_each_preserved_device(__restore_used_domain_ids, iommu);
>> +	pr_info("Restored IOMMU[0x%llx] Root Table at: 0x%llx\n",
>> +		iommu->reg_phys, iommu_ser->intel.root_table);
>
>Should raw pointer values be printed like this?

I will remove this.
>
