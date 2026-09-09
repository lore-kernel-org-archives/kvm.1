Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE046D2A3
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788995406; cv=none; b=uxGtnpkNca4DRfgMm3FZTRORFNVwp1PPqrQPfODQPgImZNcR2obDd6TMN83B8lYzHWFM1Akkuh46kOHPjJ0gj/pXFGxrFhm5uXCZXVLTbst1+4E5nywzz948IiBx+c2pZBZPFGulftGr8P9e2fAyCRq65KCD9L2YbSIFOqOCNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788995406; c=relaxed/simple;
	bh=Dnqdq0KdBdyxtlGkgMFhZDK9zFUHuwkPUPX8VZQ7/AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgBnbVkMhLOBJHHiOTZ5nUsOxTYjhhjBk2v7s5MtGW3IpRNfyBCMa8K0M/nYPCRp/jNqjJBE1zb9bcjYCYJdFHFRyBIvjSrW8lvvto6vRBtTNYODhAP1QSUqiVSyDPj+sSZZTs2ikmIXjYpwmtg71oF8KO5a/MhEBXbqjS8xW7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ai7+jP49; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ai7+jP49"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-9103f5b813aso51495006d6.3
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788995404; x=1789600204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OyXsyrmwPWpvNEMluPgrbmkQBcP1ZphCbVgRL1lfY6U=;
        b=Ai7+jP49pnrXVZ9ubbln4mlm7gZZmSh85/NbrauvAzTWvU8w/ggGPkFilBB0jBOHb6
         PLANKX399COwmqYqdMsf/UW2x5l/kAQveEEQ6WOaEev9zTYDF7XIKginIjXGcxt9pGvX
         BdRZUpX3/WtOST8iGUosCVvMjzqbwulI3cqmH5G6nVMm4EVBQ/yrbAEHADZ9i2dvQ5Fu
         MHGKJp06r/+2eJzXT9RL6xBInuRouzXWOdPV8MSXZPrO41hs2Awv7ytQRV4mrh8d+xsl
         uHGlTuhx7wJW9sFwVam2ridtbXUBoOUpm6raVKONVXFQURoz26hYq4bem/76S0RWGi13
         E5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788995404; x=1789600204;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OyXsyrmwPWpvNEMluPgrbmkQBcP1ZphCbVgRL1lfY6U=;
        b=HMe0VZsfWXmhBamYUTLibjdEFnQBObci/Sqpc9B/LjEouVDb7uKOIQC22cIbaPHgLX
         BTI5qbOwB7MgttuA9hnCPOqaUgOQ4DAQQoCoQrspLrOH5UNnrgeiCJYJVn0DaGdknADD
         2LzyPcAOmvocTuqOnsLHWYp8W9QS4oMN+gkL/+ut9MkSUiLH80FwLl15t560a/RfR4Zk
         YRlmSVlXvNQm5XpNkB1fWMhh4bBLvRqndvD0fO08NJgTsZ+PPOpTntRfeeGDjeAME0FT
         p8l+s8voFkh4IQYMfbH8c9aOiysyfMwCDCjZxPxOfL1Ar9jSdgHHETmxpBxb4ov6aFZ/
         Sgpg==
X-Forwarded-Encrypted: i=1; AKwUvByT563ADIiNF9AOUVaWZTOjGE6id+2juyMHn/9wmndiZy55WP99uMde1IP9ypapMlSkBc8=@vger.kernel.org
X-Gm-Message-State: AFuF++nUojAFHaB4Y7BS+awCzrHwjiHTBeBJAhaONEUAiPhedQhz66qn
	0X4CquLzW2Go/4TGM9n79sc+a7rkFUZ5HGMOVPNJ+gWq5WOZgXkQS4VH8rKYto3bERs=
X-Gm-Gg: AYBFou0HTsWx6iow4bQbpV/4Ciax1gkTp1W3sM3IMd2oq9iibOt26y8KszDtWm60o3P
	6fuMPggYOaFbjbVQAouO+7AMBdFjg8jQ1aabhFvRP8bHpu146mcJv4cWPm1PLYoSd/tm9BqGbId
	KZl9Dp2XoBNepWilXZKOOZUyI1islumMYf0KuJu333Tez2hmzirmhd1wwEFotWk8grOuQ7Ac5QL
	XSg93gSif30j2X4Sv7BRkBKEB5XknIR9Lm+a2VX4JGWW8Y+Bprk520AYERueHhMLjbSqir+C164
	snZRYXME+FvPkYn+jBAqpvD6R6xbxh2WcuCcUmZi7KHEIj/yGrqPrZPdXjSdGHdA/RUtDX2dhUi
	wEIdjee5RFMPw9O6S4f0cFXgl6ORy/BGtZLCVAYxFr1l4HHb0HP2D/IT/57uXEGoe7Oxx5aCDRU
	4rJy0MGDZ3QjqFhw3QP+yofinxVo6Urs4w3Ao5EW52Yop9hVV3CMQjGG9J+bbp61LthKwNlSikl
	sQ6mFXjcRhwwfNJ4wALnp4Wh+Q09DPAFl1MSryBC/YDHhJ+i4Vh2xc=
