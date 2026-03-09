Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940ED333727
	for <kvm@vger.kernel.org>; Mon,  9 Mar 2026 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773094005; cv=none; b=uQ40/91P1dRp5N0tVdFj0sNCIYXfHAK++SoJ+ta5+16JP+MzDdG273qHCShJWsMBzTBeRZZKK+itoeE5h5eUbv5bW4RONpgtV3fkI521MvpHicumSAgcKGCPozKGHO6dZQd9VLquXmGMmQS8EisogadUI8QRlZ/p7e0+usgrAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773094005; c=relaxed/simple;
	bh=q4mBz85JHUVMnUljq9Qg0t6tmIokk4zhP8/Xm8XWNZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNjbkh7eeIm44d2JVXu42z4DxCHQB9nylWHbrZD5s0bFlngpocyRgnyYobVx6FXX9uDDfdwwiKl4QdNeVgSTJljvXYpMI6RdMeEOoluckXo1tRwzMTjCMHPfW4pW35PLlk14kVF4Rf2Z1ExCR1S5Zpu2giFPfz05PgneRbcvB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G9SNVYEu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9SNVYEu"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae4b40999bso15265ad.1
        for <kvm@vger.kernel.org>; Mon, 09 Mar 2026 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773094004; x=1773698804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jbEGDtNXpvjI8o8Q1xoh+wtAtBiT8CMXNwqnXytvlA=;
        b=G9SNVYEukK7rUHQOwUEgBzeT4vMv7VJns7Zb1cyC3V/SsKF1HHBbXKXMARIfLT5kGp
         f1QuHiJZiB0x8PqymWX2yAP/0LNATnIiwgsdZUmkbeC31bv7VSfROfB4rg2zDRt1Qnje
         4QIqLPdsxrZzHfGOrx5IKCtao5pyEu24Pn/W2oyOotOljk6JG4qTZrdXvF94SRYy9aVa
         pZD0iGQ3PsnfjHKyxByw6WoA7KTb387V4aI7dIhReI023CZT1h3L+Fh+bCuXuenN4mtX
         jUjQt0IJLBs5q/7B/5jx46fRX2UFzkvvNyWPrtqOHu2focbUgvd1uAKw0dLk0ohy3uPK
         6b4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773094004; x=1773698804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jbEGDtNXpvjI8o8Q1xoh+wtAtBiT8CMXNwqnXytvlA=;
        b=xKoVTxgRD1TPBTemTy1KJUXXXUJfGVgZl2XoG44BypI1DoYhoXZuTqWswncoU0aLUv
         fwlrfS6uBU2l3YJrBdu7MF8IiLbwlW24goInVrueOAaK6dlVNO3kl14DEkdBmKmSXzEh
         0WZ+lDUTjlgnvKzjA7lSLZY5M3yeUFTLgTaO7/JII3T8jUrLJLxZmuZvIAI8E08/iXws
         SB2iWiSpupaXUlwbstnMAqK3tbvrbpDkV+SlaMfp5G067VOjeZMH5GbThfALxeNIiWU6
         q4XsxIfgsUxh34G3c9aWKy7dE8KsblyHad7EEu6VY4Qtusa3I6Du/idex4SNDTfAZPEJ
         1ZaA==
X-Forwarded-Encrypted: i=1; AJvYcCXPGRUVX0n6KvCQXrqeQXjtG8IXDmlKmS4SO5qLqt2Q5DzoxEpzfKa3/GlWKfKXq4sCfgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5rQjRh8EWiokw6fR03mpadgCClSfhFgLqIPsWm9djRZhgk8bu
	OWbi+SJSKOyChiazEZglKNW8fZ2eVL12AX3K6fVfqtY4yRoTee/Q2iRhWoGQBoZh0whl7uci5OZ
	Qdt5LDg==
