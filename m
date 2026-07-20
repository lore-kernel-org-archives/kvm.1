Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B172410D24
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572108; cv=none; b=QTuM2SdmUyQYDZxzvbmi71NVl3hzEkg20H9wIeNduf62RlU3babFor4U3yKdSQ2nFCBGsoeAghhN2lVb+Oyun2tAZGTmSWtVRj8QedkWFGDFeJWi/VZEe8tej29C0dNFIgqlce8EDIqBETOT3KI2jJA+Zkt2DoG8uAAJAAUglhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572108; c=relaxed/simple;
	bh=qB1qZm+HRTg8pqCweELVHv8jUzWxu0os0ZQCjUBjG6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxxLqumDI3Sx5Dz1UTKP7OvXYERTAVRVB9EjIRcJQfapRE8+tGhDL4oVw1LA+gZpYSGKkMc/CCQRGXe1yBtuda+wFDjOMdN65jzJcqGg6ja492OH2KckT2gy5Lg8Z1FrtDID/lrO1Hava0WVLXENsaPZF9dBUMHEmcQ+nR6cgBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1LYyGbH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1LYyGbH"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cede6375caso357825ad.0
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 11:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784572105; x=1785176905; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F4chItj7ZQ/m18fHajf2tDvUHuTNAS2VcTDNk0ORlSY=;
        b=k1LYyGbHudd2raAqeyOiys44eLrNPpwFxAJoN/sNjRVJ59TATBrZb5auT4zwyulEXH
         e1O8Sjv7tX+ZuYT+bf5YMDjB8rVXwTxwA/BBQDDJEizl/Iqio8ATFW2I6fNP+eDnT85t
         srrzK8dIIm2St5qGpLc4vyU8S+7Tx+RbPzExBVGm/0ItCBpq7UJ/ZaitT84pnX/q8OKk
         w3Td9MDv568KWD/vrlZEwKrMr+IZJyxbA2lJj0OAleqlWUqEvb5yIW57QqhXrl0N9JTc
         iLtl1itXGJzOzQLYD/YExcgxuC0xlz2FDyzqSM20LD4igeavWuBvPDjUjT4j+IJ5i3c+
         Fn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784572105; x=1785176905;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F4chItj7ZQ/m18fHajf2tDvUHuTNAS2VcTDNk0ORlSY=;
        b=Nh1DL8eICwRse1vyEqz+u7B3ngjsr9YWxSU+LzsZ8NqNWN0/hMz8iLpvfcb/YqHn+9
         9UUd6wpEBebabo30Cv2m4vEQ8olpCTiSJIxUJJuEtXIleVmbN6+tE66bQuaMcvFoAdic
         42vWDclY+n25ASdLib2f/y2P2nfEjBimb5LWQtXQSAbXFQy1OwQANO7/XVQgjg2koZ4C
         Gfxj9s/SxcKEh/147phuyZohH3UHOgd96gm5MmN/BHFwRNuWF9CCgm6JojsOwOGEYSs1
         G2FRBPfpEf/u4sX0Z3uZ8vZ4mAygcSFvaFJW56HNL5jHCiAFXIs5huMbZnJuB0YKFTCq
         N9SQ==
X-Gm-Message-State: AOJu0YxQLHX6o0CNcj4CYFFZ1HUEYmSRPg8ZiVgGTfI0y2Hh1xdscWkg
	zlIBxwTiBI524yQAeRoNv6qQDkUa7EbLkK9z2HjlojfGzldxoHDDv5SCrn6yM92Ymw==
X-Gm-Gg: AR+sD10N2kO7ldF0iyE7nJNPMd1OovcLMSCC11ZTCff2qH8mvcpqCTIqBhEig8HhvX7
	zqwDjav+ejOn6KnKHtlzrPWPpNG+kaJEdxTh54+Xsq6H2G0nW4IweJi5FewP7U00i9TwRIh0D+6
	PSijllK3QbCc2gyDY/Z4VfpbL2U0OGzoAKsCfFMPBgezS9BBa8oyA003Jm9a03E4RzKGq2+JD+Y
	ZskPDiYXEMx7EukSmX5d6y11eYZe4Tlqj0fwD3EZaLmrpmCEMTcj2Ajk9l7nzlNeURE2HxTMHsZ
	LStTu7oFD2rk5fK3q9Ikwwci6WeczK8pAy40VoonqRkJUBP05ICQgNubLr3ZVbTVtMCIr3usZZu
	A19YhMb88+GybregKDL/TgllXFaEpCnARD/+YDO5TeLXe8F9+vUJ+1XATgfCTvjbQAn1N+I+uJ/
	c+FtWsqGSY1P9Jafk3pD32f4sH6TQZsJkfmAO2TF0=
