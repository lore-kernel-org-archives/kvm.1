Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9F25F7B9
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195830; cv=none; b=mrhHy8lMTBfSPCGsFqCT3IXJWJIv0HoqUuCbIcyNgt9dhe1HpAsGMevQiel49rpAApWYzhRFDFwj2B1TlP66afPrH+v7bG9Gzis+A9eF4IlZvCx235no43QkadMYCiMj1nN+Ix1/rMwtnz3KHie1TqHOCV536Q4y/B6P9fYCkyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195830; c=relaxed/simple;
	bh=6P4geeJ+KoHlt2CMz/h9pWT+6lXDfH/Gf7m5FqNdcJo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=Ledd5O6lCJTLiOfruepBFwJ3XQu99g3s7R1FybN2tQYvlm+8bNK6cg7heA6ahGqvsMRr1wQm4neDtL/b0QZUJ/KC9QLxu3xgTnoJdxWnE735YIziKLYOa1W86s+TA1k0M/dKp+DrEI0AWJI/buNlJ262udnhml8T0VHhe2yo/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcV+Vj/G; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcV+Vj/G"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-359f239ffa6so710501a91.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 19:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773195828; x=1773800628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMltWOW0k43bLww3FIPfAmLCchQbUS14K7m8AEoPvKs=;
        b=CcV+Vj/GaKKM64BsdkphW1/HStzloWp/JwGIB9i7baRc9FvCezDHUQhoL0gHbhA8Tk
         BIzSxoJLjoOC2xh0QXo2YHfI36ETPWQdo5yscF7H3CkMFHpfXsMg7qWsmD764kYnHdQn
         hvqNmsp58wkk7l7SPsBJQ5JBzRUXj9sgP1BlylfRxzNLxgR0x4YR3i7wXaR4Ab3TYzbK
         6kjuD2vPeflK0G0tqBS6v+GehlrCTc58UzRZ8L2KcF0LVufcKDxj7vlPkZEdnrJ3dV2z
         9ulf7fZj1NJP7MOcfgzDN1DS/rU4AIGZUdJvgWntiWJZQONiR6CMb7YcOQBUG38J9wj3
         EwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773195828; x=1773800628;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MMltWOW0k43bLww3FIPfAmLCchQbUS14K7m8AEoPvKs=;
        b=Rzk6njen1Zo+d/UcAnCKqWociOYmZtlSoLp/DOjqSbyGm8oiIOHB8teF6ahAN9c1E8
         MrpFpXhwSx7VVwi30KlJkmEgpk2HGmM9GugQneqI9gw5BidgbqC0cfW2ClVLgtz8uY1f
         FIK66Nc6azmdY2i/yqG2sYH8TvFbzyCbkFwcQ5m4uHenkMIvgtlD8v+M28UL0Xr6XmJm
         pZpxjWt4LcYtGvn9kbsgD+0+BKvqaffsMUF2vftqoCCNf0Nvxoz8HgtzCziUpDKVPuP5
         /EIvr2kqR8CEn3IV8tPMdQY4JcIPc66qlsq4Ya0jrYae93I1yGnbBb0J8zje9R5tFUtg
         hVfg==
X-Forwarded-Encrypted: i=1; AJvYcCXC7M9dQNUTM9Lyty/47mSslFxIsCxZvIXGHaFQ5Qjt9/iODvLJesTkdn84EdTKJTyO2n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU9L7cTXSSHBggwf2zQVHYGdExBlWWwROVOkvIbZv8b3u+Jxd5
	pyZXnsT8/O22mVXtKI0wj6zBukBgaQiyGs58sPzQzBHfS5OGoo2UoDrY
X-Gm-Gg: ATEYQzzougt/R2gOzLVw6d0gbV37oDHgHTylvg9P66DFxlL5OFKTxqbJs+ZTEdz6M6V
	f1SspHemSZTUNbOTxU4r3zoiy+WMDKiLjTmuGQTN9IRdZVlwV01fj2FVzNKZstHGb8mha/iAKVx
	utwGQAg318isfOXhpXpZnT04Z3Jhrk04Ll2hasJ7nj119vM3gX5tt3A9+HWvoAEkBsCwaSaeAp5
	pVfzVqUMfUK8BuNO19Wv2Ye2VNAy8W6CPR+l0w7ujEPqE79Dyq7Fb5ipeIZUef6xq/piMSmGpss
	j9/agWBHkK5UYrubRoed20hOgm/9yUOusdIGt/uDlWyPRof4t0QttccveJDY8VeoiMCFveRju+l
	QyIquD7L1WXqQlPpeb1Pw9h6kPeTTNw9VUPJvNUMvzKkXmeo0ZJz3PUQNf3m5TO5VinylyoHkVx
	I0bCtdZBEW+bbgI47/rkpIxQ==
