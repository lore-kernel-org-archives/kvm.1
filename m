Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2436D9FA
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268075; cv=pass; b=n8seekf0ElqmLX8z1SPATGsAuRq9g+XeuZ4i+5ZXCV7osbpy1z14c0loAsl8HEPyD2ydDjsmPXVVTuolHOfsW2ffLxNEQtYw3m/G62BAFrcoup8eRp+Hy4HM2/3lhFlSNMslkx8QMyAtEpkZf3FMhWgfTGr6z6MMGcYJQxDmoys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268075; c=relaxed/simple;
	bh=o6sIWPBJgGD5HPh74qm87n9kIJwicM4myAA07K3cY8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WL2mpBra9x4kP+VEGyskFmrDJX3Mq+xTsVnjzm6fnU7Pdt9P9BKP9WYUCFl8fsYAAoqzZiYny4mLLdI4cTDGnSCxbAl5Ft8W/WqPa600ssX2QdR5L17K/uW+2ucXCuamwJMPf32XlAcC3tvgOnWrbcZJTpzOe3ZIUfJrciogJfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6kE4vxv; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6kE4vxv"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7de7c57b52cso1830209a34.3
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 12:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778268072; cv=none;
        d=google.com; s=arc-20240605;
        b=Ru0iUHZi7jQG2Pkcb84PmYV/esicj6nmdvdQRo2NebTnPp40NytqDi2eZO9pnzr6I3
         ITVCAZTSKrQ0eI2+EzjIa0UJCqJdPkd2QcAY6ym5VTueU5kbMrI7HjW0uxI9abk3g+cr
         +VS0vjPcH/MX3s/ilqAK0OoUl4AGaZ7nyNaoumfAu2kK4/s527J93MOwaO07K8u8Bph2
         rWuIMPDRgFnP0iHvLlnl0xau9Drm1CkG+HXnc+dDc/eeB1R31ubZJ0We2Yu+rltMBt59
         1v8dIbNfUMcBdL81QuLctBubv9lLJg4vHkILs7YRbXEK4loT1YL+98yOtZbVY2bcI/sX
         sfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o6sIWPBJgGD5HPh74qm87n9kIJwicM4myAA07K3cY8M=;
        fh=1sfC/vVRAcDPuXXsfxdVRPY1qJHGNCGRlLHWluK3ezE=;
        b=M/EI1OhAlGzb8DmOM6KJjPm56+wESz0Pdbd1xTf42nbEa8vh5JgqIo9R4wL8DvLuIo
         4CFj69iMvRhmkg2ZJjRqgi3WIBxXaLXqSTvc3qnkcQhRKOd4a7qgr+mdfstFfgwwvOdg
         +9tKb73ANBJtaylboukcYwb7XhqseBmIOdP3vvb8j5njTjQp7R1XEpwIYz/D88IQVXoM
         CYT2B45j1gbYRxPaE2fWZLe83pw0T1MnMLF5TZfwYA6TYIRx/s9nVBT/UK4h+CVqWJH4
         qvQ31XWWYNAV+w2t+zB2pyARPD0GiE3QOxMTOt6Dh5jDH37SyS4ceO4l50Yy2a0/JJ2A
         1W5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778268072; x=1778872872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6sIWPBJgGD5HPh74qm87n9kIJwicM4myAA07K3cY8M=;
        b=c6kE4vxvxbMz/af6hVyeTM9ok5oGb8zy8jE4pWy5IC9Q4CQ3TF9P6L0v4JpMeY3AuV
         4GQ7t5fhi0Z49CR35uc4Kail7RT0BL9F0WbftAHP5CbYCD1G1R94JRA8OQpIL9bHdfPr
         LF7n+XCLShJ1Aa1waXmjiO0XG4haAAOUaAU0AS/aTlB2Oz2sRby1ME3jRN+tM4JCv3vA
         kkhpylsjWPfcylIOWkCdc3RUqaT33tmYrHOk1xS+9GLPVeM27N7q38nAw9gk+luMve87
         gG6MMKdZr/nQcr+fdMtlmu5e8vdqFnN+UUpwsb/Mpxnda+Av3zb1vINKKRUuQtZvtjEW
         R8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778268072; x=1778872872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o6sIWPBJgGD5HPh74qm87n9kIJwicM4myAA07K3cY8M=;
        b=Qy5ry95NDvSXApoK3lxdeuucnuv3YtWkdE/KV3+OHPIVF6aJHfE0U3210kn6zzldkK
         fuaUNDyayCrfB4XQeXXPFiWK6YRWwSUr98KjgWrQPMNDEf8dsQkV0ETnU2lETqiJF3xx
         e2yIh7O6on7gj/8sYCO3RA5I0twQwvgfKBqwhlQ/BeAP6YVe86QKD5Q07r1BkPvrpYIk
         DXfBclK2fINZkSznzQUkklUiiwnt9MhXEVRrd64+sxUDbtdmZ8p2SB29m6+uisP1cMAa
         kDwemn1lFVYfQx7urUCOp+bO6GKMsEdPuaMEs71Lnm5XCqMvbbVHYWG2ZXRLfEmISlrO
         epfw==
