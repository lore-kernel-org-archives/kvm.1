Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA4720A5C4
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482118; cv=none; b=W2OIqTSbCMRdXjsCH8eF5q53KFwH1ClUeru+wdozcXciO+Zp8Rct38VhsOcybUI8XEcoScXZ0NqV8Bwdzz9eOwv+FIFNlas3C1bRzTUI1BK5IN6hNarlsQ3naq3YNA/6Uz9JktIlL5GkS/TASijhQW8apnYqWdnLzc8tkZ5ezRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482118; c=relaxed/simple;
	bh=j/XCoI1tnHtYY3Fbrtb5bhWIC3wl92K3Rib+VBjRIUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rLpacEFcZKNY7bO3XaxXPKBfriv+Bf7gjOtpDz7e7hMEpu9Kb6IEpAoRukb7JJKdiRRIdPzTVYmqSvFQBs6wtBTJcw0k3CLnHX1quy9NCY/ImxvC4lq/REmnIqvvxF5SwzhQeO1A2UgBcT6ff/rlBBhytE3fRnyzXfWyzHsnN80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi/Jaly2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi/Jaly2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E329C1F000E9;
	Fri,  4 Sep 2026 00:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788482117;
	bh=H5duUbq4c8dPme7cqVf8AWz3rr+sEVM3gYYZ3WafvI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qi/Jaly2543bkxN+WmJ1h7cG4+kWXi30FvnqwhQthXgEjK5SUoEOPFiX4uiwHW9mU
	 krqMO063YBDBv9TzdF1dHXRhfXAdmvEIOBi4UB4AScG5K1PjJ4merrxwGrZgfU46Iu
	 NBF2Jh1a5x6E/5yJBpmwX4//hj7Xo7k7VxKcIE4xtH605Y1Ziudseiu2IhiYhLSOiK
	 GNKrrAe/PRnnKgfZCxz7leMYKGBgJITh4DeczZjhRhm3vV9AxU8FrojRxh9fH0pDxp
	 7e9cwopLGNy69tYGZ3SNXh0kTfMn12vbW3MHG+HaEjhFo2sraHxnf+y30jAidYZKIa
	 l2YstzgHWTLNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/17] KVM: selftests: Assert success in vmlaunch()
 and vmresume()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260904002423.3154436-15-seanjc@google.com>
References: <20260904002423.3154436-1-seanjc@google.com>
 <20260904002423.3154436-15-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 00:35:16 +0000
Message-Id: <20260904003516.E329C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The vmlaunch() and vmresume() wrappers are defined as static inl=
ine functions instead of macros. Because __GUEST_ASSERT captures __FILE__ a=
nd __LINE__ at the point of its invocation, assertion failures in these wra=
ppers will report the file and line number inside vmx.h rather than the act=
ual caller's location in the test file.
--

commit 00cde4aa7e9af50759c8cee7b3f7fecea0caf3ed
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Assert success in vmlaunch() and vmresume()

This patch updates the outer vmlaunch and vmresume selftests APIs to assert
success directly, deduplicating error checking across tests. Tests expecting
VM-Enter failures now explicitly use the double-underscore versions.

> diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testin=
g/selftests/kvm/include/x86/vmx.h
> index d0ac8e128d985..1419043b41dd3 100644
> --- a/tools/testing/selftests/kvm/include/x86/vmx.h
> +++ b/tools/testing/selftests/kvm/include/x86/vmx.h
> @@ -362,14 +362,14 @@ static inline u64 vmptrst(void)
>  int __vmlaunch(void);
>  int __vmresume(void);
> =20
> -static inline int vmlaunch(void)
> +static inline void vmlaunch(void)
>  {
> -	return __vmlaunch();
> +	__GUEST_ASSERT(!__vmlaunch(), "vmlaunch hit VM-Fail");
>  }

[Severity: Medium]
Because __GUEST_ASSERT captures the __FILE__ and __LINE__ macros at the poi=
nt
of its invocation, placing it inside a static inline function will cause
assertion failures to always report the location inside vmx.h instead of the
actual caller's location in the test file (for example, inside state_test.c
or nested_emulation_test.c).

Does this cause a loss of debugging context when a VM-Fail assertion trigge=
rs
in tests with multiple vmlaunch invocations? Could vmlaunch be defined as a
macro instead to preserve the caller's location?

> =20
> -static inline int vmresume(void)
> +static inline void vmresume(void)
>  {
> -	return __vmresume();
> +	__GUEST_ASSERT(!__vmresume(), "vmresume hit VM-Fail");
>  }

[Severity: Medium]
Similarly for vmresume, using __GUEST_ASSERT in an inline function will mask
the file and line number of the actual test invocation. Would a macro be mo=
re
appropriate here as well to retain the debugging context?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904002423.3154=
436-1-seanjc@google.com?part=3D14
