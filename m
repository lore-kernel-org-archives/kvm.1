Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058935DA49
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857531; cv=pass; b=Imwg37H0xK3HDVXGFsAM31COfTbzJsMDOsny1f/ANqINp/5hFv/n/E0D+x5JSEecqml7ITUkoFdc6gg+4+CIr8bvvU/QcPZq/CjBHL9Awu/HcH/dod0bJ7VHvQPIDWr2v/rVUdCdXier8rS+t3ko7KVD5oP8eCp3idIgkBhSVgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857531; c=relaxed/simple;
	bh=h22ve8W/AMMGoQTgrDvL6p2XoTwz9Q2Vh3c4CoiRQGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeG+6imENrgSF5GuUibdvbjPKUGTOc+vT6wfAuMRxUJepvX+Pn21Xgo67IAWp2Q3djDSq/1udmzdnDeV+w4DceSyj+n2Z83dcF0DDzA8TEQCoOHDu/BFEDU6nHulfUHXfNO+72Qc6STsornr2VlkT0qBSiQJCmZFb5hD7XTkZBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Shu0p/3X; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Shu0p/3X"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51765331535so122501cf.1
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 01:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781857529; cv=none;
        d=google.com; s=arc-20260327;
        b=aw3ipFAEFLxFZsbd8c48M95zT+Peg84l3XakDcPoYeFRg76tivOT18+PyBm+kAoVhY
         1xkQBgbEU3A20TQ69xChRli82KRUNXmTeGpeSGLpufseIuGLyozaLD8Q/93nCJlsOZ0g
         9doAt3lYqP73IKncmRY1VOTyjeJ35Hl7vdP+JUSzLJVvy9YDq7F/OaYFHT84+nJoF81L
         vN7Lj34+KcsRO+2ScEDBpl2xedMmlGcKHa28Txco5WQ6PJJ08GcP+uycjOhh6WO06gW3
         ySf6fMkkjSVY5JpYuCtvTXv3zW5DxBAoVVz6OQrFjZGk9t6TId5JWa7i4PKenEoOMyIe
         TL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TxeIafjVeRSfliAEGIJzlXDLNa8j87RID43xBzL+1lI=;
        fh=ournVx0CMyHoQLaAKymYgFyS7JVjndybR2GczyNFszY=;
        b=PchaR8FICrVN0496VbRzBuNXORQ+6E4jycDhBIsE1MhGe2BbEXK1a2G/AOyczfZmB5
         rJuN2xQ1m+pYbOdXgaZ0yxCpLX3ynq1Jn0Xd2Sgo9QgKy0RTdbiHXUdI6mnGG3yRnPkC
         6LAyQ15WZKOxHXoWJGKUwndgnERm6m9IBxwrYdoSo3C0uNoQigesGEbWGH77MG1Y2mtg
         K2NuATENf44lLMuNMDv2ddQGAXdF0H10+00fDpWZt00ZYRGFlNz3Dry7tiixPqtwrk9J
         07jvxBn2OZ5i9zk0rW2KfvcieHYwREahHALYgHv0U/cEsrYLOOtwGD9DllSmitsvmx6U
         RQyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781857529; x=1782462329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TxeIafjVeRSfliAEGIJzlXDLNa8j87RID43xBzL+1lI=;
        b=Shu0p/3XJSnAb7Wu3G5E5PJzhzEpfE1t59NIOcRQQr+18WkvJKTV/3lpyhV+sO7nID
         /OwXRbgb/+7ecGwJvPJL3TGTcAEynQOaR6RNsooeIcd2PXya+06vJQULEj3+2goGJz45
         MAsPL9n0GODoAxou9Xdfeu53DoLApdxmgicbShgafy3vBv6vRmjqtlK0cLpZLN6K+ZCV
         8O2yJp6Ti7Kub6NieosA35AzKZuURUIWd8e2Mw6FVSAtvMyd1QUrEShoT66+I0YPi6qC
         YoLoVX8t/LVT4Ld6zWCgX8NNYV7Q6U15z9J1InUoBYqFmAGRhupXG2yCK9Wc806TqB13
         jGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781857529; x=1782462329;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TxeIafjVeRSfliAEGIJzlXDLNa8j87RID43xBzL+1lI=;
        b=s2O4IhTaqD62VUn1oS+JKxk0Ta24b70m8BhLLQ6nrSwrHpBmgg+iNxWviXgQ3NBWlM
         HPH6lOd575RlLNB8eKrLo5YM7dxwQ09SfaTrRaTDS7WTKv/IV6jTvOSSrViCA8AsVk+F
         USTbEaicG/p5+lj/VMAM/fffm/zZt40dVOgLMfFZxzZFqQqQbFIISNuni1CCAeme0dPL
         IvAZx6SCTwcGe77ArAElyLl2cIejiat4HFzW/yk6UfbBBRfPZEZ3ggu8OucuD0XJM6t3
         rsh2Le+JdqznvoPU+mG2Xgw0QOl3v2HQuDxWe7w089OblrRt/WC/RfZYLDR51t/jmCFV
         1vTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hjC2hqZGvAt3ZpU56KuB6P7owxRFtKMD7b24bjtYyzWZvh6AQX5nTV+Lu5Lxd1ontAJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY4bM6uNCMgiSoGDHQynTClA0pvFH49HI9Ji53QHcvl+fXcU6o
	7c9ar0JWZQIongPF9PEfTTRVyu9czJXWttN6YWoFm/IQMsplDbjzEcERq5ak60IRkyTA8PVDCrY
	eBMojSidu1eZbTJb3SzDHUKH/WguLH5yddYWdR4O0moH8JwRZecC/ngTr8dg=
