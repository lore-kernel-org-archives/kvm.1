Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A043859EF
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273442; cv=none; b=u7HQsroWfC9BfUaRSTD1gBKsFRETNUMt5O3TtuGtOxd9/+UfN+yGm0MSLrJ2sJb0oEPJDTTEwrVp+JOhQ7bzoY3ypfI/LBKEUtucl1UoaoVq/htc2Z33bowieerKpFNl+O5koeHVRHP5ahs6XKebfJtJFJDPRGPHQNLCD6gla30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273442; c=relaxed/simple;
	bh=6db33Ofib6t/7S+DBBE2IdfiVvBGcJuuy7Yvv4lLqAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkJGuGJBSwGMzIhyP0EMXW5AYTIWagPvf6SW3aWR8xknTpIy5yWrLXp/GC2Tmf7JkQgCG3cUTlVpRFEOVrH3TPgHCpuk29jTp+SAfVuXh8H1C/3Rn+ZF5LNFi5c8Vbe1tc3QUK9fWg0hnUBbESqxINdR0DloJhqY4x/Ae8hjkbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=toGcJqPi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="toGcJqPi"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae49120e97so35635ad.0
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773273441; x=1773878241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nXkXOvVeSPQRP9S+l1PKLOwx/zmlev4zOCLTWr0JUTw=;
        b=toGcJqPiHGeIgepiXcilBvvMtRNy4IM9wwmYEieFIPUkqG6eNs2ZOhZkyI/7oYvYl6
         FTNWb+KuwcRe+B005FxqqpZWW6gXq0zMsFJooj3IP9Y+a3xKmYmnu2bz/5KcqmHy43VB
         LF8CL+3rD6Wu1R04as6OQVDrk/wIJvgGdrlzeRQrKXS0LofMGnizFyWhQbP2roqjZtWg
         UIXF4dGkvIqYPdnx11OE+AmRLp7nkQXjiHGbrxLaI4Jb9Bgi5DZXE1YHP+4FaUG890Vz
         /nM9e6RRLoiToDj+N5uWIfdpfmYnub2f4d+YgXiln4DODi4jLyls5/dxMOI7MJmQEbei
         90TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773273441; x=1773878241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXkXOvVeSPQRP9S+l1PKLOwx/zmlev4zOCLTWr0JUTw=;
        b=IV7DWn+t+4IoFm02kUjlEQIwPjJLmwpx6EIxzGi7DQRRF8Ykn6xvRqd4b9LLUF5LsK
         TVsMPD+YIT5NHVhqikqyZh4zd1z6ZjWU6EzKFUjInu5S9hpMtAsyRa9kihj8Pki5EFjV
         e+A0K9T6bJ7rqMYKe19zt726m+hc4PC9cE8JHVD61z7m7n+P9x64hp+1dezf4xaxVH/w
         gvXVXpMhZoG0FyQ/bKKdoeBGYkjpNy5D+EgB05rq6NujDkXBNmrI/3AKnc5+zfrnENyw
         bTdwDH7LD6I1xVa+uLEhK+r6YAgDAG1tZvr5xUCvHNBHz7lPqkVgJPMgyHij6GUDZ+uY
         PNcA==
X-Forwarded-Encrypted: i=1; AJvYcCXiYRMC0bmXxRoi3eflSzELTEmwmMvOmihSznHeH6i4rEL8JjsedJNdJq9yz1QBLdNbLJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqngL7Mr6pB6tP0lpPRbelzY/231cc09ix2lu407SQTGk/mbkL
	VqCCglH6tGElD8aJgghcvWd5FIVnHvrD9hhMlKI+Fjob3Sirxiv5tAK+1tb72kgSgw==
