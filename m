Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6326D2E888C
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584472; cv=pass; b=Dp50ewehP3vX7gNTHTRRx9K62DYjzaj86F73Mt1ltUACtD5IemFSHuLhUqNOeg1hZuZwB+h/uQ9UW0EYrabLFk3LwTKZALUlpIAWucGXY2ggkhOBPTNY2hmXd5h+hPWqaSfkygM5mkPABKCf9BfX8A+Kz13meUJ9CgRapDeA8p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584472; c=relaxed/simple;
	bh=cS36YC7Wu3PtL9qTsgYUx0lM3dO2E4U9fKR5NR4EZG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTaPFm1W8cmqn8tGPmwKgdHFRqi5zPokK3vQfddIZXyIhVq+ajNTT5FoxqBnttqHKqimfNMjpiSyXzPRO6RQ0UhtXIFHtJKixSW4Y57rmYr/PUwmM74/zKYM6X8hqj97ssivmv3BS83WObh5Y/GHFM2wv8lUsecSy9YVj5XMvRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQAqBqX4; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQAqBqX4"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bec49f7e35eso109716066b.2
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 07:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780584469; cv=none;
        d=google.com; s=arc-20240605;
        b=EcQ4UZ51Hv9ssBHB2zmo7z6zNGg0UpT3QCj03jFdSq4X3K6Xjgla0CSD9B2MWhy2x3
         bBHU4tvI8YAs5e/CsHtzXkgBSqDEnBwQSnaLvR5Kmd22fn/nAobaR1FPbKA3tTtkUQNT
         HQKxMQINeEjeeI+PtBfzEzHNGU2zdGK4kp+ObR6v3+2h7WtSLr+ORR/+gjvpsjWkjsXi
         pmuYCR5b9NdF7k/E/lu/xrEQ2pY9MNYQetf9fihXXwppDtrbo9DqtbaY2xxBeOglmsNe
         CIgXdSAzgVFF3Qt6k8YhBr05DIZ5iiBj9DZJ2166IwuTFT7htREQgsIkM81zUCUp7DRd
         BBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QSjd1U/70yhpLCdfTmik43TR68lZDDCtC2Km+f9O/NM=;
        fh=U7ywUlR1a1xkEX4aAb9u1KGtdw+OV5mh3AQ1G4gxriY=;
        b=GnqsOb1cmA7tkqJuRjo3xY2eCfzX6O1qQ+XwHd+wHIBCv6/0unMuzc1S4YvStxTYSi
         l8UkcgBXewlyhWd/Ogo1TVvE7jnQ5iB7Hd2+Q3JKRBPh9orht/mjVCyYJPBxUfw+WMhH
         ktPuSAzQnjwpphn1p+C3OAJm5lg9oB/j24f17voD6isyA1RwX9+7iC80oBtcTEEQEeMg
         5AtYq119WCOtUI6g3gFFqkssAftx9QvyZkNbY/+GlTWM76Pfgq3HbqWPOqAe1o2C3L7B
         k9hTJbgKT7Q76k/tB9SbILn9GxhNQhkz2K8vBtxvGV9JWGdsy8oIxIlnSz7AQ44ZYWYP
         VgBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780584469; x=1781189269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QSjd1U/70yhpLCdfTmik43TR68lZDDCtC2Km+f9O/NM=;
        b=tQAqBqX4fCwTAwmDlb9rAHtqViVo0kBwThR1FF3PFe8aC7OQyei6SqBvuuprFXuCaN
         WXvj3BXl6Qna9XGVUwmsEPaspnOsjXAffl6M7OnX/bi10oZoHha81vhO7fI+xgbq0p3c
         Y1LHCPp1OZkXH9huiv3odILQDwVYcoJlkOv0rKk/675j5ixklsSO3EAMoKQhmLj6fU6g
         Oii0ApUeBIvVOdhfw6ZOI2ifo9I7B6q/8J53pbhD3qNEHE9WlmpW+U+t3ACPydNSzfky
         ZlRiBgXYHPosb+P7KF9q88Ee8He5t0MybAXqPvYyC3jMr+8cE//TT2rdt/YaxwTBsvCz
         MDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780584469; x=1781189269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSjd1U/70yhpLCdfTmik43TR68lZDDCtC2Km+f9O/NM=;
        b=X11+r14ufU/1LiYSQHcaqW16ETE/mG3Ci82WIMQ5KgkMO4+2LkEFwlUFaKGsW4ErNc
         kUm6cy+esSPZ4Qz0v464nfgY6/938a9rzlnFZfS7fdbB/54bpblFH3j2aWQCIJi0lIZC
         U4tWmoVkhTqlYYJJ4f8Ii3n127mk2D+PYfbUButItbShVhr8IOIqTEtyhtArKwLI0Ofm
         nuySW7FVrd15S7gnL4Lp/MJ/0eqRsXpDrmDzevU7CSRraSf0aJY0K5jxEmI4HlBbG0mj
         Pmt0IoVlujrx/d/lacxv+9mJ3Qk+v4u5xw0qdMM70SnHaOp1B41tgJJ8cpEgOSbHeOM9
         h3ow==
