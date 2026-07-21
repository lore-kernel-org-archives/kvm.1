Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A55532A3FE
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651852; cv=pass; b=TX1NqvtYlH9GmoA7MSZx8WdyUX0FTmC2YDueQkqjMXUGVs+EXFe3FOU4w1YSTU4Ztor8AsWa3miWgzQNsMeeL/Q0/L6G5xqOeillF0kNz7141ssQLDVXGkRYb764Zu8YskkytOObKq4w5qhLfTTb6l4WLqd1q2XDQGJslpLo6d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651852; c=relaxed/simple;
	bh=aVzR/ty4a/bVQF/s9l7ffmrbnU/SPOo7FIsD6OVmG+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQ59wyjjP03oQo7E8kVkwRQT9lP6yt+DYzIX8f3yb7pvjFIbTzPeCw20aEUWgt3pk5qb39VL7rTW0aElpKOOVbeE8FAqCNmywfcVGjoKQ0SQBvE7NfHnwzIEkglGTNksh9q8reecVed7DH4yR7JY279FB0sqIln+LC71QKRbHXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMC9fkdF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQXd7hUQ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMC9fkdF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQXd7hUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784651850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iutbkgt++7YueaLk7npeqwZ+5objeIwiLgiciL5xn1c=;
	b=JMC9fkdFeKPB4jPdW1gYxqx9GzkINVzzAPvLn8DMK/oknVUfq7lIpuNw4Kei8vOWiTWpX7
	WbfWIHb1lQ/+CUMekrD5vT70m8HZdwqB2dM4lxX2VW5hB6yDCHpB8Miyk/R3KQJeGArabZ
	x+Q0WiWZvItULc0Pu6e7yIomHAnR4H4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-nPro3tsfN06cF8kWg_bm-A-1; Tue, 21 Jul 2026 12:37:29 -0400
X-MC-Unique: nPro3tsfN06cF8kWg_bm-A-1
X-Mimecast-MFC-AGG-ID: nPro3tsfN06cF8kWg_bm-A_1784651848
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f83450a8eso426681f8f.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 09:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784651848; cv=none;
        d=google.com; s=arc-20260327;
        b=WnplelqblWEPTYfdIbaLPTIaHwzDxDXpzIGKTjSCTks61X2UCYaQlfReg2FUhPuTH3
         2qfjzJ4xka6LSNaduo9nw3Zuy+O2YWzBcN3T99j3VYefs2Ef6hJwwW1g35Bk95KoaXIu
         CGISWWY6eVfk5uCAfh+iNJS9xS/EawbXzmwE0Bb9+t2nfpZuyqXLeL3ZEQSo8tP3bWSV
         9V2GGgXSJtEvIpuBHSraeQF6XbVxbKD8ms09LOP2RKXm+4TjM//Hdz2+d/azycn/DdIS
         lS2ZSYT2ikJfToT9wPdeXCVbSzekLfGX5dGUOKdR5qIs9WwBwdgltZN8FkRd2VX6EEMx
         qPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Iutbkgt++7YueaLk7npeqwZ+5objeIwiLgiciL5xn1c=;
        fh=sJfvGJxzW4JUKswJIuG90fQqRSOQ+DI03BsE3MLTAno=;
        b=GtAclRSW5MWRJPZ3BchrCuLrTCn0hRl6DwZNji+YAUTivKdz35dND+kbBPPZMtxPhM
         r/nFddeMIhdhrGhU01RxaJCati7iyI4nGoWj3ERxQYPFaH2BI34tUXhrtoZECvXuiycZ
         /NFKONov/zZtZhrJ4AynDmhz1c4XhHsuzfjw9XIioZCxjiL/fvlpIf22GKqwRMqI1zLi
         DuhnoPVs8YH2tIpPeYuACXCyy7vnW9n2Ca4KKUG14sGt8WoecMav1t5Oc1FauONydYUT
         Te8XGGCe2Y6punDonx9B+UMAcXTjY0hycWZwzUn35b8+AMlpv2xCznbaoa77STGFgwnv
         peXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784651848; x=1785256648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iutbkgt++7YueaLk7npeqwZ+5objeIwiLgiciL5xn1c=;
        b=IQXd7hUQpFRsK8TWyy4HZYk6Rx7pW3wUpFzQmA1T1qikiEu6Nngm7ODDJdb1QTVBVz
         xxGo51APl6qjkdxXtmNFWRtVPTxX6ymtOBQzgnT3RQaj64s0iTLLaY3CV5EO/RPoefXU
         R4ce/yQ4ufg2UWgpFxdkQ4vTqGepLJfIVIEfL8hPdXGeF7wAeV2laqEsCzByQmBaVnkB
         DyG1KgNAjYpHNwbCvHZm4DOw4j6Qk80ApM6eH/q6ivXP4iXSGuM2Ols1AN8VwbkzG/mO
         qdASBTezvGFF0g7z3jXxbJvZHlHbLcYLpKjiBVhfpLoAUBXGzlv1W1k7lIksT7HmBV34
         T79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651848; x=1785256648;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iutbkgt++7YueaLk7npeqwZ+5objeIwiLgiciL5xn1c=;
        b=SeCdVlE6Tq94Ku2rD2vxHGOwYX36Yx2BwdY8GNYN+elFDtx7CELgVgKeCtSBsjAIU5
         8PCYB5kMRRslwW8uYPMIxmNsK/JDWhDnHkfedONUSrapSkEcs8Nqp1n+gxFiq5szj0QA
         ed17sJ/Xemz/5yxLl5Lx/53qPFaK+rZTYjh+/aKfr067N2OrvfSgBA3ZFeNQqxUCM/JE
         fxJNg6fcQgxD1r7zfRCbAVYKWB3qHhoZLWtyJbNeG/xGmpxDxdtLy4O+Ov4XJUfJh+lT
         CqnhUY5sqoPaDeeot6VVyW6UsW9A9NJ//3wf+WMj/gGODSrf6vKACLIMFdx+1JvQ0nlA
         N+nQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrl5RYOT+HwnwmEEtGxKDxDCiaOcsX5Ac5ULGpiS3OwHLw263tqeV/Uy32WjZikTxaJbFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUUiZMPw0axYbI2Ph8WgqOteyD8alzYPTJoqInPcLszf9FTHB
	dRRmK83W7H2w6qx1orGuFXoSr1972QHHPtzsKFwuvqJ8DOZifDibKj+trVWpV4uoSuK7Zhr3lfJ
	zCttNVB/DVdSVUztrytftr7EC1yueIzTsFxc+u2FuW6Y2rJEQOXzuGMdD+E/mWQQGVwmIZtrFV3
	+YY5g5L3bflux8cih3+MslUjVy14nxEhHdxipB
