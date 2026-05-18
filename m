Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49545380FFE
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779136369; cv=none; b=Dc2NBR9NiiZPb1W4GPkS/KxmE+aVXMUzftmBfiYGh4Thntoh8rLLW1OLDX46rkJFeBWHzF+l6bArn+H0LKWtibIOZJhyNthXZsFqYVIACufQkw594+17p3pMDmngztZgxK233FwxUdMmlZed8b+5kNpLCjz2hZKwILnUgrq08qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779136369; c=relaxed/simple;
	bh=ueB0hMp+FeQZ2rw6x9BVNLt7mojoUSebvdMXIaLRWYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epKhbll1VrgVMdSYZuoZCUmqtzmbcXWG+9RIdjJ9fb9JDw493kiVgnoUdfa49d6O2QdxlXXqD4SfKHQKD/y5fcJqaF2xu9NPXYk9iSpjLNAvJIrsq0FAFdjBg5p13wU4ehxRsNIeZG6E2VnYCm89q455ubsWd3t06UlRDSoQkCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VrhT63k5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrhT63k5"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba180a022dso175ad.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779136367; x=1779741167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNmFlCcVDbEeItJqA64fw5/4nyffyvxzQppQsiHP4dc=;
        b=VrhT63k5UIyhuFVcy/F9BQ9j29+SBh/bRxyVsiJkFSEbjimpMN1bUNU5nuu8dZkFg2
         H4+ZIBJEW9RlaAJ4lGhubIWoJahDhQQ96JLI06gixutGHqK63bUNYyrbw78xXgJW/Uhb
         DEk0VDhn+gc6R+3uDh78g7MIUTDB4akMWY9IJIKlySLzw3rn4VI5XNF/5sUoeIaF1gVL
         BnhqtHGd6ic3sDNzaG+DtYU3DXFvKXHy+PW75A1qkad5rNNOyCagYq2PlDmKyJAfTolg
         xNVTDwTqbYUG1nAWaiMJmuzn4ieEgjI7mDTqAV5+FXwNG4ezqlogLRPe4Re+8W3KCoaa
         2pqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779136367; x=1779741167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNmFlCcVDbEeItJqA64fw5/4nyffyvxzQppQsiHP4dc=;
        b=RdAbTxUnKZK2kvYzOsKJQxxqdUCoJ9fEVDR0U0lohmemS1gI3V4b6bGhQM80afrtik
         Dm6kLjnc6tgJa1zfVax8iYVmXdHhCWA9AMrIfyjpj35KPWbJSFtzfJ4rytWx+FyNuhvH
         5hMr4veGM3cj5d0iFyGGFq7jhUXt0UeKYBszoW2kPddoGzh7mRXBeNzRo5EVeMRvkNOT
         xwpmk/Yr/2HdTR+mo4sg5qoSktK8Qzl0cB1+RH6lwPLiuEnzPt6hS/wntMiUfPXnUseW
         clyo1Gw/RrhDaaPaJtyL3afW3bFN3rAB98FD5x8FsUYffh1nhxHDUAWO3OUizw1BwLGk
         gCxw==
X-Forwarded-Encrypted: i=1; AFNElJ8mUoCcFMvcVQVMZPLhqhBF9BTKVI7JFDt7s3rFITh5BPY9HXxqQ44NH1dOAZzpO511MXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YztwXdQfiQAyz8vRw22vNYOUrbudXtW7WCNg5xfEnKYQJuvGmxO
	dhvAqBe2H30V14g1w3OOu09w7pXVk/tYFKuHQKoGZLPDLxwEKUzDgLwqucUnR2XjNA==
X-Gm-Gg: Acq92OFpIK0k6EGNx9e99fznCop3xQiohK7LLOZL4x7rwiSntOkFRZgVahGG06ZHF3+
	KigYH86mq4OBDqvyn4Z6MRC+El2VgORVIT8fnQ0TwBD4TyFvt9gSYRxfUXHm9ddyzRfd4hHzdQZ
	M5bfxzBGkZdnfmBLf5tO7Ws4Oxyqr3BttaM5a3gVd/AqdIrQAjI0EgBlN8ZnBD4C97Ku7bQwsoh
	Sn9NwYWQMTnzGr3mRsbbxgg2UxA/Zikh7l2MXHBnfp32q40PQxBxHL2GFDGcTb8iYbkyy83Aq77
	GvkVjUxc8rG/mxQpCuJHbIiwmO/sAa0XzqZ5o9o2qHX0e5fhMtywEfKPv6vWufGLWXzQygtVvOQ
	jpYOdB95dyvZ8ScqsNRFwbpnrHDj1UJvqEtL33hMqxF3E7lcCg978frWzIWNkN+dOyOzDL3WP36
	EZIro5u0aryowFz5IBJzAQQMeLfG/TFRR2ITEziszWSV798oNgY96rFrNTSxoe/egKY8obKw==
