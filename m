Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA5E4A386A
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635978; cv=none; b=uidJAzOLvKDuzzFyF9ZRj9jKEHgjWny/riY1UXwtslUJOsZ09me0kUuBszbcsGUhnmjTAfYfoaxprolgXrrf/KdDKSEm7QaaqXNbkp9ZRQc/y711SGkVwqoYsX2m/arR31pbfxopgYbzaD5a0+UQoa9gOoQyk5AtuknowQVpWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635978; c=relaxed/simple;
	bh=VQM5RHu4ipLxRK9ragICOIOjXMOtnGsFtTLl/qbimfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hhDrKM1yi/uSSTlbD1kyvT2XQTPLDOKh1M9S+O5dnPAKEUWCTD7kgvjcpzEAiETcERupvPFXDDhMjtjA1ivllJ+sx+JTDDnXTkhiZzP/FSHFFuTpq2Cj4+H928QFC+GALAuOuJUmhzu25+lSO4jCQZAG8urpOlUBW1DchE2iYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJDfNvga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJDfNvga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A498A1F00893;
	Thu, 17 Sep 2026 09:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789635975;
	bh=WygfHy6z2CmLfqu/j8aAPhxoZPzccsvqX+T8b3SFBfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DJDfNvgaSwn3gsYvizyUwua5Y9m4LUDxv3nZxu5YahC/GPscfLB3J56Yk3pajdKWx
	 97CgpRN6Ip0+VXqfwxP7kOB74lVAOm4fEYMkFMTBYbw2FpKaCjxbs1feevgOcEEms9
	 BZk4b1xWdanKZ+KgxJXChhlJkw4FpDJ5nm5UMCBSlO2XfHXytZMManxdfCC0hW5Cku
	 WLKhdsIWR8LZFIvDVTbqf9UJFhsHfY+hbS6I8KHnsacWOGlOgux0QPEvawxJu8r+jl
	 ChD+/jssPRkpJzA/IaRb9r/Qz3LSfynpCQqJZcD2vHbRG/xXseoZ5buCq+TSNLBp2G
	 4ezVaqyuFwXbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] virt: tdx-guest: Use read_poll_timeout() to shorten
 get-quote polling interval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Miao" <jun.miao@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260917085533.750434-1-jun.miao@intel.com>
References: <20260917085533.750434-1-jun.miao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 09:06:15 +0000
Message-Id: <20260917090615.A498A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] virt: tdx-guest: wait_for_quote_completion() discards successful=
 quote on pending signal
--

commit c4b6f45a215285a9c5c32f569a08072ce93e37a2
Author: Jun Miao <jun.miao@intel.com>

    virt: tdx-guest: Use read_poll_timeout() to shorten get-quote polling i=
nterval

This commit replaces the manual msleep_interruptible() loop with
read_poll_timeout() to wait for TDX quote completion. It reduces the check
interval from 1s to 5ms and overall timeout from 30s to 2s to improve
performance.

> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/=
tdx-guest/tdx-guest.c
> index d0303e31e8161..a73d1f0335bee 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
[ ... ]
> @@ -251,18 +252,31 @@ static void *alloc_quote_buf(void)
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
> +	 * up once per 5 milliseconds to recheck the status is fine for this use
> +	 * case. Fixed-interval polling doesn't scale well since QE response
> +	 * times vary by implementation; an interrupt-based approach would be
> +	 * the proper long-term solution.
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
> +				5 * USEC_PER_MSEC, timeout * USEC_PER_SEC,
> +				false, quote_buf->status);
> +	if (ret)
> +		return ret;
> +
> +	if (signal_pending(current))
> +		return -EINTR;

[Severity: Medium]
Will this discard a successfully completed quote if a signal happens to be
pending?

If read_poll_timeout() completes successfully because the break condition
status !=3D GET_QUOTE_IN_FLIGHT is met, it returns 0.

However, the subsequent unconditional check for signal_pending(current) will
evaluate to true if a signal was received, causing the function to return
-EINTR instead of success.

Since the caller logs any non-zero return value from this function as a
timeout, does this force userspace to needlessly retry an expensive
hypercall while incorrectly logging a timeout error?

> =20
> -	return (i =3D=3D timeout) ? -ETIMEDOUT : 0;
> +	return 0;
>  }
> =20
>  static int tdx_report_new_locked(struct tsm_report *report, void *data)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917085533.7504=
34-1-jun.miao@intel.com?part=3D1
