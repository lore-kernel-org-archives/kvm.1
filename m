Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30E62FD1A5
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781382921; cv=none; b=Q0LCi8JOrGDodyqUO7snc72LNUV/Ktf+4vp4SQ0JrQZkLRtnxUrtJGZfK2Wt9E/8F7k6tva6ZnoDWWB3fNkvSzji/VMqfMX1Z+2AEq5b1J3M0mIRZMmWuyOIZUlhIrfmRfomI7C8dabVoPO16dKv4tNdmh50M0Wj4V8aZIex+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781382921; c=relaxed/simple;
	bh=jY+5h6BEqTigLHC2QbDztdBxYdYvY/v+aeeg3os3Dn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGUWRCdVXjmJRPQYpGGT8Js6yE2mw7VdJ8LdaxDSesw32HCSzaF5THVt4AqKQ3pNATCchR9vzfc9eruepmtpO1Wk8xy8Z5TUf+jb0ojDOy3DkNa5oQD7tVFBvwKXHHFvLGunJcNfRyTzmZWj6QmFkJWPFx3DB4yJ2zRf1cOKH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=apg+IHY5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apg+IHY5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf2911f93cso50145ad.1
        for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781382918; x=1781987718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lFug7r9V2IZ6ttYLRSwXSuZdIzMUMmjx+agrhP1KloM=;
        b=apg+IHY5EFWnXL9g1EiX77U0u3H94ggPa3gh7pfv66zbsk/wGcEXkLBDF1x+tuOJbT
         OG9kWhMBf4pRXF9uda/m+Wf/TarWhsEIjVQaZ9T9KArd3A3JpI0/Iv4qfU/VCZjvJPa9
         EnCUPtX9aDVaFD2qbKeVOIjiQ+DEJ0IUoKptnGg4DfwtIoMF7zoAql3n+ABfVZ8kGtux
         MnhSSd2tVIHs2ejfZ0Yq+NWkdKoEbi6hAOJhH17k0OPEhbx6KAoOCfJX3kLPIhGwPpK+
         5YWwyZMdvpvVfGz4wBgst87wGUSpoyNPgWGVc2nDOs4Oi6GI7DG6/Xj3V8U88AwStaeP
         yepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781382918; x=1781987718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFug7r9V2IZ6ttYLRSwXSuZdIzMUMmjx+agrhP1KloM=;
        b=PvpkzZ15+7OTQVWgH3vts4omQR+ktpc0BD2GFkL2gMmAQGpCd/Ft5nlHdVxRg1/Kwf
         xLGEMzFSpwBKwC7br+vCWyJGjQDs+eKhV/r+R5J5mVeHdzNrR4RmpTGIWILvl+9w/ThC
         Z3zlTa9RJynCHrp+a+g68w1kBtSEm+wWxaC0vAnZGL07fedM7bjIO3WzA4nRm3h2MrAr
         obG17keM5ktz1VYxN97pWXCxnGauJXpW0N0AaU3twdR5basDUkV+7fSy67B82H/iQPgE
         wZN7HaIIATt0Heq1Zl4Oirpotcy0enHP6hSXKfvfdv9t7cAO09yaLWVlhXDcoshBcgP1
         l4VQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kDsrYnIjaADOr5JUJtVEENXX2T0onTTKs1aKdfz9ntwyBS4d8ov9MwyP8G0AXRta+130=@vger.kernel.org
X-Gm-Message-State: AOJu0YxseIS2jVdbKlqbW2Aw+ZlnWycQFxO1ntInnhBPdQjKgqcoVAZ3
	sDUnqcxF2Nu0nl1szSCyNkd/QzqzMQ1xdDfypJ4LRN9HmcrXWwM6Ba1B+0ytqAkG+w==