X-Received: by 2002:a17:903:17c3:b0:2ba:4749:c9a2 with SMTP id d9443c01a7336-2bdb03a17e1mr3609045ad.2.1779136365901;
        Mon, 18 May 2026 13:32:45 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369514361b6sm11821958a91.12.2026.05.18.13.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:32:45 -0700 (PDT)
Date: Mon, 18 May 2026 20:32:42 +0000
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
Subject: Re: [PATCH v2 07/16] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <agtux6SrjpRYvMit@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-8-skhawaja@google.com>
 <a968550d-2cab-47fd-8639-a8747a8a7535@linux.intel.com>
 <af023TAT1m3oA9ez@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <af023TAT1m3oA9ez@google.com>

On Fri, May 08, 2026 at 02:36:56AM +0000, Samiullah Khawaja wrote:
>On Thu, May 07, 2026 at 02:25:14PM +0800, Baolu Lu wrote:
>>On 4/28/26 01:56, Samiullah Khawaja wrote:
>>>Add implementation of the device and iommu presevation in a separate
>>>file. Also set the device and iommu preserve/unpreserve ops in the
>>>struct iommu_ops.
>>>
>>>During normal shutdown the iommu translation is disabled. Since the root
>>>table is preserved during live update, it needs to be cleaned up and the
>>>context entries of the unpreserved devices need to be cleared.
>>
>>This is not related to preserve/unpreserve ops and could be made in a
>>separated patch?
>
>Agreed. I will move this stuff to a separate patch.
>>
>>>
>>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>>---
>>> MAINTAINERS                      |   1 +
>>> drivers/iommu/intel/Makefile     |   1 +
>>> drivers/iommu/intel/iommu.c      |  52 +++++++++++-
>>> drivers/iommu/intel/iommu.h      |  28 +++++++
>>> drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
>>> drivers/iommu/iommu.c            |  18 ++++
>>> include/linux/iommu-liveupdate.h |  10 +++
>>> include/linux/iommu.h            |  14 ++++
>>> include/linux/kho/abi/iommu.h    |  18 ++++
>>> 9 files changed, 277 insertions(+), 4 deletions(-)
>>> create mode 100644 drivers/iommu/intel/liveupdate.c
>>>

[snip]
>>
>>>+{
>>>+	struct context_entry *context;
>>>+	int ret;
>>>+	int i;
>>>+
>>>+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
>>>+		/*
>>>+		 * Alloc the context tables now to make sure the iommu unit is
>>>+		 * properly preserved. These might stay unused and wastes around
>>>+		 * 32MB max in scalable mode.
>>>+		 */
>>
>>Instead of allocating and preserving context tables for all root entries
>>(as noted, can waste up to 32MB), could we restrict this only to the
>>entries possibly in use by active PCI devices?
>
>I think the hotplug devices or VFs created through SR-IOV will be missed
>that way. Lets say device A is preserved and the associated iommu is
>also preserved. And then a new device B is hotplugged and preserved,
>then the context table for that will be missed.

Ok I thought about it a little more and basically we have following
things to consider when we preserve context tables,

- The devices can be hotplugged and preserved, so the context tables of
   those need to be preserved if we don't allocate all of them first time
   we preserve iommu, as done here.
- New context tables can be added (after hotplug) for unpreserved
   devices. And if we don't get another iommu preserve call after these
   are added, those remain unpreserved, so during shutdown those entries
   need to be removed from root table or preserved for simplicity.

To solve this we can,

1. Either preserve the new context table when it is added for a preserved
   iommu. This can be done in iommu_context_addr(). This is simpler and
   no tracking needed.

2. Or track the preserved context tables using a bitmap and then preserve
   them incremently whenever a device is preserved. On shutdown during
   cleanup, we can clear the entries for unpreserved context tables from
   root table.

I am inclined towards second option. WDYT?

I think we will have to do similar stuff for PASID also down the road to
preserve pasid_tables in PASID directory.
>
>Since we don't track the context_tables that are preserved, there is no
>way to incremently preserve the new-ones. Let me look into the behaviour
>of KHO, maybe we can make the preserve call idempotent and do these
>incrementally.
>>
>>>+		spin_lock(&iommu->lock);
>>>+		context = iommu_context_addr(iommu, i, 0, 1);
>>>+		spin_unlock(&iommu->lock);
>>>+		if (!context) {
>>>+			ret = -ENOMEM;
>>>+			goto error;
>>>+		}

[snip]
>>
>>Thanks,
>>baolu
>>
>
>Thanks,
>Sami

Sami
