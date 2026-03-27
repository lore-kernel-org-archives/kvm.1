Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FBB280336
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636329; cv=none; b=nbidpcytytLyn/bBqVbG3w6RAHHlfigRrnP8iFI55J6mcimTrsLw2rQ6YyBU+5vtXmnq2j4T1EVhs5OinsZnAC7b049lR52TcXfupJMSOMbRPU0lggVMD8gpt+oEuAxaWPOqAxQTK2s+l7pYeZajF556gH8RHDwZHO0JSH7K8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636329; c=relaxed/simple;
	bh=I8pCU0iLD4KpeNGY/h/1gemUn3rTUbWvhlBneg4jlks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+bNJPu7j/E71tSMLHNbYksvBh89bvYcc0hSFKoAG44BQ05mLlpkz3IxFH9lljlQBMdFjckiXOTqsIRgDTk2E38ZyM5jvjb3Y+GRVWyx/nMduAVtB1sNXAR07PZzv9sMwBTc/u9Mtszehf0RcZBHin4CPbYCPU/KHW0gza7DG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zk6KGSm0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zk6KGSm0"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b052562254so15235ad.0
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774636326; x=1775241126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LpDt37HhnOjDLZnhrjfc9Is2eaIGxJ/qygK6ijfc2M=;
        b=Zk6KGSm0Cgc2GnT9Er8A9b5BKr1rzqlOk+dIUrHvHjoSMCiOdd4yVV+0jC86y5Dbsp
         sz4JWRa23hic8Np7cPBf2KcqbDlu2C8YvGE/Gw2CwEfUTECJiCgMnNwwcXvmjYnwbEBv
         U0LPW5nWn0SCdvcczipLkIjYNERVwBKo3sgufD1bjMcCBQZaijdSl9WJCzUXXbprxOqE
         KSvPPCzVD4DcOpU1CsZaqx41/mlTWvMDPgI1dySuJ7zeucdW0vUmPziO/NKQwSrLvEJo
         NPVBbo4aXZ0FGjpFG8jwu+rFAZhMdDmyG+V5cQJ1Jy9S/wg4kl2UJt3vYqkQRSnLEe+h
         AFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774636326; x=1775241126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LpDt37HhnOjDLZnhrjfc9Is2eaIGxJ/qygK6ijfc2M=;
        b=N5M2Yo+75c58wBliYV9er1uwfbgJkduJ9Z7iFrN4gYaLS5+kls2ewzpio9dBg/L0tk
         je/eoWB1gBNtcmFIRLsGLW7EDJ8sc++deU2skQAWAMfjiSKaDoPZ5hfHaQCMYV5pw1nO
         6eGZUka0OmEzqQlMG0jv9mjAEnyJTU8CSfce+m0VM1p6aPn0VsbEDoElmeTeRJJq5+ft
         RFFA7HUQjgIOMXS7iTCn4d02hxnQaXU4NwIt/i7zLxKkYtMPSgPv+dEuapgLM2zAFc93
         D+25KUiXCVvI1NtObAZf0TAAy9Jh0nxJS+eJQdSA1dtkzgNAMDF0JWsUnc6XgwvZUEZ6
         R3yg==
X-Forwarded-Encrypted: i=1; AJvYcCXy/FDMByPuIhFWApeKjLX8Vt7vftnp4qOdNZpJ4edZ08Vd6/VR5ZGanid372xtBZb7kb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH8+x3EHXOk7WhwYUSqnz8Kzg7W4kT//9UKanDjIV6DApyf35j
	MWHtkcfLwxWX8GfTUI36ktz/hWAYpAmTc5O4OXt8QK9V5hBHQ2ioeFI+BqHwJIitzQ==
X-Gm-Gg: ATEYQzyrv2hNv5eAP989LlWJaPqqvdv+mByJ0DmClmH6UR9TATuZJgocVaNNxVXwJkB
	17HV5r2A3/7fgFWskGgrXN7baheJERFEJSvUOdkllzCDy2jDvslOgjOoarbVclqO29390pRfe4P
	VRoW7DwXDWx2+igdIF/JHJ9eHUNtTCw9xtKbIwXO+YqW1V3TjQBVkfWfiO+PPu4WWmgZRLifSXF
	671PFaAeF3OZB8jhw/H8RNwqdXZnUI273pIzfsedAJQ6hwNoqtZEFcafPUMg9iT3G7JKZgCgiyX
	h7Tggmth+smb/qIkw6u2kqc2MzjNVocr+a7yvuC+QRwiFg9QKp5Ms0rLXK9BVN0+fmnpWGMvogZ
	mmBcvkTQt43q9O6ZWHP/fybRsZmZooaeDRTCxzUMGYiAbIDtJS9xsHdSeipNDUkA9RVFtbxyQB1
	nnnkG+ZoYpL4UDbES7gEJgaAphQrFfiaR3Tj+yl3MhUOShNv0Ue23rVb/BDa91Gw==
X-Received: by 2002:a17:903:1b6c:b0:271:9873:80d9 with SMTP id d9443c01a7336-2b241e132a0mr249515ad.7.1774636325437;
        Fri, 27 Mar 2026 11:32:05 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca76e8478sm28351b3a.41.2026.03.27.11.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 11:32:04 -0700 (PDT)
Date: Fri, 27 Mar 2026 18:32:00 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
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
Message-ID: <acbL_NNBt1-8qa7O@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-15-skhawaja@google.com>
 <20260323212009.GC2571566.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260323212009.GC2571566.vipinsh@google.com>

