Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350423630A5
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252156; cv=pass; b=Yh++Ri0PhI/FnuVMMaEemhZXPDu6YTtkhsZJ8xW68V+/Nc9zZEgeiPMk2fniBXS7u7ZhKhNI97gIh1PSao52JJjlWBFKJgQKUjw5/zz4FfmLPj3WjQ0Wwh48Yp/2TU1a8Il7QToUU/syuY2327vNwLrXdnnHbpeiGcPOSvE+ojs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252156; c=relaxed/simple;
	bh=gKkkV19wlmTr3/xCsbfGBsR54oN4UlO4vCnWRgWlt20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tN/9vQIOI7MNldoqGkCbQo23hBUwmr0vDloPDNxT3K5ptWYmtJWECjFDenEjxH4EkOnwEaRYGZktVqyZ77AIhiTe9IZNIxyfNjtolzhNKu9LVORr/yD6kDfNOppUOcAn6YyXmUrn1geGPATBBsRJ6YMsJHWnY0eLBKMqbK6KGgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bhs2VZq5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=czFZ55pK; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bhs2VZq5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="czFZ55pK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781252154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkzgmag6RiSVdTujOEa/DO5ShgseE/EIKALr5M/fiUM=;
	b=Bhs2VZq5f/jVbVE+Mq9EHRzvqs3OOddRUiVFte5SPW/ouwK8FulMRDqBDXixM7X8ju/mFp
	edDWDNj3+Jt7fLLJUpYswX02AAPhOpm2OajW68c9ySV3pfghbtp+niPs89op/QUELWRrlt
	jJV1S0e1qiva/rWitrpBx4Mf/Lo7img=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-IpBk-jiJNhiASUueY_yw5w-1; Fri, 12 Jun 2026 04:15:53 -0400
X-MC-Unique: IpBk-jiJNhiASUueY_yw5w-1
X-Mimecast-MFC-AGG-ID: IpBk-jiJNhiASUueY_yw5w_1781252152
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0532a6588so7526345ad.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781252152; cv=none;
        d=google.com; s=arc-20240605;
        b=YojvihX+WHp7LeOPZ2OF7eMnIcTnNSfczta1VaZS0Ax5uy+E8sJ1V4jXJ8FzjnMaKQ
         cMjJbsPzyxZE7GNu7tI3S/JdPeMvcfhVggbmGRpFa7Vcl7Y4n0I6fyZ6FbVJ6puOXBNX
         /wG6Svnpl5OfXjqEplr4HjmXoDLSDE+wOtaH7Wuk50nbBijSuGFbUumG1NkYkBFvZsf5
         ICf8yve+S7Io2zcRXSm9nBvMtaMHeJ7C0LfGnJjYgxcjlEhgG1W0mCuBCePWD5yHyRZ8
         t0bJy8THm15zAeqUK8KErnWNqcdPincvINVvb4UuwcnEafxbbvLEEmRIArDJvYYdGc4B
         OleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fkzgmag6RiSVdTujOEa/DO5ShgseE/EIKALr5M/fiUM=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=Jbqe1K/7yezpBfjLz5qpwCec/o2jP86XhaayVd+8H7ZwoEYq8zH7Xq2REnLQqqmVNE
         OCSqvo7fy+tuJXWbzvMHUWUEUfCWvB8ODl5HrYWvAUvyGX1SocjEhifi+U2SO6pTyzKt
         f17/3Xut+3+zaBvURiiLh8VLnm6Dp9WEDstJtnEmUQiT5xlCTq9GS5jfEt2NwSfsw2fp
         +Dd8fpSAQe+Ns7e8ilmiwkiBnw70IFSRC3P3YCvaTt6Uki4E2icV57ZJqpfM3Py+64tA
         0l4SeczP+Pz6H74f72IVO0U9WvX+Knd6hIVA+gZbxIAh55OnjifbeNIKSwAVJn/TFmNW
         ibYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781252152; x=1781856952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkzgmag6RiSVdTujOEa/DO5ShgseE/EIKALr5M/fiUM=;
        b=czFZ55pKFbd0DiYJ+PbSopdfnyfxv4k4fXWrcv5Ih2Xi5tgF/FR+z3NMnQx0uUBWVD
         NlW02yb6GJNNLJ7BC990cNzeIMuHJLUCZrV5L9XXc0mGYd9F8q/Gvf0kinmv467cMru4
         tsVinWBo6059JMkSvM/8TG0MEBXkMq1pA+pTbwvbVCGIiV+BXl78FtxNxPk9Bfu8pji5
         InjLEF6wa9waxTF3xMmp30YY7Y/Gvk2Pj5c5fOoviwKh2+hIvm3pBj+P0uAus7YBIcZ3
         aGqjSAe7z6WMh5l7etDvTv93dzsXL2dTcuctRCjcJfwNmOfVcxVcZz9urx2JEo3JL1jf
         KbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781252152; x=1781856952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fkzgmag6RiSVdTujOEa/DO5ShgseE/EIKALr5M/fiUM=;
        b=Iu18r5S+kBVj8sCQHdzFngotJILF8ba1qwhJf+DtWIf8BTBz/4KtkwNMnqEakQj5xs
         1/Vq88v8tgPwQGiNRGvhLpXxy6ZVXRH65ULrYefPbXWnwRhITqhEOmgRheYdej91wJSq
         7eAJCyCjctIJJQuRePWRdCqGIO4Hq1W0p03yjd8MunYiP0/E2oJQfG7x3gwtyX8ex+3r
         Z+60AOceQXh7L8UT1iC0Bb2Muurp1MAo9W2DY7aAo4eQy/6fNJKrMpzME7t7SJe2Liyl
         I/f3r3THTsYo5PFxTGcldzyhoxiPnyZNfC8Ue3WhiHIvn1GjuxuzhXf/1ecqGPrztmCc
         3Lzg==
