Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12E4424657
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260760; cv=none; b=XDE/m2cEKxibtUgkDqUTy9j3n7Yr+NrTI5+4T2zVyi86Y+zsxyM11B36S/jJ+Q3FfXDC6h4QrJqp75KnLRIZOcYkcYCXgY8gqH+OyTx3T1m65WU3D9LfFBonq2Mej2ARhAbBRHudUW8IthShUvv+IifeWjH4TIG9+Mizhu6hzWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260760; c=relaxed/simple;
	bh=j5ECOq7GFehfoNtRy2CMqwyPafoJN/wfg8FK655IPp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JC9vwZ8WWXAFQh2cI+qBln/CpZhvs+C5gEP4KVeWRLvJkeYaNdyqJ5Foc+EGX7N1epsXjO00zK8hPVCTZ6AfqvYO6MNqBj5hG4eX7t1w17TGYHs7wRekzTBAe/L8sONNR9u3GFZSnDY6VHhEuUhbDsLnmWxAAex2oNG7NL+oWKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+ba83JK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+ba83JK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CC21F00ADB
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260758;
	bh=PIM6E+ZmyUeFvM/FNjFff/bPDIfkL/Psxyv3lklz2Rk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I+ba83JKm1iZpbeCSDylde6PTzq5hqN9Jmn6J6koAYEKcJ42mQQXTnhFzYeV1Dr8S
	 IFq1aJ6wW2Z08qqKOO75kNLa/0AhkxiEGyu9E28paDaYnnghu+1zrtdU5TYUE1+2cn
	 gq4RKjaA+ZY8rBspxZgwv8eJ2BSib296HxPoAIGEM7RuF0Hh6A4fqSdNltCaYgs8fq
	 gKyD6B6EWDqVU315q5g+Amh8f6cMwrRggBQdosJ4YIEviJm887uOZn1X/25p/EI+vp
	 ZrO9vicalzgrgevL4ovWqU3UGLJz+4rlbp7zdQPGfcO8khHUasZAVBbBnh9xjpfQOr
	 CCy/Sy2dS1akA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-699fbcd23ccso36949a12.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 10:45:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoPABpt+YP+c7wPK46QCECQ8N3seatVpVrpCvBC0LBLgRz5qOPDetWSpV2DtDc2yDpgMLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnsnCuKRzZmQTfaq3jLraqYjse2fWE6ItnxIQOlb18HLrvjaCc
	FxxOiRPf7yZjWA2K591zANr47pYOp4tbT6Y4Q2U7JVaMThn2USg0KF7YVQG/ZID5Y7KVtWOBbEE
	MN5RJ30VwcRi9/7w76IeMmrSuY47eqjY=
X-Received: by 2002:a17:907:94c4:b0:c16:5b2e:f972 with SMTP id
 a640c23a62f3a-c1f72494062mr200668066b.53.1785260757547; Tue, 28 Jul 2026
 10:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728174232.2423257-1-yosry@kernel.org> <20260728174232.2423257-10-yosry@kernel.org>
In-Reply-To: <20260728174232.2423257-10-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 28 Jul 2026 10:45:46 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM702JvorGQ8zSB3OZdZ89WgVBdZai8vFL48z8GsU2CQw@mail.gmail.com>
X-Gm-Features: AUfX_my442XZqiCKTJoUdFzBFkdrwxgmz7hhVLk6XmAz-7qSnXBgOuNFRmlxH8o
Message-ID: <CAO9r8zM702JvorGQ8zSB3OZdZ89WgVBdZai8vFL48z8GsU2CQw@mail.gmail.com>
Subject: Re: [PATCH v5 09/13] KVM: selftests: Do not intercept #PF by default
 in nVMX tests
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 10:42=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> init_vmcs_control_fields() sets PFEC_MASK and PFEC_MATCH so that they
> never match, which reverses the meaning of the PF_VECTOR bit in
> EXCEPTION_BITMAP (which is zeroed), effectively enabling #PF
> interception by default.
>
> The relevant part of the SDM describes this:
>   When a page fault occurs, a processor consults (1) bit 14
>   of the exception bitmap; (2) the error code produced with the page
>   fault [PFEC]; (3) the page-fault error-code mask field [PFEC_MASK];
>   and (4) the page-fault error-code match field [PFEC_MATCH]. It checks
>   if PFEC & PFEC_MASK =3D PFEC_MATCH. If there is equality, the
>   specification of bit 14 in the exception bitmap is followed (for
>   example, a VM exit occurs if that bit is set). If there is inequality,
>   the meaning of that bit is reversed (for example, a VM exit occurs if
>   that bit is clear).
>
> Clear PFEC_MATCH such that there is equality, and the #PF bit in the
> exception bitmap is followed.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>

Oh this needs either:

Suggested-by: Sean Christopherson <seanjc@google.com>

or

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
