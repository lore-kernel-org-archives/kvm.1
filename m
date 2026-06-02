Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE80396B9A
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426945; cv=none; b=rhR8evXjczJX1T9ZuaIkMv4ux+k6UEotrEjCfVSbmmvIQNU4vOmkb0aQw1gVmYggloVIJ9C6obtPmRm6Nj4YxgMtG9SVjQLertYkEZg0BHH76us08HEv7sI7xe4dTBlMM5GHhXkVE9DMMRM8yOcR6ZWfb6IDtNi3Mox+yvMAYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426945; c=relaxed/simple;
	bh=tlfB0mR+Px1st9nUwZvidlhw5J/D+T7HWt1/6sVvX+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cWx1SyXw07ciWvu83OKjNm7J2x8uACFeRXa2e+2l2/lPRXRNJL/k8q75sbFWPnhTAyClep9gzjRNKuapr2ZRRf0B+yHXYGos6iUBlE7ae6DaNoFq2uOXYorI1Z3rS/PRnM4Z5dy0EzBpsXOTwNRoYJmqE2IBPS7KsUWp5NSRvJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAShIoch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAShIoch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9296E1F00893;
	Tue,  2 Jun 2026 19:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780426943;
	bh=HsKyw4Q1QQ9GwyB6I0y2nodc8sYaNrBtr6woEBw9IiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eAShIochZEvc3JcXKwKIbiYMrQYpfua0y1Mms1kpD7GMbnR4ghav87o3KYMpfV4nO
	 OHLf33i+SHthSNQtMOSqfWiHrjWwVcV2gzQYZhLWf6w59aIJUjvM2hU+zX0nzpw9aP
	 nKPYMgFIXPc6gKio9044Iw4nceZPZmoYRAx5+MRlgrSynv1pXG8YbWVkkhC4tZH0eg
	 +I1OLwhisBIBTndNq0DABwxcAC7udAyJR5uOjl0KpefdXFQ7URqcZM8rWp5Av8ZHwT
	 wFggxc56cqMhYeReed7iO+DTq4m8tCJMU8JVeZ1KQRWTbkDIDCp/EpZIPye/oGFYGQ
	 F5Nh9eLtV154g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] vfio: selftests: Find devices that have VFIO
 selftest drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602185615.3025904-1-jrhilke@google.com>
References: <20260602185615.3025904-1-jrhilke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 19:02:22 +0000
Message-Id: <20260602190223.9296E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Documentation and implementation mismatch regarding script name,=
 output format, and usage instructions.
- [Low] Unused local variable `bdf`.
--

commit dac67adaa35d0b3beddd4d11badc85a43ad7c2e3
Author: Josh Hilke <jrhilke@google.com>

vfio: selftests: Find devices that have VFIO selftest drivers

This commit adds a new script to print the SBDF numbers and names of devices
that have a VFIO selftest driver. It also includes a quiet mode to print on=
ly
the SBDFs.

>     Add a new script, list_devices.sh, which prints out the
>     segment:bus:device.function (SBDF) numbers and names of devices on a
>     machine that have a VFIO selftest driver. This makes it easier to
>     determine if the system is capable of running VFIO selftests.
>    =20
>     Includes a -q (quiet) argument which prints just the SBDFs so that the
>     output can be piped into tools/testing/selftests/vfio/script/setup.sh=
 to
>     bind the devices to VFIO to use in VFIO selftests.

[Severity: Medium]
Are these instructions accurate for how the scripts are meant to be used?

The script is named list_supported_devices.sh in the patch, rather than
list_devices.sh.

Additionally, the commit message states the output can be piped directly in=
to
script/setup.sh (which is missing an 's' for scripts/), but setup.sh requir=
es
arguments to be passed on the command line rather than through standard
input. Piping directly might result in a usage error.

>     Examples:
>    =20
>     $ ./list_devices.sh
>     0000:6a:01.0 - Intel SPR DSA (8086:0b25)

[Severity: Medium]
The output format in the example shows "Intel SPR DSA (8086:0b25)", but
the script below generates "Intel DSA SPR [8086:0b25]". Could the commit
message be updated to match the implementation?

> diff --git a/tools/testing/selftests/vfio/scripts/list_supported_devices.=
sh b/tools/testing/selftests/vfio/scripts/list_supported_devices.sh
> new file mode 100755
> index 0000000000000..a123a965d3586
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/scripts/list_supported_devices.sh
> @@ -0,0 +1,44 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-later

[ ... ]

> +function main() {
> +	local id_name
> +	local quiet=3D""
> +	local name
> +	local bdfs
> +	local bdf

[Severity: Low]
Is this bdf variable used anywhere in the script? It appears to be declared
but never assigned or read.

> +	local id

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602185615.3025=
904-1-jrhilke@google.com?part=3D1
