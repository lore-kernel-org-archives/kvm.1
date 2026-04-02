Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BDA3C9429
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152624; cv=pass; b=SWbo9BWQLWlfPiug8ED80NkHWoJHKmMG2a3KcGlXirD3RpfSVhvyPrSKN/crr6xIg41zz4ohCmNyuskNGvOTyrAttgmG8kSFkAl9gnKEjPckANVHUn32ezp4tmfwIrkmzqSx13SaQy55ear4DC5UiTDAAaqhKAJr81gBtuT5gRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152624; c=relaxed/simple;
	bh=eznhC/MlDgx7IiZC5ju1sPMniSTsz/dNjG2AhUQ680E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5Xlc3GGR1tLtNavg/VwsQVNrRnb3RXbdxUyM1hs2VFB5EkWIqWIs8u1SOTBi4TGswckoymCPwoZnMNwkS4rJwwEcNmMebvj4HBeKWakxmMsZXcmnlU6E0SZ751weRYUX6jhOooJbBZVtsPqxkZoVzORHHXLCg7B/Ad5QAqO5WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DACnvgnJ; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DACnvgnJ"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a2c77c62d7so1066571e87.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775152622; cv=none;
        d=google.com; s=arc-20240605;
        b=VPNmj5P/b3QfSnnlISyyLQvNH6xLSaYlwoi+nISoTN2lncGOsBfLmQRFZb7m3jXUoT
         LjIzEHwVafUHtpLr/jO/ml5DBFCM8VqW/TbUAqJIKJvDY4lPKO5pCSX+mTa3+bb6gInn
         bTQMl6pnkIVAjoXMXMzrmYtYzoRK8CnusywkUzkDZLsyus9TQY2uuIDCda+DMW6YLjxg
         voQhi6MPLicwu934dYitjAGVAz3PuLpjDVhRNUTTaEDJzTmLEbVmGqDWu8xgo412ImYM
         z3b0yT0dNFrz/J+maRVRwyTrKrzHkGwqJWM9lPZegIHBFGwsAK+zkc0NdF6sgIw7OSqr
         Ezlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9kTMSQrgNj8HIW4rh9bf84CUmZ/k9a8z2gF7kKzuWJ0=;
        fh=BNgQBqVeAFS1hMEWvrUkGO6R0s+rbkCH4R94p2eBJJk=;
        b=CFrJ+Ay/MqyHEbDx7sWwoXKTr2jQeutaioGgxUtQ1/kcaOjSgNuPcsg6ucjkBDNOJM
         v8H7sSZ1e0AfNtoF6NRexl0f+YBnuLCN1JGDgEU7aUYtB42NY+z17rleQ08O5MTrcgV0
         4qgPs1UQbTWk4IAN16V1YpPWjYR7UjbyuQLzTTpz4Nkxe1S4/ipQfj0k87p08AtXz/MN
         AIqv6lkKLXdlDft2AtQWceiW7zpmLC0JAeVTYsL9Bplbjvk8mfuW7l5nqKgBvcAHgulY
         kQQTXE8eWCQydv7RDILzPUMLgWH82PDgMmfJNebVNYILVuSzL5aBoAettQOz3pvIqtl9
         5lyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775152622; x=1775757422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kTMSQrgNj8HIW4rh9bf84CUmZ/k9a8z2gF7kKzuWJ0=;
        b=DACnvgnJZLp/L3u3pL22RFHYDoX0laZM7fihGy4qC2PC6mibBEPVEoldYsSYsXjrFM
         ZwwrOQD8aJvcplVECffsRzmy55Q/bjLjMJ1rXSBY6BuiKqOAhR1CCJwDYsqGlou2uS2+
         KjOepC7aDDuG9IlgsDYCPon3XauRCEXJxRtHVZCcVWzhCvAkF1DpICImn5LJAAWct5WQ
         AFpoUgl0aPLQ5qVpj0KDTeJSnAKzK8j7pfXkgjn63y8uMvGFb6uSuju/f2dKMYt/mOTH
         Yeh/L4bzRDxR0lg6mLmw7SydH8ohC7NAabijhK56F1iGetEo+MfycHHunUa72IxG/1mL
         9q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775152622; x=1775757422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9kTMSQrgNj8HIW4rh9bf84CUmZ/k9a8z2gF7kKzuWJ0=;
        b=oNtMiidbLWVcEiBoRN/XOVUJ2W7EmayAdj46pd6jM0IPhWSwTXn97J67O0dyrfl1MD
         1vSWrRgVaPxwouSV/al5vaaI82ZPSx0QEacGp9bwlitaSlC3SbayhFPZhv17e91IWLU2
         Iez25e1jvIrelWX1wka/an3MjEDk5rRg4tknKL3o/JNMDjOoY6oA1nJ7Q6x/oLu8WgdO
         DZDUPkYquic7f9qSvFoB80zrQpwi9asoVtOIBCPv9+aL7fgxIUaa0CwChjhk1zaj528b
         hin/3pgzcW+H99WATi3YeKGJAwdSvd14GQ/Pvc1+R+avjqvgsr/Ec6PDkVMuHHuCkZTF
         oA3w==
