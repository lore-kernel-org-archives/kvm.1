Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794339797;
	b=V5o1i/OSJKvjOiMfkSW+ekzBxpHDzKP39zvbzymoYa4r7jHmDfKoYMtRfdr6Op8nKLsK
	 1aTFELH2/smlhot7OHshfXWiRF+f06PTqBeMXLOtI3quOV4hd5+rB+OpSX4c6xxe2bjwD
	 pGkI4BLpnIIligVKGm04ejPFx3LCCTm9gr+lDc2T7UFMms6nDXTAEHVagT0uvonLy9DSE
	 YkfIKEiMTbgemMKMIPy2rymnkf7eh7oM+Aa+k+L5kXZg7RqYIJ4Ie4HycbWcyydYrGBRc
	 q6G/8QZkinAU0Di4fyGG1KpLpxmBSHZjbUweVUWBjg5CyvBN9TW6dlT9xJx+G+6xDqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qM/93cSQyeNnAHHkdo1VwGjK9q5xf41HRRdCtb6TXfk=;
	b=X21Nh/rou+YDRmWdpYp4IokIndmbxJGsYIpEzadRmFfNpC/iVCcjbN6c+OZHeXvgLBoq
	 zqtui0QCh0Qgot+HF1wMw61jqQxtgvX4LZxH+NTaq6+rolsLBWoAxhQ1vLrInTcTFcm5W
	 MlqcD5ye72i4z7vXgPkqLylcQ5vx09YAhpEQLSvuoAmEFLDNzc8PA6Z0p0BPylNZ4Yu/x
	 Ft2YlN+ohRN3qArpCxak79/Kb0gOMRqf27wV0qY4MjHhHZAmm7x5iHT+t+6GA806feDoI
	 uhZXCThg9d1u7at+bzuV6Bgh5DLPlTJTXfGb1w8JeZNW4uIWFprELY16dPUKKlsUg+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O0CtDJzO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90C606A31C
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 19:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA90C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O0CtDJzO
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b579ed8da6so1553a12.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 11:43:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794339795; cv=none;
        d=google.com; s=arc-20260327;
        b=JgVJYKQGbIKPz1VqTdgsRZw1ZX/Lq3vCggSuH/JUQtCieQLXwGi7DU7xqR8nrABp9/
         MTnhxXlkD9d1A08knwlRFqlIGt8RkTiakyAc4rXkzEaasaeNLwwo/96K+6T0GrrT81Ew
         TaAAuwGjDHdSWIR2q2ksnaLbFmGtW3UNU1cQbOGcA0rveoaGUMP61tkf7f0gpZwr6WbL
         ldtvd+hebm+QEqFlFQtQQ+b7hRIelOl2qMpvCenVo/c6c/wHIiYRoZ4HoMXleg+mD0mw
         HPZUlUfP+l5Wct7VcD0znRa3SO02lrH3CJZx4J7sRAa0lplN8gtIR1Yh7iwzVTB8RueQ
         lTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qM/93cSQyeNnAHHkdo1VwGjK9q5xf41HRRdCtb6TXfk=;
        fh=B4XNZFM2dXjr5am19Ennt2BuTB+XK0CVEqTY6LIOsDE=;
        b=m65n6UU4Lg9vorN4PNbexvpe3UBgWYMBlKcrPdlfCR8ws9zBgcCHCerKD5cwsjNv/L
         FsH+PuMocuy96PFDf5toqGg1/BFWVO+uDdnnBJ9uDDf4yfu2uo7hh7DqFXyzm1yBLs54
         EJ+hZqd1sD/pXeMhL2PNB7rv3uC4HidVToN73SUamBi5+M96QQt5Eg1uSmZTWzq6lDUP
         admUx1fmHRXKTcAFp2Z8xsOnA36pSV/he1kwGOzU2fju7DfdTZUj12QL9bUB+dqHoPqW
         JF0Jcqo+cB60w8qnPMZgBHBZEp3Tkzd25FiX8NJNP+mrJ4TSBKxtRZMBRWIV5zL+2HMV
         bnJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794339795; x=1794944595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qM/93cSQyeNnAHHkdo1VwGjK9q5xf41HRRdCtb6TXfk=;
        b=O0CtDJzOjjNC0WVqvnHuYlMnqCk1kGw2+bvcyW9YCCUiCsFX5MRYpRMl6dNRBhF9VY
         yYJmfleMQM2iA+umTOCJjHbZFdELUNx+lNRfNsVtILZWshZqw79EbG74mqBM2T69B2uU
         aLjopHMKKA6Tbldrv2V6knr/8k3q9MN5VsuL2xPJKofzun4Y6WvTk6SUxbD2wLAMO50x
         xlCzDEqnilJe3DqIzc3qO6NxcwJf/DFOUiw+XbX/4w3BOPNLnfRu4/Gxw58h08Xccd6j
         fnjckvJnnbEhNDuBa+SaEFlgpZ14Te1HBs0nNg+N+j+x0+AM/+6Lc1L3L56WhAU2ip1R
         Vs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794339795; x=1794944595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qM/93cSQyeNnAHHkdo1VwGjK9q5xf41HRRdCtb6TXfk=;
        b=Cw5rgkQHTq6xxzHhT32s1zVOtmOA4MowD7dw4wz9Ggsmpoip8E8mQJ8coDS9YSks2s
         TYRqLl0bsGynKYtl8HIhTc6ZxYiuynTCD4QUAPXmuIq2ld6ccQW6jeWNSD7QGvBpQvSS
         v47C+C4I7cr2QmSmyotUFTykpEFTa1AQd0bB2AzvZtMDr1JTkWJo0OcwmrmlsBWdqgKa
         /073+2DAAdWl+J/QFYnYj8G0KG/oxYpeDZsvszdXiliW+wkCpqe6xKSqX5V6d5aPFvKo
         vvBdUu7ZsbfgNtxZYd2RI3OVG4JqXxiZaN8TAgheSPB81qeKd9ICuYBKM2ZphxQIunbB
         Gddw==
