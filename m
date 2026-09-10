Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487F221FB6
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029595; cv=none; b=nsPLDzFVNgAkOyxc/GYRnyzbJgS5HDt3J/O1G9SKDkc/goz//5WVIPydtfH2KdN68nP9VThV6ssK4FLfRlOFkMH4MCQJcyEQFI5Iv89n2E7nfJV94wxYC4XYTZ4p7D6TMu9CXHnShujqSjKOdAU6TFBgcWkiI0yre1WdJghtIfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029595; c=relaxed/simple;
	bh=OJMndiOSNOHBIUhrpWEKl3hDM6w+4z85HfKtzYjClV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QeUyeHQmyLKFl8HO3PnHK3tCt+EgFHWSg5Vm1YCoay8DKibkwtpn+HHWMhMqmoZfvMhqix41v+xuLAzx+U2FP9aShbaYqAjV7Z3/Ot6+OcKay/qWnxEJdjUu01NVTPUzfvzDyXGeOcNq162WrMr5X9f1D9o5jen3Cd1lqfSaGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFBGJ04I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFBGJ04I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF94F1F000FF;
	Thu, 10 Sep 2026 08:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789029594;
	bh=8ZzvbcSxNRDsf3l7+pjIOoJyVM0AyIUAO0RULKJ/ouc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NFBGJ04I6z2tEmHNTB/l/FJRV3+pb3bM/kzsdFT0I700dyu8Nd9gd37cmsZp5nm4x
	 HX4VJzJmbXe107/lmeNDWw6Hp9KrY1dMrKRuRSQnNviFrCQek10GNVS0UzznIRy283
	 tJPR1c5yyazek5DU6S8bOGS6kfUI0P1lOLy1SJ2YfJtmiCT6RT4YI44Ymn7Mt2DkFw
	 JtbhjK4f75+rPH0jOe1nXxpdTiHm10AAzV8IqH0+W6ysvFbYwcmUcl96CFIfnMt4P/
	 j37CS+8MixCsCgCiWDjozc+aQaASp2/0C7iGMGffyegibx5fYqFmyLTjfraVDPBKc+
	 gmzelTWBTpL1g==
Message-ID: <391885b2-6464-4656-9cda-8d05891849a8@kernel.org>
Date: Thu, 10 Sep 2026 10:39:48 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/19] system/memory: Re-use memory-backend-guest-memfd
 inode for private memory
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, berrange@redhat.com,
 armbru@redhat.com, pankaj.gupta@amd.com, isaku.yamahata@intel.com,
 xiaoyao.li@intel.com, chao.p.peng@linux.intel.com, ashish.kalra@amd.com,
 ackerleytng@google.com, lpieralisi@kernel.org
References: <20260908205236.838281-1-michael.roth@amd.com>
 <20260908205236.838281-9-michael.roth@amd.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20260908205236.838281-9-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 22:48, Michael Roth wrote:
> When convert-in-place=true, the guest_memfd instance created by
> memory-backend-memfd (when guest-memfd=on option is specified) should
> also be used internally for private memory.
> 
> Do this by dup()'ing the guest_memfd FD provided by the backend so the
> separate cleanup paths for shared vs. private FDs can be managed in the
> same way they are currently for convert-in-place=false (where shared
> memory must come from something other than guest_memfd).
> 
> Introduce a new RAM_GUEST_MEMFD_SHARED flag that can be used to
> limit this dup()'ing to specific backend types like
> memory-backend-memfd.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  backends/hostmem-memfd.c |  1 +
>  include/system/memory.h  |  3 +++
>  system/physmem.c         | 48 +++++++++++++++++++++++++++++++++++++---
>  3 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 6576331441..a9759e682b 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -89,6 +89,7 @@ have_fd:
>      backend->aligned = true;
>      ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> +    ram_flags |= RAM_GUEST_MEMFD_SHARED;
>      ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
>      return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
>                                            backend->size, ram_flags, fd, 0, errp);
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 027ca81bd2..81616bfe39 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -274,6 +274,9 @@ typedef struct IOMMUTLBEvent {
>   */
>  #define RAM_PRIVATE (1 << 13)
>  
> +/* RAM can be shared that has kvm guest memfd backend */
> +#define RAM_GUEST_MEMFD_SHARED   (1 << 14)

Trying to understand the semantics, should that be SHAREABLE ?

-- 
Cheers,

David

