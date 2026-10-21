Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.219.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792586212;
	b=q8dVsDMRqHrzumQdZLS6jcE62/oQHAICCR+QcNqofmtXL4ZqMacevhMNhVEsgYTJPfkI
	 3tf6wUS1Kr1rdJZxUujmNyq694HoKkzAL9b5SWdpiZDVrm0cO0qFYIr0szp93jnEjdzb7
	 MLZroCszy9lNoCaN2NwYfRlXWiJGENZxxABG0zM9PKcYUFgxS7jcAxrO58axskBM8AVTE
	 0cZt5SwTs6FUOxzg2qaVzMFcGCjhF9DpaLJQBbIaqx/X00bN85Ezuy4Vd0FhwfMC7RXdO
	 DOj2o+wfTEk/vvEHvoZVvSyAFfJwRZQ0amb/QUkHB+ojEOIn5njoGWwHqkH8JRBqq/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=vp+dVFBwYXmRjQyumKZLewi3+rD7rnAjQOTAkzTLD1s=;
	b=kyTytfto+DFgHHYQNEDpJrHCDBPxZsdoQSnoSlvwvYorzNsGTjFEAMKVBmkcS9Gl6JPi
	 Fclp0ohvZk5kNUVcw/ZGlcGGCkcAzv1qyiuD5WZ+ffLOoNHYzmd4NuVv9rj3disSdn9iC
	 5wY/O/fBfrDvxqvJGLs+3jRvsV7rF5xQH+QpXYYQaf/wGiUtICM+jzMS2uEgadisPdXoS
	 +HW7MNX0Y6yvWbBWeuSieHpq/Ztnoo86+SO/vcAiupal6zvN/UFYLi9UQMhnKh1f0JvZd
	 aOOnPBWav3Vb8CcIVAw8or9OY/6JU9yENGVw8z7RTc/Oz8ZtJgkSmTY9xO8KoG+gw1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VfIFDj1U;
	arc=fail smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D99606A329
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 12:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D99606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VfIFDj1U
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ba702cceaso8373046d6.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 05:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792586211; cv=none;
        d=google.com; s=arc-20260327;
        b=XYSn+gznAtA/NkY6YVf7DaPMvaRODniwJY0RAq6i3JSXyfp3MO4y+D8W/dHPSy0WfS
         ByuwzXJLO2egtFMAnpuJtFTFPXJA22vfNtDjYbotdlktP5mNsjBFgG+iPAhVXXrbLO2I
         d6bgxA6zWsk7IedAjDWow5Magw0SNLdM/odDSgocGDfkovzNUA7DIOhW3ssrOaNkN9VC
         dE3r9Pi+x8pvPAEI2/wQA/zQj8h/VT7MxMll0ZUiRdQQDRVi98qp9oX8ftKl5iClQxgS
         2s/X4cHOLP53ZspbGTe8JTC1HuzaFRA8Uw/8GhGCIXk/qDS6tDy9OeKGwH4gDSMkYxQl
         c3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=vp+dVFBwYXmRjQyumKZLewi3+rD7rnAjQOTAkzTLD1s=;
        fh=ej9v04vvTRqS35A7Z96NzqvaDcUPj9CYPTZ9LxWly/w=;
        b=oPtvLZ1a2TOzIf7bPfIuiVy5ofXW3JyoDcu6PYcCFnU0rpuAiumIkdzcBqVGfBBSmY
         qYBXdEgVAMwKIpwv/cCpP3Rk4Wz0FinmaUQc/674pCH+Pu1zTVUMrzjJWzIGVVTjTUOp
         AplywlXZV3eEOkfufR5H3Ir/c3mjnxaZcuDn8djUskQTYGxnb3EQjoh1isIlUmPaGitg
         cpFFDogXLeYiPfRO3o7DrM+ZTneCeifdgqsZseDD/gyg0ZQgkyebVBiWSIA5kv3rabrm
         ftPEyEwCvqmxWPZUKMBPSZLCgMoATv9ygU1b/Or4MfoQHMDCy3BAK63WQUVGlZ/tIzy8
         LFoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792586211; x=1793191011; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vp+dVFBwYXmRjQyumKZLewi3+rD7rnAjQOTAkzTLD1s=;
        b=VfIFDj1U1wx7mgWjIhtPYJRlL+/Ei885Ww1NZCDi+DxR1li7ARReqjbVU9kcM0ZY8D
         T+BA5Mvf+GG39KNVUP3PG+7IY/2kh4N3DjOLdujIE2tdp+Kpl0XINjVn0JjfXvhX3kGQ
         ChSfRHSkPJqFvDzqAEuXEsnCFojfdH+2a0lqPTZMAhnF/lt+owm3lV3lFQHMbm9CkGnU
         fiutRbPKq/3g6NbSwv/vb9TiYG1eHsJOU274cfkYX2vqqp5M7F+LmHSLTHPz1bapSyHx
         gHdSmZ2ztnE+O991Orcln1ukNv/1ZlXyOUBeAQW+TA0Lc0P/yY7c5Psm4kCBojTtEEg3
         szFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792586211; x=1793191011;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vp+dVFBwYXmRjQyumKZLewi3+rD7rnAjQOTAkzTLD1s=;
        b=hUn/dvfZEvpmR1AHbms1yVqmix8Vsw/FDe5eKJvWWPMGAYOzlL8Ij+QUzEm8sIUHqV
         3OXFXeD/G/xZvtPe3m3bdLy+UAFTOsyjnametiOdvgpdLlGJ6Vo6jiHPoonVWPDnQtLH
         rqPojHB7Xsmfw7D/8+b8KSZ47tynJw30f0zmAE6p/yWi5ei6cOkPh4SHl2opHGM5Zm8e
         Q0oIG3p7IqiM5AFztmSpJSYrrluaSdkVwH0xFeRMy0khJhdud4xCWrV8KbtRsDKUZLAD
         lwnELbZ8VNC1BQY9z7g2ZJVAJCLroOd661TpC5Dr+sXmhsL7DVAAVVli6P6fAv07TndQ
         NL6A==
