Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B93E5595;
	Mon,  6 Jul 2026 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335423; cv=none; b=KcSpNIMfxUrsUT0Gl+2Y9jJJgu55opLcGue2toYhNMLOw8p7I27eJF/Ly6ImMbNRdD/yUhHAfGuYgNeCYjeTJjFuoIBnUYrmzKi9hIitAnHkEOYOaJfAhJWnooM0M676JYeA9nWqkDSd6yWlgACD8Za4/n57tT36bS+bNGOOGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335423; c=relaxed/simple;
	bh=6tBHEmJXAzoJA1Iz9f5VO5wwZ++xTCYJmA5d/rIlLqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4pbVP+I2D7UQfvN66ReB/jwKkujAkl6jYfIlU7yWkHSGhmpnb8dlUP0qmtF9DCTGjL3xlBTY7GR1bYRmu0JdKlWE4yc7QF7RHTX5p7062+S8K/K7zfdlk6D6+4kggOQ/3LViaRGFRAzyOk3T5ctTNfOWh6O+x993vGdQRrdz18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8agmxFZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8agmxFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E061F000E9;
	Mon,  6 Jul 2026 10:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783335420;
	bh=9TtrHnv/qi4lGfcA8XXpkBAbAwnFcDJBMSEy+F8GNE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V8agmxFZj4+EhkprkJmhAyZXVvYWq4x2s9TtPvI+aPJ8hGRyPxKHBvIoSKehw29Da
	 1ANy+GCrq2yTMvNHJ0c4MOFTIAChl8fN7PvEpo9iUlCNqtmwUvdSFRSwMB1ubc/nQj
	 7Kl5KyOlqrk9FTmRVfFFJN1F29moAA+DqFyI0hUZHBtIE1Sqm7pIXa3aju8hzvzEzN
	 yz3HU/aqF5kI22n3IWq4tF5c80AmHLNdEy4keV+b962CnuvzXWIYldJkYxyFdhkEZI
	 SPNGHbDXhKh0KHIRsX8Q90irOU45Ew10VuKnzCwgDhU1gvkCqY79zdIrqvMz9lqWfG
	 nl7hGW6N+VV5A==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id B08FEF40068;
	Mon,  6 Jul 2026 06:56:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 06:56:58 -0400
X-ME-Sender: <xms:-olLat-EzM_LJwbXNIQ8m56H0bVx9T6l27AEua0Yr2b4oHBccVmH5g>
    <xme:-olLavV3vjXB-MrU1kPh94pWGUZC8oDxWnWecG0IDU6ewpN5OCz3lisE7yWX6X69I
    B8gNQwswO-9iSguLvYfUnSD4wMqTuQ3gjH6G7-pzTVOj996tqTjpGQ0>
X-ME-Received: <xmr:-olLagn3MWU5IvT919tfLF_S7hWKq6sYItMIdnVuDOnEgecUgbBYerrQTpAMLA>
X-ME-Proxy-Cause: dmFkZTG3EYxLj0L6vaHvG/JQokkQgmlapkgHi3g9IW9kfpTZuouF9wXLqvehvlO32VWfHa
    duqkk97Xe0HKhXsKxrdHqqNxki8kTptiLONgzXROpKLThcjWTWcvktV3WT6NtElSrQ5L7P
    JC+8p1nEl3HCpzViXlrhmV7vSWrcMtCeweeEKVIc0uVTWaL3+3LvWgTvlFqEkSG644EqaC
    oqD3l16HhA91FHOyL7u55F+RtRGyI/+KZDctCzRTvb3v0JOvk8HJd7JFhUMAqaGDdiiTjG
    VJjpfx1J1Owby6wkIkTfqdvO8SvfXk1POhBv4co9Qvufd9gwLSR2FgcbkoO8MgsA+1wnBo
    tz1w0KLGYpnTvNPu2XdlVEYx5zQx2A5k+0L9Vu5OB7grOD46Efooqb9DRDr5hGTPgX7rqR
    9a/DHNcPYA9z16Dok0ztAUvgOMFTW1aqy4hiJ440P6na09coYDUsMlVHK58n8lwLiIrFms
    03p/Vv56bjGS9mOT9oO5JqsJBQ1HDQqo7av2kSyyD+W52JyHMwVlTNRuzzaPHBRR4Izdfb
    C1bOzI0y5MFPEfrRJO0l/gMpuuAAjgxbxNJcFyv/wUIaY/JXRGzw91DPBuh2Q+GlDKB45h
    hznAG9RxPe5JbMCwi9l3NRVHBeAdUiLbY8Hxn33k9Z4QOJeGslOFTfzTA5wg
