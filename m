Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601734DCF3
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 22:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789080512; cv=none; b=WJ9xkAjw5qCk3BYnHf07EDAsy6/uJjJxfMTXrdEk8fdOW+egoqX8soOgvhWhxqN0pCVU3b5K8RN4LUR/TP9b9VIcbu5jlt4nGO2yQ/NB9b5nIdftC9Oc0wqiJcxHDQ5RSvhz/ZUPMpYtpCwJfe+g5RN90Lw/kReOSCLORCYxXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789080512; c=relaxed/simple;
	bh=6hkXp5hO9sziOXJQFcViS52eFz6fvyE5tKQ9PkSWRNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EBcvjx1o7r0goh2H3gGA20djgl9jLIkzBcZByWvQ4Ed4mMRRsuQtmzzXIVJNwSd6Pcoqud4mNvoucjp7nMYpj76e5fS0J2HxNO4Up5SgI3FHmFfS1Z8wA8UcnvSlzcwoP3m/H5ui3XP6Br8mkHjn2dE9s11Ck2CmZlL0buOcNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV+jyuB4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV+jyuB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F191F000FF;
	Thu, 10 Sep 2026 22:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789080510;
	bh=dbdRguJ7qhi2DFl/ywpiLA5RqNgDidgyxRLHWLMj4cU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EV+jyuB4+OpBetBKVeRskggjVDaTxjTQkgycwRS+2no+51ohEBfNS9mUVkEHL3pZB
	 o3obg8vJI7GdlGn5AyskB805EfxkRTomVDJpJqFk9jJoAjiI9XhFmtQsxg7vpKOxY6
	 Z5LUAZpygf0LFx0jPT3N8G0YbswyEO8hkXv2GDdFIsDhZjV0gU+KAugE994VBmRn2S
	 DKywCavVU1u78aTu+SjiRvFfaSWmcTPt5Pon3scD8mVJOuSquZwdQg78pfJRJl3jnL
	 RqwBm/vwmipnxTim2tHDh14wKopPdrdgTxqAMm29FfnRW/7z0fR06TGsFnOImzQ3/o
	 sKoHHcFi2lReA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] x86/early_printk: Avoid #VE emulation for TDX guest
 serial output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vishal Verma" <vishal.l.verma@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260910-b4-tdx_earlyprintk_tdcalls-v1-2-4b2b1bf9001b@intel.com>
References: <20260910-b4-tdx_earlyprintk_tdcalls-v1-0-4b2b1bf9001b@intel.com>
 <20260910-b4-tdx_earlyprintk_tdcalls-v1-2-4b2b1bf9001b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 22:48:29 +0000
Message-Id: <20260910224829.C1F191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Calling `static_call_update()` during early boot triggers a `WAR=
N_ON_ONCE` because the static call infrastructure is not yet initialized.
--

commit c9714557d1c8172a79380db2922407c7981caa1d
Author: Vishal Verma <vishal.l.verma@intel.com>
x86/early_printk: Avoid #VE emulation for TDX guest serial output

This commit avoids using #VE emulation for TDX guest serial output by
substituting the default earlyprintk port accessors with TDVMCALL hypercall=
s.
It achieves this by updating the serial_in and serial_out static calls to
use TDX-specific handlers during early boot.

> diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_print=
k.c
> index cba75306e5b62..4a70799cd80ae 100644
> --- a/arch/x86/kernel/early_printk.c
> +++ b/arch/x86/kernel/early_printk.c

[ ... ]

> @@ -111,6 +113,48 @@ ANNOTATE_NOENDBR_SYM(io_serial_out);
>  DEFINE_STATIC_CALL(serial_in, io_serial_in);
>  DEFINE_STATIC_CALL(serial_out, io_serial_out);
> =20
> +#ifdef CONFIG_INTEL_TDX_GUEST

[ ... ]

> +/* Substitute the hypercall accessors, but only in an actual TDX guest */
> +static __init void early_serial_tdx_init(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +		return;
> +
> +	static_call_update(serial_in, tdx_serial_in);
> +	static_call_update(serial_out, tdx_serial_out);

[Severity: Medium]
Will calling static_call_update() here trigger a WARN_ON_ONCE during early =
boot?

Booting a TDX guest with earlyprintk invokes parse_early_param(), which ends
up calling early_serial_tdx_init() before the static call infrastructure is
fully set up. Because static_call_init() is an early_initcall that runs much
later in the boot sequence, static_call_initialized is still 0 at this poin=
t.

This unconditionally triggers the WARN_ON_ONCE(!static_call_initialized)
safety check in __static_call_update(), which dumps a stack trace to the
boot log and will crash the boot process if panic_on_warn is set.

Should this use the x86-specific static_call_update_early() macro instead,
which checks the initialization state and safely patches the trampoline
directly during early boot?

> +}
> +#else
> +static inline void early_serial_tdx_init(void) { }
> +#endif /* CONFIG_INTEL_TDX_GUEST */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-b4-tdx_ear=
lyprintk_tdcalls-v1-0-4b2b1bf9001b@intel.com?part=3D2
