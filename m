Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE630AABE
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307167; cv=none; b=B808nccAKbRygmgHfqRsRpKh5mo8fkit8pfxEcUSgHUo9JCdB2PW+4DgcMBTvriaMG1C9R97qxJOf0akBq1sfouseyaE1fr7VG5CXOSIpY67E4ooeaEXYrDPu5eo/CBjPWnjpdeSxGBetQ6OJjjOqBKFhOGYn716YhUZNWHTmDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307167; c=relaxed/simple;
	bh=S7TAJoU+IMqYQKKwE9M0wXBnMWS7p5Uteu79IW573uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkzUaZp65qZ6FMGnAg44rWbyzX+s59CX/UfJ3Lv/OrI8GE/4WdOKy8xmKVizCy6eNyq5PIe4GD6jloMON4KJWvZsfhAGjWpVHjwDg7AhWZnginy/MDxt9oHHbAcBduQIepM/a8BurIgKC2RZyOHd/dmgRIry/cWGQDvex9UvTgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bodq/T1c; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bodq/T1c"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b46da8c48eso2565ad.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 12:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779307165; x=1779911965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6s3nWbufKIAdpd+T1kqQvCCgsvhw2lBrbx69UeZQAOE=;
        b=Bodq/T1cfD85etDDlX3rnm2vfzJyWhArEnsD2yEWJEFMWB6Cb+eDb8sAQQx1bjfhV2
         hJ5iQ/dgl7zg68xNjiWmdkRPYfY4iqKufrEEKONr3Vw4oK+5i1s5ZfxO7+qSgRqTDXhz
         hcSfQunAWKdWfdAMmAIG2HSi2Ad06gZxuJWianZX5LuK6+gpYrg5D9uo9F6nrtaRBID1
         x9dO31Q96kdtmtwTTWRpApLbDX1q4xcV9cRjjeAtGr47QzMPofJW6i+F26NBKnKczrsM
         KQcmhLXH8LIBJmKKs3iNi0FtWsgDDMlqwN/FK85UKvBhrj0wAgX1A/p5K/BiO+d+Wfua
         IlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307165; x=1779911965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s3nWbufKIAdpd+T1kqQvCCgsvhw2lBrbx69UeZQAOE=;
        b=a29zCETGT/QlnqqONrUHH7zykTqM+TSE4VOY7qvkykxLusDWiZ5TNv/XBEMP/kUqq9
         mg+VI46zPDG8f2fzlfFQHQNfIgn2AHPuQXiLk4okFFdApkogCG1cAGwnAj5cKBZpDIdA
         6M5TxwNDZ912/ABkPJk7r7Txsx1BlvqxNRDLOeI+a2AzY2naQAMATBtOXQUOcQSKVEnT
         VQnAiidlyTL+ROXCjsykixehzZdfFcNJPduqpgLNGP7XlkXkVqToqARmP7QcYCCg1c6W
         0cYssjs2jw5UozLDgnd3/WuXoIsec1KllpvRtLTXmdUAX4/Wup5onhNIW4EjISL1iyeU
         E32w==
X-Forwarded-Encrypted: i=1; AFNElJ/KnSVdaLbnajwBoDJOsFv042Q7uoFjiwCvvHIHc0OpQ9anUYEDJ3Lqp136XOmkYqPhIzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxybiLRDL47RMLzZ2poIvWg+n4obd1W5y38UL4NA3om65EI+N2o
	q1QuueEdI5143oIR/PEqK/OgUF4YYgh1WVqexpiC/J3FxVFbz6MQVX0IY9Wp2asp+g==
X-Gm-Gg: Acq92OGlFcRVduG6/NhCZNc5FralAlEQU2dLtrnm3Dqzjs01krask6rGXJgb4kxPcLI
	5Y0W0oi+X+WMfSDCSYtqv7Iha0Jv93hu7YlD8kW25urZUpKGltlALpfHNgTIBnnV8L+pXFn5qUE
	SWr9n/aB0Qc9FwtZd3uOVXzklls3ma6YTxeAVpQnFtmF40GFf5mRkWXQOkvk1fvnsJG11UHumIk
	tVgjdF5ZppawblGM4ETElFy14MZ7vkTeSfNffLc4K7oeA3I+3WCgPMFml//+BfoSATQbBLkHzNG
	OwJbvCmVVSE5u5s/38raOLLgiFH/VadDdlKifBtknNvCwS6HttmVpGIJFKkq2r0tdhGzOh0g0aK
	JNSF56oXRA1JCTLsRNzwDKOpmFNl6rNOnhAoRUWA9xvewagF9K4Ys1YzVjumupfg6V6hghzmDt+
	VhI+nTkE6ddKPnML7Rtb4GbQPSeFvH0az/AqGaqoHGDpqGk3WjZ+87KyBp4ia78+7Ynx9IVQ==
