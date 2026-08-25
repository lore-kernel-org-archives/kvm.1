Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F148550F
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787671709; cv=none; b=mpuUHbucQv/mpOpnA4ZuRA1dMqH38R2E+U7iNA3WwUDs1NbmtuHYNzGnDiqEnFa3lJUKsJMe6mcNCv18OGPAb4mhCKG1/y1pZRrnPaI69ZrcjQor2ClCE5waGgL6abwqap47v+IKwlPTxj+Q3veGY+xmSpJ5vQURiN0ytG7ISFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787671709; c=relaxed/simple;
	bh=loYqtnWXMGjjT8NDFhyil776wzBbOGoJ8kBMmOt6a6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n8GMrZTDstqmPD0giMzSx+g9qAFV0gEr64iit/oWJSjF5eC2P9D6wdRDE0LWKuxdy63TozO2YVtnYLEsjD9VHKATGEdOmq16JSo6nJOy6TYiQBz08yu5dYkV4CbkEeCckYMguxmHZfbx81wmFtKpWTcrfZkc7j0f3PY8gbqmwY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eaIbwYch; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eaIbwYch"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb835525b10so6310743a12.2
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787671708; x=1788276508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z2PSz/zBXLlU1jZmPieSmrOStF8SdBY8YCSvnTzrOXM=;
        b=eaIbwYche9iRhNwHOLXxc9R6lmXeZxuI1vHYj0X5Bm1Xdf0h1MYFqjDtW3ozdo6A4Z
         5FZgJSEkecxiwZmozvXlYuBVWAu2YzzPO98Ku8MqA0uV4bxXKFjDWMyrxKCS7bwPxfY8
         oJw7e1SvMOeZOvlCf8r7RD8G9aCFkl7qp847roWk2/qRhn8fVhs8GMMXQTkcfAq770Dr
         MNV+VNZtdmrzYWNpsqWnNnNOvsmrbwbuDqe8KqMPZb8X1HG33zw8Ti8kv9Zo+ZFeFaoZ
         NFdk6ydQb9FwXjA1rYDJn43uKJfHn9qY+g97SApCdHQiNsE1bNeUWZvrO0h9vVe4pOPI
         6sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787671708; x=1788276508;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z2PSz/zBXLlU1jZmPieSmrOStF8SdBY8YCSvnTzrOXM=;
        b=fgYE+QwjkraNrTDyHOBEILp1hsQvRqZShuCiVkv1AfZaV8dDoApKKRqcDLtKAYA+ui
         Opvsd/ec7T965Nye4kKTyWktqezRW4/hrNqxiO5kdYjt77/7/vC37fLbH9RJtcbGY5bU
         zXoJYT0KiE+wz6Hzi9QQ+sks93OWqCkajKNJ1jW+tZsedVrjUrC622ZY0/jZ9MRHKRSq
         iru8tEwS4PW9L/YfkP01nOntq6Uw94RKcx8Z7NKx7CSmalJHfkUxv5YswpM3CzMXB6m0
         KBAZ07MZAp8lc05vrCfsGSnalc2swhRLd504gCUZ+qhuQPSJ9g0SirN6s+gWjQ2WBCpv
         MaMg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/zD4op5ibSI2GB7+kE8ioqqDSxSa9Tbk52CkCCj1z4MFr/SMhElAUHlHeNAxZLd1gytU=@vger.kernel.org
X-Gm-Message-State: AFuF++lNSE7qULkanuhDGs2u8EdtKxe28ri5tbWGQn36onjcdKUX5aAM
	h7plXA6XF8yGczq8zR+EjjlJK5dSOfWW4OpAsIWoumeqChS5UYa98mUA21msme/WXphtWX143t7
	nzDVJMg==
X-Received: from pgbd17-n1.prod.google.com ([2002:a05:6a02:64d1:10b0:cc1:8a49:bf91])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7d02:b0:3cd:a1e2:f238
 with SMTP id adf61e73a8af0-3cda1e303bbmr4127115637.16.1787671707506; Tue, 25
 Aug 2026 08:28:27 -0700 (PDT)