X-Gm-Gg: ATEYQzwW+aDIJbhWxG9mF18n2+C5oBcrTLd6VPXw8Ku4+QkelzLYb7nbFw81l/Vq6e/
	k+GIAjhvrSPJF+KN4hYnsAP6deg/IQV6RD44387z9IT2UKuIb8nkqsSp5EI9qySWi/YJxRVoUUu
	WA3Xj6RMEqM9ZdgB3eQEpgkrj4JOeMitT7COwtLnealvcFwS8QXvTFjrK7LLew7icoghDEfBxbm
	48uXhSuOAgbV/e66NAca0Z1I4anMFazXeBwWkTM9lWcoTfyiz0PvyTzF2xxDNmI0bKUyrfHZt3l
	UvFhMOH7YTtBEfm/R3J8sCjOItGRbX2trOEIHzjrbPCA7Q/M6Wfy3yBWOhQroqzx5hYT6vbyGo8
	v+Fd2fH83vAO44Mze4hpDoyyeQ2w0+KJrMSDiJL2bninYBVhnsVeU8axTwMF48ZnR5zwe7jyKpg
	4C/Fe04V+OgKNXGT8UnVDeepE5vCPgen/hfR2GVnpuk6OaBpjBdBmvwVrtxg==
X-Received: by 2002:a17:902:db03:b0:2ae:4aa6:dc09 with SMTP id d9443c01a7336-2aea30c497cmr960975ad.14.1773094003557;
        Mon, 09 Mar 2026 15:06:43 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e181f15sm10041931a12.23.2026.03.09.15.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 15:06:42 -0700 (PDT)
Date: Mon, 9 Mar 2026 15:06:38 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/8] vfio: selftests: Introduce a sysfs lib
Message-ID: <20260309220638.GA690765.vipinsh@google.com>
References: <20260303193822.2526335-1-rananta@google.com>
 <20260303193822.2526335-4-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303193822.2526335-4-rananta@google.com>

On 2026-03-03 19:38:17, Raghavendra Rao Ananta wrote:
> +char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i)
> +{
> +	char vf_path[PATH_MAX];
> +	char path[PATH_MAX];
> +	char *out_vf_bdf;
> +	int ret;
> +
> +	out_vf_bdf = calloc(16, sizeof(char));

A comment of /* ../0000:00:00.0 */ would be nice to tell why 16 is
chosen.

> +	VFIO_ASSERT_NOT_NULL(out_vf_bdf);
> +
> +	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/virtfn%d", pf_bdf, i);
> +
> +	ret = readlink(path, vf_path, PATH_MAX);
> +	VFIO_ASSERT_NE(ret, -1);
> +	vf_path[ret] = '\0';

Can we just initialize vf_path to {0} at the beginning and not worry
here?

> +
> +	ret = sscanf(basename(vf_path), "%s", out_vf_bdf);
> +	VFIO_ASSERT_EQ(ret, 1);
> +
> +	return out_vf_bdf;
> +}
> +
> +unsigned int sysfs_iommu_group_get(const char *bdf)
> +{
> +	char dev_iommu_group_path[PATH_MAX];
> +	char path[PATH_MAX];
> +	unsigned int group;

Why unsigned int? In kernel iommu_group id is int itself. Caller of this
function also casting it to int.

> +	int ret;
> +
> +	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/iommu_group", bdf);
> +
> +	ret = readlink(path, dev_iommu_group_path, sizeof(dev_iommu_group_path));
> +	VFIO_ASSERT_NE(ret, -1, "Failed to get the IOMMU group for device: %s\n", bdf);
> +	dev_iommu_group_path[ret] = '\0';

Same, initialize at beginning.

> +
> +	ret = sscanf(basename(dev_iommu_group_path), "%u", &group);

Can we combine these operations into a single function? Seems like vfio,
iommu_group and driver all use the same pattern.

> +	VFIO_ASSERT_EQ(ret, 1, "Failed to get the IOMMU group for device: %s\n", bdf);
> +
> +	return group;
> +}
> +
> +char *sysfs_driver_get(const char *bdf)
> +{
> +	char driver_path[PATH_MAX];
> +	char path[PATH_MAX];
> +	char *out_driver;
> +	int ret;
> +
> +	out_driver = calloc(64, sizeof(char));

Comment on why 64?

> +	VFIO_ASSERT_NOT_NULL(out_driver);
> +
> +	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/driver", bdf);
> +	ret = readlink(path, driver_path, PATH_MAX);
> +	if (ret == -1) {
> +		free(out_driver);
> +
> +		if (errno == ENOENT)
> +			return NULL;
> +
> +		VFIO_FAIL("Failed to read %s\n", path);
> +	}
> +	driver_path[ret] = '\0';

Same, initialize at beginning.

> +
> +	strcpy(out_driver, basename(driver_path));

They both have different lengths. Should we use strncpy()?

> +	return out_driver;
