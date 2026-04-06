Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14538E5FB
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775519221; cv=none; b=TX4+/r+b1kojYhNWIv3QHG3KvMXerknE4pUaIGkVzU7sUhDefBiRtf6G7Ek+rRGtCKIM3BKREkXVqHmQ/jpvd4Axyf+biMS7KlYTVviQXFcFrb6hvt0b9ryscYDRPA4FHtCpeARuTSFOc0Ejy8QihdN/Cn3rnPs/uHytdPuoiqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775519221; c=relaxed/simple;
	bh=Uhsz4ifu1sjfHeM9W7g82BpAfLdqtoqGL5/l4I/0atI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiE+a5du4U3jXJoncvM/QqV2Q7UkEeuqoATgnDo36/kVD50BZdNwgL9uPS/m4NeclMIJReXZLLKVbzqIVkzg+T/NUJeJURhlsS0RW6EaME88pWb5CjIwAudzG2VNh2qsbS83xCY3jn/i9YveYVJhf3qftot34UEZuUHqaIARIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9hJumc0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9hJumc0"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82a893d289bso1870947b3a.0
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 16:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775519219; x=1776124019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k3T7i72YN9fiJvQX+8W50iUjB0p6LYj7O+KBedNW7Rc=;
        b=c9hJumc0qc2eK2mm/g1q/sRrRgNAyPUtOW9pAY1qo5ABfg+WQY+fChmTbtdM1PIKok
         K6oVXFgkf+Yfm/1COVg6AoJbQFsY3fnSKhF3e/daF1OtzUI1ZFWlfP2j6QuesagOfYFg
         L9fVSdk+OkUvneovtjrlTZSWFkd9Kbu6OzTazC/srlmB2sdLnGdYGfCDibMPfeCtv3/f
         xEpnInNpgkuMarHr2y5W0uQ0KDOslnJNhM0HKkCDJZRxU4caqp4xJLk5doELYRRHObXG
         POGnneqc+bLo0nZmwgRf9UVMQTmXhQTm5ewl4i4SxRNczD/vlZpBQF75sUJnCNMPOaab
         WPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775519219; x=1776124019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3T7i72YN9fiJvQX+8W50iUjB0p6LYj7O+KBedNW7Rc=;
        b=pfokjAzdZ9EutPeDyN6DYDZ41aARANzDfOq5517YB+TFihBlnEFt8B7miVONu+CjD/
         cvA7GUFjQRo3OhEy7gj91TLPmnuXo8tYl6mcGJtN/fYdoDBhYNV7mMxUHyaUL0O93orL
         QtsarOorpnWbpVzx8KnkyOB52RMSCHv2YrIGtIqadaRvggpXxGClQbuNhNtKE/1kvDDn
         ibE1/xl3R5YU/g8gifKvaCsASId13RqAZF2biXVwV+0H/cmb+pipbFThqkINfJBLJESv
         Ka8w9JH3ovBnHeIej/+A2XD5kWJcqxox2perC7j9+tkcWX50zFuO8WKXnnn4bix3/Z6t
         MoiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRdl2l6a3hXmYsWiZNDsOr4r43Cb3pAcoPk6n04ojM5xE5eRnZd9mBMW3kNP8a2gvUrw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGN7rKTdqkx0AVC+Cn9NgRlfyVl7rNig1nr02coWVkE5vQsLEb
	HbZ7k+U7OAZQ2RR8ly36RybhALcDXuJbmZ+0oFsw+jGTTE502kOyOLHPs5T9v4QXWXNizcJb8hv
	ygMiG9XQr
X-Gm-Gg: AeBDieuBFs3axQqZVhNKZW1bkYqt0FQ5v7VV+Q7u9MFowSxplyuYBxPANhV5jLe1M0O
	a1JDUWLyGr153iRlJ6+CWxDXs71d6Q0q+e+pnv5qGObmUd6FYGt2IuXY0O0l7SnRAkPQF0tDXeB
	vObWExdH/T6dpy/Rknb11spoTPAa77LMsgvWxj5RUTTJvKn34ga77JTCjd3eIAWlIeMHk6069Eh
	6sbqdYAr/4kYCl4uasX6myVIRuJaUmjXN5cnSwYWCQpc7OnSDjR6RHaoLA7GL7FZ48eCljvU06f
	IPFDpzIWeTEMQIfOY52yeKtoaCYlToIIbzqHaHdBfUimvtKhSohuL6PNCDDDG4UZxJHPMVKT+3W
	irwWcbLT5GeYyJ9sZ462ftIMVOlRyWHjHb2vNldkQUF1k9RaAFx5lLnqpBoKQDqIq847gozjY7Q
	FQ9f3eG6xqLXB4L6I+tJvFd49DA6kmM/ubLXIirk4NKjpettbx9Sr52erLmpHA6m8KcHrLDlNV
X-Received: by 2002:a05:6a00:414c:b0:82c:dd31:b844 with SMTP id d2e1a72fcca58-82d0db96471mr13189316b3a.40.1775519218556;
        Mon, 06 Apr 2026 16:46:58 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9cbdfsm19791071b3a.53.2026.04.06.16.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:46:57 -0700 (PDT)
