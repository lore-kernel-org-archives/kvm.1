Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FA8224B05
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 02:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849658; cv=none; b=tUl7IxuCf1lFPiCrBOT6M4cjdsGL+XSISBCL00Y4fm0vVtCRsCSgzudNdqAHBQE9ujMOcrZV9kxMz3glEE1p5x31I+SKDf9iYjlBF6uEH6i4uzxMOvaGYQRUg5JtgYgdV09Z2IcsIV/blmenDUVc/qLmgvVPHvod8Rc4SnqGqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849658; c=relaxed/simple;
	bh=JDN8H7+QusmJKhDSObJAHa+aJXXXjy111PTT2ztgp1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cejyxv2jve6UUG2xd5hOGzxOTJ4b/RhoEoNbGjeqtEHZBZ0MNG+Gd38Yxd61fZgnimjCmEOAn754C0NurWsoV+Kee/Y3nltHPLW92JUi4SlAe73/26lyyW2FyX1x0AqIdJh+h+hDLZRAxYDF/ICEk/egQ2t3wUPkrwz9T8Em9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBeIjb+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBeIjb+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290821F000E9;
	Wed, 27 May 2026 02:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779849657;
	bh=TYLmXzMogZNkjPXiIqPFQmRqtzI6V4jnls0Qzzt31SM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HBeIjb+cMc1jQVNt5awDa2p7HtuBXB0zSMGDj4P70VHQPqDKoLvRSWkedE4xc3V7h
	 Hr8aIWfp3kysPyUkA0lQyUFtle8GAaY76xPGUF9WhqHMa6LKf6TkGX+EHLc6Y4jzPs
	 GbuWDsn5dzKwACuR2dCJikv17N0ExZZpUecxIT6iLvkzZd2XvjNwMjG2xnP1lvs2IT
	 dVXTDokCDYimNYk7OEWtYRrZYvBntm8tHDw5TgG0IoGfL/EI0UhTRmWzPBP9L+yC4+
	 2yqo0WqRhHwYLnHmFemSZzTImWMHEJC0qAIAyJo/b5Xdu9QT/3lzUGTwvi1wy3PFL/
	 9MliH78vCZsMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] selftests/vfio: igb: Use offical IGB headers
 in selftest driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526235417.2058313-11-jrhilke@google.com>
References: <20260526235417.2058313-11-jrhilke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 02:40:56 +0000
Message-Id: <20260527024057.290821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Unused macros IGB_ETH_OVERHEAD_SZ and IGB_JUMBO_FRAME_SIZE were int=
roduced.
- [Low] Including `e1000_82575.h` without forward declaring `struct e1000_h=
w` may cause compiler warnings.
- [Low] The patch uses E1000_EICR_RX_QUEUE0 (a legacy Rx cause mask) to rep=
resent an MSI-X vector bit in interrupt mask/clear registers.
--

commit bff1218f00385f0c7ad23675f49b73f63118bf25
Author: Josh Hilke <jrhilke@google.com>

selftests/vfio: igb: Use offical IGB headers in selftest driver

This commit includes the official Intel network driver header files in
the igb selftest and refactors the driver to directly utilize standard
E1000_ prefixed registers and macros. It also removes the duplicated
registers.h file.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> index 5568b463c2f2b..74b4239545541 100644
> --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> @@ -5,14 +5,19 @@
>  #include <linux/io.h>
>  #include <linux/pci_regs.h>
>  #include <linux/pci_ids.h>
> +#include <linux/mii.h>
>  #include <libvfio/vfio_pci_device.h>
> =20
> -#include "registers.h"
> +#include "e1000_regs.h"
> +#include "e1000_defines.h"
> +#include "e1000_82575.h"

[Severity: Low]
Since e1000_82575.h contains function prototypes that reference struct e100=
0_hw,
which is not declared here, will this cause compiler warnings (like "struct
e1000_hw declared inside parameter list")? If the selftests are built with
-Werror, could this result in a build failure?

> =20
>  #define PCI_DEVICE_ID_INTEL_82576 0x10C9
>  #define IGB_MAX_CHUNK_SIZE 1024
>  #define MSIX_VECTOR 0
>  #define RING_SIZE 4096 /* Number of descriptors in ring */
> +#define IGB_ETH_OVERHEAD_SZ 18
> +#define IGB_JUMBO_FRAME_SIZE (IGB_MAX_CHUNK_SIZE + IGB_ETH_OVERHEAD_SZ)

[Severity: Low]
Are these new macros used anywhere in the code? It looks like they might be=
 dead
code since they aren't referenced.

[ ... ]

> @@ -297,15 +300,15 @@ static void igb_hw_init(struct vfio_pci_device *dev=
ice)
>  	 * IVAR (section 7.3.1.2, register definition in 8.8.13): map RX
>  	 * cause 0 to MSI-X vector 0 and mark the entry valid.
>  	 */
> -	igb_write32(igb, IGB_GPIE, IGB_GPIE_MULTIPLE_MSIX | IGB_GPIE_EIAME);
> -	igb_write32(igb, IGB_EIAC, IGB_EICR_VEC0);
> -	igb_write32(igb, IGB_EIAM, IGB_EICR_VEC0);
> +	igb_write32(igb, E1000_GPIE, E1000_GPIE_MSIX_MODE | E1000_GPIE_EIAME);
> +	igb_write32(igb, E1000_EIAC, E1000_EICR_RX_QUEUE0);
> +	igb_write32(igb, E1000_EIAM, E1000_EICR_RX_QUEUE0);
> =20
>  	/* Enable interrupts on vector 0 */
> -	igb_write32(igb, IGB_EIMS, IGB_EICR_VEC0);
> +	igb_write32(igb, E1000_EIMS, E1000_EICR_RX_QUEUE0);

[Severity: Low]
Is it semantically correct to use E1000_EICR_RX_QUEUE0 here?

In MSI-X mode, the bits in EIMS, EIMC, EIAC, and EIAM correspond directly to
MSI-X vectors (where vector 0 is bit 0), rather than legacy interrupt cause=
s.
While E1000_EICR_RX_QUEUE0 equals BIT(0) and works mathematically, using a
legacy cause mask to represent an MSI-X vector bit seems confusing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526235417.2058=
313-1-jrhilke@google.com?part=3D10
