Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF1334688
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861397; cv=none; b=ntZYPI9NMTsdv4xVhKPE1EvEXDbxX8dTPo3xmmOfjZENBvoL944oCVrzhY08Vmm2D3dD0mpVwq2k2+hRUbQ7zcHRPl73nAKO0HcA5pYqgJKNx7pQ+5QnfHU/OmodOSSs6ZiQy4KTMtwmB+qqe465zlPru75ETl73IpkEcyA/O1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861397; c=relaxed/simple;
	bh=64G/HZlnttl1hOl+ny+PHRUSlzFks9sd2njYjb4o00g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afGVF6/ohkmJy1YWTQSrqS/UnfeCZralmZRetAPGFGFxkDCP2qE7kcB3hLmCrzk5GRnww39RDYFb6m2mCFq5M8G29UPH8qlsV6ciGeRQV/rcfCdMpLKnKR1PfnLo41w9J+rHj7gI2Pg/tE/ywt+BYFLGtFFn3Xv2QwTX6FNa2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NQ5bKyJ1; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQ5bKyJ1"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c20010f10so6497175c88.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775861395; x=1776466195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ohdxTjV33OOUB3WjGB+FykFCNcpu8iYa4Zz1gdjkPto=;
        b=NQ5bKyJ19L9qtArNdisSbsLPqq8/sNrJpbnGREMKDveFDK3dI02wMu0xw3chFL59fj
         8efX7wwAEjtlq8OMhpm9/RBvPiQ0ZYuSfy5WcN6VoVG13kPM5PG1C7PGvqwOFUH2Ao52
         yD1e6NPDChp9TVIT4U53cmGMAJfXryvy8KUo20iZf9ieEqFxpcNLYL4ZPrzH2UsDnoAr
         rP3RLjn/g3Zn7IorkNubVfuwUsKbsc0AaevNJj/NvnThVbE/668bygWn9P4ow47dV4/7
         /ui6gAZvWypBEd4qqrP9VwQddtLgIJo6kyPjlJySnLyA4UDCHzbQ6fk438m9KdcRGmxJ
         Wblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861395; x=1776466195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohdxTjV33OOUB3WjGB+FykFCNcpu8iYa4Zz1gdjkPto=;
        b=GoFkuYgYqQQWecAytsMqoGUBj3+5Gu0Sc8GqjVnlUtNWGqCjsndUvPYlbm/Zso10RW
         F4PAp2kZPxq81AzhVcoMTWV+5rg1OHCW8u+6383bO4jYB6qM7Ld6TYqB56Z1TjNFvhfS
         hK5G2LL5USb79YnzZIa3lkt1kpD9pUZ5iJk4OCF4WuOjqODWEaZ0MyviX4ljX2dVuI4S
         STvJ3Ry+QTUughnFWShDJ1y3qIV6bm1+j3ke39NYfbyRjX6Ak+jjFu9GuVSxuKuoPO6z
         HkK0DCMZR1y3hKXBdQeeMbLcf80ioAPaPKeSlcuOHhRPT+bC3kO/g+oTKYaf124pQySi
         rUFg==
X-Forwarded-Encrypted: i=1; AJvYcCW8BfX00glQpcMZEB/1I2YHoXiHnjUaIHLT90W9+U0UOQO3BT3N/r6+Owe80vfq9k/4Pa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5zTjtA2NXD4eEOfAEvL88N8m10pux43AYp/4HXF7VA8L+eP0b
	Ft7I6EcU9dvKX9bYkme3eQBollKjPdcJUWWT2V2bgq0gPrBURvoeEjbht0yMTgguog==
X-Gm-Gg: AeBDieua9ulTP849df5dXLjG/Y2E0saf83tngsCxGFr2Lk/yfVChEz/Ktz7zFOG93lx
	tIE7GP/E420QU4bluiEhi+E4pn7N355ItNoNiORclgZ060Fxww34970l5+LPtCBDENwweQtzDHz
	lk8czSUrNHJbAt8HbJJ/uf3squK4w4xfUfr46oDTm0yGBrW82Dwct0jEQXwEaBfRDmmiPFzIhYK
	GmGSgBDadY8hzZzm94pWsPH0wUusXXHrJUMEkgg9dwsbjW5GGqWSdIEOGsPCvHjvaId8GoaAVfI
	gk5WNSivc/ytoS8SLe7MrZcRcLy15OQBpwqdtAtQiqDpNt6ux3DZwSmzYnChUeYZviKsmyAMtzY
	lrNlhkAuMzo5386yVdUSFKK1xiRN3S076EbDQVZNk5tU3yXI+yydkYP+kHgdP8gZPQpm8x+ygH9
	VWVjoMOUf8dQfiLuhXGQDyd81PQ2/nHZ2/Ch90kr0jSwajsSIng7nshHcUmY7kKjQH4Wg=
