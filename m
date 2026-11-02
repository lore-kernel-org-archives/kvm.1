Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657186;
	b=u3lq/lDyGIVR2KlFLqCB565MSeqR2325wAwf4uHhEkBnMmTWpq3Zz5rGCHMQqXjJrUP1
	 gHTnc74LGoYPKbsZ60LY207OId1GIVSWv1T/+amrZeAgu0DidVdIxfKPS5dcS+jLgjojW
	 WHzr8zKMQeitybs4pN4NAVvHJRAGt4qCuez9waM2Li54YmhHeeAokmG6rMMelbb3ZkO+9
	 K5BaehLa8bcEEhIqVuVO927cT6xr7EEktff/3lcKdwkzP9lt7LwqkQ4l+qOFbpCkDrpL8
	 xanr7qE47m6Mc3uKrieKrULru33qTccTXYCr05hQZqGOVeU2lM2iHSHyymtkJE1m5Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NH6jz3WPUJHIT+J12ydGYZK6J+d3CqEgAa315HjW4cw=;
	b=C4/lLxP4s02n8SK2ya+3Gs1UO6hpE7EQcfbDwtNIEmLrPZBd8om1bI/nmkZmP71JYN22
	 /1Ux4BrmOJimBlMKsi3EzdrvgcyWA98zWYJ6yWSvP6c138bH3DEIsY+24gRNNpj/B3wrH
	 j7No6Y4/JnBlMM2IzraGtkbe5Qiu/oeGG4uZoSWiIgofhr2/2cc/iv6rB2qwP/5baBsUq
	 RZKlhTjbdaoEmLcFYYirEoYC5n6SczlQ/P/LXL1/6Xff0n260MR31bSkHip+8dXhl1oYx
	 dt+aR/WACFqUGk54dn2LKlENLFKdomBqK4Nk1famLG3O3a2mad8yhBbTSKW1G3iwVbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B1AD7UqS;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E539D606A32C
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 22:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E539D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B1AD7UqS
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ea94541adbso15348945ad.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 14:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793657185; x=1794261985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NH6jz3WPUJHIT+J12ydGYZK6J+d3CqEgAa315HjW4cw=;
        b=B1AD7UqSqrGX1/VZ9OPSvRwQQaY1cQeTHUa+6qKksae8nAaFO6w3T01WQxSAS5F9pr
         3p3mBtKjiUnZw4iKOK+uwGkSkRA8Rx/rlSVfvuv1XSvkvMyiLlzoHOE2DOHXpivjkpHO
         htLEikQv31Jn0Hyi6pbSQKcJQTV+ZlUcssFRrd7PJLhdXlbVw84gu2Z4D/xFcfnKNiDm
         MlrIHQvplxHQEgqxKc+vHzBp0zIEgNH2xDIAARXoQmgTFLQ0X9PlbjR1qsFkCsL4LAoe
         OQI33JJnV+fdOJz0LxWGRphXSw8FC4m5WltrkCBeEsddhd/jdWDedF4pmEKRg+SPdhTa
         uafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657185; x=1794261985;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NH6jz3WPUJHIT+J12ydGYZK6J+d3CqEgAa315HjW4cw=;
        b=rm/GP2v+UswsOsRYjHh54OqX+lsBdcRKF6RS8a8aCqkigEmp/+nRhQX4jz6o1uWube
         u41hUPoJ45VTEyT47tJBytJbb+bY44Z6YLemJPzXfPfn7uJrBixB3uK2ekx2bxNmZHbG
         900YY7zRGIAFXGdTRwsKkE/yv4SCsJIeoTO+/v/A3bR6Suqyh7dL7g3Dbw65L1QFjHRj
         LcC12MJyyZ215snKeC0eTsICH4l0DnJtdai+rUr+RqJfsvKY3ZBhEwqkJvmjA4kfqZXc
         pFjJZjdAqze6kXrbcW4G4e5QvSPWolYuWgd5Q3W0KviPu/patHl8MwhRIYcwBlT9DMWM
         46Rg==
X-Forwarded-Encrypted: i=1; AKwUvBxPmKzRt8PNJwyq0NKJpk7qBFA71nrlzGFcZIQmATCKMMf/FBjAepH0XkjUzoYIw1Ht5zg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Bw6zj6/LPJiK29m9UQlM3IXRKoNIFHyl0RSga43kG5/LxbNVN
	3AlnjJASH/iinoMIifvdX5Owq0huXPujVJxJj33a17+rkRn9OJqu7YcZEadqIu9b1w==
