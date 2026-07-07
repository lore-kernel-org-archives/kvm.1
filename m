Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94E43C7D6
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448618; cv=pass; b=HMdqYS7bjcrkFeX9BUW6NQDTt2jUKxNGK2fLPQucg6RSLwPas681sh03SUe0Gw15P4VgRqPyJ/ug38rZQiqef428pMNWYutvMCyaxGaLEuQsa6ar+x5GdTEbYGRyu0Um3PukQhlxot7UJlgSQjorOOAr0zI9Gc+hDZPhPhQfcZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448618; c=relaxed/simple;
	bh=rlf3tHuXC+J9H9qoGU4eEn6pWPRGEeYT1LPxkFxhje4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bH7CZEhSVYFHhkdKFu4erKp76lG3nUqyCgDiO3VDIfIUdCI6lO9epzsh94PKd3zKd9KwSRKZ+tu4025HtkeH5t3dSR97EQLTGeWACpVp3pAOViCxGVcseZrjjh80is9uG1blq0GeodY8oYr3K0nZEb0hTBWhhiXulMXkGyOnOD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MalPC7ts; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MalPC7ts"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so1362a12.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 11:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783448615; cv=none;
        d=google.com; s=arc-20260327;
        b=m1dzgnY/v326/vfJho6ZIJD7fse+HBxuVbVu+8OnWzw1MXkRKDS0Zdk0lvn9idCBtZ
         rhoLVdcX2ogeWL1TILrHvwHk40tVSwh70Fj7E5Gyy0ChcbHveyTr/nhCvUNTuTk46hEn
         mG0mmERDP7WYjF0vbQgjGBtpZvwXdny3u0Ksz+TF8jZU+KOkr+fwjGuazSj4Ui+iRKZh
         pdTjZEtiVg3VazKLCtfszSVyXrS728ItH5nmsmZ/21jYSdN8qggsyRUIMy612/ptBPvz
         TjGPka4lO6T+nompb/489n1jdE1Lwq2hv5RsJZIsJ0yebPGJUl0Fuv1JY7Rj2Kp1nFqf
         vygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n6UTQhybf0qp+uwC136gBcEg4wQiDp++XoD04H2aZkc=;
        fh=ClgJgasUPo7PX891p3IVTGQ998QoL2S4SJUNir6RcQw=;
        b=s8q+DZCV85KFUxBViItAR5d7QlV7xsALspXg4D5HusVL+ZabEzkXKyEHbK/v4GpxKS
         OtEbEHVGaj3k6F7MzYY5OAWfo3SFraahNGYw7aADNiPvh5NjffsOTkjO0ppLFFqllSeK
         nSgk5EFx3lczrWpt6XyfFGgxnHk3i6j3f4v0gCWvPLZI6tpVyMcEtCerht3X6DrQE8e1
         xuYubU+IlvtVSqpz3eefkB605p9oB87cU5SXpttUxdpsVJUbCmbNGOwPL9n81pir/6DS
         vKRg0PKflt7cuqguQKCTdDOFNJdMuQ85T+iZ0q2rRaWbcl7ysJW46nJaz+wqvRSjL+9m
         3Ekw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783448615; x=1784053415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n6UTQhybf0qp+uwC136gBcEg4wQiDp++XoD04H2aZkc=;
        b=MalPC7tsOEfl6t+SGqr5q1OkqWADzkKctrHvzVWlgdPyJmRePGZcDWuztqKmf+l5/Y
         U58VcvVBWMpUF/5pXXBl57dPBGax02dvdwI/PI6EqVabcZdjs1XYxuYiQsThhfyQ8Zru
         pF7JQaY3p8Dey6p9a3n7WIayP0IdhADVUHljnhFXRw9YPr7ieNXs9+QfiQIyNwQHhfml
         zta5TLZN/UkabDamuRIGvPihOMpN/qtz/RQT3Dfh+rNXcBhKE6JgKJXEjZ5Nhj6Tb9KB
         fba+3hHytRwgIWBDwmcBcSNCEGw7S2RMkbJgzvZ6ufLYddthvwN2P2rku++LB+PNlANm
         BSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783448615; x=1784053415;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n6UTQhybf0qp+uwC136gBcEg4wQiDp++XoD04H2aZkc=;
        b=tN+JPXNVHhxcs/+fJ/tSFFMoW1K89atOiqwqijguzGN6ZJzxo7uAH+FAEdgBozJOaV
         gJCgjJorWT2FnVLeOvIyJpZU1z5CWspXjiImWpIPaaex8H5VqO/H684ejmeDLiWLpsbv
         iCumwcWFbfEUuVxMpzG4znHVWlnqWhiKSCFK7mLV5an02rk2Gk+J85tDnamn+Nm4vwAW
         h70i7/rbqkBAApxZpISG+le0XS/TY9METN4RRDLMT86/2JJgloNI29W8eh+cdqLDKPYT
         pulhF+fmvSYnDr2tbgezh7Mp9ZenpGHW86uujtaBVq/8jGxqPAvXve9B2tc+U0H0Z0ot
         OBEw==
