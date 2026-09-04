Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F0314B66
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482199; cv=none; b=XFpNdI8i5ocxKKJ/qThlAys/UfhRyKbenPOe1ZG5Pr+TWB0ITT5TbEP1rhWA5UHvC560UNyL9lqFBmwqZtcLFioFbUi0oib7s9yvs89bwJDANnBGoGFzsbx/XLq1G6XOO4qDSfMa8aDjNFKjfNpxm+/y0BaJN9B7NNFShWgflGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482199; c=relaxed/simple;
	bh=x5LDPsdvbXimywbzcLmSFkCU3DoJpJnex4rJgmAGAVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMfR1xzpJB/Kiax93pFONBgyevWwo74HZIWf9w5p/7r87UWZr9RdQocibBoprGOKswBrB4ptOPnEFb1GHoLQQ/AS3+Y9kHoX/29PK3GWSvSB8mSFnsLc8lSuvz/pcBHkFVpFMkUYCQW2BNwfyj7GZWJPuOY2QWS7xm6udx3BTRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFsPLkBr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=minhbbCV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFsPLkBr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="minhbbCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788482196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f6GMexSWWuoc9Cddr8yMae7nQERhafauV/Q+TnV8uPo=;
	b=iFsPLkBrwlBMmVjm70fuchG9i8HkofT1eOMrqxQ/EjuNU7Xp5BvW9UwPsqgULIcXvRa3Sp
	tPwQ6VyukSwYMdbhq+TdcvcU6f/7VH2zp4LxPz3HvbdId3T8ZlTwJj9dLCEy5iAWRmHuqs
	fcIGd3D2vFiYX0BMIIaUmivO/q0MX8o=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-zbjStwmbOjy__plgZAmqug-1; Thu, 03 Sep 2026 20:36:33 -0400
X-MC-Unique: zbjStwmbOjy__plgZAmqug-1
X-Mimecast-MFC-AGG-ID: zbjStwmbOjy__plgZAmqug_1788482192
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dbf293831so926423a91.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788482192; x=1789086992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f6GMexSWWuoc9Cddr8yMae7nQERhafauV/Q+TnV8uPo=;
        b=minhbbCV//wngwdOvnvxuFdIDunlp9r0pYUroTUIARqXMSpPEn5IGg/G0zUUfepah6
         /NzyVu7Pa7/FbrVbbAQeuwQ45Q41oDyXRH5UdQXYe3WQL36etmr8aFBdNt5EubXtJj6P
         maqyLQIBCs4/6TTiKVXNvWVTuxvZM1cQ/50EQO9FO2DggZCDwWyEqAqSj7bvz7EOtF3L
         UrUMwG3BPLou4mBFxHYHn8B17U0R38lL6/ZDKJnmQM2SQkHnZd+VqmsCfg3gZxteUwtO
         obbitc6nwnp9nT1DkYlsP2p4/XvBUN4bLd2NlcPVydUSabtlOhuaSGBHHymGGOy2HCRm
         VJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788482192; x=1789086992;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f6GMexSWWuoc9Cddr8yMae7nQERhafauV/Q+TnV8uPo=;
        b=DxegC06qRJuaJ5szWipyrhsktFkZapCX7VgSH0zEXf60JXAigjA5zpn0Bj2Qz+bN8j
         j9kO5DLi9Q4ZH8X9SLq9itKbjsTu2X+Np2SV1wpRKpNK7A4VAYqWzkT8mt4kwdmda4nr
         2bVSE2H20jjpmP3uuDdlGrUh/fk0qW2W/Uf24ND5ssldu+FvHR78mWA4iIg+B8CzFoNX
         h9+NC1XnTW6QieLCB9XFLsnlUlPBHHbb1guOQNOVEZZ8T/atAo4w02HSa5BWxR9Mqpv3
         3nWmIIHfomPWtgAQ6YErFT4oOQAbH7TSBvV6LmkrCg0oI+5YmSqWFB8/Xl2MstfjHIwu
         /nFA==
X-Gm-Message-State: AFuF++lZObm8veW5UJYMcxNkDGhA4wmX/e39JbC0sZ+LSuZ6n+E6d/ub
	GB/ulKSKh29VXhggN28b6KRFpBhVdPe9w/U5S2A5PeyHjDK5vkUVKoEkA6MGa+1jZzFNnoj3oHm
	6neNm43zRfgmfxH9NBHlcNrTYywn51Vw4s+uR8GISE1qQGfSzLsvspg==
