Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AD73BD24A
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000933; cv=none; b=qGwYxXC42Ee+MiRJ/GOa5X4gxhabYev2WU9eCu+uEOAWRCzi8uCNQ+vWCTjoouofgLp6j309X9P8yRt9ayGGWZy3hr8Y67bWPNrAmKyVDGCfXSQ2Orf+7J4VSB1WymnSjlC5oD7dpiaLBjDmtptCKFb3uuuPuKZotLMgey18chE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000933; c=relaxed/simple;
	bh=+tO/i9Xyuou+31ezUwg43wt7nSI4r/oWlUp9qpfAC+Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rKZdYOIagdn3LsWAtIkl34PKYHjvnvxu5V0KgPO75kbNRHOkMsoSz8tcKleivfB7ymYINOWdTXCLPOXQ0aMuXjFYeLDhqIJXvIU03HSV7qyRipBDd9gmf5IyrTtOARK1Z+jCv9brkUzITN4mucAoRSC4ka6bq0ajmbqvAMsDRHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG6C54Ww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG6C54Ww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551C81F00893;
	Mon, 21 Sep 2026 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000931;
	bh=KsMpDeIY0jAeVBjNfXcXGf5WjWL2WS7KSHHX8KmOVQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nG6C54WwJ7c54eJcOM4qq5fKnUkd2D5PNHn2WZjvUl8UeCZ38Id4p0OQgpOW+Sx5N
	 9Drui9ncPcj5voYx51jAJCDIdiVr5/UhwmVOB6VcVCdNNfJipiuiA+HXl3F8oGAg0u
	 9cF4mbhHa2GtJG0Zoiu730gRHGvNVPbwjGsbigHNHQFcmPWuZDYBU2Fhi7mMtesMnC
	 fW0q+M5SySw9/RcTmJ4B8sa+IEVzfzJvEdg91Ai4hnVcDwn0FLYu0k0UvX3F+yGp7N
	 CC62zPGOLDHp87gM3jlJJdoBfUm6O2wFDPS+hMyj0WosMI1mixRYQR2xiGKD/YGr61
	 I/aBfzhXAwTzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] Move struct cpu_feature to <linux/cpufeature.h>
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?= <u.kleine-koenig@baylibre.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <ef103a4b9e1cd7477fa52ee347c4ec301354fba9.1789988540.git.u.kleine-koenig@baylibre.com>
References: <cover.1789988540.git.u.kleine-koenig@baylibre.com>
 <ef103a4b9e1cd7477fa52ee347c4ec301354fba9.1789988540.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:28:50 +0000
Message-Id: <20260921142851.551C81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] build: cross-compilation failure due to unguarded <linux/types.h>
--

commit eeaf7eac97be82ddec1f82f3064dbaed8a04364f
Author: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.c=
om>

Move struct cpu_feature to <linux/cpufeature.h>

This commit moves the definition of struct cpu_feature from
<linux/mod_devicetable.h> to <linux/cpufeature.h>. It also adds explicit
includes of <linux/cpufeature.h> in devicetable-offsets.c and file2alias.c
to satisfy modpost requirements.

> diff --git a/include/linux/cpufeature.h b/include/linux/cpufeature.h
> index 6aff540ee9e57..93c1da38aaf69 100644
> --- a/include/linux/cpufeature.h
> +++ b/include/linux/cpufeature.h
> @@ -6,10 +6,20 @@
>  #ifndef __LINUX_CPUFEATURE_H
>  #define __LINUX_CPUFEATURE_H
> =20
> +#include <linux/types.h>

[Severity: Low]
Does this unguarded include cause a cross-compilation failure?

Because scripts/mod/file2alias.c is compiled using the host compiler (HOSTC=
C),
this unguarded include in include/linux/cpufeature.h causes the host compil=
er
to pull in the host system's <linux/types.h> when compiling file2alias.c.

On non-Linux systems (like macOS or FreeBSD), this header does not exist,
leading to a missing header error. On Linux hosts, it pulls in
/usr/include/linux/types.h, which risks compiler redefinition errors
against the explicit __u16 typedefs in file2alias.c.

Could this be wrapped in an #ifdef __KERNEL__ guard?

[ ... ]

> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 8d36c74dec2d5..88bff32072775 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -121,6 +121,7 @@ typedef struct {
>  /* Big exception to the "don't include kernel headers into userspace, wh=
ich
>   * even potentially has different endianness and word sizes, since
>   * we handle those differences explicitly below */
> +#include "../../include/linux/cpufeature.h"

[Severity: Low]
Does this host-compiled inclusion of the kernel header implicitly pull in
the host's linux/types.h due to the new include in cpufeature.h?

This is the inclusion path in scripts/mod/file2alias.c that triggers the
cross-compilation failure mentioned above.

>  #include "../../include/linux/mod_devicetable.h"
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789988540.gi=
t.u.kleine-koenig@baylibre.com?part=3D1
