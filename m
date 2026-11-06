Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793926401;
	b=s4ZfBh9GDQLiDZurwfHaGxTXo9Wqd5YOvGJiuAH7rZlsZlN1YRXobRcWHL7PfLL1SuuN
	 jbVOtYygHIFLMawFRKFYp8/1is4RY2s7tHzkg+T2NXKJvgUlVSqA2NYXrWkPyFxz6TU0I
	 DUYqMSi7xjv3JQJudNEPPxhPvGTRQ9kYAPEk0TI9dCnf6zfVwGVZdJ0bxKBJnYGTqMyzF
	 EMUvjb+1pRd3VVuGYB3lb/o7SH49S907+kt/kCvIWaPTH1S6poxSTFzC42kd7sEOvaYei
	 rguLjDo1btKBPR2VRD12l8240wY6r6y3r97JepRmm2FKN6vZZL8Yypo001ZXQYA0Qfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z8p0bYiVFuNX4OfWuZZ4sxGIKahg/FfKszGkM4uD0Nw=;
	b=g6gTFbPJCwttoNKuaDRymo/NOBFGRCOZQA6vfdqNH9e6UnCWeDjGvZ13zgX+hyld/a0T
	 a7d/xs3Z8FcyggHW2K+u7AEaCHnfbA4r9dnDrzhf98DAmULlfPoKzyjYHZcU3J2+aLSFt
	 I3Mq0wZTmt8GM//8A4r/vX1WMEl7IiPG4kVHeMaDqkNjIz8aHQ+qKvisqi3f+Xh+stP7A
	 DpeRpPKPtWOKyGpMUT8ergYHG0UEkwTsdhsLhV+ffs9A3u5y9r4eI2MGi38d33+eoh3Wf
	 mmJfXyBDMikGICgqAI2Te7LFYARKJY1zlMTpjMz52goXVbtDN5OyHJ1qdT6ylatbPlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GUqyc+PE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B8E606A31B
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 00:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53B8E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GUqyc+PE
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso500a12.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 16:53:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793926400; cv=none;
        d=google.com; s=arc-20260327;
        b=in5LjiSNMtbGvXIYdCspPqCOgDgX/D9Ds3zMfEtLray7GQlbGqnra4eeyqkn9fn8HD
         BGEE1jr4n75o6wWVwdxYOq6xlk1bRvmtAsZUmu3+RkEjvFb3Yl4WkPsmj8BZNz6wiJek
         CBsih2aLZw3x82Ur+D+nd0R0dHVbrE6cdPLqBcqSpxOLxBQjgtuteqE+vJtpdKGup298
         ey2NmKKqMvd8ytjB6dnTkX8Gdy4IhMVrThSizXAiDdvcKnCvD6h5rbhV61x8tIRAW4Y3
         Y58L5Lm0YapnDKZ5ekEwKGZ4E+aeiYaOwk07OEERlJ7M99IkHZg+Ht4jXDDZiltra3ai
         ObRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z8p0bYiVFuNX4OfWuZZ4sxGIKahg/FfKszGkM4uD0Nw=;
        fh=omjsYmBXFGZCHkRuJVE1jgUTt92ubw13QJ3Ln2zaSYg=;
        b=bpeIg8Mio6H+SSIrZXRrKAjnq58CL3kWlco/Euvz+Kl1l2oPWosIXtKo+SkBJLkw2Z
         7utMREWWeAWX8SFEEcs0/dkAJi6b4ifLparbAcCOZQJw66PiDDkHR7v/XvLu59DzseJx
         vqbXEPKzgLA4J5cTewtvwJ5p+cR3zQ/uU0PiofaCMCkssvN+AQDdUAsm1ciiXeYdug4G
         dKuXh8CYcGfVPS9v5Qo2kVJsfF24lhOfGBhmIM0vnvSQF+aOyPkakUVn62jUBHMM7Z3e
         BSoUMTH0ZlUZPr6zu2ArhA0cCSey6zYasAo5tfv/uDVzLWN5tml4hCzTEa9ks6WKSSLE
         +Zsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793926400; x=1794531200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z8p0bYiVFuNX4OfWuZZ4sxGIKahg/FfKszGkM4uD0Nw=;
        b=GUqyc+PESPCRisgfCD13AQ7e7emdlghEExujUKLxIzHKpk7z8xfI355RoaQ98hWyFx
         3zBlPq0nR9JmXHRICZ1bnume/4epEI7ZVtuV/F1SO/xrRVZ+9BDYtYnQk8HQ2LVvpOoT
         r/BgrjpNJ5qItxjhpwcpk9HEzjBmEA7Gkl6a/Uxly3M3m0S+FjccWTituF0CYyEFArTs
         kTSMMjKymJHXUInedhlDjwvbGAn4dGFn1c1zRdXqldKyOcSqKarcJQtBwCeW46oprKo7
         Qpra3klJ8pd9WPVTdtl+wcwamc1Jat4kuD6yoGcFuc6ZQmOJadbDl2uHXpt6suIAe/+4
         FP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793926400; x=1794531200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8p0bYiVFuNX4OfWuZZ4sxGIKahg/FfKszGkM4uD0Nw=;
        b=I8lWbGctPStCgiB63p2iDGBrLTp2FevL63hQae6ZTiQbjOVyTUjWnY/C+HnDUkbm28
         DAu62C+Nv0RhdjT7WWhxuNYgj4UgMSwLeaHwPgn0t/sKbVqmmGWNSAZDCba+XuGGAFJ3
         tKZMgu4GQR3xvKdu1wGF+d+YfcVxFRKuAX4oaKbDhlcIAQuTzIAjTPIgYDJvDmFfNVem
         C07MGyFsVXHcLUzuhCPqH62UXgoVEWyWwSp5ey/RGmjNpwXEkGw4V0eyy9edpnrtxXna
         BFEbN/o0bwQPZkenBqnjWFPs+kgSp4MElgWmPyxJs3C50WoKSvYXFRir4h/CgUZcLVKA
         OC2A==
