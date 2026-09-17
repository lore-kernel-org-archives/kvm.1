Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782D3DB960
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641156; cv=none; b=FSGs8BjLbH0gJBeP9UG5e8GEvY8f9En1M4RT1W0nS6pXLCylJ4xQeMn8hdCoEEnszBGRXcYFaYG+Lr5D+dFZ3gvmf6IWn4m4ZiOQ61OdeHObkYjJJzzeUrAVV6mswVRA6Sqv2n293nHsA1xFbSUHM9pEkSQKCsXHsHtusZBogJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641156; c=relaxed/simple;
	bh=ql14HzxYwEOhyCjrgw2JB7E3L4YhUyEKpVteXOqWEB4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LlBfhwQBEM7IipfrQGtUS9X90Bk4+fXd7G+lC6nsoXPytKDIcVEzgyqpOCwIDP//bCUtBDHKc1tia9F7DMCBQ1PR6IYGKWAXkukOXD7u/v50ksFJ5LvU4kf8hw9pbkji4PHxZwWH+8Q5Hb9NrZ3TzC9MopColNt90yZEqHgYnJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRRbae1R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRRbae1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A421F000FF;
	Thu, 17 Sep 2026 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789641149;
	bh=hj2jaRbL6ve35J08w0uO4WPcdSX+bPNy5bjObNlX4WQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kRRbae1Rf5p45dlk3iqXqmeFp0twCjAYS4RiP+qd9yHzUWWhISr7hvJJpfEc4rFrE
	 kqAsODvuCsEen6BIVYrigUgtn1mtJCv1+bd88bnZqwmCOjnkUE3PoQc/mfVB5FE1a2
	 ht+VOcw4acSIIwApleTNHvClUx6SEKVgiPSY3zMNqoxW0c+uZSFzFX4sGk1YuixaWn
	 JL/u5pRNYc7h/LI2mb/89M/KM+FwrluPca8VZq9ZJbCJ2MFtRKdd1T4DSTty3Od+Lf
	 1jN6LqNzL7kHM2aSjRsF2HL3B8dzWAydvGVq4DHTeL2alPbljDk0NcIXEQr63g1BaQ
	 F/FuACQJOCTug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] virt: tdx-guest: Use read_poll_timeout() to shorten
 get-quote polling interval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Miao" <jun.miao@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260917102202.750895-1-jun.miao@intel.com>
References: <20260917102202.750895-1-jun.miao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:32:28 +0000
Message-Id: <20260917103229.40A421F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] virt: tdx-guest: successful quote dropped on pending signal
--

commit 1145f13c13d7adf73665778fb8d08dcfab69ccfc
Author: Jun Miao <jun.miao@intel.com>

virt: tdx-guest: Use read_poll_timeout() to shorten get-quote polling inter=
val

This commit reduces the get-quote polling interval from 1 second to 2
milliseconds to improve performance and throughput. It introduces
read_poll_timeout() to handle the polling and timeout logic. The maximum wa=
it
time is also reduced from 30 seconds to 1 second.

> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/=
tdx-guest/tdx-guest.c
> index d0303e31e8161..bac7cb9403f94 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c

[ ... ]

> @@ -251,18 +252,29 @@ static void *alloc_quote_buf(void)
>   */
>  static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u3=
2 timeout)
>  {
> -	int i =3D 0;
> +	u64 status;
> +	int ret;
> =20
>  	/*
> -	 * Quote requests usually take a few seconds to complete, so waking up
> -	 * once per second to recheck the status is fine for this use case.
> +	 * Quote requests usually take a few milliseconds to complete, so waking
> +	 * up once per 2 milliseconds to recheck the status is fine for this use
> +	 * case.
> +	 *
> +	 * Also break out early if a signal is pending so the caller can be
> +	 * interrupted while waiting.
>  	 */
> -	while (quote_buf->status =3D=3D GET_QUOTE_IN_FLIGHT && i++ < timeout) {
> -		if (msleep_interruptible(MSEC_PER_SEC))
> -			return -EINTR;
> -	}
> +	ret =3D read_poll_timeout(READ_ONCE, status,
> +				status !=3D GET_QUOTE_IN_FLIGHT ||
> +					signal_pending(current),
> +				2 * USEC_PER_MSEC, timeout * USEC_PER_SEC,
> +				false, quote_buf->status);
> +	if (ret)
> +		return ret;
> +
> +	if (signal_pending(current))
> +		return -EINTR;

[Severity: Medium]
Does this code inadvertently discard a successful quote if a signal happens=
 to
be pending at the exact same time the quote completes?

When read_poll_timeout() evaluates its break condition:
status !=3D GET_QUOTE_IN_FLIGHT || signal_pending(current)

It will terminate and return 0 if the quote completes successfully, such as
when status is GET_QUOTE_SUCCESS.

However, if a signal is also concurrently pending, the unconditional check
after the loop will return -EINTR instead.

This causes the caller tdx_report_new_locked() to propagate -EINTR, dropping
the successful quote and potentially causing user-space to retry and overwr=
ite
it.

Could we verify that the quote is actually still in-flight before returning
-EINTR? For example, by checking:
if (quote_buf->status =3D=3D GET_QUOTE_IN_FLIGHT && signal_pending(current))

> -	return (i =3D=3D timeout) ? -ETIMEDOUT : 0;
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917102202.7508=
95-1-jun.miao@intel.com?part=3D1
