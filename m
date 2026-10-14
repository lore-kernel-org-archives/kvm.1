Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C04A64EA
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014608; cv=pass; b=NMPaw8KnrMXE3KsU1t0NdWq56cnWkPbHvkmBVINzHJWic0vHamJoAI5x6hz8AIMEH/TkxcJ3cgoh+gUL9XbJsUKHX5BVkKzxCapNyvEBtyfwmB33L+om2si374vAJoHxEhGbn8YOCoDZoUl8XgPcFjXSMOXcwyU3mSpqwjz4X5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014608; c=relaxed/simple;
	bh=Sb/58QriJWaMhTgvU3eln2zuouYG3sux3/AAyVRoQ2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlxS3IDgQq9LpEMwsRxZKMdHcYrkKlHK4pzPvUYU6PFlg+D+urBIVN/vJfuSIU2JAGkN6Sn7iOPZINazm2izhvZaOtJuv49N4evW2bbHIINg3u0iZgSwQjr38uoxmTMqZ7NQ8vmDmSO4yVIQbcZef8ZcAOmXcC3dXx3888pZ+fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BoPayPDh; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BoPayPDh"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso215a12.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 14:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792014604; cv=none;
        d=google.com; s=arc-20260327;
        b=aK/XCOARVwBFpc5lS6H06wGIfqpga8EqPnyffhE08nTZUZLXYyU2P0QpPWKNV9NgwV
         Ge5J456byT9QbbAohRcpAp8S5v2gpen891TC+fvjUTi2hYtqvvLAwTLHG/Hzvqg7aVZa
         8WriIehvk4qiw9r8VHa4znF/sBLqhN0c2ItgUhZNlfhTUupx1YyPEz7WXY+fBHrz20Pw
         O+Ti1VDcoGax2x+JOhgNjAfAkmeratDLB37XDI5cKM8VXDgkKmxoYbK10pPc9qNlnorP
         IjqhIovCus2FUPV0d29Q1Z14eOGUIm3jDNf9ST1BU6n3Rgqhtuiv2L6WD6XXTYkeQntL
         fT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cqDh6SSAdrnUIksW3iYI4C7alV8nfaKKDKs+g1eoZic=;
        fh=CPZOFn9cFPkeQunj38gxAVgjPZR1lKekbXTNFpQz7hg=;
        b=pNPh02+Eo2kWmU89Us9c8mERzdM1u6QY00mtahYFYPWvIAH/qZSfItn2fxd/SRweZq
         LhaN6irAd5iUr5X4hTVDlUbjjqlbunonjIrvRi5VW+t8noVVkLvJrXxJ0EWdD+YX2atr
         YwoE6Tm3lr1rJpF7U/y0voLik6nT1TZJOS/SX4g8RCP6cIF2lB4Y1xsmT9DqgapOOMZ/
         4GudLXXxqSn3sEtkrCF0w2wFfximyZfQu0UK/atw8aePnuFkcImEkuLV0PLLE9kfGxMF
         MNbfpq3m726pl0dCi7D2eq0HrkGm390rkKZnlP/qhdBiGsIwkRHyiA6r1z0VB4owRzzR
         Y/rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792014604; x=1792619404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cqDh6SSAdrnUIksW3iYI4C7alV8nfaKKDKs+g1eoZic=;
        b=BoPayPDhQaQmsd5UCdguiouW6b7guO9FNW01cc84QQ4wWkZJHONvrzpSIiV6VPbBe1
         NkP+Qt2145gDpkm2htpwatOWkXQs2dPW2/hyUHn9bP3Rg+eQiJARBgPyWNzfZ57YCcQw
         RmAF2kS3jtSvf0bgkD/uu4Bw4pJHj154nbcwaI14dNo0apJN+a/aWgCheyCq7FjVXY/e
         z5OjUxMSIk6gX8+kYaVwrXrdBbTg5AlPFSZTxWpq31QdcC5vUj5MFyCyMoS7akBWjPo3
         PtWs2DZtCFd0ykbPPij17ehwCCVGf7sjQ4j0Xh5O2ithP1AJGQpBeG2jlCsHxkCzRoHL
         mVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792014604; x=1792619404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cqDh6SSAdrnUIksW3iYI4C7alV8nfaKKDKs+g1eoZic=;
        b=HdF7+d79m1nnL2EVcRKJCsSIgNRtAkmT5FV2CB6RmFU1J3NNsIxzASY4FQ5H+Itt5F
         3ToRCGe71jC6LkmZ0x1RQAEoepv/PcYJs7sBGbSwgwJP4+BYrNsuogC5tcZsHcbuODhZ
         9y3GkeqlyiH38ZdbQzJknxS95zuviY/uoRXZHHhNufFSHglc+hjRGhdV7zybH5zQbScz
         YZn22DqjWTqBRztRlAT9I5hswZq5FbeFLyzf6fiUbp6y+X3nWHz2BUNR+LgYU+oSdQFR
         nezn+tvXfYc1ToHDZIR09gDPesJCBmPZNwCLlIApzvN6zzKt9vzCblVhXbEoo5OHwW19
         H7Kw==
X-Forwarded-Encrypted: i=1; AKwUvBwQoU3m6QnHLztoTOZ8kPpxHARKiwhuj7lpNA8srHozVWTzEwv8GtCIoOOqO3PRO0KrFe4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEx4USw1/mXtYvL+yrOUbIYdxHTnmCXIXPwCk36BYIHvEW0bIG
	EkB6shXB2Wf6l0bIOoH0GuDjL5Rp/4UF9FMMBuJoO5mTSBGV2Yw+BFvG3dMAMPqJXnUfHMvqvbJ
	16Qzd/eEwkQxxsTgROKQh7lPyGTmz807pj09yKyRY+eRrcp7uJD5xUt878tU=
