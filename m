Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16B39280A
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787738593; cv=none; b=LYzm5cRQ00TIdGQ2iFGCNh8y89sCMMelAMYRox5kmvtNn9WOINAOnJYHVXVTqBhQR6sk5gvV9/NwlbvtFTmgPvKSUEi9llhHhQJ66hn+/V+latjmkIm4ujeK9G4qmvJSATXwJfwuC6KlFxHI+laS6KBYr/2zT3cuojf6OddMLpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787738593; c=relaxed/simple;
	bh=AlfYlEb6WKoIrIEWU9ApASMS98YxtvLdbBvocivgdhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5jsUNyMDIWbnBigjQzAjtZcSY3BzhqUql2tVV4xcxdDe2VjPQ6VxlGxIQi0Jksx3s42rgB1XZNyxfly2vIlfV/tQNop8YSt9jsTsZan7Zbbm7FIt4e+pHrIxW8J8CG4YogT5mmvWrcSxpphqOrtty4YajHKOatdCG7t267ukSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UUYQSYG/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UUYQSYG/"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a41191c9a9so858591a12.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 03:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787738590; x=1788343390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bE7U1SVs1nWjk547BlCoF5e3zoAI9ns9idl/rgWUbu4=;
        b=UUYQSYG/zIb4PqWcw6+yhT0jQQMwiy3ncrxxwUYrphZBYwrgrTC/kLy2CA6JFwDmie
         UCoGZRLX0/vBXPMenpwHKfv80tl9voGL4wlEXN0MM/l823bkU709bnXZUYf9alQG0rpL
         sfrCl+pHoOyFc94SXcOkiQIMky9hXNsg2YwSjWxqykdS3lENf2IRI7slfaI1NF2naIBj
         8hJdx/6DxcCertCRZBBtUp7WP50wvq9JDM5pKz3NnPtgT5tWZKIUHRF0CTNulwHKyJ+J
         EAes7F/VoQpCKtAPA3SJ9h141VZy8rnqfBOXmeYXrdCqzZRI9IKy4lXK2XttVu6aeTjT
         6aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787738590; x=1788343390;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bE7U1SVs1nWjk547BlCoF5e3zoAI9ns9idl/rgWUbu4=;
        b=iPL+o47lLNM35oAAja/V/B7ps4gHuJSBNYdRFCR/bAPOu9ZINH/vLxSlyeZrJ6C7s4
         2qPjkHMsnB5I0GHPGKtoVgwlKKpi67RkYmmfQb2dAdCq0iKJYZ93Q5mDgQ2diyEennAJ
         78fg+nHR3M3N+LKAheX7NSwrnAzwUKzRXlwqoQ6QF+gjbu0ZUiyRF/5rCVK816xuFnlX
         9I5/IKgYTiaLdV/CXDi84UGTp9r+ULhKG/pyjFMSmRRtomKAksWWJf/sMgaRgg9Bw350
         L3AgWoxDizXJeIxvRFHfWosfwuhknS+Ys8+M38Br5VaFxoMFJTU9fn9pilYNcholYSSE
         j3zg==
X-Forwarded-Encrypted: i=1; AHgh+RoFgmmAxB7Bk/+HjZFeY+r3aHVW4+a9AEva6xtKv2RglLuAxukABRji8yJKFgOjGl4jreY=@vger.kernel.org
X-Gm-Message-State: AFuF++mFrgRZJq728aJObSs3nVLyaWh8Qp2o6IlpSX72LnjoxChaxsnQ
	BygEBIA8JbIXeE+0t4t7C5XoSwBTjo13r/QH/alxoOM53QRtMODuU12dPpEO858XL3o=
