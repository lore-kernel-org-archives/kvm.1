Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41466416CF5
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678660; cv=pass; b=D9FBxwotiaK+Fgcy6BtLKkdf42arHp6G2A6hMZlaZHo6pQN6oz0AyMMdwDCTLXZpCjxkkLqdTG7HijUsCXxxDFdMJgyDdwJDRPWhH980vvjZWuW+cJnA7gRoaBnMUW6CxIoyBv9FXjZObvv6sj0IjmWx/hUl33dDWw7rxADpR4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678660; c=relaxed/simple;
	bh=I6pRPVOVidWrPYwV5YDyVfTkLWmo+EGe9HHblFwc4w0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEozKF0CfG6ElbKI6bn+J3FKQCgu0HGgc/zKRioK2RERrUipdKpMGDzQoRRUJi8ZFVbVLGdZel/fbOR40yKzNN5++srr1Gf6gmagFvv8P+97QYG9ZigjjBL9UC0P50NpU2QFO2p20EYw7ZN61MZoOA37f1EEwJbmS30NS+cv9Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euFsZXDX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dewPHmEK; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euFsZXDX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dewPHmEK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780678658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKL2XhPJcTe92U+7kcTY+J0V1P0lR2YbYloV0NBdglw=;
	b=euFsZXDXqhGhuGOWAk3wZtZ/4pDvrG63MQ+QPpVRz/92pJTKXaqUrkjWtIh7lX2vQlDM8R
	h+xpNmhGqwYzaTFxIIvOpAbMRt+RYdBUuod08vslOxcVOUNx6+8FCwsAg7bGCWpbrBa+Hr
	hsTzwQ1fEQ5oJoL9qTOZs083N1MgnS0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-4_2WtJU1MeiLXynDC8vvqg-1; Fri, 05 Jun 2026 12:57:36 -0400
X-MC-Unique: 4_2WtJU1MeiLXynDC8vvqg-1
X-Mimecast-MFC-AGG-ID: 4_2WtJU1MeiLXynDC8vvqg_1780678655
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef3aeeb41so1472715f8f.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 09:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780678655; cv=none;
        d=google.com; s=arc-20240605;
        b=dD5J7OiClTB6e0OQ8aQcOq2EKn7RZceIsghvVhXDOrHjtKPKRZcT6zEt3d0z9IFLSd
         /8Po/Biq3D1l1ZOdfMsWv9umJwkCw/WPyw3AayfClxcxzG7qRattB31C5jJugh/RmfFm
         UvAE9gvtIwYbEvRrW8KlSsBALEq7WzquTE8CZ6yX9XvYsSoQVP9gtPWyyfDwL/Am7NCc
         i+BmquZMpqrBKiqCgKDqjZY9wYDzex3LcWG//Mko02toeLIHPACJCi34548elDZihmjq
         +M1lY+fbqS4skAU+aAZeYQJ8eo1F4iiDkwGyI0R43qvxC9yS7DluMf4XM/FL1coQ7VIF
         9dzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iKL2XhPJcTe92U+7kcTY+J0V1P0lR2YbYloV0NBdglw=;
        fh=SKmPmU8aZtg0RwrzmTdbpHpnEah1Y41tpk7NiV3KU0w=;
        b=isowNKIJemXjIXx3D4ANmQE08ITrjqvSYMFTaiE1z6Yi8T+07H1rPJAYkoeO23oUe1
         xjKrajtC0N4dn2vaArk1wVm0PLIQHPg91oUntfx+Bp6AI8fCq4RJLsI9hIUXHuNUOq3S
         v6omquPl3BdjoUOY31lGemu9cw7xu3dvY61aA9VVyUj/IZWN4K7fzxpx/2kOwe38XjrV
         IbvIXiEon73O3k9UVAsE6AnO/IYMzNvEnaVoutfEajhgVsPKZcDwNtI6DaZy4FP/oALG
         ca4CFw1wg9h0yyvdb8KYUBH5+XWyEIEsTxOoQGikvgHvkY8KSO8RnRLfUuQ1tOE0BCo6
         o0Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780678655; x=1781283455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKL2XhPJcTe92U+7kcTY+J0V1P0lR2YbYloV0NBdglw=;
        b=dewPHmEK482nP/+IO5CxjVQKGxy7f2hUgW678y904nMN0zuBlpcTIs3BGB7muoKEoI
         7x+nXP9HrraaRCK1zaQbK4+p+S+fPMv+hAfyf4TlsZndUy7UnVH0IEvXhwj2gX3twezo
         YbKW+GKoxeS+GwG5KpVEo0qZbzuSut0NxzsjnVp79mgHOf68EJKhLUh+LZ8EJhXzlFs0
         MH67nDzWW03CuLWVn1YUtfHAuCvKyI8KojNKAUZKE8OXEUhEDiySerwFt95htIlpFXt6
         RHlZUdU4NmvdKc4Q8nknfGDy/d/lGqSLigb/PbieGOVjgBJjGwKDCyGoI6humidhbf7L
         7E/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780678655; x=1781283455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iKL2XhPJcTe92U+7kcTY+J0V1P0lR2YbYloV0NBdglw=;
        b=Vx5Aun/G5v6dU9PYDV+btUa6sVcs+P/U8fDWARb9Y97YWKyhi9kuQf8dqpy2sqop00
         OtygLOOQ0xtvXiJhipNo/el/uZWU6BzBJri2TFRA3AFQROM7j5HDma4RTzXbZ0QxDt3/
         0bD+H0ecrJi6nCR7RG4ltgC3GQttJTRsWLLOJ7aSyySA9ZW3ser1ECZ5RvurazhrNd2g
         YPfHjCRKuUPePodFIYy3PAVMcKQr2CU0V3oihYlDvWlKKE1kMuiXxFkuAr2YkAg4OPpJ
         hWeVhGM1jO7ISEBIayU5M/nbMrjmLkt+fp7hdsaEJf8Oa3wibea/BcXwgZEsOw2Oc0qv
         ZXww==