X-Forwarded-Encrypted: i=1; AL+hErHp0Bl46+5ZS6Kr6ntmV5hhaW9t99GBF61w/OxIRoLCwnVxZutkEq/3h7XxzeRLSp7tUEQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cxke2TUJkVaxH5ODWBXucDsHrzItU+XTDnCrXUHzo6CaqZAky
	gDc7yJXlKaoCRsy9QlqyJSXsxPAn8gM4yZ6LWaSmXm+cLcnvnY2GR/nK04H361LQydxG651caLg
	T/It/ptFqrsvY80iCe/3My+nMmCKXMP/PS67DQtgs
X-Gm-Gg: AYBFou1davcWwY9yFMUTRBsi2O4gbZPVKiEfW9atvY4B7kVUq1M2ANhgW3kMjPKheBo
	8rm4XI/QQSyI6/FVQnyDy8Osu8F4N7RP2QnjoPSM1Yrpx8tOReFNP+x5+K6j4Oe3smxtMeF+Lp6
	Am8gtixy0goPgEldvkDpeHRQVMzU00otYeGUxmGIu+0teZW5vC2W8StJfIaKvSdRzvpB5HmdBtx
	mnvvKgqCazlc5KpfncS1GhMc0Iskso+eJPcDw/cmwtxxFa2liojkf0OuXOjMNjCnsb6Yvm3qTax
	o7zCuEVUssYd22AlTuhNq0U9tcsI0VtEiiz48NClS/M9dZzBFhDV6y1v0Aa/w+4XRS+SRV/kuGN
	T8oaktNyljfr4YTx94vsXYKZ0KQtEmKqMJi4A2QRTF+QW5v+2nZUpoNgNlCnbx50etPMbLuse
X-Received: by 2002:a05:6402:c4d4:10b0:6b1:c6fc:aba0 with SMTP id
 4fb4d7f45d1cf-6b77780feddmr10348a12.7.1794339794646; Tue, 10 Nov 2026
 11:43:14 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110004037.125692-1-jmattson@google.com> <avNYjOevOv5s2o5k@google.com>
 <CALMp9eQAxDhnJGrxt8MquPKE2jsUzezn+nbRXV7E_OiATFhsow@mail.gmail.com> <CAO9r8zN6W=95uOEUhzSenbJeBECjWk-HRgX7PSewwJZgfmQLoQ@mail.gmail.com>
In-Reply-To: <CAO9r8zN6W=95uOEUhzSenbJeBECjWk-HRgX7PSewwJZgfmQLoQ@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 10 Nov 2026 11:43:02 -0800
X-Gm-Features: AclHuK8u2h4MgClVL0RWHK-Jelk0_JEcMjg6Ljnk1fspltvatt8zpQ7C_OMZRzg
Message-ID: <CALMp9eR2RL2JgQSAehE36YVzG=pvHKxmOH4TJz03u_BwGAqOOw@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Add missing CET VMRUN consistency checks
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	John Allen <john.allen@amd.com>, Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 11:30=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Tue, Nov 10, 2026 at 11:18=E2=80=AFAM Jim Mattson <jmattson@google.com=
> wrote:
> >
> > On Tue, Nov 10, 2026 at 9:56=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
[ ... ]
> > > One last question, in the restore path, the MSR may have not been
> > > restored yet, right? Can the consistency check mistakenly fail in thi=
s
> > > case?
> >
> > Not with a legal snapshot. Note that on the restore path, the 'save'
> > area holds L1 state. Hence, RFLAGS.VM must be clear, because VMRUN
> > raises #UD in V8086 mode.
>
> Oh that's subtle, but yes, makes sense. I was going to suggest a
> comment, but I can't find a good place for it :)

Saved by subtlety!
