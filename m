Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B43CA4B5
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773753340; cv=pass; b=UnF8RKwSasrzWVqGslJy0BNF6mJlxQ2nmr3o80Ut0EWca8It5NSqIdhK7uxTkBQId49Ax45RAMvr1rwlwzoJ/e5kkN0G+v6sThtmg+8NOhZlkXJh8XkTYuXobjm+HvEQ4fcer+EGC079NcjD2nQkduAbfaX1YBrPdLFvVq5Fa6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773753340; c=relaxed/simple;
	bh=5KnNZAmiFrisbKk7nR2ro+5oWD2jYuHGrIlAPJY2zZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDGBTdYisNEs1zdZ8xE+sgTfO3tCjQikxY6VkHEVkWvZrIWkyHFgyDz7/iVA6gtwJzOJsGejQiaMC84f8d60z7gzHTF8omnuv9wSCOZjKXBbx+JWsNejGJey6ZFWQNqtz2q/jvMvBU69bBW4YU2utb9cMP4n//5Z9oZk5GoMxlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDJbFJeg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMPYrxF0; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDJbFJeg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMPYrxF0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773753337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5KnNZAmiFrisbKk7nR2ro+5oWD2jYuHGrIlAPJY2zZA=;
	b=HDJbFJegSUXevDem605GjOCLz1QFskeGCRdA5KJy0VdzbfbfFmRC7nbDqbmq4P++/+BDiJ
	uYZnaE1r6JMk/gvLCzZraZC4LcKFMFZp7KfuvdNADXfl64XSZfGHcT3nQHi426Q14kgfM3
	I80tZKIwj4pFnnXdOnu3FqgFbIY1ef0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-Cug1Q7ndNfSF_oNMDR98Jw-1; Tue, 17 Mar 2026 09:15:36 -0400
X-MC-Unique: Cug1Q7ndNfSF_oNMDR98Jw-1
X-Mimecast-MFC-AGG-ID: Cug1Q7ndNfSF_oNMDR98Jw_1773753335
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439c794ec8eso5469242f8f.1
        for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 06:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773753335; cv=none;
        d=google.com; s=arc-20240605;
        b=FNJsJBZ0uYH806jjW+g97+BKyf+s5IGfYcNxeJ966WIf1qOR0yjxzSPL0Jq5ifmIv+
         9qZ1+2ZwYad4JkF+aQavKvTtgA//pam9ppHw49xhgjWY+kNUNm+YyJr085D2I7yk33iX
         rvYnsx9nJ1EcwGbLkGYihsdWnlR8mzkaW+dgAiQfuHWWNOqf+HW7KGft6q9DKEr5CJce
         1/8EWQKJyPXEIW+/Ma2duuDtPPq3DVFvR3w1J3X4pIkc2oop02eHQN28tLCzYo3rPOvy
         ilABeCtp07Op5lUKG9Tf8AvqA5TUCOdNxfbbkggOrLd/ZNJ82n1EW2lqh9r/2aGPDQc+
         tadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5KnNZAmiFrisbKk7nR2ro+5oWD2jYuHGrIlAPJY2zZA=;
        fh=31pOVTBNarmTNDZPnpsxO74ZB/jgJE237l/AJwiZuKo=;
        b=hUJqfbZ4id0+dl7MwmR+IUezza6+4L1ma9Pb652agqFQbdHAgjOOy32cHZuVbz4Q24
         cQG/8Er0X90R7pXh5F3TgvBlCazv/+2T8tINUVfSOVnEyl73L2A7vFtgwB6c3gH/Mfh3
         SHzIGQLjxd9Vv3CBxPs+2hoXMU92AGbfrcsg72OPH+0MtnuDt8nQiDpy363d3WAsBHfU
         MQK2FjXTdtW2abXVRLiKNCiYwMw5CbdDOYc+0f/2E1kh+Z6XIckAXZczE9NRzeviBYWX
         XIeFMSCgDcfJdhNhzGPiKJtIvHNVsm+/B5bEfLxt44hbi27LKyt0pBrRZUGcks7Q73DY
         fqxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773753335; x=1774358135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5KnNZAmiFrisbKk7nR2ro+5oWD2jYuHGrIlAPJY2zZA=;
        b=hMPYrxF0AUeQEH5qTXSWt1zRazamGE3f7JDOcvuszgCD1d9yosQmM0ZjR0dyJHWbJD
         hnF/gvdehdSw9lnzRzJnD2CdUVlbXhWdnnipm8JGKegEWZd8k62foMyL6NMEfOgVcWnJ
         vnLJkhvfkLrlYQ8cpQRmhcXTCu/lTpGLMET9/UxwsBb3vYLsesBAqNPMgkJUB95T9aVp
         Twj99/hZxcNzxQoLFFEQ9Bu/uLMMk3wi9zyg9so/ugA7SfG251GetRma4gpzi8weOtng
         hYfuA5/ffPdBNIzOo+PVuSUKttbAShJMX881lUDq3k7PZutJLHdtEoyv32VTAZgvuLC7
         x8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773753335; x=1774358135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KnNZAmiFrisbKk7nR2ro+5oWD2jYuHGrIlAPJY2zZA=;
        b=EZfb7la8EwpTjtfBhUTOotC/okQuzuCJCEcEMHWEg1ovhdsZXhhbozUgTji4rgo8I+
         GhUf+Jeg3mSoa0ExR+OblxdaNizsyfq7BTLdqt8+i8WCYbszh5G7GuV6ImiFViX3So/j
         tpeU4L+UMKOqn89/MtJKYuoHamaTplJS6XMFUKa3vymmKWS6po5/kCTOLXrV2LbFY7XB
         gZLRL5gu+xcSGL2Nmfv/bjNRm4hZieX1b68W7uYbcWmUudwLtBLcqOkbZGwbRcScoK4m
         Qo4dm1v94FHBc94BT6fFbbJ6LYam6y1onLMNh/xB8gBvmq3EZcQLBtmJI3IGQ28QYApk
         MMtA==
