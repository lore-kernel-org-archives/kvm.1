Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DF53DF008
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787053309; cv=pass; b=RqFjZVt1MYFtOmOPt7YeAj2UVmcIPs1gZsJuIe3FF1oTFL9YlJ4/U9iTNC3ZnvRWxFAPix9mtd2A2tyu2icAO8sr76tZg5O55WKxOvPWQwM593mzsKTq7vneyLjzMqd9Vi4gYUv5uH24pM4TDk9FmTCpS47R8RbfqcCH28WcQf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787053309; c=relaxed/simple;
	bh=tQmYf+QDPE3KUynEei2wc6G8i6CubSSD6mr3fBNIfBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKqgBdpLuPalxtOPVvkkGHfXqLVG9oHFBp4A+XOCAFOs0irGa+BO06pNB7eL+iGuGomqzSVpMbt01E1HPcD2weI4naJLPJ2/HMYc2+Zk/anxHYlm7H58V4Bnw66pLks+hqWA5fVbtTcwtS4AReddBYb6l87a0Id1qXMGCReYjzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSLhl6ST; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EvWpEhaW; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSLhl6ST";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvWpEhaW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787053306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27+KdweROW/R9SRaLpZ3DhPF39588pcy9+cjDhON/6A=;
	b=SSLhl6STwe/FYf3SnanFw9YYMdd/Hs7AsAc1/186ZiaaOYNu/8MEjGAtka0nYOV8/P+ibz
	w1kpgBjPHSzJKguX1FVQ2nYj7zcnwvTto1m9v+Lu4kvCcByJxllGlYHPlDjcbEWn8rzBXL
	lKTAnjQKfQ8UrF8ABtN50ZTB7FvAaEs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-l24mjwMfOquyGWAzhFTPZA-1; Tue, 18 Aug 2026 07:41:44 -0400
X-MC-Unique: l24mjwMfOquyGWAzhFTPZA-1
X-Mimecast-MFC-AGG-ID: l24mjwMfOquyGWAzhFTPZA_1787053303
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6d70223dso2609953f8f.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787053303; cv=none;
        d=google.com; s=arc-20260327;
        b=cGHsEF98i/zeJO55ElkySEdzbiExd0qOBX6pGQusFDgV+dMj9ZKzT9zr+txKBi3+5U
         /vscOGdH07qwWSGBHACkV3tktR1k6nOWkMDA5omFd343PHIhHC/7p7VcpUwWs9vGXECJ
         ebaGrxF0+eLNoLJH28lJW0489QyUdGbDROrgc90KjZw6sTyhY5WKGQwWhJHt+e6U1ikP
         laFh19PrhQMhr9DOmRwlICLD/g/hLWB18niZyBXXY38FgVWSXBVPo6bSYbnsNuGnTwCy
         gQ40ypHyDnjfRCdU7Okog9AlXrxjZB5cHUE/kFfOlqqiaMoDVrfXP6KaGdliVmIpqUiJ
         cH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=27+KdweROW/R9SRaLpZ3DhPF39588pcy9+cjDhON/6A=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=NuCon7hpkses/lavf7/h1V2nwuR7p9SEPeO4hTPiEkP1vZkhZK/v7sf9KEXDexpBKs
         t94jTX5qFlOOh/V/4+M7vvH/KC0YkZHbNisqjP2ZNqlLbDRa/hfRUNc5DnycxPorMvQL
         moszDc1jljgjAO0qV+xjI00aUR/gbthtm449XFfRDwtUwAp5d0bXeINLAFNieQ8Htz6A
         OSSZcgRBb++WTRuVOFel9oPyYqsI58t9fClijR77eYZhveRcy174d5BJ0tBXRFOI2FNc
         r3Q9Ie0rB5629RmUlTzqQDZTKXjcA8h51/WWOEDSkZDQYhrPG49KpT2LRqf6xC5uXJcS
         5dpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787053303; x=1787658103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=27+KdweROW/R9SRaLpZ3DhPF39588pcy9+cjDhON/6A=;
        b=EvWpEhaWoqWIuoSMZ4Cx5tOiBOltR/ixFrSoZcs+OemkcCfxbv7FFXquLLsYN7XKTC
         MZqCGCsvsSF49LL2Ot2U3SrYpqoIX3ZxbISqAVnIuuwMEmfDbs0WC59OyMjDY8ikfUuQ
         50Gg9XI1K6e9E3V07A7YlsA9EYKzvzPWS/1bGkN49UACHx9V2s9N8Jv9foCUOXHwEfQA
         rOdmg981t/kIG4ynliEA43PUATZTYHqN+iGoM3a3ngoXUJ4Sg9MjVDz92M+sKU2RHzth
         FgfVjYGif342xcz274ZAyce/0bxBZaezYDHiZSY9Z/AG3KE6Ifizeb9qErj8VrNitHwl
         VSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787053303; x=1787658103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27+KdweROW/R9SRaLpZ3DhPF39588pcy9+cjDhON/6A=;
        b=r1XsC2p1jHSdIWVspU+cnupJ+OFGRoQCZUj2krPEbsL9FVXulftyoI0MJZI5KVY8lU
         AyTP0AvP0LQTulufxHPh8rpGj6L6v4Y482o44on7obHjfF9cUoqfS0UfcOEoMQEz9Yz1
         VS7XtNrpTtDsYaiaTYfPzbll4Y5sQrAKr5AuVM04+VpH4J8/9Tz3BMDO7/O0NiBrWVjg
         lYMzvuDsOERKsx6thGaEvyN+mWv2w1Yart5oCMesEFSUbwEcH9NHtCKF7u51pFOW4Jth
         7bobd234EmT+YxFsguxE8Qc2UYv8CxJAgh7bjpq6G1JFP+pXnNNPdExIlELuVoDdG0l5
         gQ/Q==
