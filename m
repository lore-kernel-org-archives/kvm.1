Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795127418;
	b=Q8t7fLxQzNAvWjFqQHdtDzItRL8M5qFq+RZep4au5TwXN6nVyc9qGWJ54q8GWySe+drg
	 z5RbkvbZMX1anzv/FMx/dsE+AUlkwBviNy58a143hK19cA90TxYV8GzvUatFo6WCiJdMT
	 rBCi3TkXlkolzfH7mWqMMkyU+fRb5/BQvHT66n/+JXMvVJRG2LEIXNjeD1SxZF1oqCk0P
	 rhvlfdmgDTRcyYl5fA9rbIEzGAFigILopzzf4MSN8r5UW0nZJ3o28hT7ZhXkxYBGyfWMz
	 r9rdFLGe3//g+TRHvGu2gfZlP89ENiuxmdldGZg22XYjxGhesPEQJ6InsuQpL7uP++Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5A6h2+MBLnhrrhUhH+f2KFMN1UGH7u4zFbI2kpKjwJw=;
	b=hCSK3lkjv1VTG32hY/wUccIxFgnPIyYPs4GGHUZL4+LdfNxbWmTKJNU1Q5U0Nnr6GmnD
	 8lgAJFmaQwiLBdz4Js1iNXsoFcr+wP2PC2aL305KvZ9GM+ho0iV+Qn1y/Ajid1YJ4agXN
	 xQQdihNnWb3IxE8aTO0mx5kSmUR9K9vm/hXWnFSeEjXHc7heDHwFCSWKRAeIsh1QGMqUZ
	 yHXKxkRurD0pgd2d5VCSltGLqMZvUjPLecMXGtXONL3QEVkO8ZU6osSye9WaaQrtYMcT1
	 N5Ma3/x4Sj1ErnJDFnSp2c3Ws6GK2CCOnhTXSDRJdr15PwIObphJLgkNTvz2TSiP3Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iNeFIXPm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2024606A320
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 22:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2024606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iNeFIXPm
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b71ee00f0dso1582a12.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 14:30:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795127416; cv=none;
        d=google.com; s=arc-20260327;
        b=HxU8YZowItw5bFJQfqSB4PdzV1dmwz2FcKlnjSCMOUNm6cNaEwDFZeyKws7+yHuBDW
         7gQO1sCsWtK8iTlg2SnANW3zVelmcoTuOBgBem8idzfyzpmwENehlXJDyOLpORwvfyzr
         Z38QbU4nTJEWhGcNUVTQie5BFk/lJEw8MvirmFl527mQRVFuKajZETG1e1pI/3py0hsl
         CjYxO2drEvfcrnS6ofW7QeyIf0tBh0cIFanpLASgKjiOPr/0dmIK+SFPACkl90aRvXC5
         2phG+H2wufQSgS/X9JlfMeWkiV4GI0dRgqYyA+n+AaxPrV7c9tbXi3FJbqPVCWlXKpix
         T3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5A6h2+MBLnhrrhUhH+f2KFMN1UGH7u4zFbI2kpKjwJw=;
        fh=SzFIoEdOppr0KDLYDfoQBznEIFvwSIqEEBUvTJZX/io=;
        b=dcm0tVxk1I24xlhOoE+HUptudkQ9vRyFflnLxgoou1AVjx2fUD0Dd59+hnO9S9ff9p
         M9Ict1NPATWqL6ZgJ8PJBwfCOenRazELrvwwUdnEdCzbzpDqh8p4G5ZUNXDUVysRjQPx
         1BvOyG7eBKqH+3p2Hb9HSa5u/RvtylkwnFerp6r+2vF/sJcruUalA3HpNbDTynqwlnlM
         cUcB7ajkuomfMRHfVC7T6pgyNS6rJ1NzReRm4cDaV6v4u9vkCmzYBzVki6GXxMvzpcqv
         jESjtBbhPatES8Qrh8/eMieZLAdxBxNd+yW7IE8MsTdGJq/IL6FYEvLdBaMkrYK/pG7/
         9CQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795127416; x=1795732216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5A6h2+MBLnhrrhUhH+f2KFMN1UGH7u4zFbI2kpKjwJw=;
        b=iNeFIXPmVuzoUGuYB0+JmPLp51BoBmelppWd0Ho0aHKXcQTeWaGA60ZzDD3HcC5Ywh
         Sj9U5FwvxSgLrwHRDO6tXK1tcJ/rlmR20qSExMBU0YCVEjAfkIAe8FmrhvYoq1baI7Sh
         P0RSZFkCKw3oj+cM8ZVtep+mg3prlgzVrKcouv1MnXQCiPCbAMuvF5IaqET+UXvOnQxz
         Q0vKzveFgJ+gL+2jzZOoF/pejSZrD96zOSBAwsbiUu1iaOGlr2F4kGORs4Y9hW6ubZbz
         pkRDu5idvC9YRiejDYBe37DnrIE0mugWT6BpXSYmDf0urs4WS4nciXJOuI9YH56tQV7c
         EjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795127416; x=1795732216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5A6h2+MBLnhrrhUhH+f2KFMN1UGH7u4zFbI2kpKjwJw=;
        b=djlSiJJJt0nhQhTMcS5gKuk/UIingI2EVRj5BDlaraenCF5lfFfnfGWLtxhREtRkyv
         yY0vXo9052QboUC0X6GW9ny945lQW7+4k9pfMhfZO4ydYlRbgG5wqg9dgNgcxZwZRIym
         4Tf9+Sa/4Wvd/AB1EhQJZ8ShMqZEhWWCFJ0xIEbIs5+TYIumQKiDqYuHdNzSvliMJHCf
         vr2KxIUSHLw2cG/ZNp0FAB5KZ0vedZSGzpQtCnfE4qqexnfJVax7OEPj+2VbhHyNWtRn
         y/K0O2Qk+UwGV+fw/KRsDNaAC5/JHaiI0fXkC6ke2JZtagfEjd9CpCViPlaGM+l/Gu6Q
         aTSg==
