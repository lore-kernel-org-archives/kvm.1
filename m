Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92564423EB1
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072505; cv=none; b=OQgfeTAUOSxbapECxnV2JoSsX1Xv/Uib29yzuhk9YkOsmI2qI+fyBzQrhk1rfmjJVLXPhV3dIt9QPFE0FVQ+c4yNJSXBA7wWJu0YvEyZngnvO8ddXCn9qEq9XK0jaQt2dBobkv8FFT1y00Pl/Cwz3+192Np/YvuHTh3rF1WaCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072505; c=relaxed/simple;
	bh=lQI1ltRDfG25H0oHSfUwYdJpYhMirhrwY82cJD2C17k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qWAbzck7HdpH+58wM4AV7kFBEF6PXIuiwFYtC0HEaMF9SI4H+DFSMwe+78dJe7MADqn6AoeF5u9oNb/5nBCMyptQixiJ2OlDUPx9ETyig1Eunz9XvN1ebiBduoARu2Td3ym3p4UXz4TrhKKvrVgpMN540xCgTIg2KkoQcUQnnQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O6Y2HJ3K; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6Y2HJ3K"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso1769891b3a.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784072503; x=1784677303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kNayng4wVgR7/vbYN7T9tTPosZzzZ5P4eBqZ7cxpep0=;
        b=O6Y2HJ3Kg26wk+yEVT1VUm6qCin8432RgkFAtyKSmjLAQbecEI+isoMCykkzQdejLR
         uwfbvj2/dIr/x0/oul+HIOeI/0w/UvXSpn0YYJIxkf97c1OtuYLg8K1UkP32+7J3Sx8X
         ypPg7I5hr43G7WVp1DNRB6z73xWg8B6zlIsWs5qPI+ssTlfEDj2C09eTuGWmnCkTtxd5
         oUjBREGFgV5C6V9RGHgUcyPLRuq5nnnvbE362syCtsTmcXLhlYXJIdCFaNM6D3sHAJJF
         SEfagbt0A5zRaXJkeDc+tAfDUFGnnexDRiVjBjo5mI53oDCu8WV6Bqt4DtzWBiCbomMK
         Ho+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784072503; x=1784677303;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kNayng4wVgR7/vbYN7T9tTPosZzzZ5P4eBqZ7cxpep0=;
        b=FT5GmihEO9DtzMZPTk0DsbhZgZwpRMxtFyKuJJIixczvyZ08dz+amQWAOz33/YZYir
         NSCIjrPXDWec83bLYtIm891G1vpQ8DP/4oZlURfC+Fh30tT9aU99I3OSWvvFEdSRhQAQ
         XKoohm6L7YfobvAhV4mWKtpdRoVmoxSTGSObFFdRUudw9vYvht2vkybxlHSOWQCGhnlY
         D+SygPq9/ASAwnT3Y+G6zKspBBL4o53u5ucaQTSDsWzqkT2tPDuY0OqyOz1oBwYtDmqu
         JmNw23A7V6lmFc5UqoA7XKZvUZQikWZ1SkPhALPn4nqiMaqSWtkLworSI+sYWrNZYBZU
         u7SQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6SvOZPsIo4ZldkHtewtMs70GNiewIKqc70hXbyGh+yJgSsUe6oZjcU+x6A06Jy/zoWdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5jZ3l0jVngldbopg/TbwTIFizol2qQalsg6ZSvo5J5PWq7V5g
	wkvsMcpA4Mov7ouZ/mu4Z67KNY92DvSp1ryH834pu1V9loyJqoUo5PoQpMMWE6yrQCK74kC1rWn
	ctnYO4Q==
