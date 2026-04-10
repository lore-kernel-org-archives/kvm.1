Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3D93E0C65
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860848; cv=none; b=qfo01hLzmtqW18WB822K9P/c2z3i0+yaJcPsQzSIl5xBPUeQIdzhtrXnroLnK+WOztiYpzsWa9CEHoL7xknK9OSwYeZxsJ9PWxjLmRC14DvPXNFAL7jwAWmGs8x00RM5DB3pO+bsaoHzL61rTvknxbfNrsE8p+1AJx5CwTbqbJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860848; c=relaxed/simple;
	bh=tzOUR/LjuCfGJr/mVgqXlCaulTU4vWiEidNGpq4dce0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zk28ilqsgNnEYibBggQTwCoe8zEBAM7pPCZOe2tW0ttt3eg/oIwytBR+nswyu7JCB+vhR9lD69NAtbb2I0z2KnlePvOZcVZNXOwxVU90YvQpv7zVfSxrb6JBXgSErznQRvtHHl8U+q3wm62ggzJTZXqW93ZBEa2s6WvEUq67FCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdlL5Ev7; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdlL5Ev7"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso1430443eec.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 15:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775860844; x=1776465644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8slB+3H8dMazOpqXNIOvI2WoIOKP4mrqv8umSrDoEpw=;
        b=fdlL5Ev7i81anTLA6eZa20w8wwt/JCbMjoPAZ3/1pTwE9vL4VV72IF7ZqMKTK6mmqA
         3ElnzZXjV/BBpkuoIEkyGqAo7ATqX2q4ut9C7+AJFufewWQJrlvWd1CtBF/RHducb9aa
         4qNw4WrOS8nRhkkKiT7XFwMISwITVxG+5Fgd6ORCb5O34fhb5ZYEIxNCuVeVGm5rqC4R
         3Tp3Psg4uQEq0t53pUUxul9zSBPCGRqlQaJt31NXxTl9KbhRJwcOwKNLV7rEW0zfaSDe
         WwM3FTaJU+42RB+Tk7PtF+ENC874GWi1BzVE97S5f/GKQGiGiu3Psr4xt4CCHRCUpzEq
         96iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775860844; x=1776465644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8slB+3H8dMazOpqXNIOvI2WoIOKP4mrqv8umSrDoEpw=;
        b=YNf6oEX3SYkmY1nNo/uLqFapRJPqwFlH7BfwUeSVrHs6uMPJh5kwogRtXyJqB+AFuk
         W4x139E9aIgNIQCL1/NxDZb/VEVuQWdWUBSTYuQ7ROPe/kpSt2mxxvZwStICNQAeeLTV
         IYkQNlAeYRaqbaq3ykuIWsVroPKI4b7rntuz/JeojyJIiXU8h1JGzon/o0zvydii2XdG
         a7h7+YqTeHvHFStw501kXM/dAelwM73YrI9appfO9q72w5381VjtPt/t0g2LS5gAe3ZB
         LzkMG1+Cv955xohUWcbFeYcBFLdCznaLURwtra6vMnVJqkMD7FPutlK6ooqxfvJncuik
         R00w==
X-Forwarded-Encrypted: i=1; AJvYcCXGUkckYj+jaWEUJp9DeV5cUFYa0oLuABpxIv9l0La4oG+edZovCcl90oKugvb4n0pNAMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWZYqchIVtIahCEF6SxBRahGpFuGfHeTYZXbggVLehtlyG7lu
	XrEwJ5tjlsnbjQrUYNGK0TpKENISAKbLezbmJKhHbyWAiOSaGMG1DgfFVLexxaH2tQ==
X-Gm-Gg: AeBDievmSBjZI56eLpja6Z6IV/GqFKCrKcgql27mRrFg9/5YeDSK0nO6HWmSJX5zU2A
	J9OoAvbTBTmOQmXRheg5GKiTAah+EPMtLozjtMeaaSZT75hLAt18qQY4Cljd1c3L2I2+AWtKb1s
	2rm2aM3kDpTRlAacKb6AvAClGZ+hcbZww3QCDBEwpZ7+d4sGNAg43ryCjHkYX4mjE9D484nlkjq
	MSOSAGCaKfqLJJofgn/dtgOZFj5cmBTGsfRUNx1Q3As61EPpVUHguSLSeYFjMBvK9nMFd0xDUSN
	ZrLPdyH/2VbWx5YxTGfLRX3EsmWIxivTPqSDDgTDUCJSRnfoVOF622uYdBy8ZO3GxSETvFgVRB5
	8UaE0eUnqnaQF405VKQHnLT/nxiBwWw5rI5cU6SmPHoiyYcsR/5LYLe9g0rxDPB+YfPARIBb17B
	i4KFL7sq1LY8RNFC1OoefrKd6HpmVi7Y/qmFtby7iRK+ZyoRJKgNSNpBakuFnWqdvx4pAv8xFLX
	+pbLg==
X-Received: by 2002:a05:7300:a90b:b0:2c7:6218:9830 with SMTP id 5a478bee46e88-2d59b5b3b34mr2205147eec.11.1775860843901;
        Fri, 10 Apr 2026 15:40:43 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69b3sm6302440eec.1.2026.04.10.15.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:40:42 -0700 (PDT)
Date: Fri, 10 Apr 2026 22:40:38 +0000
From: David Matlack <dmatlack@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vfio: selftests: Find devices that are compatible
 with VFIO selftests