X-Received: by 2002:a05:7301:1f10:b0:2d3:2983:c895 with SMTP id 5a478bee46e88-2d5879944aamr3271952eec.7.1775861394995;
        Fri, 10 Apr 2026 15:49:54 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561bde717sm6329546eec.19.2026.04.10.15.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:49:54 -0700 (PDT)
Date: Fri, 10 Apr 2026 22:49:49 +0000
From: David Matlack <dmatlack@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, seanjc@google.com
Subject: Re: [PATCH 2/2] vfio: selftests: Automate setting up devices for
 testing
Message-ID: <adl-jZhpu8R2mZVR@google.com>
References: <20260409015139.2800185-1-jrhilke@google.com>
 <20260409015139.2800185-3-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409015139.2800185-3-jrhilke@google.com>

On 2026-04-09 01:51 AM, Josh Hilke wrote:
> Update the VFIO selftest setup script to find a device that has a VFIO selftest
> driver on the system, and set it up (i.e unbind that device from its driver, and
> then bind that device to VFIO).
> 
> This makes the process of setting up a device to VFIO selftests much easier, as
> users don't have to manually figure out which device to use.  Though, users can
> still manually setup a device by passing the -d argument with a
> segment:bus:device.function number.
> 
> Example of automated device setup:
> 
> 	$  ./tools/testing/selftests/vfio/scripts/setup.sh./setup.sh

Script path here got garbled

> 	+ echo "0000:6a:01.0" > /sys/bus/pci/drivers/idxd/unbind
> 	+ echo "vfio-pci" > /sys/bus/pci/devices/0000:6a:01.0/driver_override
> 	+ echo "0000:6a:01.0" > /sys/bus/pci/drivers/vfio-pci/bind
> 	Successfully set up 0000:6a:01.0
> 
> Example of automated device setup where no compatible devices exist:
> 
> 	$ . ./tools/testing/selftests/vfio/scripts/setup.sh/setup.sh

Here too, also the extra '.' before the path looks like a mistake.

> 	No available supported devices found on the system.
> 
> Example of manual device setup:
> 
> 	$  ./tools/testing/selftests/vfio/scripts/setup.sh -d 0000:6a:01.0
> 	+ echo "0000:6a:01.0" > /sys/bus/pci/drivers/idxd/unbind
> 	+ echo "vfio-pci" > /sys/bus/pci/devices/0000:6a:01.0/driver_override
> 	+ echo "0000:6a:01.0" > /sys/bus/pci/drivers/vfio-pci/bind
> 	Successfully set up 0000:6a:01.0
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>

Please add Suggested-by tag for Sean and also Cc Sean on next version
of the series :)

> ---
>  tools/testing/selftests/vfio/scripts/setup.sh | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/scripts/setup.sh b/tools/testing/selftests/vfio/scripts/setup.sh
> index 2cde07eb9c8b..6d4492b211ea 100755
> --- a/tools/testing/selftests/vfio/scripts/setup.sh
> +++ b/tools/testing/selftests/vfio/scripts/setup.sh
> @@ -19,11 +19,30 @@ function print_supported_devices() {
>  	done
>  }
>  
> +function pick_device() {
> +	local bdf
> +
> +	while read -r bdf; do
> +		if [ -n "${bdf}" ]; then
> +			if [ -d "${DEVICES_DIR}/${bdf}" ]; then
> +				echo "${bdf} has already been set up, exiting." >&2
> +				exit 0
> +			fi
> +			echo "${bdf}"
> +			return 0
> +		fi
> +	done <<< "$(print_supported_devices)"
> +
> +	echo "No available supported devices found on the system." >&2

I think we should make it clear what "supported" means in this log. This
is about finding a device that has a VFIO selftests driver, which is
only required by some tests.

Same goes for the -l option in the previous commit actually and the
usage message below.

> +	exit 1
> +}
> +
>  function usage() {
>  	echo "usage: $0 [-l] [-d <segment:bus:device.function>]" >&2
>  	echo "" >&2
>  	echo "  -l  List segment:bus:device.function numbers of supported devices." >&2
>  	echo "  -d  segment:bus:device.function to set up." >&2
> +	echo "      If -d is not specified, a device will be automatically picked." >&2
>  }
>  
>  function main() {
> @@ -46,8 +65,7 @@ function main() {
>  	done
>  
>  	if [ ${#bdf_list[@]} -eq 0 ]; then
> -		usage
> -		exit 1
> +		bdf_list=($(pick_device))

Sashiko thinks this will ignore any errors from pick_device():

  https://sashiko.dev/#/patchset/20260409015139.2800185-1-jrhilke%40google.com?part=2

>  	fi
>  
>  	for device_bdf in "${bdf_list[@]}"; do
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 
