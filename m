Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6845637C92B
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158811; cv=pass; b=C62ST+KBRc6RozfPR1yuUfRH3pMvCcxtMkaZQvNKUKlUPFEDhb5ou8uc2fGjXsSdjTcpEgYKY68pFPaRnE6ebXPQWzh+QYl2T1bNTq5aYpngugfQGYiOt0nbzsj7eawam4PZOk45p3MGvGXPUA1d+Dj/ST0bnjzJ+CeLZtYb2MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158811; c=relaxed/simple;
	bh=US2V7kzwHw+XpVhDyUggsFAHRpyi5Z5kvJJ43HbFkRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsnAwuu3f9bT+xHs9fXxFrTtTdKpAOONjG/B/e58HiJN1dAlOnYylktXMUr6uGvI/iaNcYpEM6y+vvTk5nz+pn1/EGpvmwFUAaAz65qgcLpXr+J2kSXu/SD44Vcb1EULRrqnsyUrdMCDdh6G4ukuda+4pgg0mfXAdVQg8SlBOmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+Wc1N8g; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+Wc1N8g"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66bb7118c96so2988a12.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 12:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775158809; cv=none;
        d=google.com; s=arc-20240605;
        b=OoAWZk9fAoNG1S8ur+zgMwpk7OzF18WIDYqcaUMIbktfFMls8lF5IFIms2fp3fvfZ0
         t9zpxHMeSisdGy9622kZVmBIpg9G6Z/G2KW+2rid2rHX7TCzydm9yflZECXJt8Uszu7u
         9xBn3zuiyhvK1SvhhgjsQzeriFSkkSTno5suJTTrwWo7WBZTmkOE+obpOerSc6Aq7uus
         y4ALg/Ei0NA+cDWk54Ld5olA1Qh9JSTJhNwwjEZ1Y+XBN7E4DuIrjJ+OmQ2+F8A00zkS
         +f7PYB0g1TMuC125KErX5R+Mqt5/17AyXz2yth81Yg8Yp7rJVQdxBW5XXycFHrsJbxDU
         760w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J0DvflLdp3i7a17ynT3a78GmDFDn7qbQSpDZ8abq9cA=;
        fh=mlx9menZcKS4V1irhWL9IVUSJDQMaWnX87XtlXDyoLA=;
        b=hpjLcRx6HyOo5UuSseGuhJIignlLHjD+I81AKNtzJbd2KBIj7BvpJWVfnB96d12Ye2
         529IBzWBCXO9Z29IAR5b2ckf59NzvcWpfdR85sRnPEKn88qI6zlZ1ZHFgRAwA0h/E3EM
         SmBEhlKpwRBXMr763nu13FzbvUOUHYoAI8nMaj+JdbO0h1clNgsNisBdV/cvG7/C2662
         v1Qybz/tSHr3fA3zraKGTYMUbYdCba0u7vm4TqqUECj4Gg0VXH1KjMWlfDsmowIjafZ/
         BwbPHsVYXHHuRijpkjOT8PGzGjlBn3F7tqheMGJhQJQ1gWMOytf1lNE+/XhS4TLlQtyi
         eELg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775158809; x=1775763609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0DvflLdp3i7a17ynT3a78GmDFDn7qbQSpDZ8abq9cA=;
        b=Z+Wc1N8gFdHRRaTj4eCm1Vdd+8m71jgh+a/eRMZKAkXD05ZWd+1ezgQ4peeqABToHi
         p3hn1BF/wNmKvy0/Ho9Vtmx10Yjna4fouN4cxibja4dMIpVm/lARlT59/RvdAWG9OOxJ
         v9uONRDeERj3QVAi5frZwvpNdkTLO5YM/MXcbdU0YWdcVlp0ka3P1uZwFlxa5clsoViG
         kdSEi00rAX2QWbXX+xg8FDQ88TQYTOzktjH4LOJBqty87GKGF01jRyphDX7rlOOo2MKV
         ym1EHGKXjC1XOditNR23aN/rA3Dpj4b8WErLS4SugPUxYh0ilgtow/l12XpAV2luuSfO
         iX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775158809; x=1775763609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J0DvflLdp3i7a17ynT3a78GmDFDn7qbQSpDZ8abq9cA=;
        b=HnFLCjNmAZ8DprGwcjyKUj7tSkkojPgwq5fpTtPHZwFhNmrG9k7GkMqTMT6p1c450a
         KqZOmtBmAjouAI/7Aor4z+vARgVGfAPIR58z8GhspmH3ZbGhQcxg1ZJjAg9vhFP8G2XS
         kBrmXsaN6sgjIJ3I9TOxZ6kV64q/hZ6SUPcsh5ppnDrRHrbIl29z6A0mod4UzKi3qlPW
         c79IuzEB+5vSP3wJRavBWhui/3bACHoDQUAkhKvDmmjVJ6Me7pgxHvtb5qv59jE/xxx7
         VPvwGqbvO7ArntdfqOMSnJwlpyKUbaDQepYTkIiNhHjmmbsof1oKqF9dzkldG4YgnLDt
         oeVw==