X-Received: by 2002:a17:902:d487:b0:2bd:907:2ce5 with SMTP id d9443c01a7336-2be9f694c1bmr510145ad.7.1779307164981;
        Wed, 20 May 2026 12:59:24 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb1006fbsm19676025a12.21.2026.05.20.12.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:59:24 -0700 (PDT)
Date: Wed, 20 May 2026 19:59:21 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
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
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 09/16] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <ag4Ront9mcdRDYBu@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-10-skhawaja@google.com>
 <agzaTPROvwVO-3lO@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agzaTPROvwVO-3lO@google.com>

On Tue, May 19, 2026 at 09:46:52PM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:26PM +0000, Samiullah Khawaja wrote:
>> During boot fetch the preserved state of IOMMU unit and if found then
>> restore the state.
>>
>> - Reuse the root_table that was preserved in the previous kernel.
>> - Reclaim the domain ids of the preserved domains for each preserved
>>   devices so these are not acquired by another domain.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/intel/iommu.c      | 55 ++++++++++++++++++++++--------
>>  drivers/iommu/intel/iommu.h      |  7 ++++
>>  drivers/iommu/intel/liveupdate.c | 57 ++++++++++++++++++++++++++++++++
>>  3 files changed, 105 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 68fecd4e57fa..4118a0861f38 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -670,10 +670,17 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>>  #endif
>>
>>  /* iommu handling */
>> -static int iommu_alloc_root_entry(struct intel_iommu *iommu)
>> +static int iommu_alloc_root_entry(struct intel_iommu *iommu,
>> +				  struct iommu_hw_ser *iommu_ser)
>>  {
>>  	struct root_entry *root;
>>
>> +	if (iommu_ser) {
>> +		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
>> +		__iommu_flush_cache(iommu, iommu->root_entry, ROOT_SIZE);
>> +		return 0;
>> +	}
>> +
>
>Minor nit: I still believe this condition block can be moved into the
>caller? Since the called fetches iommu_ser, it can call this as a stand
>alone helper and bypass calling iommu_alloc_root_entry if (iommu_ser).

Agreed. Also as Baolu suggested the cache flush is not needed, so we can
move it out as it is self-contained. Will update this.
>
>>  	root = iommu_alloc_pages_node_sz(iommu->node, GFP_ATOMIC, SZ_4K);
>>  	if (!root) {
>>  		pr_err("Allocating root entry for %s failed\n",
>> @@ -992,15 +999,16 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>>  		iommu_disable_translation(iommu);
>>  }
>>

[snip]
>
>> +
>> +static int _restore_used_domain_ids(struct iommu_device_ser *ser, void *arg)
>> +{
>> +	int id = ser->domain_iommu_ser.attachment_id;
>> +	struct iommu_hw_ser *iommu_hw_ser;
>> +	struct intel_iommu *iommu = arg;
>> +
>> +	iommu_hw_ser = phys_to_virt(ser->domain_iommu_ser.iommu_phys);
>
>We should check for iommu_phys being NULL here.. I know corruptions can
>be funnier but a WARN_ON(!iommu_phys) could help catch NULL corruptions

Agreed. I will add a WARN_ON here.
>
>> +	if (iommu_hw_ser->type != IOMMU_INTEL)
>> +		return 0;
>> +
>> +	/* Only allocate domain ID from associated IOMMU HW unit */
>> +	if (iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
>> +		return 0;
>> +
>> +	/*
>> +	 * This can fail as multiple preserved devices can share the same domain
>> +	 * ID. Since this is done during DMAR init so these failures can be
>> +	 * ignored.
>> +	 */
>> +	ida_alloc_range(&iommu->domain_ida, id, id, GFP_ATOMIC);
>> +	return 0;
>> +}
>> +
>
>Thanks,
>Praan

Sami
