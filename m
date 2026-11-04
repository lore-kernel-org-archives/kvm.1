Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793836192;
	b=eACWpaN9P+A0vIHBqYwwHx7RA53jCweRwkJ3+wEXEHF9nss541+5o/LMW0g/e9f1rHOY
	 ofth8neDt7tGHE0R7qHgK2e06lHSa4nr2nxcsBRc5IjRZXV8TCHxX+HIP0r1U3UWbMQO3
	 jryzmnz6GQbWh3QQ47BO+c+s/21890UWhd05ufYIDqyyU09O47elyFrVCPI/6zovETtps
	 BkkykXS95jlqhTyffED2iI40GYdPtZMRZ06J0owxxZbjTbKJxGqX9HCrHcTIGsIW4D2PU
	 28A2Uw2thziP3ppL8P+BQiGReyLGQWi+HfcCM6LlrfAX+0flV/3S6xFq1sfdVrSwzSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NUKXnf2zRVnphDvWIJPgNPk0+Yxezthn/bgjikrOQVU=;
	b=H/dje+dcUUs3pnDIgVdgnLKFM9x2lk62Ng6PYrqku37yhMerD450aut6TVKTNCQjD7Rd
	 4pYaw641Oz0V8P+yrvXLzV6W7xwFmtxRtzhdSHyDM6h9W9wa7RwWFzb9ICcWqdhmFvF4x
	 2vs/9k7BriONJPOLioEhoXKhwEi/AsqXycEku/Fj/TuYsDwS4yzzjHpSlrlVSCWlDdtyn
	 aZsUtm11HtnEdlo+UcTtdAR5pwLj0hfgVpst5xXhiQ0CgT/j9ThjYQXXz1SJjOF2yfOYE
	 66xl+AzIQk6Ny7k326eKa8GR9MRptSUK8+58VMb3KCnzqSk7XGcuTEonYfXfNeG5W8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LOCKWL1w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5887606A337
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 23:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5887606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LOCKWL1w
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2461a12.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 15:49:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793836190; cv=none;
        d=google.com; s=arc-20260327;
        b=VDUNHL5cXlgbATdqef7rmzBl5LalK66boI9umLO+DGe5QiRosZCX4Z1m8yi+Tk90qy
         bHBaudNLMMxCI4mAnLC7BjjmeQXdkF8ZPwReLltZB70XS7z7/tydpRTuG7gniuAp1OuW
         hycjOSF5GAcLIbrekAQK/FbEJo5078kNzmLq4IlQ7MSbeAdR78hF6PAqz1SCYP3vS54v
         RAjR6zRXqZwc6ZYVWl4Gmo4OeCcrbhymxe11GlmLaxVMenPdjkSY6lwpaVJOZlTRuWco
         gCeTto8kz0ADyic9cXKk3ZLmwSpS4G3TETXbQQRKUGBms2sl/4rx9n7GVTua5VoNDpAD
         KAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NUKXnf2zRVnphDvWIJPgNPk0+Yxezthn/bgjikrOQVU=;
        fh=Zx+7n7npImzgkbk5wPUA1uAKZHKLr2rkbnboHG/HjuU=;
        b=IeDP1CO0WuJ8Ohf9PByVd4DAZ6+mfvHyz1jgPTg3nwKAc75TlbmJim8TQ5M1ll+//2
         dYWv9gB0R0RfZoKQar2PCAAnxmQbnoFOAQJGlEcKq+EEx894XdeUBtWscift+5oBbWz/
         KimbpW15Nb9SYJ6df9csVXf83S/IBmb04gwe3fwbewafmrVTpCgfqLk8I/ATwkQe7sfP
         fVJAMHU7WFq6GHe3pfdzafVOEvavHPS5oeGwAxEEjW1ARKa3BKWDa/DnNcJ40L+ANudF
         bTOo8ohN4UeWBDlXpfzEXr62w4Mi1+UL1kRxsxMXX42xjOA/87lxu3LzJo/6X1TxvpH0
         MLtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793836190; x=1794440990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NUKXnf2zRVnphDvWIJPgNPk0+Yxezthn/bgjikrOQVU=;
        b=LOCKWL1wvKSW1uuETVBSc+7qqp1PzGIzHAP+Uros1fuOIBAPEzBSwpC0UJ+I1tzFVX
         f+gD9FJI+nKStfEI775giljQXjuR5F1aCTV/9gG71Dxtz/dNG9MddBnSJRJWFTC8pA1u
         KsWWbOC32wZ1UHU0b7SVXbxwcH7M6CDM38v0UUeeF30VT7eGffugx7+gw6qupZcATfOU
         crQGq8b5f8m5gVJt8wY/OMfA0BeZzHLvzdNvTvFOmCj5xJrQpWC4gJZK5rg6XLWD39y6
         fgfK6Uah7rxjWM1xdj2/wGOtdElIqqEGxTGfOs+5FFTJhcNXih9IYUmo1ffThwpLZS9C
         nEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836190; x=1794440990;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NUKXnf2zRVnphDvWIJPgNPk0+Yxezthn/bgjikrOQVU=;
        b=QkW8Pby8pXNplo8a9m0K+VcsfvZoMbyPplaOsGDSXc9cUYEKDSW2IW1ihY1CY/vIvE
         /ef8SVO1dd1EmmRaUcrMFDc6Xjq6eSl5sR/wtCfuYXSzFfiSCx0WnSF+8wFRkB9Y+VyF
         Gh9YgW6FYZpFIrnMEawcQE5a/FUwa/9BBNNolpTsLgNzjeR7lipTP6LSSiHdUwbuw7pk
         1CBLd01GE1nHdCE7s8SnrP1uPVJY3GAOqNjGxXFvd65WjY/64em9WCspm9cm3Ddc9Itv
         uPPNjJ8jAfiWOZMvvKFu08tWw2PR8Pnh39jaey4kIxEWBbJw8RuZkJUJK4H7wT+EmCPi
         bZbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgdz7ba3fYsPD8BI0B5OHFgXeut8foKfT+lA77l7erbgstr1o/Qao+75U8cvLmC9pc4vU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lYdb2b3NMiCZ4QW3oqEUs9qTG88aH1/bSC8Mf9Y/jBDuqqMKz
	kM3Ipyv34xZahs4B3uZLRk2S/9uToTHmVent3UAIhoJEDR9T4yD/zHgi5Wr4lDDVsKnZv4Q6W3W
	T4luFuMmy4/a+ZsXyvO3IkEt4nhpWqwD4ztFNFdBy