Date: Tue, 25 Aug 2026 08:28:26 -0700
In-Reply-To: <327c7769-8ef6-40c3-869a-93c29ec9fa9f@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706063035.1139-1-sarunkod@amd.com> <20260706063035.1139-2-sarunkod@amd.com>
 <20260706065212.CCD741F000E9@smtp.kernel.org> <84113ba5-ddb8-47aa-abe0-c6968feb3fea@amd.com>
 <anpsjpCQHjJCH7TU@google.com> <327c7769-8ef6-40c3-869a-93c29ec9fa9f@amd.com>
Message-ID: <ao20mmzg6dMLukMo@google.com>
Subject: Re: [PATCH v2 1/2] x86/uaccess: Extend CMPXCHG user helpers to
 128-bit operands
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026, Sairaj Kodilkar wrote:
> On 8/11/2026 5:57 AM, Sean Christopherson wrote:
> > On Mon, Jul 06, 2026, Sairaj Kodilkar wrote:
> >> On 7/6/2026 12:22 PM, sashiko-bot@kernel.org wrote:
> >>>> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/u=
access.h
> >>>> index 367297b188c39..123755d471099 100644
> >>>> --- a/arch/x86/include/asm/uaccess.h
> >>>> +++ b/arch/x86/include/asm/uaccess.h
> >>> [ ... ]
> >>>
> >>>> @@ -551,11 +594,18 @@ do {                                          =
                                  \
> >>>>
> >>>>   extern void __try_cmpxchg_user_wrong_size(void);
> >>>>
> >>>> -#ifndef CONFIG_X86_32
> >>>> +#ifdef CONFIG_X86_32
> >>>> +/* Always fail on 32 bit arch as it do not support 128 cmpxchg (i.e=
. cmpxchg16b
> >>>> + * instruction).
> >>>> + */
> >>>> +#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) (1)
> >>> [Severity: Medium]
> >>> Does this 32-bit stub correctly signal failure?
> >>>
> >>> Since this macro evaluates to 1, won't the surrounding unsafe_try_cmp=
xchg_user
> >>> macro treat this as success (true) rather than failure (false)?
> >>>
> >>> This could cause the wrapper to negate the value and return 0 (succes=
s) to the
> >>> caller, falsely signaling a successful memory exchange without actual=
ly
> >>> updating memory or the old value. Even though there are no current 32=
-bit
> >>> callers using a 16-byte operand, should this evaluate to 0 instead of=
 1 to
> >>> ensure theoretical future callers don't encounter a silent atomicity =
break?
> >>>
> >>> --
> >>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026070606303=
5.1139-1-sarunkod@amd.com?part=3D1
> >> Hi,
> >>
> >> Right, It should return 0 instead of 1, will rectify this in the next =
patch.
> >=20
> > Is it possible to fail the build instead?  Attempting to generate CMPXC=
HG16B on
> > 32-bit should straigt up fail.
>=20
> Hi Sean,
>=20
> A compile-time failure in __try_cmpxchg128_user_asm would unfortunately
> break i386 builds even for callers that never use a 16-byte operand.
>=20
> unsafe_try_cmpxchg_user dispatches on sizeof(*(_ptr)) via a switch, and
> the 128-bit path is one of those cases. As noted in the comment above
> the macro, Clang/LLVM tends to compile all switch arms when expanding
> this macro, and only discards unused paths afterward.

If that's actually happening, then this code is already broken, because u12=
8
exists only on (some) 64-bit kernels.

A straight static_assert() will fail, but BUILD_BUG_ON() (or more precisely=
,
__compiletime_assert())  and all of the associated magic exists for these e=
xact
scenarios.  Unlike static_assert(), __compiletime_assert() relies on dead-c=
ode
elimination, i.e. does exactly what we want.

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.=
h
index a58d50d7a219..710a0b42eeef 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -595,10 +595,7 @@ do {										\
 extern void __try_cmpxchg_user_wrong_size(void);
=20
 #ifdef CONFIG_X86_32
-/* Always fail on 32 bit arch as it do not support 128 cmpxchg (i.e. cmpxc=
hg16b
- * instruction).
- */
-#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) (1)
+#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) ({ BUILD_BUG_O=
N(1); 1; })
 #else
 #define __try_cmpxchg64_user_asm(_ptr, _oldp, _nval, _label)		\
 	__try_cmpxchg_user_asm("q", "r", (_ptr), (_oldp), (_nval), _label)