X-Gm-Gg: AYBFou24ctR5aePgl9OhTEymFD/DnVwAk8ajI6kqB1Y4VYTD0M7/+WN6F/JccBO5iFu
	lAHeIWlEBR3vgGtlkR29bNx10jnhSLh20FI/Vj8sTRPFbSgy4+a/nyYqhUX24V4J2bkR8ptU38Y
	sXmALL8tf9ZDSeE6odkfwbFThFkYhqdzRLCrcIphyDOuh9N3U75n56xAcrUAG5BBvdBKOHfbS2d
	IhbmX6q3vXtGWRH7lKCavPXeEPGtpWwWiO4XScp1pRSaZkC2v3ukONU96BJIDnuz7KUHBrWyWbY
	LpeBxogH85f/1vaULN/NT6SI/d85e4bUlZvGh4yFKVRRZhP0i7Z//8hqZt7lTMLHIvQVKskYJ4n
	mjtIt8N86AYc2r8ftONkuwMwaBlK56Q6VEiwS8oaXNx7IH6kvgIWRZEW2WAhejLzoNlEmnQ+d4l
	tiomvg4EDbjHR9NNfMZTa1tZI5l5Uid76+Xn668lk4znb6bY4w2Ez6hjg3Bn6NvQkgR+ZNyf+E3
	79Fgf6zEaeRtpDa8c/tKSOt5HwDyiRWToZgGbqB2hZn7OOzucjl8ymP7CQFls6zxjFr1Ms17Oi4
	Bd9ZOGlNoxuCcJ1irwOWlO6eIeD7H3Xp8u2vdNmNcdf3atVWYnO26ssJA4dSCiQhxcvZlvgG4cY
	it9k92iu7Zw==
X-Received: by 2002:a17:902:e54b:b0:2eb:250a:f4c0 with SMTP id d9443c01a7336-2eb364b121dmr103721415ad.33.1793657184617;
        Mon, 02 Nov 2026 14:06:24 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39248909sm32370385ad.33.2026.11.02.14.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:06:22 -0800 (PST)
Date: Mon, 2 Nov 2026 22:06:19 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfio: selftests: Remove libuuid dependency
Message-ID: <aukJW-svGhlH4Jut@google.com>
References: <20261102200624.1570562-1-skhawaja@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102200624.1570562-1-skhawaja@google.com>

On 2026-11-02 08:06 PM, Samiullah Khawaja wrote:
> Libvfio depends on an external dependency libuuid for parsing vf_tokens.
> Building it in cross compilation environments gives the following error,
> 
>  ld: cannot find -luuid: No such file or directory
> 
> It also complicates building with glibc alternatives like musl, see
> https://lore.kernel.org/kvm/c2f7e904-2646-4b01-864d-d185221c7f56@gmail.com/
> 
> As it is only used for parsing vf_tokens, remove the dependency by
> adding a minimal uuid_t and uuid_parse() to libvfio.
> 
> Tested by running vfio_pci_sriov_uapi_test selftest.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

Please lead the commit message with what the patch does, and then follow
up with the background and motivation. The VFIO selftests documentation
(merged for 7.4-rc1) asks contributors to follow the KVM x86 guidelines
for changelogs:

  https://docs.kernel.org/driver-api/vfio-selftests.html#contribution-guidelines
  https://docs.kernel.org/process/maintainer-kvm-x86.html#changelog

Also please drop the "Tested by ..." line. Details about how you tested
the patch are useful to reviewers, but they do not belong in the commit
message. Put them below the "---" line (e.g. next to the v2 changelog)
instead.

How about something like this:

  vfio: selftests: Remove libuuid dependency

  Replace libuuid with a minimal uuid_t and uuid_parse() in libvfio, and
  drop -luuid from the build. libvfio only uses libuuid to parse VF
  tokens, so pulling in an external library is not worth it.

  libuuid is often missing from cross-compilation sysroots, which causes
  the VFIO selftests to fail to link:

    ld: cannot find -luuid: No such file or directory

  It also complicates building against glibc alternatives such as musl,
  see https://lore.kernel.org/kvm/c2f7e904-2646-4b01-864d-d185221c7f56@gmail.com/

  Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

