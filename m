Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795859170;
	b=atahPLRCdVA+60RKl3r/3b2Y7dQzAvEoGbJ7nnYj5JVAwJ+90JoTA6O7KUslCLwTY/+1
	 EgiPzPVmLN6cNWOYgbiZ7O0es/yoegX5SojFAusB7+GbbIeFXscV/RGS6kEmJByzffTlw
	 WndVTwkDqNQxdAXvIV8tD1y1XSD5pxyeirQSGmtyPYQj1UQ4+y/wPMOjEa3xK401nlWd/
	 WL+UyPd6yLtydtiVf6iSyKff7cf4IRRXZnPaao/ybt8eGGLjXruqEfyEg+w3AyhTb6qmB
	 qw4YL9PO8WhL/k3iYg7dHkqcufz0Vf7YriUZky42bmtO9gIp0UqIxjWYtkW0WhTtJrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795859170;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fNv9TUex5ARPwbWHSqEsmUWqqFCA63X39+qHuiV0zt4=;
	b=s4mLd4+ZsNhgNOQT+QC0oKZw4TInWuVmGz20UwDg+NfWUtwCrl3E2tYOp96iZhIpoPdE
	 Gr/PIHj9h+6tFc5tbJe1HGHsxD5HC0R8r4B0r/+U9n/quC8LnjUHyEigfkyfVMZiHR3Rh
	 kE+JvqMsTwWMIRq52uJFGv3KPm01hbq9M7tBvWFAz+NIb1FYGs5FA/H7ypJdehgobEmjn
	 8/RqkZeeawk3kjC+wkvb/QP7ZEET4FXHNxH8QXLQcMrUwYRAz/OY863QHww4o5YtOiBzW
	 nvlU/rMIAAvuPx8YId+8ML0k5ZPnFBtB8xRb7VmKuRh40kfBfioYshnXoqO+NygZFJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eeL7J1hQ;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352F606A324;
	Sat, 28 Nov 2026 09:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8352F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eeL7J1hQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795859169; x=1827395169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FUli3JSrmBDeDfvTU3OWuWFYYYznYbfuUzwPuAEvA+Y=;
  b=eeL7J1hQqmFbueb1B63dNWBrpGHxindq+SXDELxsxT/NyqQWMBXtFz29
   k28+xgtBf9t/V+CdD9ZuycnzLuRQjcm8KD/hZ+pfKFRTK8LhlzseYnc0a
   Xsg9leUZTdVrX24bM8h7enK4FpwrpnrFnqGPnbGouzT/qzrThQHQTxtYw
   n1ZJbNDPGGkgLYn1wkWi6MHzX0RGi0VAv2ggFQPnbHbYp2iOaJnHlrP0J
   FTKv7XbieSA5hOpDDxMo4/1RKGr4sYxkZkT5XYWzH3gfBZmW2LZrVjGBy
   ERPWrnJvim3pBjYxO8qXhwd4wXCIuTIe3DOAidl5T+DspgZXmtBBYjaLH
   w==;
X-CSE-ConnectionGUID: TP/6GRvrQy6PRNB41SxeXg==
X-CSE-MsgGUID: 4lUiwFqnQ2K8Rbv/GmVsgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4738415"
X-IronPort-AV: E=Sophos;i="6.27,238,1787036400"; 
   d="scan'208";a="4738415"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2026 01:46:09 -0800
X-CSE-ConnectionGUID: 79OzccF3Rha/nqYLtK1AvA==
X-CSE-MsgGUID: b5wDw4dOQrO7/0tXll2Rsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,238,1787036400"; 
   d="scan'208";a="13152341"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa010.fm.intel.com with ESMTP; 28 Nov 2026 01:46:05 -0800
Date: Sat, 28 Nov 2026 17:35:44 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Peng, Chao P" <chao.p.peng@intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "kas@kernel.org" <kas@kernel.org>
Subject: Re: [RFC PATCH 2/7] coco/tdx-host: Establish an SPDM session with
 the device
Message-ID: <awqgcMpr9CjMZGdU@yilunxu-OptiPlex-7050>
References: <20261116111037.3478844-1-chao.gao@intel.com>
 <20261116111037.3478844-3-chao.gao@intel.com>
 <ac7befe5081a489172d87402e55355852a9e62ac.camel@intel.com>
 <awWKRJQ3_rIgxJVC@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awWKRJQ3_rIgxJVC@intel.com>

> >> +#define SPDM_CAP_HBEAT		BIT(13)
> >> +#define SPDM_CAP_KEY_UPD	BIT(14)
> >> +
> >> +struct spdm_config_info_t {
> >> +	u32 vmm_spdm_cap;
> >> +	u8 spdm_session_policy;
> >> +	u8 certificate_slot_mask;
> >> +	u8 raw_bitstream_requested;
> >> +	u8 reserved[4089];
> >> +} __packed;
> >
> >This looks like more SPDM specific stuff in TDX. Do really know other vendors
> >need it? We should at least group it in a header such that it is clear which
> >things are SPDM spec and which are TDX.
> 
> This structure is not from the SPDM spec. It is an ABI structure
> defined by the TDX module, and it is passed to TDH.SPDM.CONNECT.
> 
> But yes, there is some SPDM-specific stuff in this series. I will try
> to separate it from the TDX stuff.

[...]

> >> +	spdm_conf->certificate_slot_mask = 0xff;
> >
> >Can we not have the magic number? I guess it means any?
> 
> Sure, will remove the magic number. 0xff means getting the
> certificates in all slots (0-7) of the device.
> 
> As a heads-up, this code will go away anyway when we switch to the new
> CTLV attestation framework.

So it seems we don't need any spdm_config_info_t definition for now.
Should we keep the definition or just to provide a zero page to avoid
unnecessary explanations here?
