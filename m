Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1434538238D
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304327; cv=none; b=YJ2SFG+TnlNB2k/4qb/9bMuiu7cgGWHAI19bgcgErm1fQ3yagBnk3z2B7o3xFTwiHL2z5UCespj8o2q5pg0pBoNmtSwkp09cD9EAvlezYokQ5Drb/t2jXVyq/l6xK9mRuoUmAD1i2gZfdENHrVLehEg7cT/LPqTxJ3z7ylaZ+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304327; c=relaxed/simple;
	bh=m0Oct6L5BwAfzAqfEGPIqu2tZ0EzzUznTUJO7ip40R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZM5oP5/1keqIBttSwLUTDIuuih0kR5uBpAtEsUSpKbjOxaLrzfBgeU5QNKPqv4FNEzPngknvH1o2BQnMg5J7eaJKstEpXMr7GI6i+pyXtnIN1hJloE9xFiiUD9NAG2FmJ4dN6Pn6MlDjRujFsa0ewGKDBKMcWhNwwWnP8nVeMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZHltvsAR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZHltvsAR"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so32725ad.0
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 15:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774304325; x=1774909125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUjy+2x1i7Xfs6bwVX9ul43lO5ojBIL9kKYDxuqVt+4=;
        b=ZHltvsARdk+nB05D2x/tLf7qQZp88iwKcSCZFwXi85zgadAsMspmjWfRaLdQDmlahC
         uK4+aKc4Upe1E1fn/iO6FTcmAMV87nOOeMzfz8Rrg3PeHgX9F1blOdoqMmMGRZKqqUHX
         vkXjZafAng608wAYLiGEeG6TEKWUS3+E2MSeUPqG2wy41fmk5Y8zQH4FGUBvP11QohG2
         YnJDXpkZPrDkbChaNOAge0ptQX7wZNdyOHkupHhZrIeOMV9p0N9yIsfoUkOW4ClESs2c
         GTMaO1B+UpTa9n3hg4UXn74AwQCA+IeI+AlfKAlK5n4WGEPyjiWUw+tKTfh2UD3nZMRo
         nhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774304325; x=1774909125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUjy+2x1i7Xfs6bwVX9ul43lO5ojBIL9kKYDxuqVt+4=;
        b=QX6PQMULTKoY6tToHL5RROcMe8i5zayIcTsZcBgG5d8kX+0QBjfQzlRpR1HDurLZ1I
         4hK2UpzB2NknqsCUOTsn5LeKZRzrgfBVJGg5ecCvBuTKM9/LOgM7n7OSj/1ug6SMt6v2
         p3NhOx6vy3RfVEJdd2peqPU6cQVlfwaOihNYUzqqsc9T2O905S7XLLaUwmTqmgxje8PE
         sy8NbKxNzt2IgjPP4M/kD4vqJEIZn3KvbaF5VBNqMWi0ddnjjVUYW3MTsDyH3LNx0gtS
         i49bFjMg5BGAK3eVRDVPYvovMhEtGdDXZH0p9wj+S+IEQc/i8WnJKL/8Ge6AT7ti3S+D
         ETCw==
X-Forwarded-Encrypted: i=1; AJvYcCXJqPqLASVcyRBxa+JQy2H6ejYH5YnXZLkJjIbRNH7kChV3XvpxyfurPKcKljFF4j49M2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzpUQD3KCqhW5E+bGvzeUCBL4ebBHC9l6pfw86LtZb5iJXQ+Wy
	NGwQtHBXV8BseSoBdu8snVlfVti+axMw3tUxhHJxIWujVAa4FNmjsDCniGBwNnw5YQ==
X-Gm-Gg: ATEYQzySH42VLM1k+LqdcTDzdB8UCjFJ24z3/aqnTbt0yJue9VnCuEToDsd9CCFjAa8
	2M4KPCGqnsuAuUmYvTQ/9gYKzupTanzxPB42RWOFyZcwbPkok564dZNRM5eUSIkw27tW+9dsV+P
	hYvIpFgp/qenD64IaNtfcE+IU4HbT6BdFVno/Ew5a2jyt4NJPXvrgSdiXp7cHbKsZrguvVQHZ6n
	t09rz9fzAoFK0gi/IskaK2LQG1WzcgJSLKqBSuFPwAaDMlhQldFyR7120MC1SVhuP4Fa5p3SxqZ
	Z0B6nTdSO1YTeq2TkTz05UhoMayMmSNffpidvXv6EeSLCbaRX4+PeemEWs+vTD56DtCBJlWfWOZ
	xADJRMgIETr4AMzi7Cxc8O4vDJWWXgVTveL+Owv7vk/4WjofQhGlcM1zW0dyIwv3wEAP2unCaZX
	vcPn9ULd/u/JK378To4SeI0P6f814grTWg7D81Q9eiJ0ZcD87Pf8eU6hx6zWvA
X-Received: by 2002:a17:902:f68d:b0:2ae:4808:bd99 with SMTP id d9443c01a7336-2b0a53e730fmr1188815ad.2.1774304324944;
        Mon, 23 Mar 2026 15:18:44 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0175e234sm131271a91.1.2026.03.23.15.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:18:44 -0700 (PDT)