X-Gm-Gg: ATEYQzyi6HzB7IdSfu9dtrNwl3xqBDJUtUiEY6uQRjmgl+Sds/wwzG2EnCZVlqk4DGF
	VjPlln6lcwa19OxgUMomlxJECmnlBLGb9+eH1mTzUc4C26gaF1Q7DAsS40eACj6i6Ygx4Y4+LRO
	MqEPHTaq6TSVqPMJ7htNv4tFUWso9nu26KMLI6zkAgHIS9gsyJeiQNdmonWcRRQAjIFV8X+g0/I
	6xHTwk4LmPO7gIcRb+ex3gRsx74Zuz6TnEsHX4e9XQcdXBQQhMYpWrzeQ9E3AJKJgVGvG1ksYXw
	Hg6Iz2ManGkS+KPPELEOP4XXIHBtCT0KCG6a0sYbCtyw5JyQi4lSc//Kug+y2nZMUSYVV1ropl/
	W4XOr9v1qrHEz2LGGG1KvaqAmPEkaZLKlaj6hmxbTEkvKGMw5fsJdLeB8dgvlhNrqzOK0OhLLga
	T7Z0/3tOaKttOeAWo+lhA6t8iBFx4ShSHo8NIwRDKgax0pOGjogB5w28/F760u
X-Received: by 2002:a17:903:94d:b0:2ae:507b:6f9e with SMTP id d9443c01a7336-2aebad67f82mr1312895ad.8.1773273440251;
        Wed, 11 Mar 2026 16:57:20 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738422esm784221b3a.55.2026.03.11.16.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:57:19 -0700 (PDT)
Date: Wed, 11 Mar 2026 16:57:15 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
Message-ID: <20260311235715.GA2738066.vipinsh@google.com>
References: <20260303193822.2526335-1-rananta@google.com>
 <20260303193822.2526335-9-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303193822.2526335-9-rananta@google.com>

On 2026-03-03 19:38:22, Raghavendra Rao Ananta wrote:
> +static int container_setup(struct vfio_pci_device *device, const char *bdf,
> +			   const char *vf_token)
> +{
> +	vfio_pci_group_setup(device, bdf);
> +	vfio_container_set_iommu(device);
> +	__vfio_pci_group_get_device_fd(device, bdf, vf_token);
> +
> +	/* The device fd will be -1 in case of mismatched tokens */
> +	return (device->fd < 0);
> +}
> +

This is one is exactly similar to vfio_pci_container_setup() except you
are calling __vfio_pci_group_get_device_fd() which doesn't do assertion.

Any reason to not create __vfio_pci_container_setup() in the library and
just write assertion in vfio_pci_container_setup()? 

> +static int iommufd_setup(struct vfio_pci_device *device, const char *bdf,
> +			 const char *vf_token)
> +{
> +	vfio_pci_cdev_open(device, bdf);
> +	return __vfio_device_bind_iommufd(device->fd,
> +					  device->iommu->iommufd, vf_token);
> +}

I see these are also similar to the code in library with some
differences. May be we can refactor library code and reuse it here.

One option can be to split vfio_pci_iommufd_setup() in two parts where
first part is what your are doing above and second part is attaching PT.

> +
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
> +}

Same for this one, vfio_pci_device_init() can be composed of two parts,
first one being alloc and container/iommufd setup and second device
setup and driver probe.

My reasoning for this is to avoid having separate code for these common
flows and avoid them diverging down the line.

