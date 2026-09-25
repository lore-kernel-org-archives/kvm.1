Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7D64F3934
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372196; cv=none; b=HlPEDy8fIqSUMV2sDHkxWmBAqnRKM6lUPnRo1OozIUTIU4g7qsGTzUhJwaebG49XASlpuqwAS/gIXdKEnIPdhSl47PxHDmmc8P4lFo9LSDf/6QUWS/hNr3Jzb+HUo76f2BCc5hNXu3+KZpRjABTon9bLObSPNwd+TUno4WVWexM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372196; c=relaxed/simple;
	bh=Qg02+3HjYm49TdLiEn+JIdhyjdhQ/eREobgiVEWZlZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i46p6lyQZFhpRZOBDuxmdl9x9/M5RLVW8Yj/xU/rFMxYqdqMR9ps2k9cM3zMYQcDZ78YuwMTxx6SEFrzQCpZdIsvRv/kRqSOuEjzuQnU7y4mWctYNk3FCtbfoU+J9xNxKgSWmeYiWV07YtZ1RCr4q5KjWS1L79+z8cAzyapgUFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ar5bsMtf; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ar5bsMtf"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb751so722085a91.2
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790372194; x=1790976994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YSyxHGO17Ov5FdscmoMh0OgHBuT9W0YP7biFjXpFh00=;
        b=Ar5bsMtf8ST8b/oZBQubVQL580lG5LtqZtct1z4pQW6/RgrVK7Pc80qln2bbFr1QxJ
         dFH4P1rhpY6e26sZWmSHk4qzMC19/h52Wr+f1kqpvEEYGTOz2k0RSAvFYZIKzxF+US/a
         SkVbC78aqpahwVI5bU75Cmk6E33/Zd0vk09x45F31UKLWGW/19liWCQw8GITmuCkOz3F
         8yzwEuCKy1o0VxXIoV5ANrQ/dKQJObaGFbcfhcS4+8X7dQcub3mU5R+kgl0utu7/lW80
         toSg4KQdS7f3nBOkAbweEfrPS427Ef7kHZzvCO50MOKxOAIOsAg2Q5IsxWBV8yFWkN84
         ZFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790372194; x=1790976994;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YSyxHGO17Ov5FdscmoMh0OgHBuT9W0YP7biFjXpFh00=;
        b=uZZZjkNnnPHZixgE2FspDDuqknI+SOm3gFb9WrtK/9lHMsfw5W7sZdF0xYL2Z9t6Fn
         LxUxi1DMhXOIFRSSElgKRIfxuw7ZCx0pUbfXUuA0qBBv0FuLqQK1RGbU4Uh6GtAUI6lk
         aZ+B7BktFTCILvdCjyfgTW3abj2v3uhPHyBqSRGhuQxbDrEi08ba1lDvTHfeAfIamGd6
         ABrRDDPtgt7qpf9EFFHerWFsZFczib2AIxEv0nbZPCGubIq0/483gAbzQIcdSk2KmOSB
         aVNtxOEc/i8sdEHOlexl1urBmqL2egmKbQA6uSfzchfAtl6SXwSYT2RpwDzpfJm1Qs/o
         GLjQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2hUo9FL2PzHmw9Bt42MOntc7Yj/NybiPk+C30x7h7biw+NF0fYaNKFcO6Ho/lGM39zd8=@vger.kernel.org
X-Gm-Message-State: AFuF++nW13kyaVeXs1j5WD2+MjZ9Tz84Vzh1dvL5X2OPPh4uOZ8boOmf
	WJGvCL4IgBsBql73+pn471UXZ/hPy3x7xoMw5Yr2fiU1wg9rBaucBvmIcPXhxrZpIA==
X-Gm-Gg: AYBFou1WxQx3dRze8Tyq9FtstT3LL2wjz3C4Ip5k6sMiCfinjOG6o7DmKdaO2BoI2zd
	joUiRRhvhR/sb189waWyZjuCNHle2cjrubxqVn8OSSneJ8i4HipBESowxXOMIXBcax8DFpdCxo8
	KvX7o6iFWdod4csDgooyL2NQQLiq2sMwCrUxMs8gMtwz530M/Hy5iU+ew9DUZbXvIdM1kf6+hqm
	B7xAjz1XCPxAtcMk55zzfTJQPP979ixqoyMyJcHn62T5ajRC4clR43c99w/3LAjNK6Q8boFO5pd
	Q7eZhrW1+IicPfLf2ZaBMJ4AXKEb1fUqv/q3XgagNylQBrW/RWNyms650zGE744i14QEYhoaAkX
	QvcGKTaAoqUeQ7mxgxcASPZeognSsuwscroqjVk6qNPkqThirj1wXLK8gb+I5bXVUVkKB7Y3qNA
	A7iYJk3KGZ8QTDuV8OcGG/1DLLB80qcPogm1Z6oVCRs/T7Lzi5MuxFGMncC6Q517GRBGlKMgPax
	gZqpSxVc122m7OG4hCduBsxtGKncx7uatv7ZVwJd0syxIRk+/8=