X-Forwarded-Encrypted: i=1; AFNElJ+bsLGc+7QOFe24bNcjg4+Dh6sv4pP2oUJE55mOzYckgX+/lx1YjO5+hYSc14vFpWB/kzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi5XJpacNKjBTTsYjla64+F/9MFl+1vFv57WdsOOM0AuCrf7I9
	qh90bz/9LFm13gdAMvFZ+2zEbGntF05DSGX2wRSdk+maayAg9mZDLIr4gtiyJKzpqX+JgKAZERb
	EGLgg0M//u74vTdTAAlmOjcejMK3nZKI=
X-Gm-Gg: AeBDietd6IEHOf5m6VXLgicLCPkMo1v+0GjUtpKlj5CmQgGa6gYusHq4fI0OwwN7aJn
	X1y5I5MTsri9hI7oh3CYYhCsq875E9gGcCDk6Mo53bZGztbnBab+2eoctFjruspQTBTou1u2DU2
	O8wyV/V/wdC4hCU0hV5l821FIBtAjHtFnnlq74MwP6y7sFV4ovi3xrYi3rI1ooPWCivWZXtNsX/
	Mmmjf040lGNHOaXcZUAzwAVqg4cybdLczwCPVNcXB1SQS+x5xTCdEUVZIkKm3e9hxvq4lY3WsRI
	Cz8VARgRClHKAXs6pjc=
X-Received: by 2002:a05:6830:3c83:b0:7dc:cd0b:58ac with SMTP id
 46e09a7af769-7e1def6a571mr8530777a34.9.1778268072642; Fri, 08 May 2026
 12:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503174534.45699-1-mikhail.v.gavrilov@gmail.com>
 <20260504235435.90957-1-mikhail.v.gavrilov@gmail.com> <af0LQNY6IhB0NEWy@google.com>
In-Reply-To: <af0LQNY6IhB0NEWy@google.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 9 May 2026 00:21:01 +0500
X-Gm-Features: AVHnY4K-Xb0w8FtvnBfieJuPoycLgMYtLvqeNeZfLJSpDZz07nQE_kGp58hAe2k
Message-ID: <CABXGCsMzWuS2Xzm00S_LO66vW0Fytit-_=Smrj7j588tnkZuKw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/virt: Silence RCU lockdep splat in emergency virt
 callback path
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, djbw@kernel.org, 
	chao.gao@intel.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 2:59=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Acked-by: Sean Christopherson <seanjc@google.com>
>
> (I can also take this through kvm-x86; I have no preference whatsoever)

Thanks Sean! Whichever path is most convenient works for me.

--=20
Best Regards,
Mike Gavrilov.
