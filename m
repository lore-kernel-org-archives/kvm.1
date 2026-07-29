Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325DD3EC83A
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341121; cv=none; b=i15q//TyIDgjazX/yjvynDzB2g4jsUM3iFJJkh1S7cOYlSnPh6GllK/BfHZcEAZeG/pn51mKHWvqbUuC8xAKRR93fQZKVN0NSLnJaQuS8Se2Rrk3EROWR4N+fbgGhWRsebwtojacKybEUTClLeHk2jLNdkV76r7q6hVuCdVsn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341121; c=relaxed/simple;
	bh=6dhf2ThkaWXO1d6SgMWi/wi1OAGH6HEYT6nrIsYJvDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9oAa9/6WF+bqVMZqgn5TLcluU33esQwMNtOrzBv/C9NF5DxcSXga4QvMRAPMXjh/reX/1UKRoRqPAotT3gpF6Cy6Jo+Fzq5gEjgu6RITcsmE78zDzYazz1UEQgN1ALfZgJxy9dEXy1jrpy5/CRrgJeesXH+wXhEdGTM0tBzu78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fKKrk+Uz; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fKKrk+Uz"
X-Forwarded-Encrypted: i=1; AHgh+Rr/a8NRfHfHGW70d6KVSjU8NHwJGh1f4YcBRSebHXI4qdG1UGOKY2Dy6FolGh8yQh93oh0=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785341118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWo0ftyBa7lC2aPQ/hBNWMcCRmwtU50P0VZaxqKFsjs=;
	b=fKKrk+UzoYifU5FVDkXkflhqtVa5hAxlybvxfwmpygJZUljFk3fn+8tFLeeX71BkYCHKmB
	dQ9g7hxlrqr/SxCDCkrw3/GhLlsGX4oalWTIZxPc7OLkcO06DX+4FJCwCt/xGH+w5pFz2a
	nl679Tx5tUdyYpo4Bp3OKMBxa1oJp64=
X-Gm-Message-State: AOJu0Yy4fO3BtPwM2RSpu/a3nvIOZUPQqE73d1A8E73ZH2hHp4WjhpJR
	QgVwfJl2Ki3DNlfFSSPPN6sRv6mX09QDnGX39fKelT7MfxwIcOcnPhx1o5ar+6Dzq8KjSte32hL
	RI9Yy4oFt8T9eswLevkM8Hyszo1YYfvkEPhepO2u4
X-Received: by 2002:a05:622a:a15:b0:517:64f6:3365 with SMTP id
 d75a77b69052e-52b34e85fb1mr1702101cf.4.1785341097295; Wed, 29 Jul 2026
 09:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-hybrid-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp> <20260720-hybrid-v9-7-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260720-hybrid-v9-7-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 29 Jul 2026 17:03:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyTcUBzAcGhG88w7qxUgm5BF709Za9XWYWEHE=JMCL2hA@mail.gmail.com>
X-Gm-Features: AUfX_myu-7UL3bRAtMkrPeNTWcxaXv9440Zld_Zcb7LGPBk6xfJMpVLySDjt26o
Message-ID: <CA+EHjTyTcUBzAcGhG88w7qxUgm5BF709Za9XWYWEHE=JMCL2hA@mail.gmail.com>
Subject: Re: [PATCH v9 07/16] tools headers: Use u* types for bitfield helpers
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Eiden <seiden@linux.ibm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	devel@daynix.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Mon, 20 Jul 2026 at 06:39, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Commit 9486aa387716 ("perf tools: Fix 64 bit integer format strings")
> defined the tools-local u64 as uint64_t so that PRI*64 format macros
> match its underlying C type. On architectures where uint64_t and __u64
> are distinct types, however, ____MAKE_OP() still gives the u64_*
> helpers an __u64 interface.
>
> Teach ____MAKE_OP() to accept the helper name and storage type
> separately. Keep endian helpers on __le* and __be*, and generate the
> native helpers using the tools-local u* types.
>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad



> ---
>  tools/include/linux/bitfield.h | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/tools/include/linux/bitfield.h b/tools/include/linux/bitfield.h
> index ddf81f24956b..1c633343d576 100644
> --- a/tools/include/linux/bitfield.h
> +++ b/tools/include/linux/bitfield.h
> @@ -142,32 +142,32 @@ static __always_inline u64 field_mask(u64 field)
>         return field / field_multiplier(field);
>  }
>  #define field_max(field)       ((typeof(field))field_mask(field))
> -#define ____MAKE_OP(type,base,to,from)                                 \
> -static __always_inline __##type type##_encode_bits(base v, base field) \
> +#define ____MAKE_OP(name,type,base,to,from)                            \
> +static __always_inline type name##_encode_bits(base v, base field)     \
>  {                                                                      \
>         if (__builtin_constant_p(v) && (v & ~field_mask(field)))        \
>                 __field_overflow();                                     \
>         return to((v & field_mask(field)) * field_multiplier(field));   \
>  }                                                                      \
> -static __always_inline __##type type##_replace_bits(__##type old,      \
> -                                       base val, base field)           \
> +static __always_inline type name##_replace_bits(type old,              \
> +                                               base val, base field)   \
>  {                                                                      \
> -       return (old & ~to(field)) | type##_encode_bits(val, field);     \
> +       return (old & ~to(field)) | name##_encode_bits(val, field);     \
>  }                                                                      \
> -static __always_inline void type##p_replace_bits(__##type *p,          \
> +static __always_inline void name##p_replace_bits(type *p,              \
>                                         base val, base field)           \
>  {                                                                      \
> -       *p = (*p & ~to(field)) | type##_encode_bits(val, field);        \
> +       *p = (*p & ~to(field)) | name##_encode_bits(val, field);        \
>  }                                                                      \
> -static __always_inline base type##_get_bits(__##type v, base field)    \
> +static __always_inline base name##_get_bits(type v, base field)        \
>  {                                                                      \
>         return (from(v) & field)/field_multiplier(field);               \
>  }
> -#define __MAKE_OP(size)                                                        \
> -       ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
> -       ____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu) \
> -       ____MAKE_OP(u##size,u##size,,)
> -____MAKE_OP(u8,u8,,)
> +#define __MAKE_OP(size)                                                                        \
> +       ____MAKE_OP(le##size,__le##size,u##size,cpu_to_le##size,le##size##_to_cpu)      \
> +       ____MAKE_OP(be##size,__be##size,u##size,cpu_to_be##size,be##size##_to_cpu)      \
> +       ____MAKE_OP(u##size,u##size,u##size,,)
> +____MAKE_OP(u8,u8,u8,,)
>  __MAKE_OP(16)
>  __MAKE_OP(32)
>  __MAKE_OP(64)
>
> --
> 2.55.0
>
>