X-Received: by 2002:a0c:f206:0:b0:910:6432:b201 with SMTP id 6a1803df08f44-9106432b31amr201020706d6.21.1788995403591;
        Wed, 09 Sep 2026 16:10:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406af144sm155519616d6.40.2026.09.09.16.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 16:10:02 -0700 (PDT)
Date: Wed, 9 Sep 2026 19:10:00 -0400
From: Gregory Price <gourry@gourry.net>
To: Ackerley Tng <ackerleytng@google.com>
Cc: linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	pbonzini@redhat.com, seanjc@google.com, akpm@linux-foundation.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH 0/5] KVM: guest_memfd: bind backing memory to a NUMA node
Message-ID: <aqHkVKvons1tBs1O@gourry-fedora-PF4VCD3F>
References: <20260902194657.79075-1-gourry@gourry.net>
 <CAEvNRgHWyBaBpZ4Bem1Eu86b-cuEA7NkyjxTJ4D3FnpGe1B2Yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvNRgHWyBaBpZ4Bem1Eu86b-cuEA7NkyjxTJ4D3FnpGe1B2Yg@mail.gmail.com>

On Wed, Sep 09, 2026 at 03:41:35PM -0700, Ackerley Tng wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> > guest_memfd allocates its folios through a per-inode shared mempolicy.
> >
> > Today that policy can only be set after the fact, with mbind() on a host
> > mmap of the fd. That requires the fd to be mappable, and it cannot reach
> > folios that are only ever guest-faulted. Neither holds for a
> > non-mappable (confidential) guest_memfd.
> >
> > Add GUEST_MEMFD_FLAG_BIND_NODE and a node field to struct
> > kvm_create_guest_memfd. When set, KVM builds an MPOL_BIND policy for the
> > requested node and installs it over the whole inode, so every folio is
> > allocated there with no userspace mbind().
> >
> 
> Instead of a custom API to ensure all guest_memfd allocations come from
> a single node, how about these options?
> 
> 1. Using cgroups/cpuset to constrain allocations (could be troublesome
>    if the guest memory is not preallocated, unless the vCPU threads are
>    running with the cpuset config)
>
> 2. Process-level NUMA policy
>

for 1 and 2:

the intent is to put the guest memory on the target node, not all system
memory for a given process.  so the scope here is not the same.

in fact at that granularity, the desired node may not even have eligible
memory to host the task's memory.

> 3. Why not request the guest_memfd to be mmap-able just to be able to
>    set a memory policy?
> 

the eventual intent is to enable this for fully confidential,
host-unmapped guest, isolated to a particular memory device.

Requiring a mapping to get node-placement is quite defeating the point.

> 4. How about something like fbind() that takes an fd and offset range
>    instead of mbind(), which has a prerequisite on mmap()?
> 

This was a consideration - although it has other limitations and larger
complexities associated with it.

Where does the policy live for random fd's? (inode? address_space?) 

How is a reclaimed inode's policy handled? (lost forever?)

figured i'd start by reducing the scope to the narrowest and clearest
use-case, but I did expect to have the fbind() conversation.

I'm open to it, but it seems like over-engineering.

If you look at tmpfs / shmem, you'll see there is the option for a
default filesystem-wide mempolicy that can be plumbed, but i'm not sure
there's a real usecase for per-file mempolicies that isn't literally
guest_memfd.

> This doesn't exist yet, but I'm hoping to discuss this at LPC 2026:
> 
> 5. What if you could pass an fd representing a mount to guest_memfd at
>    creation time, so to make all the allocations come from a single node
> 
>     Step 1: Create a tmpfs mount, specify mpol for mount to MPOL_BIND
>     Step 2: Get some fd representing the tmpfs mount, hand that to
>             guest_memfd at creation time
>     Step 3: guest_memfd allocations will always come from that tmpfs
>             mount, and abide by that tmpfs mount's memory policy.
> 

This i think this is more feasible than something like fbind, but devil
is in the details.

I definitely think it's interesting and would love to chat at LPC!

> May I know more about the use case behind this new feature?
> 

see above - confidential vm whose memory is quarantined to a particular
device, without placing that same burden on the host memory.

~Gregory
