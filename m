Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042204503B
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323854; cv=pass; b=jFpZY9f40fu4TdVt0N3WmaXHT7HOyiFKX21lO6PE/Il86XH3swiyMYPWpVvSWj6MxFKfL11AdijWRWw+Z9CjmVZvm6AK6+TnGpC7uoGEwgXyNqd5Ti4Xc7vQVRHGWbIaVaZUhf+tQoQYy7Ap6SeusfuV/kxlr9Lbqijih70Fa6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323854; c=relaxed/simple;
	bh=e08EuhQW7pzOcYaJ548JslB8xHm80aFdGtESM8ZlF58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJND4MWr+ZEKqXXpMefsKOALM/JcdNULPpp85sb+/M8VfcxN8w1571/VVVnK5X4RknsF4v/tuhA4aSyLErgHdHEOfn0rLEErreKfLnUwsSeEPf509mjlcwXQISyHxK1Hv+R/12wfKetEGUFcxDXKv7Ojd1oKKqjc04j5DZfzOWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQ9705hJ; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQ9705hJ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6aae147ef9dso4549a12.0
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 14:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791323851; cv=none;
        d=google.com; s=arc-20260327;
        b=NP8mnGWUDAw969bmfZ3M9BfyGfRGkQazEtox+KNz8W/B5fUdniIvfui1CDgFfbUjhM
         5S/AyQTd0ywtOt46K3PFLLjL5VylL6NN4S/SvBJx5frq0TtYPGaOxh9dXhnuiZGb0h9u
         h9SlhFJXqePCcqMB9c3rQF45LIL0+/Jz8hYTnY3Se4FdhJBpzROmfAU6m51Eh/y9HAve
         tKC2sYWmC/Ol/+sLQtfCl+PH66b/wme25nOJlOy00+XOwQplTrGe5lsC1ZyRb6qsKpSj
         wXfKkoJG0wgVBXIESFg2592T2qSNZTneIzv17rT8lVRR/7DNgRODlEuQHS+nPPBkcr3c
         dIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jCcwO2LV+Ld2g/yJwpkwAsvl8IfvNX1pMTCUsDf1qHM=;
        fh=d2Gdetpnlfk1yFouEyIzNZKmCWxyW5/dGrsgSB/H/kI=;
        b=KCnFtt0L7r2Rwpku7F1DRekXXqBv+rTSmRoZqxKQKF0jkA3FxnsYbLoMCUnynPFUU1
         Z9YJdd10e7FV6jI2VnDXMDU6I3ysbOgTVG4zmb0HjxIbdtMLor7qd6Euumwrf8xAgjl7
         vrMeNu4rRavpHSLXh8bPjKs5YpiDaamV8Lki49I9SIcSSbsr2Ewop7Z5VwzKaUIIGzRR
         MjDFMZdeZGVQFur2eqwrksgRIFt8hdkIVKYwTNBxb6g81WMcjfK42uEkVL30r9wJ/XOZ
         IUom/iUwF8jXh5uJn2igZUQxynStJZT3PIGHx6zZJ0JyMUkCAwQzYmSPOYMtNk+3qNCw
         vThg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791323851; x=1791928651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jCcwO2LV+Ld2g/yJwpkwAsvl8IfvNX1pMTCUsDf1qHM=;
        b=eQ9705hJAkE7ySDjuMQAyrAM3oqMnmZob82tt6Su8LCyND5r7Of+mlg5t7UlzWAyAt
         rxrXLzYFGo+RE2/CYR6kmq815soMeIPdikAFtcRUxwK13uE39prHgnjiiwFrs1UtkIPU
         e3GMM/Qr4ZxNkrB0mrUfbNzd97eM8rlA1XKmkF59iCaSk4KhzLNGxkcjF+QvhQRnMz1k
         SDyKyP1Fs3C4bzG8KuC/pXNVabUFH0z1YUl4RjOzca1WXOAXdc9MoAgea/CBsAjOlrEL
         BfiZE1/YlLcYIRfyNsDjojJbq1AZiA1Rx5xAhec8f+MLa5J+HHTZJsHzMrzjZ4hcFJKK
         WUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791323851; x=1791928651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCcwO2LV+Ld2g/yJwpkwAsvl8IfvNX1pMTCUsDf1qHM=;
        b=j8Ei/7Y+0GMm2XymwlAC07486ZHAb+kqfP1gW3Aq0cCEgmIXW3gRls/MeVoAEs8d5d
         bkwS2+cjX8TgDCpzV3+M1fdB0+5Ojudgcv6zwPr3fLO7VBY65Bh4yubTxlxzlZw9UDUf
         NC/f3PTR3kUy0yZ5T/rQZD3I6YZWfP5eGktPE1FYmVfzWEAEgKLPn/Tjc/HYk51Qwjsp
         hvAEHfF0mnOXVeKfZNfnk/WDpUzRAoJa9Ol8DPrYBrLwAi3f8i0CoeVH0iKcvINJ/PUp
         n8tKJfOY+4RTQbjX3wxr+CKtJw+hmdw/LgnBu/2JnWvSl8PsHX9UhXE937yiilYTL6Os
         mqaQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2SIAJRPOnTfLmWNMDu6gWhy5/VwzMHr0/d0q1ZY6tSns+/PJYKcx8iWaXRgyCrG8TBBk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdIvc6a36mx/8BcqKrWRIDsjvW9HJlE/U2PAjp/SqK6CrdC2kJ
	R+hkEK/73bYIDfr2klxtbU5wE3wJky22gc81qtREgk5J1MBNCXcu3IkOdiXnPI8nlG+OegiUpS9
	laS67qWJrLvtazngjBJmVwXb6wjaw46d11DLL63LK
