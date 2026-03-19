Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361EE39903C
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944300; cv=none; b=obUUzV9tTia9WxxTfLIhpEIiwh7V8f7LVU0T5CqwzPOK0fWeUEZbf4hAK5RNQH8miSXnZ2ENFZWHDO/84JdmcrlI+5KmJHUsWIcvLFTlGxce13veWTYEFTz6A5DeNYvz6iyROBTACsBkCExVLqIXT2W3wWp+gOlvzD0tJW/ZT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944300; c=relaxed/simple;
	bh=ks0M/klZENCM5dZMeKF033TXPM1stqWEgRH+1plE3FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/shx6Y/4oQLDy5gXY6eD83I+xe+9UTRB3fK9rNWIl/e8KVlyivJ0M8BQ+aLrsS6QoS5wDgnmrujxxMAm1ufEFGPalD5HtNutBKhJabDICLQq1GqsmKkfO2BFLsipHwtjkZbtu9iev+p3Q0Q1EucffXxf+sdX/zbjoVpKmrTxlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NE1QxMU7; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NE1QxMU7"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c648bc907ebso751539a12.3
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 11:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773944298; x=1774549098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+aMRchp8AKKMlv02F6neHZa+UurEBvVp2lJmGUVOIYQ=;
        b=NE1QxMU7LlmjNMpsIopylaPm56FU0I+TpunRKrWMw/PQE+E59SU35XwT/3SZBHmwnI
         LZztziSBYjnehnfajUTEVc2epOW3GRDBsq8YHuU+HYIjRfVX0LHO2Zz5ZBZ002EcbhZT
         ZgW2oMxUiIpxTf+mRyeLfMBTJarZiYdUu9QfPOtr8e9+wxms4DD2FgOH1hxXfHBc1j1+
         EiJqMAgtNQCSOGIJSgJhlMqVUA6Mw2Pe/rjSS52ueEGb53J1GPVHLH9rTeKcQigQdtvI
         iHzDnMOZB/0SCO6FLPj4Lq6WRymIFZ+xxbpr+koBQATHqOSxqrXW8w1yZ6KAM5KeAoGs
         uG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773944298; x=1774549098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aMRchp8AKKMlv02F6neHZa+UurEBvVp2lJmGUVOIYQ=;
        b=Ce79jZyrygcRZkbMmNAiJBb//2XVAv2AMXZyJOCaZnxPFWQ5m6QFDR7/2VSi/1gDFh
         N/Om6HVkFLqPgElzF8roqOkvXVlLeruZsFjLjcEEpTP8zzWunChAX0w5DUhjqHvJV0EZ
         Vql9RLr/Iy7UxKAk7Ej+cU213TCdsS/IuyVr3ifBSd+uLZRehw1u2GNXkvik72Tr4u7N
         eesxDR/q3ZR9rAx4TECXzPnWdFx9uhJQos3TAWKddfTAW6ZCKx43Lrq+ApbFJb37546m
         tye/OSpU2GFPw4SvEkO66pJwscYmwD25wuVQfH7hlPnRzd2c3evAQTx4tCGpfLUYJ3PW
         RmtA==
X-Forwarded-Encrypted: i=1; AJvYcCX0zWbz68BPZgM5kqXcWxsOEVO/GeaaTHuc7lAfoiJIngY2GvbALsUYM6jvKYw6VvraiIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHvcmVzrEto5HD/1m7/+xGk9wfAN8jNpNHbuaA/8vxxjtS58wb
	TU9QpiCgm7leLumRELCqG+ct4Q/p7bisUzU1Non2+UQ/yhcZXZtfj6KC9s6UDslj8g==
X-Gm-Gg: ATEYQzxpn6gSXZerAh+yKPoFCE+QV4IiwFvTFUiCKY0v8EpefeIeF8kY+whLGs0Q6D7
	ctkFmqbFu1TyRbctX1fOhmEVohVBlzsFEeHtN5VeWfrsH4ZTeq1Fbsjzvg08K3muvrm4SeXGg/l
	qZDABoEtzIw1sUqTvBdJzJyLHZULVyH/K4fN2yZgtrCPIbTRitYo8oakMD3BD0txtd4qoc9LnZt
	ifXsJ9kZRfHZWr6hJ8EPeiuzYZT9mF65QePk3q0Lwqf5iLxwxC17IsjmXR44+YFqcQVbqOudNeW
	2Kc5/Ma9d6fI32hLVANCPm2vN9i4BuaDTPklYiLY0ZaT8OTgMrM2xNjALGk1BTPtfO+w+JGvSuZ
	umgzf+5Jvms3X71fiOWbwBUnagVZvexTNyYKPXn8XArrzGbxHY3MGNtrWZngToi6g2+FMGDBTj1
	rduDU2L2E34/KmNGcJbDyXEh3EjutUClwNY21C9Z3e4iGPXYvkDZOU8tQsJalKCZ9eyMEPz0ra
