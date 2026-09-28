Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EDA46983F;
	Mon, 28 Sep 2026 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634533; cv=none; b=g6uD8V66vSAYe/LxFrLbTq0VMX4Nff0wrWB7Tuou9gChkJ4dUsyr34upcB29+Vg+CknJEXpGDV4iHXBuSO1zTUoEBykRgoiUHJUSu3XUJRDhXfUcncbvpVnrvA5y9FIjhhYTnh5hefckwIJ9jJ0MV6UAMNNYHT7WyLgCr6B5XQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634533; c=relaxed/simple;
	bh=jBMb3L296c0O+OjW5SKCRhHUGPAT24o3WEYc6pidZqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeFQBVoKgmvxZhw7WkGNa4PgpPeK5kSGDDh8vZfKxTMUEXodyh9UsQtLqcZfApVJTpt+bdijT9LBRAolyA+QaBezcl0NEyNb1EU0mczJP1U5sJNNmdlemSwoRpMqbKxgdWauFd275hAuaqcvgZYJ//O+lJahD8HEfBvkg0QMwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=fhJkH05o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v84oGVZ/; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="fhJkH05o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v84oGVZ/"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 28B421D000F5;
	Mon, 28 Sep 2026 18:28:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 28 Sep 2026 18:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790634531;
	 x=1790720931; bh=NUzzglyhr6LSnVy/4PTW7bzB6yZwtCHGNUPCejsAehY=; b=
	fhJkH05ok1woYsovbmlM92S0xhvJIOHR0nvPutgPz81rVsANbS17uZWZ9s+axVph
	1Tq9ELhbPqQg0JSFznw80MtjGljtbV5Al1/BOUo6Z+9wHUpKV0uJigG+4pBQ2HM3
	U0iNkQcSJY7xt1x8qCF9yO6QwpkonqbfiTONWYu6KjS5kqY4iztRHuQNj2mpsmI2
	NyuwuSqnjE+sZ6t+wD1fQcKy6gQ4tL+hkhFnN2byeEpYtlizjHPGt/PTnd5FaHvk
	E8ZZXoeBVp9iNVaTdUB0PQPsreZ7N+AsWpepQdgI4b5rvca37H0Py/C+lqBXL+MK
	Rk/gLZ1cCLxXBxlddsx2/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790634531; x=
	1790720931; bh=NUzzglyhr6LSnVy/4PTW7bzB6yZwtCHGNUPCejsAehY=; b=v
	84oGVZ/lB7MJKmFr72jrfCusu3R/Or7zgwvkxygyKT+NZXOT06Ex9vs2ChE4sziZ
	QA2icfOcr2WTP26rlvLjuJbiTnpNB5E9PaGmF9T7B1T42xx1aSLsVaDs0IEkeh5y
	AYpOyGBJtcwjjxjpUOB7qzrxNM000Pn5+UiPpUDMyeKPY0KyrenH9VZlAjW02JD0
	SBApAGsvPYsLdyUZ0K+f3qfZKyClsWbAzZ6gZTCDvkrkSRED55eetbDSfK0veiBi
	Gztmt32ONZXcJNYfSJj2s6is5InXP7hrG9nzJ7iwW5ihpnByMNz8LXC2r3n/xCVW
	Q6tPMgYhIGcaTsIdupAjQ==
X-ME-Sender: <xms:Iuq6apO4C2g7xkgP-685zqUJwU8WYuTK2KUOXSg2aw72xIv2Y19OaA>
    <xme:Iuq6ahI3lJ5rqquQ1lNwuUjX0_7OuHuy3uTqW9lSKZ4OAsR6f_ld9vt5dY1faOxf6
    nnYb8jZZF6omggG6vKb8UMCEB_GeKT5Md9IrApsQ7WEpsrwuW_VG5U>
X-ME-Received: <xmr:Iuq6apKc5e_M1EepTZBFBQsMZdCCCUoynh_sdUXd_ub0PMDDHAFiBFBdhcxDEQ>
X-ME-Proxy-Cause: dmFkZTFjkexj7t9P8sudggapxulSyVz1RZc2pvM3/cyjddeDx19eMQiocZet65GSKkqAn2
    tTJdDmDhWxdtjM2+0uDTlmsqOB2+3l5ra8RhDVZZQuuZAc2jhR7UpmEEwzergnJLj0uxJc
    RJIdgu+RNcx1w5QOWkm6LCqxApocTGNG2VU5tez/SHCNcbWxv2QtvylFZcPnI53nop6KHc
    1FaYu+1ui4cRMHsUH00TwDB4y29mT88Ft2cCqJzXAt7sOZQlB22vFaxRviF4lEvLUbhRku
    RR7Rje2bdC24gYdtYBSh3Kr5YLqgbZS7iy0OeOorws9kj5BGlq0MgscXwJkEZVyyhot4pA
    O4HNxsCELSiXnrNvsqU9RcP1Not/uTzQLPToclgZDC14ytnYBmJXfoAG6zUOxHa4F7SogD
    SaGXuvpMaoBoUR7wY3nEiiplLv2CVaoVXeH4qEAvMGGDYI6UbkeliPAmFwHlphnonZgB9+
    CCGjQFedKAiik2RbuvoRbcjWoipvIGjikrXantn7sWMA15lxzAwd+1XdaxdhHwAAZSyDjn
    o6LrdCiGPks29sxNkx8rHhmKE2aSdQ7Vud5Y8Rx3JQBrbLmWoH9yyfLgxNsvw/QImDkFPN
    3d5jjaIlleTV91VKD+kxEdXzlAhq7mmCcgYh+5M8Z1JT619s5fUh+VVCSnnA
X-ME-Proxy: <xmx:Iuq6ar4myuQmu0RpOjn_oPYyC7degT03DvKaxyx-lfQ2jMPhlxX-Lw>
    <xmx:Iuq6ajcTvbYzLDTkNCTDBBbt_qk0fXrDRKhXu-CdhmiNWneoqxzojg>
    <xmx:Iuq6amFtlp0KR42fxCGjsl_Bmdhkr57DBJ9NZ_73X13AvBFAUkorbA>
    <xmx:Iuq6asRtSkCShooC4QZtfea9Z4gea0_qQetAaRClVRxmaxr-3xfwww>
    <xmx:I-q6an_lY_7ogsD1_rldGXiteswAhuukSOB5qabQFc3u8dKRZUDQZ4D1>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 18:28:49 -0400 (EDT)
Date: Mon, 28 Sep 2026 16:28:48 -0600
From: Alex Williamson <alex@shazbot.org>
To: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, David Matlack
 <dmatlack@google.com>
Subject: Re: [PATCH v3] vfio: selftests: Verify a failed second open
 preserves the vf_token
Message-ID: <20260928162848.72f6c716@shazbot.org>
In-Reply-To: <20260925205134.3505611-1-alex.williamson@nvidia.com>
References: <20260925205134.3505611-1-alex.williamson@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 14:51:32 -0600
Alex Williamson <alex.williamson@nvidia.com> wrote:

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
> ---
> 
> v3 following v2 from [1], incorporating David's suggestions to combine
> the tests using EXPECT_EQ() rather than ASSERT_EQ() so that we still
> test both aspects without duplicating code.  -EINVAL reference moved to
> commit log.  Remaining patches from [1] applied to vfio next branch.
> 
> [1] https://lore.kernel.org/all/20260911170429.1642480-3-alex.williamson@nvidia.com/
> 
>  .../selftests/vfio/vfio_pci_sriov_uapi_test.c | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)

Applied to vfio next branch for v7.4 with resolved nit from David.
Thanks,

Alex

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

