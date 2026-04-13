Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC12361657
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103724; cv=none; b=Yv3lKqVZDxpZULJGgfUP8NlyKDG+E20GyMyAbrF+W9psy8r5w1dmjEaNiGv1Q8dTqSM919oZto+Sq/xCvP9ZqhNHV1x6M+0mLR7MNeR59x+GwLx9jX0dkTIgyfozmaDmeOxKTcgeDY1iOFlT9Lq1HY93fPq0iZsx38LIac5Py8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103724; c=relaxed/simple;
	bh=sTTBFXUQvlG7va6ESRKWpJsoua7hOEDkjIePlaumAi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E15HeZVZqbBeP0RfRwrIkZoLK7mX5YpCtMkg3SUasD4FjVcPAAy7LocZomvk/P7s8d39xpMLRw84hH5rKwgONmuimyJZwnAcK0+ob0rPnwLMZV5HjdmPTKKpmrB4puoUBNoqKufmDIEpxnC5tpOa02D3eMK4XgU7zaxpm9XSng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=otYht39s; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otYht39s"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1270fc2bdf2so38379c88.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 11:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776103722; x=1776708522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihnbQ8DAwZ608jSyPeNkvNqcC3UO+2nLmbAoi4r5+eE=;
        b=otYht39sD9AvSFujZ3I/39+EosuPsYltPCZJy9O/XYrgQHNc9QHvlJIZDpgG7NIPCF
         EAfMgBcmENkz+cMA9czguCw8UHg5P05I+8/AG6kM6MfwukCbeq89gkMWW9CTZmVfSua0
         tZQ3JnIGJg0jSzSdYo8jatpADuqkTYUpCnX+Stwg3EVPVzX/vorL5/8haYeH9BXAQBSX
         QhXqvnUCt/RXf3J5NnrJy6MprppiaX7UDcl5N4ZgvLcWtAz38CHpUA95ZoKFTtT9ykHL
         svamRMf+fAgxSf+vVVQPZUYAFvAsSzd7HLBXwMqD52499clSVLpTa6ujwc+BoKzQarjk
         zGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776103722; x=1776708522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihnbQ8DAwZ608jSyPeNkvNqcC3UO+2nLmbAoi4r5+eE=;
        b=Wn7HVBcIbMQPIhPDaG0aED8z1ihj2Pk8kY8/g9dJJYYc0WwSS6EUN4t8f2pD40uQ5y
         w9RtcGZZdq4Ldr44nzykH9HJpdlpN6xhhTKxkxQ8kZOwcVtEgWrAMeWZJPt4n3HIKgd0
         +e3vjcaB+Y8MURKTPg3rL7DOQoY/iB8ylWV+4A5mDA3rm5v4Hf2yzsESfuotMgh1j+yy
         ndZkbWa5L8MIAmMr5t8wYeVptc2cGiEi6Mxl944etWYM8bChI+u3z/QNjIQQlEVrKG7X
         5zoHXvUBkdIH94CxMOmho5lxu7ra6qZ9Vj5P214CYlIdYy0NJhF1iU6hK+RQY92jKsoL
         p/3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Bc8umieQd4wuO7LuHbXwrPio48+X0V2EqTYKa3yupyxiTB8Xa3aCdI2vywAQ9ShAcSjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJLZbavTCpyltCGP3mF/rmVA0t93Pi4utfAvFRZctppszAQyM
	81iFAO1sAEbMo0iNnDOfS9LrkSl22rJDts1dc4pbu58yElOgGByfHjWmFxK0MYHMig==
X-Gm-Gg: AeBDietbTHwfrG68xDl1s5ghKozRB139jQXxIKotVeowD3KU8M6wttLDV+ivTozQ91N
	9zr4Rh26wpKsIZ6O8V2bFZkKC2fnV/bLZVwnyaMtp49zTtU4XY+UkPrFznQV7CSaOsjZapMssWM
	jsvAprsKqlopgUfmw/VQ8ltYLcW3iJX7vtZ8u4cflDlzNypXuj1Xv3LWowwkLJ00S4QOT+tPVWm
	+3V99I8Foj81sBvwei5vWB3U7reOYPUbNiF1R4wmKz8OXefkXL7NVME0YhZIlMVfz8DMU/uQcLW
	KQrPLEDZnuFNmW2MI5GjB7LFu/I41s3MhFxF5XOwQQFi89AZ3az3mzx6172NDXRQ3UlUtZOtBBE
	lyxtjquFgmoKMK+c/MiHZy50Yjd90MTupeB9lyjZf50ttwKHE8SMJQ/XejecSFjPZrCDQA6Sdv0
	e2j+50QqyYcYKf2XdlHR5jokooRtltFo113JeY/ZqjV3p+9G8h8f4DH7JLjVR93qqUBOP6Ldi24
	cBy/rgP
