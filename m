Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241DE37F8BA
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570896; cv=none; b=iiVLQGImP6uX0+g9us+Dt7BeUk5A6h7Pe3AySDUgn+N7TjOXYY9+dJybRmqilK0CZxX6A7ZUjQPyusMhrVhECBms48Y8V/UrhB+LHZz9Uq9TgKl8t9wxUFEq0RIPBBkYXaDnYvpbpqaAVpyug9Lhv5htK9t6VJidnTpQJngLsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570896; c=relaxed/simple;
	bh=Myn0f5PoONuBeSnhGPwFLjCEATkMK/fQIXssiOVSNy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBfqk4082aDT/lDo58v9xrX4eB4t56ftGaiwCOCV8NzQGGOeV9VlEHVjRAQKNI95K0yS8UnIXTEjWJiwN2UeRk+9p4u/KbJHO30IcadbqhkX9Tz+neglupK2NS/wByERNvR9VBGSVPXB/e4Tqfo4XWMyWeH4I4pynOc4YKTwk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=choYcLMz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="choYcLMz"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf452def93so3051515ad.1
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570893; x=1787175693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NPvoXejEXMCOLtks/4P44XseBHeJ9j+rFY5G6V1i118=;
        b=choYcLMzzYt+EkneTOegz0/c40LRIGJvd4bO/SM6+11qBRjCZHyFmO+vsdAOFxsS1w
         EiFXkb4eR8TjF0JQdMn3RBqgg/nXvx0gBedu1SzsFJcl4U6vYEWZrfNp0A8MWJF8Fx2/
         U/UEgb/kTjJEUR07MFRmoWAoNe5HDnLansO0wH3tlYyq/revCNq39mFPtxb0TpoqM9vH
         AYgxFm1KNabjVNnER7ZHZyUWclO/RwYCg7CeFztB5IgHuTbR+T3tUVfm1rzd+UDr7OXz
         v5dMxhIf8DGqcZlN39Hv939A46x5dcPthyVGFAW/Zn2jBSNQUufxPVWtYQkniVf/Dpus
         kAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570893; x=1787175693;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NPvoXejEXMCOLtks/4P44XseBHeJ9j+rFY5G6V1i118=;
        b=fZSn0dChgvY8PSAOsVEpTqXZWCvQjWH3KPw8028YkkcTdnALXN9670LBGUztGuYp07
         jEaFiAUEIxWdiDofIQapno0Z1WtRXwS+NsaOf32O97CH9+alI/ASQG3KBtAb3hUn7L2l
         lVIgUsslro9P9CTNnpEzdO7yR4q5Sssf48MPpS0QTqdyjrcV1yEwj4E7CWgZUWsPQDms
         PRd8WnYqDRpr1zKsuz50NduMoA5gz1U4hU+8hVevODp140mrQrHJG8NBAPjamDQkPwQI
         YT7LJNYJz3NL8WGtl0swiR19WXuEpVTAku2UAv21mPzn/R5OsfH+KhIg3rbd7bR7zG8O
         eU1w==
X-Forwarded-Encrypted: i=1; AHgh+RoAM0Nx++WwBbvImfcQfImjwhVvpGHptxy0u7uPiRltATUUWmoPv7VNUBagak89JavdPCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoWFnzExAkeMAleJZhiFYN/rloegpPHceK0855vjR2CLF7AxxQ
	UJgQ9QOcgu3qMQ7WJZqUSd6sHvE/nFo1hhbyMgog2e3goM4EbcvTQ/5kIhT0+KOXhg==
X-Gm-Gg: AR+sD112WT3/tE1unFZJKoU3mfVnRP3dlqAihA4dhGKUdI5Urzt3NHJcyfDX3j8gTA8
	0+fNxbGBHvsLZGFHNsQdokygvIaueaNzCAno4KBzpO/aicRoudqAT8FQalY/qc1fRMUeqql4ldW
	OYoBug5d7ZrYlzxJqW4aR0P9OsqR9LmUX6O/1pmMGTH8gwQDrJmt7Vwldn5uOaqXvz/U3UhqwKs
	GOKH67oauYPuwimCXRRdVuCgyiEhqBZa2L5MVD996Q68hwRh8RMBWuz5M8GdSoVtAYKYguTGR4G
	KbIxOdRnk+Rvy8j3FPkvK9A70bjxVwF5jkm7xDM+xYFzUp6ytKOvIoj1oQH3DMEfD4jvuNgjlv8
	vpA7oLpCn+i2ieTEB78fZXY48Tcm1/HUseVmi0KV3GyYRHzIOAZhs7E4RpzZoPsVdalHBIsAweo
	qF8PxjiEtNl77wY/c7xGhImRN7thuEmuLIgXvv9kV8grAn2Xp2q4gvU+ASZjicxPdtXZUpC4dDo
	8mF7JT9FpN5ZqPt0Abahdyj0cF+TA==
X-Received: by 2002:a17:90b:274c:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-3931f583a5amr478962a91.10.1786570892837;
        Wed, 12 Aug 2026 14:41:32 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931ced0781sm878738a91.11.2026.08.12.14.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 14:41:32 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:41:28 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v4 08/10] vfio: selftests: Add mlx5 driver - HW init and
 command interface
Message-ID: <anzoiALsjiWrsZtl@google.com>
References: <0-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
 <8-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>

On 2026-08-12 11:59 AM, Jason Gunthorpe wrote:

> diff --git a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
> new file mode 100644
> index 00000000000000..a2506ec8a19523
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/*
> + * mlx5 VFIO selftest driver - HW definitions
> + *
> + * Typed wrappers, constants, and helpers for programming mlx5 hardware
> + * via the VFIO selftest framework.  Most HW constants and all MLX5_SET/GET
> + * macros come from the kernel headers (mlx5_ifc.h, mlx5_ifc_macros.h).
> + */
> +#ifndef SELFTESTS_VFIO_MLX5_HW_H
> +#define SELFTESTS_VFIO_MLX5_HW_H
> +
> +#include <linux/io.h>
> +#include <linux/build_bug.h>
> +#include <vdso/bits.h>
> +
> +#include "mlx5_ifc.h"
> +#include "mlx5_ifc_macros.h"

I'm getting a compiler warning here when building with clang which is
getting upgraded to error from -Werror.

  /usr/local/google/home/dmatlack/kernel/trees/review/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_ifc.h:2706:50: error: field 'menu'
  with variable sized type 'struct mlx5_ifc_resource_dump_menu_segment_bits' not at the end of a struct or class is a GNU
        extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
         2706 |         struct mlx5_ifc_resource_dump_menu_segment_bits menu;
               |                                                         ^
           1 error generated.
           make: *** [lib/libvfio.mk:36:

I assume the mlx5 header needs to be fixed... But we can also work
around it in VFIO selftests if that turns out to be a can of worms:

diff --git a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
index 2c451e411ec1..b9fad2b722a0 100644
--- a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
+++ b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
@@ -13,9 +13,18 @@
 #include <linux/build_bug.h>
 #include <vdso/bits.h>

+#ifdef __clang__
+#pragma clang diagnostic push
+#pragma clang diagnostic ignored "-Wgnu-variable-sized-type-not-at-end"
+#endif
+
 #include "mlx5_ifc.h"
 #include "mlx5_ifc_macros.h"

+#ifdef __clang__
+#pragma clang diagnostic pop
+#endif
+
 /*
  * Typed HW object wrappers for driver region arrays.
  *

