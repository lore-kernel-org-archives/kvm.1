Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8360377A91
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784156913; cv=pass; b=ZqK0GbNyfpYSTx+/rQPSLNNu7E20pph/Lhd1dR8bHzgL0WkJJ32wEpqAs4ToQIIGA6Xj65dbq6OtSvPuvh+fQrWnF6kzOlenglX2yfPL484qKhyGv8m8tBEV/9Kqek5Xof8IBlwxqg5iUbth6GCBQmoMDrMsoWAGaf0mE/dY7VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784156913; c=relaxed/simple;
	bh=PQgCKGNNNbdMZzqnzTj/ImF0sQmZGDZxuxN0rcmc6iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0v4eAcG59LjnykchBTLFdSgfM5wBxVi4qZwzpwKrWdWoAOVAZCv/FIvfx4QH2l1HMwuyccbP9QCkc6Pllfxs5YYkFBJR6+kTgAhBleNGYE+t1r7aicVtb4Zr/Rv8Ro3oYEr+RjdQVRlRPfhi5hso4k1O6sWv3lxMfVFRV1x1RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F5GC4UIh; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F5GC4UIh"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso2090a12.1
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 16:08:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784156910; cv=none;
        d=google.com; s=arc-20260327;
        b=kGzMZ8h4XC/veXNRzptgAvrbI2809OM0KpZR7q8KFGIAJSdBSScgZICBNu4VKe84Ye
         +JR5nfjRzJeLSbkCIEtjHwqJBtoClQvratKF8M+eUAuoFvXSYn3wWLzDU9FQ7N2Mb6C8
         DMQjeWow4A0RvVLKKRQkBTPY2AOpa3grVkfbTRy4KUkibSU+QYYl3kDlf3YjpXM6s+Ls
         lVUZUE7jCg8CtirLiHg/eT5iJ84VlZ2Ezfe9XnoMLOl6S2ikLjSVNpGKh6MMlTmYd2qp
         WDpuTDIncwZuzJCCmrSMBc+08tW8mTW4SlE/aSa1VvdJEXwss9rV9FsHQvNRocJLoDvd
         XzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/KMkPSBNuv+FxEK9sPaQiuvHezh8gs8un7ufSsDMGuA=;
        fh=iDf/POxQm4TIO2YyDRethIt90F5RhRKiErhUBEyDh1I=;
        b=WbitdNjF/Swuc9rqScaHVc7AQQXPuTPMImUpPtDtFeOYYv35aRRSLRt1YZbzkBYaAa
         HAirWIGDS3RKqJf9DjgrZ+LhxXqstfgXRLoFbq39wtZt95DbZdELO7wTs/Dj84P5vtaT
         13Vgj93mH/evXWg+U/n8d+v5BDu5d4O+MOybHM7WTlYeBQ4W4PzbRo92C3zflr0GOYbP
         Q4qHBGmvYKqh2kT8VbqCnDU0BWBIXIgKydvN/GwaX674qydUqPDDT7M2PKVPaq+QOGwQ
         tTMjNNckdS9d2EYpqF7Nji9bnIm/6eTonoGDPvG9NfI3un7IbGzstlCV8o15zwb3sjjp
         0Ktg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784156910; x=1784761710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/KMkPSBNuv+FxEK9sPaQiuvHezh8gs8un7ufSsDMGuA=;
        b=F5GC4UIh+jTvtlZ3xoUghpueIVAI94fw9hQONx6JfG7ECqkh0ywV/xvRVuJONlftUu
         2eBQgjaGEdtIqiQjMNIh5vKLb2PiMlBJ5GKQi4JRpVXIYFwEsaV7F7nSZTG28KneuOex
         YoV1Q43AzFS7fGTFb046U077jOfiWzJW0Ch6y2f1RCIO5LOddVSr5VplYibVNGnojHQw
         QVf6BDA9aSSKVqyjkX2t7kRrfwkEMr3Hyg+3p45pxO8WP8Nc4iQaOQj9u8AqH2lVXLOC
         Tig9JtNODmM+ayXUHGL0WdnhG+s61dQZONStZYuZv45zCtLUzcqwSXcQcQralywlz6Jm
         94vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784156910; x=1784761710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/KMkPSBNuv+FxEK9sPaQiuvHezh8gs8un7ufSsDMGuA=;
        b=kJkk5lv20dqbpIOTum0Rk+d4atY7Oi+7+GBr7snz9EGlP6Ke3LaBpqTHIXQneVeFpI
         9CjGOPt6NNSKFsDx2L0wtAuS970rI20foNiJplt4EkIizN2pvwFi8sbFKUztrJIJ4XGA
         OUhJ9IptmGfeLDvzG2BQR6um9wLQDt+6FcXHyZiZ/L8yPGJu3ZcZEtcFxh73UvYeF5RH
         yV9EwBqgsdL9ZDK3GHn2VY7gT6kYipesn/eSoDFTDKTIUufF+1jy2Ze8ZotcKi1kU3x9
         QaP3T7P8jpNdzhNpW30Kupy1pwwhXqO6FpUyVg+6oz/ujSNAj1sS7Tzau1SE7gKtEs4R
         b9/Q==