X-Received: by 2002:a17:902:c94f:b0:2c0:bf57:8746 with SMTP id d9443c01a7336-2cf7b6989a3mr1866065ad.18.1784572103969;
        Mon, 20 Jul 2026 11:28:23 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517f8f77dsm5120904a12.11.2026.07.20.11.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:28:23 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:28:19 -0700
From: Vipin Sharma <vipinsh@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v5 19/20] vfio: selftests: Verify that opening VFIO
 device fails during Live Update
Message-ID: <20260720182453.GG1381701.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-20-vipinsh@google.com>
 <20260714154208.274791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714154208.274791F000E9@smtp.kernel.org>

On Tue, Jul 14, 2026 at 03:42:07PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] Test assertion failure due to IOMMU group already being claimed by preserved cdev
> - [Medium] Test assertion failure due to re-binding already bound preserved cdev
> - [Low] Abstraction violation using free() instead of vfio_pci_device_free()
> --
> 
> --- Patch [19]: [PATCH v5 19/20] vfio: selftests: Verify that opening VFIO device fails during Live Update ---
> Note: Due to recitation restrictions, this report uses a free-form summary
> of the findings rather than quoting the original patch diff.
> 
> commit b5a56d527567933e2f5fd3077aed99e8404f21c3
> Author: David Matlack <dmatlack@google.com>
> Subject: vfio: selftests: Verify that opening VFIO device fails during Live Update
> 
> This patch verifies that opening a VFIO device through its cdev file and via
> VFIO_GROUP_GET_DEVICE_FD both fail with -EBUSY if the device was preserved
> across a Live Update.
> 
> [Severity: Medium]
> In check_open_vfio_device_fails(), the test loops over legacy modes and
> calls vfio_pci_group_setup(). Since the device is already opened via cdev
> before kexec, the group's cdev_device_open_cnt is greater than zero. 
> 
> Does this cause the group open attempt inside vfio_pci_group_setup() to
> fail with EBUSY? If so, it looks like this will trigger the VFIO_ASSERT_GE()
> assertion on the group_fd, which would abort the test before it can even
> reach the VFIO_GROUP_GET_DEVICE_FD ioctl it is intended to verify.
> 

Not an issue.

Kernel data structures are initialized after kexec. So,
cdev_device_open_cnt will be 0 and vfio_pci_group_setup() will not fail.


> [Severity: Medium]
> In after_kexec(), the test retrieves the preserved device_fd and attempts to
> initialize it with a newly created iommufd by calling
> __vfio_pci_device_init(), which then issues the VFIO_DEVICE_BIND_IOMMUFD
> ioctl.
> 
> Because the device_fd is preserved across the Live Update, doesn't it still
> retain its original binding state and reference to the original iommufd
> context? It appears this might cause the bind ioctl to return -EINVAL,
> triggering a fatal VFIO_ASSERT_EQ() in vfio_device_bind_iommufd() and
> crashing the test.
> 

Not an issue.

We do not have support for iommufd preservation yet it will not
retain reference to the original iommufd context.

> [Severity: Low]
> In check_open_vfio_device_fails(), the code directly calls free(device) on
> the pointer returned by vfio_pci_device_alloc().
> 
> Would it be better to use vfio_pci_device_free() here instead? Even if it
> only wraps free() currently, using the library's abstraction might help
> prevent future memory leaks if internal allocations are added later.

It is not an issue right now. But I do agree we should use
vfio_pci_device_free() for future proofing. I will change it.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260714151505.3466855-1-vipinsh@google.com?part=19