X-Forwarded-Encrypted: i=1; AKwUvByLEi9MgFW+ul7TpKtT2kQmTuuabWpLsGfxHbRurSDTeVnVXP5muGuxhZjGDNFHcd9zR+8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gBrPDVc7ZuYO9Psk3pTWRIvyijLDUiCihSP0v4d4+QrJ8tyft
	qlUbebu03MHxStEUqa/JqmOO2agCHway0ys85vpbvsdIH5REnnf70rmV6vVbNg25jMNp71X3Z2L
	ekiwGLH2ZW0KNW51KconnIagESjAlwCWTnX80GsKF
X-Gm-Gg: AYBFou3BsTyUO4krUi0lMFZzFbErGpW5NVi8j38ykq54Wczkf7pPw3sN569DVzyz3LP
	HVDJoFnelWPPgILGZGVK0A3/i0RN3Tf6sgETHELtkQvf/Ta760v3tBKSWQzYEExWLb1p6RgLWhJ
	Y5MOm5+0/iIrEcGNHL27RwE8FvMi9N24TGE3eUsyhXg+O762N0X56chO1yj7BVOjnTikGH8sc4I
	qsr0oI92Y7Z6lKy2ZvlkI/cFPWlker0w1Ruw/gWl/RtM4csHCAVThhlIma+P6d8gV3tPpr7XAyG
	vYsiQ5jORaPaoFja+Us6ei2+OPprkO79K6ed32vxIX49eR+YDh9ncRmnY2pFZ1CT8NGRb4tg5QD
	2C0EXN0nWESAd6v8JcaYWmDB7o5BPmh3B+CFSyqFZrKl1xdjk4VfpwHBsmv5AFjR0fQLBm1f0rr
	HcYX7eJOuedq4q42R3zJLI8EbkGvZ6ilFHL2ek5xfqfN+/MQ==
X-Received: by 2002:aa7:d44c:0:b0:6b1:d80d:396b with SMTP id
 4fb4d7f45d1cf-6b5d53d5c2fmr27678a12.14.1793926399217; Thu, 05 Nov 2026
 16:53:19 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-10-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-10-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 16:53:07 -0800
X-Gm-Features: AclHuK_SEF5elS3aU0BqmAvaeLUrXA4HaQU5I3YL53_AQiNGQtbuBTA-Tt14aoU
Message-ID: <CALMp9eQ2TbHZ1xzsDq+TfFTfaJf5wHMk9g1fM0aWRhJsE=sgOQ@mail.gmail.com>
Subject: Re: [PATCH v8 09/20] KVM: nVMX: Propagate extended instruction information
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com, 
	Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:37=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Define the new extended_instruction_info field in struct vmcs12 and
> propagate it to nested VMX. Gate the propagation on the guest APX
> enumeration, which aligns with bare metal behavior. Thus, define the
> CPUID bit here too.
>
> Suggested-by: Chao Gao <chao.gao@intel.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Link: https://lore.kernel.org/aRvOSnaUt1E+%2FpkC@intel.com
> ---

[ ... ]

> diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
> index 1ebe67c384ad..267aa64f005e 100644
> --- a/arch/x86/kvm/vmx/vmcs12.c
> +++ b/arch/x86/kvm/vmx/vmcs12.c
> @@ -53,6 +53,7 @@ static const u16 kvm_supported_vmcs12_field_offsets[] _=
_initconst =3D {
>         FIELD64(XSS_EXIT_BITMAP, xss_exit_bitmap),
>         FIELD64(ENCLS_EXITING_BITMAP, encls_exiting_bitmap),
>         FIELD64(GUEST_PHYSICAL_ADDRESS, guest_physical_address),
> +       FIELD64(EXTENDED_INSTRUCTION_INFO, extended_instruction_info),

You need to add a case for VMCS12_CASE64(EXTENDED_INSTRUCTION_INFO) to
cpu_has_vmcs12_field().