X-Forwarded-Encrypted: i=1; AKwUvBwxhULSLO+LdXLNuVZ+KBfcq8DGIR9aTKrZZbVEw0CwFiD2O7/EcH48/Tp8k8fTyWseWW0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKI7hI7kCsOGHLXAYQhx/A+MQXc/UdsGXp6RR2YojvD0Ie8aup/
	LtrxBXhYj64OoTmjwUxyZbMimAncNbTwAOr59u2XFKYNhcaGXAX3+a/jg9rf+xb8JCvuh2ZgQin
	Aaud5Tskf2kg/ePq2CH36nbGJTNW4X4JsbQHjfriRaULLLurG1FAMU9aB
X-Gm-Gg: AYBFou0LGaVGi/bAHZpj/lh0+9bCzFUorN/PiPvdYlxkK6zuq1db9/+Z/Y4ig/gMNov
	Q+88ao9xhGOwjmeQDJUdyiiNrUn5C0gHFEM+Rmpbk9Bo34Qq5I4S0z+h98bJydiUECdWQnhwRBh
	pwTDwfzF6JkjFcX7KXa4evgcbjDJPbDhNCVP7PxwP1F/2skZv26EBD2t6Vy6lAVHByNzYSHFKFg
	4PikfbHUxpdUlkhTqvubWgo5IWHpyP4esrgcgyIIVnqJx0H23GzpM6hg+QUqFGJkDBW/JpoE4zZ
	YhRe+YC+xsBGkNEkQZNvQplyCWWzw3gIRKsJMGJGeJcmvKaP5cTPsUTN1oJMGK6PXVvYX0HXBQN
	SzxDYtGG40k9KTjfKU+6LXw4ydsqkYQDIXfUPFDt0FmOn9iip72WwOJRGokLfuPJv22k=
X-Received: by 2002:ad4:5ded:0:b0:91b:8b2b:5a0 with SMTP id
 6a1803df08f44-91c12ed7f7fmr33692636d6.23.1792586210014; Wed, 21 Oct 2026
 05:36:50 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 05:36:48 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 05:36:48 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261020131447.122096-4-pbonzini@redhat.com>
References: <20261020131447.122096-1-pbonzini@redhat.com> <20261020131447.122096-4-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 05:36:48 -0700
X-Gm-Features: AclHuK8oqUEgIxjh5FUdJlLrxelycGduv-SDb4dxrbObth2hRi4LViUrvz_cFxw
Message-ID: <CAEvNRgGstgi3vo4Z1vqoXXQfbg8fDd608+JuMnmEtF_FiQF5Dg@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: always make in-place conversion a compile-time
 constant when possible
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Fuad Tabba <tabba@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Shivank Garg <shivankg@amd.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Paolo Bonzini <pbonzini@redhat.com> writes:

> Remove the unnecessary static call indirection and make
> gmem_in_place_conversion a constant if CONFIG_KVM_PRIVATE_MEMATTR_VM
> is false.
>
> Require that CONFIG_KVM_PRIVATE_MEMATTR_VM is y only if
> kvm_arch_has_private_mem is also defined.  This way, the three
> possible cases can be expressed without nested #ifs.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/linux/kvm_host.h | 13 +++++--------
>  virt/kvm/kvm_main.c      | 13 +++++++------
>  2 files changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 09c57d31d153..e7fc94e2910a 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2585,15 +2585,7 @@ bool kvm_arch_post_set_vm_memory_attributes(struct kvm *kvm,
>  #endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>
>  #ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
> -static inline bool kvm_vm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
> -{
> -	return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> -}
> -#endif  /* CONFIG_KVM_PRIVATE_MEMATTR_VM */
> -
> -#ifdef kvm_arch_has_private_mem
>  extern bool gmem_in_place_conversion;
> -
>  typedef bool (kvm_is_private_gfn_t)(struct kvm *kvm, gfn_t gfn);
>  DECLARE_STATIC_CALL(__kvm_is_private_gfn, kvm_is_private_gfn_t);
>
> @@ -2601,6 +2593,11 @@ static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
>  {
>  	return static_call(__kvm_is_private_gfn)(kvm, gfn);
>  }
> +
> +#elif defined kvm_arch_has_private_mem
> +#define gmem_in_place_conversion true
> +#define kvm_is_private_gfn kvm_gmem_is_private_gfn
> +
>  #else
>  #define gmem_in_place_conversion false
>

There's a #endif just below here where the comment says

  #endif /* kvm_arch_has_private_mem */

Not sure if the convention is to align with the first #if
(CONFIG_KVM_PRIVATE_MEMATTR_VM) or the #elif (kvm_arch_has_private_mem)
or something in-between.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> [...snip...]
>
