Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD81A0B0E
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198742; cv=pass; b=sLGLExuW+QFgJ79nb3nvjL+IAoxM2UTxn7qivVEnpTqb3vSRpsIaLgm+bdFZzmXwBoNC5+/qAeaZLVP4dlupYwpPERy1UQ34mXPhsomFQ9M7XpCndQLibGJ/Ayx/i5NCle8peTdy1gUePpSpB0kKx4C9swmBGa4SCvBDiwcUXsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198742; c=relaxed/simple;
	bh=FL1AXtTaLJMwqVl0ZO02Ff3ZqGOscYBDyBP9pb8cPwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAYJMB9eievzBg6VeF8kWeOBOvwyPd5zGCX2M67f6anXv2khSHnZwgWitIiu6doiL7V6GAlQFoWz8Y9fUJrS8QUHzpngGtR0HPbSEb/1WOP9Gzwlpp0SlbKMQx6b/j7o93mjTTSdNurmYOI8O0HJITpMRmIYH0M3BgmhEVce2Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nW+yQRzJ; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nW+yQRzJ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1691e4ec40so439209066b.3
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785198738; cv=none;
        d=google.com; s=arc-20260327;
        b=dpo3vtbbTCQ8zV9rQDGJCK978VnZdxWj5KkGRRH0zMEFIQgnwIshvQ5P30aFBiekwV
         jpMsuee2pwOj8v86KPtJaQSMDP0QfQXx1qpzcWSGzqaM6b4+ApE5DeEUoS4ynI1+kULk
         sKdNOmuZ6Qr5T+T7QekGu4cRZ16nNPkWGNn0J0CkVQFTNLPC1rSRTsLm8PqJHoqgnhi5
         lY0YPyUtvJi6sYqYSqq4tglfAXZIJ7P+pW7EeFVPpjD5Mga76f8zfI7Ru7d9R5ZUNS0w
         8zG0pTIdSnDXNIVvPsq1luZ0osarTAR2dwWt5zf+/gTZ5bJ5KkNqUTG3rxOlVkxMFAsy
         xCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HZglPpnUw2DB3NFcrzl72/zLIJkn4fwVu2mbddrqY8w=;
        fh=0Wynthv3lf95AdhqUkWc5DFsl6QyHRKdKozHiyLP3ds=;
        b=Q2Szp010zeTG2Lu2+Yr6RVUKFjoWtoqNMlyc2qIa5ewm0o+J5LvaSDYX4xHFyXLonU
         A4WCaqZMjL3yxcSmxbDoeinHZsyKsEcneAT2IvqJSgDn6Kxl7gcdMnFjigrag0/M4IR8
         YrVUw98ECA3a+BtUlvmya2oPufHw1k6eYt9HmboRdN4ZRWtTX9KmAR6KKRny4YBt/3hr
         tU+F95dufkke/rT/fgsaXhWM69x3HUfvUG4gsj5aQj8IbBopteXg1BHQR+fIVGQPgTnN
         KUDb/8Z6sZhAoP/9vJ87GfClxqqTVa13acgMK43M1p+qefFUYSoZ2ke2c/6f9CflfzpR
         CLIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785198738; x=1785803538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HZglPpnUw2DB3NFcrzl72/zLIJkn4fwVu2mbddrqY8w=;
        b=nW+yQRzJXkTroC8B/S7fPzbUnszfNwZNz+ypIJCzLe7TNvK8fCz7D/WioX8EKNWobt
         bENvmtOJD9NvHUKL7StmzLKjKnIy9y7wgPMPjzV+3rrlbx4Yx7cqwe1VIcEeQzVgTwhr
         LjvPp7lgZ8yZMghPIg843fIU9BRuWChdxKobjKX4iqN91GOOy1+5ba/Yzs25Kv/Jqe67
         s5dl8fqQeQre8f+OwiN6l5cT/J3gG0I/BRXqgx3z7eMFtG/HMFeqhMBKQK/I7IrxIK61
         v7CPi/urK+vN7NvITd3UCXj4cLRDVTm3OoNIJKea9bkHoBlaxyK2/4973cnfH88oaqvX
         28Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785198738; x=1785803538;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZglPpnUw2DB3NFcrzl72/zLIJkn4fwVu2mbddrqY8w=;
        b=tAa86E1jY6iJJiHf8zrQ9IkkZIUll40z7My/rO4emkOKSOZayqa3dfubaI/+AyWIeA
         Nw/Ea/kV1pxNI0ERX7G1wEQTKJv0wTEgUHbD8QxRhT294O685jU4nT7SizgLRIoCWOi9
         SPNWxIdrzSRXEebvsEidA3IWuHsEPrPB9kXbRNg7ng3ngC8gM21y69jqUIYVJfYv0JVf
         2e/2uPb+AIXhWOV2JPMJrow6hJ296otlihrj8A3fnDRU54hAy3xiF4zyUvIn9Quj+xgD
         FJBOkG08iIT09OQK8fjixzZeZCXiWl0degYP8//3Y5+5gU37OCGJxq8xoqdfJWXETjJK
         SZKQ==