Date: Mon, 6 Apr 2026 23:46:53 +0000
From: David Matlack <dmatlack@google.com>
To: Rubin Du <rubind@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 4/4] selftests/vfio: Add NVIDIA Falcon driver for DMA
 testing
Message-ID: <adRF7clGId7Wuiik@google.com>
References: <20260403234444.350867-1-rubind@nvidia.com>
 <20260403234444.350867-5-rubind@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403234444.350867-5-rubind@nvidia.com>

On 2026-04-03 04:44 PM, Rubin Du wrote:
> Add a new VFIO PCI driver for NVIDIA GPUs that enables DMA testing
> via the Falcon (Fast Logic Controller) microcontrollers. This driver
> extracts and adapts the DMA test functionality from NVIDIA's
> gpu-admin-tools project and integrates it into the existing VFIO
> selftest framework.
> 
> Falcons are general-purpose microcontrollers present on NVIDIA GPUs
> that can perform DMA operations between system memory and device
> memory. By leveraging Falcon DMA, this driver allows NVIDIA GPUs to
> be tested alongside Intel IOAT and DSA devices using the same
> selftest infrastructure.
> 
> The driver is named 'nv_falcon' to reflect that it specifically
> controls the Falcon microcontrollers for DMA operations, rather
> than exposing general GPU functionality.
> 
> Reference implementation:
> https://github.com/NVIDIA/gpu-admin-tools
> 
> Signed-off-by: Rubin Du <rubind@nvidia.com>

Will anyone from Nvidia be able to help review the correctness of the
driver?

> +static int gpu_poll_register(struct vfio_pci_device *device,
> +			     const char *name, u32 offset,
> +			     u32 expected, u32 mask, u32 timeout_ms)
> +{
> +	struct gpu_device *gpu = to_gpu_device(device);
> +	struct timespec start, now;
> +	u64 elapsed_ms;
> +	u32 value;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &start);
> +
> +	for (;;) {
> +		value = gpu_read32(gpu, offset);
> +		if ((value & mask) == expected)
> +			return 0;
> +
> +		clock_gettime(CLOCK_MONOTONIC, &now);
> +		elapsed_ms = (now.tv_sec - start.tv_sec) * 1000
> +			     + (now.tv_nsec - start.tv_nsec) / 1000000;
> +
> +		if (elapsed_ms >= timeout_ms)
> +			break;
> +
> +		usleep(1000);
> +	}
> +
> +	dev_err(device,
> +		"Timeout polling %s (0x%x): value=0x%x expected=0x%x mask=0x%x after %llu ms\n",
> +		name, offset, value, expected, mask,
> +		(unsigned long long)elapsed_ms);

nit: You can replace ll with l in the format string and drop the cast to
unsigned long long.

We only support VFIO selftests on 64-bit architectures, and that matches
what existing printfs for u64 use in VFIO selftests.

> +static bool fsp_check_ofa_dma_support(struct vfio_pci_device *device)
> +{
> +	struct gpu_device *gpu = to_gpu_device(device);
> +	u32 val = gpu_read32(gpu, NV_OFA_DMA_SUPPORT_CHECK_REG);
> +
> +	return (val >> 16) != 0xbadf;
> +}
> +
> +static int size_to_dma_encoding(u64 size)
> +{
> +	size = min_t(u64, size, NV_FALCON_DMA_MAX_TRANSFER_SIZE);

It should be impossible for size to be greater than
NV_FALCON_DMA_MAX_TRANSFER_SIZE. This should be dropped or converted
into a VFIO_ASSERT_LE().

> +
> +	if (!size || (size & 0x3))
> +		return -EINVAL;
> +
> +	return ffs(size) - 3;

Sashiko pointed out that this can lead to partial memcpys:

. If a non-power-of-two size is passed (for example, 24 bytes), ffs(size) will
. return the lowest set bit (bit 4, yielding an encoding for 8 bytes).
.
. Because nv_gpu_memcpy_wait() performs exactly one chunk transfer and does not
. loop over the remainder, could this silently drop the remaining bytes and
. cause a partial data copy? Should this check if the size is a power of 2, or
. should the caller loop to handle remainders?

https://sashiko.dev/#/patchset/20260403234444.350867-1-rubind%40nvidia.com?part=4

I think this nuance needs to be handled within the nv_falcon driver.
vfio_pci_driver_memcpy_start() just guarantees that size <=
NV_FALCON_DMA_MAX_TRANSFER_SIZE.

Perhaps this is why you had the loop in an earlier version of the
patchset, in which case it was my mistake to ask you to remove it!

When you add the loop back please add a comment to the loop to explain
that it is necessary since the region needs to be sliced up into
power-of-2 sizes for Falcon.

> +const struct vfio_pci_driver_ops nv_falcon_ops = {
> +	.name = "nv_falcon",
> +	.probe = nv_gpu_probe,
> +	.init = nv_gpu_init,
> +	.remove = nv_gpu_remove,
> +	.memcpy_start = nv_gpu_memcpy_start,
> +	.memcpy_wait = nv_gpu_memcpy_wait,
> +};

Any particular reason these functions are named nv_gpu_*() instead of
nv_falcon_*()
