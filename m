Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73C12F8E99
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895057; cv=none; b=XJ8geaHELAnuu3gszinOCyBF6U1s+WhtNi93ZtAVITed3MWGWCqIDar5Upd1kngbyD9t1+KkRjJbZTfz679tICU5ESv8lf+1/fRZZHUSRqmu4kc93QrDpI2OyiVA4tLv5SuJTBLoWvKpjPwf2/GDANPljezudKace3b/vec/Zhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895057; c=relaxed/simple;
	bh=RXJQ46TpLl9RkQUymQ8Z6ffE99IZdtP9ntDKaBrB/30=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A3rMRavgdlHdY4QKzk/Hps+ABDIHz8HaBKNVFu0Qoq6CVXKMnkCH1PyZBIJLhKG/KUP2CwWwzQbEQ4i/89SZ/FWC9Hskvwu4AzdRcJ26MHNYKXDkdvUU7V3pUcGwersO6SZ9mkyXS3Vqsf7Dw1VAcJU9xxh5Wz2Rd9Jze9G6YG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd5vJO4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd5vJO4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6C81F000E9;
	Wed,  5 Aug 2026 01:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785895055;
	bh=SIrUctmyzn6THDp7iUOkOvjbccY0niFH8V9sr8rAFAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fd5vJO4aIvW4tJduwDtaHgiuSuQBKZvvkmf0QYKU/+/ZEtk3HxbqFaT8l+QOS217r
	 6P+ugCmTPoUzjVn+xeGqmACMcNez//tt9ZlTo4e2nMR7i4UGY/eH+VvHYwURN3Z5YE
	 wqRJkPLlWOqfkaV+ErJW1bVg1IlW3LLGmr7C6J7+7biKUznFFRH2P1ZHM5LlpzTV4l
	 a3UShrRn4R2PcDpw/Uv5skfmzoybCzBra/Xi8dYAELJUPe+kZhQfTPRDCU9YRtLYHu
	 ma0ZCrMNahGlOkDmjKDsMpHeQI0ufuga4y6uvapVcdkBcVBu112oZKbpOBYbHLMAfn
	 ogSHqps/uIa5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v14 4/5] ptr_ring: move free-space check into
 separate helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Schippers" <simon.schippers@tu-dortmund.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260803183641.96882-5-simon.schippers@tu-dortmund.de>
References: <20260803183641.96882-1-simon.schippers@tu-dortmund.de>
 <20260803183641.96882-5-simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 01:57:35 +0000
Message-Id: <20260805015735.7D6C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but `__ptr_ring_full=
()` lacks a check for a zero-sized ring, leading to a kernel crash (page fa=
ult/panic) when it dereferences `ZERO_SIZE_PTR`.
--

--- Patch [4]: [PATCH net-next v14 4/5] ptr_ring: move free-space check int=
o separate helper ---
commit 883e8b9b82d44bf10bcbbae97968cf7b37d933bd
Author: Simon Schippers <simon.schippers@tu-dortmund.de>

ptr_ring: move free-space check into separate helper

This commit moves the available free space check for a new entry into a
separate helper function. It allows callers to determine in advance whether=
 a
subsequent produce call will succeed. Existing callers checking for a
non-zero return value remain unaffected.

> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index d2c3629bbe451..631c43fde4407 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -96,6 +96,26 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
>  	return ret;
>  }
> =20
> +/* Report whether the next __ptr_ring_produce() has room for one entry:
> + * 0 means the single slot at r->queue[r->producer] is free, -ENOSPC mea=
ns
> + * the ring is full, which is transient, and -EINVAL means r->size is 0,
> + * which is permanent. A caller that stops producing and waits for space
> + * must therefore do so only for -ENOSPC.
> + *
> + * Note: callers invoking this in a loop must use a compiler barrier,
> + * for example cpu_relax(). Callers must hold producer_lock.
> + */
> +static inline int __ptr_ring_check_produce(struct ptr_ring *r)
> +{
> +	if (unlikely(!r->size))
> +		return -EINVAL;
> +
> +	if (data_race(r->queue[r->producer]))
> +		return -ENOSPC;

[Severity: High]
This isn't a bug introduced by this patch, but __ptr_ring_full() in
include/linux/ptr_ring.h lacks a check for a zero-sized ring, unlike the
check added here.

include/linux/ptr_ring.h:__ptr_ring_full() {
	return data_race(r->queue[r->producer]);
}

Can this lead to a kernel Oops when it unconditionally dereferences r->queu=
e?

When a ptr_ring is initialized or resized to a size of 0, r->queue becomes
ZERO_SIZE_PTR. Calling __ptr_ring_full() evaluates r->queue[r->producer]
unconditionally without checking if r->size =3D=3D 0, leading to a page fau=
lt
when it dereferences ZERO_SIZE_PTR.

Would it make sense to update __ptr_ring_full() to safely check for
!r->size as well?

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803183641.9688=
2-1-simon.schippers@tu-dortmund.de?part=3D4