X-Gm-Message-State: AOJu0YwPsdM5wRqQFMaLWpaqYgWLdI1sVrpbVW17k4LhXnUBZHiTXUgM
	j9WjAGhP/jzud3qWwqOLugWMCmzRMZIscmOJNtTUPQsHN4NmH65e+tPtiOi1/c/ucUsgrrSJZJQ
	GxF62EU3h45PboNaMsMGgMTK5Vlc0ZpxtN1FEY4vexnpybqza45bZ1grRVNQwJvCsdpwTPmgM+Q
	1HFIIAS2TJRKpHVNeb453nfIHc5oQazJgfaT2M
X-Gm-Gg: Acq92OGcurdtnJYjT3CKcpg4t2WhWo594JAZZ0/FWom9p1xA+D6YS4bRNiPqvsFuZLl
	Qyq9VK3NnR64kray+9518IwGn9bVvxputvRXb934k4S3VtXYlbTNiMLhmSauQ5YP1YPEaWqApJM
	RmabJ5AFOmW6LOR75x12dfUYwZTi0s/KIySxNedK5LAaqwoBE8OjQwQM66y+RyOJNMJe5bu6mXe
	yUUDOSJphsCcLT5bUMhJqoFELIGFQ0ZgpfQHnTSSloBeWn4rwdok4ysB5XcHNYI+5ILaes/963g
	79AEQQ==
X-Received: by 2002:a17:902:c401:b0:2c1:6020:7398 with SMTP id d9443c01a7336-2c410fbec97mr21514495ad.12.1781252151819;
        Fri, 12 Jun 2026 01:15:51 -0700 (PDT)
X-Received: by 2002:a17:902:c401:b0:2c1:6020:7398 with SMTP id
 d9443c01a7336-2c410fbec97mr21514115ad.12.1781252151290; Fri, 12 Jun 2026
 01:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com> <20260612004755.349925-10-seanjc@google.com>
In-Reply-To: <20260612004755.349925-10-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jun 2026 10:15:34 +0200
X-Gm-Features: AVVi8CezT2kGO_h2SlI2bLyo8MLWTQxnuSNm4rO4Vxcimuv4RGs6TRUX_-YzzDU
Message-ID: <CABgObfbOXx468LKpQNTRbjzHk_yc_BtcNT=R3uvnoUWicH3mHQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: VMX changes for 7.2
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 2:48=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf18=
87:
>
>   Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-vmx-7.2
>
> for you to fetch changes up to ca674df13b195eb6d124ab059799d4e03fa40624:
>
>   KVM: VMX: Handle bad values on proxied writes to LBR MSRs (2026-05-27 1=
6:41:51 -0700)
>
> ----------------------------------------------------------------
> KVM VMX changes for 7.2
>
>  - Fix a largely benign bug where KVM TDX would incorrectly state it coul=
d
>    emulate several x2APIC MSRs.
>
>  - Use the "safe" WRMSR API when proxying LBR MSR writes as the to-be-wri=
tten
>    value is guest controlled and completely unvalidated.

Pulled, thanks.

Paolo

>
> ----------------------------------------------------------------
> Rick Edgecombe (1):
>       KVM: TDX: Fix x2APIC MSR handling in tdx_has_emulated_msr()
>
> Xuanqing Shi (1):
>       KVM: VMX: Handle bad values on proxied writes to LBR MSRs
>
>  arch/x86/kvm/vmx/pmu_intel.c |  6 ++++--
>  arch/x86/kvm/vmx/tdx.c       | 38 ++++++++++++++++++++++----------------
>  2 files changed, 26 insertions(+), 18 deletions(-)
>