X-Forwarded-Encrypted: i=1; AL+hErGqYoviomG9g5gPbO7W9/rJmBzYM/oX0wAHkosNm80twOoyifxrzEzzBEFcUnk3zQn7Uaw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dMb3nj68KVRjbViyJwKwE3SosArfZzX1Aq9yObXbZlTF3gqsL
	yjKaV0dkLCw66ztI8omKzdKZIeFM5N52JFD2A5IY8CvDvs5B4u8398ne1xE1MrZRkX9eoo0fNab
	t+Jt36cC+awL6pvBoZt6Gafox2XB27CLg2CPMe/oYsw81r2M3XaNjRLP4gEo=
X-Gm-Gg: AZFdTZdjXWoN/EdfmUrly5Rqw2MRjn3Vv1wwA3huEmNmxHCOHdJ7cOj5fCrmO68P9mC
	1A2UL2Ni0wnjtUfnMfHqLAB4whYmXbA+CRfwX464dQWYCrJa6S2qG3Src/OMPqCqMKXi9iV6UUV
	3/fSF8NEF7EvCKGxW/kicW/FdbI7CmaRN3zXLUFrb21+8mLz5n/sGfleHUbuamviVqAur/XDqm3
	zRrwqf+1rGm8fx0enpHgn/s/tTTfo34gIGltk6vy0fewi3odVdZ5ssT5lz/UUyUSTL/U5bqE3v5
	Gv1kXUlajeRPUSCrgPmPUZ/txKfrW6d5Nm4sn1ccZGwDpK6mXilzb6etSfo2cTIA3Q//IO4BCef
	VLARe0F4vOzynIW1hcJqlfvZOWeRur31dFctn2Xsh2HWg3MEtJniKN5usnRHUY2Of4JcZLC3wTR
	EMWvFd1MHjLUk2x2tzCyqilDLCs0Jem6hdIj8nykIq05Tx5CoFT5YQrQ==
X-Received: by 2002:a05:6402:c522:20b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6ba413f0ff5mr10216a12.15.1795127415737; Thu, 19 Nov 2026
 14:30:15 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com> <20261019210532.378628-11-shivansh.dhiman@amd.com>
In-Reply-To: <20261019210532.378628-11-shivansh.dhiman@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 19 Nov 2026 14:30:03 -0800
X-Gm-Features: Aa3M54qsLoRZTc452G96ErWYvtt96wWlw7wb2uvEac3se3Klhy2tTf3OL8kk824
Message-ID: <CALMp9eRVB4gYMgjmTj4Hh4fo6VY+6_SWHrRYXcA1QLrtCkf-eg@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] KVM: nSVM: Pass through LBRv2 MSRs to L2
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:08=E2=80=AFPM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
>
> Add the LBRv2 MSRs to merge_msrs[] so that their MSRPM bits are merged
> into msrpm02, letting L2 access them without taking a VM-Exit. Grow the
> merge offsets array to 12, as needed by 32-bit kernels where each offset
> covers 16 MSRs rather than 32.
>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---
>
> Changes in v2:
> * New patch.
>
> ---
>  arch/x86/kvm/svm/nested.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index b356a091e320..84154f353935 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -209,7 +209,7 @@ void nested_vmcb02_recalc_intercepts(struct vcpu_svm =
*svm)
>   * Hardcode the capacity of the array based on the maximum number of _of=
fsets_.
>   * MSRs are batched together, so there are fewer offsets than MSRs.
>   */
> -static int nested_svm_msrpm_merge_offsets[10] __ro_after_init;
> +static int nested_svm_msrpm_merge_offsets[12] __ro_after_init;
>  static int nested_svm_nr_msrpm_merge_offsets __ro_after_init;
>  typedef unsigned long nsvm_msrpm_merge_t;
>
> @@ -253,6 +253,27 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
>                 MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
>                 MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
>                 MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
> +
> +               MSR_AMD_DBG_EXTN_CFG,
> +               MSR_AMD64_LBR_SELECT,

Why add MSR_AMD_DBG_EXTN_CFG here? L0 only disables interception of
MSR_AMD_DBG_EXTN_CFG for SEV-ES guests, which don't support nested
SVM.