X-Forwarded-Encrypted: i=1; AFNElJ/e9GviPlp01pmKj6piRz+XiAwM0yN5rYcno9ZbnzV2Us+CfxRMGApJmOYQiR1zePy7ebw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq0brHJAXfjWoChc4l/4pb0ztcmajq4u5Do3guWkjYfrDbXzZ9
	gxdHE7yTwsFIrtVDDkxzeF2gkAg35QdjuV9Wj8r4yOgx4q+uB6MRGh6XhE5zDCpkKzdmts4/Uk0
	rZ2BsFF1/elZ1B4WsVjh8ujAPwnWWWyaxVz90ttEQ
X-Gm-Gg: Acq92OHOu3MWBCrWAJWLTHZgbpYPYffeVKy1FqZkZJuXs2k0H60V2ED0hs5+8/is5jH
	K75KIMr5hRkPnIoJLmWw3lKF3x+MX2YfoqosLq7ti6AHfsPqw42fpbkvt2XnntcdCPY52OmGG8F
	MsOgf4e2X9SULXZlhMOlWMtsOBa4ppgPIQAFcjgcoZPgylTpryasqwjoUzZz3B2QnRfk65GaO2p
	6cQSxT6OEghdmRrX+9S3VaFc5nYJlA2/q83zRu0eW8g+AVKEajrQTPIyzfEnEIwXk/zAGxETekA
	AAGc/pkDkz09ieRFcmYtIp7AnWR8f3uFtufNHkb/qj4d7svyqmdi2GBXGX7h1zTfX9XhhpmNFX5
	zckXjayw=
X-Received: by 2002:a17:907:6d26:b0:bb7:eb68:514e with SMTP id
 a640c23a62f3a-bf0aed0cafemr433224366b.36.1780584468249; Thu, 04 Jun 2026
 07:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69a2d58c.050a0220.3a55be.003b.GAE@google.com> <874in0ex49.wl-maz@kernel.org>
 <CACT4Y+bbQ3qfoy0kuXgTk5H2k=Wrg2t0Ghhc6U6fT-28ter7iA@mail.gmail.com> <86wlzu8ird.wl-maz@kernel.org>
In-Reply-To: <86wlzu8ird.wl-maz@kernel.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 4 Jun 2026 16:47:36 +0200
X-Gm-Features: AVHnY4ICfNLxavuIrQN2iJIGM7Z0iBfnUYdb7BfndwNYy6T9AkyY1h7EA6y1Ohw
Message-ID: <CACT4Y+ZKV6Lq0uBv7ob1cKnVcD7XUvV2srUMDR5R9gxAE_Yxww@mail.gmail.com>
Subject: Re: [syzbot] [kvmarm?] [kvm?] BUG: unable to handle kernel paging
 request in kvm_vgic_destroy
To: Marc Zyngier <maz@kernel.org>
Cc: syzbot <syzbot+f6a46b038fc243ac0175@syzkaller.appspotmail.com>, 
	syzkaller@googlegroups.com, catalin.marinas@arm.com, joey.gouly@arm.com, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	oupton@kernel.org, suzuki.poulose@arm.com, syzkaller-bugs@googlegroups.com, 
	will@kernel.org, yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Mar 2026 at 14:26, 'Marc Zyngier' via syzkaller
<syzkaller@googlegroups.com> wrote:
>
> Hi Dmitry,
>
> On Mon, 02 Mar 2026 12:59:41 +0000,
> Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > Hi Marc,
> >
> > The reproducer should print at the start specifically to address this concern:
> >
> > the reproducer may not work as expected: fault injection setup failed:
> > failed to write fault injection file
> >
> > Isn't it enough?
>
> Ah, I totally missed that, because things scroll really
> quickly... Apologies.
>
> I think it'd be a bit better to just stop the test if the
> preconditions are not met, as nothing useful will happen.

FTR filed https://github.com/google/syzkaller/issues/7450 for this.

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller/86wlzu8ird.wl-maz%40kernel.org.