X-Forwarded-Encrypted: i=1; AHgh+RoenwE5ffOAWX7PKzfvJ/Rt0u6gwlGbQpG8h+USZ0vtBH1+BrTCxgm3R0gtSsSgnfx8/LI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye4dsWxSzAKLdYdDWRxcf+IsC6Y0oUyt71vFAwrf5Otp0hoKtr
	OwdzHfaJWK+wkTBJzdTMHViYfoyPVQuiZNVTluvlSo9ioGZuVQIqRxSFdDLTqC4ew6eEjw/fegt
	+tyY/azgQxnLdI2yKZdLVsUoYXjkcwGNgFXwGziKOiWVLgRYtrZIqZ5br
X-Gm-Gg: AR+sD10s1Z+zfL0g1Hj1V/boj75Shb+hNdo8BTwe50UAQchos0rnVNN7gvIwlQTGs1Z
	8lmT/vQe0sFZrkOqqaJsjLmFpisg+88wbWoIStVsu37pGSM1cDkGxYsW51c6DKceTJCYlrjrVkX
	NalznXEnPPchjZz+bADeQQXBWoQFDnDyHB35qSKvrj0kf4eLkB5zLsuCXUIoyNaNockkGf0xVvV
	+chppCElGFdnDSAIvunuHlhj4GNR4id2E9P46OPtuqzfpFSSBu0Bs/iHQKbKDCORZa02JmV5dTL
	6h3sx4oNu732TnM1IzcsanPo0npMuPxoAGU2538xNMH8WPxp
X-Received: by 2002:a17:907:960b:b0:c16:12ff:dc8d with SMTP id
 a640c23a62f3a-c1f71db115dmr5687766b.14.1785198737558; Mon, 27 Jul 2026
 17:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728002236.869865-1-seanjc@google.com> <20260728002236.869865-2-seanjc@google.com>
In-Reply-To: <20260728002236.869865-2-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 27 Jul 2026 17:31:40 -0700
X-Gm-Features: AUfX_mxwy_J6BZaJVMd17vOKwACxxnganTziZGRgoI2Wvk-XrA19dfFcnI-g2cQ
Message-ID: <CADrL8HUtAD=aEHG5TKdZeXNWXDKugE0e0u6kZAcyHw90iNckwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit
 in TDP MMU
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:23=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Use LOCK CMPXCHG instead of LOCK AND to clear the Accessed bit when aging
> SPTEs in the TDP MMU, as doing a LOCK AND can corrupt a FROZEN SPTE and
> allow a third CPU to effectively overwrite the FROZEN SPTE.  As pointed
> out by AI of some kind, because the magic FROZEN_SPTE value is a "full"
> SPTE, not a single bit, and includes the Accessed bit, clearing the
> Accessed bit in a FROZEN SPTE will result in is_frozen_spte() getting a
> false negative.
>
> E.g. if CPU0 freezes an SPTE, and CPU1 clears the Accessed bitin the froz=
en
> SPTE, then CPU2 could come along and overwrite the frozen SPTE with a
> shadow-present SPTE.
>
> Thankfully, the false negative is largely benign, because outside of TDX,
> which doesn't support aging, KVM only freezes leaf SPTEs when removing an
> upper level shadow page.  So while KVM could clobber a frozen SPTE back t=
o
> a shadow-present SPTE, and could even use the new SPTE, the subsequent TL=
B
> flush will make the orphaned, shadow-present SPTE unreachable.  Failure t=
o
> ever zap the orphaned leaf SPTE would show up in KVM's stats, but otherwi=
se
> is benign (because KVM no longer keeps an elevated refcount for leaf SPTE=
s).
>
> Opportunistically add a comment to warn future developers away from using
> kvm_tdp_mmu_write_spte_atomic() and tdp_mmu_clear_spte_bits_atomic(), as
> they are generally unsafe.  Keep the helpers, e.g. instead of open-coding
> the atomic64_fetch_and() in tdp_mmu_clear_spte_bits(), as scary warnings
> usually are more effective deterrent against recidivism than removal of t=
he
> dangerous code.
>
> Alternatively, KVM could use different bits for the magic FROZEN_SPTE val=
ue,
> e.g. setting the Dirty bits (with effective IPAT and Global aliases) woul=
d
> likely be "ok", as IPAT/Global are extremely unlikely to be cleared witho=
ut
> doing a full SPTE write, and KVM's clearing of Dirty bits shares logic wi=
th
> Write-Protection, which must do a full SPTE write (via cmpxchg64() in the
> TDP MMU) to ensure KVM isn't clobbering state.  But there is zero reason =
to
> carry that risk (beyond stubbornness in wanting to preserve a "cute" idea=
),
> as the cost of LOCK CMPXCHG and LOCK AND are within 1-2 uops of each othe=
r
> on modern hardware.
>
> Fixes: b146a9b34aed ("KVM: x86/mmu: Age TDP MMU SPTEs without holding mmu=
_lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Thanks for this. Feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>
