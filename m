Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014C24E4C4;
	Fri, 20 Mar 2026 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773968219; cv=none; b=AXSr6u4Lot4+toBJ3Ki7lXcvqBMhz54GSfF29LYQw1zGHBaPICFwJnEaDQtXfM4Vtdfun9i6UtfcRHD2ejXaDoFYPOMwMWYmPHXQpIEuNmPQVoBALS88SMHjcm+BaMOaWLDhb6W6I1tt7Lt8zhPnEytkNCkm4abMqWwHLZszz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773968219; c=relaxed/simple;
	bh=3e+uEhh9yTt0xKKCisCx8sBU7VSVPw95JvXzYkKKRwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzXEIa5ehxdUg+2scG8ksY2zY0bUd9hTn+pFAZ9EAQ/GNNMn/RZU6XBLggdsE269yU8gmcd2NpSHNgb2bmEyGrCJ0ZPe/U+FR1sYJnBnY6JpUr/qJ6xb107CqVO45EQMlBNp7tUmEj3tqz4rBX1MNc7QcrU3ouGXSr7Wl+X4gLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqjzAXH0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqjzAXH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773968218; x=1805504218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3e+uEhh9yTt0xKKCisCx8sBU7VSVPw95JvXzYkKKRwQ=;
  b=EqjzAXH0g3rHngrVznHK8aQhmEWJz0J12/rrZLvjvaNUOJLurV+dgtFJ
   hkXzyI4+vLw/Nw3L9p3tbrY4ZAdAiSkmGtgzIf1lx9h4yYplRDdDsCFwf
   GFDWA+DRHJSNC1dEsYNP8y9KfKZ3b6lOGK7VcDTYBt5P2M+R2KkuwK4AC
   vwIDZDLsbcV57R13myqE/JJohwdQtnXmb7XhlkJHLTqVu1ZyXh45WhgAN
   j+GksCX8nVG33AqHH5p622u0LAsQmT/L+h/H9yWS0AlqOmCefbVjDBlFF
   axek8JZg91nvoLXD+YE64qONXs0gcHEsgNt7o7I/3UXlQ5OXPf/wxcl6v
   w==;
X-CSE-ConnectionGUID: 59u3rHawQDeQuhh9NkgpSg==
X-CSE-MsgGUID: aPz8z0KbS7+RRzDWVkFtIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74962325"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74962325"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 17:56:57 -0700
X-CSE-ConnectionGUID: ltbLwL2fRhug4PJwEx1xPQ==
X-CSE-MsgGUID: kV2pQ1L9Qe2K9yPm1xrFPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="261026287"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 17:56:54 -0700
Date: Fri, 20 Mar 2026 08:56:50 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: David Matlack <dmatlack@google.com>
Cc: Yi Lai <yi1.lai@intel.com>, Shuah Khan <shuah@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Alex Mastro <amastro@fb.com>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Support DMR and GNR-D DSA devices
Message-ID: <abybUpEljBFylzf0@ly-workstation>
References: <20260319072719.472216-1-yi1.lai@intel.com>
 <abw95W9pCyLF_5n8@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abw95W9pCyLF_5n8@google.com>

On Thu, Mar 19, 2026 at 06:18:13PM +0000, David Matlack wrote:
> On 2026-03-19 03:27 PM, Yi Lai wrote:
> > Currently, the VFIO DSA driver test only supports the SPR DSA device ID.
> > Attempting to run the test on newer platforms like DMR or GNR-D results
> > in a "No driver found" error, causing the test to be skipped.
> > 
> > Refactor the 'dsa_probe' function to use a switch statement for
> 
> nit: s/Refactor the 'dsa_probe' function/Refactor dsa_probe()/
> 
> If you append () to the end of function names in commit messages and
> comments it makes it clear you are referring to a function.
> 
> > checking device IDs. This improves maintainability and makes it easier
> > to add new device IDs in the future.
> > 
> > Add the following DSA device IDs to the supported list:
> > PCI_DEVICE_ID_INTEL_DSA_DMR  (0x1212)
> > PCI_DEVICE_ID_INTEL_DSA_GNRD (0x11fb)
> > 
> > Signed-off-by: Yi Lai <yi1.lai@intel.com>
> 
> Thanks for the patch. Looks good aside from some small nits.

Thanks for reviewing the patch. I will send v2 adopting your comments.

> 
> Were you able to test that vfio_pci_driver_test passes with both of the new
> devices?

I tested vfio_pci_driver_test with DMR DSA device. All tests pass.

> 
> > ---
> >  .../selftests/vfio/lib/drivers/dsa/dsa.c        | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> > index c75045bcab79..0cbc7606d904 100644
> > --- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> > +++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> > @@ -65,10 +65,23 @@ static bool dsa_int_handle_request_required(struct vfio_pci_device *device)
> >  
> >  static int dsa_probe(struct vfio_pci_device *device)
> >  {
> > -	if (!vfio_pci_device_match(device, PCI_VENDOR_ID_INTEL,
> > -				   PCI_DEVICE_ID_INTEL_DSA_SPR0))
> > +	u16 vendor, device_id;
> > +
> > +	vendor = vfio_pci_config_readw(device, PCI_VENDOR_ID);
> > +	device_id = vfio_pci_config_readw(device, PCI_DEVICE_ID);
> > +
> > +	if (vendor != PCI_VENDOR_ID_INTEL)
> >  		return -EINVAL;
> 
> nit: s/vendor/vendor_id/ to be consistent with device_id and
> vfio_pci_device_match().
> 
> Also you can initialized these variables when they are declared to
> simplify the code a bit. e.g.
> 
> diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> index 0cbc7606d904..19d9630b24c2 100644
> --- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> @@ -65,12 +65,10 @@ static bool dsa_int_handle_request_required(struct vfio_pci_device *device)
> 
>  static int dsa_probe(struct vfio_pci_device *device)
>  {
> -       u16 vendor, device_id;
> +       const u16 vendor_id = vfio_pci_config_readw(device, PCI_VENDOR_ID);
> +       const u16 device_id = vfio_pci_config_readw(device, PCI_DEVICE_ID);
> 
> -       vendor = vfio_pci_config_readw(device, PCI_VENDOR_ID);
> -       device_id = vfio_pci_config_readw(device, PCI_DEVICE_ID);
> -
> -       if (vendor != PCI_VENDOR_ID_INTEL)
> +       if (vendor_id != PCI_VENDOR_ID_INTEL)
>                 return -EINVAL;
> 
>         switch (device_id) {
> 
> >  
> > +	switch (device_id) {
> > +	case PCI_DEVICE_ID_INTEL_DSA_SPR0:
> > +	case PCI_DEVICE_ID_INTEL_DSA_DMR:
> > +	case PCI_DEVICE_ID_INTEL_DSA_GNRD:
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (dsa_int_handle_request_required(device)) {
> >  		dev_err(device, "Device requires requesting interrupt handles\n");
> >  		return -EINVAL;
> > -- 
> > 2.43.0
> > 
