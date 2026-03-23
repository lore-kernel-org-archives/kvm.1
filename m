Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6BB3DBD52
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294447; cv=none; b=P8Ah4x9IJwlH+dMhipZw057ie3HYwNyK2dqDGwxxpjAsBa6DtlcFG0Iyn2df3nYS7yvy4KLjbGN8T/+Mma9366OU/YZeNduiglCg74DzqjmlR4OkmPOcpp9Sp19sQJNT+H9Mam1P6zd9qNbu9cYWMWfRglO+i9/MNXPT/VLKn8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294447; c=relaxed/simple;
	bh=FK7ryPPLQ1cMRqgcooTytVc5UdVnSaHYn7Jt+YRm4us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5gk1PVHO/m7qVxDZ8ZOhm2J8kTE96xyKvN988shwWSKEMOMUMiUnjAw2FCJlULnBZlBs6a8uV1ZWlAO9jGTONEKaYh0U9gykWh1CfQwgKP03PP/Onhi/EJ3X83EC45a9s94obyXjekJuYi9B2j+aRKbIVv6EIS6XRMFFp+M7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNaNj9EO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNaNj9EO"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b052ec7176so1635ad.1
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 12:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774294437; x=1774899237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fKE3oi4j/7h9F1EbALUrXcAiOT/nZnkORyKYR3F8H7Q=;
        b=dNaNj9EOPQ55EwthgDUp9uIX+gWqZn2BmyY1xXWxff4MZPajf9k8uZIZ/l2wypRXu6
         +R3DFI4joEC8SeyDokmgYQ4onvKvBXAUsaNdWQptw3cWnZVpfpJ4/jhEMTjh7BXwNJns
         2QSHP6YJKc3OncPH9UFkwQFw/K+kY8FLYRYbSEZeqW6iyRr3Bj01M84g102TZ/1Deoav
         mMFc8W8xycR7Uw370OTSzTczodYihwQTvWjVFUSxexKjj9nGz66CISoW6T6mrX2bUYSB
         wzSv5mE4X7dztNGUiOyMqiSmNZzYTW5AXriAKPzXrMRskx3soLUnNNM5GhGo4lQh0tBm
         xetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294437; x=1774899237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKE3oi4j/7h9F1EbALUrXcAiOT/nZnkORyKYR3F8H7Q=;
        b=q7OrKdcHGL8tnmaclzSaMwuIKYc7Gw/qiGb+tw7OkKjBR50Iatk59neTWEDYDOt6LX
         TNe5h1xP1jBJbBnxv37OdBEmXkppn8y5YNCKKpPB21ncPYBYHTgWS7k5WG1j1VktFFwd
         vvC8RCeBCdrKMNH6oX8qbNkpnBq5auTttbLMN6K4/Th6AI6k1x32BxyL+RnCbz8rbCjZ
         5XZYy8EBimLOOF9i2ebqojnJ8UwmU4SkndsgW6gnP2kD+TslXSdXAYqGKuYuMbxRQfB2
         HlxrP/RXNhKxWdsDICaKM8yKZtQ/+/soce/RKH4nVV6ZVqtn1TO8wXEBeotJo2fpgyWW
         +gzw==
X-Forwarded-Encrypted: i=1; AJvYcCX6KjNiFgHIabbYBzBKYRaFHvtl09yOOfcg9PMg7WMXs7cdo+3mCa/33eEH/smVRRy/K2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVx22MeM+u0jbcggFW/UA9TTZw2Uegqk+uX4f6fx5o1Tmcnnjx
	DHZkg5UZFos1IJ3BJWLpa5JhIHaFDlJ+vVJmk/WLqQKHv+Mt1ol4iYYLERfIzOylJQ==
X-Gm-Gg: ATEYQzxvhHoWn0YrxABDXNybZpDZfelDXunTMjnimLo5gXbUwdln2o0BeJsVb0JaZhd
	5gg/VAuN2Rlu7sOERlW2ghnp2flNmPFPRl8AsGzuZd2V3Urj1sv3l2ukMrTsW1vkmxOftXcsmfQ
	ZaJhEQ36qz9Oy2ui+SUSgmp3NwmYlppvzHjKcPTrZFXVnVCuugzmLJ3wiR4YGldGoVpk5A85/4M
	f3kAGCWT60qyalc5VPbvmLvKC8y3lyxDlNwSXx+5NmLLsdAkL60toUp76LbBhC/Oa6iSLhSoxH8
	Ec8ey91+LniJGb1HAoShWAyCmfbJfXl6IAEq4f9NKXBo39+uLpmgRGloePqNIw2H0KZ2G61EefI
	ZQXGVXKZ75XkpZi1WGA+t8HNCS0u2/BC6d7hHfTZTTIo4i/BFm3dznpPeFRBSGARkVFkYVBFn4o
	VQbwSSdrYGNR0+9qiNWasGtwaUB/pLYis+ohlX1FL2MtJgduSRFHdkAECAuRkbvg==
