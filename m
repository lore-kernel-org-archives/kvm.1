Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A13002DD
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779523482; cv=pass; b=apIXFQYVCH0++7CY9KrNNbB3z8CSEx2/wCY1DMjPDmm4ex/oXGyb2GuiFdXwvGCkv1Cxe8g2MkwZCuRQVwYkOnmMvqRan4ao5WVbUlW2t/EuXaU5oGCrB/HgaUFgN8Z9LkEJ47VuOlH8d0f5WGhCVSIpua4PcxSyu07wHmVsHtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779523482; c=relaxed/simple;
	bh=K7Vnv9KOQb+dC4E4MeSvCa6bjIyrn4+Roa18WXG38yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGJ5wTlA9haaM7Ibb2btlj0KrCRuSxGTLND5s0N48zQAuFz5m5qFRmwHE2FY7XzM5L9WW4SCX6SpHwrE0YiAJCVAYzsOzpFC4oYUJp4X3bDZ+a7R3xk9RGIrwbbj3TDYjkCfk6dR1PKOObwdVfJeYl5nRiaf8hMo3KjTpkwzVq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUMbx/g5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/uFCpRB; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUMbx/g5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/uFCpRB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779523480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttamByqpUXp8gDJ2jEtCsLRWhVllrayfTGFh49yK7cw=;
	b=YUMbx/g5Judza0n8AwMpiqEKwGEglvNldZMmTM4AhSvzxH2KHRRcY8aUXAKCga8gw2pAyo
	J7MKw8afaFBHOB39plifUpAoLvTLm3yvLzrANlzY9qBnk8l0AvF9MhXonP5tg19XEEYfC6
	FyaHhchbCW3nxOLhfErecKI7ClanHvc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-A0KRICZdN7asP6a9tPlsIw-1; Sat, 23 May 2026 04:04:37 -0400
X-MC-Unique: A0KRICZdN7asP6a9tPlsIw-1
X-Mimecast-MFC-AGG-ID: A0KRICZdN7asP6a9tPlsIw_1779523476
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d9ace59efso4919685f8f.1
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 01:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779523476; cv=none;
        d=google.com; s=arc-20240605;
        b=jZP71L0PDCnYBX99SQAiQw42XGuWqbJbdC0T+luDLw0MOaMhru5Cs10iM2Z69EmLz2
         FtjNLgtP0VMww4ZMDdwmT0cKx8pLK2iScBO6hTRDGY6hMjqjOG7rl1FnUs3JzVrjnPsB
         DMaEOQvKqBdCOfmGlVxPnnERhr0zWQfzkjYUgbJRzBQleF/dCKif9qnO4zsu/Hj3YDUJ
         gOxLOWPtr8LTmOj62n/IofjTge12URbMMCYYBu5jy9fZFHXLizJdXfk99PTT8z3/uGo5
         VqsUEdlIP1NXjiDlRWUJ/L/PikfdboRWJKkdCxtua2EUrofLoD1O8g/DPNaACkjTDITQ
         BAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ttamByqpUXp8gDJ2jEtCsLRWhVllrayfTGFh49yK7cw=;
        fh=5Lw/HGKJ+8zJXISiApHzH9cgJ56F3WHZbEDIJ+izNqs=;
        b=dAUnelUnpS0mv9ADeeT0g1rSWxPEtGM336yvYQvH5NpU6Kqf/0q2N3jnsu6BvOYutD
         VNxRpwkIKRw0gp2SKPkdi94p8qEHcnkjk1vYjE0ewACnh5rFHh2HhPUr5Yk2D0CSiVW9
         OG1Jqgrjpmx2YTH0tIKEDlHUSuV1ZlntOTaes3IROYKLG4F92ce+nrw3V3GpYb7LaL0M
         +Aat9MYwjfcFZWS62m8w7PTHhAumMjxXR+zAT8Twdt82UU/be120uz2CEWFFgB4fndpH
         QkXMfPPfqlTX+keGRvluxfweoit44xetNaw1WVx2Th5LxIjMN7qDHxwwFBOWP6wE2L2y
         dT4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779523476; x=1780128276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttamByqpUXp8gDJ2jEtCsLRWhVllrayfTGFh49yK7cw=;
        b=e/uFCpRBLXUQX0h7iJptCkRb/WzsuI6fn885SoFvyQalh+/VQ0TTDHIc1+CX++lixq
         kPnU6ASxxDHF8pUsqxr6LmUy8XhkXtwClcGe1SykatiJSktvajF6HM8J0FmYhUNQQfVA
         LETeN13SvueEEvaNGmTX0kY0muPeWrCQM2dUpm8ETWHj41CCCL48cOUES1UKOdyw5mo1
         5dyYDzL9MA0//SGuH+P4+UpdfeN9AyKbkcpTnzZdLmaaJLwiZjBj8FJKiShzTXjRxIe+
         Sb1cqaC2IaNehpKXSAwLd9XwBnPzDKqrJtx0y2m+T2B7hoNcIbd4g3Rpi/TVr1JyaYfP
         nyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779523476; x=1780128276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ttamByqpUXp8gDJ2jEtCsLRWhVllrayfTGFh49yK7cw=;
        b=YxSesOBmiSyF7zMyxItDuttSzx1PI8QSfowuwRiJv3EA1+srkPWWErMc5lulWOgXph
         +oe1FWvctn4Gp0VTLfnHLhEpX2cJbj4Rdx16v4VrbkQaIJtkIWDUJlUXurmD6oveCX6B
         cvVGNMCnsV5wO08K9REZUwg77zABq/Xnqjjb/UnTG3ZcyLgRmfNX4wugtylrD6Hoaipc
         d595KvFc6OJdHlO5B5d8VAcJ7Zj2t0ZR/ZNmaTCuZS8WrQZkGi0wLSrRq00KztST4rYB
         DvTPrR/LY5Dj5SYOTeNN0tcaW68SXHgvt09C/ANW5+Nws4OKOmG9ysFHpMvpOkWHBJ5T
         LsAw==
