Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF02C3E0C4F
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083099; cv=pass; b=q4oP+0ffMPTFnbCd4xsREKR57xRjIYZqCWF8ghFqNNX6y5VNAyO/zP+lcSZTg757o5qWpXbUs+tpdalpHGCf0JODaCTejRhBX0zlIt2UFdrj1bDpWEEAg95YG4Ny8pDkOjQ1nUktOYr1trONdP80jjohCcRFySOLKDlsUGCq8Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083099; c=relaxed/simple;
	bh=jXO8gD8XlEA3fjQ8sPVJzY/ZhuFjBKDxDVzAsc0vY6I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mn0XyQIgT3hUrnzVKsdt5zzdB+CH+9+aZmH/I7rVDmgI+04jTDNWhFsJWJ8QARsC+r5AHB8hqDFryYZtfpfeGgzUY9LFCbrJyRUaU5ZEtzkmeA0ChiOA26Wrrp5pdJCMTe97Hy06Q8AiZqgcaIIXet6+DjwY2ULobwiZZygOQRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCxpQvvc; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCxpQvvc"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-951a4e8d1b5so84939241.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 15:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083094; cv=none;
        d=google.com; s=arc-20240605;
        b=CM0mIIY4amQd+5Q8wP6jtrRMxMQP6yxfqw4o6E7iUJ+csAc9s5y8MbdoIf+cVUV60T
         CjLjU3layK307LEgYNlQIiIATe2cI0bu1FtzglRuBiC/7zuFgLyE0fEilY0HfxlcM0IW
         hYq9C8nbHtQ9ZO0xkf8C3D59UQG7v0FyQH0afvdE7FY4K9fHI2xzIxfYyhFnmadavSt+
         XHfLVNvXvGdFhzozZHu4RRq7vf1LgYz0/snwhg5N26Cm5XOgY1uKed94GEKAi9CufOni
         +i3UTLrl24XTCS0TYYBBBwMW69YX9riTbb3fvgN1hDYGFmeFcIqQR74Z6l4ph8UGK9s5
         qJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=euITMSp/xJeCQhYA18f4lx9pM8JTP5ZhaaxCuXCtMTI=;
        fh=+jZ1a+sVcrXlaMJZ7IediBafmekiMgEIqngMjUUssgI=;
        b=DaYIsJi3h1Nq8fjp8cXYVvAf3zRa7rMihBuYMpRKCChL9u48DKShivCPhkHsvceCuB
         jT4pM9psLj+wIxt/QH16L0bCFf4Y15IEB1C8ZxFYgg0wPAcvsEqDpt5AjBHkossk5ENg
         zH3XENNE7s0yN6IezNIqaaoNJ6PSU7Gyu7pAWvtegcERZBp0tXAQhzkKB9d1AN8CV/Ur
         itsidj3z1AJ2HCR7K1ntygtxPsuimc1kWvBZ5U8p1v03i2brbYgl2UPg8MK79KPXMUa9
         z4gxtArpRigO9DkGqnW0ikA11CaHAm/KBisdq6sbiqc2pzBBp7zN00SlSeOyzIH5XpyL
         cuKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775083094; x=1775687894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=euITMSp/xJeCQhYA18f4lx9pM8JTP5ZhaaxCuXCtMTI=;
        b=uCxpQvvc+0hcjsMUN671rmbWXMrSyqwrqTf3/sro5V11OwUvG8Ux4E7yRNXL9y3nJk
         P674tn4VbUHGQDn44atPoT2jydRhB5IKXGuziuL7PcdPXutGk8rTART8+nyy1xOkCswY
         uprTVCuySafYSktTyvOuvbxK9+b+nWdPwTNcykQ3dvt4mi41f2SF8JyWJ8BkIVKzuLE6
         +RJ9QZDZqSaNO3+p4G1aEXqgWLTf0gPd3Ts/BdmJ06GG61NVX3kmAs9JqE77rtNi8RjO
         UDguyXscnRr21wcD1M/+qN1h1vtswv+mekWziGIOBSxPkCgsRGMaFTkZQeIbH74JCJAd
         pTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775083094; x=1775687894;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euITMSp/xJeCQhYA18f4lx9pM8JTP5ZhaaxCuXCtMTI=;
        b=XnDimvW3i0Pr5MXT02ud+ab/CCVYK6RM2ecgoyEfbfa6NCxeZ+ZAZH1lx6vhX+mswq
         Dw9DLmA8FPWbDTwSecbWSxM2jODkrtA75Zf3JEDMmsl23ZSHV0XaH8kcw4VFJ2K6j1Gh
         wA4OX5auCfQw05doGFl06CbftV+aCNt5L8j6/hQzXc88vq5k0qpHtT7WgDvbVRZqbjdr
         7YiaPrJQR5Bfq8ikxk9OaA8WTOrnaol86/fqlkrohJpG1I3YpiINysOD7yz1LrevwjI+
         z54rRXInHhr+HnpHpALdA/Olisuum8SnpiZ5R4AaU6rrSEB+njPokV0GhXJJsX8Xgrk2
         LTPg==
X-Forwarded-Encrypted: i=1; AJvYcCX9xh+PBE8OkxIG6FMdKu2vZBen0LHnVkj4S3H5a02Hjt0AdAn4VVNtiitT5v/nW0B4m0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YylqfdDgh+Xj5oxYwR1b4/3On6VyHMFp0EaZk/dJhD4tvxTDJKW
	3VfVeaZAx0c37w2oTW6pGeseiokXdXtAtVPxEKEKvZdN4EOUPnTSjlciFAJ4jL1Qq4C79AOs2wp
	a80aZ0DL0y0+l1bYAIbo1hiVIyOtmFULrrGM/+l5E
