Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C74DBD62
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694167; cv=none; b=kfR+JWN78mufuslYmLbEy4mw/VwyP+DWF7i5Jqe46+MKv+1kqaWjKkBO1d5T6utTcDziMcaT0wOVuQ2FkOknlbZQrYf/zerzgv1Ru+rCCZf+LOTn4MDxLT4yhIVSfAugrw6wGoefBflpKREjHUXWA97YFY2zM+Q8Ihoji69qjq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694167; c=relaxed/simple;
	bh=1WSS9Lw9aBcee4iz14cYiigHCP8r7yK0EA/3ERT0UOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1TzQt83EvQhPaBVT2c599uMOh4CFxNv7PTCg9rl73R/oyUm0ybFj7lpjWtGArAR1M+gUqs6DrYdYE1EDM23QoFS6Y6ieATDSfGQUTsLRF4o6rorwG34f6JC/sbqJwszqfOslUPc58zA1hBAcBFvConrrLEzUDdBHMUCauqdvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9+CaXfH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9+CaXfH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778694165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GFGDkWttOAoH/uihBYTyJk3WR1vveCD97OVBVVmA34s=;
	b=L9+CaXfHEO/JLetPZwfrpAWZ13l+SM/D4airBjNlTY9yEPKnq53FCQypx5+cU1/ijacfFt
	twJHMQJyOohnQA3B1406XvSmGKyoYB3XYVpjDe7jVeQvUivnWONiJ54um4fO/Ere+EuItE
	swyQ1zs0bbJvOspIEhntwfm6fw3+ge4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-5XLGpI3XO3ek90i1GPL6Iw-1; Wed,
 13 May 2026 13:42:39 -0400
X-MC-Unique: 5XLGpI3XO3ek90i1GPL6Iw-1
X-Mimecast-MFC-AGG-ID: 5XLGpI3XO3ek90i1GPL6Iw_1778694158
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 943511800610;
	Wed, 13 May 2026 17:42:37 +0000 (UTC)
Received: from [10.44.50.86] (unknown [10.44.50.86])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 197031953947;
	Wed, 13 May 2026 17:42:34 +0000 (UTC)
Message-ID: <afdca8eb-cfad-4f8b-b809-fdb107e43fce@redhat.com>
Date: Wed, 13 May 2026 19:42:33 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/21] x86/fpu: Ignore APX when copying from/to guest
 FPU
To: "Chang S. Bae" <chang.seok.bae@intel.com>, seanjc@google.com
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 chao.gao@intel.com, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
 <20260512011502.53072-7-chang.seok.bae@intel.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260512011502.53072-7-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 5/12/26 03:14, Chang S. Bae wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> KVM will store APX extended GPRs directly in the regs[] field of struct
> kvm_vcpu.  This is done to make accessors more uniform between GPRs and
> EGPRs, and partly because x86 maintainers expressed the desire to compile
> Linux with APX enabled sooner or later; accessing guest EGPRs from KVM's
> C code would get in the way.
> 
> Therefore, let KVM handle the APX feature on its own when executing
> ioctls to get and set the virtual machine's XSAVE state.
> 
> Cc: x86@kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [ chang: adjust function prototype ]
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>

Boris, Dave, can you please ACK these changes to core FPU code?

Thanks,

Paolo

> ---
> V3 -> V4: New patch
> ---
>   arch/x86/include/asm/fpu/api.h | 2 +-
>   arch/x86/kernel/fpu/core.c     | 9 +++++++--
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> index cd6f194a912b..0b218f5eaafd 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -160,7 +160,7 @@ static inline void fpu_sync_guest_vmexit_xfd_state(void) { }
>   
>   extern void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf,
>   					   unsigned int size, u64 xfeatures, u32 pkru);
> -extern int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf, u64 xcr0, u32 *vpkru);
> +extern int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, void *buf, u64 xcr0, u32 *vpkru);
>   
>   static inline void fpstate_set_confidential(struct fpu_guest *gfpu)
>   {
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 608983806fd7..ae5c73faed69 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -420,6 +420,8 @@ void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf,
>   	struct membuf mb = { .p = buf, .left = size };
>   
>   	if (cpu_feature_enabled(X86_FEATURE_XSAVE)) {
> +		/* Up to date APX registers are in struct kvm_vcpu anyway.  */
> +		xfeatures &= ~XFEATURE_MASK_APX;
>   		__copy_xstate_to_uabi_buf(mb, kstate, xfeatures, pkru,
>   					  XSTATE_COPY_XSAVE);
>   	} else {
> @@ -431,11 +433,11 @@ void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf,
>   }
>   EXPORT_SYMBOL_FOR_KVM(fpu_copy_guest_fpstate_to_uabi);
>   
> -int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
> +int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, void *buf,
>   				   u64 xcr0, u32 *vpkru)
>   {
>   	struct fpstate *kstate = gfpu->fpstate;
> -	const union fpregs_state *ustate = buf;
> +	union fpregs_state *ustate = buf;
>   
>   	if (!cpu_feature_enabled(X86_FEATURE_XSAVE)) {
>   		if (ustate->xsave.header.xfeatures & ~XFEATURE_MASK_FPSSE)
> @@ -464,6 +466,9 @@ int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
>   	if (!(ustate->xsave.header.xfeatures & XFEATURE_MASK_PKRU))
>   		vpkru = NULL;
>   
> +	/* APX registers are copied to and from struct kvm_vcpu, not the FPU.  */
> +	ustate->xsave.header.xfeatures &= ~XFEATURE_MASK_APX;
> +
>   	return copy_uabi_from_kernel_to_xstate(kstate, ustate, vpkru);
>   }
>   EXPORT_SYMBOL_FOR_KVM(fpu_copy_uabi_to_guest_fpstate);

