Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F23438BA
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213718; cv=none; b=gAJ4lrEcXVk4jYoUtcilbEr8HFW4EzrtBHsKnsGhSEUrAYq7DRM6b7LhrM4lCr+jFqoTz7EW6rstfIUtbkuKe51EVcK6L5/TptZkmbUF2A7mACcQ7ipT3YY2qmDPYZmfDT1jzXoXFEP47/N8T6GhE2zYBEe2Thr6ofRF2LIeg+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213718; c=relaxed/simple;
	bh=e4kk50Be8aXDcQplMn+i32p43VgE25pg4w/kUoSDVP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD+IvA239iBJOCdtTfdIjL0SBxc4zQ80zN5JARCFZ6MwGl/EdmLEAE97g40K+D2fLxLjQlB6Ub7Ac8gZQ3hsXfVZeUYdjuE0HNGgHMKE1DZRvsRyU+o5krwdErrEHwuHHhQHaKvF5zccboUNMeHLFrStXeO6q/vkPuNkCPhqx10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XkfVi8zm; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkfVi8zm"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso1689468a12.0
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779213715; x=1779818515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0tshnSftDumfUObHoSJ/HpWYdPspPnCxn7clHRCbcA=;
        b=XkfVi8zmuqmo9+W7S6HTWEnH2yqoIbozMSP5DC3tnNysqMn2C/9D1arwDDHxKMsxD3
         LlMTTE1dn96Rvu9YH1o11loBWSIukkOzmN7p1eszE71qkDzeuylE/2nwngAtsyvvEifU
         w71AJkQF1u+3rynk8MBHftddDzFnkcd888PUGknL+KBnnfJsEh+vkLLoy7XdHZl8yYOb
         mEEInUhNDqnItdEnFo6lllJDTUCs1N7XUCuf3o61UJ1NDwUdwHsKfhpkdSQ7oRaK6TlQ
         akES2mykig9sKpJR/ZiIQbHPcZTbrIJ07gsiWcUNclxL236PRSSZsU8fKiG/0lq2aaiy
         ZPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779213715; x=1779818515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0tshnSftDumfUObHoSJ/HpWYdPspPnCxn7clHRCbcA=;
        b=eajuMLsWkoh5ku3jV9Z2kBXdvwKJnchktbB/6bv8BQiV3Khj56DSz2N+GQnHn1YqX7
         pxxT+L2DCUwalw1Oe14iX+KLCrPZ6S9O0qDF0K/2LvF6ZSE374rqX8WlpCYD7N3xGA7y
         WE7gICmpQiRXDnTPDHg5kF1NXcIoyY+ruWtwAcECx0FjK/bm0i74vgUfHJDObJQBNk53
         Sy3Xaomea4B45ik+rmr7dthXGSixNa/PN932Dpe3O/3Ey2USaq7F0JzOQai0hmjq/ZWB
         Bs31H7yaqm5ZZNTfCcl6pRR9hvTm+ZhyKNa8ewP5jnGs/0oWjUQ7ASyxYRmVDxrKWMug
         MB2g==
X-Forwarded-Encrypted: i=1; AFNElJ+cjfvHZR/xkQJsgXhobrYLxjXUpeHC99/72lS7Ushx4bbBiMturgl5tFvL9mh6VLLovNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqqrh145nu7CjJaDap9sovgNKP3O2RzxYTRafUO1G5KkrrGlum
	OoepZ0Sy9ru5eglHhPWJMH/gQ5HypyE0gyJi8d4a7Tigy2r225Tg41HQ5TZZA2chtw==
X-Gm-Gg: Acq92OEBXhAs0TmueSY14Yf6qcOFn0e1dHAVsO6LdoWwIZQ3bW9HejwskHCJyDOUPXu
	i0UQBPnE8alpSwgXrmcUDZDrI9idA4PRJaVIHeB5QyJr4o/gPKbRBdNvxyjGr+BI82/twBpVDPJ
	wvnVfyPUJouP9SkWoGOx677GJS6FnUb++m59odSiAXkNue8LQYLnHu1+VY3IjNMKjnftUwXLAOx
	RxR9JZqX2JgPoUrIDjmGHdFJgOt1Lx1cQ8JdD4UcrhMsE3xP7hhRLlT9BsoqP/43ZHgP4IELz4d
	HWOukBe33dBhBnzHT5lL6ijZKKGfCUGpws/hu8TOhnq3Gm4+0yw2Q5RGk9XJYVJcjridoJ0O2uh
	DUKrfV5kOv+GGEcMgma4FvJPtg4Izy4n8v5fqIVo9mlu+zxjyQIYPGdwA9r/HxhzKLODRaNS0rd
	1RTfoCmfiZ0kxOQk65eQnng66EaQ5b2v4EG3jmZDu5+BPvbto4FS7B2965kHlCBLg3f+b4crhG
