Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2723A640C
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549536; cv=pass; b=bjkk52+RqrYNRgCQUFohLW9jFqNfXs115b+V+vVgu1RD0LkfDS6vM37Inp1EErCWOf9NNPLEFb5rK5WZaI2rNj14L5trzgsTigt4MrNmIRHLpL/TQU9GQQWYScN6Izn+JFZACTmknZld+9T6xnUrq9oObmXSrQGfX+Lf7fz/4Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549536; c=relaxed/simple;
	bh=Ju4GuypyYdw0ImWV7ufhXgfThhO1xwtog0FALkHkh7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qe1WmQNn90O3NwjoGYLY9cWCtS7JLHQlmE3OaBglqNmpLLPhGpwWFzV8KzV5SBFu96Ery3d54iPHeQepZp7Q8EtRMD9oH5FssD7vHiW0T8LwXeDesuEqSomwqa4d428OhmH4x1kdd9UVcF8RYi+AKIhmhHxFtV2yGeHi+/6n3uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WAY0gTdh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddG6tUSB; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAY0gTdh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddG6tUSB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ju4GuypyYdw0ImWV7ufhXgfThhO1xwtog0FALkHkh7Q=;
	b=WAY0gTdh6Yf7pUGionykx23jVOQ44COTnkmAwdg5AGmWt58YgvEaIlJzPE/bx2HzrbZtot
	EygbusRXg5DmmTFDnOFUyHYOO3TF/yeEO4LeU/3bcsKuM+0hT0ANoWSDELCqkIxcKqtPmx
	TpHkOxbBTtLKkndinzqxmViJj1cmpRw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-joWRmIZWOM69dPv2HL9cpg-1; Thu, 26 Mar 2026 14:25:33 -0400
X-MC-Unique: joWRmIZWOM69dPv2HL9cpg-1
X-Mimecast-MFC-AGG-ID: joWRmIZWOM69dPv2HL9cpg_1774549532
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b93781cb8so977390f8f.3
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774549532; cv=none;
        d=google.com; s=arc-20240605;
        b=XqcfCpzMqmVo5di22e8cjgrdNIq9OEy4pKocb+ZTX0x8xJKrM2t4gmah2mQ6LFeXVK
         2mxoWgHcWIuDTLbMmU4gccToIZatZyjSQaXciiwUriqfJ73krhHL5Q+FR9tCqFIRTjCu
         9FVOl6fDMqY31Z7/jhcLofk+Y2VKUU7Q0kY3KDR+KcsWt9Rvp3Kkv7nCeWTyRSQmJsYE
         IpStbr1/iL2tirs/sOrNUXi1awlIke9xgxHxZ/e+ciqSzT4tBBE4yq0MgbgxwdMYeX1L
         AqGJH7o89+knbjBKbiGyFlgjLOPzOS03UhnrOIv8fV0GrYDhA+DT+kplvhSLauzuYhT6
         8mFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ju4GuypyYdw0ImWV7ufhXgfThhO1xwtog0FALkHkh7Q=;
        fh=ERAwXdbgOwSo7vs9e7iqyfoxl7FJMj0JbuZe2VUrPPU=;
        b=b80avF4qaIaOUaD3bsDt9FX+jKXRR7D+yPhyF5IiJ0ybFpWDbaIsEFepPE0hDIRSOk
         xAn7u/wTldk3f6gOvwGctpxO1qm+X69YaSZVuO0crYfv+88KlY8vrWbQAfqtcZADvoa8
         JQGOhgFVzCccfqmkR5PzB2Rwvbd/69Ahpf5gtKY5vIsD/SsCwUdliHXGpkbBxQkzQQ7M
         lr58a+UMTgqOK5gvWkesDJYgEYWtlnB2hr3TvzNOF1bo5TakPnDmrrrWaDe/WlqgbEoQ
         GUkS61pRisIlY5YkiVok8DhtU6DS2R1lH5EAdvi+umwnzjVnOXsHJn3Ccc3lmKHD2/5y
         Os8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549532; x=1775154332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ju4GuypyYdw0ImWV7ufhXgfThhO1xwtog0FALkHkh7Q=;
        b=ddG6tUSBnKyXWs5EYuBWPXhkHCNk3qiwgnXZcbCx8mjpMFq+FqNvkbu8qJOVz18Fhy
         dM68NIAd5aRzC6tOEMgS069TrCm6g0/YXYn+5fszylQOoULw/BUvVekmSW0V3/7ayMKK
         +yAxWUH2nF3ZfrGp3OnI/N2ASuA9ildmSlfRYUITkXDZolE0fGL9w/VFf2GCXtQ8J51G
         IKL5TQTm2w3hFhrrKYJEznF7dYOcOoY7sUgGPW/JN1i6l4E6NE3DhUfBdOVZSYEJgFMX
         vf9/Xau8ePAdzVdLTFTgqc3/P1cBrGGSaIjnJ+F7L65Zpq0+rNAVBaPxKYTI0iWCHz6U
         uT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549532; x=1775154332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ju4GuypyYdw0ImWV7ufhXgfThhO1xwtog0FALkHkh7Q=;
        b=n5QbxLf2/gTJLlnh71Q6mF9EVtRyEY71DstJmDpC+lczKbqBL0OkjVS1Ij6kZmFuq5
         SCsIQUCnLk3jQKz/uSyaouCaQd7GvQlqftE1HJ1mnX/o4nL/EJyvX7vwuPnpMf+dxJj7
         bgw8vbYccqnaYVL8lqOkygY26kROLzfvfvMAS+JTQ5LyvhDo4Wc8ynB8KR16gKr9NHhp
         TxZRJ300CHTNEAkdKORenDVGkt0tA8Bqv8t44VsSP1yQazRiJlPEWxLrBQKGnIJQmS+G
         5o+ZsrKcA2DnBm74vekcTMGj6hzNfVPOozBqGJCQY/Us4KdqPETZJM7tQRtKTYfPKG1z
         /1xA==