X-Gm-Gg: AYBFou3yGRRJwNrVs70pCCFu2apQ1B4oflEz3mGy19WqZLt5aAnW1Gvngo8THbyEHmK
	RNkWm0vR+slJ2ao79vKreFOPgxCtV6bdV7//o5uWhOlWlXaBpdix5bSbFUhmQCQjmqbQ/d8wfMA
	K3tWh25Pgr5L4PFoBB26V59hV2slnkecz0w1Epv3uTBUpijvQRT1u1KXs1xjKOwBLR6KvDc9V3v
	9ACX0VBomMLZ2PlDjV41y0fO+XkGJnNfMJoF9+JeMkh4hKbDeQzmtEDsT+Qm1BuTLmHXkVf3ddx
	Gu9xlAMBhleCsvo0OC+3r2PRZLqOzLaeRihaSL88e+7iIRl7jqW8FgI=
X-Received: by 2002:a05:6402:20c2:10b0:6af:b196:68bf with SMTP id
 4fb4d7f45d1cf-6b20aacf5c4mr61458a12.7.1792014604097; Wed, 14 Oct 2026
 14:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-5-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-5-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 14:49:50 -0700
X-Gm-Features: AclHuK_GlqQIdJcNkjsjv88poiBSqZFim_xtLDMo54MUoTLrqyASHXUTHJYwihU
Message-ID: <CALMp9eQEEKVQT33t=UNDdGLotZWiUpznoM6Jxdc4u0W4vfcv1g@mail.gmail.com>
Subject: Re: [PATCH v3 04/27] KVM: x86/mmu: Support specifying reserved TLB tags
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> In preparation for using the TLB tags allocator for SVM, which has a
> range of ASIDs allocated for SEV/SNP, pass in the number of reserved TLB
> tags when initializing the TLB tags allocator. The bitmap is
> conceptually shifted such that bit=3D0 corresponds to tag=3Dnr_reserved.
>
> Specifying the minimum value during initialization also makes the API
> clearer, as tag=3D0 is now explicitly reserved by the caller.
>
> No functional change intended for VMX as VPID=3D0 was already implicitly
> reserved.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/mmu.h     |  2 +-
>  arch/x86/kvm/mmu/mmu.c | 42 ++++++++++++++++++++++++++++--------------
>  arch/x86/kvm/vmx/vmx.h |  2 +-
>  3 files changed, 30 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index de79e002edf8f..b443a5083bfb0 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -413,7 +413,7 @@ static inline bool kvm_is_gfn_alias(struct kvm *kvm, =
gfn_t gfn)
>
>  typedef unsigned int kvm_tlb_tag_t;
>
> -int kvm_init_tlb_tags(unsigned int nr);
> +int kvm_init_tlb_tags(unsigned int nr_total, unsigned int nr_reserved);
>  void kvm_destroy_tlb_tags(void);
>  kvm_tlb_tag_t kvm_alloc_tlb_tag(void);
>  void kvm_free_tlb_tag(kvm_tlb_tag_t tag);
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 97d49247d9d82..c096c1a2b4684 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -8182,9 +8182,17 @@ static struct {
>         spinlock_t      lock;
>         unsigned long   *bitmap;
>         unsigned int    nr;
> +       kvm_tlb_tag_t   start;
>  } tlb_tags;
>
> -int kvm_init_tlb_tags(unsigned int nr)
> +/*
> + * Initialize @nr_total TLB tags, where @nr_reserved of those tags are r=
eserved.
> + * Reserved tags start at 0 and are contiguous. Hence, usable tags are
> + * [nr_reserved, nr_total). At least one reserved tag is required, as 0 =
is the
> + * host TLB tag on both VMX and AMD, and is the value returned on a fail=
ed tag

Nit: VMX and SVM -or- Intel and AMD

> + * allocation.
> + */
> +int kvm_init_tlb_tags(unsigned int nr_total, unsigned int nr_reserved)
>  {
>         /*
>          * Limit the number of TLB tags to VMX's hardcoded maximum of 0x1=
0000
> @@ -8194,7 +8202,12 @@ int kvm_init_tlb_tags(unsigned int nr)
>          * need a solution that works for both Intel and AMD.
>          */
>         const unsigned int MAX_NR_TLB_TAGS =3D VMX_NR_VPIDS;
> +       unsigned int nr;
>
> +       if (WARN_ON_ONCE(!nr_reserved || nr_reserved > nr_total))
> +               return -EINVAL;
> +
> +       nr =3D nr_total - nr_reserved;
>         if (!nr)
>                 return 0;
>
> @@ -8208,13 +8221,8 @@ int kvm_init_tlb_tags(unsigned int nr)
>         if (!tlb_tags.bitmap)
>                 return -ENOMEM;
>
> -       /*
> -        * 0 is the host's TLB tag for both VMX's VPID and SVM's ASID, an=
d is
> -        * returned on failed allocations (e.g. no more tags left).
> -        */
> -       __set_bit(0, tlb_tags.bitmap);
> -
>         tlb_tags.nr =3D nr;
> +       tlb_tags.start =3D nr_reserved;

Can you also clear tlb_tags.start in kvm_destroy_tlb_tags()?
