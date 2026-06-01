Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB63DE430
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335438; cv=none; b=nbPw9s7teGWINw3FnJPx7xHdcoOJ76bLgNNAYYTpwvLBqYkquiJ7x1n50xn4GvOJqCz5NabqMpFBdcd6Yn8jXzZaajLhCyX7+sodwT2ZpY6fxBp3F7A4K++X1e1k1Q4qFegtER5YQruyk+CuLjTGbCp2VPebLYnwmD+Hvx9yh9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335438; c=relaxed/simple;
	bh=0xurPIo/alkKI0riEvqay5gLBgm0wt9AgRSyEg/9K8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbIW/14fuoay/QxTWceT5Rsg8Pj4VFFiggRUQ+dlZx9v9ZoKZ+twtAZU6aalVlY4GPrhWI5SbrE1MA9WuEVGgqXsvD/nYMTNiKlZ7gqbUiPh5y2BIMEqff4VXanLcdP+f4Af3We+2GLMUJK8cv8otyn5qSMFl4h9QzpatiUbcCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tos/ESRw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tos/ESRw"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf2911f93cso2195ad.1
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780335436; x=1780940236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqySxUeQPPoGSTVfHQ/saO0tBfCLkU/uPgklhMQc/zE=;
        b=tos/ESRw9dy1ZxENTEqG9v3QTwnaMeX91nf5fIN7uaGLBzDIZPa8ArLx5/WHIE/5IS
         Pvlt3KdDINZU45ZE+7d8toGdSn86ZwMZSERId/MbB+/aV9qn1B686geI442/Dx8czEzN
         pde8lTHdYUbzXYGKWcp/DBO/m72J5wqZsrrSl6zfED+Qn4gydjd+S3k3O+esodas/+Ny
         m4f+7Yu0cP0W8RKlKJJVcFr/w3kdeTv5KZ9h//Z3/heHBAxcmIyhr8y/YBag3dwNUUpl
         Mup8UOE2/9WnENIuBCcApquHJgV1VUar/EWc+vZCQ3iVI9ik71gRHiJ9Y/extBb0NQuc
         oNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780335436; x=1780940236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqySxUeQPPoGSTVfHQ/saO0tBfCLkU/uPgklhMQc/zE=;
        b=C0I3PQxyuYbnmM9qx39MQ3zPkaQr1gFhMZxE/efW2NzWEWQK1At+VV8KrKTFX2TOnr
         7zZa0P6h5OKUBMLc88YA2fdQbFL/vKNtFIwsNXNbuG+ZG9mWUtJnUa6Mpk7PkuCxy/RA
         g2Uq/AGl/08v8IWiBXPN2L7RBn4foT7yFk7K+tb57o/VLjUK93BK6+mGUZmB30R6dOh5
         YOoN4bdEr0MryNRjoUc12w0jR0Eazp1wiy/s+GonkjMuZp7GBdOtXqNxJ5GNRCcphgql
         4CITcmcbTGahFmiKouIzTzSfbu88SJHZgeaD+87x+lCgQ4BSSxciaEWN2+ReCulBCIxq
         E92g==
X-Forwarded-Encrypted: i=1; AFNElJ8cnwSEABLm/xJ18fj8up9qcZxw7IimrH1DAeDal7NMut9aVdNQCHayskHKxpEnCGqcAro=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9ge29DSpwwZ2NlAgqdkFWIujJvtVGajfhHd0S1SocqcX7zGD
	9pp1YvHyLw3XkVNRIOKLg3HlAnV92CqQ0zJam1Des4islnyfep3GPgl7KWOZ1G6A9g==
X-Gm-Gg: Acq92OGt/4iSHIW2firSxDSvEOZdlSlaswJFx9wv39z44KcDXpkYPQSwKxzdym4thGJ
	taBWrvh6e1qm6CIe/y1iryMkjEO1THOwLRtvmXEaM5Ztw/IPVd5IP0E0JRjNpURBftCjhbeREtI
	KSNTLVG6GE4lS6lspEhEm+OTdyizsf0rcjiQCXu+cwochfe6KA4P/AeO9qua2F6vw7rMitSamXi
	grp11GrAwIqRpW1OIry6qQFfd8uFaaFlqAoK+5gXGWq3j39cikC5FoQ41uuiKoQOyNo5TT6UKmf
	XjWQz8gqWzSqnglxChkv4NZa9OmMw0tz7nKh1LIIkezc0eMrmogOYJp1gwIk1FpT12hgHAsMT3K
	Q4pURlU7r5XDoDbGFGC7w9Mhb5xL3YuOVfCBOvSIy3GS5Ul0bHauR+kC7WgdB+e6zyJQyVu9h6D
	7BdO1ylSWYEna6YmBiqA2sGoy35en/5QePn1EvaOSTUdUV85WNy7JhF5jQ9GVg2WHxBtT+5pR3P
	Pmfmyo=