X-Forwarded-Encrypted: i=1; AJvYcCXmbYSr7Y/JOlEB9aLzGg8E2ClI0fjrmvHa5JasakKu1g6LT8y8iqYs5nijA/3+SiwoR34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyLnl9quzzW29LBgq973/R+WSuJ4LMrxR9t0ReGyLHFXUEeqpM
	o8Pm5CDa5IxsCqPLhAAOpDqwoOlezZ0Vojie6LQ14cT75FOCL/WwSL/3M1gVfyFUh4ikK9acKc1
	4OsE7UyWv2MwpDV5YkCvuHNrNWemqhahNQF4+4fF+IsNgiXt/N+y9zMVTZPwct7bZ4X1gJfMWjf
	cLEw0KJbOtpEeS6GdfdqcbZqNMNiVh
X-Gm-Gg: ATEYQzxUw5SOH7b2Fs840W/jyk5ItrGkIIPnaexEPpBioDsBUshCKz4wzUzPD2l7sdS
	X64fIaCOk08XJwFxzH21t0c8Xj9063nctQhLrPYvqVwSqkWwKzh0g+/B3gXJRUHtnJDN3ASWnwf
	+yqMkIUpsyRLKsuVcAyxcuhUE1EsOUpoVvUAuCqAQgU/0K31iLi9sdZOF+DAqBtyUI/Pss/HG7P
	hXycwycZ2xp/Vy3smZ8+isogPMqIycAbl6ZhEVQuzQkdvJyWeM9T+U2f7IoyGin53FCslyz5ZZI
	sFTd
X-Received: by 2002:a05:600c:1f12:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-487160564abmr131776465e9.16.1774549531556;
        Thu, 26 Mar 2026 11:25:31 -0700 (PDT)
X-Received: by 2002:a05:600c:1f12:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-487160564abmr131776075e9.16.1774549531118; Thu, 26 Mar 2026
 11:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com> <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com> <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
In-Reply-To: <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 26 Mar 2026 19:25:19 +0100
X-Gm-Features: AQROBzA4Xxa8YCmGcRxu79Svr4HUz2dOQ6f5ejBx1X38OfhAGi0MWHQBY_m3IsA
Message-ID: <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, kas@kernel.org, "Qiang, Chenyi" <chenyi.qiang@intel.com>, 
	"Anvin, H. Peter" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, kvm <kvm@vger.kernel.org>, linux-coco@lists.linux.dev, 
	"the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il mer 25 mar 2026, 18:21 Edgecombe, Rick P
<rick.p.edgecombe@intel.com> ha scritto:
>
> Ah, I see now! So the problem is not that the kernel is accidentally
> re-accepting the memory. It's that host userspace is not actually
> removing the memory during unplug. Hmm. Why not fix userspace then? If
> the memory is unplugged it should not be usable anymore by the guest.
> If it is still accessible then it seems kind of like a bug, no?
>
> And! This totally justifies the warning. If the error is ignored, the
> guest would think the memory is zeroed, but it could have old data in
> it. It's exactly the kind of tricks a VMM could play to attack the
> guest.
>
> Another option could be to perform a TDG.MEM.PAGE.RELEASE TDCALL from
> the guest when it unplugs the memory, to put it in an unaccepted state.
> This would be more robust to buggy VMM behavior. But working around
> buggy VM behavior would need a high bar.

Wouldn't it actually be a very low bar? Just from these two paragraphs
of yours, it's clear that the line between buggy and malicious is
fine, in fact I think userspace should not care at all about removing
the memory. Only the guest cares about acceptance state.

Doing a RELEASE TDCALL seems more robust and not hard.

Paolo

