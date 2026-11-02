Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660385;
	b=HGCUqvp2BDwVpb/ltIX3UbTUGwTWRgWo7lfyh4wRHskz4foMGB/lpFOSJC5DFe/VQtVN
	 YlUOaxTw9ot5nc8ah3+amN2kpxWXHrQxXwfYMw2StLuqZratSU2sa2yh7tierCbuIsXLH
	 TVadDBqt/3bXkoJv3o1QvQEnnx+h49xbIvtKlCZehOvXQ5/DG6vbifzcFp05L4eLgvHnM
	 DQMk3cFXOFeQ+PEPJt56X5FCHcDGY8mhdsZj4Mz7p1JBdwpAHS+zy+6IEANaTMBopUvQq
	 Q1Jj58scdqY6kPWGJY0C4HblTqDvpgLDdfNnmysPYO16xYdwPqTjwpHV0QlMGbnLDYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660385;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iLt7gomhobRST6pL39GjSAuCVOmL6c4Z4dyrsMX+wyw=;
	b=5SkacQJETKnPuKpmK2DV768QoveNYtbMySteyHk1YG2uYBvHsdWTKuNIEezCpZaYCVvS
	 lgVa+V0i9Za4QZu0Sq/x8lw5SPkzDyTep2YfouGygHLIp2rOZEBJG/CSJgs75/kbSOrg4
	 Lks4SKYMGyNvbVWBO2kyUGvBj8FjykB1setR4IQsATFGVmB5DUfBOXglAPH4GoDul1sC2
	 wYgHNz1cgl65Ajm4ronNRerQubjuLzHWwId13TFR4zV81s39M/T5ef24RLVF0iW+DKi/k
	 jEJ2S6HSWStFheARV/tCIRJsBdIsC1SkKWcKQxWDipb7BEsQgpnha4xl9tMiEByE9kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9mjW3sx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEECE606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9mjW3sx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C9C1F00A16;
	Mon,  2 Nov 2026 22:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793660384;
	bh=iLt7gomhobRST6pL39GjSAuCVOmL6c4Z4dyrsMX+wyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g9mjW3sxtRL7Amp8152SS3ndVHhchTOEQfiDgmUefvnY9jYJtabCb2MZ6F4+//DSy
	 Yzlecy9fDizpVzegIV6mqL2wkcW/8IZgduuBQOgZnCDNv3GCHoh9Py9VgEGwV+gSUM
	 v6QZo4HpIhYQSsJhdaO5rH4qRYYsQxGYOCkd8SpTl/AVvtp6gWSEHOBRvTlSf9BUVe
	 jJVT5+Z/nMjKkV/dC7pM8NsTRkIKr8/j8+dfS5JusF7DLEjeYby3ITCXAHV+T3z/SN
	 5I1rCVSPW6eR3CAESLD6ISdNmRJ70ia9jVLrKk9DGStqJo7f3PXiJ+BJh37vxi6R6v
	 WAvpn2y6NBWqA==
Message-ID: <sashiko-outbox-194310@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] x86/early_printk: Add earlyprintk=tdx to drive
 the UART with TDVMCALLs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vishal Verma" <vishal.l.verma@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261102-b4-tdx_earlyprintk_tdcalls-v5-2-b01bc95d44ff@intel.com>
References: <20261102-b4-tdx_earlyprintk_tdcalls-v5-0-b01bc95d44ff@intel.com>
 <20261102-b4-tdx_earlyprintk_tdcalls-v5-2-b01bc95d44ff@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 22:59:44 +0000
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
- [Medium] x86/boot: missing earlyprintk=3Dtdx support in parse_earlyprintk=
()
--

commit f1945c05c983a94ab54fe2daf5b1ddd281e8d948
Author: Vishal Verma <vishal.l.verma@intel.com>

x86/early_printk: Add earlyprintk=3Dtdx to drive the UART with TDVMCALLs

This patch adds an earlyprintk=3Dtdx option along with tdx_serial_in() and
tdx_serial_out() accessors so that a TDX guest can drive the early serial
console directly with TDVMCALLs rather than triggering #VE exceptions on
port I/O instructions.

> diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_print=
k.c
> index cba75306e5b62..04dadcd73b857 100644
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
As reported by Sashiko on v4 [1], when booting with earlyprintk=3Dtdx, this
adds support in setup_early_printk(), but parse_earlyprintk() in the boot
and decompression code only checks for "serial" and "ttyS":

arch/x86/boot/early_serial_console.c:parse_earlyprintk() {
	if (cmdline_find_option("earlyprintk", arg, sizeof(arg)) > 0) {
		char *e;

		if (!strncmp(arg, "serial", 6)) {
			port =3D DEFAULT_SERIAL_PORT;
			pos +=3D 6;
		}
		...
	}

	if (port)
		early_serial_init(port, baud);
}

In extract_kernel() -> console_init() -> early_serial_console_init() ->
parse_earlyprintk(), early_tdx_detect() has already wired up the port I/O
operations to use TDVMCALLs in a TDX guest. However, because
parse_earlyprintk() does not recognize "tdx", port remains 0 and
early_serial_init() is skipped, leaving early_serial_base unset during
kernel decompression.

Should parse_earlyprintk() in arch/x86/boot/early_serial_console.c also
handle "tdx" so that decompressor serial console output is not lost when
switching from earlyprintk=3Dserial to earlyprintk=3Dtdx?

[1] https://lore.kernel.org/r/20261005-b4-tdx_earlyprintk_tdcalls-v4-2-3f7c=
56dd568a@intel.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-b4-tdx_ear=
lyprintk_tdcalls-v5-0-b01bc95d44ff@intel.com?part=3D2
