Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCB833A9DD
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 23:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382510; cv=none; b=h3a4Gb+ya8OfyGXYmsP+vnMNu3iaBOdV39BqG3NghWnI+44x39MfOWC16evhWQfS9qsS1hsccKq7ndKLTuXa5NNWXUADVbRk5r49M2hnkVCNSx8vjaFeLEGd4xXqLRpxZLEm7Sj1Fl9VK04t2XRDEmey/BkGQ6MhUp56t+x3Skc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382510; c=relaxed/simple;
	bh=EQSFUhYMbqalY21c98rxAzwM1mRZaLeETXhghpDejbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrLjRUPNlhKEwpB/OgTlAVnIEP0StXjK//qRLkSUZn0I5gqmGscHkreZ6kQzOtIfab8nSD5baGuN6e97iTrK7CUxhxM9Z8bBOrUZJCkdc4EVLTjPX5Fg3I4+Su3cg2dSL3yEZSNOYfeQWmlhNTWMM47QseBFW8YdRjo5C3KBq7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Acslq03Q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Acslq03Q"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so418765ad.2
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 16:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776382507; x=1776987307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5J1LNHvg3o+uCHHQkO+BCrg8gFD7yX7Qoyb8mG4ZdPk=;
        b=Acslq03QFxIezkNk685nhM6i31r9NTvi71fVMSPiPo5YsQVR0OcT12KxoUZ4ziWTuJ
         oh9DborbB8m8FwKqHS9rHwvY55rbvnfvYlCbupWVKIh8PR75v4SJGg1yYOdLAVhSgPjW
         KrRWpzovOl1qtfOI4pX8P58AQC46f1HJlbpxEdW38qxjF1DwZdaJXr6qUyRUnr8BuYw0
         CgCnAVwA3LMjQk6qtIkpDLVlZXOTry/fjZT0ilFI95cFVHG6pt2qpd++3QJgRenoF6aF
         POQ53L3b9wLgW2MjTHHc8g1jC0TcyjeEfsbOghtJM0EN9GSw9gb1uBdRJXZ4+51I1sRz
         WDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776382507; x=1776987307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5J1LNHvg3o+uCHHQkO+BCrg8gFD7yX7Qoyb8mG4ZdPk=;
        b=SsThmqg9Lp03/swSbZPyQiKXDTBkQPBPV435BkQT+hP6LiAPGOhv7RBUq2syQ3l2ae
         ijebqG8vHt0DATf0RuVaEcGVS6Ng/gq6yYI4qXjHG9wD814lGPEVyDdAehdxCEw7T/Yd
         3uh3GqNnAZPGCdlRgVJ8bwFI41Swq8WfLABrjge44a44fYbKCvKSQKVerCoSs2nurql1
         HQA28n6jFDXlEoGngL6QVv6D4ySMQ8AZZNgsBzcwnI4/1r8eWGYRqm0LHRwdSzS72DS3
         dUw0Ee0rYUvazSnjZLciu2yGjDUqxJVF2PBVs3vqaRAeVMVHxvvMTd7prrege0xC/WNi
         L9+w==
X-Forwarded-Encrypted: i=1; AFNElJ/2tEs1Fc1zc723OifMgS3FXBOGKsis57XD1z0aE07rJ7zxm1zobzvaAn0MAcAUfXrKi9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YztOG1jGu8QZn4JVRtE9ycKXJSq2IFrgquQg8qbucUwaxgimxqV
	F+BZxGuMTa+JlHkw9+vw5S1TLmClWDZlDggccQJHP7rKZvCUFtCDGACB1JIoV1UFtg==