X-Received: by 2002:a17:902:d4cd:b0:2ae:575f:3755 with SMTP id d9443c01a7336-2b0a54ce8cdmr468725ad.20.1774294436733;
        Mon, 23 Mar 2026 12:33:56 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083543503sm125155705ad.27.2026.03.23.12.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:33:56 -0700 (PDT)
Date: Mon, 23 Mar 2026 19:33:52 +0000
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
Subject: Re: [PATCH 07/14] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <acGNBlN1Nwe59L3_@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-8-skhawaja@google.com>
 <acBIL052TH39FpNK@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <acBIL052TH39FpNK@google.com>

On Sun, Mar 22, 2026 at 07:51:11PM +0000, Pranjal Shrivastava wrote:
>On Tue, Feb 03, 2026 at 10:09:41PM +0000, Samiullah Khawaja wrote:
>> During boot fetch the preserved state of IOMMU unit and if found then
>> restore the state.
>>
>> - Reuse the root_table that was preserved in the previous kernel.
>> - Reclaim the domain ids of the preserved domains for each preserved
>>   devices so these are not acquired by another domain.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/intel/iommu.c      | 26 +++++++++++++++------
>>  drivers/iommu/intel/iommu.h      |  7 ++++++
>>  drivers/iommu/intel/liveupdate.c | 40 ++++++++++++++++++++++++++++++++
>>  3 files changed, 66 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index c95de93fb72f..8acb7f8a7627 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -222,12 +222,12 @@ static void clear_translation_pre_enabled(struct intel_iommu *iommu)
>>  	iommu->flags &= ~VTD_FLAG_TRANS_PRE_ENABLED;
>>  }
>>
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
>>
>> @@ -670,10 +670,16 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>>  #endif
>>
>>  /* iommu handling */
>> -static int iommu_alloc_root_entry(struct intel_iommu *iommu)
>> +static int iommu_alloc_root_entry(struct intel_iommu *iommu, struct iommu_ser *restored_state)
>>  {
>>  	struct root_entry *root;
>>
>> +	if (restored_state) {
>> +		intel_iommu_liveupdate_restore_root_table(iommu, restored_state);
>> +		__iommu_flush_cache(iommu, iommu->root_entry, ROOT_SIZE);
>> +		return 0;
>> +	}
>
>Instead of putting this inside the allocator, shouldn't init_dmars and
>intel_iommu_add check for iommu_ser and call
>intel_iommu_liveupdate_restore_root_table() directly, bypassing the
>allocation entirely? This looks like it could be a stand-alone function
>which has nothing to do with allocation.

Agreed. Will move the check out into the caller.
>
>> +
>>  	root = iommu_alloc_pages_node_sz(iommu->node, GFP_ATOMIC, SZ_4K);
>>  	if (!root) {
>>  		pr_err("Allocating root entry for %s failed\n",
>> @@ -1614,6 +1620,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>>
>>  static int __init init_dmars(void)
>>  {
>> +	struct iommu_ser *iommu_ser = NULL;
>>  	struct dmar_drhd_unit *drhd;
>>  	struct intel_iommu *iommu;
>>  	int ret;
>> @@ -1636,8 +1643,10 @@ static int __init init_dmars(void)
>>  						   intel_pasid_max_id);
>>  		}
>>
>> +		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
>> +
>>  		intel_iommu_init_qi(iommu);
>> -		init_translation_status(iommu);
>> +		init_translation_status(iommu, !!iommu_ser);
>>
>>  		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
>>  			iommu_disable_translation(iommu);
>> @@ -1651,7 +1660,7 @@ static int __init init_dmars(void)
>>  		 * we could share the same root & context tables
>>  		 * among all IOMMU's. Need to Split it later.
>>  		 */
>> -		ret = iommu_alloc_root_entry(iommu);
>> +		ret = iommu_alloc_root_entry(iommu, iommu_ser);
>>  		if (ret)
>>  			goto free_iommu;
>>
>> @@ -2110,15 +2119,18 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
>>  static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>>  {
>>  	struct intel_iommu *iommu = dmaru->iommu;
>> +	struct iommu_ser *iommu_ser = NULL;
>>  	int ret;
>>
>
>Nit: Add: /* Fetch the preserved context using MMIO base as a token */ ?

Will add.
>
>> +	iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
>> +
>>  	/*
>>  	 * Disable translation if already enabled prior to OS handover.
>>  	 */
>> -	if (iommu->gcmd & DMA_GCMD_TE)
>> +	if (!iommu_ser && iommu->gcmd & DMA_GCMD_TE)
>>  		iommu_disable_translation(iommu);
>>
>> -	ret = iommu_alloc_root_entry(iommu);
>> +	ret = iommu_alloc_root_entry(iommu, iommu_ser);
>
>I understand that iommu_get_preserved_data() will eventually return NULL
>after the flb_finish op has executed (based on the LUO IOCTLs dropping
>the incoming state), but I'm sensing a potential UAF/double-restore
>issue here that could happen during the boot window.
>
>I believe we could restore the same context multiple times? I see
>intel_iommu_add() is called from both dmar_device_add() and
>dmar_device_remove() paths, and the ACPI probe has the following
>sequence [1]:
>
>static int acpi_pci_root_add(struct acpi_device *device, ...)
>{
>	// ...
>	if (hotadd && dmar_device_add(handle)) {
>		result = -ENXIO;
>		goto end;
>	}
>
>	// ...
>	root->bus = pci_acpi_scan_root(root);
>	if (!root->bus) {
>		// ...
>		result = -ENODEV;
>		goto remove_dmar;
>	}
>	// ...
>
>remove_dmar:
>	if (hotadd)
>		dmar_device_remove(handle);
>end:
>	return result;
>}
>
>If we successfully restored a domain during dmar_device_add(), but the
>ACPI probe fails later (e.g., pci_acpi_scan_root fails), we jump to
>remove_dmar. This tears down the DMAR unit, it unwinds via
>dmar_device_remove() which eventually calls dmar_iommu_hotplug(false)
>where we:
>
>	disable_dmar_iommu(iommu);
>	free_dmar_iommu(iommu);
>
>At this point, the root table folios are freed back to the allocator.
>
>However, if a re-scan is then triggered before the FLB drops the
>incoming state, we would call:
>
>dmar_device_add() -> intel_iommu_add() -> iommu_alloc_root_entry() again
>
>Because the KHO state wasn't marked as deleted/consumed,
>iommu_get_preserved_data() will hand us the exact same iommu_ser pointer?
>
>In which case, we'd call kho_restore_folio(iommu_ser->intel.root_table)
>on a physical page that might have already been reallocated?
>
>Shouldn't the restored state be explicitly marked as consumed
>(obj.deleted = 1), and shouldn't the driver properly unpreserve/clean up
>the KHO tracking during the free_dmar_iommu() teardown path?

Thats a good point.

I think on disable/free the restored state should not be freed abruptly.
The iommu should be able to reuse the same state. We just need to mark
it as consumed/restored. I will rework the disable/free code paths to
handle this.
>
>>  	if (ret)
>>  		goto out;
>>
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 70032e86437d..d7bf63aff17d 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -1283,6 +1283,8 @@ int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_se
>>  void intel_iommu_unpreserve_device(struct device *dev, struct device_ser *device_ser);
>>  int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
>>  void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
>> +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>> +					       struct iommu_ser *iommu_ser);
>>  #else
>>  static inline int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
>>  {
>> @@ -1301,6 +1303,11 @@ static inline int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_
>>  static inline void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser)
>>  {
>>  }
>> +
>> +static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>> +							     struct iommu_ser *iommu_ser)
>> +{
>> +}
>>  #endif
>>
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
>> index 82ba1daf1711..6dcb5783d1db 100644
>> --- a/drivers/iommu/intel/liveupdate.c
>> +++ b/drivers/iommu/intel/liveupdate.c
>> @@ -73,6 +73,46 @@ static int preserve_iommu_context(struct intel_iommu *iommu)
>>  	return ret;
>>  }
>>
>> +static void restore_iommu_context(struct intel_iommu *iommu)
>> +{
>> +	struct context_entry *context;
>> +	int i;
>> +
>> +	for (i = 0; i < ROOT_ENTRY_NR; i++) {
>> +		context = iommu_context_addr(iommu, i, 0, 0);
>> +		if (context)
>> +			BUG_ON(!kho_restore_folio(virt_to_phys(context)));
>> +
>> +		if (!sm_supported(iommu))
>> +			continue;
>> +
>> +		context = iommu_context_addr(iommu, i, 0x80, 0);
>> +		if (context)
>> +			BUG_ON(!kho_restore_folio(virt_to_phys(context)));
>> +	}
>> +}
>> +
>> +static int __restore_used_domain_ids(struct device_ser *ser, void *arg)
>> +{
>> +	int id = ser->domain_iommu_ser.did;
>> +	struct intel_iommu *iommu = arg;
>> +
>
>Shouldn't we check if the did actually belongs to the iommu instance?
>iommu_for_each_preserved_device() iterates over all preserved devices in
>the system. However, here (__restore_used_domain_ids) we allocate the
>device's did in the current iommu->domain_ida without checking if that
>device actually belongs to the current IOMMU?

Yes, this needs to be checked. I will add this.
>
>On multi-IOMMU systems, this will cause every IOMMU's IDA to be
>cross-polluted with the domain IDs of devices attached to other IOMMUs.
>We must verify the device belongs to this specific IOMMU first, maybe:
>
>if (ser->domain_iommu_ser.iommu_phys != iommu->reg_phys)
>		return 0;
>
>> +	ida_alloc_range(&iommu->domain_ida, id, id, GFP_ATOMIC);
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
>> +}
>> +
>>  int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
>>  {
>>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>
>Thanks,
>Praan
>
>[1] https://elixir.bootlin.com/linux/v7.0-rc4/source/drivers/acpi/pci_root.c#L728

Thanks,
Sami