X-Received: by 2002:a05:6a20:6b9d:b0:39b:83cf:ebb0 with SMTP id adf61e73a8af0-39bcec0675cmr234015637.66.1773944298146;
        Thu, 19 Mar 2026 11:18:18 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443cc2ddsm64311a12.24.2026.03.19.11.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:18:17 -0700 (PDT)
Date: Thu, 19 Mar 2026 18:18:13 +0000
From: David Matlack <dmatlack@google.com>
To: Yi Lai <yi1.lai@intel.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Alex Mastro <amastro@fb.com>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Support DMR and GNR-D DSA devices
Message-ID: <abw95W9pCyLF_5n8@google.com>
References: <20260319072719.472216-1-yi1.lai@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319072719.472216-1-yi1.lai@intel.com>

On 2026-03-19 03:27 PM, Yi Lai wrote:
> Currently, the VFIO DSA driver test only supports the SPR DSA device ID.
> Attempting to run the test on newer platforms like DMR or GNR-D results
> in a "No driver found" error, causing the test to be skipped.
> 
> Refactor the 'dsa_probe' function to use a switch statement for

nit: s/Refactor the 'dsa_probe' function/Refactor dsa_probe()/

If you append () to the end of function names in commit messages and
comments it makes it clear you are referring to a function.

> checking device IDs. This improves maintainability and makes it easier
> to add new device IDs in the future.
> 
> Add the following DSA device IDs to the supported list:
> PCI_DEVICE_ID_INTEL_DSA_DMR  (0x1212)
> PCI_DEVICE_ID_INTEL_DSA_GNRD (0x11fb)
> 
> Signed-off-by: Yi Lai <yi1.lai@intel.com>

Thanks for the patch. Looks good aside from some small nits.

Were you able to test that vfio_pci_driver_test passes with both of the new
devices?

> ---
>  .../selftests/vfio/lib/drivers/dsa/dsa.c        | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> index c75045bcab79..0cbc7606d904 100644
> --- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
> @@ -65,10 +65,23 @@ static bool dsa_int_handle_request_required(struct vfio_pci_device *device)
>  
>  static int dsa_probe(struct vfio_pci_device *device)
>  {
> -	if (!vfio_pci_device_match(device, PCI_VENDOR_ID_INTEL,
> -				   PCI_DEVICE_ID_INTEL_DSA_SPR0))
> +	u16 vendor, device_id;
> +
> +	vendor = vfio_pci_config_readw(device, PCI_VENDOR_ID);
> +	device_id = vfio_pci_config_readw(device, PCI_DEVICE_ID);
> +
> +	if (vendor != PCI_VENDOR_ID_INTEL)
>  		return -EINVAL;

nit: s/vendor/vendor_id/ to be consistent with device_id and
vfio_pci_device_match().

Also you can initialized these variables when they are declared to
simplify the code a bit. e.g.

diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
index 0cbc7606d904..19d9630b24c2 100644
--- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
+++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
@@ -65,12 +65,10 @@ static bool dsa_int_handle_request_required(struct vfio_pci_device *device)

 static int dsa_probe(struct vfio_pci_device *device)
 {
-       u16 vendor, device_id;
+       const u16 vendor_id = vfio_pci_config_readw(device, PCI_VENDOR_ID);
+       const u16 device_id = vfio_pci_config_readw(device, PCI_DEVICE_ID);

-       vendor = vfio_pci_config_readw(device, PCI_VENDOR_ID);
-       device_id = vfio_pci_config_readw(device, PCI_DEVICE_ID);
-
-       if (vendor != PCI_VENDOR_ID_INTEL)
+       if (vendor_id != PCI_VENDOR_ID_INTEL)
                return -EINVAL;

        switch (device_id) {

>  
> +	switch (device_id) {
> +	case PCI_DEVICE_ID_INTEL_DSA_SPR0:
> +	case PCI_DEVICE_ID_INTEL_DSA_DMR:
> +	case PCI_DEVICE_ID_INTEL_DSA_GNRD:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	if (dsa_int_handle_request_required(device)) {
>  		dev_err(device, "Device requires requesting interrupt handles\n");
>  		return -EINVAL;
> -- 
> 2.43.0
> 
