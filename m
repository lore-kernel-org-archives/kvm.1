Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035243793DC;
	Mon, 23 Feb 2026 21:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883513; cv=none; b=s96ZxnYSRLGfN4ZKuK4P1IORYpI8IftW3OgYK7tYrxlkFzmDgQOE5+c4YSel/Eg3YS71GPU4uHHim52RCdw02mh1/u+D/Rzp2emPeIzVJ4a4uevDtvgp6jAiXChGD3At2EXQoxp0FADDxQ1cuOblnQWCOU/kgXjSFSijkDtCVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883513; c=relaxed/simple;
	bh=WKnPEDwDIfx+k5AfNNeAwDt7AQEjK30PPk/wAUXfwj8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VxdNr8DNKS6ch3FYfCwZ+Z9wODuHvndefGV99L0ATMahzNh8i5ZcrfOE8D/xJzJkqLtj2H9llYWQ4VbqdQrIBmQh0PxhHdJcpwdVGlXQgDFXH1HqmRoEpvpMhrnnrvVCBUxwkEXNRKUMtZXp1EaHEswqfIprGvYLaivnAj05yms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=gm79Vk5c; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gm79Vk5c"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61NLYvH01544899
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 23 Feb 2026 13:34:57 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61NLYvH01544899
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771882498;
	bh=OaFmr3lJa5FSZUIHPiZLMbyOO2f/Re90qGLN732/lLY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gm79Vk5cwr8hNbIiGsR3JzHXzJQGWJTEtYUA+hPYy6TkMmg7Mr1W2UizsTNuqVPzr
	 YwcmONmbFNgNXkWq0pDAWWEZLPyG7x4xWO0eP19Lr3Jex99pdgsRU+Elo8HHHBPcDY
	 fyKtu++A/UxVfX6Z55Jxpw0PHCP44DcmN+0auikXCRF8aJ6GnUYfYW3d/k5IVHU9oj
	 BSZNEFhf7ntBhItORhDSYcI8iNzILj+RNyFJphbBSRQMrbJ267Z0MwmbzE/8Zqqusn
	 B18floV2S7wSJFcL3w2xZOpwgm+14a7FZyYvNVs4S9UAKjM/g60ZeBugjQp4wht6Mp
	 FSnHcqszWoNOA==
Date: Mon, 23 Feb 2026 13:34:49 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, Dave Hansen <dave.hansen@intel.com>
CC: =?ISO-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kvm@vger.kernel.org, llvm@lists.linux.dev,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_09/16=5D_x86/msr=3A_Use_t?=
 =?US-ASCII?Q?he_alternatives_mechanism_for_WRMSR?=
User-Agent: K-9 Mail for Android
In-Reply-To: <14FE6A05-0864-4BD5-8331-0C2E6B8A28F8@zytor.com>
References: <20260218082133.400602-1-jgross@suse.com> <20260218082133.400602-10-jgross@suse.com> <aZYoUE7CmrLg3SVe@google.com> <e05a65a7-bf8e-420b-8a36-2d76e56b43b0@intel.com> <d622a318-f7f8-4cff-b540-38d159ca87f4@suse.com> <437EC937-24B7-4E69-B369-F9FAFC46F1B1@zytor.com> <542ff5d7-1cff-4ef9-af48-f0378aa2a05c@intel.com> <14FE6A05-0864-4BD5-8331-0C2E6B8A28F8@zytor.com>
Message-ID: <9BD31A13-A285-4C81-B590-5241C47D3F5C@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 23, 2026 9:56:28 AM PST, Xin Li <xin@zytor=2Ecom> wrote:
>
>>>> I _really_ thought this was discussed upfront by Xin before he sent o=
ut his
>>>> first version of the series=2E
>>> I actually reached out to the Intel architects about this before I sta=
rted
>>> coding=2E Turns out, if the CPU supports WRMSRNS, you can use it acros=
s the
>>> board=2E  The hardware is smart enough to perform a serialized write w=
henever
>>> a non-serialized one isn't proper, so there=E2=80=99s no risk=2E
>>=20
>> Could we be a little more specific here, please?
>
>Sorry as I=E2=80=99m no longer with Intel, I don=E2=80=99t have access to=
 those emails=2E