X-Received: by 2002:a05:7022:48e:b0:128:ba6e:f809 with SMTP id a92af1059eb24-12c28ea0f68mr695867c88.6.1776103721868;
        Mon, 13 Apr 2026 11:08:41 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2c09sm20302457eec.18.2026.04.13.11.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:08:41 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:08:36 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
Message-ID: <20260413165308.GA3034974.vipinsh@google.com>
References: <20260402173059.1018805-1-rananta@google.com>
 <20260402173059.1018805-9-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402173059.1018805-9-rananta@google.com>

On Thu, Apr 02, 2026 at 05:30:59PM +0000, Raghavendra Rao Ananta wrote:
> diff --git a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
> +static struct vfio_pci_device *device_init(const char *bdf, struct iommu *iommu,
> +					   const char *vf_token, int *out_ret)
> +{
> +	struct vfio_pci_device *device = vfio_pci_device_alloc(bdf, iommu);
> +
> +	if (iommu->mode->container_path)
> +		*out_ret = container_setup(device, bdf, vf_token);
> +	else
> +		*out_ret = iommufd_setup(device, bdf, vf_token);
> +
> +	return device;

I will recommend to return the error code and pass struct
vfio_pci_device **out_dev in the arguments. This seems more natural
compared to having a last argument as an ret value which is checked in
the caller.

> +
> +/*
> + * PF's token is always set with UUID_1 and VF's token is rotated with
> + * various tokens (including UUID_1 and NULL).

Nit: s/UUID_1/UUID_2

> + * This asserts if the VF device is successfully created for a match
> + * in the token or actually fails during a mismatch.
> + */
> +#define ASSERT_VF_CREATION(_ret) do {					\
> +	if (!variant->vf_token || strcmp(UUID_1, variant->vf_token)) {	\
> +		ASSERT_NE((_ret), 0);					\
> +	} else {							\
> +		ASSERT_EQ((_ret), 0);					\
> +	}								\
> +} while (0)
> +
> +/*
> + * Validate if the UAPI handles correctly and incorrectly set token on the VF.
> + */
> +TEST_F(vfio_pci_sriov_uapi_test, init_token_match)
> +{
> +	struct vfio_pci_device *pf;
> +	struct vfio_pci_device *vf;
> +	struct iommu *iommu;
> +	int ret;
> +
> +	iommu = iommu_init(variant->iommu_mode);
> +
> +	pf = device_init(pf_bdf, iommu, UUID_1, &ret);
> +	ASSERT_EQ(ret, 0);
> +
> +	vf = device_init(vf_bdf, iommu, variant->vf_token, &ret);
> +	ASSERT_VF_CREATION(ret);

ASSERT_VF_CREATION() name is confusing, as it is asserting both success
and failure ret value based on the variant passed.

I will recommend to rename it to ASSERT_COND_VF_CREATION(), or, may be
create a wrapper function to check if current test is a UUID_1 variant
or not, and then directly the assert needed.

> +/*
> + * After setting a token on the PF, validate if the VF can still set the
> + * expected token.
> + */

This comment seems incorrect. VF doesn't set the token, it just provides
the token which is set on a PF.

May be a comment can be "After closing the PF, validate VF access still
needs the right token.

> +TEST_F(vfio_pci_sriov_uapi_test, override_token)
> +{
> +	struct vfio_pci_device *pf;
> +	struct vfio_pci_device *vf;
> +	struct iommu *iommu;
> +	int ret;
> +
> +	iommu = iommu_init(variant->iommu_mode);
> +
> +	pf = device_init(pf_bdf, iommu, UUID_2, &ret);

I am assuming because of this, you cannot move device_init and
device_cleanup calls to FIXTURE_SETUP and FIXTURE_TEARDOWN respectively.

Can we just start this test with device_cleanup(), then do init with
UUID_2? This will allow to reduce the code in all of the tests by moving
things to corresponding setup and teardown functions. WDYT?

> +
> +static void vf_setup(void)
> +{
> +	char *vf_driver;
> +	int nr_vfs;
> +
> +	nr_vfs = sysfs_sriov_totalvfs_get(pf_bdf);
> +	if (nr_vfs <= 0)
> +		ksft_exit_skip("SR-IOV may not be supported by the PF: %s\n", pf_bdf);
> +
> +	nr_vfs = sysfs_sriov_numvfs_get(pf_bdf);
> +	if (nr_vfs != 0)
> +		ksft_exit_skip("SR-IOV already configured for the PF: %s\n", pf_bdf);

Why would we want to skip if VFs are already enabled. Just
set it to 0 if it is already there and set it to 1 unconditionally after
that.

