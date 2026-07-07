Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349A42DFEB
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438667; cv=none; b=A0wzWWVwBXAz6WhL2jDLZzYLQWmHllHoloJ7UV3e1qdZpWGWSV9TTmySnxE4MgXn6rad7C8S2LBOVrCQ34pXLx7O75Gzl6keqGKiwxvAg/KObcx601LAmerK6/WCVQbHKXrfXpm8qCqMuYwzlHWncqFbJ/TP0643nfYIZX/OnD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438667; c=relaxed/simple;
	bh=nNEtWhsqH+EElpDPwy5F3Hy38N2bH/smUGCQo+NrEzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OxKVpRBdEcUrlkbRSQYw2fTeBIpL7i46f3hZstA01aDcUqebTW6MzSw5lRI/O8hpEsByJ5oPLOukMpOQdAO6a5Jc+H6yACdmkusqp7PSFd6X6dkcEAzx7AFUowbKeSjPaD6NKlsmg9xeOR9+qCawZg4Aj+Gp5rqIfFkREVEbcL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8Rr1UUB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8Rr1UUB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ccafc5e82cso25527585ad.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 08:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783438665; x=1784043465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KcPF5J/bz/mF1ksfoKKLrOzuL/Bt6L6jlasgMUKGJgQ=;
        b=p8Rr1UUBK3xJJ4/l/4rrRWRs+tWJH4pESaGetFWWAd+qJyHr04ZB3H6JkBdREyH9pM
         8GeQG2aOWiZ/dS5mJ0uZR52crDo/cfcsXxtEb06LuIucN8HihRTHAcl5xPejUBaxFIUX
         xQoZdDOPGl8CJ0achK9O9TJugCXj83DXGa37g8yuLTGY0VHXDMKiugdsSl7aPkAU72Im
         W7TjabAuTF0cbTXglJAqQQNWxKESS8VB18rQGZ2ned2urbYvf//zxKekWRA3+0QE0ix7
         v5IcZtms57uD2zmstbYkYpksOZnekNshnEkFgYhouGJA2l+tFnWcP50JGQdolzmtj8oc
         KzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438665; x=1784043465;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KcPF5J/bz/mF1ksfoKKLrOzuL/Bt6L6jlasgMUKGJgQ=;
        b=P9WGr2x60B14Tg4O5ozZuXX0N3S8ZZ4GiMP7dpmoUUtEw29YprquE5t+ue05hunNUP
         LZkHnMf/Md2COm+qXn0BXpFhxlFTLkuAZq/zWgVOFPTkRYudP8JNRhZJH4qYOXoxwDKD
         Cf13BR7w+/J3wGJCpL7WrKs/UgjuZ8hg8KiBr4ODx7pmixBjqFipPxIvv3XJOLpIGHB0
         idGTR2Uo+ntbidmpHx6+ikRShh8kVv668IYA32oAIXpf1mDxeO1dCdcqlWARPiqDGuGN
         2TTCXCnuI6mMjitFvYyHT5AMiokf5CeXuJZdo/5N43+qAv9x1vj56OpFei0m/TfG55B5
         uOBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqqo9WLxHEcgVSAsyRyP+A3ENG7f0TeaIGjlhQhGBMsHoaAJ1tefT6AQZfhwgY2Cb6LxmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1nGgurPA+loSMBNDAPLauWGVxgG0hOz3kiSrKtJ9IaWNL2bs1
	O0VsQMf+auAHqajOAfmVvLWi7D9jIaCVS9nzX0GVPfFo3N0wzToZmpFEoyi9qwfOfaxtSxzmDZh
	En60zWQ==
X-Received: from plbjx4.prod.google.com ([2002:a17:903:1384:b0:2c6:a078:41f8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc6:b0:2ca:106c:7122
 with SMTP id d9443c01a7336-2ccbe3ee417mr56406945ad.9.1783438664543; Tue, 07
 Jul 2026 08:37:44 -0700 (PDT)
Date: Tue, 7 Jul 2026 08:37:43 -0700
In-Reply-To: <CALMp9eTycB8Z94V8j-xyfDeah5KaJypRrPfFNHfQSUzgrr7FkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
 <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
 <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net> <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
 <d5645a47-c346-4e63-a5c6-c88bb39a3ee1@open-hieco.net> <akxwt1mX6blSnkxI@google.com>
 <CALMp9eTr0iJ5QgbZJ0YtOZg89XVFSesbyoGGdtkz+f8c60DcDA@mail.gmail.com>
 <ak0QE7mP_TeZmzeS@google.com> <CALMp9eTycB8Z94V8j-xyfDeah5KaJypRrPfFNHfQSUzgrr7FkQ@mail.gmail.com>
Message-ID: <ak0dRzS4Ap-JREvg@google.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Tina Zhang <zhang_wei@open-hieco.net>, mlevitsk@redhat.com, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026, Jim Mattson wrote:
> On Tue, Jul 7, 2026 at 7:41=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> >         insn =3D ctxt->fetch.data;
> >         if (ctxt->eip =3D=3D kvm_rip_read(vcpu))
> >                 insn_len =3D ctxt->fetch.end - ctxt->fetch.ptr;
> >
> >         for (len =3D X86_MAX_INSTRUCTION_LENGTH - insn_len; len >=3D 0;=
 len--) {
> >                 if (!kvm_fetch_guest_virt(vcpu, kvm_rip_read(vcpu) + in=
sn_len,
> >                                           &insn[insn_len], len, NULL))
> >                         break;
> >         }
>=20
> This split doesn't bother you?

What split?  Do you mean reading some bytes from the emulator, and some at =
the
time of #VMEXIT?  If so: no.  IMO, the most important thing in practice is =
to
capture the actual bytes used to decode the instruction that led to the #NP=
F.

Exactly how and when the "CPU" reads the bytes is a micro-architectural det=
ail,
so I don't have any qualms from an architectural-correctness perspective.