X-Gm-Gg: ATEYQzxkItIrFQMuEQKKZcm8nK8ElnqCOHD+2DSM4e5n0ejunTLOpIp9L6iAVsMfbPq
	UbwZpJwE8i1vrK2xDgIyiwbwJOPPG/mNkrCU0mnLI0jZv3Pv1et/F0baCcorKP4Z1EWfwJp4CMA
	Z0h00jqwqWd6Vj6NfLQYqqifPuxkLSD0agqZRjrNK6gRfNCbYc4X3WcBSP7u+XLQyz+Gy4WYvFO
	o9SUG24+Gx44JuLk0xOXmanL6At/XIRfDxQ+6Yl+AkLIqYZy2w8eTUBYRxRrAMZxn/iyzaQR3SD
	1cIdWdypVvPbBV2lk22oBrfCpnwjOtgKVnB6W4UV2OGRYG2iJGsAp9oIQb/OMbr19kMkqA==
X-Received: by 2002:a05:6102:cd0:b0:5f5:40ab:2d65 with SMTP id
 ada2fe7eead31-60583fb718fmr487325137.22.1775083093776; Wed, 01 Apr 2026
 15:38:13 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Apr 2026 15:38:13 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Apr 2026 15:38:12 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com> <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 1 Apr 2026 15:38:12 -0700
X-Gm-Features: AQROBzCNhmfEK8q5oXqVxD-E8d6K5nvB8FmwqZKQD4ACNG80cfTfNWvs3WVsxNc
Message-ID: <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Michael Roth <michael.roth@amd.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Michael Roth <michael.roth@amd.com> writes:

>
> [...snip...]
>
>>  static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
>>  {
>> @@ -2635,6 +2625,8 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
>>  		return -EINVAL;
>>  	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
>>  		return -EINVAL;
>> +	if (attrs->error_offset)
>> +		return -EINVAL;
>>  	for (i = 0; i < ARRAY_SIZE(attrs->reserved); i++) {
>>  		if (attrs->reserved[i])
>>  			return -EINVAL;
>> @@ -4983,6 +4975,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>>  		return 1;
>>  	case KVM_CAP_GUEST_MEMFD_FLAGS:
>>  		return kvm_gmem_get_supported_flags(kvm);
>> +	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
>> +		if (vm_memory_attributes)
>> +			return 0;
>> +
>> +		return kvm_supported_mem_attributes(kvm);
>
> Based on the discussion from the PUCK call this morning,

Thanks for copying the discussion here, I'll start attending PUCK to
catch those discussions too :)

> it sounds like it
> would be a good idea to limit kvm_supported_mem_attributes() to only
> reporting KVM_MEMORY_ATTRIBUTE_PRIVATE if the underlying CoCo
> implementation has all the necessary enablement to support in-place
> conversion via guest_memfd. In the case of SNP, there is a
> documentation/parameter check in snp_launch_update() that needs to be
> relaxed in order for userspace to be able to pass in a NULL 'src'
> parameter (since, for in-place conversion, it would be initialized in place
> as shared memory prior to the call, since by the time kvm_gmem_poulate()
> it will have been set to private and therefore cannot be faulted in via
> GUP (and if it could, we'd be unecessarily copying the src back on top
> of itself since src/dst are the same).

Could this be a separate thing? If I'm understanding you correctly, it's
not strictly a requirement for snp_launch_update() to first support a
NULL 'src' parameter before this series lands.

Without this series, the startup procedure is to have memory set up in
non-guest_memfd shared memory, and then snp_launch_update()-ed into
guest_memfd private memory.

With this series, it is a little troublesome, but the startup procedure
can still set up memory in guest_memfd shared memory, then copy
everything out to some temporary memory, then set guest_memfd memory to
private, then snp_launch_update() the temporary memory into guest_memfd
private memory.

We would be unnecessarily copying the src (now in some temporary memory)
back onto itself. Can that be a separate patch series?

Btw, if snp_launch_update() is going to accept a NULL src parameter and
launch-update the src in-place:

+ Will userspace have to set that memory to private before calling launch
  update?
    + If yes, then would we need some other mode of conversion that is
      not ZERO and not quite PRESERVE (since PRESERVE is defined as that
      the guest will see what the host wrote post-encryption, but it
      sounds like launch update is doing the encryption)
+ Or should launch update be called when that memory is shared? Will
  launch update then also set that memory to private in guest_memfd?

>
> So maybe there should be an arch hook to check a whitelist of VM types
> that support KVM_MEMORY_ATTRIBUTE_PRIVATE when vm_memory_attributes=0,
> and if we decide to enable it for SNP as part of this series you could
> include the 1-2 patches needed there, or I could enable the SNP support
> separately as a small series and I guess that would then become a prereq
> for the SNP self-tests?
>
> Not sure if additional enablement is needed for TDX or not before
> KVM_MEMORY_ATTRIBUTE_PRIVATE would be advertised, but similar
> considerations there.
>
> -Mike
>
>>  #endif
>>  	default:
>>  		break;
>>
>> --
>> 2.53.0.1018.g2bb0e51243-goog
>>