X-Gm-Gg: AeBDievT7nS7JtMrd3IiY32/jUJ3kKZe3orLX1UjnxE/CEVpNwuEg0gNbwuuWfjaudH
	3fV4QVXUH01wdd/dimgbeBScSSfDTywXZCxqdcRW571OXu66sct9hvp8dhKgLlvgkPO01W0faIi
	jZmT++aOCW5pXW+DwSkBSq4jxiNw+KMGd6AvC9z2de47D6mKp1RHkpya0167eiacyCnYbBX8Qcy
	SfCNHHipmeK5MFpSjP8CPfiZn579tpxUPsKHuSysovb3UKYFaA7sekguIHNW8TuQuvnykrb/nwu
	GHc8MhFhye7unrZnf69PocmjBvvOtXbxth0e5hkz04EP0+7pJe3C45ADmxl5Xb3YsUDFkM/s+F6
	3YAVzROWtz/Ol2+LjA/aNPiumUN2RUOIdYwbDMna0okMKgDvSizqeNCaQv7naib2P1qutlbMAhY
	XgUh784Yp65UJXFNgLypoaQ86gm87xCmh+UmVcVBRnoM4TdJXNDmptCbRxCWbK2IiEAbVZb2IlN
	N2CYQ==
X-Received: by 2002:a17:90b:52cf:b0:35f:b784:d3bf with SMTP id 98e67ed59e1d1-361403adbadmr381106a91.1.1776382506526;
        Thu, 16 Apr 2026 16:35:06 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410a7a9fsm33438a91.12.2026.04.16.16.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 16:35:05 -0700 (PDT)
Date: Thu, 16 Apr 2026 23:35:00 +0000
From: David Matlack <dmatlack@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Sean Christopherson <seanjc@google.com>,
	Vipin Sharma <vipinsh@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] vfio: selftests: Find devices that have VFIO
 selftest drivers
Message-ID: <aeFyJBjmJ3jYB02q@google.com>
References: <20260414230943.41198-1-jrhilke@google.com>
 <20260414230943.41198-2-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414230943.41198-2-jrhilke@google.com>

On 2026-04-14 11:09 PM, Josh Hilke wrote:
> Add a new script, list_devices.sh, which prints out the
> segment:bus:device.function numbers of devices on a machine that have a VFIO
> selftest driver. This makes it easier to determine if the system is capable of
> running VFIO selftests, because devices that have a VFIO selftest driver are
> compatible with all VFIO selftests.
> 
> Example:
> $ ./tools/testing/selftests/vfio/scripts/list_devices.sh
> 0000:6a:01.0
> 0000:6f:01.0
> 0000:74:01.0
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>

Aside the nit below, looks good to me. But would like to get Sean's
feedback too since he requested it.

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  tools/testing/selftests/vfio/Makefile         |  1 +
>  .../selftests/vfio/scripts/list_devices.sh    | 22 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
>  create mode 100755 tools/testing/selftests/vfio/scripts/list_devices.sh
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 8e90e409e91d..d48ac967f1dc 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -15,6 +15,7 @@ TEST_GEN_PROGS += vfio_pci_driver_test
>  
>  TEST_FILES += scripts/cleanup.sh
>  TEST_FILES += scripts/lib.sh
> +TEST_FILES += scripts/list_devices.sh
>  TEST_FILES += scripts/run.sh
>  TEST_FILES += scripts/setup.sh
>  
> diff --git a/tools/testing/selftests/vfio/scripts/list_devices.sh b/tools/testing/selftests/vfio/scripts/list_devices.sh
> new file mode 100755
> index 000000000000..b56fa23d5657
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/scripts/list_devices.sh
> @@ -0,0 +1,22 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# List of devices which have a VFIO selftest driver
> +DEVICES=(

nit: Use readonly here.

> +	"8086:0b25" # Intel SPR DSA
> +	"8086:11fb" # Intel GNR-D DSA
> +	"8086:1212" # Intel DR DSA
> +	"8086:0cf8" # Intel CBDMA
> +)
> +
> +# Print the segment:bus:device.function numbers of PCI devices that can be used
> +# to run VFIO selftests.
> +function main() {
> +	local vendor_device_id
> +
> +	for vendor_device_id in "${DEVICES[@]}"; do
> +		lspci -D -d "${vendor_device_id}" | awk '{print $1}'
> +	done
> +}
> +
> +main "$@"
> -- 
> 2.54.0.rc0.605.g598a273b03-goog
> 
