Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96447AF56
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400835; cv=none; b=E4PzWlFM3NlE4Tqyo//8YGaeViSeOnChj3ALBSEilTolefXm+v9th0AumPEP0taBd04+n894F+mc+bEIb8BhA6w4qREiih2puVUBAxqebS8UiQLeu1ddnLU6F3Z3L2MQTojt9gKHcDe/xuOB2ZkPW4XS0MiAiaB9XESeWNr1OsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400835; c=relaxed/simple;
	bh=Qgs4VKe6aa4WyJBdEkeJSC4dGYTWRhPAU+v9n/d2wxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9JXf40pB36VMiPZiVO3zvMbygQf1lD6PYGdCmIlrb8IkeZAdAiihb2sdg941rt6Ni1TYyNUJ7D2V57u/YgO/WYoSMtUZCt0dqCIUu3YtQz3UB6OKe7RC8lqG73cclXxPdyhsAFwfoJ9F+ER98ZqSG5V4Ec++2lqWB12OUDNqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUQhxdmd; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUQhxdmd"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d90833cacso7481317a91.2
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777400833; x=1778005633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0UGTjzT1o8VOQ2X8VCxDZk9yTiALK5gtuUuVtTpZzQ=;
        b=vUQhxdmdeuDL+FmBTeTFCL84u8FbaZMFQd8jFbXkAUH7rA8EFiDAWvTaanwtnGkWDT
         aGpUA5rJl4AQw3logHsf4Mgxvaf8CATv4bXr2qZmtCqbycJmH7EtK2AtrC2bTha7iBO8
         huu5X3m/SjKAApAt62Qm3adcufkd8yhIA9gRixIfobX6+0+PDt+Fdz1n0vJs0MVGmZ4Q
         pGWkJbhfoAgfE5H1F6ii/BpZNyJuq+C+YS0qdMnHlxG+qFrtn5UB0CL6VvCdozxz0ubA
         wN5G/MBrV27x/IeC4Fq+Glo2p93SI6i0i5zaxdSO6s5o9nJ9ckYuibeT/xoQZKOC4m7o
         BinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777400833; x=1778005633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0UGTjzT1o8VOQ2X8VCxDZk9yTiALK5gtuUuVtTpZzQ=;
        b=GduuYM8MuVX9iQCe23ZAmdXLw91nA8kbC13veEEXRiVSOQV+RwusvWsTerzmbW5FHC
         WLe3eHOOiDdZObKyXO6qshaNVxVhEXrQhQalNswKqYVvNMlByDhppw/Whx5CR4K3x5d2
         0G72+1JaDu+dbrVPYDBXHjxdkWL6Jr6DXcnUlIOVxO+paVv8v01KAaY08n3RoA464hLg
         hw+iUjUNBSwcD30KxouEcKqTEqb5l8OCAQlMSRjZQp+KswDMhcOjnA3IjCG7JyMZw7sS
         jOJACc2pRBk+i4MalhQu7nssVDLqvTew4UI7lsqoJkIZebJ1q8ZQFs+mGzxmBi4P3Tr+
         Ljbg==
X-Forwarded-Encrypted: i=1; AFNElJ9lxD+DqsJmZ+E4Yd4jd4BTuk2OsCAgTg03R6GTNtp1vu3k9R/x6tcdTvLkpHH4+rq4usQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ZHGQ4kDjPdNXd7vre1AEOWISQdBkKUNExII6XJNQKL7ygjJv
	qPiOoVAGvz/+iy+Fa7h7Uo8ZDkMuSquGqFkGRTNQYLJPSQpLsZLLRLFoKSbeSX0NPIBYzSsWQrE
	oiAmG0g==