Date: Mon, 23 Mar 2026 15:18:39 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 14/14] iommufd/selftest: Add test to verify iommufd
 preservation
Message-ID: <20260323212009.GC2571566.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-15-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-15-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:48PM +0000, Samiullah Khawaja wrote:
> Test iommufd preservation by setting up an iommufd and vfio cdev and
> preserve it across live update. Test takes VFIO cdev path of a device
> bound to vfio-pci driver and binds it to an iommufd being preserved. It
> also preserves the vfio cdev so the iommufd state associated with it is
> also preserved.
> 
> The restore path is tested by restoring the preserved vfio cdev only.
> Test tries to finish the session without restoring iommufd and confirms
> that it fails.

May be alos add more details that VFIO bind will also fail, it will return EPERM
due to ...

> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
> +$(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBLIVEUPDATE_O)
> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBLIVEUPDATE_O) $(LDLIBS) -static -o $@

Why static? User can pass static flag through EXTRA_CFLAGS.

> diff --git a/tools/testing/selftests/iommu/iommufd_liveupdate.c b/tools/testing/selftests/iommu/iommufd_liveupdate.c
> +
> +#define ksft_assert(condition) \
> +	do { if (!(condition)) \
> +	ksft_exit_fail_msg("Failed: %s at %s %d: %s\n", \
> +	#condition, __FILE__, __LINE__, strerror(errno)); } while (0)

Please add indentation to the code.

> +
> +int setup_cdev(const char *vfio_cdev_path)

Nit: s/setup_cdev/open_cdev

Since you are using open_iommufd() name below, this will make it
consistent as there not setup here apart from opening.

> +int setup_iommufd(int iommufd, int memfd, int cdev_fd, int hwpt_token)
> +	bind.iommufd = iommufd;
> +	ret = ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
> +	ksft_assert(!ret);
> +
> +	ret = ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
> +	ksft_assert(!ret);
> +
> +	hwpt_alloc.dev_id = bind.out_devid;
> +	hwpt_alloc.pt_id = alloc_data.out_ioas_id;
> +	ret = ioctl(iommufd, IOMMU_HWPT_ALLOC, &hwpt_alloc);
> +	ksft_assert(!ret);
> +
> +	attach_data.pt_id = hwpt_alloc.out_hwpt_id;
> +	ret = ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
> +	ksft_assert(!ret);
> +
> +	map_file.ioas_id = alloc_data.out_ioas_id;
> +	ret = ioctl(iommufd, IOMMU_IOAS_MAP_FILE, &map_file);
> +	ksft_assert(!ret);
> +
> +	set_preserve.hwpt_id = attach_data.pt_id;
> +	ret = ioctl(iommufd, IOMMU_HWPT_LU_SET_PRESERVE, &set_preserve);
> +	ksft_assert(!ret);
> +
> +	return ret;
> +}

iommufd_utils.h has functions defined for iommufd ioctls. I think we
should use those functions here and if related to iommufd are not
present we should add there.

> +int main(int argc, char *argv[])
> +{
> +	int iommufd, cdev_fd, memfd, luo, session, ret;
> +	const int token = 0x123456;
> +	const int cdev_token = 0x654321;
> +	const int hwpt_token = 0x789012;
> +	const int memfd_token = 0x890123;
> +
> +	if (argc < 2) {
> +		printf("Usage: ./iommufd_liveupdate <vfio_cdev_path>\n");
> +		return 1;
> +	}
> +
> +	luo = luo_open_device();
> +	ksft_assert(luo > 0);
> +
> +	session = luo_retrieve_session(luo, "iommufd-test");
> +	if (session == -ENOENT) {
> +		session = luo_create_session(luo, "iommufd-test");
> +
> +		iommufd = open_iommufd();
> +		memfd = create_sealed_memfd(SZ_1M);
> +		cdev_fd = setup_cdev(argv[1]);
> +
> +		ret = setup_iommufd(iommufd, memfd, cdev_fd, hwpt_token);
> +		ksft_assert(!ret);
> +
> +		/* Cannot preserve cdev without iommufd */
> +		ret = luo_session_preserve_fd(session, cdev_fd, cdev_token);
> +		ksft_assert(ret);
> +
> +		/* Cannot preserve iommufd without preserving memfd. */
> +		ret = luo_session_preserve_fd(session, iommufd, token);
> +		ksft_assert(ret);
> +
> +		ret = luo_session_preserve_fd(session, memfd, memfd_token);
> +		ksft_assert(!ret);
> +
> +		ret = luo_session_preserve_fd(session, iommufd, token);
> +		ksft_assert(!ret);
> +
> +		ret = luo_session_preserve_fd(session, cdev_fd, cdev_token);
> +		ksft_assert(!ret);
> +

All of these ksft_assert are hurting my eyes:) I like the approach in
VFIO where library APIs does validation and test code only check actual
things needed.

Should we at least create a common function to combine both
luo_session_preserve() and ksft_assert()?