Message-ID: <adl8ZlgM9JEtV_Vx@google.com>
References: <20260409015139.2800185-1-jrhilke@google.com>
 <20260409015139.2800185-2-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409015139.2800185-2-jrhilke@google.com>

On 2026-04-09 01:51 AM, Josh Hilke wrote:
> Update the VFIO selftest setup script to print the segment:bus:device.function
> numbers of devices on the user's system that have VFIO selftest drivers (i.e.
> are compatible with the VFIO selftest infrastructure). This makes it easy for
> users to quickly find devices that are compatible with VFIO selftests.
> 
> Example of how to list compatible devices on the system:
> 
> $ ./tools/testing/selftests/vfio/scripts/setup.sh -l
> Supported devices:
> 0000:6a:01.0
> 0000:6f:01.0
> 0000:74:01.0
> 0000:79:01.0
> 0000:e7:01.0
> 0000:ec:01.0
> 0000:f1:01.0
> 0000:f6:01.0
> 
> Example of setting up a device:
> 
> $ ./tools/testing/selftests/vfio/scripts/setup.sh -d 0000:6a:01.0
> + echo "0000:6a:01.0" > /sys/bus/pci/drivers/idxd/unbind
> + echo "vfio-pci" > /sys/bus/pci/devices/0000:6a:01.0/driver_override
> + echo "0000:6a:01.0" > /sys/bus/pci/drivers/vfio-pci/bind
> Successfully set up 0000:6a:01.0
> 
> This makes the script much more user friendly so that no one has to dig
> around in the VFIO selftest libraries to figure out which devices can
> run the selftests.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>  tools/testing/selftests/vfio/scripts/setup.sh | 43 +++++++++++++++++--
>  1 file changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/scripts/setup.sh b/tools/testing/selftests/vfio/scripts/setup.sh
> index 49a499e51cbe..2cde07eb9c8b 100755
> --- a/tools/testing/selftests/vfio/scripts/setup.sh
> +++ b/tools/testing/selftests/vfio/scripts/setup.sh
> @@ -3,18 +3,54 @@ set -e
>  
>  source $(dirname -- "${BASH_SOURCE[0]}")/lib.sh
>  
> +# List of devices which have a VFIO selftest driver
> +DEVICES=(
> +	"8086:0b25" # Intel Data Streaming Accelerator

Please also add the new DMR and GNR-D DSA devices that were added
recently:

  https://github.com/awilliam/linux-vfio/commit/c82cfe15916d33e89c2d2efeeb624e8c9c2c4ca8

> +	"8086:0cf8" # Intel CBDMA
> +)
> +
> +function print_supported_devices() {
> +	local vendor_device_id
> +	local id
> +
> +	for vendor_device_id in "${DEVICES[@]}"; do
> +		read -r id <<< "${vendor_device_id}"

Sashiko seems to think the read here is unecessary.

  https://sashiko.dev/#/patchset/20260409015139.2800185-1-jrhilke%40google.com?part=1

> +		lspci -D -d "${id}" | awk '{ print $1 }'

Let's print the whole line and let the user parse out the BDF with awk.
That will let the user see which type of device it its rather than just
raw BDFs.

> +	done
> +}
> +
> +function usage() {
> +	echo "usage: $0 [-l] [-d <segment:bus:device.function>]" >&2
> +	echo "" >&2
> +	echo "  -l  List segment:bus:device.function numbers of supported devices." >&2
> +	echo "  -d  segment:bus:device.function to set up." >&2
> +}
> +
>  function main() {
>  	local device_bdf
>  	local device_dir
>  	local numvfs
>  	local driver
> +	local bdf_list=()
> +
> +	while getopts "ld:" opt; do
> +		case ${opt} in
> +			l)
> +			 	echo "Supported devices: "
> +				print_supported_devices
> +				exit 0
> +				;;

nit: Put the echo in print_supported_devices and this can be a one-liner
like the rest of the options.

	while getopts "ld:" opt; do
		case ${opt} in
			l) print_supported_devices; exit 0 ;;
			d) bdf_list+=("${OPTARG}") ;;
			*) usage; exit 1 ;;
		esac
	done

> +			d) bdf_list+=("${OPTARG}") ;;

Let's keep the current semantics where the list of BDFs is passed as
positional arguments. The next commit would just pick a device if there
are no positional arguments.

This will keep the script backwards compatible with current usage and
also keep it simple (no need to pass extra -d flag for every BDF):

  ./setup.sh BDF1 BDF2 BDF3
  vs.
  ./setup.sh -d BDF1 -d BDF2 -d BDF3

> +			*) usage; exit 1 ;;
> +		esac
> +	done
>  
> -	if [ $# = 0 ]; then
> -		echo "usage: $0 segment:bus:device.function ..." >&2
> +	if [ ${#bdf_list[@]} -eq 0 ]; then
> +		usage
>  		exit 1
>  	fi
>  
> -	for device_bdf in "$@"; do
> +	for device_bdf in "${bdf_list[@]}"; do
>  		test -d /sys/bus/pci/devices/${device_bdf}
>  
>  		device_dir=${DEVICES_DIR}/${device_bdf}
> @@ -42,6 +78,7 @@ function main() {
>  
>  		bind ${device_bdf} vfio-pci
>  		touch ${device_dir}/vfio-pci
> +		echo "Successfully set up ${device_bdf}"
>  	done
>  }
>  
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 