On Mon, Mar 23, 2026 at 03:18:39PM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:48PM +0000, Samiullah Khawaja wrote:
>> Test iommufd preservation by setting up an iommufd and vfio cdev and
>> preserve it across live update. Test takes VFIO cdev path of a device
>> bound to vfio-pci driver and binds it to an iommufd being preserved. It
>> also preserves the vfio cdev so the iommufd state associated with it is
>> also preserved.
>>
>> The restore path is tested by restoring the preserved vfio cdev only.
>> Test tries to finish the session without restoring iommufd and confirms
>> that it fails.
>
>May be alos add more details that VFIO bind will also fail, it will return EPERM
>due to ...

Agreed will add more detail.
>
>> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
>> +$(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBLIVEUPDATE_O)
>> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBLIVEUPDATE_O) $(LDLIBS) -static -o $@
>
>Why static? User can pass static flag through EXTRA_CFLAGS.

I will remove this.
>
>> diff --git a/tools/testing/selftests/iommu/iommufd_liveupdate.c b/tools/testing/selftests/iommu/iommufd_liveupdate.c
>> +
>> +#define ksft_assert(condition) \
>> +	do { if (!(condition)) \
>> +	ksft_exit_fail_msg("Failed: %s at %s %d: %s\n", \
>> +	#condition, __FILE__, __LINE__, strerror(errno)); } while (0)
>
>Please add indentation to the code.

Will do.
>
>> +
>> +int setup_cdev(const char *vfio_cdev_path)
>
>Nit: s/setup_cdev/open_cdev

Will change this to open_cdev.
>
>Since you are using open_iommufd() name below, this will make it
>consistent as there not setup here apart from opening.
>
>> +int setup_iommufd(int iommufd, int memfd, int cdev_fd, int hwpt_token)
>> +	bind.iommufd = iommufd;
>> +	ret = ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
>> +	ksft_assert(!ret);
>> +
>> +	ret = ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
>> +	ksft_assert(!ret);
>> +
>> +	hwpt_alloc.dev_id = bind.out_devid;
>> +	hwpt_alloc.pt_id = alloc_data.out_ioas_id;
>> +	ret = ioctl(iommufd, IOMMU_HWPT_ALLOC, &hwpt_alloc);
>> +	ksft_assert(!ret);
>> +
>> +	attach_data.pt_id = hwpt_alloc.out_hwpt_id;
>> +	ret = ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
>> +	ksft_assert(!ret);
>> +
>> +	map_file.ioas_id = alloc_data.out_ioas_id;
>> +	ret = ioctl(iommufd, IOMMU_IOAS_MAP_FILE, &map_file);
>> +	ksft_assert(!ret);
>> +
>> +	set_preserve.hwpt_id = attach_data.pt_id;
>> +	ret = ioctl(iommufd, IOMMU_HWPT_LU_SET_PRESERVE, &set_preserve);
>> +	ksft_assert(!ret);
>> +
>> +	return ret;
>> +}
>
>iommufd_utils.h has functions defined for iommufd ioctls. I think we
>should use those functions here and if related to iommufd are not
>present we should add there.

iommufd_utils.h has utilities to use with mock testing, so those cannot
be used here. I will see if I can make separate helper functions for
these and use those here.
>
>> +int main(int argc, char *argv[])
>> +{
>> +	int iommufd, cdev_fd, memfd, luo, session, ret;
>> +	const int token = 0x123456;
>> +	const int cdev_token = 0x654321;
>> +	const int hwpt_token = 0x789012;
>> +	const int memfd_token = 0x890123;
>> +
>> +	if (argc < 2) {
>> +		printf("Usage: ./iommufd_liveupdate <vfio_cdev_path>\n");
>> +		return 1;
>> +	}
>> +
>> +	luo = luo_open_device();
>> +	ksft_assert(luo > 0);
>> +
>> +	session = luo_retrieve_session(luo, "iommufd-test");
>> +	if (session == -ENOENT) {
>> +		session = luo_create_session(luo, "iommufd-test");
>> +
>> +		iommufd = open_iommufd();
>> +		memfd = create_sealed_memfd(SZ_1M);
>> +		cdev_fd = setup_cdev(argv[1]);
>> +
>> +		ret = setup_iommufd(iommufd, memfd, cdev_fd, hwpt_token);
>> +		ksft_assert(!ret);
>> +
>> +		/* Cannot preserve cdev without iommufd */
>> +		ret = luo_session_preserve_fd(session, cdev_fd, cdev_token);
>> +		ksft_assert(ret);
>> +
>> +		/* Cannot preserve iommufd without preserving memfd. */
>> +		ret = luo_session_preserve_fd(session, iommufd, token);
>> +		ksft_assert(ret);
>> +
>> +		ret = luo_session_preserve_fd(session, memfd, memfd_token);
>> +		ksft_assert(!ret);
>> +
>> +		ret = luo_session_preserve_fd(session, iommufd, token);
>> +		ksft_assert(!ret);
>> +
>> +		ret = luo_session_preserve_fd(session, cdev_fd, cdev_token);
>> +		ksft_assert(!ret);
>> +
>
>All of these ksft_assert are hurting my eyes:) I like the approach in
>VFIO where library APIs does validation and test code only check actual
>things needed.
>
>Should we at least create a common function to combine both
>luo_session_preserve() and ksft_assert()?

Agreed. Will rework these.
>

Thanks,
Sami
