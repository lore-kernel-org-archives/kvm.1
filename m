Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B3238D54
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514877; cv=none; b=OPuIy/ZyB5zywWtlpuDCSbfVDC1ooRRfWjWOHG+iQgoV/B9zyCm5+yhloAjSumVA8gC7ZR2r3CbreTlrOmqBLzxXhmH8p3MhqOnqeZyeDcQVbFEkiiBTNSwYa7bLmg2tZ2jBzG6wS8ufag0WDzeYgcBydv0QnWZfNfi7gAC9GUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514877; c=relaxed/simple;
	bh=/i9iFQ6SxTlMolecKcsZBTFda116yhf0OAEHd/HnJHQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NY7JuE1ZEhLoa0PGyIKplBrBAepg54bqS3PHP7SaFGB+R4zfWLYohR+iiNtL7L3sP8bDbcEFlRrFqIBcVhbBgT3b8IbjVz406NSY/7iWtOGG+aeYdKmqJwKIkGgvhfQ1m76Pn8Lm/LoKcdCWPCPAadVpdFVV4QEPHQsj8qmLTe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2UKmHeE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2UKmHeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853931F000E9;
	Sun, 23 Aug 2026 19:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787514875;
	bh=46sk9v2N+NupPmd1J5x0BF5n5y3St+lwhiyS7i7vRGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O2UKmHeEllFyNI0sWY+39B0rJSy/Yt7AsoiQOaBwrcqFoOC9DSuNWJw9z3yLklwCb
	 qidpBnYcQa071xF+ZX7tYR0hynfpMedQRaWqZsFrwbFqGFY4B57r8dqSs7ImoSXN0r
	 wvc3iin3mIF1/WzNZFzV9A8rywu3NKXiArLSxWCl5C5jHKCt9OKJ1Km2hlFK3qjluE
	 E0v2pLqRj5OmnDn0tDDmjQeZnvl6in0VbgVyEWK/BPJcM+ts95lzVe0zzQbg5Z7uiI
	 qIn0wwTI500q2Rj9YBUAyll2jQIxCTxRILZLHjm79sHMzvcqiUJUIuUTMk86ysJKXU
	 VR7bQ4oggCMkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] mm: memory_failure: Allow truncate_error_folio
 to return MF_DELAYED
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lisa Wang" <wyihan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260823-memory-failure-mf-delayed-fix-v5-2-d97a5703e45a@google.com>
References: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
 <20260823-memory-failure-mf-delayed-fix-v5-2-d97a5703e45a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 19:54:35 +0000
Message-Id: <20260823195435.853931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] AB-BA deadlock between `folio_lock` and `mapping->invalidate_lock`=
 involving the memory failure handler and guest_memfd file truncation.
--

--- Patch [2]: [PATCH v5 2/5] mm: memory_failure: Allow truncate_error_foli=
o to return MF_DELAYED ---
commit 1e7b00ec8e2bc22a20c74d21aa034f3f7f88aba8
Author: Lisa Wang <wyihan@google.com>
Subject: mm: memory_failure: Allow truncate_error_folio to return MF_DELAYED

This commit modifies truncate_error_folio() to check if the
error_remove_folio callback returns MF_DELAYED. If it does, the
function now propagates MF_DELAYED back to the caller instead of
treating it as an error.

> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -939,10 +939,12 @@ static int truncate_error_folio(struct folio *folio=
, unsigned long pfn,
>  	if (mapping->a_ops->error_remove_folio) {
>  		int err =3D mapping->a_ops->error_remove_folio(mapping, folio);

[Severity: High]
This is a pre-existing issue, but can this callback trigger an AB-BA deadlo=
ck
between the folio lock and the mapping invalidate_lock?

The memory failure path acquires the folio lock before reaching this point:

memory_failure()
  folio_lock(folio);
  ...
  me_pagecache_clean()
    truncate_error_folio()

When the callback is kvm_gmem_error_folio(), it then acquires the
invalidate_lock for read:

virt/kvm/guest_memfd.c:kvm_gmem_error_folio() {
    ...
    filemap_invalidate_lock_shared(mapping);
    ...
}

However, the file truncation path acquires these locks in the reverse order.
It acquires the invalidate_lock for write before taking the folio lock:

virt/kvm/guest_memfd.c:kvm_gmem_punch_hole() {
    ...
    filemap_invalidate_lock(inode->i_mapping);
    kvm_gmem_invalidate_start(inode, start, end);
    truncate_inode_pages_range(inode->i_mapping, offset, ...);
}

Since truncate_inode_pages_range() acquires the folio lock, could a
concurrent fallocate hole punch and a memory failure on the same guest_memfd
file lead to a system-wide deadlock?

> -		if (err !=3D 0)
> +		if (err =3D=3D MF_DELAYED)
> +			ret =3D err;
> +		else if (err !=3D 0)
>  			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823-memory-fai=
lure-mf-delayed-fix-v5-0-d97a5703e45a@google.com?part=3D2