X-Gm-Gg: Acq92OFp3cz7cdWg3TFq3pQ7l08E0jRr7DfTbowO4rzePT7BCz/dtqj9mYi1oreQU8r
	a0EOFzNbor91f6ufORPzS/ubf7Mek1OATomvvJO9s2Hhv3h0kIeBtX5biVIJ0y2VfiPWHYQ8/jX
	fbGeGcPAdGGtIVvvw3v+jQQ8g6QP3HVBUnCJ/U6+9u7yLB/trxkHiynBACcorwRCUcKfTQIvfdQ
	9EQNp7DPsCNNpK4xXjYkeeXNN7xmW4v6ntaqhBpNdPOKP1UUzhe/b85RO07U5WneBJVXYRxSnml
	tWYNCzzOtgxhC2XcZ54bp8xEUsEmoiNhnT+0HQ3Y6G7qcNPQHsn5MAiCm/jfZSOSu0bx7kK43q2
	7la7aok/AHXe4lXWqNYKk/9d0QBj4EVHfkyEC7ZPGFbhZYajtDLrdEoDIB+BPtMs1Q9cdyOIeZ1
	gvmSk9t2WG0buoqF2sy28sJ2o1Io3rcQompXXMuNLyTqZmtcPOlSJaoy6IocdN
X-Received: by 2002:a17:903:24f:b0:2bf:3741:5b76 with SMTP id d9443c01a7336-2c665e34838mr1217385ad.3.1781382917803;
        Sat, 13 Jun 2026 13:35:17 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac7fbsm59623015ad.42.2026.06.13.13.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 13:35:16 -0700 (PDT)
Date: Sat, 13 Jun 2026 20:35:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Pranjal Arya <pranjal.arya@oss.qualcomm.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
	David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-arm-msm@vger.kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH RFC 0/3] vfio/pci: Hide and optionally override the PCIe
 Device Serial Number
Message-ID: <ai2-_nWEXPyHmmLJ@google.com>
References: <20260613-pcie_vfio-v1-0-09168188f3f2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613-pcie_vfio-v1-0-09168188f3f2@oss.qualcomm.com>

On Sat, Jun 13, 2026 at 11:13:35PM +0530, Pranjal Arya wrote:

Hi Pranjal,

> vfio-pci has no perm_bits entry for the PCIe Device Serial Number (DSN)
> Extended Capability, so guest reads of the serial
> number currently fall through to the physical device.  The DSN is a
> unique, persistent hardware serial number that identifies the physical
> component (the functions of a Multi-Function Device report the same
> value; Root Complex integrated Endpoints may implement it independently),
> so exposing it lets a guest fingerprint the host hardware and correlate
> it across VMs.  For multi-tenant passthrough this is an unnecessary
> host-identifier leak.
>

+ 1 to what Alex said here, QEMU / VMM should be able to trap and present
the desired values here, we shouldn't need this in the vconfig. Thus, I
believe this is better suited to QEMU (maybe this should be a patch to
QEMU?)

> 
> Signed-off-by: Pranjal Arya <pranjal.arya@oss.qualcomm.com>
> ---
> Pranjal Arya (3):
>       vfio/pci: Virtualize and scrub Device Serial Number from guests
>       vfio/pci: Allow userspace to set a virtual Device Serial Number
>       selftests/vfio: Add PCIe Device Serial Number test
> 
>  MAINTAINERS                                      |   6 +
>  drivers/vfio/pci/vfio_pci_config.c               |  98 +++++++++++
>  drivers/vfio/pci/vfio_pci_core.c                 |   2 +
>  drivers/vfio/pci/vfio_pci_priv.h                 |   2 +
>  include/uapi/linux/pci_regs.h                    |   5 +
>  include/uapi/linux/vfio.h                        |  18 ++
>  tools/testing/selftests/vfio/Makefile            |   1 +
>  tools/testing/selftests/vfio/vfio_pci_dsn_test.c | 206 +++++++++++++++++++++++
>  8 files changed, 338 insertions(+)
> ---
> base-commit: c425609d6ac4012c8bbf01ec2e10e801b1923a7b
> change-id: 20260613-pcie_vfio-48506602ec6a

A few minor things, we don't use change-id upstream and no need to add a
MAINTAINERS entry per test, we already have an entry to maintain
tools/testing/selftests/vfio.

Thanks,
Praan
