Received: from mail-wr2-f32.google.com (mail-wr2-f32.google.com [74.125.225.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD03C109B
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871868; cv=none; b=B2sCaK7PnDXsw2hHRuG/SvMitSbACI51cERZjhmjIMQyk5+KmuiWo+2T+AO3fdjUX5VyrubtYgdlmE0wX+6m7g81PdoM6r8mmrRZ95R9L716yU505q3pNV1omUm8bg/tb+1Ntkm2hEeQDTdjiZIt8VKueBVg+RRVCZfPuB0ctuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871868; c=relaxed/simple;
	bh=ZI9o4bTwAFLSUvqfJtnYi+jk/zWeAfwkgSPzM3bOjNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeGHVgUSvhqME2pmDizgqA5KVkYOsx5JHHiM/px5Pj/M9DbT82EF6UMq4NasmH0jJyExr9Vw0xOuQikFprboNe5NZwVllnBTxW/eTeOIMDAZ8jSfL0X94Y1UZsQrWVcvytGA+p/idf629icpPaVTzVBy8IMU7OU3O4f5E+maGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AX7JMAx/; arc=none smtp.client-ip=74.125.225.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AX7JMAx/"
Received: by mail-wr2-f32.google.com with SMTP id ffacd0b85a97d-482f6350f91so3942267f8f.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790871864; x=1791476664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HYtyNDhTMSzL7NauOy9LXxOvJvUf8XAKFvjtNEOO43Q=;
        b=AX7JMAx/iCCKy3KBYoqCVV8ttcZlBtbKECoCfWd6I1RK75t0ZbLSWNRMJuxtrMy6D2
         UXQS5qWcldf4sDAIiozHBI2lAAdNDlYfkgTCTEyXDLe4PzqNmABLLsp/1aicPxEfkxEZ
         wXEMPPqE+VTT8CEpEEXyQ0Ho+lE0dl33zOhX6gUWU8QU3DhWqIwjAXEyKHd/VUxppFOD
         R4NAuZTwYbl1IDHrAe9VHGF8LEnhR+oO38cjG7RNj7OONNQ4Q21jnCtRkUHdXN4BYbdO
         UJk3ILue2hWlo2PEUhh05xF/g5ndi/0OQBNkPORAFz+/C2fc5owCRnrS7vOSmS6Zsn4p
         A+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790871864; x=1791476664;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HYtyNDhTMSzL7NauOy9LXxOvJvUf8XAKFvjtNEOO43Q=;
        b=s9vvb39TvDzpHWbwiM/cBvDUbXhOCPhYJ6B4lGwqmcTHlGNzoqzWW0i4DaiBKgPiH1
         o7UO8AmX3OlqDHFaqwgFgSq/7R4Rj9uzdSH26xjBW7pxq1lSweyZCMw1rRDaSIOnrAGp
         Y354dui/oZYWTNGB5KQjDj7cCX+4MKV70/ys2LQga5prFpL28pauN4HLbZIA9+YnVYog
         XbtZQwx2TIBpcu90AyXuckBmNG9w93mJuVMnYiEgSFtL6IRJ7YdfcdGrqCFaCkcA+ydj
         TXQ/3glUb4mR104y37w5B8VtpOerYSEahpX8M7DVkCdW0qG3Kw0XyzWYqgCW3Ihhtkjp
         mIWg==
X-Forwarded-Encrypted: i=1; AKwUvBz4RKeYVLR144BbJJJpY+11lJoZ3apV9uwiOEB8dL7evidPKkolfkZT1+sxReEXNdMz57w=@vger.kernel.org
X-Gm-Message-State: AFuF++mys9g6OT2fFjFKaUrczriwREKaldHwyFranVo1wXwGLgg1lF31
	WSWsNHJq96IQsc7SMa8cwyAZnXDVK228nVeOmfCRxeEEebB/NZPJt8SIWzK2zxcRuzQ=
X-Gm-Gg: AYBFou2oDabcw4ZFcJxQR+L/m2TEtLUmGFa2DP7Kd5eMogfibimvqOc3GtnpHSZ9Jtp
	WtM4A7NQMnymQLHwrE1NB7avuQXiD/IweQAJsBI5mbREGqag5LHicf2HpgYwH1S7Z/FyBeJFALc
	dGWBu1NPJZv18CMfdYtSOB/ZaqZPgul4zbcgBJy67gS9GzpYBvDrEyCnGUSByEZvedJNDvUSGYZ
	AJoE4IxAG0NuhWy2l8nVZNK6bHujVVosgV+0TxJeeSMQmBvtXTS0J8ZQllK7xScHJMpP8SyZIs9
	ItPbeMv5HEVBnmXXgUI70THozHQZ8/J3XsWZZDBLuBj6tVTZdf0vYVLKTdSNnj86fkjX7dGCTDG
	78Tpceiq2x6xOU6YvyBzGoDqaqqz99PiMBxX5HRActqg8mXZlc8wFHVK28RotVBISjbVuZ4sl2G
	06AbsLDIkgbCZw1L+1h7vpJadn3J0+yRXRxoW/xocXbP7HOf2W09AJ4953Er6SSk6K75feys+Ni
	rBpw81DDPqoqWiBsVTYPeA=
X-Received: by 2002:a05:600c:34cb:b0:49f:c199:e1e2 with SMTP id 5b1f17b1804b1-4a0276ab18amr2182265e9.28.1790871863905;
        Thu, 01 Oct 2026 09:24:23 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02752aeb3sm3061465e9.0.2026.10.01.09.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 09:24:23 -0700 (PDT)
Message-ID: <5fe666c8-55ad-4f06-b853-a532d73c35be@suse.com>
Date: Thu, 1 Oct 2026 19:24:22 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] x86/virt/tdx: Convert the version metadata
 reader
To: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: yilun.xu@linux.intel.com, binbin.wu@linux.intel.com,
 tony.lindgren@linux.intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
 <20260930053901.22528-3-chao.gao@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260930053901.22528-3-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30.09.26 г. 8:38 ч., Chao Gao wrote:
> With the helper to read a table of metadata fields in place, the
> existing metadata readers can be standardized on it.
> 
> Convert the version metadata reader: add a table that pairs each field ID
> with the 'struct tdx_sys_info_version' member that holds its value, and
> read all version fields by walking that table.
> 
> Name the field IDs for readability, so the table entries don't carry raw
> hex literals.
> 
> AI was used under supervision to review code and workshop logs.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
> v3:
>   - Drop the get_tdx_sys_info_*() wrappers to remove an unnecessary layer
>     of abstraction. [Rick, Dave]
>   - Shorten the field ID defines from TDX_MD_FIELD_ID_* to TDX_FIELD_*
>     [Rick]
> ---
>   arch/x86/virt/vmx/tdx/tdx.c                 | 15 ++++++++++++---
>   arch/x86/virt/vmx/tdx/tdx.h                 | 10 ++++++++++
>   arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 17 +----------------
>   3 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 67a80ed86bd3..9d8a55a5da31 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -408,8 +408,8 @@ struct field_mapping {
>   };
>   
>   /* Read each metadata field listed in @mappings[] into @data. */
> -static int __maybe_unused __read_sys_metadata_table(const struct field_mapping *mappings,
> -						    int num_mappings, void *data)
> +static int __read_sys_metadata_table(const struct field_mapping *mappings,
> +				     int num_mappings, void *data)
>   {
>   	int i, ret;
>   	u64 val;
> @@ -434,6 +434,15 @@ static int __maybe_unused __read_sys_metadata_table(const struct field_mapping *
>   	.size		= sizeof_field(_type, _member),		\
>   }
>   
> +#define TDX_SYSINFO_MAP_VERSION(_field_id, _member) \
> +	TDX_SYSINFO_MAP(_field_id, struct tdx_sys_info_version, _member)

nit: I personally dislike adding this level of indirection, albeit 
rather shallow just so you don't have to repeat 'struct xxxx' in every 
TDX_SYS_INFO_MAP. Same goes for the rest of the patches. In the past I 
remember TDX code also suffered from, in my opinion, excessive macro 
nesting.

Dave, what's your take on this?

> +
> +static const struct field_mapping version_mappings[] = {
> +	TDX_SYSINFO_MAP_VERSION(TDX_FIELD_MINOR_VERSION,  minor_version),
> +	TDX_SYSINFO_MAP_VERSION(TDX_FIELD_MAJOR_VERSION,  major_version),
> +	TDX_SYSINFO_MAP_VERSION(TDX_FIELD_UPDATE_VERSION, update_version),
> +};
> +

<snip>

