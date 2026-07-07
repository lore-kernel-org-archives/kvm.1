Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B391D3E3C50
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437673; cv=none; b=OOuJTPKBDLX89o6pctgIaoizgQEaxP8U9nWOaEzsveRDGs5FtOutbdbnQUuFaVi4m36A9KY+9uyl1G7if5/pQa/ZhhXZrEQrIdZIx4wwnff0nEhqO/9FrtYM3YSLoPvgj84mdpB+daau4Pcec64v6djp5H4DBYwF1LrQXEO/T/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437673; c=relaxed/simple;
	bh=C02/dp95+TiHAuX3MtsufdlSnAMz9uTW2oESIVwombw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NNpUdWFkX2x3ued2szGes13dRrrkTfdtFMqNuSMmpYbqnn8HvdnFyj5Wvz+LkgM1yl09gi/ge6F1MR+lIir0dOkcLMucF67NWd/rtH/Vf3Mv+qjesJNVRHwuzz5aZLTAW2uK0wCr7YT7u6HiQyWHlMXGT4+2VArZEtFxs+E1AOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1wzSJ6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1wzSJ6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE671F000E9;
	Tue,  7 Jul 2026 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783437665;
	bh=PmliN9piG0oQ2yJvPJbA8vmYsnfbj6PiiXRJPM4SWLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1wzSJ6NnxAEKJqUp9RU8H4O3UV8lbxojdjS5899J/4wVRj3M9CSP08JxjTm3quFM
	 HdH+2WV3kNTQ5qtVUm3dvxpN6wQ5kojrmG38dJTAxPzTpT5XHxYPnJ6UO5uIL7ywMQ
	 Y7g/zH2KzyzqpsyE5oqgRyXz0BK5gWvveXu+kzgDTWzoscdhHIuxxWk1qcfVsinQqo
	 RfYyRhUDPb+GBJgtNAtn6Qj3hndHiE6d/RLJi5KXmAvoLhAdzL0nYNDctZhrCzIHR8
	 2I5XElCsnsXCgRB4IeVZ2BnVikktSgxI+mYZwEA53RYAD5hpMTuiUDsRmuNnwnFpq2
	 GnjOd5mn3E7DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] KVM: selftests: Drop superfluous use of
 pthread_attr_setaffinity_np()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707150706.1198541-2-seanjc@google.com>
References: <20260707150706.1198541-1-seanjc@google.com>
 <20260707150706.1198541-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:21:05 +0000
Message-Id: <20260707152105.8FE671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The assertion intended to verify CPU affinity inheritance can si=
lently pass if `pthread_getaffinity_np` fails, because `cpuset` is not clea=
red before the call and its return value is ignored.
--

--- Patch [1]: [PATCH v2 1/2] KVM: selftests: Drop superfluous use of pthre=
ad_attr_setaffinity_np() ---
commit 4058c4b23733ee3e6fc2f4b8ebc85f63f4492c52
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Drop superfluous use of pthread_attr_setaffinity_np()

This commit removes explicit CPU affinity setting for the worker child thre=
ad
in the steal time test, relying on inheritance from the parent thread inste=
ad.
It adds an assertion to verify the affinity was properly inherited. It also
allows the test to build against non-glibc C libraries lacking
pthread_attr_setaffinity_np().

Link: https://man7.org/linux/man-pages/man3/pthread_setaffinity_np.3.html [=
1]
Link: https://man7.org/linux/man-pages/man3/pthread_create.3.html [1]
Closes: https://lore.kernel.org/all/20250829142556.72577-4-aqibaf@amazon.com

> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/sel=
ftests/kvm/steal_time.c
> index 76fcdd1fd3cb4..a244bf9f701f7 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c

[ ... ]

> @@ -558,7 +555,11 @@ int main(int ac, char **av)
> =20
>  		/* Steal time from the VCPU. The steal time thread has the same CPU af=
finity as the VCPUs. */
>  		run_delay =3D get_run_delay();
> -		pthread_create(&thread, &attr, do_steal_time, NULL);
> +		pthread_create(&thread, NULL, do_steal_time, NULL);
> +		pthread_getaffinity_np(thread, sizeof(cpuset), &cpuset);

[Severity: Medium]
Can this assertion spuriously pass if pthread_getaffinity_np() fails?

Because cpuset is not cleared before calling pthread_getaffinity_np() in
main(), and the return value isn't checked, cpuset will retain its previous
value if the call fails. This could happen if the child thread completes
its execution before pthread_getaffinity_np() is called.

Since cpuset was already populated with CPU 0 earlier in main(), the
TEST_ASSERT would read the stale data and pass even if the thread did not
inherit the affinity.

> +		TEST_ASSERT(CPU_COUNT(&cpuset) =3D=3D 1 && CPU_ISSET(0, &cpuset),
> +			    "Worker failed to inherit parent's CPU affinity");
> +
>  		do
>  			sched_yield();
>  		while (get_run_delay() - run_delay < MIN_RUN_DELAY_NS);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707150706.1198=
541-1-seanjc@google.com?part=3D1
