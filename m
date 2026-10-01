Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC703A5E64
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790875395; cv=pass; b=p7xEjekfatfXd2ZMcuiQCMQJ1FxjK1BDmmSIcWnewaSj55olQFA5en0mZfnHaYtUGJu7PzRPXOga62qxCkVqibykQU9kK2ODgNiplWiEEUJcX4H7x3eQwfXD4fuBf7+Tg725laQp/r1Ff9PWx7DyTzH0bMtWcgzvKg4MD4KERGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790875395; c=relaxed/simple;
	bh=u5/HMj3CdChqx/OnjqHNwMZ4vGC0r+b7BgrrwRCt8O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfiAEbxSYHHFGWv3bt1o0mzmGwe7JFu/wg/DTkImm3awOKeG8lGzDxbJdxDisPDrdSi8YHXzqWQW0U5Ulo4z6LUesFZ4eR63r4jgyINd5/XVoGOl15oJpXOlGKf5bDTtwHA+Xq6ESmv9DRRYI/sw6zx5mAV3rTucZAfDAh1qTdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsgpwmtM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+DYyP+2; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsgpwmtM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+DYyP+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790875392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5SoYEmzKElkGom7H29Ym98qwP5JJ7+ldvMW5qXiXXtg=;
	b=LsgpwmtMI1Lv672MhpWZfopSZhOju/RgD7DWQsdVJvKOXfjgzE4QquoGGBAEokosbPblIP
	STmDxvxqgHQhNDH8Li6yhhI21bWoHeGWbi62dJA80G889U9trr/NoyOnTrBEZu9tKwhLI0
	XHBkwLm3SfEW7wXVKTG7CoU+9NAMu38=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-qlJh1xsANU6coMBauCQ8tg-1; Thu, 01 Oct 2026 13:23:10 -0400
X-MC-Unique: qlJh1xsANU6coMBauCQ8tg-1
X-Mimecast-MFC-AGG-ID: qlJh1xsANU6coMBauCQ8tg_1790875390
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48af4a0bd0fso1799728f8f.2
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 10:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790875389; cv=none;
        d=google.com; s=arc-20260327;
        b=PIjZVxhzOwcANhNwL20UXlVtIlPYwPYK9suEwXCQ0xBu+7v9LJZCCfjhi8Q7Hp+3Zq
         J7wGSb0OytiORyRo5XlLIfEgG9mgQclcgglF9Zdu8y463rHQgADSgJqoGoFF3WD6NYkq
         zHlLCV9NubKwRKx4vww5hbDjglvBzDKWITsxxMywpYc2kUmNV/hapOSZYayQsFP7lf/r
         vzg2ddTGpFTCygjE0AAwyHvbgbl/96eOtepbd9AvFXXbAReUoNVuPhzxa5RGUmzjTmGy
         YI2YB2pGTqNTbnom6CJ7IAmiQ0PL6zd9GkF94QzwS5b8eceCdwGDit7e1b65wEq95HFX
         kGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5SoYEmzKElkGom7H29Ym98qwP5JJ7+ldvMW5qXiXXtg=;
        fh=2bkYQzOBMBLoWYDTxvxAXyo6z42DeCX/pLBJeedbT0M=;
        b=AHkt/c7tp7cLEfaPkCiio5EvgGdNW6j38JLQGZwbxDsfgc7b/S1Hmww4OKu3OBhv9A
         RXV7cNJ36cSjs0SDmNkauBHsMZ4J9v5WMvIRFK31a0MTlmlkkzl6jzJc1qikJwurk26U
         1mTdBTswXDLrpIBAif1gG19+k6ajx6Fm0gOfwO8g13N7pazdpwcyaPOslKBBQxGcGgwq
         7pTe0dEtxsszioZn5dEnSmF8hguxA/E3dWnYIFakGsJVg7IunbaBAQGLsXomhtkZv/cK
         w62LtNIAaLMnLZGglSKs98RSJzmDmaMpuOL8Se8emO7nY2Yzrkoaz0pDAr3JQG2jFMdM
         C/+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790875389; x=1791480189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5SoYEmzKElkGom7H29Ym98qwP5JJ7+ldvMW5qXiXXtg=;
        b=N+DYyP+2w3rmkAMR2Vl47E8+7X3E9aoLf4Mag55+v6YoLHqqKV3OY1f3TfiwBq7Tq8
         gF3yXobZMFLGaGSXyLjbgBM2FLIN5BvZqai+AquXMriKJRaISaVgiV626sROUUkBd+6g
         s9WXRwKDnYxlLI/ZQJD085BoZj8iqLI17bjV4A0RobbCi0KyyCtplh88EvThSRHjuK6Y
         8DUPVEeMKS+EbeMrSDFWVczYpcMBaGG62DboY8xrC9aeXj7pKP8NiSQdOJ4AG0UIGPwL
         MpGiPzeONc9x8MNLztBmBGf/tKSBzPhPl9s6Lb1dsb/KpXYu1mDGRZCXi8d0NWL98+UE
         I5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790875389; x=1791480189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SoYEmzKElkGom7H29Ym98qwP5JJ7+ldvMW5qXiXXtg=;
        b=p8jiFSC/2+TyRNQk410lzx0dqa0jBeg+aVb66K4qeuvvZ6glEB3Upd39erZvJfUICX
         Mfnxi+3lURDwDqnSNw72ax8U0d3US0I98Dy/CELt15+ezj0HJAToAkBm4TbvFrP5lFxm
         opTSOtF70aQ8TdLLe8Ja/M2pevliAlzm7dS8wO3PKzh4JCHMfzKMv6/WvVeXtmq6RxBe
         57a1aWPVOuj/MxQwod/jNZrXZ/cpNeMyq9O0BjFoWWI9hCtSVisjCV1axnarw7VXNz0B
         D7crDooZ1QBK7lHyrVpue986/8or2AZdkqg/2hSDdph0pPqpeN4jg8iO/UHPW3Rk43TP
         +mHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwErKkJKZrX7aEgZDYVOQ/UpI4sLaANO3cHOEzOMAZ9dpLtQlLZlyW7a7olUpeayS2lnKs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWq3EZIVPtqb6vLFHjQteOKrnAXFlIvdzy9FNA+hyJnApyENMm
	/dWWcHFokPtOAuJslOmMeeUNciSyTzMEsxJ1FvUJwQBXyt3pQUfz/CqkL5jWcusizmkyKI8Ehbl
	XGHwWg2h0sfr9H6ItI8+kfKwueeqWxbG87BXUSInHy6zXP4SrusBjmnc6ufucRdFanuJvUh62a2
	+SlCpz4CkMVeLNBTazObGwnA3yAeTn