X-Forwarded-Encrypted: i=1; AHgh+RooNuRU5BXpCovns8aQuOLGvdVmRp/LCbMlpoz/Q8qgo+79gpP18jMYkCAKWnSFAXWCWxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxme/W8OtRwCA/GC9j1UuzGPZXS2zJr/KkZpYvuXqJavsbJdbK+
	lYL3CasZqca+em5pP8oRCDoZK5J1hXgrFXUDqN96OWNkp2Jx3IFA1/WfBrn1/Ws5oc7NoUVzK6T
	AJ7IYhWEPOlGupE9TzTS7OCOkTAaup4eLuAuGnZcC
X-Gm-Gg: AfdE7ckdqC/WWIA/SG6XN87ALvILscE2lD97u7Vs67+0HKggWKc1LFUY/OkrBvEmOS9
	RUD5Ww7leTYEMb7k5tEFta0yrkoILEPRzQSL3PSgoy0SnQ/07TW4qlHStIB+vaLrBvV+01wAjpY
	VaQ1mwOmcACRPWgvE6vsB1FA/zurThZZvglPAQshETyHHe7r9KBinZbAG52eX0l4b9M2mGpFj0T
	n07hFuU8TrFA2jJRXHZXwNEBA6eDA2D1szRIftEzTcc2prNziI0slJbooWCFg==
X-Received: by 2002:aa7:d6c5:0:b0:697:e82f:e4f2 with SMTP id
 4fb4d7f45d1cf-69e2e372b99mr22128a12.4.1784156909648; Wed, 15 Jul 2026
 16:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120050720.931449-1-zhao1.liu@intel.com> <20251120050720.931449-3-zhao1.liu@intel.com>
 <aXO1_kmDSu_H1BoL@google.com> <aXXLZ9nCzTmeaSS0@intel.com>
In-Reply-To: <aXXLZ9nCzTmeaSS0@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 15 Jul 2026 16:08:16 -0700
X-Gm-Features: AUfX_mzrjdzlN2LUfwcjMtWV5UO2vkDclrCdsuyWzJUowm3IE32QI0GrP1tUjMA
Message-ID: <CALMp9eRqaxhmADqOOWW9h4yctg5MxfU9AdL5C8MpFNzKJm-Big@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: x86: Advertise AMX CPUIDs in subleaf 0x1E.0x1 to userspace
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chao Gao <chao.gao@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 11:25=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wro=
te:
>
> > Unless someone feels *very* strongly about the "mirror" terminology, I'=
m going to
> > use ALIAS instead of MIRROR when applying, to match KVM's existing term=
inology for
> > the 8000_0001.EDX =3D> 1.EDX aliases.
> >
> > /*
> >  * Intel-defined sub-features, CPUID level 0x0000001E:1 (EAX).  Note, s=
everal
> >  * of the bits are aliases to features of the same name that are enumer=
ated via
> >  * various CPUID.0x7 sub-leafs.
> >  */
> > #define X86_FEATURE_AMX_INT8_ALIAS    KVM_X86_FEATURE(CPUID_1E_1_EAX, 0=
)
> > #define X86_FEATURE_AMX_BF16_ALIAS    KVM_X86_FEATURE(CPUID_1E_1_EAX, 1=
)
> > #define X86_FEATURE_AMX_COMPLEX_ALIAS KVM_X86_FEATURE(CPUID_1E_1_EAX, 2=
)
> > #define X86_FEATURE_AMX_FP16_ALIAS    KVM_X86_FEATURE(CPUID_1E_1_EAX, 3=
)
>
> LGTM, yes, ALIAS sounds better than MIRROR.

Our friendly AI reviewer asks: given that these are aliases, shouldn't
they be hidden from the guest if the features they alias to are hidden
(e.g. clearcpuid=3Damx_int8).