X-Forwarded-Encrypted: i=1; AJvYcCWEHYvRleYoc1tHWTmJdaIxHZCGCwdNFQtj9yHs8L13UNi+GRSZkoKRKQvrma2OYy+62Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ncjeneYJEMeKF7/30M5g0pytaScqTsfWhR9npvys6aXYXNzI
	x9c5uZd3bk/8qJ0VYec544ekqtj3L8bFtcgGhyvMXXr7ksAmaitWXDYkiG2GmefdhRHEKzcE3Qm
	bOetZgXYCab6KeZCoq1LFM/aq2ZmBZNjTyI0d72Lm
X-Gm-Gg: ATEYQzyGa3jy9ZAm4ozwxbKRfHWWkpZ0yoc54ySm/cmLDee6ZLRsQ0TUxSsRAZfkOvm
	HBFAg0cKriRazc/+1+5InCxt5LeTtzTxubQlB0/W5jA/fcTDIf/FGOVnEGQz/l2mEhQlv24dGTN
	jChjvRqAMiWP+aW56qLYCRIczGQ3U4aTN2+ouiGc7Yj4BHNUNeKxK2hLua+SxPF8Xe/QNZXtxV6
	XU+Ts4h86Fe8fczpJ9NzE8GJDDbH7G59u1lbfbbuovfkbQGwzE1odv2ruJ6KUHZB8VvAR1C4zuE
	/FC2s4Aj
X-Received: by 2002:a05:6512:a88:b0:5a2:7ddd:ec16 with SMTP id
 2adb3069b0e04-5a2c1f2c29fmr2818020e87.40.1775152621289; Thu, 02 Apr 2026
 10:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <ac1hI93pEo-x-7YU@google.com>
 <ac1pUx_jYv2yCMnX@google.com> <ac1s55_oLEUQx8Hs@google.com>
 <ac18LHQLalPb4z0-@google.com> <CAAdrzjugqk=APteY4oZNsa2e5kv5-=HBekyYfpzrwFUZ_WapsQ@mail.gmail.com>
 <CALzav=cO48f7f8yaN6EsSL4uGpojvY7gmCe9oOy+sP_+Kii4mw@mail.gmail.com>
 <ac26haU_7nXYWke1@google.com> <CAAdrzjvvxX3eEkCBUvSud7qyaSUdzecgAkX1=f+ZQe7Q6ws69A@mail.gmail.com>
 <ac6o2Z_cs0HA6PpG@google.com>
In-Reply-To: <ac6o2Z_cs0HA6PpG@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 2 Apr 2026 10:56:33 -0700
X-Gm-Features: AQROBzAnaNyQ1xf2EUVyqVytBNxbNxpcJ948nLLkD2uy-QSimOCwSMIUl3kZHd8
Message-ID: <CALzav=cnT1EQY4DQbqj3vNuG2ino+RSFkZ6UJ0-zDc8bQhBJPg@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] KVM: selftests: Link with VFIO selftests lib and
 test device interrupts
To: Sean Christopherson <seanjc@google.com>
Cc: Josh Hilke <jrhilke@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 10:35=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:

> However!  We _do_ have a KVM testing gap that can be trivially filled as =
there
> is no existing eventfd_signal() =3D> KVM IRQ injection selftest.  And thi=
s test is
> pretty much exactly that.  I just don't want to deal with jumping through=
 VFIO
> hoops for effectively no coverage (for KVM).
>
> If we strip out that fluff, then the test is runnable without _any_ VFIO
> involvement, which means it can run by default, e.g. in n environments wi=
thout
> VFIO or VFIO-able devices, e.g. in automated CI testgrids.
>
> Something like so.  And then we should also rename the test to drop vfio_=
pci from
> the name, as the VFIO aspect becomes purely optional.

That plan sounds good to me!