X-Received: by 2002:a05:6a20:7f9a:b0:39f:4d08:7555 with SMTP id adf61e73a8af0-3b22e7c65f4mr23894450637.5.1779213714187;
        Tue, 19 May 2026 11:01:54 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb114c08sm18183837a12.23.2026.05.19.11.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:01:53 -0700 (PDT)
Date: Tue, 19 May 2026 18:01:50 +0000
From: David Matlack <dmatlack@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Sean Christopherson <seanjc@google.com>,
	Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vfio: selftests: Find devices that have VFIO selftest
 drivers
Message-ID: <agyljom7lr8rhcFv@google.com>
References: <20260515030758.1203256-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515030758.1203256-1-jrhilke@google.com>

On 2026-05-15 03:07 AM, Josh Hilke wrote:
> Add a new script, list_devices.sh, which prints out the
> segment:bus:device.function (SBDF) numbers and names of devices on a machine that have a
> VFIO selftest driver. This makes it easier to determine if the system is
> capable of running VFIO selftests.
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
> Changelog:
> 
> v3:
> - Show the names of the devices (Sean)
> 
> v2:
> - Move the functionality to discover devices from setup.sh into its own script (Sean)
> - Omit the patch which automates binding devices to VFIO (Sean, David)
> 
> v2: https://lore.kernel.org/kvm/20260414230943.41198-2-jrhilke@google.com/
> v1: https://lore.kernel.org/kvm/20260409015139.2800185-1-jrhilke@google.com/
> 
>  tools/testing/selftests/vfio/Makefile         |  1 +
>  .../selftests/vfio/scripts/list_devices.sh    | 46 +++++++++++++++++++
>  2 files changed, 47 insertions(+)
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
>  TEST_FILES += scripts/run.sh
>  TEST_FILES += scripts/setup.sh
>  
> diff --git a/tools/testing/selftests/vfio/scripts/list_devices.sh b/tools/testing/selftests/vfio/scripts/list_devices.sh
> new file mode 100755
> index 000000000000..8e7cbe5b7449
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/scripts/list_devices.sh
> @@ -0,0 +1,46 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# List of devices which have a VFIO selftest driver
> +readonly DEVICES=(
> +	"8086:0b25,Intel SPR DSA"
> +	"8086:11fb,Intel GNR-D DSA"
> +	"8086:1212,Intel DR DSA"
> +	"8086:0cf8,Intel CBDMA"
> +)
> +
> +QUIET=false
> +while getopts "q" opt; do
> +	case $opt in
> +		q) QUIET=true ;;
> +		\?) echo "Usage: $0 [-q]" >&2; exit 1 ;;
> +	esac
> +done

Please move the argument parsing into main().

> +
> +# Print the segment:bus:device.function numbers of PCI devices that can be used
> +# to run VFIO selftests.
> +function main() {
> +	local id_name
> +	local name
> +	local bdfs
> +	local bdf
> +	local id
> +
> +	for id_name in "${DEVICES[@]}"; do
> +		IFS=',' read -r id name <<< "$id_name"
> +		bdfs=$(lspci -D -d "${id}" | awk '{print $1}')
> +
> +		[[ -z $bdfs ]] && continue
> +
> +		if [ "$QUIET" = true ]; then

nit: Consider using empty string to represent false so that this can
just be:

  if [ "$QUIET" ]; then
  
> +			echo "${bdfs}"
> +			continue
> +		fi
> +
> +		while read -r bdf; do
> +			echo "${bdf} - ${name} (${id})"
> +		done <<< "$bdfs"

nit: This can be a simpler one-liner and also moved into the else case
of the if above to make the execution flow easier to read:

  if [ "$quiet" ]; then
          echo "${bdfs}"
  else
          echo "${bdfs}" | sed "s|$| - ${name} (${id})|"
  fi

> +	done
> +}
> +
> +main
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
