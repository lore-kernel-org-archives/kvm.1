Received: from isrv.corpit.ru (isrv.corpit.ru [212.248.84.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C794F4D07
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.248.84.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852747; cv=none; b=XkppTygrVIIyl4v8rwA11i9LRMGPk2zSNRrmWB/kk901XZCt3Opi5J343nol05kLoYLSFfRaKr71u3J+n/ayA/G2AI2OQvZ7FKwykV8w4b3AzHdiggd9TAGeNtFzctNBDSr8rp7KJc2jDiu402+cSvsBQr4oNQoPQMGPhrdxrkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852747; c=relaxed/simple;
	bh=mv9nVaZL/XcJQGB+PLdb9m3rmNyVm0E+71o0SrI2qAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnTMwP09gCAF7Tk58kgeCzoCoC66UIntlMrDw3N8pAfcByNDo4dhgdEjXp0Y0uLFWGuierQU6a2tjxti/RPUX/R/dfU3MHdg5gQyc3PLrfyQ9BuFZqE4p6/l4nMRKqcd6m3qv/7taRHazDVz/yuL8setdoNYVCeztX+hR/b3KE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru; spf=pass smtp.mailfrom=tls.msk.ru; dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.b=ZLDHs0ln; arc=none smtp.client-ip=212.248.84.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.b="ZLDHs0ln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
	t=1790852740; bh=mv9nVaZL/XcJQGB+PLdb9m3rmNyVm0E+71o0SrI2qAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZLDHs0lnjXHM92bx0JV/Kg7/cdziqhSJR2xqxdddFcp3GgoWCcIM1G5R6aanlMHMe
	 8UaM2DVSoH601J/PFiJ+yStZz4arjE+FRH6t81IFfdoOcifp4LHFoA/EgVg3aDEnL6
	 24V8zK//sQgM2P0kEH2wAix8pzm4/0umV2QvA9CjknbdWre65sIID+DXzm1dj5lqcL
	 3MixcM3NK/uJziH3wy/G41zvX0vvAReTk1q6A2N038oxoBDMpmy0Zyrl2QpTv8TV+Z
	 fuEANJw1/9/3HZJLOUbq5NXIsilwj4NlMjnIXPJEiulVgIIxMX/NxD/6t0n99MHvB5
	 BLlbn1surKMEA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id F3BD11DA243;
	Thu, 01 Oct 2026 14:05:40 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
	by tsrv.corpit.ru (Postfix) with ESMTP id 631F4438200;
	Thu, 01 Oct 2026 14:05:40 +0300 (MSK)
Message-ID: <f4a13c82-927b-465c-8ae9-9e7bb0f2e7b1@tls.msk.ru>
Date: Thu, 1 Oct 2026 14:05:40 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu"
 is configured
To: Sandipan Das <sandipan.das@amd.com>,
 Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 babu.moger@amd.com, likexu@tencent.com, like.xu.linux@gmail.com,
 groug@kaod.org, khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
References: <20251230074354.88958-1-dongli.zhang@oracle.com>
 <20251230074354.88958-2-dongli.zhang@oracle.com>
 <81a1f791-37ef-4d26-bcf7-024eab4cd810@tls.msk.ru>
 <fa8b40df-a35c-4ae3-8eaa-b4b65c546a91@amd.com>
 <18ff5158-a515-4659-8388-5bcc074afb94@tls.msk.ru>
 <6ee6f858-37f6-4acb-8253-acd3cec584ad@amd.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <6ee6f858-37f6-4acb-8253-acd3cec584ad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/26 13:43, Sandipan Das wrote:
> On 01-10-2026 15:30, Michael Tokarev wrote:
>> On 10/1/26 11:54, Sandipan Das wrote:
>>> On 01-10-2026 14:02, Michael Tokarev wrote:
>> ...
>>
>>>> When booting windows11 VM with -cpu EPYC-Rome-v4 -enable-kvm, the
>>>> guest enters tight CPU loop while displaying a boot screen, before
>>>> it starts showing up the rotating circle (which shows boot progress).
>>
>>
>>> What happens if you use "-cpu EPYC-Rome-v4,+pmu"?
>>
>> With that, it boots fine, just like before this patch.
>> I checked current master too - same, +pmu fixes it.
>>
> A guest OS cannot expect a functioning PMU if the hypervisor has disabled
> it. Linux runs a basic sanity test to determine this. See:
> https://github.com/torvalds/linux/blob/master/arch/x86/events/core.c#L268

So.. what do we do with all this?  :)

I kinda see the intention of the original change, but it results in
non-bootable systems (linux too, as I think you demonstrate above).

hmm.. :)

Thanks,

/mjt
