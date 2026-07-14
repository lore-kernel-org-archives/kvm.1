Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFC312CDA5
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035233; cv=none; b=EfEhzKInWqS4cfqia5GM+vBg/hIAawHqt1mFqpOKBLOOcs4RS0Wu19w6S4/zAD55p8sG/p7TsnxoGFk8Aw3yscnZ3WKdO96Hyj02qty2ImLOQlchtkiX70oVJXkNpivJim0e21XUyPHU/tV7r+fg4aG87ABfxhmup2PlbSqK7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035233; c=relaxed/simple;
	bh=DRhexr3UWhVZdDLYkQX+zeoU2Fm1g90HjUyOORaaeUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUYwWMfG8gTv3IHqy1iFRfTWVG2OTjUAkKxsxiK0X5GRGKVCds4hw35P1uxmcrpRfrYqpCl9OFTXtg1s5pBhIGOOsqUfLInvCcGaAEf0YBYXNiUSp8bVwkV/KwYfCau0AHxiTXaMbHhVi08kQTmQ1CxnV4/C2jTf1gLQwR+DSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kodZk992; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kodZk992"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1281A1F000E9
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784035232;
	bh=DRhexr3UWhVZdDLYkQX+zeoU2Fm1g90HjUyOORaaeUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kodZk992n/wEhb5lU/1X0vg5kt+2aaomjDzFoJg5y1ez1P+W1PMWOEnlZ+8XaLtf4
	 MlzMlf+DhJXpyYSR7zfF9nNKDwxcqq6Y8UDQ21LoCgpofSbXs2N3BAJxsJp+EYKgEK
	 dFOWaJ5yGyyVxVjsL4jBzSGaDlsUIo5hmLR5p/eHhwJ4UfO1hihapOTab47+P5NKD4
	 X1GaQyLT8GWcaaf5PTiBx6DKaOnGS9k6fJmBT7eR94j34DTQSm1XnLb0y5voHYn/aj
	 1OUEaop11K0sQIOU+PGRY4j4jjdFv3U0QFF4zkGGvXfCPvqGqEWyfps1kcE3YkTSyf
	 feAMzRjHiWb4Q==
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8efb708b1a0so37350566d6.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 06:20:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrbwWzpWKO/XlojPAZ6rERvrmn4ioFWTjbN6Y1apGfIy/XueAZEJBdeR9Q9IVwk03az8kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHDhoAZqCVd9xzRk5oMa+NO/KpxuMExqNJP9+y9MzSPB34nubb
	YYMIXbcK0v2YSEkqnzHVEOFqw1kvxvvmr0O1qI1AAvSpK4imKzYQmztskFoo0idfTmGn8LMHXJR
	qDJUtisB0vS8rjw+HaTg4YCSfpHAPKaI=
X-Received: by 2002:a05:6214:1c43:b0:8fe:7fba:2db3 with SMTP id
 6a1803df08f44-9074c84be8bmr23222316d6.45.1784035231336; Tue, 14 Jul 2026
 06:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-3-yosry@kernel.org>
In-Reply-To: <20260616004155.1435766-3-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 14 Jul 2026 06:20:17 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
X-Gm-Features: AUfX_myBIlC-ACxM-KWdEVI6pnl9XHCD806Nb5NaB-fLaKbgIZOA3fqTlmJS6lM
Message-ID: <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 5:42=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> KVM currently hardcodes the number of supported ASIDs in CPUID to 8. A
> KVM guest (L1) would then do a full TLB flush (i.e.
> TLB_CONTROL_FLUSH_ALL_ASID) every time it runs out of ASIDs on a vCPU
> and updates the generation (see new_asid()).
>
> This is currently harmless, as KVM (L0) uses the same ASID for both L1
> and L2, and flushes that ASID on nested transitions. However, following
> changes will add proper ASID emulation and a separate ASID for L2,
> minimizing the TLB flushes on nested transitions. At that point, a full
> TLB flush from a KVM guest (L1) would flush both L1 and L2 ASIDs, so
> should be avoided as much as possible.
>
> Passthrough the number of ASIDs in hardware instead of hardcoding 8, to
> reduce the chances of an L1 guest flushing its own TLB entries
> unnecessarily on a nested VMRUN.
>
> In practice, there is no harm in exposing a large number of ASIDs to the
> guest, even larger than what hardware supports, as KVM never actually
> uses the value of ASID from vmcb12. Even with a separate L2 ASID, KVM
> would allocate a (supported) ASID for L2, and just flush that same ASID
> every time L1 changes the ASID in vmcb12.
>
> That being said, avoid the temptation of just advertising the maximum
> possible number of ASIDs (i.e. 0xFFFFFFFF), in case any peculiar guest
> OS does not handle that properly.
>
> Note: QEMU currently hardcodes the number of ASIDs to 16, so this change
> doesn't help QEMU VMs (without making a similar change in QEMU).

I had a discussion with Jim internally about what our VMM should
advertise as the number of ASIDs, and based on that I think passing
through the hardware value may not be the best idea, at least not
without some disclaimers.

Jim pointed out that AMD CPUs will ignore unsupported ASID bits, or at
least earlier ones did, even though it's not mentioned in the APM
(last time I checked). This means that technically KVM can ignore the
higher bits of the ASID set by L1 beyond supported ones (e.g. if it
uses a hashtable to multiplex L1 ASIDs onto several physical ASIDs).
KVM doesn't currently do so with or without this series, but it could.

The problem happens if a migration pool contains multiple AMD CPUs
with a different number of ASIDs in hardware. If the VMM advertises
the greater value of the two, it would technically be advertising an
unsupported number of ASIDs on one of the CPUs. If KVM ignores the
upper bits based on what it supports, not what userspace advertises in
CPUID, then userspace would be shooting itself in the foot.

I think technically speaking userspace would be in the wrong for using
a number of ASIDs above what KVM_GET_SUPPORTED_CPUID provides, and it
should use a number of ASIDs that is supported by all CPUs in a
migration pool. However, this makes the VMM's life difficult, say if
AMD decides to reduce the number of ASIDs in a newer CPU just for
kicks.

All of this is hypothetical in nature, but it's a very valid concern imo.

I think there are several ways we can handle this so that VMMs can
reasonably start advertising more ASIDs to guests without these
complications:

1. We can just advertise a larger ASID value instead of 8 (say 16K or
32K), rather than passthrough what's in hardware. I assume this would
mean that KVM is more-or-less committing to supporting that number of
ASIDs regardless of underlying hardware (i.e. KVM wouldn't reduce it
in the future). In this case, a VMM can just advertise the same value.

2. We can advertise the maximum number of ASIDs (2^32 - 1?), which is
the same as option (1), except that we're biting the bullet and
preventing the possibility of KVM ignoring upper bits completely.
Might be too aggressive.

3. Document (somewhere) that KVM should use the userspace advertised
value as the source of truth for ignorable bits, even if KVM
technically supports a lower value. As I am writing this I am
realizing it doesn't make much sense as it means that the value
supported by KVM is meaningless. Maybe that comes naturally with the
"don't break userspace" rule, but it could also fall under the
category of userspace shooting itself in the foot and KVM letting it.

4. Do nothing, let this be userspace's problem, and hope that AMD
doesn't reduce the number of ASIDs in a future CPU.

I think option (1) is probably the most reasonable, we advertise 32K
ASIDs, which is what recent AMD CPUs advertise anyway, but it's
more-or-less KVM committing to 32K ASIDs even if a newer AMD CPU
doesn't support them.

Sean, WDYT?
