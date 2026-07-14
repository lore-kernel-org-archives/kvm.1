Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985042DA58
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064876; cv=none; b=MySUE9iduWnluMDivD2kVc4Ok6e0VRejT+CqcyD/a5O9llvSBqnql4cQlPVvYuMuWGc97+gxJ3q94moKQcju3hdgOxh9khnkcNw6sEPeotySmIdbzHWudpfzJdATn30odIf9QsSQ8G//1/w7wEop38hQVs7OhGiY0MorGPe+mbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064876; c=relaxed/simple;
	bh=Jf9LF9XwtMzp6Rx9n/qDEYyqkXzZphAJFL31if5jTEs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DS5Jsq5of5evjFbg1cHFNIFw8HpSchSh6WuKt4ElCimnBTMcbay1EVdg36NbNbJhBFeEtSGSWTQGoVR8NkB+AoNrJpKeaQEYBt4d6EnO6g2rDSTtrz2RB77O2v3NVhAkqqJ4GerVKmZMq93KHC3IM6lUrOwgtuS3IMUUfh4bsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6YvnrHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6YvnrHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BA81F00A3A;
	Tue, 14 Jul 2026 21:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784064873;
	bh=QZx0DIanvldZvjaayS5ycUA3cw9LOz48vV8jnc8HMWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y6YvnrHJvmp1DZ6G/avLwvQzyWNQpIKxzp8ZWCgKH8FjdSYU6mIpXdcYSh5LMJ6Kw
	 4vDg+Es9dGIlfSkFGV3Opp1yd7zF9Uoghhq9oUo0+YyoFtWjEsNNhyly7/Xly58NZa
	 AQBc+InB4y+KNEhejQrIB/EMcpPNjhhuqVy34AU4l2ha5ARPMgvUWVBnIhWohxr3g8
	 xPP7r6Qr8L9BwXc7XzKykYDzi09cRmQiawrNdw7rBq6kr4FNKCYoqRmIjIborshhZw
	 IqJd2RQY37BTqk9YWpKUku/p4ocmHG7ge0P/GmfKN8fTloQU1Z1H/irjDrBAY3gnzQ
	 LA6eOnXThhyJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] iommufd: Periodically reschedule when unmapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Lewis" <aaronlewis@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714210303.3967981-3-aaronlewis@google.com>
References: <20260714210303.3967981-1-aaronlewis@google.com>
 <20260714210303.3967981-3-aaronlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 21:34:32 +0000
Message-Id: <20260714213433.02BA81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `cond_resched()` rate limiter is circumvented for fragmented m=
emory because the loop counter `i` is local and resets on every batch, leav=
ing the scheduler warning unresolved.
- [High] Using `BIT(PUD_ORDER)` to rate-limit `cond_resched()` to 1GB is un=
portable and scales incorrectly on architectures with larger page sizes, pr=
eventing rescheduling.
--

--- Patch [2]: [PATCH 2/2] iommufd: Periodically reschedule when unmapping =
---
commit 32d4b71fc4dce755ccc1bb27abe57a685f82b576
Author: Aaron Lewis <aaronlewis@google.com>

iommufd: Periodically reschedule when unmapping

This patch adds a cond_resched() call to batch_from_domain() to avoid
scheduler warnings during large DMA unmaps. It attempts to rate-limit
the yields to approximately once per 1GB of processed memory.

> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 03c8379bbc347..e7abb3350b235 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -412,6 +412,7 @@ static void batch_from_domain(struct pfn_batch *batch,
>  	unsigned int page_offset =3D 0;
>  	unsigned long iova;
>  	phys_addr_t phys;
> +	int i =3D 0;
> =20
>  	iova =3D iopt_area_index_to_iova(area, start_index);
>  	if (start_index =3D=3D iopt_area_index(area))
> @@ -428,6 +429,9 @@ static void batch_from_domain(struct pfn_batch *batch,
>  		iova +=3D PAGE_SIZE - page_offset;
>  		page_offset =3D 0;
>  		start_index++;
> +
> +		if ((++i % BIT(PUD_ORDER)) =3D=3D 0)
> +			cond_resched();

[Severity: High]
Does this regression mean the counter fails to trigger cond_resched() when
operating on fragmented memory?

Because i is a local variable, it resets to 0 on every call to
batch_from_domain(). For highly fragmented memory, batch_add_pfn() will
fill its array and return false early (limited to roughly 5,461 pages by
TEMP_MEMORY_LIMIT).

This early return causes the outer loops, such as iopt_area_unpin_domain(),
to repeatedly call batch_from_domain(). This continuously resets i to 0
before it can ever reach the threshold, meaning cond_resched() is never
called and scheduler lockups can still occur.

[Severity: High]
Is this a regression on architectures where BIT(PUD_ORDER) does not equal 1=
GB?

The commit message mentions limiting the cond_resched() call to once per 1G=
B.
While this holds true on architectures like x86_64, it scales incorrectly
on architectures with larger page sizes.

For example, on ARM64 with 64KB pages and 3-level page tables, PUD_ORDER
is 26. BIT(26) iterations of 64KB pages corresponds to 4TB of memory,
not 1GB. The loop will only yield once every 4TB, which effectively defeats
the mitigation on these architectures.

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714210303.3967=
981-1-aaronlewis@google.com?part=3D2
