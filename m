Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098656;
	b=XWVeH/YoZZw9KWdEEuw1jH5Bznx3WYGlkYhCE1kbr86+Wb61J8dfsKNilcFyFbjA5GnS
	 mgL73iMwa1o7JjMoiqWHSMTuRUkWy/2BQlkc5v2qM4r6/qO+jm5AHV/GHAR2FSTB4LqNn
	 Yvdm9dcyCj5Y1/KDe8qLZRf1bSvPSjGwNREKRp4YBF8CWbGuf6iEh7datD3bkyzofMop/
	 p714YCtlZsA94T5H4V80LUedAgwXqOmwyIFxjDTe3WJ0nOfcN4o0ZeSSS9vSC9vZsvzQl
	 Hrp3pGnRVk3HhYvOGmMh6ilHPYNTCLCB3MIy6hu1w/rBDCOD8k8bfQBE+QybBruehDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098656;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mZgkdudxpriV0masBemQGPzPIFdk1tXutO3Xb2jyEGk=;
	b=P5myLWecDpXNEei9UNCAUDFbyvHWM1PpkOYdna/7c17HTPe5CAE8qm6Mex94UAo5ah6d
	 SKvxK7sGZMCOCdDKZ8VuhvTkSP67R9M2rlqAi5/A/euC/jQFYZXQh6jvyN+nH22MeZsvQ
	 g/xbEVx7LTEPxMLd0xq/AI8/K1rCWSvik6rATyGh3MqhqDV5Psfy5K0GnLIx7UsF27XCe
	 fbijwZQ5Yn0dYnRTxtIrXjpyRnI5ONmTpIQ+/TswUd4AXMrhTHKrd9kiH6oQNxW2H4Ytu
	 y2gFps5zNe5HTsAKjVx/5RIk208lIT9weDXS6dEooQ4j0kOuT1kldMeA+bPbVphLHgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5jVzzqE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A67606D815
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5jVzzqE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F387B1F0089F;
	Sun,  8 Nov 2026 00:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098655;
	bh=mZgkdudxpriV0masBemQGPzPIFdk1tXutO3Xb2jyEGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q5jVzzqEwNnLB8CsKc0Gg/4VV0/zPTEwf3456HsVDiiLbKlWUDC3Ok29Q/qUqevcr
	 PrXfSRHzX/OMvHwRWF/M3KeHlnShE2LQ2nAoS3sbhVwdOryPlEPCGawvgWOZeJz35O
	 O8l4zxyjaD9RtiSRBMEF+QxgZXbT6wwYvwtQ8JLiorZ1ZwmO5J982vwAfimaHzMutH
	 qmEiIPhmKfexz/XwfnC2CdZ8VXRnSL2W29p/M8c9UKTIkQoG8k2nATqdFMGRC0ceJ1
	 d8GHmvw+KhgpVtBv3UBfnW98/+MGuoKDv1D3vDiAVfAhjzsQwnd1SXYWvjo/1zHoR4
	 PJcKnoHgHmOcw==
Message-ID: <sashiko-outbox-203462@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 51/88] KVM: guest_memfd: Support reporting PFN
 cacheability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alexey Kardashevskiy" <aik@amd.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jianxiong
 Gao" <jxgao@google.com>, "John Starks" <John.Starks@microsoft.com>, "Michael
 Roth" <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Sean Christopherson" <seanjc@google.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Fuad
 Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261106-gmem-alternative-providers-v3-51-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-51-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:14 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] KVM: guest_memfd: gmem_insert_pfn() ignores PFN cacheability
  attributes
--

commit f25760b5d4313e6d13e16717d7b61b6d2b33bbac
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Support reporting PFN cacheability

This commit adds cacheability attributes to guest_memfd PFN attributes and
handles them in stage-2 page fault, nested VNCR, SEV-SNP, and guest_memfd
population paths.

> diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
> index fb2279a001ebf..8cdc334d1c9aa 100644
> --- a/include/linux/guest_memfd.h
> +++ b/include/linux/guest_memfd.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_GUEST_MEMFD_H
>  #define _LINUX_GUEST_MEMFD_H
> =20
> +#include <linux/bits.h>
>  #include <linux/types.h>
> =20
>  struct file;
> @@ -9,7 +10,33 @@ struct folio;
>  struct inode;
>  struct mempolicy;
> =20
> -#define GUEST_MEMFD_PFN_ATTRS_READONLY	(1ULL << 0)
> +#define GUEST_MEMFD_PFN_ATTRS_READONLY		(1ULL << 0)
> +
> +/*
> + * Cacheability attributes for physical frames returned by providers
> + * (columns show x86 / arm64 memory types):
> + *
> + * Attribute                               | Host PTE       | Stage-2 PTE
> + * ----------------------------------------+----------------+-----------=
----
> + * GUEST_MEMFD_PFN_ATTRS_CACHE_WB          | WB / Normal    | WB / Normal
> + * GUEST_MEMFD_PFN_ATTRS_CACHE_UC          | UC / Device    | UC / Device
> + * GUEST_MEMFD_PFN_ATTRS_CACHE_UC_ALLOW_WC | UC / Device    | UC / Norma=
l-NC
> + * GUEST_MEMFD_PFN_ATTRS_CACHE_WC          | WC / Normal-NC | UC / Norma=
l-NC
> + *
> + * GUEST_MEMFD_PFN_ATTRS_CACHE_WB is 0 so normal cacheable memory is the
> + * default when no cacheability bits are set.
> + */
> +#define GUEST_MEMFD_PFN_ATTRS_CACHE_MASK	GENMASK_ULL(2, 1)
> +#define GUEST_MEMFD_PFN_ATTRS_CACHE_WB		(0ULL << 1)
> +#define GUEST_MEMFD_PFN_ATTRS_CACHE_UC		(1ULL << 1)
> +#define GUEST_MEMFD_PFN_ATTRS_CACHE_UC_ALLOW_WC	(2ULL << 1)
> +#define GUEST_MEMFD_PFN_ATTRS_CACHE_WC		(3ULL << 1)

[Severity: High]
Should gmem_insert_pfn() apply GUEST_MEMFD_PFN_ATTRS_CACHE_MASK to the page
protection passed to vmf_insert_pfn_prot()?

When userspace faults on an mmap()ed PFN-mode guest_memfd,
kvm_gmem_fault_user_mapping() passes pfn_attrs to gmem_insert_pfn(), which
only checks GUEST_MEMFD_PFN_ATTRS_READONLY:

virt/kvm/guest_memfd.c:gmem_insert_pfn() {
	...
	if (pfn_attrs & GUEST_MEMFD_PFN_ATTRS_READONLY)
		flags &=3D ~VM_WRITE;

	if ((vmf->flags & FAULT_FLAG_WRITE) && !(flags & VM_WRITE))
		return VM_FAULT_SIGBUS;

	return vmf_insert_pfn_prot(vma, vmf->address, pfn,
				   vm_get_page_prot(flags));
}

Because vm_get_page_prot(flags) returns normal write-back page protections
(and also overwrites any custom vma->vm_page_prot set during mmap), host
userspace PTEs for GUEST_MEMFD_PFN_ATTRS_CACHE_UC,
GUEST_MEMFD_PFN_ATTRS_CACHE_UC_ALLOW_WC, and GUEST_MEMFD_PFN_ATTRS_CACHE_WC
frames are installed as cacheable on arm64 (and on x86 whenever PAT does not
override the protection).  This creates mismatched attributes between host
stage-1 and guest stage-2 mappings and allows speculative cache fills or
write-combining on strict uncached MMIO regions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D51
