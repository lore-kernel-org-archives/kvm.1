Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674142;
	b=MGsMQ0Tx9QUdyuVWY33RKxvX6VV+1ra779lqUYXWtvxE+z3O5Z5aihBELPkMdq5VYe6Q
	 dHf3GHAUMHD5NuPYQhFVBRIknjVJjPnhZs+5nuTwf4U7OsMWkpzy8w0sJKeF2GsPwS4Hf
	 m2g6mcw5nple7u9KgGWH/jn1RYFgDXZiZGLBebxaZ/VutjUiVpcOUp5IGrmyZh4VY11ew
	 r4GQ4eYTvWtBPF5GBcrI0yuSjcPkOubTIMgqT2C7MmmfOj1ooHUxCrgyVtpJdS6PrMO9A
	 XKWUxo+tFdamy8X/2I6CKlsj4HvWeeyC1IE10eEdOOwexNkOjR4jrTVk+7L+v6LkAqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674142;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=4HuGv5ZRH/AtF4S4hVGB2td/V1pIJ3gKoiIbsSKyuhk=;
	b=SvAo8Vv0iOOSLGp4h5bUlrlGOL9ztkj1JTwc0/YYc27uI48HORgVuDUQ+jkyu18V4KSs
	 Pip1dhcEr+OXdKcAiHE4S2Hwt+t2mDPyzK9oZvEbK2Alb27II0PbIYnOJeHn+mhnxwtf5
	 Ug2uBP3aThh5/DyOtCBD+4RlCMiHDJEqFmLxmKYsQciB6pAVV1NdBHJxUQFWYrYVvT2dk
	 KgDieVNmlthKrQjErQ7ofpdmZn1iqrNLC8GmoUBMIY2IMA1JkiWNvKlpxxgAlEgflt6WI
	 ZpIiFLeIT2vL2uAPHdxdtf8/xAg8ftURSO66qfErFF0Ht/Smge+b2ZMLPWwyKHhmQfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gukAl2Vz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF7606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gukAl2Vz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2E11F000C3;
	Thu, 22 Oct 2026 13:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792674141;
	bh=4HuGv5ZRH/AtF4S4hVGB2td/V1pIJ3gKoiIbsSKyuhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gukAl2VzLfgw+LefWfQff69EA3FCD4cWTlc07QUqCAQE584rjjznNHti3vCl/lEgv
	 H4U+4qwTUVVEb8w+TXjGZs5su3BvvfwVDLfxR4FlO5+AyLsEiSBwRFAr7Gjv50t4Vp
	 rFHpOiVNA9z/cO370CX7qrnKgugQNLSaKoc/+dpjdZmcxFVqcUGYF3Tb2K2nD3kG6T
	 gG4xlrrSo5HtPT4IERUO3SWx2avtjDeidhyWej4+8ENVpYV47hgnXjMO1aNmbzqpNW
	 Q40NFfFSnlHB++K3iCQ0rO8zmA4+b66Vg0O5BgGNb5bVCWNqvDOL1RnnxxmiXpO//l
	 xMiLC/cj8P2UQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 66900198003A;
	Thu, 22 Oct 2026 09:02:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 22 Oct 2026 09:02:19 -0400
X-ME-Sender: <xms:WQnaapTr8GvbsUJAfOv97XwN1xdGS_kaCfN1cRsFq2jYvZj38kREww>
    <xme:WQnaaqUVPUSVDFK0uHhV69ovcrBc6OqdWEXlLKLH_M59lwCPZKU6lDUIc-R1IE5Ha
    szRSGZXoU01lliTHpuF1XXFgXwoq9hiecQPG-idwvLCvBFZn4tJsyLS>
X-ME-Received: <xmr:WQnaaud_OxSQ0gkz9X5tYMwfv-bwJeExWr3m5ZvV6b35agwo75SUprprHnU>
X-ME-Proxy-Cause: dmFkZTEvFcltCV3rbb+SUdH6HdqghYdFA006W/sOuoLejeYB8OZVAiAdEvFfhoxp4aDjDf
    Nrh67OJON03Gd/PBrjnw1ermn1KRh5c782xteXhRV8EAKkCo1vfXN5IIpU5VxGJufymJDI
    zOkJfkEPXF18SFWiIZP+tjpcJvgk0DFb9T3Id3Lx0iKSJXzygfzebjr9JOxaxd57v7wSvp
    /ESbV6sntPKQWwGAONXhUU1s1eYU+utn2GP0wDd63WK+mNEniuz1T2LFmfRAKU3QaT18f4
    1pZAW7EhvJThlt9eCkRnOPkx71x2aeAqqbl2o5w+4DK4j3DLOVvcYaBm9IkK4V8gQX9UZc
    XJzfXOaAqPcaLjuG57uQVEvlTG8a2NRohq8peiNNlWEBzRsAkgBN/cMnsCF5yUss0xk+nY
    JIVyovh8ZQ/GNMFdxgH2luifQeZOhpskM4E8qo7JweVhRILYyqublekNYP3e5xwBvAMwR3
    m4RbyKdfIS6qLTsiV8+ffp+uQj+c7TcE1HJs4+n2Lgnha4ils3HpjBSyIdbBhiC6zE/bAK
    8aUi4kKG1Lc8b0CLxj4s5VCzCYpsvxyVI64QDiGSFBuWukE3R9RqTDBSwFodZcRcURld1Y
    hD4J+wgxg0EnjX1TEWGTebZKKO2+u448obJsRjl/1ddaVUwbrHK83UGQmIfQ
