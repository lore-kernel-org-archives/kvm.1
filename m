Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8A288C81
	for <kvm@vger.kernel.org>; Sat,  7 Mar 2026 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845112; cv=none; b=ivpFNKCFZaHdB9AQnTGQe3XdkiHF68D5/qMmAdDzUMPFqxLQFwJFNl8RSuOd5v4dH5DZdAUMMwuRJ2JyvR8DkpsoV8HQqWnnl4yROG7S/TSiRp5k4ln9GHJ5as3hAHQmiVkMgIUnX52kCyuNf24A7tp7C8y1cUEssbEIkYZYWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845112; c=relaxed/simple;
	bh=gUeTy650d69CYnjPmbPWI6oaDbdEdVumUYsXTrZYpwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4NDGaaD/yD6sD5m/Ul3yNCOI94K0VlLcD1W6Pwx4k4lBn6hcwG68CF+ghsMpNNqec62cMgkDMa4x4SXIH/KxOJ0bV7ByyV1XOsT1WbGArhPNAs+2A+RGaD3D2QT9VZ1pfCokXfu38TWqirmxFW823bw/nvzmY+oYJ0pTZtWhNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S12lkoSb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S12lkoSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D68C2BC86
	for <kvm@vger.kernel.org>; Sat,  7 Mar 2026 00:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772845112;
	bh=gUeTy650d69CYnjPmbPWI6oaDbdEdVumUYsXTrZYpwc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S12lkoSbVLj11SUne4oTYFbIKSlfsxGg20s8XIU3l+SlpQ5tuxQOYppKJDAnUdAtn
	 QEwWl6n1q0G9Rg2tGE5xNN5JT+2w+FtG+B6Fg/MI2FDqZR71j0GGp41JBYU8Y31zCo
	 /wiKEPPcmcyfxdEMJRCXuRl2C3Enqd6sN8YD5RYF09oTUzpdxuFUme814nyoZYQXxX
	 GpdogX4fFLGea9DZ4hi6wsK9Mn+GVpRfQugWYXuuM3Qay4XQYyzZEfW0sA3CWolWui
	 c1ihYNHj5eqnKpEOLl4FnB+5TvZ4p414mvftpkzef1aGKU7m85tXmHnh1bgTOZ6Uya
	 ZlpddS1u9yxpA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8d7f22d405so1437402266b.0
        for <kvm@vger.kernel.org>; Fri, 06 Mar 2026 16:58:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMvkD2HRwpbolX7nwb3k7C7LDWHr82bCE5aS4yzmiAGu/VhW7r63NwcJQvYg85HH2I0m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqoW/ZcpMrIAxQGDjxmg6ZWrTjOKaRxPuqQ2vWMORHq8uDt3Zb
	wW7YD9QAC+1Mcb+4ij2taPAsBFlFElRyH0bhNNCSv1BrZ6mX/3+gWSPy3R4WYj6o9os7ixkb6L6
	v6lgBi/HnOwZFBg9Q7HleMvGi/b5Zef4=
X-Received: by 2002:a17:907:7f86:b0:b88:783e:64fd with SMTP id
 a640c23a62f3a-b942df8345amr214819066b.45.1772845111370; Fri, 06 Mar 2026
 16:58:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306002327.1225504-1-yosry@kernel.org> <aar-gDulqlXtVDhR@google.com>
 <CAO9r8zO+sTttrKscx+9Sr+TECLrb5rHFTPThHYZG_e1qKSo+Cg@mail.gmail.com> <aat3s9EjKB_IsQQf@google.com>
In-Reply-To: <aat3s9EjKB_IsQQf@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 6 Mar 2026 16:58:20 -0800
X-Gmail-Original-Message-ID: <CAO9r8zOq=HJZbGiCyfn1OpQAVkq0=eA+KH7jBF7g+Frfi1myzA@mail.gmail.com>
X-Gm-Features: AaiRm51cDQM9BmX_CNMiLkszwGjjTxk3zcwqBXCFc3x163cqJxEVeSHFG7wudMM
Message-ID: <CAO9r8zOq=HJZbGiCyfn1OpQAVkq0=eA+KH7jBF7g+Frfi1myzA@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Propagate Translation Cache Extensions to the guest
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Venkatesh Srinivas <venkateshs@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Venkatesh Srinivas <venkateshs@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 4:56=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Fri, Mar 06, 2026, Yosry Ahmed wrote:
> > > Hrm, I think we should handle all of the kvm_enable_efer_bits() calls=
 that are
> > > conditioned only on CPU support in common code.  While it's highly un=
likely Intel
> > > CPUs will ever support more EFER-based features, if they do, then KVM=
 will
> > > over-report support since kvm_initialize_cpu_caps() will effectively =
enable the
> > > feature, but VMX won't enable the corresponding EFER bit.
> > >
> > > I can't think anything that will go sideways if we rely purely on KVM=
 caps, so
> > > get to something like this as prep work, and then land TCE in common =
x86?
> >
> > Taking a second look here, doesn't this break the changes introduced
> > by commit 11988499e62b ("KVM: x86: Skip EFER vs. guest CPUID checks
> > for host-initiated writes")? Userspace writes may fail if the
> > corresponding CPUID feature is not enabled.
>
> No, because kvm_cpu_cap_has() =3D=3D boot_cpu_has() filtered by what KVM =
supports.
> All of these EFER updates subtly rely on KVM enabling the associated CPUI=
D
> feature in kvm_set_cpu_caps().
>
> If we used guest_cpu_cap_has(), then yes, that would be a problem.

Gaah I mixed up guest_cpu_cap_has() and kvm_cpu_cap_has(), sorry for the no=
ise.
