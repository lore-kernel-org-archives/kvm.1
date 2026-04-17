Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0552FB084
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776466322; cv=pass; b=GDZLcgyqXe7fd5DHFtwn+fPPJ9DJdxFka8Nbdxtx0v6J2Q5VODHr3ZCsbhbK1klLStCkFwOw4kHBPe9pLXll/fah46xdy4N7qFcfosU2WELclEtw78lqtdFHpy9SrQ2wM9YDv66Oiqwja8ORdFkpw5kB42L1kXEA8PKnI/KJ98I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776466322; c=relaxed/simple;
	bh=1HruGi7X4dU575hOmcU+Ynje9evD+aRUJzp7jhO7jY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhRCBKHRYRVk072VTPdpkfsXCS4VnoVlnE0nIXTLGAalke6IR9GGHY0v0jQxTsEpHecyMhmsLS7bhBvYyoJLaip/cNJ6Ajcd0XuEJSmB0ybtWhUil741i61o4JeG229AOmLM/IrcUwP7h+X6KrYLDEh8BKpUfaY1WjhM4zDYsag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2ux1W5v; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2ux1W5v"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so3255a12.0
        for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 15:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776466320; cv=none;
        d=google.com; s=arc-20240605;
        b=E5xH0CL+Wq/Jwh8ZRj2qcCBDK6KzWp9zlqK0D+alvtsxUmiwnMzp6wWMi/7+8sFBMr
         i9PS5wKrGUs/8ZmxNxsTX9A41H7kvOBq+NemNTxWPDo3TjNgx+A0/jDklZrC0ddCAx88
         L/um1eYiM4SeyzdcwcSEjJV4denOzlsFKNDS7RlTkLGHscsw5yNnPRaSMvc777TvdZdK
         FcyPjgcU5IB1CHRp93iwzCtqn+ui8drPH7YctRDFhZ4g87fGvabwcUIibJpC0cGPznoe
         rNF4N1G0oXrbL/MGsF5dBqaQJfcvmIq4FyRGxSpGcyxKa394GnSqq3eahf/b7C7n04JB
         YEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jkdtCAtP8odoPa0atr2MGvhK2NtLmBy28A7hTYzVBz0=;
        fh=c9aCfZaIruaoQaR7qRS5H1GPbROh+Bkw9/YIeVrCVK0=;
        b=dBrxvQpy4GyqXiFhPOwNieMNn6mr+5dCtO/iIQO29/OHq9K3Zw13BUjnqWxPrsTMB/
         nX/wUajipkx5JQHDCiCHQ6nNfscmZy6ZDazQjRACUN4/m4Fxo8paeyDZBSuv0pDZGsy4
         tVFo9dbUszzfLbq7RSudPcaIIZ5m0rNDhhj8CQNN3DdvBsMD6F9Ys/SKvdIGM946mDuN
         VGKz9h9Ljv3rk4HtctN5Hs59XQ9iKE+FjdutJUW2eRF3wNJhSUSsqde5OZPt95fqONwy
         cYdi2g56Ugl0mEfUTdSsCNI1IHD94JcmQj9i+AdrEfXMjRdVtfzNMDyXN/DyomeJtjxK
         /Uwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776466320; x=1777071120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkdtCAtP8odoPa0atr2MGvhK2NtLmBy28A7hTYzVBz0=;
        b=O2ux1W5vwmEMWphTHVOoiwrwPBOuR05XbMKJi8eLET2kBFjHJPh7zOIGmTwWGxbSkV
         /LhRcNboCVMWEutkmWGYi5n+K5O/pFGAjRZG8HgJltMXSybVQLIfoaD+ohMNi5Ty+cnc
         HwqLveM3WIa8gqXVO3eLPb9zDjz9s/VHAoEDs850DhsptWlpO4lsz5oBgq09M70OrXGq
         gVKGULaDiK8NdwwtxL0/yD9BB+z/WD1waD3Ef0H+qHHPcPA6TIDw9PuZ8GgiebJocfLJ
         yC/lzBOXF4PJmpOZFi/MK8EW4ZO4mo2dMskpq92ViXTIshTPRhWe2C9q4ZUu/BlpXHyS
         u97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776466320; x=1777071120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jkdtCAtP8odoPa0atr2MGvhK2NtLmBy28A7hTYzVBz0=;
        b=J7nixq4PADjnNa/GjxS4MtTRQsdPO+P1IJhH6RuAOD32kz6d0htumWChPxYrJYemG8
         xpmhKQdZqxJQXVkbUDIFz+di/VGBysSsk0LYHQzIBG0Q66p0H83RvAJRID597oUEC4Mu
         ZNFJdOpHIsG6JNOD9UvX1T3oXPbyeSW4HzAvL3GGyW4Wb+hvscdIWwvn2bp7T54yUFtl
         1t6eQuxg1jdUCN3tnCxASOqCvB7PhjuQY3Kk6yPJjNwZh8Bw/iSfTo1GjpLIO3WRrrNn
         jlUkormEGJOFn9VV0X5JwHSrC8UGBxdClMKidcWwD3SZJ+JPhfhtHBpygL2hJeeR+K9u
         MT3g==