X-Forwarded-Encrypted: i=1; AHgh+RphhN9MJCRPHIHg7RbjJmuYLvd2acGIuIxg082L46PFIq9qRdmF8aGgAc3/9G6QHrD5vM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDNVC3cDxp0ZRLmq8eqZFuqGEkxD+1GKxOauWCamf7h7z+edFD
	e4uuezLTGOyx4YSCvDxrsDNrvGMEIIZbYv7tfkbeZDIR6QyYqgYrUdbehdCuMIJNPgXO1D9Ydc1
	NMPeXyYmXl+FZChmiZCyQwBIXQDMcoBGN1hE/8quK
X-Gm-Gg: AfdE7cn951oOmnYm518SBuBkzfWw1RuJpVDViWYLErqQzL330iMpM29uiV4eTwVmu0N
	DKp8yWLjMQ5dpO+2X3yWelG+NlPry4wbZjVm0VKvT+pP/Z21ywJEmOXDXNUPQjAceDCVPf8vZ+0
	JibhE3GAzOfQctIOY+vkmq4ZwOqzPdMzWorIm/E188cMnMidZNv37Y67drwPUAZqpFsa54E+hBN
	ep0atDSZ2V7V/ChgnKYQbGk7vbyhT588s4nnnenh/MoQIna7Gg6HIugBASjwfQkfO7p2Jcw
X-Received: by 2002:aa7:d614:0:b0:697:7f69:48e3 with SMTP id
 4fb4d7f45d1cf-69a9134f82amr62168a12.10.1783448614909; Tue, 07 Jul 2026
 11:23:34 -0700 (PDT)
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
 <CALMp9eTr0iJ5QgbZJ0YtOZg89XVFSesbyoGGdtkz+f8c60DcDA@mail.gmail.com>
 <ak0QE7mP_TeZmzeS@google.com> <CALMp9eTycB8Z94V8j-xyfDeah5KaJypRrPfFNHfQSUzgrr7FkQ@mail.gmail.com>
 <ak0dRzS4Ap-JREvg@google.com>
In-Reply-To: <ak0dRzS4Ap-JREvg@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Jul 2026 11:23:22 -0700
X-Gm-Features: AVVi8CdfxH9KPwBG1cPjxuI_GW1P0iEniD5Mku_K1NYa8qNEH3FQUGW2WLHpSig
Message-ID: <CALMp9eQ4JZ8E5BTr7Cde5M=djBg1oMNLbfn_ZoVPL62ijna3AQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
To: Sean Christopherson <seanjc@google.com>
Cc: Tina Zhang <zhang_wei@open-hieco.net>, mlevitsk@redhat.com, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 8:37=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Jul 07, 2026, Jim Mattson wrote:
> > On Tue, Jul 7, 2026 at 7:41=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > >         insn =3D ctxt->fetch.data;
> > >         if (ctxt->eip =3D=3D kvm_rip_read(vcpu))
> > >                 insn_len =3D ctxt->fetch.end - ctxt->fetch.ptr;
> > >
> > >         for (len =3D X86_MAX_INSTRUCTION_LENGTH - insn_len; len >=3D =
0; len--) {
> > >                 if (!kvm_fetch_guest_virt(vcpu, kvm_rip_read(vcpu) + =
insn_len,
> > >                                           &insn[insn_len], len, NULL)=
)
> > >                         break;
> > >         }
> >
> > This split doesn't bother you?
>
> What split?  Do you mean reading some bytes from the emulator, and some a=
t the
> time of #VMEXIT?  If so: no.  IMO, the most important thing in practice i=
s to
> capture the actual bytes used to decode the instruction that led to the #=
NPF.

Yes, that was the split I was referring to.

> Exactly how and when the "CPU" reads the bytes is a micro-architectural d=
etail,
> so I don't have any qualms from an architectural-correctness perspective.

When I requested this feature, I think I made it clear that I wanted
the actual instruction bytes used to decode the instruction, rather
than bytes asynchronously fetched through the data path. It wasn't
until I encountered the Naples erratum that I realized AMD hadn't
implemented the feature as requested.

Since there is no guarantee that the instruction bytes are actually
relevant, I concede that 'exactly how and when the "CPU" reads the
bytes is a micro-architectural detail.'