X-Gm-Gg: AeBDieuYZJnn6NdpCbW4Xc0AmiyzmwgkeYzxPBYcE7Y8iwb3Uo23eMB6VBjLfbybC6V
	ZKqOpYhrA7w3dJujC87ngEnVO2HSNUwXpR5NeTIN3fPIcI3pQe8E80Rr3Abm5gD8snZIReJ8iO6
	IlEQGnWrnOtZWlaT19METxcBAcm9h6f5qUf49RyEjnA9BfrK51f3F/CwQh7rC6Or98Mv25lBiUU
	X6RwN8mTRoPWhjne8m7v8c4kt7diqfUx1WgkHByZ0J10WIOmx5mjTd0qzA6wTGVprYWSFlQlg9m
	you31H/eLWwNsHL/5k2wSmCG7wDVhNebqQ2kmRrSiXkx01/1JBJIi430qkJP06ewaaBx8OEG7nN
	D9w2kbbKyZjVoCDsxXmvoY3HvA759kFfKbXzMpNdEBdSh3aQ7F6pkPCUpkLKdhNBDJIMj4WnCSp
	FvDZPO/Ubq4og2NhB0b/96ouI0Tzxvh0k8HNjXE23trUEb9PaIEC8wl6+ZB/GkRUs+DAp0fxuDe
	ZATMA==
X-Received: by 2002:a17:90b:268f:b0:359:87a8:e65c with SMTP id 98e67ed59e1d1-3649202ea13mr4377890a91.17.1777400832390;
        Tue, 28 Apr 2026 11:27:12 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a119e0b4sm76522a91.5.2026.04.28.11.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 11:27:11 -0700 (PDT)
Date: Tue, 28 Apr 2026 18:27:06 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	patches@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] vfio: selftests: Fix out-of-tree build with make O=
Message-ID: <afD7-rg58XvqRJpD@google.com>
References: <0-v1-79f29139180b+8e-vfio_st_make_o_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-79f29139180b+8e-vfio_st_make_o_jgg@nvidia.com>

On 2026-04-27 08:07 PM, Jason Gunthorpe wrote:
> The test programs are compiled via a static pattern rule that requires
> intermediate .o files:
> 
>   $(TEST_GEN_PROGS): %: %.o $(LIBVFIO_O)
> 
> After lib.mk prefixes TEST_GEN_PROGS with $(OUTPUT), this creates
> dependencies on .o files in the output directory (e.g.
> $(OUTPUT)/vfio_dma_mapping_test.o). However, there is no rule to compile
> these .o files from the source directory .c files when OUTPUT differs
> from the source directory.
> 
> Add an explicit chain of pattern rules:
>   $(OUTPUT)/% -> $(OUTPUT)/%.o -> %.c
> 
> Following the same pattern already used in libvfio.mk for the library
> objects.
> 
> Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  tools/testing/selftests/vfio/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 40165d087a0bc4..81c3be8298fdc2 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -27,10 +27,13 @@ CFLAGS += $(EXTRA_CFLAGS)
>  
>  LDFLAGS += -pthread
>  
> -$(TEST_GEN_PROGS): %: %.o $(LIBVFIO_O)
> +$(TEST_GEN_PROGS): $(OUTPUT)/%: %(OUTPUT)/%.o $(LIBVFIO_O)

Changing this line (with the fix you replied with) is not actually
needed right? I tried the following without it and was able to build:

  $ make OUTPUT=/tmp -C tools/testing/selftests/vfio

$(TEST_GEN_PROGS) has already been prefixed with $(OUTPUT), so %
in the original pattern already included $(OUTPUT).

Is this for readability?

>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
>  
>  TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
> +$(TEST_GEN_PROGS_O): $(OUTPUT)/%.o: %.c
> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@

Looking at this commit made me confused how this was even working before
and I learned that make has built-in rules to build .o files that
assumes the .c is in the same directory. I see now that we were reying
on those built-in rules to build $(TEST_GEN_PROGS_O). It makes sense to
have an explicit rule to handle the directory mismatch between .c and
.o.

This also got me thinking it might be a nice cleanup to use the
predefined macros $(COMPILE.c) and $(LINK.c) in these rules instead of
$(CC) $(CFLAGS) ... etc. No need to attach that to this fix though.

> +
>  TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBVFIO_O))
>  -include $(TEST_DEP_FILES)
>  
> 
> base-commit: 681b35420592a2e072d9759254185e72d2e914c8
> -- 
> 2.43.0
> 
