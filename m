Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF933F588
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437871; cv=pass; b=JDFG/X909hVkMPClSer6C0ThWglLcSxooIT55Omvd6RxvK1WoR96LAmHA1GF63Soe813Lt4d/WGDogxCO/QWZwrpVgNdejIfKw8fwHWCxphr6reB9CEs4xRldNec0gYxRyBlpapKW6NtZxntXspCzHfkyMGjTz+EVnrqycSEFkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437871; c=relaxed/simple;
	bh=va8xMcojp/wqlH955kAcrki46mO9Z0hCEPfHLiFpKO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvieE1LrXF3CeuZiWaoaNDLX7lmQLG03G8YZ9rBm/yaOfDAUEQtNN/+UoIlu1ZHq6ELAsY1WCnrpyf6GP8E5FjOUcVzMQi3k5MwO6nGw+ppP+jGGL5GQsMdSl6EtAFqcHmpYagNy2oxms+5ofg5szF+Be2GZlXHBj6o4tAMf6js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRgbRYw6; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRgbRYw6"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so10025a12.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 08:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783437868; cv=none;
        d=google.com; s=arc-20260327;
        b=bhtmNpet7s0kQ/g95SzPvTKvSaZpp9SbCeUaMr09hJDYrFRBJZEreJk9eBfZRwJm7j
         IDHoK9bmowbueyh1V/apfHAXK/19TIgzvNGofY+e9gEiw5CCnqz2kxWi8DZigCrWTrnp
         nUzsGMZ86BMDLuBjl3N249ScB3jVWHNxGphlFo2/QCMhHs1XKt2x4WtezKE3Xy4MHzg2
         wRofjKIMmDA1NLqwoUpB/iCcXcROkiOriuoyH/O4mkiaypY0GDf3RK5H8PniEZu2Twiv
         3oLnLsOa7KSbVLXtRpUrZulQJyctswsAifEdtXg3F5n52mQGe4xSTgHrebx30ngMFqMy
         AnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sRAvQtVXJNbBLG0JVFcqABmsGYBHBTODI/Uqh3OZb1g=;
        fh=ENbi/I7javF2S1C/fxTFKX409JnIL9X0fPzHSH7xb5U=;
        b=kBpitqPT2mXmyoFQ9DDBjNKHyrxr5wpZIWE4qEg3HtUiMHuTKRJfIv0M70uBvylsth
         c+vYA2pTO9tM0IAfWr/3+KMG2M2gGAFgPvr+wG/KSB+MjTJjqmfllTrACVqzMlmRVZ/H
         1gBmLmYwa0htkM6h6EV4jdKALgKLu6OW3Q3P1GGcmWhyg9QBOd9m4TvAGvK3skeGnnL4
         d4uxo6oS1jmrg7bj42e/l4kEMx6QQ72YPaxx7AbtklbLxeqozOmZPNWYgyIBO2+9Dw8w
         cchdCW5Xp3P/USuCNPMWkl74W+7+V2ZSOzDbVucyRhy5RYUxCjjWU8tniJ/b+V6BmNn5
         er0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783437868; x=1784042668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sRAvQtVXJNbBLG0JVFcqABmsGYBHBTODI/Uqh3OZb1g=;
        b=vRgbRYw6gZYsblOnfHBNQ90t5gkpAOEztyYq6eFKDLew8fUyZ5jAwBZs7tTuRK76PR
         joVtGt8xj5TlUc9oW7Dq93+wFS0tbb/4VJBE9GFH5oyuLNimHyFGKzj43QRlNnOBRIHG
         WNMI4alL1d5e/8w1I1qVDOCAMFLllkt7mUotIwuax4flIaOunI4FO2S5kxuAfGvDjAzv
         FSX1CHnd5lkdcOkW5MMo/SLCtvVcDZaXiG/hVhhWK6Ei1c9eNVkhImeZ+5MtVw5kavJu
         +CorfyQj6ccMRxBDp/rz6325mxttr2O1UGXaTgnCRdBdnVbwJK5p9dwI6Ne4rvTCd4Gh
         6KhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437868; x=1784042668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sRAvQtVXJNbBLG0JVFcqABmsGYBHBTODI/Uqh3OZb1g=;
        b=sUQ8QYD4V5zevx2rE9De9GuHk2nCcGb5TQOGYjLSB70NeoQclAiivpS6UQC1OKbV5/
         6kS3KM+chZviI0HG2V/HD0gKX89M0Mbk12w/R156/oxxn6dglGuOyTslbXbUJXDCo53N
         GapKyBQUf/V0OISABJ/R5dMhAsyhkapFszfElGJqTJDXYh4Xb9Z056ZhdtPjR5Mz94Jm
         tPxEZPBPB3RPriy4l6TTfTq2a0NLZOqL1CxV9FguXqOPC+BVp8u2THladtoGFr+IBLNR
         tOxagMVaJbyGvsqPWz6h1qQlupDVnzfAltpEI/6EiMCbjuKLPB2K3EeItRd6LRZSGSBA
         04yA==
