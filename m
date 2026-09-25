Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB44F55A0
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369723; cv=none; b=dfmsXomZ6ZXSmqqoveo/tapQgOdn6anH9Olw1jdSNdP+FzqXCZ0CrZPnzxifeyhjsjmnUMS0cwhBzAdtNrG4CsfKB/gm9/l8xmSUEk0ekJpl7rKfV5Rypp5z+kL85f/prsd21/jOf2u4YH3IjmOwIqLMTJDfRCFY/1ATCYqECVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369723; c=relaxed/simple;
	bh=24yjjZnXY1DYpKHmlWT+MX+eqe42maAyhosiwvUV4Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iadiu/IXswAPapWMgUANcWVvbqDmNZbycp0qeszxRp0VFK8LZqdRGqCyZBvA6l08Nan3W1iDo0tGmrE1aFZdfJ0r6lsoSQNI+jhVWivn9djb4LtH7OmGWf8o6EwrFmTYsVEUS9MTQWgxhN/UUDnCzmXex4UUxaF1A1PcNdic9ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/c/VDNV; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/c/VDNV"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so499787a12.2
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 13:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790369721; x=1790974521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IBZGc7Te6ndEEpx/gGdvka8Znd6f8zDQu/S2hFPgZOI=;
        b=i/c/VDNVHCPWl97WQJskVHZAtqvnrn7g4eSpFAaI3IJdWU35ZK0KntL4ozB8baPFqa
         wjyEn4QmYcGrqFhbRxDNPAkGx15DHOG6hG+M5NfrQiyv/5VXILvu4uiD93F8VLw3UUpU
         vj3TAbTHgNJSlhztLvPUu/EKh+gYPVIfGQ81tpkak1Q4+KqI+iVHeZbW7v6EZhYPXgju
         sd6MI5Yi4tPPkjtviY10AEP/WoFOvsQjGw4sX6/nhdBWYqmax30IdYQksPvaIXhdGMsD
         nK5H8QiFwMxFql1mZGirnW3vgSDR+BqyCSDYGFARLUwyFSEXeE14EIMawf+EGL2o9eZ9
         Bt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790369721; x=1790974521;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IBZGc7Te6ndEEpx/gGdvka8Znd6f8zDQu/S2hFPgZOI=;
        b=NRx0C+YSrazuof+/5HqqTTqdFPtW07lyfHdLRF7iZv1ZA67ffPOoY4nl96gpEFVxzY
         p9UkR7kfbSeFyodsXDjAZCwAiJ3CkJuCnnngl0nb/aPGTUaQbu1FKHH6jT68/RYqPTAK
         sqdZ9v2WSN3LeQ1dIu0pGuuzLC525jm6jiPQksKTjY1vsShvsb6lq1+/nTiqzJiKMj1j
         /DzyGI4Y3dFpiBu1Rgiqhz99mqv0OUjRV5TNRCM7FGVajTmVzqCaeDTzAcc+owlhpnbL
         OCAkyw+sNaR1zrCqveBnh8XaXdkLup6YuvgRL9I+Wg+hJ8YmUzhDIgkx4dRnxzuMEzKS
         OZ1g==
X-Forwarded-Encrypted: i=1; AKwUvByVwbqsYXeMKg0JCcB0GIHBCdxRKypZjOwdxtsT02FdnSL0X6WFQ7bFC+/iZ9yWbDskN8Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lrxCFOfvGb9X3iOOcoyu9AafXuG6S9ggmo2Sg65jwaFrixLoco
	ko5t0BFbWzG2F8BfF6da+5VKEaM2WD7oggo3YUTWX/t8xiSw+MNapwfh7XT5ryvt1w==
X-Gm-Gg: AYBFou3AxSGlhI73EGoScDdGmZwqeJdeaep0/60QV3pyh3doAn+JNZRHnQgcQFpZBD0
	MoDn3dzKXIJDKIQKIKce9HJgLO2j6bXmeKfCoP2IMmrQXp4QT0ePSrpnOEslvVHoeAAJPi3haTQ
	A8tX2BG0nbMt0LVs2G2RKG9KGKjyL1qR6x+g3JdCk/j93+y245YoPxrzjB/29H5WA76dQBVR+9q
	xKSrNmuG+jKNu3P0CW7drSFaBR/lZfGFsTVkET2m74IeclfFcQTzrQEHvrI7hU1CtjrRPOLn1em
	O6+Lk42OzyJsXgYjwDwQMB9ljK8a8Lrh/Ryq9cb726+lkQX975iEKyNBclqy3hzRuc4w/QXXhO9
	vPPfbfd/B7MqKbcHj0hPnKbqj7SgoDO7wEtpoWDqoT5Cn31gITKN32izYwmeNLHM6fwbCd3QCIC
	wBaf1PI6e1Fjm7Iqpd7szTxgAoxN7h6IoPc5ewG+RpwdaJhYVWYNrYchS+EPU6/EC4pv/AnxKPd
	HPgi3wmmtYG4yGr8o1y66fLhfe2L9wXySZ4cxw0
X-Received: by 2002:a17:90b:224b:b0:39e:6a81:f34f with SMTP id 98e67ed59e1d1-3a098bb63femr5626684a91.41.1790369720447;
        Fri, 25 Sep 2026 13:55:20 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b99917besm6043758a91.14.2026.09.25.13.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:55:18 -0700 (PDT)
