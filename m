Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC21651FCA3
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790306; cv=none; b=YvV/ahWPnckQ6awU4jNaCsiMjNitXwBrxuxQj7b6lPLF4ncKVccYxqXG3JrikEmHBUwoXGF0GsQ+1VW7FS6ID/cDTcqpmCneaUYXS9igN/xY7DD0wzu6FEW0m3NcIYG4OdIVKevHGI6gq2e0UgM6nWmKa9jifUQWocIn0iBX9iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790306; c=relaxed/simple;
	bh=QS5F1n1s9CDwc6oy/33YqVDcDHBHLLzroXk8J+709nk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bmJb6OVt1RoD7S5NRR2xOGq3aaYc0rVxY0qHhpE0hKyqj00OZlzq+PSx6pqUYIHQgrNuzvettEmdNPKYRPAZfwjjwVwpXfbUPP5jmgDGyq/FkxCp1SiixGIWJeevLXF6F57cLgL8pWBrXqiTrrsW82Snr6siN/BpxU/pHfnTY0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0lMekkC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0lMekkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7738F1F00898;
	Wed, 30 Sep 2026 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790790304;
	bh=XkkVWaUc8J9qyS7e3/lX6P/rM5N7jo8HEa6ij+DOMV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l0lMekkCOBAbowlgpdVb1zphQ3NC+xvdKd2BaUpZ9ALbH1xSwaL6edXH/6p+Gg8cP
	 GfiTqp58lRfuWJ0NgDKSlshlqstOPt1MkGFYcBBdKlrn1+JpKHG3g9VD9Zs5l05m+W
	 gODddD6hZA7ytEN+Bbv3Aw2qbYn2ryzOV6qVkytY5qlJr6+fZ7NLRLjvwZJJTt5le2
	 0SPljaRVqmOFeXdHJAWI8eeJ8BpcfDcuYvhkN6fFKe7DnGJgSzpvwaJoRGVUqdFgQ/
	 W3KBieicadeqX5nqYftSyYFhvZXFz9mGwguLM+IBdUpMr7C4dzt7Ha0Nt1x/J/JqR4
	 xL7TZgXuDxN3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/21] KVM: selftests: Rename TSC freq checkers in
 nested TSC scaling test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930173635.3362655-9-seanjc@google.com>
References: <20260930173635.3362655-1-seanjc@google.com>
 <20260930173635.3362655-9-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 17:45:04 +0000
Message-Id: <20260930174504.7738F1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests: guest_check_tsc_freq name contradicts commit message sem=
antics
--

commit 7c759b101cdd9e99d261e6f3022bcb5096eeadfb
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Rename TSC freq checkers in nested TSC scaling test

This commit renames the nested TSC scaling test helpers to clarify guest vs
host usage. It aims to emphasize that the host version performs the actual
assertion check on the result.

> diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/=
tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> index 84312146e93f6..e5fc4c9bb9f9b 100644
> --- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> +++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c

[ ... ]

> @@ -45,7 +45,7 @@ static void compare_tsc_freq(u64 actual, u64 expected)
>  		    actual, thresh_low, thresh_high);
>  }
> =20
> -static void check_tsc_freq(int level)
> +static void guest_check_tsc_freq(int level)

[Severity: Low]
The commit message states the goal is to make it more obvious that the host
version *checks* the result and asserts on errors. However, renaming the
guest helper to guest_check_tsc_freq implies it also performs validation,
whereas it merely measures the frequency and invokes GUEST_CHECK() to pass
the value back to the host for verification.

Would a name like guest_measure_tsc_freq be more semantically accurate
given the commit's stated intent?

>  {
>  	u64 tsc_start, tsc_end, tsc_freq;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930173635.3362=
655-1-seanjc@google.com?part=3D8
