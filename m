Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793836767;
	b=MvI1fdNE/Z6snLDux0JLyEyGMiOAWT4NSP+L24TPQwB60MxL4F1Fzf4l0vwqbKfuyhw7
	 ivMoxDq46gbF7vL2plZhPP+hDXXYpDkeWckrKZ+XutB/8W+6DsbPEArSY2eib03sF2LYh
	 AK/e1/I5REbPFkf6b1Nc2fDFE8+AkRPuC4RgxiSfwhAPfh48Z0QN8GGrvDfF6mQ6PkyOH
	 t7RZYopWr992hm2vY6Exx3Nup5RBody9kQHBOSasbkfjzeiv46he8WVYOoerl7H8XZ66I
	 +4WQJJ8Bai49DSEGCtHmU8sx23o4bYcefm6reFbKKIWsfD6++hBFRqKPPrXyJg63eQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dkiq8G97zH+ba7bC4JuE4QsITtbGVvYbvH0HqLcYoWQ=;
	b=n8OHSUPKLwktTv6VTgluvaPM1/E8RZjeUCuagdPY6rrFvpSELwa0D8kUP8rsnXp1ZQrB
	 rrwY49p07fbA8wrSqTZ4mTTgzMjQ7RLMXidbZbdHku3H72l3zs5E7n+/wa4+1wVOADIfo
	 4CiGd+ME6hlaqciKQ3dgKtUEPSuIcp7xUzkJADVNG1ndz586+dvMJqtlBVpu2+q4Wk4Yh
	 4I1S6PfZvXvLRH1F1UXW39VPpymz9Ui0CDNmjc+G6bjpi5wRsjA4zZ7R7RPuCIZXAjgMU
	 AFUZs2enxn9mwLlyVwYt2d/wNHKCyvKjs8AP20iU+z4xoPvhLbEuyCWy1rGPlWBfPkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vc9LIe1U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4652606A32C
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 23:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4652606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vc9LIe1U
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso5057a12.0
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 15:59:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793836765; cv=none;
        d=google.com; s=arc-20260327;
        b=Ku6j6dxbyzx89qD3am38xYABjRpQEAEoL7eMvDhEYCxmiY1m7w9hCiA+NDABJumSQB
         839zhbZUGH9efeYmxyuLNaniua/VdQxSWCmP3Or7DTVFqyqhJceNtCfXhEf0lFvf4urB
         ozVk09PhTcK6WqcJvmhLzx5AW3L7Q9CNTFDOVhM9xe2mvdAx3k9ALoRMj2rQIFvlDJXL
         ptUJEgipeEj8Mx7Sib/WI4kliQPozRBpnx5GhRI9HUt8CtiELKwaPOV1laMP1BL1BjU3
         hVCWyuWW8yIkAffFqWO+L7DWQrpkgG6+bjRIvkGSHN2T3/iNPkuRQ49G9yvW71bxcJRp
         +kWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dkiq8G97zH+ba7bC4JuE4QsITtbGVvYbvH0HqLcYoWQ=;
        fh=qpMLE8uwoxulMQ9zHpQfWgE1PJPbynmiHgiIeqrJFUs=;
        b=IkIXppzJdXll0s8umKS2ZAHr0bGekwUfzHHy0iwDaW4VWuVjccPzO4p5/3TjWrwKd9
         MLwuWnJl1yEoIKtgEZNU4ddJhyRmrzeaHAT1O9UEvFgPJsfmuK9LuS69lSYMv6T/xzC8
         slSJktaLby4BeLVsPBp7yw3wCX5N4Jaf72B5tnI9TFzDRXwz9bW/Cm7uUJRBvDolTy7g
         10p12EonCzw43nn5yl1nMPC9YRU7qkRqi9cc6L+22F1wEBUrFrznHU1TbldVSP8EhtsT
         EGUOVMJ9G8UZFybfK4Df5olwfdsm0QSNjluPvuCtSDmacdEQfn5axsVEFJ3DpU9tUz9F
         cJ3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793836765; x=1794441565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dkiq8G97zH+ba7bC4JuE4QsITtbGVvYbvH0HqLcYoWQ=;
        b=Vc9LIe1UafFwZGai+igL6zs/Uc1hhnfx4DdJRxwvpr+7zSjSTZKN1ETxXX8zGMpdnN
         q5w4J1gdbeRebvVAKTHV1XJ/mljgTwBZ26MEVrWaGU4MMl06uzqTt8jN7d/RJR3KB3ZP
         FPNqjWU9A3ORayG155iRJlNh1r3+/Qggc03cHKppDCDHulNi0aosghQ0oCIDY8btbeY0
         PFlorf5a4pYeuFL393kwZNK+irgZm5BqUJ+3YtxCyo1OM4kxaXaOEweJS6CJiZAMM6OO
         YYNrzPf2HVDHqDhDSZTrHaYOSYnNBeENCBZ74dmXTZxIFWJi0FyMnHV6uTDdwSTeBSiF
         /wvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836765; x=1794441565;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dkiq8G97zH+ba7bC4JuE4QsITtbGVvYbvH0HqLcYoWQ=;
        b=kCdrvqDN3G4MOot+iGoqMrJgJ3IwVeAVEU5vO3SfO1WNOzfZJmfesHpkdvMJr/ihNx
         bW8tJXktgRIh0VN5PLKf19aNk7WbVK92zA/2Mx4cLt49UZdzs/44zIwfgWzFc7YvgDce
         kasEhissFMwfuOSwQCqndFLQJRP5m1dQozYmOui+vwOO3QFvnqyafWP44pCr2nhU8M20
         Tj5xS2z5hEO35nQLgpGuyyp04glJMsPeNY/M2l3pfPJ+yK4VvS083osQ7UdabCW8V+9u
         tYEAQSaktHO5o6SrzrrHMaUqBnUadtcD31bN/VUVsJWdKKo++wxARS91FiXGK0xAHRtW
         FN+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwN2NiO7A+xEdielpqbEQ6/Mm7k2+nvIR+nab6hyoZzImBRu/cdk7/9E6hZpfE94i9x/xM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BdHomYPUL5qjc+u8yl0akQZQWN6CMtHlPNq/DxM3/ush5BUXx
	6c4DUwlU4mfxobi64BAuScfJ387OEMZ4/7cr0eBzaUT9P/LA6bgS3xHeibEnmTkoEs2XgNFO6O1
	u605yMRnw4D6atD62HZpDgewpC//ZHcabshvq1H3P