Date: Fri, 25 Sep 2026 20:55:13 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Alex Mastro <amastro@fb.com>,
	Sean Christopherson <seanjc@google.com>,
	Rubin Du <rubind@nvidia.com>, Josh Hilke <jrhilke@google.com>,
	Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hisam Mehboob <hisamshar@gmail.com>
Subject: Re: [PATCH] vfio: selftests: Remove libuuid dependency
Message-ID: <arbfsdQ72pIew9TB@google.com>
References: <20260925013110.3447626-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925013110.3447626-1-skhawaja@google.com>

On 2026-09-25 01:30 AM, Samiullah Khawaja wrote:
> Libvfio depends on an external dependency libuuid for parsing vf_tokens.
> Building it in cross compilation environments gives the following error,
> 
>  ld: cannot find -luuid: No such file or directory

It also complicates compiling with glibc alternatives like musl. See
https://lore.kernel.org/kvm/c2f7e904-2646-4b01-864d-d185221c7f56@gmail.com/

Please mention that as well for historical context.

> As it is only used for parsing vf_tokens, remove the dependency by open
> coding the parser where it is required.
> 
> Tested by running vfio_pci_sriov_uapi_test selftest.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  tools/testing/selftests/vfio/lib/libvfio.mk   |  2 -
>  .../selftests/vfio/lib/vfio_pci_device.c      | 57 ++++++++++++++++---
>  2 files changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
> index bcfa74ae040e..7d6916ca3940 100644
> --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> @@ -29,8 +29,6 @@ $(LIBVFIO_O_DIRS):
>  
>  CFLAGS += -I$(LIBVFIO_SRCDIR)/include
>  
> -LDLIBS += -luuid
> -
>  $(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c | $(LIBVFIO_O_DIRS)
>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>  
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 4063a0e2b3df..774d1e90ec0e 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -23,11 +23,54 @@
>  #include <linux/types.h>
>  #include <linux/vfio.h>
>  
> -#include <uuid/uuid.h>
> -
>  #include "kselftest.h"
>  #include <libvfio.h>
>  
> +/*
> + * Minimal replacement for libuuid's uuid_parse(). libuuid is part of
> + * util-linux and is routinely absent from cross-compilation sysroots, which
> + * makes the vfio selftests unbuildable for non-native architectures. The only
> + * thing needed from it is parsing a VF token, so open-code that instead.
> + */
> +#define VFIO_UUID_LEN		16
> +#define VFIO_UUID_STR_LEN	36
> +
> +static int vfio_uuid_hexval(char c)
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
> +static int vfio_uuid_parse(const char *in, unsigned char uu[VFIO_UUID_LEN])

Do we need the vfio_/VFIO_ prefixes now that we aren't linking libuuid?

> +{
> +	const char *p = in;
> +	int i, hi, lo;
> +
> +	if (strlen(in) != VFIO_UUID_STR_LEN)
> +		return -1;
> +
> +	for (i = 0; i < VFIO_UUID_LEN; i++) {
> +		if (i == 4 || i == 6 || i == 8 || i == 10) {
> +			if (*p++ != '-')
> +				return -1;
> +		}
> +
> +		hi = vfio_uuid_hexval(*p++);
> +		lo = vfio_uuid_hexval(*p++);
> +		if (hi < 0 || lo < 0)
> +			return -1;
> +
> +		uu[i] = (hi << 4) | lo;
> +	}
> +
> +	return 0;
> +}

Please move the uuid changes into lib/uuid.c and
lib/include/libvfio/uuid.h in case we want to use them elsewhere in the
future.

> +
>  static void vfio_pci_irq_set(struct vfio_pci_device *device,
>  			     u32 index, u32 vector, u32 count, int *fds)
>  {
> @@ -167,13 +210,13 @@ static void vfio_device_feature_set(int fd, u16 feature, void *data, size_t data
>  
>  void vfio_device_set_vf_token(int fd, const char *vf_token)
>  {
> -	uuid_t token_uuid = {0};
> +	unsigned char token_uuid[VFIO_UUID_LEN] = {0};

Any reason not to define a uuid_t?

>  
>  	VFIO_ASSERT_NOT_NULL(vf_token, "vf_token is NULL");
> -	VFIO_ASSERT_EQ(uuid_parse(vf_token, token_uuid), 0);
> +	VFIO_ASSERT_EQ(vfio_uuid_parse(vf_token, token_uuid), 0);
>  
>  	vfio_device_feature_set(fd, VFIO_DEVICE_FEATURE_PCI_VF_TOKEN,
> -				token_uuid, sizeof(uuid_t));
> +				token_uuid, sizeof(token_uuid));
>  }
>  
>  static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
> @@ -415,10 +458,10 @@ int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
>  		.argsz = sizeof(args),
>  		.iommufd = iommufd,
>  	};
> -	uuid_t token_uuid;
> +	unsigned char token_uuid[VFIO_UUID_LEN];
>  
>  	if (vf_token) {
> -		VFIO_ASSERT_EQ(uuid_parse(vf_token, token_uuid), 0);
> +		VFIO_ASSERT_EQ(vfio_uuid_parse(vf_token, token_uuid), 0);
>  		args.flags |= VFIO_DEVICE_BIND_FLAG_TOKEN;
>  		args.token_uuid_ptr = (u64)token_uuid;
>  	}
> 
> base-commit: 3d7783543c2646af69ad65825e810060494bea21
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