X-Received: from pfff9.prod.google.com ([2002:a05:6a00:bd09:b0:848:487e:d23c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1881:b0:846:f517:ba5a
 with SMTP id d2e1a72fcca58-84889716692mr14284967b3a.28.1784072502419; Tue, 14
 Jul 2026 16:41:42 -0700 (PDT)
Date: Tue, 14 Jul 2026 16:41:41 -0700
In-Reply-To: <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-3-yosry@kernel.org>
 <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com> <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
Message-ID: <albJNb-akQJ97Yor@google.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026, Yosry Ahmed wrote:
> On Tue, Jul 14, 2026 at 2:28=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> > > > Note: QEMU currently hardcodes the number of ASIDs to 16, so this c=
hange
> > > > doesn't help QEMU VMs (without making a similar change in QEMU).
> > >
> > > I had a discussion with Jim internally about what our VMM should
> > > advertise as the number of ASIDs, and based on that I think passing
> > > through the hardware value may not be the best idea, at least not
> > > without some disclaimers.
> > >
> > > Jim pointed out that AMD CPUs will ignore unsupported ASID bits, or a=
t
> > > least earlier ones did, even though it's not mentioned in the APM
> > > (last time I checked). This means that technically KVM can ignore the
> > > higher bits of the ASID set by L1 beyond supported ones (e.g. if it
> > > uses a hashtable to multiplex L1 ASIDs onto several physical ASIDs).
> > > KVM doesn't currently do so with or without this series, but it could=
.

Deliberately ignoring ASID bits would certainly be a choice.  I can see why
hardware might make that compromise, but I don't see any reason why KVM sho=
uld
do the same.

> > > The problem happens if a migration pool contains multiple AMD CPUs
> > > with a different number of ASIDs in hardware. If the VMM advertises
> > > the greater value of the two, it would technically be advertising an
> > > unsupported number of ASIDs on one of the CPUs. If KVM ignores the
> > > upper bits based on what it supports, not what userspace advertises i=
n
> > > CPUID, then userspace would be shooting itself in the foot.
> > >
> > > I think technically speaking userspace would be in the wrong for usin=
g
> > > a number of ASIDs above what KVM_GET_SUPPORTED_CPUID provides, and it
> > > should use a number of ASIDs that is supported by all CPUs in a
> > > migration pool. However, this makes the VMM's life difficult, say if
> > > AMD decides to reduce the number of ASIDs in a newer CPU just for
> > > kicks.
> > >
> > > All of this is hypothetical in nature, but it's a very valid concern =
imo.

Eh, I disagree.  It's hypothetical, and not a concern for KVM.

> > > I think there are several ways we can handle this so that VMMs can
> > > reasonably start advertising more ASIDs to guests without these
> > > complications:

What complications?  Advertise the lowest common feature set for the pool, =
just
like userspace has to do for literally every other feature.

> > > 1. We can just advertise a larger ASID value instead of 8 (say 16K or
> > > 32K), rather than passthrough what's in hardware. I assume this would
> > > mean that KVM is more-or-less committing to supporting that number of
> > > ASIDs regardless of underlying hardware (i.e. KVM wouldn't reduce it
> > > in the future). In this case, a VMM can just advertise the same value=
.
> > >
> > > 2. We can advertise the maximum number of ASIDs (2^32 - 1?), which is
> > > the same as option (1), except that we're biting the bullet and
> > > preventing the possibility of KVM ignoring upper bits completely.
> > > Might be too aggressive.

And potentially suboptimal for performance.  There might be a legitimate re=
ason
why a CPU generation advertises X instead of Y.

> > > 3. Document (somewhere) that KVM should use the userspace advertised
> > > value as the source of truth for ignorable bits, even if KVM
> > > technically supports a lower value. As I am writing this I am
> > > realizing it doesn't make much sense as it means that the value
> > > supported by KVM is meaningless.

As above, I don't think KVM should have "ignorable bits" in the first place=
.

> > > Maybe that comes naturally with the "don't break userspace" rule, but=
 it
> > > could also fall under the category of userspace shooting itself in th=
e
> > > foot and KVM letting it.
> > >
> > > 4. Do nothing, let this be userspace's problem, and hope that AMD
> > > doesn't reduce the number of ASIDs in a future CPU.

By "Do nothing", I assume you mean "advertise what's reported in CPUID"?

If so there's a fifth option.

 5. Be super paranoid and zero the entry, like KVM does for the topology le=
aves.
    See commit 45e966fcca03 ("KVM: x86: Do not return host topology informa=
tion
    from KVM_GET_SUPPORTED_CPUID").
   =20
IMO, the only sane options are #4 and #5, and #5 feels unnecessarily parano=
id.
I genuinely don't see how this is any different than any other feature wher=
e
userspace needs to not over-advertise features across its migration pool.

"Simple" use cases that don't do migration and just reflect KVM's CPUID int=
o
the guest Just Work, and more sophisticated use cases get an explicit hint =
from
KVM as to the optimal number of ASIDs to advertise.  I don't see why we nee=
d to
make it more complex than that.
