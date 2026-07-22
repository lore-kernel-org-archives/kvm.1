Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54257215075
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784760466; cv=pass; b=K5VYEuP5Obf9L9nPaoN5OT3J6nwkFmpngv12JykHPtO+BBQWArRZNTUpkdKDzjx0bScu69rkOn4iNZqZtoVCdQhdy0LCpRiSmuSsihHE2z9JLbVx726CtlNAEXLR1SHVbZe385sxWivD1laetimQtwk4atsxs5T5dMOq5CWulWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784760466; c=relaxed/simple;
	bh=pRtzImDlruyh8fdPLiaDvJbyRN8Voc0nNsK55T/akoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5UAPye0mk7coerMwmy4E4vJwbVGqgJ4pqXJqN6NnxcotZe2ZGSG3T2KPPQPMp64/aXc2Al5seX4kiEueEya7+sLFxSnQOktsTS9a+g13GxPzEQ6gpCnlbjrCh9RYh31yC5O91uyaqudke0254g8C6gldvc0j2q7IwoH8GiEn1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUrSlAZZ; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUrSlAZZ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso1325a12.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 15:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784760464; cv=none;
        d=google.com; s=arc-20260327;
        b=JMXVFyjXeySzK57wBJPHQ9U63THp0b8DrxsSPA4TeS4QV/OqXl2roD9JSRhoSdZiIa
         qBDBS8R0l/V0c+XDEGndYMltAgZ0LnVwMaWjkE68O2r45xTgk7jeUUrmLYfrU/oWnRUZ
         CID9VNGvpAF3gsbN8/UYmzlGSeFk8XAp6GjDH0mpNdKwIC+Y5a2gm1anLebKVFLtKtiw
         uYa9TcFNVaA9dtXpAjI9Xt49PgpAM0nbZY/jg9vPI+CTnut4jME3y7wwmttuo2pmYUfm
         VoqNqQJK4fWWfGc5sGsSnwx5RYjr34V1SJghVoVqkGNqOQDV8Vkwmxle5fGjOCtQBmqo
         M/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pRtzImDlruyh8fdPLiaDvJbyRN8Voc0nNsK55T/akoo=;
        fh=cDV+asD0F9CPZny5O8nBFMTR20bPAx6niQA82ozmKKw=;
        b=aaCzmbXfdyheXBlFYOp+SzG6Udp1FXrvljAf+JlxwlAD3NTYX5a3UhD94/NpKpD4ti
         7TXrIvkHmiprCo4W8TOxdMbBdBBJLm+ZzNg7vLms2yU4hsY3Cf7RLZMW6ofvBI4Z1JVj
         BZHIaSt7lOwLwImq+2a4JPFNuvqW9h5gU6O4efFd2lFSaT3twXS2tAjGfl4MamKWlrJF
         tjQCCSZkzBADi5Cm4mVmFmkqhmOw3yFeCHOhjjGZfZpnDrEUHf2nN2MJ3lmgo59r/A9s
         TEWf4vmZWL6fIF2XSPuduGNF7PGjFujBKB6N9/k/Y6NxpdpKs/+BJJj78IzTreRiihWZ
         FOtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784760464; x=1785365264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pRtzImDlruyh8fdPLiaDvJbyRN8Voc0nNsK55T/akoo=;
        b=XUrSlAZZh+nWcBUuONMsF0W5KFeWEFcn2nobVpjyLbMFzEgiekTQgpX1kLCe5DqYvr
         dpKwnTUTxzlklCyJJv8Tqgn71AxOpDcE4s1kbu4vW2P6YKRSAqzyFKhLnrKUgd+x6ene
         dv5EoJKymMFCMkOwOt17drxfZYVVlmo93yR6c+8qbiWH/Bp8jRCzE6vPXvabSmS/vNMb
         +behUir8Njv39IPvxL+5QUFz5XzYhWuJTKbnRM0yR0z8h7C9VeRFBxkGteLVTWIkfc1O
         4ob37YstuS2HTjc1r+H0sSI9NPEV86ip7TZ5n99Mjdr4+ZHpDaVy6jahiPf2OFY1WPk4
         wXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784760464; x=1785365264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pRtzImDlruyh8fdPLiaDvJbyRN8Voc0nNsK55T/akoo=;
        b=MARB3ake3vPfQtmys/fPyPGkptFfKlLvxcVVjcNzJRxNGAV4GIMpipIt6I/8Q4C3W+
         D0LuJl5Bd6eT30G5eIQiKNfulWUIiOPds5UpT13SVsIHmcTXaMMW5vRqjDwaB0v6Jn5a
         qR2VzI6gBy7LgQ53meq/Hk5MtRinVIH2zsGq5MxjftHLThLOoWG2jasR2yscPGG6MH7S
         NEJ7kH04QjjHLhUKtRgkuKANJh8+cy8qo/a0Az2J+yOAbcxFhdH08QSiPgFZMnrUql0Y
         lEsQGgAq/wKzlcAh9FQYrzLOmlqvZ3UY8hWdCMQT07YU0YlQSCvtVr0FHhF19CjwbR7L
         bElw==
X-Forwarded-Encrypted: i=1; AHgh+Rojc1N7cfFvmh2FfgIdE8iW9RyxtYZvMFZZGUrPMqN5Hqb6x9FOCcgoabB0GQLBCDam7VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOtXVeTEMkuaarY+sqDtGrtzyr7nH/zfIBXRFFF/yuNgeVtK/I
	mWBWTXwqj2askTcwY41l5LCSc9HQdfdlTzim72+nYRm2Nz8Pz79S22ZFOLFkyvKcbmODQBxsN+E
	wzhFvHIzbZtojcHJv+LqfmdVLCDvWbXe8EPHWQCGS
X-Gm-Gg: AR+sD12/zMWF+QUR+OTgfRTn3OBCUIHbdxUMojkDGgCJoESW4LiAF5ynrM8tQkXpopg
	u8nKjpdJOCJIFglLKDR+oYHsr8fCSXmRgDcJ9WW2XyAAlL0e0LmLb0sjDKF+h6niiKMfXaTdnm6
	o7quMSGy9vFVoipoHLVoEaYxkjeU8zNyaEhCz8DWlmq1Jult9qY9ph2CF/8t2a9gdG8Hf2LRZhq
	P/otVRTiamgfzA7WTdNV2VPjmXmIZOYk3UcHoDTrVoiGsDUKDR1pbi9i0LSNCDAy+uYWgyW
X-Received: by 2002:a05:6402:4407:b0:69f:7546:7563 with SMTP id
 4fb4d7f45d1cf-69f75468289mr119a12.3.1784760463094; Wed, 22 Jul 2026 15:47:43
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-4-zide.chen@intel.com>
In-Reply-To: <20260629231938.15129-4-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 22 Jul 2026 15:47:30 -0700
X-Gm-Features: AUfX_mwsKRrItuub7mqDliu5nM9vDpJlbCwcoW3JxcK-saJ3lI7y8ioUokIfKyQ
Message-ID: <CALMp9eR=UfzHqCt2P2ROpNP8eb681QHLQwJF3JGxGS9x4yx8Aw@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities()
 to pmu.h
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 4:28=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> This is in preparation for it to be called from common x86 code, for
> example kvm_need_rdpmc_intercept(), to check the guest's PERF_METRICS
> capability.
>
> Rename it to kvm_vcpu_get_perf_caps() to indicate that it's part of
> the common API, and shorten _capabilities to _caps.
>
> No functional change intended.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
