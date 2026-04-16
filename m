Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB11A683B
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776299383; cv=none; b=CgoDV5ikMykZYxqkFsaUamO7gJa1eWsijg860OssAiRQw47d3UKVMMxu9k5ti9UtqAPTUQNmESgtizrzy633EyvQbm0U1lVFHCpxroLRKKKSJVW9+ht2FmxlRMCKIk9Byh77z6EnisjaEYqQp/f0N4n1EdVP3YFXrqLofnKB+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776299383; c=relaxed/simple;
	bh=4tLfhpuoWMl6k3LyIpifM7WBcRtIBiXUUr/hNejAVAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WEXXeNn5GS/ypGZ57DK2hOHSbmdA/6co+rBsne9qtA5V16f5KFrm4pwM4NDNtoEmkVhp3AA3+m/EVlrNw6Uu95xXyBZ/5VWhzQrkpKxs9Vqt5dRAYfnj0eYRqRKyG4YSISFamwNiab0aHTgKWkThbr+NCTnUg1CN0Z83ANAd70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T8AUHCR1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T8AUHCR1"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so1292022b3a.0
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 17:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776299382; x=1776904182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzU6XWZ7f5Cr6G2VmDhZlBgT6V/Dd8RtTH+gkK8bzW0=;
        b=T8AUHCR1tDq1ZWzBGINZfAnxf62LgYuvvy8eQywIyru2BbsXncdV3sLaMwqFzhAS2g
         LMHWi5jvMKKYSaYsInUvwseT2hjGiYvQGy0HvbZtYtCMeSZgBgCXe6mNEm5P5mnR2an0
         qnsTkdvrd8wXUu+rR7yeVg9HLaDSi/nTed05Xw2yb8nYpKa3rwfECR7AvfuHX7YfoSMK
         hkHrxuoRatjC4892yYRmZ6zLOUazY9H8+Jx3fQ3khoJEaOapvCemIWZ3fmLF2ZWKyjwj
         7x8tqGkR8pQp94nVDBi9rs1FR3HHvLeYTkB5n7DCyhj/HDrkKwKQZQeO6v/Fy/VGjePX
         SC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776299382; x=1776904182;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KzU6XWZ7f5Cr6G2VmDhZlBgT6V/Dd8RtTH+gkK8bzW0=;
        b=IXtWADdWQWLV/n7AECwlRATmFyPVbC9Qs4pIlEz4PyP4Z2U7nKxKmH5JEKVEl+Jge0
         J7SKy48v5Wl9bRYlEJPtH30BHX8x8iIooD0+WhEB0lXMOdIRqtD18tZKEp5b1EmH2veY
         4zE7VrvwK7jE+yAjGOhpJk4xOeHxsrv+YJ/dnBtLYhquMJEZoukyGsqMSze+6Oy1lj8U
         JGtn4JKhdG+yzn7y3kcvhTV7is8rc2LAHO+D8j0yhWE1eqlsKRl2I771wRPozZAuTPJX
         tf19J4IkHi0w1teC+ULrrVnjoWmQGmIYYPAg0cSG1WgE57nQPgNztDdfpn2h0UrITzXt
         S8bA==
X-Forwarded-Encrypted: i=1; AFNElJ9mMEs2FwXQx0+VdPyTcywYXYPZEjlN0UXYFTEPzSqErsL+LeijYfH7OvNZGdPmKQbCusg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMuQWtmh6C7VvNT5tcPmZqNB7FIgYi/FMmcRVBUG7I2CP9qp66
	zPXXE/FaBQXjElxt8u2Y3JAIkNOAnSM4qOaKY6OlSh4d1nnpqwk/w5+g41JYfjiZ+miRrzInLLS
	DvIPKqg==
X-Received: from pfwz19.prod.google.com ([2002:a05:6a00:1d93:b0:82f:541b:7b67])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:130b:b0:82c:217c:98ca
 with SMTP id d2e1a72fcca58-82f0c2194dcmr23763603b3a.12.1776299381692; Wed, 15
 Apr 2026 17:29:41 -0700 (PDT)
Date: Wed, 15 Apr 2026 17:29:40 -0700
In-Reply-To: <CALMp9eSHJmLLAQAvbvRmq99v568PGkJduoQn1djnXGb-yED_5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com>
 <adfgPwgXz1iQHpVS@google.com> <CALMp9eRLpZtpmdH4LJGdNkFO_hdJFw0i9MS94Ou1_GKHADq13w@mail.gmail.com>
 <adfmVXRwzZkvRSnj@google.com> <CALMp9eTvH1Pg0Eb-KCcX7LLJPFgS1xTSR0DzeA8xo4Re7=p=7w@mail.gmail.com>
 <adfyKU5WUiW4OnUg@google.com> <adgYSnE-I1Z19fCY@google.com>
 <CALMp9eSjAoVYk2f_j=b_X=EngJ935J=W7YS-C0nDS7b1j2Y4Og@mail.gmail.com>
 <aeACk7T5Q4TxtRMF@google.com> <CALMp9eSHJmLLAQAvbvRmq99v568PGkJduoQn1djnXGb-yED_5g@mail.gmail.com>
Message-ID: <aeAtdIPo-8uk8nvH@google.com>
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026, Jim Mattson wrote:
> On Wed, Apr 15, 2026 at 2:26=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > On Thu, Apr 09, 2026, Jim Mattson wrote:
> > > When would we use the deferred version? As far as the Intel PMU is
> > > concerned. there's nothing special about a nested transition.
> >
> > Actually, outside of VMRUN=3D>#VMEXIT, isn't the deferred version corre=
ct?  E.g.
> > when counting instructions, shouldn't WRMSR(EFER) be accounted based on=
 the *old*
> > EFER value, not the new EFER value?
>=20
> Unless you can point to documentation stating otherwise, I think this
> needs testing. By analogy with VMRUN and #VMEXIT, accounting should be
> based on the CPU state at instruction retirement.

IMO, VMRUN and #VMEXIT are broken :-)

But yeah, +1 to following what hardware does.  I was thinking we could look=
 at
our KUT and selftests code, but AFAICT all of the precise measurements are
bookended by WRMSRs, so an off-by-one on the frontend would be corrected by=
 the
off-by-one on the backend.
