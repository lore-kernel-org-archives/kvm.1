Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33714405F7
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994379; cv=none; b=uB+DcyeR84aWVgcK1+stk5qwJKscrQvsuCMORDAhhsx3SmMAaXynQkaIdGJ3vlPe6FXG7tTRjj6Fg+ogpp1hq0eW+0TSFxoqenVryBuGlC6u4VLlFTvheFELWQO/pYfi+7aFacVGhP9eVBQ597AQsNlMxcTh0Oua0slPf0QAzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994379; c=relaxed/simple;
	bh=BNkUYJ5hjpLhtDwcHTBjw4CbDKWHUDOuVDc59ztoDpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z41AzMUbi7O2TjGHUeI3EssUoHbvXSjUOa1pLZJXlri5EpTGaXD2secMjJWWpd8mG15rXQruSxnvWqU5SausRaqK+4mh8gstNm6LURqyqQbnS920enFO3si4w8JoIUhFY4/+1IS6qNjzwzQD/kBGItI8jccIVmwDTexg4m/VteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFza0XXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFza0XXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6103B1F000FF;
	Mon, 21 Sep 2026 12:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789994377;
	bh=BNkUYJ5hjpLhtDwcHTBjw4CbDKWHUDOuVDc59ztoDpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WFza0XXNS/sZjWeJrsfqVRoz3rIK6YgCM6agIKIIAYaPnNagdSE5ezInMsr/IiFox
	 joMk+iUfGNsKwoNFTggwrXMYial3LNvkZkVhv//3HI3h6Ag6adqaif+laiNKrEgAXq
	 nBWfv3p/F5+kxbqcFKrJIgHcASY9h4xEjqTYwoamKF8GpipdP0aQL23hssCk2Bl5BZ
	 aoKyv8zyFhsEmplLvgTbm33SFc2zzQWMuHeVPOYxuz7UFETyRkCY+T4ogr6kY5+M2z
	 NpOKpx3arumAcHgFhzxsOisXIT/bNNmw3nVbLlOoAjaqrWPWHP6JrKXv3Xn5p3VAzc
	 GRYjL6qwrHIxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 3/4] RISC-V: paravirt: pvqspinlock: Add trace
 point for pv_kick/wait
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R1VPIFJlbiAoWHVhblRpZSk=?= <guoren@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260921-pvqspinlock-v4-3-409a22aed6ef@kernel.org>
References: <20260921-pvqspinlock-v4-0-409a22aed6ef@kernel.org>
 <20260921-pvqspinlock-v4-3-409a22aed6ef@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 12:39:36 +0000
Message-Id: <20260921123937.6103B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] trace: incorrect TRACE_INCLUDE_PATH depth causes brittle include re=
solution
--

commit 2603329e3e16137c739dbffd2974c6bd447b6ee2
Author: GUO Ren (XuanTie) <guoren@kernel.org>

RISC-V: paravirt: pvqspinlock: Add trace point for pv_kick/wait

This commit adds tracepoints for paravirt qspinlock operations pv_kick and
pv_wait. These tracepoints allow observation of paravirt qspinlock behavior
via the paravirt trace event system.

> diff --git a/arch/riscv/kernel/trace_events_filter_paravirt.h b/arch/risc=
v/kernel/trace_events_filter_paravirt.h
> new file mode 100644
> index 0000000000000..8d57efda2c177
> --- /dev/null
> +++ b/arch/riscv/kernel/trace_events_filter_paravirt.h

[ ... ]

> +#endif /* _TRACE_PARAVIRT_H || TRACE_HEADER_MULTI_READ */
> +
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_PATH ../../../arch/riscv/kernel/

[Severity: Low]
Is this TRACE_INCLUDE_PATH definition too deep?

The three levels of parent directories (../../../) navigate outside the
kernel source tree relative to include/trace/define_trace.h. This currently
builds because the compiler falls back to searching the
-I$(srctree)/arch/riscv/include path, where the three directory levels happ=
en
to perfectly cancel out the depth of the fallback path.

Could the include path be corrected to avoid compilation failures if the
include paths change or if built with compilers that evaluate fallbacks
differently?

> +#define TRACE_INCLUDE_FILE trace_events_filter_paravirt
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-pvqspinloc=
k-v4-0-409a22aed6ef@kernel.org?part=3D3
