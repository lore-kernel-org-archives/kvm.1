Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345C44AB68
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241631; cv=none; b=p3wKinB2KOtptBETunn1ZEOZ4dZ682wq3w/OIq9LaINJNsWu9AaWoKz7butUnXHPTD0zilr4QJFnArxWZkZGqMrf6iaaEV+jmtukpK0X1biOunWEZtTzrjCtp5LHa/8eGxTuzNSllya9inXjJgFE4yl3eIzSdFwrVfwoiY/rsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241631; c=relaxed/simple;
	bh=cfRMlOv8JFFLdVLLK61hrtUrQ+ikrh8ZGtrQfNspB9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LjAFQ+CM2MttjVUVcMtd+BlewBtL5Cb2kW7Ndl4Yt6C9QblPOALSjHe+zVpg0KyN/+5P+b+Xto+/yFRvcRo/y8Vpa1alqrQQ8EdLY3Z3ZnkMW9VjML7gwbHOTb2SLfCW/N1hfYvvNR3vJ2+AG16DJbXzXssuHflzD+Bn7q7kwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fymA1l/F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fymA1l/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D11F1F000FF;
	Mon,  5 Oct 2026 23:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791241625;
	bh=RanhztWEzoiB9isRpsJdoYDyKiTEVZc2ffIIXeEJLt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fymA1l/F8lmTwyg0oUeKbabQbW4cA0U/bKgrgIs/BPkL/addCmPO9sIefWx4o28va
	 GVOmRc4YDbWYFfNuksu0eZX4zSHXOYZ+zcmuwRdmytpj0H7YV3LwtwlegTfqG+n4xp
	 lsR4Ef9FW4xt2ZZ3QeMy4c3Gs6xM4ItkqeGy325KBauU5Fax4e4k7GOLz30Km7tbf1
	 pDgExEAltT804HTOjbtsif8NXd3tb2SLKKvLVWV4Yfz3vus7Bs90j/OmGv4Sir+/9x
	 WMFhQ7aUEw6tPtUH09wL9q6fIr77JS/YiEqAeaxM5aO0oC0XYIeqS12j/dyQNDuYFN
	 5X9bhaTyheKpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] x86/early_printk: Add earlyprintk=tdx to drive
 the UART with TDVMCALLs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vishal Verma" <vishal.l.verma@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261005-b4-tdx_earlyprintk_tdcalls-v4-2-3f7c56dd568a@intel.com>
References: <20261005-b4-tdx_earlyprintk_tdcalls-v4-0-3f7c56dd568a@intel.com>
 <20261005-b4-tdx_earlyprintk_tdcalls-v4-2-3f7c56dd568a@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 23:07:05 +0000
Message-Id: <20261005230705.8D11F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] earlyprintk: missing 'tdx' option in decompression stub parser c=
auses silent loss of early logs
--

commit bd0f2326d287e01b5e4cf6ddb08a23b05a98652a
Author: Vishal Verma <vishal.l.verma@intel.com>

x86/early_printk: Add earlyprintk=3Dtdx to drive the UART with TDVMCALLs

This commit adds an earlyprintk=3Dtdx option to drive the UART with TDVMCAL=
Ls
in a TDX guest. This avoids the #VE exception that would normally be requir=
ed
to emulate port I/O.

> diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_print=
k.c
> --- a/arch/x86/kernel/early_printk.c
> +++ b/arch/x86/kernel/early_printk.c

[ ... ]

> @@ -414,6 +429,11 @@ static int __init setup_early_printk(char *buf)
>  			early_serial_init(buf + 4);
>  			early_console_register(&early_serial_console, keep);
>  		}
> +		if (!strncmp(buf, "tdx", 3)) {
> +			early_serial_tdx_init();
> +			early_console_register(&early_serial_console, keep);
> +			break;
> +		}

[Severity: Medium]
Does adding this option here also require an update to the decompression
stub's parser in arch/x86/boot/early_serial_console.c?

The decompression stub uses its own parse_earlyprintk() function to
initialize the UART base address, but it only matches serial, ttyS, and
pciserial. Because it doesn't recognize tdx, early_serial_base remains 0,
and console_init() skips setting up the serial console during
decompression.

Ironically, the older earlyprintk=3Dserial safely avoids #VE in the
decompression stub because early_tdx_detect() overrides pio_ops.f_outb to
use TDVMCALLs. Users migrating to earlyprintk=3Dtdx might unknowingly lose
decompression output.

Should parse_earlyprintk() in the boot code be updated to recognize tdx
as well to avoid losing early logs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-b4-tdx_ear=
lyprintk_tdcalls-v4-0-3f7c56dd568a@intel.com?part=3D2
