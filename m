Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9875B3DD851
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773123; cv=none; b=u1lHWeDmxYdHWuKgQHRWN5WmXyc7Xq+g9ryWT1URS3vK4BeX1GVRNFT/mWr4ApS1adwGoR0NyIn4uRi0qGpAq5yPjb5NebvVRVnvE+TSmzUjhXqQ9/4G+9Vw93n8aftlJLSJQzissP26hbSaeLUFa71zY17wH04TtX/vLxQgAxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773123; c=relaxed/simple;
	bh=tqcIEmUo1WmgzrFqwhzN7Q3ZtZ3AslAB6vLkkgJnj2w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r+cULW4Sx55IVkaOwMSpeGBQNOTAfcwj1zr/e5dmrLz/j8BqQ89/tpLY1X9VNY+UrpRcX5wgP7shq+NKwTBvZ0fijCu3AMIITgvqoILa+R/c2vMOsZ4Q6+woAN5rNL7DZklNjsLS08ceaT8x+VAyAqK4gFLjQUDofDfwCD5ExdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZJ/i0PL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZJ/i0PL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A041F000E9;
	Thu, 18 Jun 2026 08:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781773115;
	bh=e0wu3UTiP7/Wx8OwldhHjGUyC5U+a+ocQwIcRfGTX8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GZJ/i0PLbEFel7GtGeVGCJ83dlUCzn6lcTUTiLchoantWMyDy1tLxB55mrvAhe4Jw
	 iFWL2qQMUuQrhPvyf/1du9ig/bcn6HE9VJnStK8EEX/k8+1LZcdh8+XaQCfg0iMJBw
	 pPpSnvppIkVz4JffUMQE2XOtujJeD80rK1tZuC0ONcn05PnkMZ1zuamB0q1RxeGgUX
	 kExhtL2Bunam+ag5f+Wymt4ZwX9Vxppw9ow24XO6YFDbdwV02aIXVhAXO8+9g9PU1v
	 dajvy0iy7OQ1tLTbyt6s5BopPCLeh+MAKxLeb5MHZdxD0ucHCL+UJF5k+aHOx3Q3Pk
	 ttYsnSHWviSWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/17] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yilun" <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618081355.3253581-7-yilun.xu@linux.intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-7-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 08:58:35 +0000
Message-Id: <20260618085835.98A041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Infinite loop in `tdx_ext_init()` when an external interrupt b=
ecomes pending during `stop_machine_cpuslocked()`.

Pre-existing issues:
- [High] Infinite loop in `tdx_sys_disable()` when an external interrupt be=
comes pending during a kernel panic or crash.
--

commit 03507e2a23bf57aa355b6cf99d6b8107f41ea488
Author: Xu Yilun <yilun.xu@linux.intel.com>

x86/virt/tdx: Re-initialize the extensions on runtime TDX module update

Runtime TDX module update introduces a mechanism to update the module
firmware while preserving and restoring TDX operations. As part of the
restoration process, the post-update initialization detects if extensions
are supported, rejects updates requiring additional memory, and
initializes the extensions via TDH.EXT.INIT.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 900928de373ae..4d2940f4538a2 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c

[ ... ]

> @@ -1308,6 +1308,31 @@ static __init int init_tdx_module_extensions(void)
>  	return tdx_ext_init();
>  }
> =20
> +/*
> + * Mostly the same flow as init_tdx_module_extensions(), but rejects add=
ing
> + * more memory.
> + */
> +static int update_tdx_module_extensions(void)
> +{
> +	struct tdx_sys_info_ext sysinfo_ext;
> +	int ret;
> +
> +	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> +		return 0;
> +
> +	ret =3D get_tdx_sys_info_ext(&sysinfo_ext);
> +	if (ret)
> +		return ret;
> +
> +	if (!sysinfo_ext.ext_required)
> +		return 0;
> +
> +	if (sysinfo_ext.memory_pool_required_pages)
> +		return -EFAULT;
> +
> +	return tdx_ext_init();

[Severity: Critical]
Could this result in an infinite loop during a runtime update?

The tdx_module_run_update() function runs under stop_machine(), meaning
local interrupts are explicitly disabled. When this calls tdx_ext_init(),=20
it executes the following polling loop:

    do {
        r =3D seamcall(TDH_EXT_INIT, &args);
    } while (r =3D=3D TDX_INTERRUPTED_RESUMABLE);

If an external hardware interrupt becomes pending during the update, the TDX
module exits to the host and returns TDX_INTERRUPTED_RESUMABLE. Because the
host CPU has interrupts disabled, it cannot service the interrupt and simply
continues execution.

Does this mean the loop condition evaluates to true, immediately re-executi=
ng
the seamcall, and permanently deadlocking the system?

> +}
> +
>  static __init int init_tdx_module(void)
>  {

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while looking at how
TDX_INTERRUPTED_RESUMABLE is handled, I noticed a similar pattern in
tdx_sys_disable():

    do {
        ret =3D seamcall(TDH_SYS_DISABLE, &args);
    } while (ret =3D=3D TDX_INTERRUPTED_RESUMABLE || ret =3D=3D TDX_SYS_BUS=
Y);

During a kernel panic or crash, machine_crash_shutdown() executes with local
interrupts disabled. If an external interrupt becomes pending, the TDX modu=
le
exits with TDX_INTERRUPTED_RESUMABLE.

With host interrupts permanently disabled in the panic context, will this
loop endlessly and prevent the crash dump or kexec process from completing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618081355.3253=
581-1-yilun.xu@linux.intel.com?part=3D6