X-Gm-Message-State: AOJu0YzgYzSEwByGx8h/gV+adYpmvHg9aO5mVVKDgxV4X9ZYzpT7UJBy
	IKiYhS8cm35FFHbB6+wUqUK2MOCSmdaQ13flnpimdLxHRgcHrmaawzqVNHiEZVzxqgj0geej0x8
	ICDj3XpOEv40gimKixCqNHfBg9KwWq7fXPMOvcI/Uu7oOqk8vVNTorJlYpkOvJQLP2VascqJ4p1
	UW6xS4QnJQsIFfZVp86lEg/44pZm53
X-Gm-Gg: AR+sD137FeFwEx0apSOKapTCxGT3HI6R65r+wBKYoHywbg8YqmZFdjJepsWbPInedev
	b8FWIWhvf4sZG8Kjc9+/dTSwJauAkz9xYFWC2qpP/WmXyNWIijdbZLTcUOxyBRERpbquRyspicg
	xDDG07qmToPrPU16Kd04rsKrIle8qfvAu/rCT1kxwDI24NyAIJed+d6Vgtm/+az9Ki64iXujZGU
	BvPXBruLz+3sJ9QoYUJ1m8iLHLUBhd93YOhVn2JNHzft/A5Cn5P7cHyARU=
X-Received: by 2002:a05:600c:848e:b0:499:7024:9d4a with SMTP id 5b1f17b1804b1-4999fb2ec1cmr134907875e9.8.1787053303155;
        Tue, 18 Aug 2026 04:41:43 -0700 (PDT)
X-Received: by 2002:a05:600c:848e:b0:499:7024:9d4a with SMTP id
 5b1f17b1804b1-4999fb2ec1cmr134906885e9.8.1787053302792; Tue, 18 Aug 2026
 04:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com> <20260812213206.1564354-10-seanjc@google.com>
In-Reply-To: <20260812213206.1564354-10-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 13:41:28 +0200
X-Gm-Features: AcwNN1W10G2UrG3IjZ4DEi_F_p_YJnrqec2MvIwGhmbZHhC55QKp3oW5ZgS8Z1k
Message-ID: <CABgObfY=TcRX1jimqQS4xRi72DMrV_46xQQQHdd+exwC6wbi2A@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: SVM changes for 7.3
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:32=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> A somewhat random collection of fixes.  Note, dropping FOLL_WRITE is safe=
 as
> GUP breaks CoW for FOLL_PIN.  This is explained in the changelog, but I f=
igured
> I'd call it out here too in case you have the same knee-jerk reaction I h=
ad.

Definitely worth adding a note to my tag message, just in case Linus
has the same knee-jerk reaction too!

Pulled, thanks.

Paolo

> The following changes since commit a204badd8432f93b7e862e7dac6db0fe3d65f3=
70:
>
>   Merge branch 'kvm-chainsaw' into HEAD (2026-06-25 11:32:09 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-svm-7.3
>
> for you to fetch changes up to ec9a16c6aeba8e19ce98c58a1ac255681a4dd0ac:
>
>   KVM: SVM: Always intercept ICEBP to workaround AMD ICEBP+TASK_SWITCH fl=
aws (2026-07-24 13:15:14 -0700)
>
> ----------------------------------------------------------------
> KVM SVM changes for 7.3
>
>  - Remove a dying VM from the GA Log notifier list before the VM is actua=
lly
>    destroyed, to fix a potential use-after-free.
>
>  - Don't pass FOLL_WRITE when registering encrypted memory regions, i.e. =
when
>    pinning SEV/SEV-ES guest memory, to fix a regression with file-backed =
memory
>    introduced by KVM's (correct) usage of long-term pins.
>
>  - Allocate full pages for SEV/SEV-ES {DE,EN}CRYPT ops on SNP-enabled hos=
ts to
>    fix a data corruption issue due to the PSP driver assigning to-be-writ=
ten
>    pages to firmware (as required by the SNP specs).
>
>  - Unconditionally intercept ICBEP so that KVM generates the correct gues=
t RIP
>    when handling an ICEBP-induced TASK_SWITCH #VMEXIT.
>
> ----------------------------------------------------------------
> David Woodhouse (1):
>       KVM: SVM: Always intercept ICEBP to workaround AMD ICEBP+TASK_SWITC=
H flaws
>
> Pankaj Gupta (1):
>       KVM: SEV: Drop FOLL_WRITE for encrypted region registration
>
> Qiang Ma (1):
>       KVM: SVM: Remove redundant ret =3D 0 in svm_set_nested_state
>
> Sean Christopherson (4):
>       KVM: SVM: Make kvm_x86_ops.vcpu_precreate() hook fully AVIC specifi=
c
>       KVM: SVM: Do all per-VM AVIC initialization during vCPU precreation=
 phase
>       KVM: SVM: Remove VM from the GA Log notifier list before VM destruc=
tion
>       KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops on SNP-enabled h=
osts
>
>  arch/x86/kvm/svm/avic.c   | 96 +++++++++++++++++++++++++++++++----------=
------
>  arch/x86/kvm/svm/nested.c |  1 -
>  arch/x86/kvm/svm/sev.c    | 29 ++++++++++++--
>  arch/x86/kvm/svm/svm.c    | 34 +++++++++++------
>  arch/x86/kvm/svm/svm.h    |  4 +-
>  5 files changed, 113 insertions(+), 51 deletions(-)
>

