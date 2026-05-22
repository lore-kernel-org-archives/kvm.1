Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD46138228A
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454194; cv=none; b=B+AdlIgqmSgwBtRtBBOtmAgMieijMKLKHYMxWZdpGutqkkWjoauwndftXakmMPuj38174pvzLr5hBZccCIoABP64atN7tM9xj61RMTg4bWFwWh+ZGAYobsKHoM5FpqNeT+Px4EI8+Y0YlZTmvPiuErPOphcEPnWmWcbviSnFmjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454194; c=relaxed/simple;
	bh=RbHOtVV6OeY+ZEk+4bAtnYf6cI1SHn8hUw08eOY8EZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N7VG+O5lfFsh9xcgPE2EYToAyiAw5hxuxosSjpKyLPUuL5GhKnjAlyOHCQ5XfvB0YUBLGs9KFRVoRL8wkusRIAlScIGkiOm0VHH6nvuCdJmaBRdh7py/vQECujGWvwkKf57+MSw8T5arISgrY9uZoEyWyogbfrZNu8ejyNPef/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=czYTJFew; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czYTJFew"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b458add85aso79229525ad.2
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 05:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779454191; x=1780058991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQXBtYOgD26OY0sxOaH3yIHE1h+TPqKS3BQiU+AvFJA=;
        b=czYTJFewNgQdudNdgwZ55E1+qPLX/eGbyT9zSr6Vfh27zIYrh5JeIpUkdT4qKbIJAn
         SCQfKHCc79A2ralZCRnqE7xqd/+WAkYl9RpZulbZ+8OWnhpXZXJjAT/6MOb+3nygBqCY
         /yXMpXT0iQ4TwXVvqcqgyW8SJsw3esyWj2mbVO16EIX1fNci1PWWE6w2nTxY2oSJPKNH
         uigKHszq9m4nhoT5+6B9imaZ6HHu+PEOpPb+/5774Bti5CH+EdiEvn7TOEnafnnOK4I8
         9uMj+980rBC2uvn5pgF7QSBmfXmeQFqOZYjETtuhWevuB7i0Zafn+fxtJYH8ixEXlLHB
         soYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779454191; x=1780058991;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DQXBtYOgD26OY0sxOaH3yIHE1h+TPqKS3BQiU+AvFJA=;
        b=ZU2ITP+vIOj97drGZMpx8vVQ54lIhlsbZT22pJulST+hYEMaY/eRn0oQzgRZbUw8pu
         G5EV8R9fdeimBGZsbvpO9PD/ASOca+5A2sVOZUx69izEjWQo8O/zVkTbMymt7ingCTjm
         tLPWTUrxsXpnWkM/nJej/SCwhaJCE0ZBvtvcv6e5sNTwABQYyOtmQ4MXyXoPzSx+bJ4P
         Ag7z6HD0WQWuKi4Wf6dn5E9/UvWSFLSJkNc0nR+o6l++XCA1JMT6C+t4b8GF87PITrSG
         Ruvl2iGjzuZ3s+YEQBhwVscrcxW/AApA3ItfiVbWAB2/cArLdflNRHORIYqkcTrHhCfw
         TTOA==
X-Forwarded-Encrypted: i=1; AFNElJ+/M02yTM19gmCxY1XV8ii9vkkCv7ODUaokKPPeH3CczAge+bYi2JVp9y7r1OrsYiDNNC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYNgFNFX1+bpZwG/IZj9nY6BCbQy7S9Pw0OWwGZIKnpTL9q2L
	AthfY+MtpcLYJg7jHYLVY+KDm3hO36fudx24LNQbe/3+SUQuHY0VGVDCs//z39JiuAhbz1XjywE
	JIx1BdA==
X-Received: from plpf11.prod.google.com ([2002:a17:903:3c4b:b0:2b0:51f0:272d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94d:b0:2b4:63bf:5535
 with SMTP id d9443c01a7336-2beb073d568mr36887635ad.41.1779454190670; Fri, 22
 May 2026 05:49:50 -0700 (PDT)
Date: Fri, 22 May 2026 05:49:50 -0700
In-Reply-To: <ab84153e33fbe7c25667f595c56b310d4d5a93ef.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260509224824.3264567-1-dwmw2@infradead.org> <20260509224824.3264567-28-dwmw2@infradead.org>
 <3ad6cd109480772ade3c11f23b9c1d7a9855d67e.camel@infradead.org>
 <ag-Hf2liLSX9q0rS@google.com> <ab84153e33fbe7c25667f595c56b310d4d5a93ef.camel@infradead.org>
Message-ID: <ahBQ7mXNaTtouT3C@google.com>
Subject: Re: [PATCH v4 27/30] KVM: x86: Add KVM_VCPU_TSC_EFFECTIVE_FREQ attribute
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026, David Woodhouse wrote:
> On Thu, 2026-05-21 at 15:30 -0700, Sean Christopherson wrote:
> > On Thu, May 21, 2026, David Woodhouse wrote:
> > > On Sat, 2026-05-09 at 23:46 +0100, David Woodhouse wrote:
> > > > From: David Woodhouse <dwmw@amazon.co.uk>
> > > That does leave userspace still needing a way to get the APIC bus
> > > frequency, to populate CPUID. So maybe I'll just make an attribute
> > > which returns that as a single value.
> >=20
> > Already exists, KVM_CAP_X86_APIC_BUS_CYCLES_NS.=C2=A0 The TDX architect=
ure decided
> > that unconditionally telling guests the virtual APIC bus runs at 400Mhz=
 was a
> > brilliant idea.
>=20
> Ah, thanks.
>=20
> So KVM always exposes 1GHz by default regardless of the actual host?
> Which is why there's no *get* method?
>=20
> (Well... getting KVM_CAP_APIC_BUS_CYCLES_NS returns
> APIC_BUS_CYCLE_NS_DEFAULT which is 1, so it's basically just returning
> 1 like a lot of cap queries do, and *not* returning what the period is
> actually set to)

Oh, that's just an oversight, definitely not intentional.  Easy enough to f=
ix:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1616b2eec6e7..cd4a244ca0c5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2235,7 +2235,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
                r =3D tdp_enabled;
                break;
        case KVM_CAP_X86_APIC_BUS_CYCLES_NS:
-               r =3D APIC_BUS_CYCLE_NS_DEFAULT;
+               r =3D kvm ? kvm->arch.apic_bus_cycle_ns : APIC_BUS_CYCLE_NS=
_DEFAULT;
                break;
        case KVM_CAP_EXIT_HYPERCALL:
                r =3D KVM_EXIT_HYPERCALL_VALID_MASK;