X-ME-Proxy: <xmx:-olLalFYYTvofYxEUV4s9LShIBvRseh4RZY3l3XwbNim4X8QP7C_-g>
    <xmx:-olLahSww4oFsZkGr0J7Efk-r06k42NJ3jQWsjf9L9DHyvqQtMfM2Q>
    <xmx:-olLasQMu1HWGipJb8c6Gu-6oG-UxEDrU3Z9jjsolCTTatjkCCsuJA>
    <xmx:-olLavcV5UuOm9YI0rEV1Yr6GswCbsa_IihLc5PiVHsX102z7qRLDA>
    <xmx:-olLarBWU9ljjQU2yd1LTse5SOgGNCYTBY51sYKZ4RD3uRE-duKlpfv_>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 06:56:58 -0400 (EDT)
Date: Mon, 6 Jul 2026 11:56:57 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org
Cc: ljs@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, 
	sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, kernel-team@meta.com
Subject: Addressing Sashiko AI review
Message-ID: <akuJmbUgGRtjksPr@thinkstation>
References: <20260706084805.8400-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706084805.8400-1-kirill@shutemov.name>

Hi,

I went through the Sashiko review of v9. Only one (test-only) patch
needed changes; sent as v9.1 of 14/15 in this thread:

  https://lore.kernel.org/all/20260706104906.36084-1-kirill@shutemov.name/

  - Tolerate EINVAL from madvise(MADV_NOHUGEPAGE) so the suite does not
    abort on CONFIG_TRANSPARENT_HUGEPAGE=n.
  - rwp-mprotect and rwp-fork-pin now assert the marker survived
    (PM_UFFD_WP) before the access that auto-resolves it, so a kernel
    that dropped the marker fails instead of passing vacuously.

The finding against 11/15 is a pre-existing PAGEMAP_SCAN inconsistency,
unrelated to RWP: an unpopulated pte is reported written by the
PAGE_IS_WRITTEN fast path but not by the generic path. Confirmed
reproducible; fixed separately with Fixes:/stable:

  https://lore.kernel.org/all/20260706104308.34741-1-kirill@shutemov.name/

The rest I assessed as false positives:

  - 07/15, move_pages_huge_pmd() corrupting a non-present PMD: a
    non-present source bails (-EAGAIN/-ENOENT) before the RWP re-arm,
    and the post-lock pmd_same() recheck rejects races -- the re-arm
    only runs on a present PMD.
  - 07/15, UFFDIO_MOVE re-arming RWP "destroys resolved state": this is
    intended. A MOVE-installed page starts tracked; the next guest
    access is the working-set event we want (async auto-resolves it).
  - 10/15, hugetlb stale-marker livelock after UFFDIO_UNREGISTER:
    markers are cleared on unregister and on release via
    change_protection(MM_CP_UFFD_RWP_RESOLVE); the rwp-close tests
    exercise this on hugetlb.
  - 13/15, check_stable_address_space() before the VMA walk in
    UFFDIO_SET_MODE: the ioctl holds mmget_not_zero() + mmap_write_lock
    and only takes per-VMA locks, and a ctx on a failed-fork mm is
    never published to userspace.

The 09/15 findings (userfaultfd_clear_vma() touching ptes before
vma_start_write(), the partial-unregister OOM rollback, and UFFDIO_MOVE
dropping uffd-wp markers) are pre-existing and left as-is; pte-level
access there is serialised by the pte lock.

Ping me if any of these assessments seems off.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
