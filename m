Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777E2EC09F
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978904; cv=none; b=fuSj9jnsYcjQFnQx9MvAffT/2ANfQnCcf5hsq/GGNzhhO7yIh5kTklGsgPEfnwL0eVbp1/X/Ub7ttFKJDEyz2Jaqe98C5NNJZP0Oc8l32qKa+Y729B9HYfJK4VJMk2Q43/7a/qhqqsoBVP26PXWMTO99SuTqZWEqXmGJp6EN55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978904; c=relaxed/simple;
	bh=TYRYdYBjtzKkSXDceJkYE0PrXL3e3v82rx2L0cRPE2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=csR8N0HDGQ6lRNgWoHk3YaF1lqttLG3Jx/zpB76Na5XA9aEz/wACyRJ1EXtrKkn9Y4VZDWlB6RsQwsYm9Z+Hm43CdTyeRNYUAKvk7xXsRPLRTmgKbd5BqGV+0GoBY6ompqyoEL/bD+yJcEIe384mcKI0onehgY2fJR5gTTMT6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnFqowRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnFqowRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C551F000E9;
	Thu, 28 May 2026 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779978903;
	bh=DcopGG9DqynwYB7PFRh+3UceOijqy9AVIVGU7clCMOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZnFqowRdaX3rpDpKJJmgR8vJVNlN/RQ/QNuwg8OboZkBIURhOxOXc5a+Lpnlj//b6
	 x+/UoXG79ZgKnpQRxz1qWl0bVyTOnsN8N+Ss43zRQDfvrGfMcmOc3kDIzo5/gjpxai
	 5MIYaxSKOeoMELsx4wQWp1l4yuaMFhSF6ljABjZB6yMhimlANyvrzo+9riGSjPcT+w
	 D6nKIZbU03Xfs/sIi3/CESgrh4FadTtFNLnEJv28CacROlGwjSKBo0AvVea1BbWeK8
	 APHx4wFv7NLtjLh+EgBmpAzIsDGsVGTFv3VkQtcpnxNrQGRrIysImpfwd39eZkFkpZ
	 m6MRiX5XPtM3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: selftests: hyperv_tlb_flush: use swap() to swap
 PTEs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Piotr Zarycki" <piotr.zarycki@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528141059.3337431-1-piotr.zarycki@gmail.com>
References: <20260528141059.3337431-1-piotr.zarycki@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 14:35:02 +0000
Message-Id: <20260528143502.D6C551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Adding a generic `swap` macro to `tools/include/linux/kernel.h` cau=
ses macro redefinition conflicts and namespace pollution that break the com=
pilation of other tools (like perf) and selftests.
--

commit 484fb42146bff71557e97872274f2ed19e30162f
Author: Piotr Zarycki <piotr.zarycki@gmail.com>

KVM: selftests: hyperv_tlb_flush: use swap() to swap PTEs
   =20
This commit replaces the open-coded swap in the hyperv_tlb_flush test
with the swap() macro, adding the macro definition to
tools/include/linux/kernel.h.

> diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
> index c8c18d3908a90..381e457960dc6 100644
> --- a/tools/include/linux/kernel.h
> +++ b/tools/include/linux/kernel.h
> @@ -46,6 +46,10 @@
>  #define min_t(type, x, y)	min((type)x, (type)y)
>  #define clamp(val, lo, hi)	min((typeof(val))max(val, lo), hi)
> =20
> +#ifndef swap
> +#define swap(a, b)  do { typeof(a) __tmp =3D (a); (a) =3D (b); (b) =3D _=
_tmp; } while (0)
> +#endif
> +

[Severity: Low]
Does adding this generic macro cause namespace pollution and build failures
in other tools that include <linux/kernel.h>?

For example, in tools/perf/util/session.c, swap is used as a local variable
for a function pointer:

	perf_event__swap_op swap;

The new macro will incorrectly expand function calls like
swap(event, sample_id_all), causing a type mismatch compilation error.

Also, tools/testing/selftests/bpf/xdp_hw_metadata.c defines its own 3-argum=
ent
swap macro. This new definition triggers a -Werror macro redefinition failu=
re.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528141059.3337=
431-1-piotr.zarycki@gmail.com?part=3D1
