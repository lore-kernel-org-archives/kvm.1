Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED4288B1;
	Mon, 27 Jul 2026 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142622; cv=none; b=Iycpgf7z7X83aEwwRbMTtXOsvin0+zzx+cwcHmbKLZ5OxeHN+xdVwWN3YFtxyYIXdLITkb7rlGDn8amg5eGfdYCM79BPy90B/kTI5uAKzalRabNWkaLwhvOgMR8Cy9BIgm+4/Tg2Vk29a8iLRf2AloLuBfoBwle/+UxsbE9ZhSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142622; c=relaxed/simple;
	bh=lMpIU/V66aytLPGUR/j5WZxaR63Djlk3lIVk2ujNTsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFeR+DTjmkzzHWRJS1TiGXyzymTdKqBJwAyYkvQ82ucbTkW7i+FYOtJgLD+dbkGF9XnHP14o0vvMMbI7z5nEmZ6jldVSOOj1rM1CsgX+lpXKSmccRBEHEgAuNVXJFBGOzzivVpOYYUUIvke2vgNdXdS57Bu8nozLB3kFHl3Eb78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vd/B5lE1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vd/B5lE1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785142621; x=1816678621;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lMpIU/V66aytLPGUR/j5WZxaR63Djlk3lIVk2ujNTsM=;
  b=Vd/B5lE1Ym4isKwuzUUv6ssKZJcX9Y3KxZ5lKTfgdwI+4BJPuGm24W4M
   PmVze8K8XoOBauA1nGnahZhP0llLQEkk8hFNsQ3dFj1GLCzVx3O9xa31F
   rTt5ej9Dzxoqe49+lXI5TlXdHjsD0QOBqRGJFPGsa9Kq1gn7YnvESrsmt
   hGR8Y1ndZTUMkeMmW1djv2T2Buv5tux+OT13lTD9ba9K9bzE++0iCDofg
   FIOS1cKByuH50ryJRBzPN/D95juaPkNY4PE9a3O6uu7gF/oW8Pcp6pdDA
   +xnhbpwg9ct+W623nxjVuWRbUmkLymx55+Uy8zu7mnrSByPGXaT8FqSdq
   A==;
X-CSE-ConnectionGUID: wnTTwDm3RNiAYr2sJbHwqA==
X-CSE-MsgGUID: EfcmmF7PRBWoEmOibJQuuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85650634"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85650634"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:56:46 -0700
X-CSE-ConnectionGUID: bCMhkf+yQb2QvXpI2EQz5Q==
X-CSE-MsgGUID: k0pmQHftQiuyGJF1mR6S1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="261321213"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.132]) ([10.238.208.132])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:56:43 -0700
Message-ID: <0a800681-40da-4d45-b0f0-ee8aa84ec942@intel.com>
Date: Mon, 27 Jul 2026 16:56:40 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] KVM: guest_memfd: Only "prepare" folios for
 private pages
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>,
 Michael Roth <michael.roth@amd.com>, Fuad Tabba <tabba@google.com>
References: <20260723210811.72720-1-seanjc@google.com>
 <20260723210811.72720-7-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260723210811.72720-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/2026 5:08 AM, Sean Christopherson wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> When getting a guest_memfd pfn, prepare the folio, i.e. convert its pages
> to private, if and only if the page is actually private.  The misnamed
> prepare() hook exists specifically to allow x86's SNP to assign pages to
> the owning VM in the RMP when mapping private memory into a guest.
> 
> Guarding the call will allow renaming the prepare() hook to better reflect
> its role, without creating a semantic mess, and will become a hard
> requirement once in-place conversion is supported, i.e. when CoCo VMs
> support SHARED guest_memfd pages.
> 
> For all intents, no functional change intended (the sole arch hook is a nop
> for SHARED memory).
> 
> Suggested-by: Michael Roth <michael.roth@amd.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> [sean: rewrite changelog to fit the context]
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

The rewritten the changelog read better and clearer!

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   virt/kvm/guest_memfd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index e9d61410e5fb..f64cd87ec8b0 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -814,7 +814,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>   		folio_mark_uptodate(folio);
>   	}
>   
> -	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +	if (kvm_gmem_is_private_mem(file_inode(file), index))
> +		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>   
>   	folio_unlock(folio);
>   