X-Forwarded-Encrypted: i=1; AJvYcCWns1TmLoi3qv2hejMjOOwYIEed2XyC7w2lpbishT/gTeJ2Jo2OFGiCWb3p68AXLtpzxBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPDG4K9JeUpXTrPm1bgE6DjyRL1WGGVPUNPWxUtjVjtR9v5b6x
	e+dYAFwNt95ewDyfn4DMc+AxAx8Muk/Dg/gm1LXYcZ5UETvnVZNhlQlhOjWArAg/PNWzKeqg6eE
	BWMq7zycRwjv6oi02X/n2NBPIL1ozNjDlxpQhrJ1L6XvytAEuz6Wn0CRAwOMYCpOTwDpsyX+2Z2
	kDUzSV5IwZiY57xvdC7oI+dMoiT1RJ
X-Gm-Gg: ATEYQzzg1IStXZtndAuyM7Q+pXdLdbj11Z11MngDgO5s+MVpDn3Y6lmlT9opfidfna7
	Fi1scCOqtaQz9CY48OQj3E8RhZ7RMDTmixgbbUv21hmNR87nLxxZOTg7xSuSfPe5Ig44ZIPB1JF
	ZeO2AO43GxRbcZsB8LAIByckTw2M2K+3jFszLUDY5qsNN0dJiRz2xc9hl6U/I1yJEa9USc13fWT
	i9UPB0DZyB+Ia/f+CiVkV/FPrCZ8qxjci/RusZXE32ee1HJyAKjOKSwQvNFTcXaU5zHEx9KzBDb
	P7b9d+U=
X-Received: by 2002:a05:6000:2dc2:b0:439:b440:b8b5 with SMTP id ffacd0b85a97d-43a04dc049amr30913018f8f.43.1773753334880;
        Tue, 17 Mar 2026 06:15:34 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc2:b0:439:b440:b8b5 with SMTP id
 ffacd0b85a97d-43a04dc049amr30912903f8f.43.1773753334274; Tue, 17 Mar 2026
 06:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313001024.136619-1-yosry@kernel.org> <20260313001024.136619-2-yosry@kernel.org>
 <181d8563-14a2-4429-9e18-ede7a6aeb030@redhat.com> <CAO9r8zMxLx7fGGp1JPWatGNauY8fZvSECNGzC+o-p41BZrRGFg@mail.gmail.com>
In-Reply-To: <CAO9r8zMxLx7fGGp1JPWatGNauY8fZvSECNGzC+o-p41BZrRGFg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Mar 2026 14:15:21 +0100
X-Gm-Features: AaiRm509GAyQLRJwkXfrP4nMjoVV-1uvOfbidPpprdj4Nf4zLGYQi3d_fQiDYa8
Message-ID: <CABgObfY__euhy8YRpWbkVW8V2q10HS0nXmRQrfPOkt5iENbCGA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] KVM: SVM: Drop RAX check for SVM instructions from
 the emulator
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>, kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il lun 16 mar 2026, 14:49 Yosry Ahmed <yosry@kernel.org> ha scritto:
>
> TL;DR is that the emulator support for VMRUN/VMLOAD/VMSAVE is
> broken/unsupported anyway, beyond checking for intercepts and
> pre-intercept exceptions (well, even that is broken), and the RAX
> check should be after that architecturally.

Agreed about that, just ripping it out completely would be fine. It's
only if the emulation happens that it has to be complete.

> Given that the goal of this series is actually to stop injecting a
> non-architectural #GP when KVM fails to read vmcb12, I didn't really
> want to derail it anymore by making it emulator-focused. We can
> probably do a follow-up on just improving the emulator support for
> these instructions as I mentioned above, as that would take its own
> series AFAICT.

Agreed.

> The only reason this patch exists here is because the buggy RAX check
> in the emulator results in injecting a non-architectural #GP on 52-bit
> MAXPHYADDR platforms (the #NPF scenario described in the changelog).

Yeah, that part was clearly broken when physical address bits broke
AMD's 48-bit limit (and I don't think the details of what is
considered an invalid physical address are part of the architectural
description, for example some SMM ranges are carved out by the
VMRUN/VMLOAD/VMSAVE microcode).

Thanks,

Paolo

> So the check is blocking the goal of the series. I didn't really care
> much whether we fixed it or removed it, but Sean did not want to fix
> it and have the emulator directly peek into vCPU state, so removal it
> was.
>
> I hope this makes things clearer.
>