> +
> +static void device_cleanup(struct vfio_pci_device *device)
> +{
> +	if (device->fd > 0)
> +		VFIO_ASSERT_EQ(close(device->fd), 0);
> +
> +	if (device->group_fd)
> +		VFIO_ASSERT_EQ(close(device->group_fd), 0);
> +
> +	vfio_pci_device_free(device);
> +}
> +
> +FIXTURE(vfio_pci_sriov_uapi_test) {
> +	char *vf_bdf;

Nit: Can we just use an array like char vf_bdf[16]? 
Just not sure why we need to do alloc and free for each run.

> +};
> +
> +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> +{
> +	char *vf_driver;
> +	int nr_vfs;
> +
> +	nr_vfs = sysfs_sriov_totalvfs_get(pf_bdf);
> +	if (nr_vfs <= 0)
> +		SKIP(return, "SR-IOV may not be supported by the PF: %s\n", pf_bdf);
> +
> +	nr_vfs = sysfs_sriov_numvfs_get(pf_bdf);
> +	if (nr_vfs != 0)
> +		SKIP(return, "SR-IOV already configured for the PF: %s\n", pf_bdf);
> +

If there is a test failure (ASSERT) then fixture cleanup will not run
leaving SR-IOV enabled and all subsequent tests will skip. 

Since this test is specific to SR-IOV and user is intentionally passing
a device to test, I think we can just reset the VFs to 0 before
proceeding instead of skipping.

> +	/* Create only one VF for testing */
> +	sysfs_sriov_numvfs_set(pf_bdf, 1);
> +	self->vf_bdf = sysfs_sriov_vf_bdf_get(pf_bdf, 0);
> +
> +	/*
> +	 * The VF inherits the driver from the PF.
> +	 * Ensure this is 'vfio-pci' before proceeding.
> +	 */
> +	vf_driver = sysfs_driver_get(self->vf_bdf);
> +	ASSERT_NE(vf_driver, NULL);
> +	ASSERT_EQ(strcmp(vf_driver, "vfio-pci"), 0);
> +	free(vf_driver);
> +
> +	printf("Created 1 VF (%s) under the PF: %s\n", self->vf_bdf, pf_bdf);
> +}
> +
> +FIXTURE_TEARDOWN(vfio_pci_sriov_uapi_test)
> +{
> +	free(self->vf_bdf);
> +	sysfs_sriov_numvfs_set(pf_bdf, 0);
> +}
> +
> +FIXTURE_VARIANT(vfio_pci_sriov_uapi_test) {
> +	const char *iommu_mode;
> +	char *vf_token;
> +};
> +
> +#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _vf_token)		\
> +FIXTURE_VARIANT_ADD(vfio_pci_sriov_uapi_test, _iommu_mode ## _ ## _name) {	\
> +	.iommu_mode = #_iommu_mode,						\
> +	.vf_token = (_vf_token),						\
> +}
> +
> +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(same_uuid, UUID_1);
> +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(diff_uuid, UUID_2);
> +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(null_uuid, NULL);
> +
> +/*
> + * PF's token is always set with UUID_1 and VF's token is rotated with
> + * various tokens (including UUID_1 and NULL).
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

Can this and cleanup go in fixture setup?

> +	pf = device_init(pf_bdf, iommu, UUID_1, &ret);

We should assert here as well and in other functions.

> +	vf = device_init(self->vf_bdf, iommu, variant->vf_token, &ret);
> +
> +	ASSERT_VF_CREATION(ret);
> +
> +	device_cleanup(vf);
> +	device_cleanup(pf);
> +	iommu_cleanup(iommu);
> +}
> +
> +/*
> + * After setting a token on the PF, validate if the VF can still set the
> + * expected token.
> + */
> +TEST_F(vfio_pci_sriov_uapi_test, pf_early_close)
> +{
> +	struct vfio_pci_device *pf;
> +	struct vfio_pci_device *vf;
> +	struct iommu *iommu;
> +	int ret;
> +
> +	iommu = iommu_init(variant->iommu_mode);
> +	pf = device_init(pf_bdf, iommu, UUID_1, &ret);
> +	device_cleanup(pf);
> +
> +	vf = device_init(self->vf_bdf, iommu, variant->vf_token, &ret);
> +
> +	ASSERT_VF_CREATION(ret);
> +
> +	device_cleanup(vf);
> +	iommu_cleanup(iommu);
> +}
> +
> +/*
> + * After PF device init, override the existing token and validate if the newly
> + * set token is the one that's active.
> + */
> +TEST_F(vfio_pci_sriov_uapi_test, override_token)
> +{
> +	struct vfio_pci_device *pf;
> +	struct vfio_pci_device *vf;
> +	struct iommu *iommu;
> +	int ret;
> +
> +	iommu = iommu_init(variant->iommu_mode);
> +	pf = device_init(pf_bdf, iommu, UUID_2, &ret);
> +	vfio_device_set_vf_token(pf->fd, UUID_1);
> +
> +	vf = device_init(self->vf_bdf, iommu, variant->vf_token, &ret);
> +
> +	ASSERT_VF_CREATION(ret);
> +
> +	device_cleanup(vf);
> +	device_cleanup(pf);
> +	iommu_cleanup(iommu);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	pf_bdf = vfio_selftests_get_bdf(&argc, argv);
> +	return test_harness_run(argc, argv);
> +}
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 