X-Received: by 2002:a17:90a:c884:b0:354:c593:b1a8 with SMTP id 98e67ed59e1d1-35a0124b91cmr932718a91.13.1773195828309;
        Tue, 10 Mar 2026 19:23:48 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359fc97356dsm1413731a91.8.2026.03.10.19.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 19:23:47 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Alex Williamson <alex@shazbot.org>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>, linux-mm@kvack.org, kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>, alex@shazbot.org
Subject: Re: [PATCH v2 1/2] drivers/vfio_pci_core: Change PXD_ORDER check from switch case to if/else block
In-Reply-To: <20260309154637.3abf76af@shazbot.org>
Date: Wed, 11 Mar 2026 07:50:24 +0530
Message-ID: <1phrumxj.ritesh.list@gmail.com>
References: <b155e19993ee1f5584c72050192eb468b31c5029.1773058761.git.ritesh.list@gmail.com> <20260309154637.3abf76af@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Alex Williamson <alex@shazbot.org> writes:

> Subject prefix should be "vfio/pci:".
>
> On Mon,  9 Mar 2026 18:08:37 +0530
> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> wrote:
>
>> Architectures like PowerPC uses runtime defined values for
>
> s/uses/use/
>

@maddy can we wrap this in while applying?
Otherwise - please let me know and I can re-send another version.

>> PMD_ORDER/PUD_ORDER. This is because it can use either RADIX or HASH MMU
>> at runtime using kernel cmdline. So the pXd_index_size is not known at
>> compile time. Without this fix, when we add huge pfn support on powerpc
>> in the next patch, vfio_pci_core driver compilation can fail with the
>> following errors.
>> 
>>   CC [M]  drivers/vfio/vfio_main.o
>>   CC [M]  drivers/vfio/group.o
>>   CC [M]  drivers/vfio/container.o
>>   CC [M]  drivers/vfio/virqfd.o
>>   CC [M]  drivers/vfio/vfio_iommu_spapr_tce.o
>>   CC [M]  drivers/vfio/pci/vfio_pci_core.o
>>   CC [M]  drivers/vfio/pci/vfio_pci_intrs.o
>>   CC [M]  drivers/vfio/pci/vfio_pci_rdwr.o
>>   CC [M]  drivers/vfio/pci/vfio_pci_config.o
>>   CC [M]  drivers/vfio/pci/vfio_pci.o
>>   AR      kernel/built-in.a
>> ../drivers/vfio/pci/vfio_pci_core.c: In function ‘vfio_pci_vmf_insert_pfn’:
>> ../drivers/vfio/pci/vfio_pci_core.c:1678:9: error: case label does not reduce to an integer constant
>>  1678 |         case PMD_ORDER:
>>       |         ^~~~
>> ../drivers/vfio/pci/vfio_pci_core.c:1682:9: error: case label does not reduce to an integer constant
>>  1682 |         case PUD_ORDER:
>>       |         ^~~~
>> make[6]: *** [../scripts/Makefile.build:289: drivers/vfio/pci/vfio_pci_core.o] Error 1
>> make[6]: *** Waiting for unfinished jobs....
>> make[5]: *** [../scripts/Makefile.build:546: drivers/vfio/pci] Error 2
>> make[5]: *** Waiting for unfinished jobs....
>> make[4]: *** [../scripts/Makefile.build:546: drivers/vfio] Error 2
>> make[3]: *** [../scripts/Makefile.build:546: drivers] Error 2
>> 
>> Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>> v1 -> v2:
>> 1. addressed review comments from Christophe [1]
>> [1]: https://lore.kernel.org/linuxppc-dev/0b8fce7a61561640634317a5e287cdb4794715fd.1772170860.git.ritesh.list@gmail.com/
>> 
>>  drivers/vfio/pci/vfio_pci_core.c | 19 +++++++------------
>>  1 file changed, 7 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index d43745fe4c84..0967307235b8 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1670,21 +1670,16 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
>>  	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
>>  		return VM_FAULT_SIGBUS;
>> 
>> -	switch (order) {
>> -	case 0:
>> +	if (!order)
>>  		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
>> -#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
>> -	case PMD_ORDER:
>> +
>> +	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP) && order == PMD_ORDER)
>>  		return vmf_insert_pfn_pmd(vmf, pfn, false);
>> -#endif
>> -#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
>> -	case PUD_ORDER:
>> +
>> +	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP) && order == PUD_ORDER)
>>  		return vmf_insert_pfn_pud(vmf, pfn, false);
>> -		break;
>> -#endif
>> -	default:
>> -		return VM_FAULT_FALLBACK;
>> -	}
>> +
>> +	return VM_FAULT_FALLBACK;
>>  }
>>  EXPORT_SYMBOL_GPL(vfio_pci_vmf_insert_pfn);
>
> Otherwise LGTM.  This appears to be no change for current use cases, so
> I assume this will go in through ppc trees.
>

I think that will make sense to take these 2 patches via the same tree,
so that we don't see any build issues on powerpc when the next patch
enables huge pfnmap support.

> Reviewed-by: Alex Williamson <alex@shazbot.org>

Thanks!
