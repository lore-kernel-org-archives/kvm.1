Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682694B8DC7
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525134; cv=none; b=GAKopp8Q0Wi8sc4sU5wcXWufMCjIyiJLBRfMahkIGfuiNwqjhTJkkHIIaFLTgJwl5vt5keN/11YF7M5omddzany3adsFNim41eqidCASdsa00cCrnR8pc9tGxAgqMdCgMv182l9KwUao4Kus3a4S1TuIzh/1yZQJZ1pkhZ8fXBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525134; c=relaxed/simple;
	bh=EfTIbAWmLDFDyvNFwjeqvGW6T6qTRBjvePBREiQPCEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7lq28CHuzO/XzEvzXCMwrRAHl+7O9dwULDW/Ee9YjKr0W46azm7DC6lDRd627hdfh7F8XhHiC+sqgrtmTZWPBxh4igAapHZml1fuPiE33+PPjNsnZzG596CI4U6PBurrgJ2kk/xA2f8beu7eB1qRdQ8vKNv6H7CNGHUKCsZeCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHhxcRQA; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHhxcRQA"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-132cccd3d77so1096c88.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 11:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778525131; x=1779129931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P4ZVeg+YkmtR9q/2zoKbQ9G/S4IeJPqOrtHp4fCMixU=;
        b=rHhxcRQAwU1H5iv0XPlL0r5zvNpLhlL+HQ6Ky21p+eirtU8ObwDPgu6RIifuzftslh
         mYNrvNjvRrMN8BGOUYVUypUxFSKQTCfR9IP74AXSouKo9Ikmdsxg0bXLs+BJIYWZA4jC
         gDffYLps9k47LlnLx/q8oGJsqlCdi9U/ftNkWDnw0Xit+AFbjLrRX+ro4CHjY2ITatYa
         Vhq4sDICYtrZO407UEgOHPCmrngQ1D4td8cm3EKY7aZ6fVcoVzTmqwBzia18KKnWho04
         96CIbD54uNqqutgbbDOLxIaRpvT7mOqpeekkcMCFfE4MJuSi/6AXl+j8E8+jhhq1l+/p
         nCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525131; x=1779129931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4ZVeg+YkmtR9q/2zoKbQ9G/S4IeJPqOrtHp4fCMixU=;
        b=A1Qgna5do5dHHlu89B7ZejoRf+EXU5zPAvGEFeTqy0xhZKEW2UujBsVikUhXaMxeN5
         nBZ7LlIMTfkH6Xk/U1G/Ht0s1lpwWakMSHKqAwkz6I0d1ruRggucv1Y4o1xzAb5zFQSG
         LPpfwcrnASyy3g3UmvMm52TSKbk5NXAePBHKpi4C+GD8eTGcPelYA+7X7P1cwW793p/C
         vwWSDAhurZKBmGELdxRdW8WAz+hGHOnoKqjdCqhSnOO8GukJeQU06V38IRPlHvueHdIi
         /mPIvCFRz5hI5Fj/TQTm7YUuUfuMvkXBiRjdDa6ejQYO2y58KCPNSlaRq+2r1BuYkKWh
         aDZg==
X-Forwarded-Encrypted: i=1; AFNElJ9ozmILUWolzstOG4BGMrz+KXj1PShTpZmiECnfaHcl7uzKO4yxsrdoI3PkADrPzQWVh+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMJZrz3Klp3Dumqe3NSiJ7B4m8s04gmF7v4cG2beekQepP28Sn
	PgB4jcC63ho+c1bA30tPh5YM33vfOjRWSgkKDrBrGvVWBqYo0rAyRX2HXelj+EelDA==