X-Received: by 2002:a17:90b:5847:b0:3a0:b40d:827 with SMTP id 98e67ed59e1d1-3a0b40d1ebamr3431836a91.0.1790372193240;
        Fri, 25 Sep 2026 14:36:33 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec5d0sm13794932a91.4.2026.09.25.14.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:36:32 -0700 (PDT)
Date: Fri, 25 Sep 2026 21:36:28 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v3] vfio: selftests: Verify a failed second open
 preserves the vf_token
Message-ID: <arbpXGSPO1jqNmAA@google.com>
References: <20260925205134.3505611-1-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925205134.3505611-1-alex.williamson@nvidia.com>

On 2026-09-25 02:51 PM, Alex Williamson wrote:
> The cdev path enforces a single open per device and rejects a second
> bind of an already open device.  That rejection must happen before the
> bind can mutate state shared across opens, notably the PF vf_token, so
> that a bind which cannot complete leaves the current opener's state
> untouched.  Before the fix in commit 258ba46543ab ("vfio: Reject a
> second cdev open before mutating shared device state"), the second bind
> mutated the vf_token and only then failed with -EINVAL.  It is now
> rejected early with -EBUSY.
> 
> Add a regression test that binds a PF with one token, attempts a second
> bind of the same PF with a different token, then initializes a VF with
> the original token.  The VF init succeeds only if the rejected second
> bind left the PF vf_token intact; a regression that clobbered it to the
> second token would make the VF init fail.  The -EBUSY errno is checked
> with EXPECT_EQ() so the clobber assertion still runs if the rejection
> returns a different error.
> 
> This hazard is specific to the cdev/iommufd single-open path, so the
> test runs only in iommufd mode.
> 
> Suggested-by: David Matlack <dmatlack@google.com>
> Assisted-by: LLM
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
> 
> v3 following v2 from [1], incorporating David's suggestions to combine
> the tests using EXPECT_EQ() rather than ASSERT_EQ() so that we still
> test both aspects without duplicating code.  -EINVAL reference moved to
> commit log.  Remaining patches from [1] applied to vfio next branch.

Thanks!

> 
> [1] https://lore.kernel.org/all/20260911170429.1642480-3-alex.williamson@nvidia.com/
> 
>  .../selftests/vfio/vfio_pci_sriov_uapi_test.c | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
> index 19d657d00b75..87f42aae340c 100644
> --- a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
> +++ b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
> @@ -157,6 +157,41 @@ TEST_F(vfio_pci_sriov_uapi_test, override_token)
>  	ASSERT_COND_VF_CREATION(ret);
>  }
>  
> +TEST(failed_second_open_does_not_clobber_token)
> +{
> +	struct vfio_pci_device *pf = NULL, *pf_second_fd = NULL, *vf = NULL;
> +	struct iommu *iommu;
> +	int ret;
> +
> +	iommu = iommu_init("iommufd");

nit: This should be MODE_IOMMUFD

> +
> +	/* Create and bind PF using UUID_1 */
> +	ret = device_init(pf_bdf, iommu, UUID_1, &pf);
> +	ASSERT_EQ(ret, 0);
> +
> +	/*
> +	 * Attempt to open the same PF again and bind it with a *different*
> +	 * token (UUID_2).  This must fail with -EBUSY because the cdev path
> +	 * only supports a single open per device.  Enforce it with EXPECT_EQ()
> +	 * so the clobber assertion below still runs if the errno differs.
> +	 */
> +	ret = device_init(pf_bdf, iommu, UUID_2, &pf_second_fd);
> +	EXPECT_EQ(ret, -EBUSY);
> +
> +	/*
> +	 * Attempt to initialize a VF using the original PF token (UUID_1).
> +	 * If the failed open above clobbered the PF's token (i.e. updated it to
> +	 * UUID_2), this VF initialization will fail.
> +	 */
> +	ret = device_init(vf_bdf, iommu, UUID_1, &vf);
> +	ASSERT_EQ(ret, 0);
> +
> +	device_cleanup(vf);
> +	device_cleanup(pf_second_fd);
> +	device_cleanup(pf);
> +	iommu_cleanup(iommu);
> +}
> +
>  static void vf_teardown(void)
>  {
>  	/*
> 
> base-commit: bc78c90728cd74d1c7335fef786fa51968bdebad
> -- 
> 2.53.0
> 