X-Gm-Gg: AfdE7ckJ0Fa68hNRfs9cS4PLKS5V9vtGF8GwIOOTyDaBEcjMgyMDeOaau745gifYxuD
	F4HC+bBuHTSw6rYKElbSIkLLpw2kieAsV7Wec95+p1mqSsAIr8MgqAxLn3HpOgdVSDpDCXouzSB
	0qe7hUZwXQS7DlgtzhPh21S1GXa+h6q0D3HqyOsWinLc61FjOr2HBMMtpusGHuzQ3BDnIyLR1DW
	Zr2xoFQLigbZYxyh/imiRK0bfoE3T+dCpMt94CNoHb5mMabzpFYHbO7sgeGk0nykc8B8230Rw==
X-Received: by 2002:a05:622a:82:b0:50f:ce97:3b84 with SMTP id
 d75a77b69052e-519e48867afmr6336961cf.6.1781857528567; Fri, 19 Jun 2026
 01:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-9-9d2959357853@google.com> <20260619004918.378771F000E9@smtp.kernel.org>
In-Reply-To: <20260619004918.378771F000E9@smtp.kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 09:24:51 +0100
X-Gm-Features: AVVi8CcBvC8TtgogaTN3EUPr2ibU9wi2w0OnsKTZp__1iLlZ0ogFy1kJC5a9Fls
Message-ID: <CA+EHjTzh_FxssbW62ejsbjBBks6YmiNc=9rY=xh5tkTFpkqDKQ@mail.gmail.com>
Subject: Re: [PATCH v8 09/46] KVM: guest_memfd: Introduce function to check
 GFN private/shared status
To: sashiko-reviews@lists.linux.dev
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 at 01:49, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] `kvm_gmem_is_private()` hardcodes address space 0 by using `gfn_=
to_memslot(kvm, gfn)`, which breaks multi-address-space vCPUs (e.g., SMM).

Same limitation as the per-VM kvm_vm_mem_is_private (single xarray
keyed by GFN, no AS qualifier). Not a regression.

/fuad

> --
>
> commit 8dfdb2d13d27c9727b32ecdcb6460d23702e6438
> Author: Ackerley Tng <ackerleytng@google.com>
>
> KVM: guest_memfd: Introduce function to check GFN private/shared status
>
> This commit introduces a new KVM utility function to check whether a give=
n
> GFN is backed by private memory. It checks for a guest_memfd file associa=
ted
> with the memslot and queries the inode's private memory state.
>
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 8101f64e0366f..bca912db5be6e 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> [ ... ]
> > @@ -510,6 +510,37 @@ static int kvm_gmem_mmap(struct file *file, struct=
 vm_area_struct *vma)
> >       return 0;
> >  }
> >
> > +bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn)
> > +{
> > +     struct kvm_memory_slot *slot =3D gfn_to_memslot(kvm, gfn);
>
> [Severity: High]
> Does this code correctly handle multi-address-space vCPUs (such as SMM on
> x86)?
>
> The call to gfn_to_memslot() internally looks up the memslot tree strictl=
y
> for address space 0. If a vCPU is operating in an alternate address space
> where the memslot layout differs from address space 0, this lookup could
> return an incorrect memslot or no memslot at all.
>
> This could cause KVM to incorrectly treat private memory accesses as shar=
ed
> for alternate address spaces, potentially leading to incorrect page table
> installations or guest memory corruption. Should this function perhaps ta=
ke
> the target kvm_vcpu or the kvm_memory_slot directly so it is evaluated
> against the correct address space?
>
> > +     struct inode *inode;
> > +
> > +     /*
> > +      * If this gfn has no associated memslot, there's no chance of th=
e gfn
> > +      * being backed by private memory, since guest_memfd must be used=
 for
> > +      * private memory, and guest_memfd must be associated with some m=
emslot.
> > +      */
> > +     if (!slot)
> > +             return 0;
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inp=
lace-conversion-v8-0-9d2959357853@google.com?part=3D9
>