X-Gm-Gg: AYBFou1Xn8AttMkclgGQ14yLPkwqKGYMcKO7pT9ZaoCbanwM3TsSsCNeh673E1VnkYf
	bxuwEZ/xpdoK38UusYQlNCp8e3VrbTN5DbeoMpn9kHYr/yYaWbgsad3biY7xetbBg0uBElQ7g7U
	cHW3oD+gYJqdLPeO33wDst1E98tqUCJBO1MaufbnrXt0E43rRfewpbDRGjJCoiQWWdsMGDQp3Sz
	vIZmZ5F3nnmLgXlHiNN0RVGbC4u7GjHyOWwzUB2dtUXEtWBPC9Nd5TshhS79lNICDqRbTidCb1m
	L30FHXULvxdif8W7G7Dl585v28lZDfdDNDaP8XCxLr7f2CYaJ+D3CHaxvC+/J+H97OPBsd1P68i
	v7IYNotq6VUpnnb2te5G50udQDwMoF4WLZeiBXB62Sg==
X-Received: by 2002:a17:90a:c106:b0:398:e1f4:bda1 with SMTP id 98e67ed59e1d1-39b2624cf3fmr3925683a91.21.1788482192428;
        Thu, 03 Sep 2026 17:36:32 -0700 (PDT)
X-Received: by 2002:a17:90a:c106:b0:398:e1f4:bda1 with SMTP id 98e67ed59e1d1-39b2624cf3fmr3925599a91.21.1788482191942;
        Thu, 03 Sep 2026 17:36:31 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b8f44d7sm2233190eec.22.2026.09.03.17.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 17:36:30 -0700 (PDT)
Message-ID: <a7fb4f62-bc2c-49f9-848f-9f64235f95a1@redhat.com>
Date: Fri, 4 Sep 2026 10:36:19 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] KVM: guest_memfd: Stop returning struct page from
 PFN lookup
To: Ackerley Tng <ackerleytng@google.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, David Hildenbrand <david@kernel.org>,
 Yan Zhao <yan.y.zhao@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
References: <20260826-gmem-no-return-page-v4-0-3bb9c1ddb4e3@google.com>
 <20260826-gmem-no-return-page-v4-5-3bb9c1ddb4e3@google.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260826-gmem-no-return-page-v4-5-3bb9c1ddb4e3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/26 7:01 PM, Ackerley Tng wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> KVM currently expects guest_memfd PFN lookups to return a refcounted struct
> page, which callers hold across fault handling.
> 
> Drop the page's refcount before returning from kvm_gmem_get_pfn() to
> prepare for the in-place conversions series.
> 
> CoCo shared-to-private conversion handling must inspect folio refcounts to
> ensure exclusive ownership by guest_memfd. A concurrent guest page fault
> taking a temporary reference on the folio causes conversions to fail due to
> an elevated refcount.
> 
> While this refcount is also taken on host userspace page faults, that
> refcount is taken on behalf of the host userspace page tables. This
> refcount will be dropped when conversions unmaps the page. Either way, once
> there's an mmap() or userspace mapping, the pages are open to way more
> refcounts, transient or not. This patch focuses on just dropping refcounts
> before handing KVM a page.
> 
> guest_memfd already notifies KVM of page invalidations, so callers within
> KVM only need to respect the MMU invalidation protocol to safely rely on
> guest_memfd for page presence.
> 
> Since the page refcounts are dropped, don't return the struct page pointer.
> 
> Not returning the struct page from the guest_memfd PFN lookup moves KVM
> closer toward supporting memory backends that are not backed by struct
> page.
> 
> Here are some notes on the cleanup in the callers of kvm_gmem_get_pfn():
> 
> kvm_release_faultin_page() in ARM's gmem_abort() originally also serves to
> set the page dirty and accessed under some conditions. The dirty and
> accessed flags don't matter for guest_memfd anyway, so it is safe to just
> drop the call to kvm_release_faultin_page().
> 
> For ARM's kvm_translate_vncr(), the local page pointer must be initialized
> to NULL so that the shared cleanup path that releases faulted-in pages
> safely no-ops for guest_memfd.
> 
> For x86, no additional changes are required in the MMU fault path because
> the page fault tracking structure is zero-initialized at the start of page
> fault handling, ensuring the refcounted page pointer is already NULL.
> 
> Reported-by: Yan Zhao <yan.y.zhao@intel.com>
> Closes: https://lore.kernel.org/all/anZ4W9o5pTWIEgMY@yzhao56-desk.sh.intel.com/
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Michael Roth <michael.roth@amd.com>
> Tested-by: Michael Roth <michael.roth@amd.com>
> Tested-by: Yan Zhao <yan.y.zhao@intel.com>
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>   arch/arm64/kvm/mmu.c     | 4 +---
>   arch/arm64/kvm/nested.c  | 4 ++--
>   arch/x86/kvm/mmu/mmu.c   | 2 +-
>   arch/x86/kvm/svm/sev.c   | 8 ++------
>   include/linux/kvm_host.h | 6 ++----
>   virt/kvm/guest_memfd.c   | 9 ++-------
>   6 files changed, 10 insertions(+), 23 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


