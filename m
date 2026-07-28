Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033D3D5C32
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231937; cv=none; b=U7ukrPhF4P0SAGcPS8V/w8ik0a5adOAP5IMAAMK91iDXB8AcOOrtlaNqQiFsaopDzBUw+U7HH2prwl0r3r8Bv3WYJgIPQAtuOuvk+sW/5pfmpTxpBchHieQmwQQMG/qurIhd0gnepHTAPTfIrpA3tffKs/lAoOEUZqVl+7UzRjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231937; c=relaxed/simple;
	bh=4ncCwLHbd0y5QmKrVWBk/lqxfcoLzBZt8Gojr8StP2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAwF7fQGHLmFp5xBWOSZiLFH/oHJN1fd4PBi32kE7BHHK48731figglNP7WjTRxmgcjVJDF3KZajKzajb/08mq4P/LPCby9POs5imBMfhpa/KYtR+1hBEPVkX5snimqtMo/JW4svQdBpbiO5JfDLZQ2WVdyrdD5AGZKJzY0bxmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tRETev7R; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRETev7R"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so6685a12.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785231934; x=1785836734; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f86kYd5ZgAbyf9BSKP0yMuigLiXeU1iriKpHpan/dmc=;
        b=tRETev7RIZceXoOhDMfJBomc3UTS4IHmqYWIdOJETeaS+sixg0MTPeYCX7noRCN8Zn
         q64KXnSAj3Vv4s48UHT5vkoUcT9SX6uvxWxqcJsUEl/986g/ucx2mDNOZejU5wgmKUvv
         mY6NknbfotGdI8j5ozGcy86hahyuoROzPvxQWqtb4V/zDur0Sy1U4G0QYk9n+VXXV3dF
         aybkQmUr2UKZiQxbb7hL8mGBe8Xbz642dbUdkOjaKCdlvtdOQmBCg7HlelaCkvsboPhy
         RQ/kFn2Q8BMWPAAIkR0FkxXwOhrD73ReISc7A6G/02plN5pwchsHe5p9oT0xcMhBqEgv
         674g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785231934; x=1785836734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f86kYd5ZgAbyf9BSKP0yMuigLiXeU1iriKpHpan/dmc=;
        b=tCIFXX6SKK0m/UimpesbaovORjj9riZxdWV3jR4qiItdjqtn5BllCX9/mH6wqYx1KW
         ZOZu65zdDKHOCFs4bC2e0hNH95CSXsH2sbyPIupuXz9NwsHb+Yroj5bbqz/8+nFmmFwX
         l9WXjhxUGpSB1FOu+X93kSxLETjOeZyr5ddDdi2r3rniARyp2RsD95FT4YNmP6vgmkqY
         H3LfJ1eJr9l0AX0WDVhRJqRzUI7gfDuxYc5DoQS04RyjMnxlDrsoP/tZUIkv6z1byu1Y
         qkRJDpmGn0Je/SCD+dQi+LBCiGOK0/XmjzgFb8c0FD9vGv5fp7XshX6VkJrMaukTXee2
         6Yqg==
X-Gm-Message-State: AOJu0YzUTjKgPFW5LEbJ8HDiSkR9Zt2Jg9IGK4Qw2kGucn5drYT1XAyF
	mRY32CViZvZnebNFJb06m3+aw98/l7Pxy2t5yYmDMx/Dg8Z2Oj/lmy7cy6aSe12ExQ==
X-Gm-Gg: AR+sD11yW9V53XIs/ZKLwhwrTTg1bd6c+zyLvskZbqpszxYeQgQ9Jo0hX2v3YFWg1jo
	hbWxhyOTbOF+qarfQDCJS/0/8fmlBMlyOBG07tOnZk1cakbA13iRZAI0qXEkExIzovLgOaiv/ma
	Hux52ebwtVwTG+MFmqwJljNorkOSFeusSEXRi1PPJoj6wRnOcV/GvXM0SGJNFmJA0FSLZ271NCs
	nb/dtv36kOBFkn8a74GPgESIBsjVhZ9yBOTR/A3ICMQWU0R//VzvLA43/5/Ar/aRNVk3jsLXC6o
	/hLzmeOFtNW7JQfXJezx6FoLmcf5nRVs72jUAC1L3JrEi+icQ/c/MEZdSQKjXBkYZQPCnVTegy9
	lThNjsBr+B8WuFCYIbLhRHADEr8aNdB7nnOckjbLuCPBIOg+ZYflXkfrnNe1LbGiEoaQl4n/H4S
	eoekvynG+lkca6OeyuXpfvUwb/zKxmzOpmZ4HZp4SsGEw=