X-Forwarded-Encrypted: i=1; AHgh+Roa7URqK5Gg/lFyjSq8gv3LSGfb1GdzjqardWPRxdC0t9dz1uzTMGrvLpyRybobJeO+OIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy87Ce7ZV14f6+Ft5NNvF8Fk3Jzw6BnCv22mYh/W96ENFyNpYuX
	A67YfEaobs30Um3Yl4bf4yrIp01OooALwLeYhwmgJxoSPu5OKIkFZIoqzv+fhwQltbIK51m4hNl
	a9LDHe+aLVZUCtV8XX7xl8DWVHmvfqJ8ko8UFMenW
X-Gm-Gg: AfdE7cllkLoY2IOpUSwqw6zwC5CcBxukrUBNbTC3Enx2vtzGmkHSJkjSsdJUMGcCxlQ
	WFu9V9nuCVHycCFCvSsDaSnsXAPmuhqAUkQWJSqRQqMj5vNKTiSZ+WNkG7lsu0yhV9ZUn35p9sF
	V5cdlFuoVaOZWMlwmHgB6lqQHYgquqxm+8l1ne0N/bjqXeTzQy2g4bWhvP9cL++5XZlvM6IoFS6
	8jUQ+NmdwmEbDX2DJtnUyXjrPMo/KfnCsAN1HP9EusfAY3XiiJRI7sS2asadP3NTAhxKIuO
X-Received: by 2002:a05:6402:3046:20b0:697:9254:a66b with SMTP id
 4fb4d7f45d1cf-69a91340f8bmr43195a12.6.1783437867684; Tue, 07 Jul 2026
 08:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
 <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
 <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net> <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
 <d5645a47-c346-4e63-a5c6-c88bb39a3ee1@open-hieco.net> <akxwt1mX6blSnkxI@google.com>
 <CALMp9eTr0iJ5QgbZJ0YtOZg89XVFSesbyoGGdtkz+f8c60DcDA@mail.gmail.com> <ak0QE7mP_TeZmzeS@google.com>
In-Reply-To: <ak0QE7mP_TeZmzeS@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Jul 2026 08:24:15 -0700
X-Gm-Features: AVVi8Cd95GVwYBfuP3XznzxvpDMnGWooflK8KFIsDpgzTbJAg7OoycQy2qFC1k8
Message-ID: <CALMp9eTycB8Z94V8j-xyfDeah5KaJypRrPfFNHfQSUzgrr7FkQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
To: Sean Christopherson <seanjc@google.com>
Cc: Tina Zhang <zhang_wei@open-hieco.net>, mlevitsk@redhat.com, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 7:41=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
>         insn =3D ctxt->fetch.data;
>         if (ctxt->eip =3D=3D kvm_rip_read(vcpu))
>                 insn_len =3D ctxt->fetch.end - ctxt->fetch.ptr;
>
>         for (len =3D X86_MAX_INSTRUCTION_LENGTH - insn_len; len >=3D 0; l=
en--) {
>                 if (!kvm_fetch_guest_virt(vcpu, kvm_rip_read(vcpu) + insn=
_len,
>                                           &insn[insn_len], len, NULL))
>                         break;
>         }

This split doesn't bother you?