X-Forwarded-Encrypted: i=1; AFNElJ9q+wJBOVQeeltNwqdSvz344AAqugs5EqUzJnNEV8LG/CDRY9KMifcNZXcQl4IHD9X2/UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN1fA24NK7FmjvsNVDnuMKr+xMihsYERwl69OEYNGkhp+EDmrH
	nsNqcF5BWnUEhub0lhM5qg9791T/D9aKaUaO5H5lg0QLD4MGdpyOsZDgELJHvDkxz0YkQ+J8p/q
	4OfFaX58qCRcQHjV4cXCdcZK+mr6usRa4hgNimxpK
X-Gm-Gg: AeBDieuB781sSJ0mght0Nj9Y9i61jMXIXRt2BzFDg/oNzXcWFEBswFp90BjzwKAnHwe
	XeDujj4IqIbZpBRFVphKAydBSza+kLwHS55ObRY/yZA1YQLLfJQEQ1xXqYf6zsjn/BOdWbmnVXL
	+kSTDbRILY+xzWLhaP0Dn0SxgOhNBCHKwx+ffhR5EajQgb9sMfdY1FqVN8pmKQ33uqaGq7vSYsS
	G+M6R6nNogw0O5xIsAso0BWhb4NFhzsu/z+GVTj4YKR8SQD69RyYBNZwB89wvlpHeD2IBu1m3Z1
	DS2VcQ/bSNU+QEqNR0hDwg2Cb2M7
X-Received: by 2002:a05:6402:3192:b0:673:9b15:39ff with SMTP id
 4fb4d7f45d1cf-6744ec68927mr6122a12.5.1776466319570; Fri, 17 Apr 2026 15:51:59
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com>
 <adfgPwgXz1iQHpVS@google.com> <CALMp9eRLpZtpmdH4LJGdNkFO_hdJFw0i9MS94Ou1_GKHADq13w@mail.gmail.com>
 <adfmVXRwzZkvRSnj@google.com> <CALMp9eTvH1Pg0Eb-KCcX7LLJPFgS1xTSR0DzeA8xo4Re7=p=7w@mail.gmail.com>
 <adfyKU5WUiW4OnUg@google.com> <adgYSnE-I1Z19fCY@google.com>
 <CALMp9eSjAoVYk2f_j=b_X=EngJ935J=W7YS-C0nDS7b1j2Y4Og@mail.gmail.com>
 <aeACk7T5Q4TxtRMF@google.com> <CALMp9eSHJmLLAQAvbvRmq99v568PGkJduoQn1djnXGb-yED_5g@mail.gmail.com>
 <aeAtdIPo-8uk8nvH@google.com>
In-Reply-To: <aeAtdIPo-8uk8nvH@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 17 Apr 2026 15:51:47 -0700
X-Gm-Features: AQROBzDHMrwUeMaZ0tQGcUGfm5IB4WAtEbo90cxI7V-K_7ct13-ad_GOY4mfqZg
Message-ID: <CALMp9eS5t16pgZY4PEwdWFqBCQUHMSQDtcAoC4cuPeq-SfWo+w@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 5:29=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Apr 15, 2026, Jim Mattson wrote:
> > On Wed, Apr 15, 2026 at 2:26=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > > On Thu, Apr 09, 2026, Jim Mattson wrote:
> > > > When would we use the deferred version? As far as the Intel PMU is
> > > > concerned. there's nothing special about a nested transition.
> > >
> > > Actually, outside of VMRUN=3D>#VMEXIT, isn't the deferred version cor=
rect?  E.g.
> > > when counting instructions, shouldn't WRMSR(EFER) be accounted based =
on the *old*
> > > EFER value, not the new EFER value?
> >
> > Unless you can point to documentation stating otherwise, I think this
> > needs testing. By analogy with VMRUN and #VMEXIT, accounting should be
> > based on the CPU state at instruction retirement.
>
> IMO, VMRUN and #VMEXIT are broken :-)
>
> But yeah, +1 to following what hardware does.  I was thinking we could lo=
ok at
> our KUT and selftests code, but AFAICT all of the precise measurements ar=
e
> bookended by WRMSRs, so an off-by-one on the frontend would be corrected =
by the
> off-by-one on the backend.

LOL! When EFER.SVME is clear, setting one or both of the G/H bits
disables the counter.

In the following code sequence, 10 instructions are retired, and 5
host-only instructions are retired:

mov    $0xc0000301,%ecx
mov    $0x3,%eax
xor    %edx,%edx
wrmsr
nopl   0x0(%rax,%rax,1)
mov    $0xc0000080,%ecx
mov    %ebx,%eax
mov    %r14d,%edx
wrmsr
nopl   0x0(%rax,%rax,1)
mov    $0xc0000301,%ecx
xor    %eax,%eax
xor    %edx,%edx
wrmsr

I think the first wrmsr counts (because the PGC bits are set when it
retires) and the last one does not (because the PGC bits are clear
when it retires). If so, then the second wrmsr (setting EFER.SVME)
counts in host mode.