X-Received: by 2002:a05:6402:a153:b0:69f:d4ca:3c8c with SMTP id 4fb4d7f45d1cf-69fd4ca41d5mr127144a12.6.1785231933541;
        Tue, 28 Jul 2026 02:45:33 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac7eacsm746420066b.17.2026.07.28.02.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 02:45:32 -0700 (PDT)
Date: Tue, 28 Jul 2026 09:45:28 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jing Zhang <jingzhangos@google.com>
Cc: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [RFC] KVM: Proposed uAPI for querying GSI and irqbypass status
Message-ID: <amh6OLH38hsO7ZWj@google.com>
References: <20260717162658.2833515-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717162658.2833515-1-jingzhangos@google.com>

Hi Jing,

On Fri, Jul 17, 2026 at 09:26:57AM -0700, Jing Zhang wrote:
> This RFC proposes a new KVM uAPI to allow a VMM to programmatically
> query the status of a GSI, with a particular focus on determining
> the success or failure of Irqbypass.
> 
> 
> 1. Motivation
> 
> The primary motivation for this uAPI is to bridge the operational gap
> between the VMM and KVM at the kernel level regarding interrupt
> virtualization status:
> 
> * KVM (Kernel) holds the precise, live runtime status of each GSI (such
>   as whether Irqbypass is active, pending, or has encountered a setup
>   error). However, it completely lacks the high-level semantic details
>   of those GSIs—it does not understand which logical function or
>   physical hardware device they represent.
> 
> * The VMM (Userspace) possesses the complete context of the guest's
>   interrupt topology. It knows exactly which GSI belongs to which
>   passthrough or emulated device because it orchestrated the setup.
>   Yet, the VMM has no stable, programmatic way to query the actual
>   runtime execution status of these GSIs once passed to the kernel.
> 
> Currently, diagnosing when a high-performance interrupt path falls
> back to software mediation is highly problematic:
> 
> * While some architectures (like ARM64) expose virtual ITS states via
>   debugfs, this implementation is highly architecture-specific and
>   fragile.
> 
> * debugfs is not a stable API, is prone to breaking changes across
>   kernel versions, and is entirely unsuitable for programmatic
>   production monitoring and fleet-wide observability.
> 
> This is not an ARM-specific problem; it is a general, cross-architecture
> limitation within KVM's Irqbypass and interrupt routing subsystem.
> By introducing an architecture-neutral uAPI, we allow the VMM to
> marry its topological knowledge with KVM's live execution state.
> 

I am trying to understand the benefit of introducing an new uAPI for
this. I have been using irqbypass with arm64, and I would debug
performance problems solely based on /proc/interrutps.

On the host side you see a vector per interrupt and a new vector per
vcpu for the doorbell interrupt in case the vcpu was not scheduled.

Based on that I can tell if irqbypass was active or not, and in case
I have /proc/interrupts from the guest, I can get a percentage of
the fallback software path per-VM.

A uAPI will not give much extra info, see my comment below.

[...]

> 
> 
> /* To be included in <linux/kvm.h> */
> 
> /*
>  * KVM_GET_GSI_STATE: Get the status of a specific GSI.
>  *
>  * The user passes a pointer to struct kvm_gsi_state. The kernel fills in
>  * the status flags, performance counters, and the architecture-specific
>  * union members directly.
>  */
> 
> /* Generic flags indicating high-level status */
> 
> /*
>  * The GSI's route is theoretically compatible with hardware bypass
>  * on this host (e.g. is an MSI route and GICv4/VT-d is present).
>  */
> #define KVM_GSI_STATE_FLAG_BYPASSABLE      (1 << 0)
> 
> /* An IRQFD is currently active and bound to this GSI */
> #define KVM_GSI_STATE_FLAG_HAS_IRQFD       (1 << 1)
> 
> /* The irqbypass path is fully enabled and active in hardware */
> #define KVM_GSI_STATE_FLAG_BYPASS_ACTIVE   (1 << 2)
> 
> /* Example architecture-specific failure reasons for ARM64 */
> #define KVM_ARM_GSI_FAILURE_REASON_NONE             0
> #define KVM_ARM_GSI_FAILURE_REASON_NO_ITS           1 /* No ITS/GICv4 support */
> #define KVM_ARM_GSI_FAILURE_REASON_NO_MSI_ADDR      2 /* MSI address unset */
> #define KVM_ARM_GSI_FAILURE_REASON_GIC_HW_REJECT    3 /* GIC rejected map */
> #define KVM_ARM_GSI_FAILURE_REASON_INVALID_STATE    4 /* Guest state block */
> 
> struct kvm_gsi_state {
>     __u32 gsi;              /* IN: The GSI to query */
>     __u32 flags;            /* OUT: High-level status flags */
>     __u64 counter_success;  /* OUT: Generic counter for successful bypass */

I do not think that is possible on arm64, the host does not know
about the interrupts directly injected to the guest, so it can not
maitain such a counter.

Thanks,
Mostafa

