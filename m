Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE8B40B377
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540653; cv=none; b=RE0RuvzIQt9vi5qdkK+zydBOIFY6Hs2uAXWB3qLyUpakC5k8/eVOxZxjM8F4b/8psMM49Fg8Fnvof+AJVpE27CuzbJC3uAPznkf2i8zPSHlZYYYyerhAjgiegq6lo6gEuJsUl4MGFNOoJCzniq06LUTPUGsxVIPFv3wTa+xY4MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540653; c=relaxed/simple;
	bh=EVt56oAjTD6wNFwS9tRM+Jo2ox+dBTYN6dvu6U4tLsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=usqvYNedXb/7RDn7woAEKWAs43mry4DawaS2PDV8ryNGeE0DsX8ntVWuc/BKvkF0auR+snwyIWnefyjUPTeULfAGDHda1f/mQRQUdonUlsfm99G+Ls0Q2ZtPFSZm1ZKByfktHKd0HhnKNkWOykM+kU5QeZ4Gyc9qTZG3Bm/8+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSPvKnPe; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSPvKnPe"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so5599045a91.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781540651; x=1782145451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVt56oAjTD6wNFwS9tRM+Jo2ox+dBTYN6dvu6U4tLsw=;
        b=GSPvKnPeRUXzyJYLwHaB0jP2RdsU2T7CGqeKKo/n7gPo7FHFAo+Q1lDwcJU4TEgUvq
         sQzE4ATM5MI4T9DxtyPosiLIhKJxQyBKP8xQh/NoVESYWsWwbISAP3aSCw+XykDTitwz
         cqP4bqSkmX7U5/eRwWESWqmQcWoD30/WIPSBta71qU6GuwC/6yiANPldMM1ddvk3Ukjs
         RJbDVECk6uxEjLNNosGhUTwzAqHqbPSb4iGcOl0RCRnKpYPwcqUmZjVmricCTQykmT37
         2ucoKZeB9/dvNd0u9FVOOm67DxK74Oe7NJ4MRWijAcv4QvzveKlMVTygx6+ynVXkMDxd
         Z5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781540651; x=1782145451;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EVt56oAjTD6wNFwS9tRM+Jo2ox+dBTYN6dvu6U4tLsw=;
        b=Vt3eG1YxNDiYpocmK6I/xNZoLDFMN8BZ9R5yP97NugMAqzN/hIdCsbXKCOpwBFxCPW
         bZWRF/x17tsz3HG2xKnhLtb0uChn0beUWDEAMuRpq2IH8Yaxs6fk/fdRqKXSeqXU5QQ0
         1KkgwSEqgt7PdzEq6M2y4bzWkHWsUv59i3/qWjnTjxbMH5rfsASpvwPCcXwnsrGo8XPX
         pLCz8UAXRlpSNTpaBEth2Jc2Bgd/H8i5vfZ5ZlACrWyox6JvxslRHS7J4crgpN6zar2M
         ZZq8yCNU5d16RA9JHPxZMXsING8abVIOu2ekuRQyrnP9f0UD82+obsL9be1VHa3i4l86
         KGLw==
X-Forwarded-Encrypted: i=1; AFNElJ+cGTsRrBb3ZfQIBMX1HG9W7m9i8hHG6yr5HScN/n9j2g0m9Zs3+Pi6yqEz1hQYwQrC/Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXfBrPF8j2SvTWGhx/27/yRSDk0BOFP07hHO4DtzQWm3l0vKwS
	5F+8svsOoYHO+IbhOdY2bEmtmYour1WEMRoyRe5UY1zkLKkh+aproubO5lqJFeKvdEQshzYaSX8
	JGkP/Yw==
X-Received: from pjbrr7.prod.google.com ([2002:a17:90b:2b47:b0:36a:7bd1:2d9c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d006:b0:36a:8ce7:b879
 with SMTP id 98e67ed59e1d1-37a018486cdmr14629534a91.5.1781540651113; Mon, 15
 Jun 2026 09:24:11 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:24:10 -0700
In-Reply-To: <69019093-fed6-4cb1-b3b5-a62a3a46578c@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-7-seanjc@google.com>
 <ea5bb362-f6ff-48e1-94f0-0b413969a186@intel.com> <69019093-fed6-4cb1-b3b5-a62a3a46578c@linux.intel.com>
Message-ID: <ajAnKleLBD411Uka@google.com>
Subject: Re: [PATCH v4 06/30] KVM: x86: Move kvm_caps and kvm_host_values to asm/kvm_host.h
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026, Binbin Wu wrote:
> On 6/13/2026 5:01 PM, Xiaoyao Li wrote:
> > On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> >> Relocate the kvm_caps and kvm_host_values struct definitions and their
> >> associated global variable declarations to asm/kvm_host.h to allow for=
 a
> >> variety of cleanups in x86.h and mmu.h, and to establish a (hopefully)
> >> maintainable rule that asm/kvm_host.h's role is to define common
> >> structures (and declare any associated globals), and anything needed b=
y
> >> arch-neutral KVM.
> >>
> >> While it would be lovely to trim kvm_host.h down to the point where it
> >> *only* holds things needed by arch-neutral and/or non-KVM code, multip=
le
> >> attempts to do just that have failed miserably.=C2=A0 Trying to "hide"=
 code
> >> from arch-neutral KVM is too restrictive (and ultimately pointless), a=
nd
> >> KVM x86 itself also needs a place to define common structures and thei=
r
> >> globals, e.g. to avoid inconsistent header include chains and/or mispl=
aced
> >> helpers.
> >>
> >> E.g. as pointed out by Kai, it's weird that x86.h, which is a kitchen =
sink
> >> of sorts, includes regs.h, but not mmu.h.=C2=A0 Literally the only rea=
son that
> >> x86.h doesn't include mmu.h is that mmu.h references kvm_host, which i=
s
> >> currently defined in x86.h.=C2=A0 As a result of odd include ordering,=
 the
> >> very clearly MMU-specific helper mmu_is_nested() lives in x86.h, not m=
mu.h
> >>
> >> "Fix" the kvm_host dependency so that x86.h can be the "central" inclu=
de
> >> everyone expects it to be, and set KVM x86 on the path to having somew=
hat
> >> sensible "rules" for what goes where:
> >>
> >> =C2=A0=C2=A0 - asm/kvm_host.h holds "common" structure definitions and=
 associated key
> >> =C2=A0=C2=A0=C2=A0=C2=A0 global variables, and things that are referen=
ced by arch-neutral KVM.
> >=20
> > I'm confused by the term "arch-neutral" all over the changelog. I suppo=
se

"arch-neutral" refers to virt/kvm code and other code that isn't arch speci=
fic.
I used arch-neutral here, e.g. instead of "common code", to differentiate b=
etween
arch-neutral (virt/kvm) code and common x86 (arch/x86/kvm) code.

> > include/linux/kvm_host.h is arch-neutral while asm/kvm_host.h is
> > arch-specific but not KVM internal only.
>=20
> IIUC, it's the situation where asm/kvm_host.h for x86 provides the
> x86-specific pieces that the generic/arch-neutral KVM depends on.
> E.g. struct kvm_arch is defined in asm/kvm_host.h, which is x86-specific,=
 but
> the generic KVM embeds it in struct kvm as 'struct kvm_arch arch' in
> include/linux/kvm_host.h, i.e. "referenced by arch-neutral KVM".

Yep, exactly.
