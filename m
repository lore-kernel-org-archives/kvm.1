Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE64AA57F
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148397; cv=pass; b=PniEMGB/IOcoPIdEptn2NKXCJb/KzKNDzTvk5WyTcUYK1chKCXRK6b2+poknX0Tol97yK9yBHYEBWtrixUifeQ5PZUvywagiT5IxQl1KRtIXX2DsDzOgoWsbLEDCqMgXyus1D/P7ndYaimmX2OtK3ENzBIcyfiNLljDeuVWFUlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148397; c=relaxed/simple;
	bh=NO/W4DWn7EPZ1yS2Pt6eiEseQwg1SQfroMdxjcEEl74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rc18VUPlhNG62iadfJAtz+MGg3QEs9whhFvfOG7IFcU9f2kJc7UAhFU5yDGWCJjpph2vMzqpFrAvmznhD027EzUI2et6qsGRHS8xmzZGTNpKOapYGRqdTVLVDWIfjEUiUB1YUnxYMgHSC2Kg3Y0qtBe1mCKaActT0TIp94Tjdgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+wzf5gD; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+wzf5gD"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9a26ce21aso2242a12.1
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 10:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789148391; cv=none;
        d=google.com; s=arc-20260327;
        b=dTU8dtgjxPEbqd5I9z3Gv2olBbi4arkXFCQESkTBVW9dAZwWDz+7TcxSyHrLhpcw9n
         MvWLeHvy5V2U/cBaxf4MddvAT7v40ZRMYT5Q0ZhdnpJ4jaKC6/PExrhm7yvJKxJKyJ0K
         1F6cIUz6LTbmZRDtaEOc038HjWj975vmEDW4vmD+sCcIzobwgzlLDhP7ryI4UeLAqZnw
         x2AgwO8XReAw9DS5r5RSyrZcYQZiUZAXSaQAjl6DGwqIB8fXasTuWgeuD3pNnBGIDGjY
         PCve5NutA+8tumAc5pD8WWRUAIBi5MHjXVKCwd9KTjhXJNCWOwTwmTtEetSkj9v3pJAL
         zF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NO/W4DWn7EPZ1yS2Pt6eiEseQwg1SQfroMdxjcEEl74=;
        fh=Bf79pAF0XTmvz9zAqAVO1L1htDQY5liaOkZ3JYnmW2s=;
        b=JxGfPjdhRT3yJWgisTstfZllKKpSW5gxet4J087h6L/ChOczseGQJHenlzuGzdP+7V
         CYMjzHx3lQgxHJTW893fFs1as20/i0zWU5b/eZSqkvj18UNIQ4M/rbf+7ymYndWpha6I
         IMr1SOUmSaCcBrU9cqpNzFHFQG4Yvf8HwnsttfBTH3jZyAJqej4nIi/Ra1IDqt+s5Oks
         V9SNNfp/nSGR3Ot956c6T79GM5cyCH6to+zJ9pOGqwcdUvzR7GAbW1Yp3F3pfW6HNvfH
         ppMViehdilRiQh0jveWFd1SYvpyvwGUY9i/04OWMxUG66AFSfQnptSS5MTp/lewaoUUS
         1miA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789148391; x=1789753191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NO/W4DWn7EPZ1yS2Pt6eiEseQwg1SQfroMdxjcEEl74=;
        b=Y+wzf5gDdAjJvN31ndTPQatU9eRlMBR3mwyJqDCJmTCgl5odbeO8CWb+eKRNmsh4wN
         K5eVgyPeed1zyxXTwlQvLMtI2GO+dwLZuFVXyXQocn1vqPKqzHNxn9kyGcsTBsLYptvB
         RloRmmWevN1Q2Y+4KX1C4y/YnHOl84yIpT4HGZUDODwczDM93uFBWqP+UhGbfOyoMV9q
         XQPDNeclUAJt0H1nm22CiPr2G3g0r619shI2eKIx0pEulNQeb4XYiv+xzSZnyrIFs/vy
         zPLf5zUOj+gSI9uG1AsdLDe/wrUcPXvc50geX83Bj5f6Cqv7vxaeTiau4iZ6CwNWElTd
         Icpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789148391; x=1789753191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NO/W4DWn7EPZ1yS2Pt6eiEseQwg1SQfroMdxjcEEl74=;
        b=qXtNWQOgsYj4DBza2kIcWV/U3Q22xdOBp7ZfNTSlbYqPFmSYLgluNUk2s4v4Vc47VJ
         KpxfpPgHbYxpeDSNzdl2zsqXy5INzorRloU7SfOlJGXUi7ExVSQHL+UunTMacRqRE+sX
         +dyVOOYX8wGk6QJ80R5/IiC3KUdgSsU6uKHHClCiYbgNvjck9mOLNiAgixQHDbDLf08+
         V23ZDWHBPriEFAiMMf3Khl5rvO2K0OFgARiRX2CrvL/O3YU0uxBn5zlMSLY5gTRc7nMf
         FX3NPChUOeEpZB5CHGGPTOMSUnCLC3wg1aPW7juhGq4QIm+ghOTsLWfUSks5NQjGxpmF
         RH3g==
