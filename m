Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395451A14D
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902538; cv=none; b=HBVpqPHxO+C7sMK24z0H338fG+3mCakWieJ+2OAS+Cc+6ABVJkHKM3xJZn2o7NZhfRGeGEPxDU32jKBk/kcWGeIfbL7vsObh6sNab7iBKOBzHkEUIzCIItoX0hrkN2DinpbFxpsxPa2boHAlRSU9HRLhahn6hKWtGIl3LJTNHew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902538; c=relaxed/simple;
	bh=EDID393fC7tukPZfvcocCPsPfhIQrWG/1PsKk2F4FBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQhAqdj5pLlpnyKSXxnn6dgNfXpPk7lA21wWA/oK/fxwNBWBILzlrULk+nFaJ9rdF+5umsJVxVP4bSBCBUiclMaHvzcKTy7iRgb0gq6Kjvgb4z7mI3uFtI7cc/pEvyKYJkCBt+3U23UngE8qgaWe57JMT1Z5WXIFRTajFMCf7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvMVnYcD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvMVnYcD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C0D1F00893
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902537;
	bh=07oJOGeS5FhE8zN/c2ze/F/oAB3LVitexCPC6Cj5leQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JvMVnYcDyjf5RrQ419cPeGJ4FIYvjLCKrTvdfIooUZM0Mk/5LCnlMc/KQRLoKmo99
	 m4HFZZ+/LEuv/Qleo/iIuVwQZQo4IblWEPHNMiIAu+HW1V2n9DUBHoqwhzMctz9dmI
	 0ai4LvhGAkd6Tomw0eFdpJOUEQFqqjqnY5vtG6HZNS4IkHH01Ft6k7GacS8ynGlvNi
	 kLKz2Su5Ipk1N3v7uTpujzRBiVR7hSLoT8kRWnA5WxbkRbHSAxjRrdj/mJ4McM7XhE
	 5CF2pGNdYRDWA7Hx9ly4W5w3Qc2NUHoqU1dEYs7mSZLKdmt/HYU8h/MsrtN1VlFxeg
	 HDtPZRxNcO/wg==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-930c0f9c1b1so312852085a.1
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 07:42:17 -0700 (PDT)
X-Gm-Message-State: AFq9FYL0GmPOvJvBk5aGl/AXW0FItms7/lp/oy47B/a1mhK3x1dF6ALH
	avYSY37vyMs3h25paUMQ9la80Wo/vwbnRKZsWzfWosXO7CTwga0+/3rqmkkRo9tjjw83oheJ0WB
	3UICwScb5we3cUP2RPTJK52UnDyqOKEY=
X-Received: by 2002:a05:620a:8389:b0:93b:d79a:c463 with SMTP id
 af79cd13be357-93ebd26b5e0mr2066173285a.59.1791902536734; Tue, 13 Oct 2026
 07:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-16-yosry@kernel.org>
 <sashiko-outbox-168758@kernel.org>
In-Reply-To: <sashiko-outbox-168758@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 13 Oct 2026 07:42:02 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNTeScHRbhJjHBtpOXbfGhs81S7tOb9H4xNLzFC4JO+CQ@mail.gmail.com>
X-Gm-Features: AclHuK85-y1lkn532bqr0UIR87iPcHfYX8c1ypiqANOa5r9BBRqaBCSnuNm_l4M
Message-ID: <CAO9r8zNTeScHRbhJjHBtpOXbfGhs81S7tOb9H4xNLzFC4JO+CQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/27] KVM: x86: hyper-v: Allow purging all TLB flush FIFOs
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:56=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] x86/kvm: redundant guest TLB flush due to uncleared KVM_REQ_HV_TL=
B_FLUSH
> --
>
> commit fd7f6324f98d1c559f015e78c148b1f3ca58d78f
> Author: Yosry Ahmed <yosry@kernel.org>
>
> KVM: x86: hyper-v: Allow purging all TLB flush FIFOs
>
> This commit refactors kvm_hv_purge_tlb_flush_fifo() by introducing an
> inner helper __kvm_hv_purge_tlb_flush_fifo() to allow purging a specific
> FIFO or all FIFOs. The refactoring delegates the KVM_REQ_HV_TLB_FLUSH
> request check to the inner helper, which is now skipped if no FIFO is fou=
nd.
>
> > diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> > index 03cc65f8cc52d..a23ef05c1075c 100644
> > --- a/arch/x86/kvm/hyperv.h
> > +++ b/arch/x86/kvm/hyperv.h
> [ ... ]
> > @@ -312,18 +312,29 @@ static inline struct kvm_vcpu_hv_tlb_flush_fifo *=
kvm_hv_get_tlb_flush_fifo(struc
> >       return &hv_vcpu->tlb_flush_fifo[i];
> >  }
> >
> > -static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu)
> > +/* Purge pending TLB flushes in @fifo, or in all FIFOs if @fifo is NUL=
L */
> > +static inline void __kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu=
,
> > +                                              struct kvm_vcpu_hv_tlb_f=
lush_fifo *fifo)
> >  {
> [ ... ]
> > +static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu)
> > +{
> > +     struct kvm_vcpu_hv_tlb_flush_fifo *fifo;
> >
> > -     kfifo_reset_out(&tlb_flush_fifo->entries);
> > +     fifo =3D kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
> > +     if (fifo)
> > +             __kvm_hv_purge_tlb_flush_fifo(vcpu, fifo);
> >  }
>
> [Severity: Low]
> Does this change inadvertently leave the KVM_REQ_HV_TLB_FLUSH bit unclear=
ed
> when fifo is NULL?
>
> Prior to this patch, kvm_hv_purge_tlb_flush_fifo() unconditionally evalua=
ted
> and cleared kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu) before returnin=
g
> early if the vCPU lacked an initialized Hyper-V state.
>
> With this update, if a Hyper-V VM-wide TLB flush sets the request bit on =
a
> vCPU without initialized Hyper-V state, kvm_hv_get_tlb_flush_fifo() retur=
ns
> NULL. The helper __kvm_hv_purge_tlb_flush_fifo() is skipped entirely,
> meaning the request bit remains uncleared.
>
> If a standard guest TLB flush request arrives and triggers the purge path
> in kvm_service_local_tlb_flush_requests(), the uncleared Hyper-V request =
bit
> will still be pending when execution reaches vcpu_enter_guest():
>
> arch/x86/kvm/x86.c:vcpu_enter_guest() {
>         ...
>         if (kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu) &&
>             kvm_hv_vcpu_flush_tlb(vcpu))
>                 kvm_vcpu_flush_tlb_guest(vcpu);
>         ...
> }
>
> Since kvm_hv_vcpu_flush_tlb() fails (returns -EINVAL) for a vCPU without
> Hyper-V state, would this fallback path execute a second, redundant
> kvm_vcpu_flush_tlb_guest() operation?

Yes, this one seems to be real, although it's not a big deal IIUC.

I defaulted to checking hv_vcpu first as to skip the expensive request
check if it's NULL:

if (!hv_vcpu || !kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))

But I think we need to do the opposite to maintain the existing behavior, i=
.e.:

if (!kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu) || !hv_vcpu)

I won't respin for this for now, will wait for more feedback. It can
also be folded in probably.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012233638.25=
46339-1-yosry@kernel.org?part=3D15