X-Gm-Gg: AYBFou1Tsk/Glt9bySwEK55FDKXLOgE4y3O0QYHeXvYjGXmR9ozAH3JIaHn+eXi47CI
	a7uf8aeyOkoYNb401m3+csaNjBMz60ZaxgLlqw3sLnehQwW060QB6SBQGTk5MeRQxeK6/54EOLh
	k8OeVSLLl6tXh0leIH5nO1RlFZXws/RUmDP4iFBraIZPMgIDGJus0TFACpOuuArwJcHxKYiMnSo
	1kec/Go8rthollU7BEp+45K0VpUcv1iHMbqy2jq5M6GkJY8GLLjQoBzRCkF3N+8ytHJ8+eJahMy
	7XcFpX4yKWjuT0UnbKPEV0rNbcGDw4Awv+uva4EbNDe/LaUkB3Y/Fe8xQEwCs59piFuJWXmUIdK
	C+Q8GMv5+tgxF16Z/cn0bRIMb/ClgVybZHgtXoDKWe/GXLFuQo4umCwnsfQ==
X-Received: by 2002:a05:6402:515b:b0:6af:b196:68bf with SMTP id
 4fb4d7f45d1cf-6b57bf23d30mr13524a12.7.1793836189727; Wed, 04 Nov 2026
 15:49:49 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020234535.3182385-1-jmattson@google.com> <20261020234535.3182385-3-jmattson@google.com>
 <auuZcZhBhrkZd9qM@google.com>
In-Reply-To: <auuZcZhBhrkZd9qM@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 4 Nov 2026 15:49:37 -0800
X-Gm-Features: AclHuK_NOce6L67eEel5xBWyuJ8EA4SaVhlYOcLwPr6ufXLfVFjSolSkCGb1uQw
Message-ID: <CALMp9eTpWP6XSYPJQjBwPsNWmPzLNh+EDGivMFZsUnixqpGkVA@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: VMX: Refresh LBR MSR intercepts on full MSR
 intercept recalc
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Like Xu <likexu@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 12:45=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Oct 20, 2026, Jim Mattson wrote:
> > Re-apply the LBR MSR intercepts in vmx_recalc_msr_intercepts() if the
> > LBRs are currently passed through, so that changes to userspace MSR
> > filters are reflected in the MSR bitmap.  Unlike SVM, which can simply
> > rewrite the intercepts in either direction, leave the bitmap alone if
> > the LBRs aren't passed through, as a filter can only force interception=
,
> > never prevent it, i.e. the bitmap is already correct.  Note, clearing
> > msr_passthrough to force vmx_passthrough_lbr_msrs() to re-apply the
> > intercepts on the next VM-Enter isn't an option, as doing so would
> > leave stale passthrough bits behind if the guest LBR event is no longer
> > active.
> >
> > vmx_recalc_msr_intercepts() is invoked in response to
> > KVM_REQ_RECALC_INTERCEPTS, which is raised on MSR filter updates, but i=
t
> > skips the LBR MSRs, and vmx_enable_lbr_msrs_passthrough() does nothing
> > if lbr_desc->msr_passthrough is already set.  If the LBR MSRs are passe=
d
> > through when userspace installs a filter that denies them, they remain
> > passed through, and the guest can access them without exiting to
> > userspace.  Conversely, if a filter forced interception when the guest
> > LBR event became active, relaxing the filter leaves the MSRs needlessly
> > intercepted.  Either way, the bitmap remains stale until the guest LBR
> > event is torn down and recreated.
> >
> > Only x2APIC MSRs are exempt from userspace filtering (see
> > kvm_msr_allowed() and the KVM_X86_SET_MSR_FILTER documentation), and th=
e
> > filter is honored when LBR passthrough is first enabled, so KVM's
> > behavior shouldn't depend on whether the filter is set before or after
> > the guest enables LBRs.  Drop the LBR MSRs from the comment claiming
> > that they can't be filtered by userspace, and clarify that
> > lbr_desc.msr_passthrough tracks KVM's desired interception, which may
> > not match the MSR bitmap when userspace filters are in play.
> >
> > Fixes: 9254beaafd12 ("KVM: vmx/pmu: Reduce the overhead of LBR pass-thr=
ough or cancellation")
> > Cc: stable@vger.kernel.org
>
> Meh, this isn't stable material.  Unlike SVM, where LBR virtualization is=
 tied
> to a pile of other crud, if userspace wants to filter LBRs on Intel it sh=
ould
> just not expose LBRs in the first place.

The functionality is not equivalent. For whatever reason, MSR
filtering can be modified dynamically.
