Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8E3F5BFD;
	Thu, 24 Sep 2026 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273158; cv=none; b=p3PVD0qJns7OJ4t6jF7pO+j2f9GABCiYT0gHWewTAXP86BT03lRWJwjjRjt1DO8NH/W4AgivwEQ9DMJQtzA4TCGvJgOa4b7Svg/fi/JFoVCga6fGZcGUoIM7/vYYVAcy49ZxKCEUMG0vskaaeYtvuB6CWxJ/puAtc/ma+Hhjjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273158; c=relaxed/simple;
	bh=FWFsNnSzhu1fiE5WtHS0RJuAvLpbRr/sFjwMzAyL1/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyXuk94FFeWIArSjV5kI+A/FX56w2J3Wm6Vuc5tDzknebOa3r6LV33w9I3MVnWbsoPhVuFy4/dLxHFf/aAoxbaF02mumULPoAKVvvs5z37yC91IoL760wCNjA1yCAO0GgPy3J6R1aOW+EKPUP3XEeZSX3D8N7lvatY1Db5g1eEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=LgvpoTU6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c133arE5; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="LgvpoTU6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c133arE5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E7941D00098;
	Thu, 24 Sep 2026 14:05:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 24 Sep 2026 14:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790273152;
	 x=1790359552; bh=LnOMZElOTssHpcgTXTzuI+vdxp3by2LgyupIgEe64/0=; b=
	LgvpoTU6OCuSsvOGNgKv4W+ifIhyoYKNdLeVIolJybTO6aztahAh6agUZw/2THtY
	jbVAfyInscEY/mST8IlJ5ZD5G+DwjfFh3n9NvYcxB0yT/pV53CdOIuBmFHOE9/dt
	a0IN6X/D7Qan+6FQIjK4ajpNF0090IrTCL34fE8hg7Uh0vDIxX9QAybuwwKY1sxN
	al0s9KNXO6suUN4hyI+Y/Vrthpr5m9Yftrk+AGoFU12y0QzczgEKoZHHGkFtx9GA
	sxuHt5WcpK6+w8sJbzK1jql+4xAsp9g/R/2hjvwLGeUcKMDHStTXEwTZoOvdft28
	hkwwa+/7r1LGnaoKYrU/uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790273152; x=
	1790359552; bh=LnOMZElOTssHpcgTXTzuI+vdxp3by2LgyupIgEe64/0=; b=c
	133arE5YXKbNp1SHN91JG9h6x9OXU60Xr7Z0DeRxE4K6EbRuyj/UMi5oUSa4Wds1
	JHukH66zouRUWV1jhYHRR/3r6scRvqivG0s1b34K6Gg60jARY4cUgN7uN8+1K4hi
	SxlcuyOlSalPQPjeSBYCDTT52mmeJtNwedE5Gmftko1IzIQOQjhpCj9/S9EqBJjH
	pXuUoMYm4O7XIb7VADk4qMJIgBEwrT6aDi9Vz6sqUu9eENZLSkg4Q4FaCEHSkiWV
	GFXF+76b4B/rULOQzJKWVqb4fkv7kcCEIZyf2TIEgj7n8IWcjJoWRcD8u/J56z+B
	nASqzH2F/g1zUSGqwRfnw==
X-ME-Sender: <xms:gGa1asiYYzcwCU4drX12PGo9ZDKeimJOQr2URByXX05GD9Z6WUYoWQ>
    <xme:gGa1aqNLSoEjajYYjw4uRzS9VDU6uVJ2a9FCibTZRgW0I0dUp9UFb4N7axpGg-9OU
    7jDLqEdV5vlh0r7TwVk-mpzIvTHjyxhvciVa8PU-EYlQa4UgfGgTAQ>
