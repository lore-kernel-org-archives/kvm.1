Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641840;
	b=nIJKSobVsvgzjF4VWAUCtlXuWB5x5TCIkhv9asWE1lM/otzmQC6ySV8tV07zIjEq9eGY
	 qSbqgc9SifQLOSixn9LMQArlD56eaPe9D0ANYQUeqg66hW/n54mZKML7SMnNel7Hxok3E
	 8wlubHa7BmWwqdRLAiMAbFQsxf6U9fCcMydlNWhVDGfi/51zLa9cLjO4Ud3ojoSGzkmT/
	 5cgwAu0kxA+AoGzujXulQdTVyzxjcq2rT9tj5xVXFKOOGU/TNLp8hWNz97rZkGziroHTJ
	 zVZBJm8uHShha2fYKRhYLx7jk92xiGbYoEvQji3dFqfSjoOHbq/53pWxC6dsrAJ4erQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641840;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MbpMrPfAJkzH84jz1jUrcuftv0Ahe2G5yuntSJxYSQs=;
	b=l9yypvbK3z66X6ddVgjk+LQ2sXfBYH/S6eEKc6WpH7wvbJjbBzupHrEk9+mYzovtMNno
	 gog0OrmaIa64RInqPtt4aJLCWea3BlQMNGMGnfhyhHu9H+zHBq10KXRparGBRdcCEa3Oy
	 +0xvhn6R+ltaOKr1N25/OOUHy6oXyzXW007qNu3Zi1bksG2ppTwkoIvVagG4nZMzif+g6
	 rwhREgqTH/tsgzp33rOr6sWKxWkTniED+dH/ieslBQdY30oCxrWazwRdEFNTCRUZhrjIT
	 c8PIQnRQ4Yiw3jHPBSLG4ZV1GNkgB/usElDUd+3hVPP/Z88MJPK1rjqtff5COxKEKqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHVuuHer;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226EF606A337
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHVuuHer
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94731F00A16;
	Mon,  2 Nov 2026 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793641839;
	bh=MbpMrPfAJkzH84jz1jUrcuftv0Ahe2G5yuntSJxYSQs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dHVuuHervwGcajPbDAm3BNwVewpz/7T2bWe1/JBlmyMGBmvxdu6ogAIXE7KqdU/jJ
	 3e/uAf+986WA7vdFBLQ/tJd9HgqbwdwR0zXGF3/T+gdxpNG8jAPZEtkifum43RhbL7
	 rb5pToRfaeMLYtf0e+2xARJK5XjHRZaWOddQsTP+oQrExahJV1V4AXCg20A0udzZrn
	 1W68kLptxKkZZI94u5WLFaX+RGyCDUWaqusI3dXBBgzGmq1/f5lXyRz7fuhdXXHk7o
	 c9445yAjhjyIzhcZ9LsebsCZJMvZcmCxig0GCGYUxLcvyl6jgmcXbT1jZsx1TSIXNe
	 lwCXd0sefFN0Q==
Message-ID: <sashiko-outbox-193873@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/45] KVM: selftests: Take into account mixed memory
 fault flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174130.8779-8-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174130.8779-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 17:50:39 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: selftests: leftover flags check in test_private_access_mems=
lot_deleted()
--

commit 6287705468987b3051cb61deae85c0b625189112
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: selftests: Take into account mixed memory fault flags

This commit updates private_mem_kvm_exits_test to check that
KVM_MEMORY_EXIT_FLAG_PRIVATE is set in memory_fault.flags using a bitwise
test rather than strict equality, allowing other valid flags such as
KVM_MEMORY_EXIT_FLAG_READ to be set alongside it.

Link: https://patch.msgid.link/20260918135030.171564-3-pbonzini@redhat.com

> diff --git a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c=
 b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
> index f7228e0f1ac61..ed8edde9b7180 100644
> --- a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
> +++ b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
> @@ -91,6 +91,8 @@ static void test_private_access_memslot_deleted(void)
>  	} else {
>  		TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
>  		TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRI=
VATE);
> +		TEST_ASSERT(vcpu->run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVA=
TE,
> +			    "Memory fault didn't occur on a private memory access");

[Severity: Medium]
Should the existing TEST_ASSERT_EQ(vcpu->run->memory_fault.flags,
KVM_MEMORY_EXIT_FLAG_PRIVATE) in test_private_access_memslot_deleted() be
removed here as well, just like in test_private_access_memslot_not_private(=
)?

With the old equality check left in place, test_private_access_memslot_dele=
ted()
will still fail if KVM sets additional flags such as KVM_MEMORY_EXIT_FLAG_R=
EAD
in vcpu->run->memory_fault.flags.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D7
