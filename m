Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110128;
	b=ewiVA1oho63iinLlY3I/1nnSf9WCg8wzD1ZCkabaSUrF/yj+nJYmUsiK8uAMUKStrw0U
	 PIGClLOI0J1gxwvXIkfpARgGit6e8Du9UnERqF8mmAxowHkyAjcU96dXx+YZCITgKx2db
	 n0f8ClyK1jhBlAVMFOjRBMWGJmEDfkSY4Xcon1UWeGzlv8y98+4EvOSbsc5ZznZobhKjX
	 OtomG9xy7DseXM8GQCsUlVVqej5Xs2I/084qJIydYsyNAuHWnnmO0KR2xyPp1hIZwbWzb
	 fpF/JImIeREKc7e+jvuZHKMflyCvQ/p6nXpbgzf4mOqVASjLlkToz5FNTG4znohcWiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110128;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lSLIUaL2Jt52ZL1/ZORhvu/M8g+F3YsO7Y845XP4dWA=;
	b=EoCWVZcfuS8VFu5/p556HRP8NK+FjeRzqe6qS77TS6w5eUgdhwpNXq1xFd7gtE+OqSiM
	 NCQz5hQvZZ6NsX/3Ti+wNBN9z5nvJ31Xhk0k9m1CgoNHsTIpLHKvNZGODs3bsZdHKPXpI
	 RkGCm3cT2v9ybz4PsfHmYln7anG8XL903g+09vhkQAU7ICtV0U8SCEVDT2/lsAR9BxHGi
	 NG0cQlQ6uGHwxgn5fIzLJDaNZe48DynHd+nCc8ggPL8X8Ys/HPD+2ytinCxdyRYVf2FzC
	 PQp1mhQ+D9yliuTSzPNaiIgIDz5WZ4bo6KPXET1pz916UDeAN3dr2r+/IKPc6+9TMRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S15z9dD9;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA125606A31B;
	Tue, 27 Oct 2026 14:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA125606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S15z9dD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793110126; x=1824646126;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K47uyZ+9DXPOcHQqkyoR+d19Q9CpijVOgdBU1uW527U=;
  b=S15z9dD9B7fR9E2m1zxBx0tfqtUZjQFAntxJ9eMw9U+Su76Jyfw5w241
   ftydpSeHLM8bHRrqk7YTZF1xM6kaA5+9fjjR4kKXFxax9AVEnlOUhtBNI
   pr6yXeJpfbMeZxWcWf++tQxx/MyPQ2XBlZPb6Vw1RcIrPuT0xpMCtYvl+
   +XgQpnJxBkl33PXDJC1XjzzSyvqEKg30njerOsML2mUtpg6C0/hHSj0CN
   Ohn2zWR+rpqTBQwGIu1hIbuFgV/4yGAHwdoLawQo3t+CQEF3Sqq2afijj
   kDyeOeVWo6Y8n78hufNzLEgiR3H00cblQ+IXLqq3CQiUwwOcNl6zSIosx
   A==;
X-CSE-ConnectionGUID: eNTdVfmcTmu7mFNvH8HDog==
X-CSE-MsgGUID: ZS2o5F9KRACWYKcPz5TYoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1900009"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1900009"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:08:45 -0700
X-CSE-ConnectionGUID: VxLkWFdXR02r0GM8ie7iKA==
X-CSE-MsgGUID: 33F1fWAMRIyiBsNQEv6I0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4594033"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.140]) ([10.124.240.140])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:08:42 -0700
Message-ID: <7a832e5c-eaff-426f-adff-7935be265bbd@intel.com>
Date: Tue, 27 Oct 2026 22:08:39 +0800
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
Subject: Re: [PATCH v3 2/2] virt: tdx-guest: Poll Quote status with
 exponential backoff
To: moe@flashbots.net, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dan Williams <djbw@kernel.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jun Miao <jun.miao@intel.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
 <20261024-tdx-guest-quote-poll-v3-2-6a83bb767314@flashbots.net>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261024-tdx-guest-quote-poll-v3-2-6a83bb767314@flashbots.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/2026 3:17 AM, Moe Mahhouk via B4 Relay wrote:
> From: Moe Mahhouk <moe@flashbots.net>
> 
> wait_for_quote_completion() sleeps for a full second before it first
> checks whether the VMM has completed a GetQuote request, and then
> rechecks once per second. Every Quote request therefore takes at least
> one second, however quickly the host answers.

It's not 100% correct.

I think it's possible that the host VMM completes the GetQuote request before
the first check in wait_for_quote_completion()

> With a local Quote Generation Service the VMM completes the request in
> a few milliseconds. On an Emerald Rapids host (KVM, QEMU 11.1, Intel
> QGS), back-to-back Quote requests through configfs-tsm took 1021-1024 ms
> each; with this change they take 6-12 ms at HZ=250. Since quote_lock
> serializes requests, the one-second floor also caps a TD at about one
> Quote per second, which hurts users that bind a fresh Quote to every
> connection, such as attested TLS.
> 
> Poll with an exponential backoff instead: double the sleep from 1 ms up
> to 100 ms, so that a fast Quote is noticed within a few milliseconds
> while a slow one costs at most ten wakeups per second.
> msleep_interruptible() rounds up to whole jiffies, so at HZ=250 the 1, 2
> and 4 ms steps are one 4 ms tick each. The sleep stays interruptible,
> and the timeout becomes a deadline in jiffies.
> 
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

With the statement of the first paragraph fixed,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> Signed-off-by: Moe Mahhouk <moe@flashbots.net>
> ---
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index a5a53174f9d9..d58c8eccb26b 100644
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
> @@ -271,18 +272,25 @@ static struct tdx_quote_buf *alloc_quote_buf(void)
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
> +	 * within a few milliseconds. Poll with an exponential backoff of up
> +	 * to 100 ms, so that a fast Quote is noticed promptly while a slow
> +	 * one costs at most ten wakeups per second. msleep_interruptible()
> +	 * rounds up to whole jiffies, so the shortest steps take one tick.
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