X-ME-Proxy: <xmx:WQnaatxe5gC_Uri40zV4nTMdfLaat1g6mzgQ37vhNVXFKXi4_Gr5mQ>
    <xmx:WQnaapGTcaoGwLF0_6wvjC5_PuIRGvx5fu6PQic1O3fI-9rDY5Szig>
    <xmx:WQnaas1YIkQ0ILP5XTQAPKImH1-4jbFYBRBu2T_0feI1PJISP9RWfg>
    <xmx:WQnaah8ZYPeI77tT5kzOkS6qbi8j2H5IX24c2eoIPSLZDa8x_YK63g>
    <xmx:WQnaavHXdoazp9bcr14PKOB0vhwwo7YpAmuXD_L84-fUxleCtaq6DHfc>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 09:02:17 -0400 (EDT)
Date: Thu, 22 Oct 2026 14:02:16 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: moe@flashbots.net
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: tdx-guest: Poll Quote status with exponential
 backoff
Message-ID: <atoHWgQF-0vlTRK4@thinkstation>
References: <20261021-tdx-guest-quote-poll-v1-1-919a87812ecb@flashbots.net>
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
In-Reply-To: <20261021-tdx-guest-quote-poll-v1-1-919a87812ecb@flashbots.net>

On Wed, Oct 21, 2026 at 05:16:32PM +0000, Moe Mahhouk via B4 Relay wrote:
> The latency was found while measuring TD boot and attestation times.
> The code and this changelog were written with an AI coding assistant,
> Claude (Claude Code, model Claude Opus 5.5), which also ran the tests.
> Tested on mainline a804c5742 in a TDX guest (KVM host v7.0, QEMU 11.1.2,
> TDX module 1.5.34, Intel QGS) with 40 Quote requests per kernel; builds
> with W=1 and passes checkpatch.pl.

Does anybody find this kind of dump useful? Maybe move after --- ?

> @@ -271,18 +273,25 @@ static struct tdx_quote_buf *alloc_quote_buf(void)
>   */
>  static int wait_for_quote_completion(struct tdx_quote_buf *buf, u32 timeout)
>  {
> -	int i = 0;
> +	unsigned long deadline = jiffies + timeout * HZ;
> +	unsigned int sleep_us = 100;
>  
>  	/*
> -	 * Quote requests usually take a few seconds to complete, so waking up
> -	 * once per second to recheck the status is fine for this use case.
> +	 * A local Quote Generation Service usually completes the request
> +	 * within a few milliseconds. Poll with an exponential backoff, from
> +	 * 100 us up to 100 ms, so that a fast Quote is noticed promptly while
> +	 * a slow one costs at most ten wakeups per second.
>  	 */
> -	while (buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
> -		if (msleep_interruptible(MSEC_PER_SEC))
> +	while (READ_ONCE(buf->status) == GET_QUOTE_IN_FLIGHT) {
> +		if (time_after(jiffies, deadline))
> +			return -ETIMEDOUT;
> +		if (signal_pending(current))
>  			return -EINTR;
> +		usleep_range(sleep_us, 2 * sleep_us);

usleep_range() in uninterruptible.

Why not use the same msleep_interruptible(), but with shorten interval?

        unsigned long deadline = jiffies + secs_to_jiffies(timeout);
        unsigned int sleep_ms = 1;

        while (READ_ONCE(buf->status) == GET_QUOTE_IN_FLIGHT) {
                if (time_after(jiffies, deadline))
                        return -ETIMEDOUT;
                if (msleep_interruptible(sleep_ms))
                        return -EINTR;
                sleep_ms = min(2 * sleep_ms, 100);
        }

        return 0;


> +		sleep_us = min(2 * sleep_us, 100 * USEC_PER_MSEC);
>  	}
>  
> -	return (i == timeout) ? -ETIMEDOUT : 0;
> +	return 0;

Hm. The current code is broken: on a real timeout i ends up at
timeout + 1

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
