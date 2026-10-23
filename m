Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788240;
	b=YPIVzugxMwgk7o+juIIpCcp3XTf+clHUTUSxii+cRbNcvIrY2ztVKVNTyOQ0evVYP4yM
	 Eq26tYX8OGUxTEiI8ZTS7fagaJqUugt9ItBxRRE3fQCcAJLagnQE8IHno4ZSNeMZwMPlV
	 spbaXOsMgB+6kM8pZpBy8NY8BDXoYlH/Ru/RtjATRf7XclaQSwwADBH4PeBIWTU5yh0Cm
	 RdJNaKvDKbHTg/SCbQsb40Vy5EeW6uxuf4b8wbELSzApJzP69CJAj30yYzD1IZi1YAhIu
	 eV/URIMEyu4HFkBKVYmwye5xCJftRUerSReyMK6dk1nmkAO2rX5zrgJSg18r1I/tyUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788240;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Kg5sEdhQ2g+V2nQgohzkE2jL3J0nwWNaN3yyyXVB1Vc=;
	b=Vq687THnq1jiQifKaOSzN24UB2KOGUbL799aI6Lx5LCyQQ+9k9glH8RhUY8y/pW4Eo3P
	 vz9HRyTfSooIIUF4whS/51zEhoc9wz2JSfM+nWe6EPef8yfwgCgo54/zFpJm9kOpT8K9M
	 GQk5EqJNB22nbaL08+tf4J+sbU13whq3sgItkuuVRyGdNW98pziLRJa6QxKvYMqkHItvL
	 vM+71/9wjRmYgH3v8Cppu9Mt4eup6NQWjWrZluNiQuuTFv5aO0DxK/jS4cf7Xj4uBKq/d
	 5Tu5+TWtfbjgH/g9wL1/7jPk/Rw/hpfabQqIsRMa9kza5oBSPywkw3O9K0VYuDj1Btg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lYuX0DGP;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC84606A31A;
	Fri, 23 Oct 2026 20:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DC84606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lYuX0DGP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792788240; x=1824324240;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SdXxGKPsZhSER7+T11B25dIGAkc06IB10PwDrkQUjNI=;
  b=lYuX0DGPpfWeLOYv+eaK/6SL9Iyv2vaaUxpv2glmrhFhw3qyiO9ff8k/
   FDBVVBqh9gZNz5TdVWzWC0Lt0A+jjICopRqJwuoWlFsDRbUKiUYD7pEJD
   KTbYKPWbDsdA5biyaCBr1OvF5cSm88X3ABkkACJCzOPxtPuRycdjY8Xpy
   W9gZxJ0UQ+7VKnj/de16u/7WzLKz5JydxKdSwKR+otY4j/3QRymccV/+q
   SWWA1IboWQD4XvRnzKt/hzBoYhVOZin5tAcMlt/OnIjmObG/QiRC+4oh8
   AUZdfOB1YCadsu1P14SH2gzHzDLAbd76ivlS+cY5qfK/sEFvJ6Ys8bUMa
   w==;
X-CSE-ConnectionGUID: 3vpQCp1DSG+jAeIc/eFnIA==
X-CSE-MsgGUID: CRNHAx4kSru0L7Mb0aIpTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1455977"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1455977"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 13:44:00 -0700
X-CSE-ConnectionGUID: 4Lky41bqRqSvgB3SMkw+dw==
X-CSE-MsgGUID: e4UaoCamQPK9VSpUQTONew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3742384"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 13:44:00 -0700
Message-ID: <4e8ffa1b-a0bc-4a77-b1f2-cc1c84f9d8ec@linux.intel.com>
Date: Fri, 23 Oct 2026 13:43:59 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] virt: tdx-guest: Fix timeout detection in
 wait_for_quote_completion()
To: moe@flashbots.net, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dan Williams <djbw@kernel.org>
Cc: Jun Miao <jun.miao@intel.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261022-tdx-guest-quote-poll-v2-0-7543c6eb2d36@flashbots.net>
 <20261022-tdx-guest-quote-poll-v2-1-7543c6eb2d36@flashbots.net>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20261022-tdx-guest-quote-poll-v2-1-7543c6eb2d36@flashbots.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/22/2026 9:31 AM, Moe Mahhouk via B4 Relay wrote:
> From: Moe Mahhouk <moe@flashbots.net>
> 
> wait_for_quote_completion() counts the seconds it has waited in i and
> reports a timeout when i == timeout. That gets both outcomes of the
> last second wrong:
> 
> - If the request is still in flight after the last sleep, the loop
>   condition increments i once more before it fails, so the loop ends
>   with i == timeout + 1 and the function returns 0. The caller then
>   returns -EIO instead of -ETIMEDOUT, without the "GetQuote request
>   timedout" message. Before commit 0f409eaea53e ("virt: tdx-guest:
>   Return error for GetQuote failures") a timed-out request even
>   returned success with an empty Quote.
> 
> - If the VMM completes the request during the last sleep, the loop ends
>   on the status check with i == timeout, and the function returns
>   -ETIMEDOUT for a completed request, discarding the Quote.
> 
> Decide on the Quote buffer instead: the request timed out if it is
> still in flight when the wait ends.
> 
> Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
> Reported-by: Kiryl Shutsemau <kas@kernel.org>
> Closes: https://lore.kernel.org/all/atoHWgQF-0vlTRK4@thinkstation/
> Signed-off-by: Moe Mahhouk <moe@flashbots.net>
> ---

Since it can be back ported add Cc: stable@vger.kernel.org

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  drivers/virt/coco/tdx-guest/tdx-guest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index 11d741da3b35..a5a53174f9d9 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -282,7 +282,7 @@ static int wait_for_quote_completion(struct tdx_quote_buf *buf, u32 timeout)
>  			return -EINTR;
>  	}
>  
> -	return (i == timeout) ? -ETIMEDOUT : 0;
> +	return (buf->status == GET_QUOTE_IN_FLIGHT) ? -ETIMEDOUT : 0;
>  }
>  
>  static int tdx_report_new_locked(struct tsm_report *report)
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