X-Gm-Gg: AR+sD13gUo3AfTlJPZrWXPN3+7um/wjP8SVyKJng+5zJtFKKwdat0JPcz+7TMX5O6U1
	eqHMUs1vijLDxduVJ5RjY4KszJ/atFh82ZY2HqQGLIIYKETY2IPJAqolmXdMAepLjh/msZECahq
	LBi1oZLpJaSK60UgqdYGe/ZMfwdTqdjFD9u8iOMpe2TxO0jhyr00KOebVyzCIGisw+JcXPE41Z+
	QEn+XDo50QsLWvAPAhS3tKi32zzmDuja5fIbCSAowg6dq0zf48+7i+VmCuggyaZXrp6CXv8xokF
	9iYu0/NVWhgw4B3ObSl7aAn0kOiBpMAU4COD353EJlgJJk8Bv5B4XEOQy682ZN2tp3LaWbw4Xu2
	Jx7MMlo3d9b8mSHnD3oKiiYgJM2vxa59NrNpMBc+lzmq9BZzsLko+Y7cu8r3vnjpF25trizxIhd
	sweoHcviueS8kcwzUmnCal34/5o4Torpr2yfLIPcTlZb1lqvpT3OM/keSU/l9uCZQ=
X-Received: by 2002:a05:6402:5288:b0:6a1:f95b:8ced with SMTP id 4fb4d7f45d1cf-6a5df5fd41dmr8268122a12.4.1787738589521;
        Wed, 26 Aug 2026 03:03:09 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.207.128])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de5f7bb8sm3723194a12.0.2026.08.26.03.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 03:03:07 -0700 (PDT)
Message-ID: <5426d2f6-3e67-45d3-85d6-d0da67edb486@suse.com>
Date: Wed, 26 Aug 2026 13:03:01 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] KVM: VMX: Consolidate the exit handler for VMX and
 TDX
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
 <20260819094903.3060020-10-xiaoyao.li@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260819094903.3060020-10-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/19/26 12:49, Xiaoyao Li wrote:
> The exit handlers for VMX and TDX have the similar pattern. Consolidate
> them into a single vt_handle_exit() helper.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Changes in v4:
> - new patch.
> ---
>   arch/x86/kvm/vmx/main.c | 38 ++++++++++++++++++++++++++++----------
>   arch/x86/kvm/vmx/tdx.c  | 18 +-----------------
>   arch/x86/kvm/vmx/vmx.c  | 21 +--------------------
>   3 files changed, 30 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index 6a813c49ca8a..10df9667d0c0 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -154,15 +154,6 @@ static fastpath_t vt_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
>   	return vmx_vcpu_run(vcpu, run_flags);
>   }
>   
> -static int vt_handle_exit(struct kvm_vcpu *vcpu,
> -			  enum exit_fastpath_completion fastpath)
> -{
> -	if (is_td_vcpu(vcpu))
> -		return tdx_handle_exit(vcpu, fastpath);
> -
> -	return vmx_handle_exit(vcpu, fastpath);
> -}
> -
>   static bool vt_unhandleable_emulation_required(struct kvm_vcpu *vcpu)
>   {
>   	if (is_td_vcpu(vcpu)) {
> @@ -887,6 +878,33 @@ int vt_handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
>   	return 1;
>   }
>   
> +static int vt_handle_exit(struct kvm_vcpu *vcpu,
> +			  enum exit_fastpath_completion fastpath)
> +{
> +	int ret;
> +
> +#ifdef CONFIG_KVM_INTEL_TDX
> +	if (is_td_vcpu(vcpu))
> +		ret = tdx_handle_exit(vcpu, fastpath);
> +	else
> +#endif
> +		ret = vmx_handle_exit(vcpu, fastpath);
> +
> +	/*
> +	 * Exit to user space when bus lock detected to inform that there is
> +	 * a bus lock in guest.
> +	 */
> +	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
> +		if (ret > 0) {
> +			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
> +			ret = 0;
> +		}
> +
> +		vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
> +	}
> +	return ret;
> +}
> +
>   #define VMX_REQUIRED_APICV_INHIBITS				\
>   	(BIT(APICV_INHIBIT_REASON_DISABLED) |			\
>   	 BIT(APICV_INHIBIT_REASON_ABSENT) |			\
> @@ -960,7 +978,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
>   
>   	.vcpu_needs_initialization = vt_op_tdx_only(vcpu_needs_initialization),
>   	.vcpu_run = vt_op(vcpu_run),
> -	.handle_exit = vt_op(handle_exit),
> +	.handle_exit = vt_handle_exit,

nit: Why isn't this vt_op() for the sake of consistency and introduce 
needless churn ?

<snip>
