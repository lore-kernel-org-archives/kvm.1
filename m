Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8021B39EF1E
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514257; cv=none; b=sz1htPyVkmF9sOo4k9yQkrKkVAVXp/NW2jNl4JOu38wFYPXeB0QB08v2J21WijEqThxoPvn+VYKA2q6uj63s+TtIFEGmGV/llCMEAS/6ntghr+1NHmCB/2wwoi+67uIQ9PLvDw21KmYgq0Z929ihW0TEORpdnPjhUBpjRpujCFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514257; c=relaxed/simple;
	bh=ewoAHirtyxvs6kNwLJTzu3Wt/BMmWqyQhBTsTu1+SDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1HHsm/0fiv3qazxGVRlgOTnkzj41J4ZggGcMEnxVESpyvFxqIhhemPoPNNf0ptmKWFGdcZMLBWKia/gqTFmU62qEDDH5dL6A9sI9iVYDGzY1emvTKWpFCvXKzS1m6/4OYuFXehDJ0hSfXiccw0XGAAVs6jqZtvdhWpTBGwSkDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3PyK1Qg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3PyK1Qg"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso3122850b3a.0
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 15:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775514251; x=1776119051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkKBfhYGIkfoZWJSvPx+TEPZBQ4oCANpmSjapN38TJg=;
        b=D3PyK1QgY4x5A4ESHydBbAxVJ4HPh9yncPkkSdj9uk+/QYwEVBC8rx9YZxnWD/2n55
         +rpJbP2KARdopQ30CmmXniXMgT+M5oDZbFpTiVlQivIv0bhESp4T6KWnHJN9SZqqOERz
         wEJ/DF5CQ9esqKt+TrYSgr+3fIO7DwNlLO6uvroBmNrFvowQASaxS3Z7ZYvUQKVvkkcX
         WrT57AVqG96tQJDwGwkaFQ7/h7SSKemMXF/tonEGSMsKpm5yT4YQ5VV5gcTsDsQ23Ayw
         PXgDUpv5BEOXSWjix9Q8iJsEEmaUxqftHs1AZFuVcnBIgfh1TsirRO39IZ8D595Qr5M9
         030g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514251; x=1776119051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkKBfhYGIkfoZWJSvPx+TEPZBQ4oCANpmSjapN38TJg=;
        b=iJJbt2wMDDCoALREwinW8321lVnQyKCaJlok67S9gbYKU+wE5lY/d3bQg7E0BccG+s
         FugDnGvI+w8HDJMdPEA9qJl8RVDeknuZ3ZfQltX0xWMMOpIR3TDXcFy74mt2zG5f/PfY
         QyX5QxtphSxuwuKEjfChurvHNHnf0c2svFnbXVVgrxJB2GCmR7czEXXSTJMqYup7glIj
         CkavIPIqP9mB5iBAEGAWzbu2b7H+Uv9HnNg7xqGcb1W4AReCntSam5dEDHX1zbZSsZ7L
         skz763McxNT/ahc1zU16uZ+/WKcUrsYi5D3N4doHjIfg6NQ/UzC5Hs70qNDRK3Tc+X1J
         oeAA==
X-Forwarded-Encrypted: i=1; AJvYcCUvBUa7VeFXsbDTAuMCxXwonkJ6QCPDOk5tSgZBH8rGF6D1yX187bVtzCAmzLYyXSC1ODU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxunOjPJHE24vqSaziq6l8yZOmGrsZ4vtzQpNqxi5/jfnz6uD9+
	RHntDDOZD7e9KSfaBd+ad0Itjm8Oxi4M1Zl0gO8Bij+dpqw0rTleEI2AwGkoO95QIw==
