Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE9395273
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823685; cv=none; b=RPW6FxWZ+KxaSFS3JiEYxY4ZA6SfAoHNEszMOvvLL6nelkZX95jUlDA0+Nluz75YgxUfeaKrgIfcm99n4cWIOKFpfUhWjf9qx6VPJxD4uSR5lvM4dxJpYHxoVchvinS1tn0qTPt78jYthlJNdshkfp4mI2XtEhfM85sztvKQqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823685; c=relaxed/simple;
	bh=Zn6zFRPZqXi0QzW7YY3iv8zN7h8vLIg8vDHuWf+op1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QnflGfMem246NC1ctFIFTmseAmIM/3MvvTU9QIq+9vFXUnW7GxVRnc/jfWdPV77p4lnRQoyhH9gu8jbzGB+wiPJ78U99ZEFgobRhKCxlMCelPmLn1axwBP5kSiyHG97qZRxihdu5dpGPbu7x+dMZKqaqlWwIktzMGgQBSggH/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pAWBHwDe; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pAWBHwDe"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39512608fb1so3461607a91.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791823684; x=1792428484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LibxDXO+KDgRqmVow7/Whkw5PtEP6MVPh2MsRLI8bpU=;
        b=pAWBHwDeCXCPPzSeHjx7RpuXvh6ZivLEmhNU/RIsqV36A1hDm51HpG8tfTqijdvcuZ
         rYJW4XlJ0AYvKFGg2yRSo7m2+0SRnb0b76HaCcapLrJkyaxSMVb6EF3TB5oteTXdbNH1
         gAeix97OMT9STD19Nu+wv2V/dS/uY85opjbXW71bTlHJagxgOXiYo+2ZjdwRfVAeKxbn
         CjYP0nrMBA8sqUfqCDjFAG52Xcuhi+BSeT6FIPllEaFlEUJRXimR5BtT7f22ThNwM8qT
         8JSA15CGIgUQoeLgyVA/yeHgIMb83tJQ5RI+5Qq7V4YBBfTGz/tF6z48hhv9uTkFClYj
         bbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823684; x=1792428484;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LibxDXO+KDgRqmVow7/Whkw5PtEP6MVPh2MsRLI8bpU=;
        b=18o2CLoq8YrNUM+Gi6vyudr4HtWB9DSzdl9q1f8tWvRysuvB6tB3rB3mTVb7Fpr3R0
         xr3CPxiUmt9uX/MPoR2SEKG53fk8XDaUL9m9or6Sm1MJEV9+80htTrACLfcd/ShXJuDa
         dTI4D2an/ZrUkfWyQ+FD9Eahsi1+tjXBnTQwqU0F7cWcBou+oVlbtDL1sAJJmzbINqeI
         7SJPQ4O8LS1r7Nr75ynhvu+A0LHEKwdzfTY8r/5/kTqwxNAEjMbAVfzjoTPzjlccWrl5
         RfETTmBE7mpdFYPD6VTJXjo1wMmSAaZxP2a/mTjzjq8ii0x33SraLRe0iN18oMVpa6DY
         vyAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUrOF8NHD+P1poN0AtOdIA2dandVkqcPzT4H3cBAwp2vo88+LOI3m124Ppxw7n3uu0+SM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGhI+f1CVd6jHwpxZraN9wX+t5xoCyPybixfNdyRTc1pL4aQbl
	C0o3L5elzllT7X+ySC0d2H70JZvmnPQ1Y1weM4MxtL4niubRbnFBsmRgDvlLyxVyB3IZjRPIL5o
	0SOAHIQ==
X-Received: from pjbov12.prod.google.com ([2002:a17:90b:258c:b0:3a8:a8e6:f289])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:916:b0:3ab:e588:c2a0
 with SMTP id 98e67ed59e1d1-3abe588f906mr1929716a91.56.1791823683410; Mon, 12
 Oct 2026 09:48:03 -0700 (PDT)
Date: Mon, 12 Oct 2026 09:48:02 -0700
In-Reply-To: <CABgObfY=xYUJJtYvcVhjdTXOah6eofi0O4C3J3sa60KCC+WO6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261009130450.361690-1-pbonzini@redhat.com> <as0NBfuEY-60pgtz@google.com>
 <CABgObfY=xYUJJtYvcVhjdTXOah6eofi0O4C3J3sa60KCC+WO6A@mail.gmail.com>
Message-ID: <as0PQm_PS3LC9KWc@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	SimonP <simonp.git@mailbox.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026, Paolo Bonzini wrote:
> On Mon, Oct 12, 2026 at 6:38=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, Oct 09, 2026, Paolo Bonzini wrote:
> > > When running Hyper-V from Windows 11, KVM is seeing the SS bit set
> > > in nested page fault error codes produced for shadowed NPT.  The AMD
> > > manual is unclear about when SS is set, including whether it can be s=
et
> > > when SupervisorShadowStackEn (bit 6) is not set in the MISC_CTL field
> > > of the VMCB; in fact, bisection shows that while SHSTK was available
> > > to guests since Linux 6.18, this started happening with commit
> > > 687ee95c1b6d ("KVM: nSVM: enable GMET for guests"), which seems unrel=
ated.
> >
> > It's not unrelated.  As you note below, this is purely because Hyper-V =
only uses
> > CET when GMET is available.
>=20
> Indeed, my intended meaning is that bit 1 of MISC_CTL does *not* have
> the side effect of reporting SS failures...
>=20
> > This is wrong, I reproduced this with the KUT CET test with gmet=3D1.
>=20
> ... howver, this makes me wonder if you meant gmet=3D0? Because if you
> need gmet=3D1, the Fixes would be fe080f58dec24049 (i.e. when the gmet
> module parameter was added).

/facepalm

I did indeed.  And I quadruple-checked that I could trigger the splat with =
gmet=3D0.
