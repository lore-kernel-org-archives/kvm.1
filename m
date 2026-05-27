Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B638B7BD
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925781; cv=none; b=j0ZQfidxeHscVXCYbVMs9XJhE5Ho8Jq7rg0Zwflme0jW0oV53RPbsgQ/cnSatZLhA83LMTIm0w5asjT5g14AfHm7Xi+DqJwFpMqEPW5AyOiTPgDNRb3QjI/osgbQvUM/d1Uxux7phKjuVYS0IWoLganYth0x4xvNhpsWsTlPKPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925781; c=relaxed/simple;
	bh=pTq0LqTckkRulgB4C8MRq4YW7t2zq0gXUKt5K8i1fZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7Ek8lkXcMrYZEupVaxYzUNe36oiRZH9KnapKUArLn0ArXi2dooNCJw32e7QlE4jmVbT01HjYRZGVQRAp9G0+FCmQCAxJP2Y0aoqOKhjc9ShRmgvZpARZz0LYN1sn0E4XWTOYKCadqv9qm5k3iELScIw9i2UUJQfMdTgty6+Qc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNRItCUz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNRItCUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8431F000E9
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 23:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925779;
	bh=TcOfKEdiNAel16+xP7tjMPPqKrxHymQZIh7pOvA0B7A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NNRItCUz6/1PXK54GmICGhfqy8vhQ/cRtrzEbAENBEAMv4b8534sJfSvJCI6fFuWy
	 fRcKjO6SFCNEpbTQo5nQN18gmgcM/+ZuDGoVk9WCG5RCZtuom4Rw74bgAIgPHX88Fo
	 UZsBfKZaa6FQ6CmPnWDxn7ftI3zbzG4GT3Xife0oKmU+KX6pJL91nPDY3viVhNx0Ft
	 Gm0OPKe+SCBB+FYaDVPEFU0LoiMCW0iYPf5klUl8i6tnHvAnd7hyDUD6Q+qZiu4yYc
	 JAVJZ20qglbGkrZvOIIOHpi9YC/p3rGTKcYZ/ze7Tp9OxubH6K3s8x5XYcNuSlPjDh
	 YAOW7n90nRhpQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bdd1986cc86so924500966b.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 16:49:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+2Eut1KYKYsjgYeoI2CopBEyDifNdJfHOkcHwYfzTSsQfYTshD6qJXpHQdGtT9IunBFYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHcVzjWYa5hvLaeD2X2vgXmppLzHLgoJ1+39vvShQqIdaN+rbK
	KdGjWU5CbxM8juzEG7yUgJoGT2T6a5IwFqHCsSlb4KVtbYSlJ+kshA3CnvAtqEmwkB+SiIrG07D
	RS++gNK391bjn6ThHQ4QWsrcUx5aOgOg=
X-Received: by 2002:a17:907:b59a:b0:bd3:893c:c44f with SMTP id
 a640c23a62f3a-bdd25fd111amr1135482966b.19.1779925778799; Wed, 27 May 2026
 16:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527180417.4119289-1-seanjc@google.com>
In-Reply-To: <20260527180417.4119289-1-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 27 May 2026 16:49:27 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNrz3U18hGOj9MAd46X-OHYzs9-QebH=D1TRp=wcHmk=A@mail.gmail.com>
X-Gm-Features: AVHnY4JiSXVam1T_54bVn9bMSZoH6JL5KTlNZOmfF2bsvQBRmkl5BCVqSqq4WU8
Message-ID: <CAO9r8zNrz3U18hGOj9MAd46X-OHYzs9-QebH=D1TRp=wcHmk=A@mail.gmail.com>
Subject: Re: [kvm-unit-tests GIT PULL] x86: random smattering of changes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 11:04=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Please pull a rather random set of changes that have been accumulating ov=
er
> the last few months.
>
> Note, the SKINIT nSVM intercept test fails on some Turin CPUs, but allege=
dly
> only on pre-production hardware?  I assume/hope such hardware isn't commo=
nly
> available, and so didn't bother trying to handle it in upstream KUT.
>
> The following changes since commit 9eb6c57313060d34f7e5b2ac6f90bb5873bbe2=
ff:
>
>   Merge branch 'mbec' into HEAD (2026-05-12 13:03:25 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/kvm-unit-tests.git tags/kvm-x86-2026.05.27
>
> for you to fetch changes up to c10d4616e2ad5d95553b2f0c389b4546dfacd76f:
>
>   x86/vmx: Remove the superfluous vmx_cet config entry (2026-05-27 08:59:=
46 -0700)
>
> ----------------------------------------------------------------
> KVM-Unit-Tests x86 changes:
>
>  - Track SVM's EXIT_CODE as a 64-bit value, to verify KVM does the same.
>
>  - Add nSVM tests for unsupported instruction intercepts.
>
>  - Serialize the (v)CPU after WRMSR(TSCDEADLINE) to prepare for APIC time=
r
>    virtualization.
>
>  - Disable PKU in the vCPU model when running the nVMX access tests to ma=
ke
>    the runtime somewhat reasonable.
>
>  - Extended the VMOVDQA test to cover VMOVNTDQA as well.
>
>  - Add test coverage for ENTER + emulated MMIO.
>
>  - Misc fixes, cleanups, and minor coverage enhancements.
>
> ----------------------------------------------------------------
> Isaku Yamahata (2):
>       x86: Replace NOP with CPUID after WRMSR(TSCDEADLINE) to serialize d=
eadline timer
>       x86: tscdeadline_latency: Remove unnecessary nop
>
> Jim Mattson (1):
>       x86: nVMX: Add retry loop to advanced RTM debugging subtest
>
> Kevin Cheng (2):
>       x86/svm: Add missing svm intercepts
>       x86/svm: Add unsupported instruction intercept test

Any reason not to include this series:
https://lore.kernel.org/kvm/20260312200308.3089379-1-chengkev@google.com/?