X-Forwarded-Encrypted: i=1; AJvYcCWQeBtZeureSr09bgaTGqWgm4AIDGbkCevZzll4kU2Aq6HD0GN/Kejg0wOmyTcly/Ine9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWlsdIW4hOtPblLdN+a9T9Vh//oe8zWWYmad4+oT2IWTaoe/I
	qbPe2VC+wWsYp8qWU0rfmIYLbo7hjszwFANxAgj7uwaHir2Ar88ftplPch3+SoBj6hChjRFem4/
	KFSacnp/fBp9v+S1AHZV2cdRJ75yZl1a/G0Lm1PMR
X-Gm-Gg: AeBDieulL8ypWeuKYaUkC8o43vmuY9qks1GAU721/FyAePydE/Q3D+2wOfW5UJBkktS
	ScdjkeS+W6XrTl2Ro/fud9AKWlaf9O3GG+EqaPgkkUaV4cagEgSQ3TT1RBig4nKS3w0QeKRhPlX
	W/zItBPMYxsIHh9NQoZOwq/xCyfEEsTuXScEtIO6AWcVhbcxXl18Y0SdYDuNeoqLWC055vT05iz
	8/Qhz/3iOPyDU9DCid55ixvNyBtU5nMNsK7beHNOqN+z1KtAVoSKMm7mT6xWbN9OE1mI9xvHD+2
	JqOsBhw=
X-Received: by 2002:a05:6402:4588:b0:66b:9469:a0f1 with SMTP id
 4fb4d7f45d1cf-66e41481095mr1730a12.14.1775158808171; Thu, 02 Apr 2026
 12:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327234023.2659476-2-jmattson@google.com> <202603301501.N2sdlIQ9-lkp@intel.com>
In-Reply-To: <202603301501.N2sdlIQ9-lkp@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 2 Apr 2026 12:39:54 -0700
X-Gm-Features: AQROBzAy_EbHuWlN5wT5_Opuw5NUyxR9m0jIc3ZzushJ6pVsut7GdsF_uvQSOn8
Message-ID: <CALMp9eSO6gz4R0f1S=E-sA3YE8KE0uJ30otcGsMV1NS3ujUcNA@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
To: kernel test robot <lkp@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 12:50=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Jim,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 3d6cdcc8883b5726513d245eef0e91cabfc397f7]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jim-Mattson/KVM-x8=
6-Define-KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT/20260328-110805
> base:   3d6cdcc8883b5726513d245eef0e91cabfc397f7
> patch link:    https://lore.kernel.org/r/20260327234023.2659476-2-jmattso=
n%40google.com
> patch subject: [PATCH v7 1/9] KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_S=
HARED_PAT
> config: x86_64-randconfig-016-20260330 (https://download.01.org/0day-ci/a=
rchive/20260330/202603301501.N2sdlIQ9-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260330/202603301501.N2sdlIQ9-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603301501.N2sdlIQ9-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/x86/kvm/svm/svm_onhyperv.c:11:
>    arch/x86/kvm/svm/svm.h: In function 'l2_has_separate_pat':
> >> arch/x86/kvm/svm/svm.h:626:18: error: implicit declaration of function=
 'kvm_check_has_quirk'; did you mean 'kvm_check_request'? [-Wimplicit-funct=
ion-declaration]
>      626 |                 !kvm_check_has_quirk(svm->vcpu.kvm,
>          |                  ^~~~~~~~~~~~~~~~~~~
>          |                  kvm_check_request
>    In file included from arch/x86/kvm/svm/svm_ops.h:7,
>                     from arch/x86/kvm/svm/svm_onhyperv.c:12:
>    arch/x86/kvm/x86.h: At top level:
> >> arch/x86/kvm/x86.h:429:20: error: conflicting types for 'kvm_check_has=
_quirk'; have 'bool(struct kvm *, u64)' {aka '_Bool(struct kvm *, long long=
 unsigned int)'}
>      429 | static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 qu=
irk)
>          |                    ^~~~~~~~~~~~~~~~~~~
>    arch/x86/kvm/svm/svm.h:626:18: note: previous implicit declaration of =
'kvm_check_has_quirk' with type 'int()'
>      626 |                 !kvm_check_has_quirk(svm->vcpu.kvm,
>          |                  ^~~~~~~~~~~~~~~~~~~
> --

It looks like svm.h should include x86.h.

Sean: Do you want me to send a new series?