X-Gm-Gg: Acq92OEbegK0IN0Ej4opW4fM7JXNlZiISIDZzt/3/vqZDSI6NaLzH3hPkSuvkhm2hRN
	xYOeh95b8lX8385Q+oT/VvycOt84hM1o6lLqYEfhLCr7EWwrunfHcBB2YYOJ+/FlJVLChlZxsV/
	2xcoSfpsKLtVNxK8Z/4zn7MDfCcsd+SD1kszlPuDxxLBDcgUk407fNerRXqf1TpVEXVXOCqmy1c
	Pxikh2tjiGfVOGWQzFYFD697D4SFzwp15e2qNdqhvzRYkDxf56HBVTeXS8BV4E76RfXdD1WDz0v
	Xygb6TwZZ6XlZGmoodnuTaLpQeIxrVt3KLST1ssDDD1K4cxhx3GUiRUN5Jn7aAJThRpVC/PTkOb
	vU/crzQhl2+l9KcLVDHczyK1AnSEBqpEAH+/iER428sSFG261Tpe7i68oHO6LC4pwcShJiepSfy
	W+kbp97vOCScAXcZF4TIfsK7nTj39p2akv9YmMkpRC878o9ZbYqd/X3AQGACcRpCcC2KDqXw==
X-Received: by 2002:a05:7022:b9c:b0:12a:77e6:68d9 with SMTP id a92af1059eb24-1333e4e41dcmr55502c88.16.1778525130642;
        Mon, 11 May 2026 11:45:30 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f91004b6a2sm13056216eec.0.2026.05.11.11.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:45:30 -0700 (PDT)
Date: Mon, 11 May 2026 18:45:26 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 11/16] iommu/vt-d: preserve PASID table of preserved
 device
Message-ID: <agIGEyL12Djj2clV@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-12-skhawaja@google.com>
 <666d749e-c1fd-44e1-bfe8-681ba04862e0@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <666d749e-c1fd-44e1-bfe8-681ba04862e0@linux.intel.com>

On Fri, May 08, 2026 at 02:05:58PM +0800, Baolu Lu wrote:
>On 4/28/26 01:56, Samiullah Khawaja wrote:
>>In scalable mode the PASID table is used to fetch the io page tables.
>>Preserve and restore the PASID table of the preserved devices.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |   5 +-
>>  drivers/iommu/intel/iommu.h      |  12 +++
>>  drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++++
>>  drivers/iommu/intel/pasid.c      |   7 +-
>>  drivers/iommu/intel/pasid.h      |   9 ++
>>  include/linux/kho/abi/iommu.h    |  13 +++
>>  6 files changed, 184 insertions(+), 3 deletions(-)
>>

[snip]
>>+
>>+void pasid_cleanup_preserved_table(struct device *dev)
>>+{
>>+	struct pasid_table *pasid_table;
>>+	struct pasid_dir_entry *dir;
>>+	struct pasid_entry *table;
>>+	size_t dir_size;
>>+
>>+	pasid_table = intel_pasid_get_table(dev);
>>+	if (!pasid_table)
>>+		return;
>>+
>>+	dir = pasid_table->table;
>>+	table = get_pasid_table_from_pde(&dir[0]);
>>+	if (!table)
>>+		return;
>>+
>>+	/* Clear everything except the first entry in table. */
>>+	memset(&table[1], 0, SZ_4K - sizeof(*table));
>>+
>>+	/* Use the folio order to calculate the size of Pasid Directory */
>>+	dir_size = (1 << (folio_order(virt_to_folio(dir)) + PAGE_SHIFT));
>>+
>>+	/* Clear everything except the first entry in directory */
>>+	memset(&dir[1], 0, dir_size - sizeof(struct pasid_dir_entry));
>>+
>>+	clflush_cache_range(&table[0], SZ_4K);
>>+	clflush_cache_range(&dir[0], dir_size);
>>+}
>
>The PASID table is currently active and in use by the hardware. Clearing
>the entries without the necessary hardware cache invalidation is buggy.
>
>It seems this manual clearing is a workaround because PASID domain
>preservation isn't supported yet. If so, rather than clearing the table
>blindly, the code should verify if any PASIDs (other than
>IOMMU_NO_PASID) are actually in use. If there are, the preserve callback
>should return an error.

Thanks for looking into this, I agree and will remove the clearing logic
here.

Yes, we do this check in iommufd, as it is the dma owner of the device,
and only DMA owned devices are allowed to be preserved.

During preservation iommufd returns an error if the device has PASID
(non NO_PASID) attachments. And once the device is preserved, any PASID
attachments are not allowed until the device is unpreserved.

I think I will make this check robust by moving it into core and use
pasid_array. It will require some plumbing as pasid_array exists in
iommu.c file.
>
>Or anything I overlooked here?
>
>Thanks,
>baolu

Thanks,
Sami