X-Gm-Message-State: AOJu0Yw5kbKm8cnnvU2OY9M25hJBkJkwPdT5D2mEl1fjUfq6CV94BdGr
	k5SGuZFp+NeYXtiN5KBCL7gAI9IcnpUnmOUQjTwPr97mRfP6gvO9yVHP+/eYmFkX1vHJszii/hG
	b6JUCqHA0f24ZNHYWHzT7c353vQ2MT1CWhQRHXL8hbJm3FTDpXG3FvBasKpErC2cYkgUbIikjvV
	uBUfnRExpKLIvo50eY07aRnZ9GJoT6
X-Gm-Gg: Acq92OEiiohRNcVYT9AIM2WAU74suyysohXUEZnqqMFyJJyO/O9IHv2ehCC713YSKEQ
	wMGirW4H4iml4xispPxhM4bKvTOFYZ52tk7akAlrAC2epUnKtD6N5To81Y0Y7wpwTAzoRp05YLP
	JQcMQFgtUYJqNhletvLtf6ztD15zckhftmQ7O7F3R/y1ktiRZuY9JxA6nHFzFYmSooFO/1E0Qs6
	9mYlZB33sMyLg+k9zZS8eIK7mPJwuAJ119BtvWuWTxh55OK7gu+0hf0lY5zPE4E0hQkek3PwK05
	ZglpAE8=
X-Received: by 2002:a05:6000:1888:b0:45e:73a5:e5e4 with SMTP id ffacd0b85a97d-45eb38b9243mr10583130f8f.33.1779523476056;
        Sat, 23 May 2026 01:04:36 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:45e:73a5:e5e4 with SMTP id
 ffacd0b85a97d-45eb38b9243mr10583059f8f.33.1779523475505; Sat, 23 May 2026
 01:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522122951.117120-1-imbrenda@linux.ibm.com>
In-Reply-To: <20260522122951.117120-1-imbrenda@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 23 May 2026 10:04:23 +0200
X-Gm-Features: AVHnY4JHAW_gQrvPAHWDAel_biT7NF7yn9kNkYJxpwYTRO3g49bL9AydaXkpZHE
Message-ID: <CABgObfZ9sZ=BhOMVWNO8pg5JjQmZ6=PNo8dEv7O5VfhrT=LzPA@mail.gmail.com>
Subject: Re: [GIT PULL v1 0/5] KVM: s390: some vSIE and UCONTROL fixes
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, 
	borntraeger@de.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 2:30=E2=80=AFPM Claudio Imbrenda <imbrenda@linux.ib=
m.com> wrote:
>
> Ciao Paolo,
>
> please pull this small, but important, bunch of fixes for vSIE, still a
> fallout from the gmap rewrite.
>
> Claudio Imbrenda (5):
>   KVM: s390: vsie: Fix memory leak when unshadowing
>   KVM: s390: Fix leaking kvm_s390_mmu_cache in case of errors
>   KVM: s390: vsie: Fix unshadowing logic
>   KVM: s390: vsie: Fix redundant rmap entries
>   KVM: s390: Properly reset zero bit in PGSTE
>
>  arch/s390/kvm/dat.c     |  1 +
>  arch/s390/kvm/dat.h     |  3 +-
>  arch/s390/kvm/gaccess.c |  1 +
>  arch/s390/kvm/gmap.c    | 18 +++++++-----
>  arch/s390/kvm/gmap.h    | 61 +++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 73 insertions(+), 11 deletions(-)
>
> --
> 2.54.0
>
> The following changes since commit 6779b50faa562e6cca1aa6a4649a4d764c6c7e=
28:
>
>   Merge tag 'pci-v7.1-fixes-2' of git://git.kernel.org/pub/scm/linux/kern=
el/git/pci/pci (2026-05-21 15:02:12 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-master-7.1-2
>
> for you to fetch changes up to 9029496abfae3c208336855ae6f3e1f5f881ef76:
>
>   KVM: s390: Properly reset zero bit in PGSTE (2026-05-22 11:25:11 +0200)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM: s390: some vSIE and UCONTROL fixes
>
> Fix some memory issues and some hangs in vSIE.
>
> ----------------------------------------------------------------
> Claudio Imbrenda (5):
>       KVM: s390: vsie: Fix memory leak when unshadowing
>       KVM: s390: Fix leaking kvm_s390_mmu_cache in case of errors
>       KVM: s390: vsie: Fix unshadowing logic
>       KVM: s390: vsie: Fix redundant rmap entries
>       KVM: s390: Properly reset zero bit in PGSTE
>
>  arch/s390/kvm/dat.c     |  1 +
>  arch/s390/kvm/dat.h     |  3 ++-
>  arch/s390/kvm/gaccess.c |  1 +
>  arch/s390/kvm/gmap.c    | 18 +++++++++------
>  arch/s390/kvm/gmap.h    | 61 +++++++++++++++++++++++++++++++++++++++++++=
+++---
>  5 files changed, 73 insertions(+), 11 deletions(-)
>