X-ME-Received: <xmr:gGa1ak-kksG0UUBZM27h3DslEX7X1-sQ5AUOSd42fjFhLZ3CIC4zs6NnViHjkQ>
X-ME-Proxy-Cause: dmFkZTEcpyhqwH37txrXJNJQlslykEF3owGmeiGtpJKBmGvar0NgW2vQqDs6r4dxYAP/E3
    D9vSKhCe0U+nc9+tFbW4yEgeD7qkfQOxuS4eAHHzj11Li6x/R+xBVhyz5LVz2s4OPlPYsv
    odGoxcqdmiIJpTQLrmbssMJ33uO44/ksB/2KOH7OQpFftF2Caa/Ltj80nhm4ENAgX6ClBZ
    7xwuraWb9EYOKmcgClXEI9N1+/oTiZkbBuBvXHuFC/7CNj5JYItYog06cOv7RwUJVyacOS
    KgFIPujM1kn5Cy7vkWENJwwuvPI6uubu4WWNFIZiwsjB5oH+AudZhJwjj3e5p1/dU+fRl2
    qfhWwLJG00Zpe+SD37YT5GAQ0u0c3cF8og0jPPRefz2VuN6vg/IyN7RfibHj1jNTAHTgTK
    z7MDuxtlJfzhKafTTC3gB6lybmttRnHPwHd/WNESmnlUI0VdUn1HmHYkf1vTiPOQ6kkTCu
    p/WOqBkVKQiUBaJkeGmR5biXapmFkK0IAETFt0QMNFDxi2+/GFU3mmz1LH6QclWecLtK3t
    asR9MEP/ANEE4pHOSfGAvWfDSCRdiDXbm937l2bG9y26gIFWmwH5kj1JFQBWyfHdtrD0+P
    u5tohWkdp4XDS/yNdhIdwcvgUbn0S+qESB4FEs82/qJ9Hgo8JrHeLPu5Vn3Q
X-ME-Proxy: <xmx:gGa1ajdApqjRcM6PG1sWhF_oRpEO3NgggHmZiqCyWnpM2_no79pvuw>
    <xmx:gGa1aryh4kPhRAVkbK2buy7V5K1S2UCtkVy-NpePYVbylmKkyZTSrg>
    <xmx:gGa1agKaOy0FCqjKqg2GVq-AA0cSkXTeh9OsM3jgvorkQ6kB-DV-bg>
    <xmx:gGa1alEUI5IVBe_RYibsXrxy-1QsiHXtdKTXXldXQDuE9zoL3MqVNA>
    <xmx:gGa1asH3f60Yle92vwzJ5HjK5tDVc_gSKh2b4x-e5-T1WhInzAi9i2hD>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 14:05:51 -0400 (EDT)
Date: Thu, 24 Sep 2026 12:05:48 -0600
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>, Alex
 Williamson <alex.williamson@nvidia.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 2/4] vfio: selftests: Verify a failed second open
 preserves the vf_token
Message-ID: <20260924120548.75097986@shazbot.org>
In-Reply-To: <20260911170429.1642480-3-alex.williamson@nvidia.com>
References: <20260911170429.1642480-1-alex.williamson@nvidia.com>
	<20260911170429.1642480-3-alex.williamson@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hey David,

Ping, you suggested[1] this selftest, I think this series is only
blocked by an ack here.  Thanks,

Alex

[1]https://lore.kernel.org/all/aqHdXvfcfCJbLajM@google.com/

On Fri, 11 Sep 2026 11:04:25 -0600
Alex Williamson <alex.williamson@nvidia.com> wrote:

> The cdev path enforces a single open per device and rejects a second
> bind of an already open device.  That rejection must happen before the
> bind can mutate state shared across opens, notably the PF vf_token, so
> that a bind which cannot complete leaves the current opener's state
> untouched.
> 
> Add a regression test that binds a PF with one token, attempts a
> second bind of the same PF with a different token, then initializes a
> VF with the original token.  The VF init succeeds only if the second
> bind left the PF vf_token intact; a regression that clobbered it to
> the second token would make the VF init fail.
> 
> Additionally add a second separate test that enforces the -EBUSY
> errno on second open so that the vf_token clobber and errno testing
> are independent.
> 
> These hazards are specific to the cdev/iommufd single-open path, so
> the tests run only in iommufd mode.
> 
> Suggested-by: David Matlack <dmatlack@google.com>
> Assisted-by: LLM
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
> ---
>  .../selftests/vfio/vfio_pci_sriov_uapi_test.c | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
> index 19d657d00b75..b57e4498443f 100644
> --- a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
> +++ b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
> @@ -157,6 +157,63 @@ TEST_F(vfio_pci_sriov_uapi_test, override_token)
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
> +	 * token (UUID_2).  Return value intentionally unenforced.
> +	 */
> +	device_init(pf_bdf, iommu, UUID_2, &pf_second_fd);
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
> +TEST(failed_second_open_returns_ebusy)
> +{
> +	struct vfio_pci_device *pf = NULL, *pf_second_fd = NULL;
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
> +	 * token (UUID_2). This must fail with EBUSY because it's a second open.
> +	 * Previously failed with EINVAL.
> +	 */
> +	ret = device_init(pf_bdf, iommu, UUID_2, &pf_second_fd);
> +	ASSERT_EQ(ret, -EBUSY);
> +
> +	device_cleanup(pf_second_fd);
> +	device_cleanup(pf);
> +	iommu_cleanup(iommu);
> +}
> +
>  static void vf_teardown(void)
>  {
>  	/*

