Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792611184;
	b=ybP57xjFaJpYdkLfDkuPb1CjvjK2KngTbSXgRH/Ym8lXT2EAB4uQnvPmkTmJ786CHJw/
	 KMQITOWXg9s/XhsOyq4yrpi5ykhr8Z3ahW/NljtpVSBPRpIhWwBo+1Q7lIZ4Rc2wDCuwI
	 GlijP/RvZ7N0HBCqqEG3kW2BOoVVPWGMjwncbbizTbNeP3Anh0Gj6i8mL5kTndhfw5aJD
	 rODAvNsEEY1vt+OYJaxOO5QL73Mf9hOF3lTdxP5e+GYTGBRrSZPE2YrdyCnBJSJdB9ZJj
	 pHZhiNxz7uwKC8Xlg56Y3tl0xQocdLLI0bM8e8j/abJxVZtmRREs0tujFRlGMj/L08w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611184;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=8gftYBqZkW1GZ9nkLXxq5OPxgiNVwbGOASN8EnEPFk4=;
	b=3JOfeRCFJxKqNJwh0IhE6LykH7bOOSNz1QRyUUEJelqkw8ON3OHxJvfzWb0a8ORNxStO
	 H+pEjm/iKYv//eJUHcF9I7CYZqCkTy6suGPq6aAamj/PNXAQLjhVA70gjPaxjrBxunFwI
	 EAAs57GnIu/05YMe2F2WIlYYzgO1JixardPJKWPyWGWM85hS8rKCJmKyrNBDv1SAifoJA
	 TCX2UGJ2Q0doHUYVHui6+ZNjFwRj1LDkEhS7g/B48w9QVuviTQOtvoDc8epDiuRfGWspJ
	 Rmr0t2YeIyejK5Pvy6aP5nnmPLTm7BztMdf2OHrOONSEC8RWPpqc5oKhQwkslj9pGEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JVIK4/yy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F5606A31E
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JVIK4/yy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76011F000C1
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 19:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792611183;
	bh=8gftYBqZkW1GZ9nkLXxq5OPxgiNVwbGOASN8EnEPFk4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JVIK4/yycKfB3RNWan18xDFQ0GP6VaHhilFAntNpJBDNZUhp4gncG8P8myoigGzSn
	 OgbGsLZqD5IB5DiB4kvSoWYoWH2JppTD8CesgeLSJFx0Tvvrnk9lIpylVjHGy0j5K0
	 11cag3gpruDJVcaaOc1Vz9BXxOBS0P3ve/qM6Pu8/Xp3WMgmfRLvtVtrVsVd3dFzKj
	 XhnOr084VTvYfBlIUfzxutdCRc9Y0QW/K/woOxZbrHTw5EspCGeNhrTIXqrQSoJ90e
	 RKBxybyYQpMYtjVo0zF6nO1s+zVeCaveZmSNvsriIywDEQGPSl/+Jv3WRHvqrKGHLY
	 xJVbsxsAOuiWQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso1724326a12.3
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 12:33:03 -0700 (PDT)
X-Gm-Message-State: AFq9FYLYAYLnLBvBLjXDuNJJIDI1ILHoXYdeN7Wth2ZK7T8iW+NAc+lA
	7QHsnB0/9yV0e1DYvA2RcV42fSkEnpzv55F5ALmOUTsRTZenE26gN5fZWDU7MAq4HhA26U0L3lh
	OOS/miF91rlHHDXaA+490hEI/Kddd/j8=
X-Received: by 2002:a17:906:dc8e:b0:c44:14d:d95d with SMTP id
 a640c23a62f3a-c46796ec9bcmr259538866b.23.1792611182837; Wed, 21 Oct 2026
 12:33:02 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260312200308.3089379-1-chengkev@google.com>
In-Reply-To: <20260312200308.3089379-1-chengkev@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 21 Oct 2026 12:32:51 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOEqpVwLnpT6DQMboA4m4cPZ7rztpy=nj6VR8b4pd88Vw@mail.gmail.com>
X-Gm-Features: AclHuK96nB-PS-enke6oOnPp9qDcIXa2wePJOegIk0fSbaQvq3y7riThklP-JlQ
Message-ID: <CAO9r8zOEqpVwLnpT6DQMboA4m4cPZ7rztpy=nj6VR8b4pd88Vw@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH v3 00/10] Improve test parity between SVM
 and VMX
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, andrew.jones@linux.dev, thuth@redhat.com, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 1:03=E2=80=AFPM Kevin Cheng <chengkev@google.com> w=
rote:
>
> This series introduces numerous tests for features that VMX testing
> covers but current SVM testing lacks.
>
> I went through all VMX tests and identified which ones could have an
> equivalent test written for SVM.
>
> This series also includes some canonicalization and consistency check
> tests as defined by the AMD APM.

Friendly ping for this series :)

>
> v2 -> v3:
>   - Open code assembly instructions in svm_ud_test as per Sean.
>   - Removed unnecessary separate config for svm_ud_test as per Sean.
>
> v2: https://lore.kernel.org/all/20260113003153.3344500-1-chengkev@google.=
com/
>
> v1 -> v2:
>   - Renamed check_npt_ad_pte() to found_bad_npt_ad().
>   - Renamed test_event_injection() to svm_event_injection() and removed
>     the test from the svm suite to run separately.
>   - For the svm_event_injection test, injecting the CP vector now relies
>     on shadow stack capabilities as suggested by Yosry.
>   - Added a new test for verifying that certain instructions generate a
>     #UD when EFER.SVME=3D0. This is a regression test in response to a fi=
x
>     that is currently under review [1]
>
> [1] https://lore.kernel.org/all/20260112174535.3132800-5-chengkev@google.=
com/
>
> v1: https://lore.kernel.org/all/20251219225908.334766-1-chengkev@google.c=
om/
>
> Kevin Cheng (10):
>   x86/svm: Fix virq_inject SVM test failure
>   x86/nSVM: Add test for NPT A/D bits
>   x86/svm: Add tests for APIC passthrough
>   x86/nSVM: Add tests for instruction interrupts
>   x86/svm: Add tests for PF exception testing
>   x86/svm: Extend NPT test coverage for different page table levels
>   x86/svm: Add NPT ignored bits test
>   x86/svm: Add testing for NPT permissions on guest page tables
>   x86/svm: Add event injection check tests
>   x86/svm: Add test for #UD when EFER.SVME=3D0
>
>  lib/x86/processor.h |  11 +
>  lib/x86/vm.c        |   2 +-
>  lib/x86/vm.h        |   2 +
>  x86/Makefile.common |   2 +
>  x86/access.c        |   7 -
>  x86/access.h        |  11 +
>  x86/svm.c           |  16 +-
>  x86/svm.h           |   9 +
>  x86/svm_npt.c       | 801 ++++++++++++++++++++++++++++++++++++++++----
>  x86/svm_tests.c     | 664 ++++++++++++++++++++++++++++++++----
>  x86/unittests.cfg   |  54 ++-
>  x86/vmx_tests.c     |   5 -
>  12 files changed, 1440 insertions(+), 144 deletions(-)
>
> --
> 2.53.0.851.ga537e3e6e9-goog
>