Other than the commit message and the minor comment nit below, the patch
looks good. Feel free to add my R-b tag in v3.

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
> v2:
> - Move the parser to lib/uuid.c and lib/include/libvfio/uuid.h (David)
> - Drop the vfio_ prefixes and add a uuid_t (David)
> - Mention musl in the commit message (David)
> 
> v1: https://lore.kernel.org/all/20260925013110.3447626-1-skhawaja@google.com/
> ---
>  .../selftests/vfio/lib/include/libvfio.h      |  1 +
>  .../selftests/vfio/lib/include/libvfio/uuid.h | 11 +++++
>  tools/testing/selftests/vfio/lib/libvfio.mk   |  3 +-
>  tools/testing/selftests/vfio/lib/uuid.c       | 47 +++++++++++++++++++
>  .../selftests/vfio/lib/vfio_pci_device.c      |  2 -
>  5 files changed, 60 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/uuid.h
>  create mode 100644 tools/testing/selftests/vfio/lib/uuid.c
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
> index 07862b470777..e9d513c3a08e 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
> @@ -6,6 +6,7 @@
>  #include <libvfio/iommu.h>
>  #include <libvfio/iova_allocator.h>
>  #include <libvfio/sysfs.h>
> +#include <libvfio/uuid.h>
>  #include <libvfio/vfio_pci_device.h>
>  #include <libvfio/vfio_pci_driver.h>
>  
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/uuid.h b/tools/testing/selftests/vfio/lib/include/libvfio/uuid.h
> new file mode 100644
> index 000000000000..52406f3409b7
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/uuid.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_UUID_H
> +#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_UUID_H
> +
> +#define UUID_SIZE	16
> +
> +typedef unsigned char uuid_t[UUID_SIZE];
> +
> +int uuid_parse(const char *in, uuid_t uu);

Note that this differs from the kernel's uuid_t, which is a struct, and
the kernel's uuid_parse(), which takes a uuid_t *. I think matching the
libuuid API is the right call since this is userspace code (and it keeps
the callers unchanged), but it would be good to call that out here. The
"Minimal replacement for libuuid's uuid_parse()" comment in uuid.c could
move to this header and mention that uuid_t and uuid_parse() mirror
libuuid, so readers familiar with the kernel API aren't surprised that
uu is not a pointer.

> +
> +#endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_UUID_H */
> diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
> index eff95828719e..d1d1b2b05af1 100644
> --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> @@ -7,6 +7,7 @@ LIBVFIO_C := iommu.c
>  LIBVFIO_C += iova_allocator.c
>  LIBVFIO_C += libvfio.c
>  LIBVFIO_C += sysfs.c
> +LIBVFIO_C += uuid.c
>  LIBVFIO_C += vfio_pci_device.c
>  LIBVFIO_C += vfio_pci_driver.c
>  
> @@ -30,8 +31,6 @@ $(LIBVFIO_O_DIRS):
>  
>  CFLAGS += -I$(LIBVFIO_SRCDIR)/include
>  
> -LDLIBS += -luuid
> -
>  $(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c | $(LIBVFIO_O_DIRS)
>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>  
> diff --git a/tools/testing/selftests/vfio/lib/uuid.c b/tools/testing/selftests/vfio/lib/uuid.c
> new file mode 100644
> index 000000000000..378904d9340a
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/uuid.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <string.h>
> +
> +#include <libvfio.h>
> +
> +/*
> + * Minimal replacement for libuuid's uuid_parse(). libuuid is part of
> + * util-linux and is routinely absent from cross-compilation sysroots, which
> + * makes the vfio selftests unbuildable for non-native architectures.
> + */
> +#define UUID_STRING_LEN	36
> +
> +static int hexval(char c)
> +{
> +	if (c >= '0' && c <= '9')
> +		return c - '0';
> +	if (c >= 'a' && c <= 'f')
> +		return c - 'a' + 10;
> +	if (c >= 'A' && c <= 'F')
> +		return c - 'A' + 10;
> +	return -1;
> +}
> +
> +int uuid_parse(const char *in, uuid_t uu)
> +{
> +	const char *p = in;
> +	int i, hi, lo;
> +
> +	if (strlen(in) != UUID_STRING_LEN)
> +		return -1;
> +
> +	for (i = 0; i < UUID_SIZE; i++) {
> +		if (i == 4 || i == 6 || i == 8 || i == 10) {
> +			if (*p++ != '-')
> +				return -1;
> +		}
> +
> +		hi = hexval(*p++);
> +		lo = hexval(*p++);
> +		if (hi < 0 || lo < 0)
> +			return -1;
> +
> +		uu[i] = (hi << 4) | lo;
> +	}
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 4063a0e2b3df..4ae6ac1f8ed8 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -23,8 +23,6 @@
>  #include <linux/types.h>
>  #include <linux/vfio.h>
>  
> -#include <uuid/uuid.h>
> -
>  #include "kselftest.h"
>  #include <libvfio.h>
>  
> 
> base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
> -- 
> 2.56.0.385.gac671c819a-goog
> 