>
>Got to mention, also to reply to Sean=E2=80=99s challenge, as usual I did=
n=E2=80=99t get
>detailed explanation about how would hardware implement WRMSRNS,
>except it falls back to do a serialized write when it=E2=80=99s not *prop=
er*=2E
>
>
>>=20
>> If it was universally safe to s/WRMSR/WRMSRNS/, then there wouldn't hav=
e
>> been a need for WRMSRNS in the ISA=2E
>>=20
>> Even the WRMSRNS description in the SDM talks about some caveats with
>> "performance-monitor events" MSRs=2E That sounds like it contradicts th=
e
>> idea that the "hardware is smart enough" universally to tolerate using
>> WRMSRNS *EVERYWHERE*=2E
>>=20
>> It also says:
>>=20
>> Like WRMSR, WRMSRNS will ensure that all operations before it do
>> not use the new MSR value and that all operations after the
>> WRMSRNS do use the new value=2E
>>=20
>> Which is a handy guarantee for sure=2E But, it's far short of a fully
>> serializing instruction=2E
>
>

So to get a little bit of clarity here as to the architectural contract as=
 opposed to the current implementations:

1=2E WRNSRNS is indeed intended as an opt-in, as opposed to declaring rand=
om registers non-serializing a posteori by sheer necessity in technical vio=
lation of the ISA=2E

We should not blindly replace all WRMSRs with WRMSRNS=2E We should, howeve=
r, make wrmsrns() fall back to WRMSR on hardware which does not support it,=
 so we can unconditionally replace it at call sites=2E Many, probably most,=
 would be possible to replace, but for those that make no difference perfor=
mance-wise there is really no reason to worry about the testing=2E=20

It is also quite likely we will find cases where we need *one* serializati=
on after writing to a whole group of MSRs=2E In that case, we may want to a=
dd a sync_cpu_after_wrmsrns() [or something like that] which does a sync_cp=
u() if and only if WRMSRNS is supported=2E

I don't know if there will ever be any CPUs which support WRMSRNS but not =
SERIALIZE, so it might be entirely reasonable to have WRMSRNS depend on SER=
IALIZE and not bother with the IRET fallback variation=2E

2=2E WRMSRNS *may* perform a fully serializing write if the hardware imple=
mentation does not support a faster write method for a certain MSR=2E This =
is particularly likely for MSRs that have system-wide consequences, but it =
is also a legitimate option for the hardware implementation for MSRs that a=
re not expected to have any kind of performance impact (full serialization =
is a very easy way to ensure full consistency and so reduces implementation=
 and verification burden=2E)

3=2E All registers, including MSRs, in x86 are subject to scoreboarding, m=
eaning that so-called "psychic effects" (a direct effect being observable b=
efore the cause) or use of stale resources are never permitted=2E This does=
 *not* imply that events cannot be observed out of order, and cross-CPU vis=
ibility has its own rules, but that is not relevant for most registers=2E

4=2E WRMSRNS immediate can be reasonably expected to be significantly fast=
er than even WRMSRNS ecx (at least for MSRs deemed valuable to optimize), b=
ecause the MSR number is available to the hardware at the very beginning of=
 the instruction pipeline=2E To take proper advantage of that, it is desira=
ble to avoid calling wrmsrns() with a non-constant value in code paths wher=
e performance matters, even if it bloats the code somewhat=2E The main case=
 which I can think about that might actually matter is context-switching wi=
th perf enabled (also a good example for wanting to SERIALIZE or at least M=
FENCE or LFENCE after the batch write if they will have effects before retu=
rning to user space=2E) There is also of course the option of dynamically g=
enerating a code snippet if the list of MSRs is too dynamic=2E