X-Gm-Gg: AYBFou2jHRjgn3tfpKfWICoRh0YRo4Acisl+59I3MviKEMvZXhbyo13hdQIAxwGaluZ
	tSU5n7BLDQKDfkOEPwdnswyvGgcB9u2EFqigIm/F8RQD64E703PDOW4gv5bokZ6zBKY5oUbwS9Y
	/Wzx/qiLrGxX6Xk/y5srHFVeqm0YojpK62UEGQwtb3b13lObGJ4JGk8U006Cs9nvm2Ym1yDLwdp
	RsgxeTg9RH/+ZKsrXbJJ3xZ/IhlRuDQbX5E8z1VmWIuX1618fF7gF1B5HtgO1PXRqvP0LHAVM0O
	+QGV3e2sfTa89y7WlGakhSLOXn/o/Mk2j6OyK7RL6SORQWNAkd96n17PX/Ykg8naa54XCwOOQxL
	xWls3svfkMgKkJQL5Ptv79W9OmLyLEWxJ8MNg
X-Received: by 2002:aa7:c952:0:b0:6a6:8513:7e14 with SMTP id
 4fb4d7f45d1cf-6b57cdc6385mr16040a12.9.1793836764713; Wed, 04 Nov 2026
 15:59:24 -0800 (PST)
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
 <auuZcZhBhrkZd9qM@google.com> <CALMp9eTpWP6XSYPJQjBwPsNWmPzLNh+EDGivMFZsUnixqpGkVA@mail.gmail.com>