X-Received: by 2002:a17:903:8c3:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2c10ec37892mr78735ad.17.1780335435226;
        Mon, 01 Jun 2026 10:37:15 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a0fea7sm106944965ad.29.2026.06.01.10.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:37:14 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:37:09 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vfio: selftests: Find devices that have VFIO selftest
 drivers
Message-ID: <20260601165745.GB2026478.vipinsh@google.com>
References: <20260529180425.4162392-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529180425.4162392-1-jrhilke@google.com>

On Fri, May 29, 2026 at 06:04:25PM +0000, Josh Hilke wrote:
> Add a new script, list_devices.sh, which prints out the
> segment:bus:device.function (SBDF) numbers and names of devices on a
> machine that have a VFIO selftest driver. This makes it easier to
> determine if the system is capable of running VFIO selftests.
> 
> Includes a -q (quiet) argument which prints just the SBDFs so that the
> output can be piped into tools/testing/selftests/vfio/script/setup.sh to
> bind the devices to VFIO to use in VFIO selftests.
> 
> Examples:
> 
> $ ./list_devices.sh
> 0000:6a:01.0 - Intel SPR DSA (8086:0b25)
> 0000:6f:01.0 - Intel SPR DSA (8086:0b25)
> 0000:74:01.0 - Intel SPR DSA (8086:0b25)
> 0000:79:01.0 - Intel SPR DSA (8086:0b25)
> 0000:e7:01.0 - Intel SPR DSA (8086:0b25)
> 0000:ec:01.0 - Intel SPR DSA (8086:0b25)
> 0000:f1:01.0 - Intel SPR DSA (8086:0b25)
> 0000:f6:01.0 - Intel SPR DSA (8086:0b25)
> 
> $ ./list_devices.sh -q
> 0000:6a:01.0
> 0000:6f:01.0
> 0000:74:01.0
> 0000:79:01.0
> 0000:e7:01.0
> 0000:ec:01.0
> 0000:f1:01.0
> 0000:f6:01.0
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
> Changelog
> 
> v3 -> v4:
> - Move argument parsing into main() (David)
> - Use empty string for false in quiet flag (David)
> - Simplify logic to print device names and IDs (David)
> 
>  tools/testing/selftests/vfio/Makefile         |  1 +
>  .../selftests/vfio/scripts/list_devices.sh    | 43 +++++++++++++++++++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tools/testing/selftests/vfio/scripts/list_devices.sh
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 0684932d91bf..777f91f09057 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -15,6 +15,7 @@ TEST_GEN_PROGS += vfio_pci_driver_test
>  
>  TEST_FILES += scripts/cleanup.sh
>  TEST_FILES += scripts/lib.sh
> +TEST_FILES += scripts/list_devices.sh

Nit: Should this file be renamed to supported_devices.sh?

list_devices.sh sounds to me it will list all of the devices. Just a
suggestion.

>  TEST_FILES += scripts/run.sh
>  TEST_FILES += scripts/setup.sh
>  
> diff --git a/tools/testing/selftests/vfio/scripts/list_devices.sh b/tools/testing/selftests/vfio/scripts/list_devices.sh
> new file mode 100755
> index 000000000000..249532f15570
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/scripts/list_devices.sh
> @@ -0,0 +1,43 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# List of devices which have a VFIO selftest driver
> +readonly DEVICES=(
> +	"8086:0b25,Intel SPR DSA"
> +	"8086:11fb,Intel GNR-D DSA"
> +	"8086:1212,Intel DR DSA"

Nit: I think this should be DMR instead of DR.

> +	"8086:0cf8,Intel CBDMA"

Where is this device in selftests/vfio/lib/drivers/*? I am not able to
find it.

Also, selftests/vfio/lib/drivers/ioat/ioat.c has PCI_DEVICE_ID_INTEL_IOAT_SKX
(0x2021) device. Should that be added here?

I think we should write the comment above that DEVICES list is populated
from the IDs in lib/drivers/* files.

> +)
> +
> +# Print the segment:bus:device.function numbers of PCI devices that can be used
> +# to run VFIO selftests.
> +function main() {
> +	local id_name
> +	local quiet=""
> +	local name
> +	local bdfs
> +	local bdf
> +	local id
> +
> +	while getopts "q" opt; do
> +		case $opt in
> +			q) quiet="true" ;;
> +			\?) echo "Usage: $0 [-q]" >&2; exit 1 ;;
> +		esac
> +	done
> +
> +	for id_name in "${DEVICES[@]}"; do
> +		IFS=',' read -r id name <<< "$id_name"
> +		bdfs=$(lspci -D -d "${id}" | awk '{print $1}')
> +
> +		[[ -z $bdfs ]] && continue
> +
> +		if [ "$quiet" ]; then
> +			echo "${bdfs}"
> +		else
> +			echo "${bdfs}" | sed "s|$| - ${name} (${id})|"

Nit: lspci prints vendor and device id in [], and use () for revision.
Should this script also use []?

> +		fi
> +	done
> +}
> +
> +main "$@"
> -- 
> 2.54.0.929.g9b7fa37559-goog
> 
