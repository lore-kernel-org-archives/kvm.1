Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789102;
	b=OeYOzUVPeHITp89ziDZtjTSMZr4qZfaiGmUHiW/YrarZBfnqFJIvp4+A08Khj59R2U8L
	 oexzir/yIxGpZFHfoWApek81VNkNFt13+fiZfHDLxlAP78Q/iTis7M3UzvPPvAhXkXIYs
	 3mjGaCBgkC7l6krILLMIGcPi7lc1vAcYJjNHtB20JZfW4zsIP4HDIqWTszCqz3fft0Ohs
	 PAVFtqmEGKJ+i9/O6WKR27RkKRC3KI/WpUSNdqGED+SpMeWR3SrvzPEfJGYcOtVBjOP20
	 htmBBP+0gpCf91pTEwRRzJhdoQgJz32LKVXpso5xw+Bp0b9dFRyXlcIMFXrwQv2FbGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789102;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=47fFe2ZVWzD2M+xi/Gv522xhXtrQ0E4Nr3GRjs7cPpA=;
	b=GBc8wMY2v+h8XbDHsFGgH50IVfBIKvjaRXv3qlGqOspxnzd0H+lvtQJ5vgDzXOmpmGvj
	 MjA2g7Edihq5DCwLya1+znfxoorqecjEZPXKjgqsdPsfurIqJTJq2kQ95xFlmEVZtq+zF
	 /gYI2VzuZNcFbyoDZwy+L+NOnM2g8eHcTLHYzkJZZAjnM5ugxPG/O0fexYWIl0nMgtIq2
	 1LI+kGsc4jLWlpWjc5PhQlhUAtdHE/4xLX+FlpiSrPNrTIuUCsoZi8bjoQhLbJN2fgCh6
	 NlG+Ukt9JV8flL6pqXtg7YKn6k3zp205FzCi7o9ANAiYA5+W/mLQ6pVI23RPsr2ksvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UomQidKl;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E60606A31B;
	Fri, 23 Oct 2026 20:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E60606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UomQidKl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792789101; x=1824325101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ks7Gx4OVJpb109E2zCSIAV0QP2uyhcmqOu5LqKpAbhw=;
  b=UomQidKlXcoPjeT/CaO1rbTNvA/SxK7wuY8+Me7w/TK6s4N+xcVoJwwn
   rxnNo4S2l/DpkYcMC1pxtLiy3/WFH+ASeo/PRepJ4WHOVllVIVAuF1gZu
   V3KG5Bbr+A2LxK9PoYkhi0CXrZ27QjBdFQEZUInS0o4NgBtfdlQEKI8c2
   AgIhG68nmBsCP/VfyuJV7Y5o3fnNjBo1e0zwfjcS9e/WdQMuHKFsjpHj5
   2e09EKvRp9X6rSSuWNFDB0Q3fkIcC6iYbSEKLJbnf1ETAQUpuEc33m4vF
   gxwMiCogCFKpHChAq8oJCmD8Ym0LznDwWA8uk4hQWN6axgHReyEt7vqoU
   A==;
X-CSE-ConnectionGUID: hbtzdOv3TEiNUDKp1/pM+A==
X-CSE-MsgGUID: rm/Axp7OSVeN41JZ50KK7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1440509"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1440509"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 13:58:21 -0700
X-CSE-ConnectionGUID: ptr2M49qRaiYrDw1HxCWYw==
X-CSE-MsgGUID: E2s5XuQmRAOf+b72Nk+Qkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3744554"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 13:58:21 -0700
Message-ID: <6090c951-edda-44f1-9569-c6d268649465@linux.intel.com>
Date: Fri, 23 Oct 2026 13:58:20 -0700
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
Subject: Re: [PATCH v2 2/2] virt: tdx-guest: Poll Quote status with
 exponential backoff
To: moe@flashbots.net, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dan Williams <djbw@kernel.org>
Cc: Jun Miao <jun.miao@intel.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261022-tdx-guest-quote-poll-v2-0-7543c6eb2d36@flashbots.net>
 <20261022-tdx-guest-quote-poll-v2-2-7543c6eb2d36@flashbots.net>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20261022-tdx-guest-quote-poll-v2-2-7543c6eb2d36@flashbots.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/2026 9:31 AM, Moe Mahhouk via B4 Relay wrote:
> From: Moe Mahhouk <moe@flashbots.net>
> 
> wait_for_quote_completion() sleeps for a full second before it first
> checks whether the VMM has completed a GetQuote request, and then
> rechecks once per second. Every Quote request therefore takes at least
> one second, however quickly the host answers.
> 
> With a local Quote Generation Service the VMM completes the request in
> a few milliseconds. On an Emerald Rapids host (KVM, QEMU 11.1, Intel
> QGS), back-to-back Quote requests through configfs-tsm took 1021-1024 ms
> each; with this change they take 6-12 ms at HZ=250. Since quote_lock
> serializes requests, the one-second floor also caps a TD at about one
> Quote per second, which hurts users that bind a fresh Quote to every
> connection, such as attested TLS.
> 
> Poll with an exponential backoff instead: sleep 1 ms first and double
> the interval up to 100 ms, so that a fast Quote is noticed within a few
> milliseconds while a slow one costs at most ten wakeups per second. The
> sleep stays interruptible, and the timeout becomes a deadline in
> jiffies.
> 
> Signed-off-by: Moe Mahhouk <moe@flashbots.net>
> ---
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index a5a53174f9d9..000fff4ef6f5 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -16,6 +16,7 @@
>  #include <linux/set_memory.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> +#include <linux/jiffies.h>
>  #include <linux/sockptr.h>
>  #include <linux/tsm.h>
>  #include <linux/tsm-mr.h>
> @@ -271,18 +272,24 @@ static struct tdx_quote_buf *alloc_quote_buf(void)
>   */
>  static int wait_for_quote_completion(struct tdx_quote_buf *buf, u32 timeout)
>  {
> -	int i = 0;
> +	unsigned long deadline = jiffies + secs_to_jiffies(timeout);
> +	unsigned int sleep_ms = 1;
>  
>  	/*
> -	 * Quote requests usually take a few seconds to complete, so waking up
> -	 * once per second to recheck the status is fine for this use case.
> +	 * A local Quote Generation Service usually completes the request
> +	 * within a few milliseconds. Poll with an exponential backoff, from
> +	 * 1 ms up to 100 ms, so that a fast Quote is noticed promptly while
> +	 * a slow one costs at most ten wakeups per second.

Nit: msleep_interruptible() rounds up to whole jiffies, so at HZ=250 the 1,
2 and 4 ms steps are all one tick. The 1ms comment is confusing. Drop it
or clarify it.

>  	 */
> -	while (buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
> -		if (msleep_interruptible(MSEC_PER_SEC))
> +	while (READ_ONCE(buf->status) == GET_QUOTE_IN_FLIGHT) {
> +		if (time_after(jiffies, deadline))
> +			return -ETIMEDOUT;
> +		if (msleep_interruptible(sleep_ms))
>  			return -EINTR;
> +		sleep_ms = min(2 * sleep_ms, 100U);
>  	}
>  
> -	return (buf->status == GET_QUOTE_IN_FLIGHT) ? -ETIMEDOUT : 0;
> +	return 0;
>  }
>  
>  static int tdx_report_new_locked(struct tsm_report *report)
> 

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