X-Forwarded-Encrypted: i=1; AFNElJ9YxkgVKR7rZjwPhvXKXH0r3QSl7yqFTUonMgBPDreU564xTrxLXccujOnrLKoBtSdCc1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5E87/FCF5Y1HoKR86GzcjCqwKi6GQg4ddSUDzHxS8LDDJlbu
	PwRR66RuzA078ZeIX6OvsTkJFAN7LEO35T5qK8f2jpVqL0Gm9TgK47R5HmCTypIWHCBXH8B3Avw
	leJBOWOacIAqqUpxYtQdhSaW5dbFUMxhvLloVqnFu2Dzpn4HCxYWJA3235Je3kig+YxAaYsnD0L
	Sfkk/nWqrZIiX/Qa3ljm78F9iTABJv
X-Gm-Gg: Acq92OFcNVwP0C2U4ZHM64x5vfPtF5PfIAzSQm3cmKaH9YQuSSTNl99bir2cCc6ilrI
	fiqweYsrfrnTt+wBRrASVo3wydFI1N/S7roOsU3HC741giXS7QLzqUH/vVCfZjs6C3HbEQhnVxl
	oiqXtwbI+NegdmpY7Z/2DVk1hiWmYUEEM1hwvUXe4gdwFgr6OccRtNpiojHr/Ue2UUObz5WREjV
	scME7JBV8avyn0Sb0QNkyEIaeYfE8Ltz6QyrbqZN8U6R8OoYtp5K8BG/zPqDkIaoJTBFsyXNTXL
	qL0c+QyH0IALlO+YhA==
X-Received: by 2002:a05:6000:1889:b0:460:1987:7bb9 with SMTP id ffacd0b85a97d-46030753534mr7686115f8f.29.1780678655553;
        Fri, 05 Jun 2026 09:57:35 -0700 (PDT)
X-Received: by 2002:a05:6000:1889:b0:460:1987:7bb9 with SMTP id
 ffacd0b85a97d-46030753534mr7686068f8f.29.1780678655186; Fri, 05 Jun 2026
 09:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605164516.2214533-1-maz@kernel.org>
In-Reply-To: <20260605164516.2214533-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 5 Jun 2026 18:57:22 +0200
X-Gm-Features: AVVi8CdXD2dFjV3hwOcMaVAYJkQk2Ss55TNM_5tzf_zqwGUWPlvODfkGX82xJFw
Message-ID: <CABgObfakiK_xLU_buKA_TknQNMPiKKo_=GMhgP71i_r8jPPY7A@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.1, take #5
To: Marc Zyngier <maz@kernel.org>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, Joey Gouly <joey.gouly@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Wei-Lin Chang <weilin.chang@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 6:45=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> Paolo,
>
> Yes, I said that last week's pull request was the last. I really meant
> it, honest. But people (and their AI best mate) keep finding ugly
> stuff in dark corners, and I can't sit on this stuff much longer.
>
> So here we have an assorted mess of bad races, broken userspace, and
> architectural bugs. What's not to like? As usual, details in the tag
> below.

x86 isn't doing any better, so who am I to judge.

Pulled, thanks.

Paolo

>
> Please pull,
>
>         M.
>
> The following changes since commit 83726330748981372bde86ed5411d7b3066129=
91:
>
>   KVM: arm64: Correctly cap ZCR_EL2 provided by a guest hypervisor (2026-=
05-29 10:04:00 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kv=
marm-fixes-7.1-5
>
> for you to fetch changes up to 17f073f78fc43280891ecde8f8ec3f84f98bb37c:
>
>   KVM: arm64: Correctly identify executable PTEs at stage-2 (2026-06-05 1=
4:07:57 +0100)
>
> ----------------------------------------------------------------
> KVM/arm64 fixes for 7.1, take #5
>
> - Correctly drop the ITS translation cache reference when it actually
>   gets invalidated
>
> - Take the SRCU lock for SW page table walks
>
> - Restore POR_EL0 access to host EL0, avoiding POR_EL0 becoming
>   inaccessible from EL0 after running a guest
>
> - Reassign nested_mmus array behind mmu_lock, ensuring that vcpu init
>   and MMU notifiers are mutually exclusive
>
> - Correctly handle FEAT_XNX at stage-2
>
> ----------------------------------------------------------------
> Hyunwoo Kim (3):
>       KVM: arm64: vgic-its: Drop the translation cache reference only for=
 the erased entry
>       KVM: arm64: Take the SRCU lock for page table walks in fault inject=
ion and AT emulation
>       KVM: arm64: Reassign nested_mmus array behind mmu_lock
>
> Joey Gouly (1):
>       KVM: arm64: Restore POR_EL0 access to host EL0
>
> Oliver Upton (2):
>       KVM: arm64: nv: Fix handling of XN[0] when !FEAT_XNX
>       KVM: arm64: Correctly identify executable PTEs at stage-2
>
>  arch/arm64/include/asm/kvm_nested.h     |  4 ++--
>  arch/arm64/kvm/at.c                     |  6 ++++--
>  arch/arm64/kvm/hyp/include/hyp/switch.h |  2 ++
>  arch/arm64/kvm/hyp/pgtable.c            |  4 +++-
>  arch/arm64/kvm/nested.c                 | 33 ++++++++++++++++++++-------=
------
>  arch/arm64/kvm/vgic/vgic-its.c          |  6 ++++--
>  6 files changed, 35 insertions(+), 20 deletions(-)
>