X-Gm-Gg: AYBFou1QjzKXXEGm+1N3hUCwh/96+NK0qi4yu+USgJDYNprAWtGcZHKAoP4SmyJX4HV
	E77BBl4Y1LDAEOJfQpgxkv3vte0LjFPNM1gXlnAZZ/o5Gv6Am26GOi/Tvm3h+0J7ys0s8tW9R5r
	J8GrsG1Lv4C0EE6UCEo9Ds1RSRAApeFWGv8/wtC4oYGey/XGtVLTXKaIqxKKNxNh+L9zQ7ZgSfZ
	QMCKT7JWIhrZr7oeN3h9ntpLZ4OU+b0gbtvKaEmbZUZs+BYoH5BDI8hmEGzoWpd98r9Aloivkyt
	pOt86pl3D6IvpkDsjkoV8yqkbm+8zWvnhIjCCkAnkXq+FR7HTJS41hI=
X-Received: by 2002:aa7:d5c2:0:b0:6aa:b72b:d762 with SMTP id
 4fb4d7f45d1cf-6afd8fe5331mr72366a12.1.1791323850737; Tue, 06 Oct 2026
 14:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com> <20260930173635.3362655-14-seanjc@google.com>
In-Reply-To: <20260930173635.3362655-14-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 6 Oct 2026 14:57:18 -0700
X-Gm-Features: AclHuK-juL2tOV8vJqtls9IgipFfKDGs-bJ8YWH9hKG05WoEYaaS7Uk5UU7yNdc
Message-ID: <CALMp9eS0=HgM02Ff4mv6RLHVoM3EgavhKu_P6J-oTWTMbk9zng@mail.gmail.com>
Subject: Re: [PATCH v3 13/21] KVM: selftests: Use KVM's reported TSC KHz as
 L0's frequency (sanity checked)
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 12:04=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Use KVM's reported default TSC frequency as L0's frequency instead of
> calibrating L0's frequency using RDTSC.  Trying to calibrate the frequenc=
y
> in userspace is all but guaranteed to be wildly inaccurate, e.g. due to
> interrupts, preemption, etc, and no known CPU supports TSC scaling withou=
t
> also having a constant TSC.  I.e. there's no need to calibrate the curren=
t
> frequency, as it should also be the same as KVM's default frequency.
>
> Opportunistically sanity check KVM's reported frequency against what is
> observed via RDTSC, e.g. so that KVM_GET_TSC_KHZ or platform issues show =
up
> much earlier in the test, before VMs get involved.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../kvm/x86/nested_tsc_scaling_test.c         | 25 +++++++++++++------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/=
tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> index d790ab36a198..a78585af0ffd 100644
> --- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> +++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> @@ -137,7 +137,7 @@ static void l1_guest_code(void *data)
>
>  static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_scale_factor, u64 l=
2_scale_factor)
>  {
> -       u64 tsc_khz, l1_tsc_freq, l2_tsc_freq;
> +       u64 l1_tsc_freq, l2_tsc_freq;
>         struct kvm_vcpu *vcpu;
>         struct kvm_vm *vm;
>         gva_t guest_gva;
> @@ -159,11 +159,8 @@ static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1=
_scale_factor, u64 l2_scale_
>
>         vcpu_args_set(vcpu, 1, guest_gva);
>
> -       tsc_khz =3D __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
> -       TEST_ASSERT(tsc_khz !=3D -1, "vcpu ioctl KVM_GET_TSC_KHZ failed")=
;
> -
>         /* scale down L1's TSC frequency */
> -       vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *) (tsc_khz / l1_scale_fa=
ctor));
> +       vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *) (l0_tsc_freq / l1_scal=
e_factor));

Our internal Sashiko complains:

[Severity: Medium]
Is l0_tsc_freq passed to KVM_SET_TSC_KHZ in Hz rather than KHz?

In main(), l0_tsc_freq is calculated in Hz by multiplying the KVM_GET_TSC_K=
HZ
result by 1000. Passing this value divided by l1_scale_factor into
KVM_SET_TSC_KHZ configures the guest TSC frequency 1000x larger than
intended, since the ioctl expects a value in KHz.

I concur.
