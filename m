Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5B2C0285;
	Mon, 18 May 2026 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117158; cv=none; b=dPEBj6O+QcR9Go/oOtA19po1U/We1THcfmJdLcOlcabcHKx7ct1/VaLebg/9xLAszz1GRJBNHj4iLqTMYiRjmbc+H31U3AI0m4dzRvA5didbg4nLFFdysvyJJyUKNTOfktogUp4Rpc9ig9RREV/vBmw505538mGSi4j8kNMWl14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117158; c=relaxed/simple;
	bh=usaP7VTdT3T6hQ117xP8THBXVVnr1QGxlZ+HgD3YzJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6Qdy1/B/bYn44NRgSNTTP45+vHJc5+DvYGAQtsk0GGXrrKudVsy5RD5buRolRpG1fRmh2oAQhesZHXQy7Cp2i+AK4olLog/AMzlxnA2RNv7NLH3D0N3JvdPhgCT6Ref9Qh+Asx12fZmkodXC4UUuPVw7wsvLSxTJCk5R4E7jjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jg6Z1VtE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jg6Z1VtE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779117156; x=1810653156;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=usaP7VTdT3T6hQ117xP8THBXVVnr1QGxlZ+HgD3YzJk=;
  b=Jg6Z1VtEEm37bHsAasxGSqJSe9u7sRQgrSYwKrekyfTvdIwmZbBzf95g
   dMrmsw9uQSTOAf0VmrUI9cb/16IiSLwsQSbXZ1Smg+UBkQ6ogoyJE31hr
   y5Qbx3W2F3S2O/moSA104DjtW4/xPTX3L+pewZknA/I/es+bQTwqzweYk
   CIhheQln0yKJsemv+wzzxqKZP3bC5EjICvGefx4Dq3fn2qxLNCpSX8LcQ
   k8u0oiCKFip/LFfp6+pvZZRgSBE964FWC3NAPlcWnklh8fR/qbGMOS1JR
   CM2lsuR64l1zRjZjUKRlYg9K5YBfsfS/cTQf4JlHUClHU30/694m+bGIv
   Q==;
X-CSE-ConnectionGUID: Ags0N3bfT8W0ebA2UCo7Cg==
X-CSE-MsgGUID: +FIpazb5SliN74Memg3UTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79687998"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="79687998"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 08:12:35 -0700
X-CSE-ConnectionGUID: akdb7uMNSf6p7VqwITabcQ==
X-CSE-MsgGUID: ACN5/8WXQfm9zO1DhUmmbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="235205109"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.43]) ([10.125.109.43])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 08:12:34 -0700
Message-ID: <977c1cf8-45cf-4902-9c50-ffc2b45391e6@intel.com>
Date: Mon, 18 May 2026 08:12:37 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/23] x86/virt/seamldr: Allocate and populate a module
 update request
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com,
 dave.hansen@linux.intel.com, djbw@kernel.org, ira.weiny@intel.com,
 kai.huang@intel.com, kas@kernel.org, nik.borisov@suse.com,
 paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com,
 rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com,
 tony.lindgren@linux.intel.com, vannapurve@google.com,
 vishal.l.verma@intel.com, yilun.xu@linux.intel.com, xiaoyao.li@intel.com,
 yan.y.zhao@intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-12-chao.gao@intel.com>
 <7d7fff5a-53a5-439e-9ff8-dcbd97f473cd@intel.com> <agsfCsvcILh3Vg7a@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <agsfCsvcILh3Vg7a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/18/26 07:15, Chao Gao wrote:
>>> +#define TDX_IMAGE_VERSION_2		0x200
>>> +
>>> +struct tdx_image_header {
>>> +	u16	version; // This ABI is always 0x200
>>
>> That comment reads strangely in here. Did I ask you to write that?
> 
> I copied that from the example you suggested for this structure in v8. But
> yes, it does read awkwardly here, so I will drop it.

The point is that the code or comments needs to mention *somewhere* that
"This (header->version) ABI is always 0x200". I didn't mean for you to
literally put that ^ in there.

It's fine if it is in the code to. Just mention it somewhere.

>>> +static int init_seamldr_params(struct seamldr_params *params, const u8 *data, u32 size)
>>> +{
>>> +	const struct tdx_image *image		= (const void *)data;
>>> +	const struct tdx_image_header *header	= &image->header;
>>> +
>>> +	u32 sigstruct_len	= header->sigstruct_nr_pages * PAGE_SIZE;
>>> +	u32 module_len		= header->module_nr_pages * PAGE_SIZE;
>>> +
>>> +	u8 *header_start	= (u8 *)header;
>>> +	u8 *header_end		= header_start + HEADER_SIZE;
>>> +
>>> +	u8 *sigstruct_start	= header_end;
>>> +	u8 *sigstruct_end	= sigstruct_start + sigstruct_len;
>>> +
>>> +	u8 *module_start	= sigstruct_end;
>>> +
>>> +	/* Check the calculated payload size against the data size. */
>>> +	if (HEADER_SIZE + sigstruct_len + module_len != size)
>>> +		return -EINVAL;
>>> +
>>> +	/*
>>> +	 * Don't care about user passing the wrong file, but protect
>>> +	 * kernel ABI by preventing accepting garbage.
>>> +	 */
>>
>> How does this "protect kernel ABI"?
> 
> "Protect kernel ABI" was imprecise here. The intent is to reject
> obviously malformed headers.
> 
> If the kernel accepts garbage in header fields today, userspace can come
> to rely on that behavior. Later, the kernel may start validating those
> fields more strictly or assign meaning to fields that were previously
> reserved. Rejecting the same image then could be seen as a kernel
> regression.
> 
> I'll simplify the comment to:
> 
> 	/* Reject obviously malformed image headers. */

I'm still not following this at all.

I suspect that someone along the way said something in reviewing this
about ensuring that fields that are "reserved" are treated as "reserved
+ must be zero".

Somehow that recommendation got conflated with the version checking.

But the deeper point is that neither this patch nor its contributor is
quite able to articulate the reason for this line of code being here.

Let me try.

	The "tdx_image" ABI is versioned. However, there has only ever
	been one public versions of the structure: ->version==0x200. The
	kernel can only parse that version. Future versions of the
	module might be able to use the same ABIs (user/kernel and
	kernel/SEAMLDR) but they will not be able to use this kernel
	code.

	Reject module images without that specific version. This ensures
	that the kernel is able to understand the passed-in format.