X-Gm-Gg: AYBFou3HUcTmGvOH+Ypgg4vewmXDv09nj55a7SlE35PE0HAxrcq1lyLrZXmg5suxjsa
	0NMd13BDRe2VU00Ak79lgL2arQcuh5J90dQOFec0j9tUzCG1RlzIYrbWh5VaZ4KU23pSx9PVbc7
	rJOiA2/kImHSwUZxWPOSPy8btN6aPAFcRVFev/uErGQ9y/98ii/YB9Bin4xI032KLdQ9agkEDpF
	XJ2Z/BclCCgBCMWeYrHn5hePFWf9tzdAc8PyswFIDOt61vsQEjH5gu24RY=
X-Received: by 2002:adf:f584:0:b0:488:8352:cbfd with SMTP id ffacd0b85a97d-48b1275c0bamr297593f8f.46.1790875389653;
        Thu, 01 Oct 2026 10:23:09 -0700 (PDT)
X-Received: by 2002:adf:f584:0:b0:488:8352:cbfd with SMTP id
 ffacd0b85a97d-48b1275c0bamr297572f8f.46.1790875389262; Thu, 01 Oct 2026
 10:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ar4HJw9zON0mG2_t@kernel.org>
In-Reply-To: <ar4HJw9zON0mG2_t@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 1 Oct 2026 19:22:55 +0200
X-Gm-Features: AclHuK-JbEz6Qj_Cdd61kEB-q91RWVXCa2Z9BMHFYGHf6lD5dkvwRUXQ_AoHM8M
Message-ID: <CABgObfZhmJsjciLG7U2DVmRtzL0nHnqytnRwEoava9-sCT=TUA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 changes for 7.3, take #3
To: Oliver Upton <oupton@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 9:09=E2=80=AFAM Oliver Upton <oupton@kernel.org> wro=
te:
>
> Hi Paolo,
>
> As promised, the patches I was waiting on have baked and we have another
> batch of fixes for 7.3. Continuing with the trend, the VGIC is getting
> some additional attention, particularly on the handling of a vCPU's AP
> list.
>
> Unless there's something truly horrible brewing in the next couple of
> weeks, I expect this to be the last fixes pull for 7.3 with Marc taking
> over the tree for 7.4.

Thanks, pulled and sent to Linus.

Paolo

> Please pull.
>
> Thanks,
> Oliver
>
> The following changes since commit bc502b86a3cfd89e6740f877c90d06b0263593=
5d:
>
>   KVM: arm64: Use stage-1 leaf size for VM_PFNMAP (2026-09-30 11:03:16 -0=
700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/ tags=
/kvmarm-fixes-7.3-2
>
> for you to fetch changes up to bc502b86a3cfd89e6740f877c90d06b02635935d:
>
>   KVM: arm64: Use stage-1 leaf size for VM_PFNMAP (2026-09-30 11:03:16 -0=
700)
>
> ----------------------------------------------------------------
> KVM/arm64 fixes for 7.3, round #2
>
>  - Take a reference on the last IRQ loaded into an LR to prevent it
>    from being freed while running the guest (Marc Zyngier)
>
>  - Ensure that the ITS MOVALL command only affects LPIs that were
>    previously affined to the source redistributor (Marc Zyngier)
>
>  - Fix + test for honoring the host's trap configuration when running
>    non-protected VMs while KVM is in protected mode (Fuad Tabba)
>
>  - Use the host stage-1 mapping granularity for VM_PFNMAP mappings at
>    stage-2 (Mostafa Saleh)
>
> ----------------------------------------------------------------
>