X-Gm-Gg: AfdE7ckwFX+gsKDkiqtE0nA7jtJ8uc+VOIwdGUvjuL+/4556NnnDu9Pcl1ZNDNpxi+9
	WueyoC0vpNQuZOgMv6QLBbUMMOVVZoHFGA8XxGbO6ctsYNsQvyFkvwzdm6TBnqkpzGuyPrlOVha
	Jk6znD7bTbZHIf1q2Ybi8S3ehSyqJTWpMCG5xv47131ZsIZs3PKTjuTUoiwHySEhupMvprjFvsA
	TH392Rlhmj5NaydIqfti33g/ZtHG1D1QFMS88yGKt5qvNJqzK7fswS46uk=
X-Received: by 2002:a05:600c:5850:b0:495:406f:dff6 with SMTP id 5b1f17b1804b1-4954a4106ddmr158406865e9.33.1784651847857;
        Tue, 21 Jul 2026 09:37:27 -0700 (PDT)
X-Received: by 2002:a05:600c:5850:b0:495:406f:dff6 with SMTP id
 5b1f17b1804b1-4954a4106ddmr158406685e9.33.1784651847465; Tue, 21 Jul 2026
 09:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721102827.313208-1-pbonzini@redhat.com> <20260721104819.B5A101F00A3E@smtp.kernel.org>
 <al-PSX0sOPdYdvIg@google.com> <CABgObfbL3t21yVeSwiLSjjOUER+rTYDPHYAH9YU4TWGRjx6XHg@mail.gmail.com>
 <al-d7WPocYgEtgFU@google.com>
In-Reply-To: <al-d7WPocYgEtgFU@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Jul 2026 18:37:13 +0200
X-Gm-Features: AUfX_my2pzIWT0klO9x4--we7SaT18jk2dGJ79eGAGyiguyCxBNpp9RUjAdC1qo
Message-ID: <CABgObfa2C0fk4JTVPduZmcFnyyxsOvJfBS1s5Uzgf1K+LX-OEQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Hide shadow VMCS right after VMCLEAR
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 6:27=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> > That said, I am surprised that VMCLEAR/VMREAD/VMWRITE/VMPTRLD do not
> > have a memory clobber, since they access internal processor registers
> > and the compiler may reorder them without the clobber. Fixing that
> > would also work around Sashiko's complaint, so I guess we should do it
> > anyway?
>
> Ya, good point.  We should probably hardcode that into vmx_asm1() and vmx=
_asm2()?

Definitely the easiest, even ignoring INVVPID/INVEPT...

> INVVPID and INVEPT also need the "memory" clobber, no?

... which strictly speaking do need the clobber, but in practice their
effect is only visible to the next VMLAUNCH/VMRESUME so the risk of
bad consequences from reordering is non-existent.

Patch going out soon...

Paolo