X-Forwarded-Encrypted: i=1; AKwUvBwoeag0LgeyZaWKqdyeKvV5TOa3zInYDyzck5zAPNxn1WHD2WYdKxKcifxxzJClIxknjno=@vger.kernel.org
X-Gm-Message-State: AFuF++k10g6wSJW8CVqi5kKCoCCwnt3eCSUYZgBMxrsJ9hX3zdtb6C+u
	lgxfQx2htA3d6yedzQn+ml2FHTdeAGMC1UEv/VM5zp3mM10JuO6hJcsy/Zeo3V8T/podbTF8soP
	eX4AYcKy+wMtRQsIMEfUWmVVnlVBcmv8xUuE4qRhh0xqLz1fCWWCwM0Yg
X-Gm-Gg: AYBFou0iqmkZOztpvjYy7oxsax/uaO+CXjTS1Q2RCI5OXt85gQfpbtAduYNwsj4Tuee
	WIrm3iWo9dx5TflzkISPg8kV28W7wkT+h6AaleQwpegWrMO0VGrbJijIL+pRftMI6M3JGMvxFAy
	eO0Ifr4w0DwMC9JcdpZBjkiVVu5VnVFd81tEKU0IoDUyaH1IUq30g6SublKFXm3l/OF1le0CI7c
	ajE/kwcMLRyCzE7zthU9oC2G5Uyhdig+6FRbLKJYUJ/iGpLb0AcIYhxpq22BAqYf2dqz6ToZbkg
	EZcUc0qwf3etRZ6NCpeAgmnZf+qHO9FGXHRt0u3S9lsbNPkOBpEaHWA=
X-Received: by 2002:a05:6402:3987:b0:6a6:967c:3186 with SMTP id
 4fb4d7f45d1cf-6a9cab59a3dmr2722a12.2.1789148391126; Fri, 11 Sep 2026 10:39:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com> <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
 <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com> <aqGsukcRG6khmxpt@google.com>
In-Reply-To: <aqGsukcRG6khmxpt@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 11 Sep 2026 10:39:39 -0700
X-Gm-Features: AcwNN1X2A_hxZ5GZwsDJmDi2mwtjAoPaaSIS9kKhx7UswvNj-QNrz6kZOK723cw
Message-ID: <CALMp9eSG0F9yv_KfYpWk58Ko6ZPcVArijguF=JF61NVVnuAVVQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
To: Sean Christopherson <seanjc@google.com>
Cc: James Houghton <jthoughton@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:00=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> So, as an immediate set of changes, what if we do this over ~5 patches, w=
ith patches
> 1 and 2 tagged for stable@?

By "we" here, you do mean the Royal "we," right?

I just want to confirm that you aren't expecting anything from me. :)