In-Reply-To: <CALMp9eTpWP6XSYPJQjBwPsNWmPzLNh+EDGivMFZsUnixqpGkVA@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 4 Nov 2026 15:59:11 -0800
X-Gm-Features: AclHuK8_LY-OTUKdxgAEiTiBoWtOGamSflwZcfkOr9pBxGweoCUz57HuFcean9w
Message-ID: <CALMp9eRU6G-spTgzkKdh6E=U7omQsFDM_2nH4KEPZieg1e-zgQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: VMX: Refresh LBR MSR intercepts on full MSR
 intercept recalc
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Like Xu <likexu@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:49=E2=80=AFPM Jim Mattson <jmattson@google.com> wr=
ote:
>
> On Wed, Nov 4, 2026 at 12:45=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Oct 20, 2026, Jim Mattson wrote:
> > > Re-apply the LBR MSR intercepts in vmx_recalc_msr_intercepts() if the
> > > LBRs are currently passed through, so that changes to userspace MSR
> > > filters are reflected in the MSR bitmap.  Unlike SVM, which can simpl=
y
> > > rewrite the intercepts in either direction, leave the bitmap alone if
> > > the LBRs aren't passed through, as a filter can only force intercepti=
on,
> > > never prevent it, i.e. the bitmap is already correct.  Note, clearing
> > > msr_passthrough to force vmx_passthrough_lbr_msrs() to re-apply the
> > > intercepts on the next VM-Enter isn't an option, as doing so would
> > > leave stale passthrough bits behind if the guest LBR event is no long=
er
> > > active.
> > >
> > > vmx_recalc_msr_intercepts() is invoked in response to
> > > KVM_REQ_RECALC_INTERCEPTS, which is raised on MSR filter updates, but=
 it
> > > skips the LBR MSRs, and vmx_enable_lbr_msrs_passthrough() does nothin=
g
> > > if lbr_desc->msr_passthrough is already set.  If the LBR MSRs are pas=
sed
> > > through when userspace installs a filter that denies them, they remai=
n
> > > passed through, and the guest can access them without exiting to
> > > userspace.  Conversely, if a filter forced interception when the gues=
t
> > > LBR event became active, relaxing the filter leaves the MSRs needless=
ly
> > > intercepted.  Either way, the bitmap remains stale until the guest LB=
R
> > > event is torn down and recreated.
> > >
> > > Only x2APIC MSRs are exempt from userspace filtering (see
> > > kvm_msr_allowed() and the KVM_X86_SET_MSR_FILTER documentation), and =
the
> > > filter is honored when LBR passthrough is first enabled, so KVM's
> > > behavior shouldn't depend on whether the filter is set before or afte=
r
> > > the guest enables LBRs.  Drop the LBR MSRs from the comment claiming
> > > that they can't be filtered by userspace, and clarify that
> > > lbr_desc.msr_passthrough tracks KVM's desired interception, which may
> > > not match the MSR bitmap when userspace filters are in play.
> > >
> > > Fixes: 9254beaafd12 ("KVM: vmx/pmu: Reduce the overhead of LBR pass-t=
hrough or cancellation")
> > > Cc: stable@vger.kernel.org
> >
> > Meh, this isn't stable material.  Unlike SVM, where LBR virtualization =
is tied
> > to a pile of other crud, if userspace wants to filter LBRs on Intel it =
should
> > just not expose LBRs in the first place.
>
> The functionality is not equivalent. For whatever reason, MSR
> filtering can be modified dynamically.

Oh, and, duh, MSR filtering doesn't disallow the LBRs; it just
reflects them to userspace.