X-Gm-Gg: AeBDievDEzsk+22Cx9Hbw0nmbKh5nNKS7hynqAuU8wea+AOnkaFWcZlqNuvzthkRJWn
	SGnQkNZWRy74hP1ibpkx+8KSvSZc6IdQqASp+C56nDJcay9e71dvGDe5KV66YOZ79qNH7jxmYSn
	RKDwhS9QarNnnmCH626FXaMRMQqE0Gfyu0ZIt/kCsDKfppDpK5ZYbwhETuFWBzWfe+wgW4Q/nrC
	AjyP55uL2cC2lR/PyqszfgxsvXZnqCta8yCJAjDYwQNywaYss6n8r0VZMUb9fcmMdanrNIVJw0H
	tXzLEqw4QVeE829HEH6+a7Oqs2+JfK8e8XEcBttKClKtF48IJmcwnhlZP5I2+mhUS4C3Fwb711N
	gIFMwMvVx+nqowmJkTOK+UupauUbQS+eW2MbyFKr3Vo5L7+K5tnsAZ36eaacl/7kHiZLb2MhafU
	R5d2SkQIO3saxYhwZMmE/CVaqy5NA+3QkcVSpUbd2CMLpHVX91TS2TgV4QCryYgw==
X-Received: by 2002:a05:6a00:1d9e:b0:827:4372:dd15 with SMTP id d2e1a72fcca58-82d0db888d4mr14250007b3a.40.1775514250273;
        Mon, 06 Apr 2026 15:24:10 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b76c0fsm14336712b3a.15.2026.04.06.15.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:24:09 -0700 (PDT)
Date: Mon, 6 Apr 2026 22:24:05 +0000
From: David Matlack <dmatlack@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>,
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
Message-ID: <adQyhegJdEWuUIi4@google.com>
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

On 2026-04-02 05:30 PM, Raghavendra Rao Ananta wrote:

> +/* clang-format off */
> +FIXTURE(vfio_pci_sriov_uapi_test) {};
> +/* clang-format on */
> +
> +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> +{
> +}
> +
> +FIXTURE_TEARDOWN(vfio_pci_sriov_uapi_test)
> +{
> +}

Please do iommu_init() iommu_cleanup() here to reduce code duplication
and as an added bonus you can drop the clang-format comments above.

> +static void vf_teardown(void)
> +{
> +	/* Destroy the VF only when the main/parent process exits. */
> +	if (getpid() != main_pid)
> +		return;

Is this because the child processes created by test_harness_run() to run
the TEST_F()s inherit the atexit() call? If so please clarify that in
the comment in more detail.

> +
> +	free(vf_bdf);
> +	sysfs_sriov_numvfs_set(pf_bdf, 0);
> +}
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
> +
> +	/* Create only one VF for testing */
> +	sysfs_sriov_numvfs_set(pf_bdf, 1);
> +
> +	/*
> +	 * Setup an exit handler to destroy the VF in case of failures
> +	 * during further setup at the end of the test run.
> +	 */
> +	main_pid = getpid();
> +	VFIO_ASSERT_EQ(atexit(vf_teardown), 0);
> +
> +	vf_bdf = sysfs_sriov_vf_bdf_get(pf_bdf, 0);
> +
> +	/*
> +	 * The VF inherits the driver from the PF.
> +	 * Ensure this is 'vfio-pci' before proceeding.
> +	 */
> +	vf_driver = sysfs_driver_get(vf_bdf);
> +	VFIO_ASSERT_NE(vf_driver, NULL);
> +	VFIO_ASSERT_EQ(strcmp(vf_driver, "vfio-pci"), 0);
> +	free(vf_driver);
> +
> +	printf("Created 1 VF (%s) under the PF: %s\n", vf_bdf, pf_bdf);

Do we actually need atexit()? This code can go into main and we can do
the VF cleanup before returning from main after test_harness_run()
returns. I don't think you even need to check the VF driver. If the VF
is not bound to vfio-pci then that will be caught by the test cases when
they call device_init(vf_bdf, ...).

That would make the logic more straightforward and get rid of the
main_pid stuff too.
