Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B57175A7E
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711850; cv=none; b=DgONu7UuWBAMJSIJo7ILcaU73FJKD09Hw9dWqJ6OUn/7IGR2lqmy2XID+lXopWwrTxJNfxcOViomY2UR/boOMArSdNQKBBZnwn3bUofHvFXoulzyk+3oHpERhUVwyDU3w0/SjhY15Oxwptup+CWVgrIVUy3Jjw9zJzqYElC+q/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711850; c=relaxed/simple;
	bh=fQ87BVPAI+R0z70qyonJZnQswPOeGKkcIej1oI1agR0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P9vv52hiFp0GKe/DuIF8iPqCsM1VKUDvmN9d5kyinkFE5vLNv9RMyjqT3o7UYVciVhR/IHUQX8nYbzlZkIWpUEIxoAcQvalEa4JHd/V6wdnKmV1PEyj8W8XBhe2hZgYMG+cAGr/Q+1xxiVM6+qwljmKRoIYXL6o+bYTy/qUBTGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+904+Ig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+904+Ig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74CB1F000E9
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779711848;
	bh=4CJkwF44z3wJxT3vHoeKqT+T4HF0Wkf5JcpoK0KkynI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=d+904+IgbpM9CeyGQnEna+fcqpkfTbSNCwOIBkthFhQk0VGmxXiA1/oMczgDPWKNv
	 JMFapfVCFkfykPzI13TAqc4y60Ka1OMzbj8Wat5hPz2hDABGw4ZzEpQCBRvSsqVLWH
	 HUwiSEeRg3983T21dfpdtGPiRDQMg7C+eNoEtPaYQCv3NhTDuB2g6m8eDuxXAiME7K
	 n8TZj3eVHHMb/oGJYh+zy91MN/I4LbIjJiPlD1t9+ZpB3wisjp9WEG4IGLLHcRRl/h
	 zxkTW+MHb1Y80t0oY9icjBaP4uDOTTOznYk6NC3HV6PO5DL6s3wX5tYFyc6jTpvktD
	 seqDeop7KFJ1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/14] Documentation/userfaultfd: document RWP
 working set tracking
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525113737.1942478-15-kas@kernel.org>
References: <20260525113737.1942478-15-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 12:24:08 +0000
Message-Id: <20260525122408.B74CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] The documented VMM working set tracking workflow disables asyn=
c mode AFTER performing PAGEMAP_SCAN, creating a TOCTOU data loss race cond=
ition.
- [High] UFFDIO_SET_MODE relies solely on mmap_write_lock() to synchronize =
with in-flight faults, failing to exclude or drain per-VMA locked faults.
- [Medium] The example code uses an anonymous compound literal for the UFFD=
IO_API ioctl argument, making it impossible to inspect returned features.
- [Low] The example C code contains standard C compliance issues and an und=
efined variable in the `pwrite` call.
--

commit ae370f680f6102fabefea63e5943a13cca9daab8
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

Documentation/userfaultfd: document RWP working set tracking

Add an admin-guide section covering UFFDIO_REGISTER_MODE_RWP:

  - sync and async fault models;
  - UFFDIO_RWPROTECT semantics;
  - UFFD_FEATURE_RWP_ASYNC;
  - UFFDIO_SET_MODE runtime mode flips.

It also covers typical VMM working-set-tracking workflow from detection
loop through sync-mode eviction and back to async.

> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation=
/admin-guide/mm/userfaultfd.rst
> index 1e533639fd509..cb5d0e0c9fff1 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst

[ ... ]

> +**Runtime Mode Switching:**
> +
> +``UFFDIO_SET_MODE`` toggles ``UFFD_FEATURE_RWP_ASYNC`` at runtime, allow=
ing
> +the VMM to switch between lightweight async detection and safe sync
> +eviction without re-registering. The toggle takes ``mmap_write_lock()`` =
to
> +ensure all in-flight faults complete before the mode change takes effect.

[Severity: High]
Does taking only mmap_write_lock() safely synchronize with in-flight faults
here?

mmap_write_lock() alone does not exclude or drain existing per-VMA read loc=
ks.

Since modern page faults (including userfaultfd async and sync faults)
execute under the per-VMA lock, UFFDIO_SET_MODE could return while async
faults are still resolving if the implementation only relies on
mmap_write_lock().

Would the implementation need to call vma_start_write(vma) to properly
drain per-VMA locked faults?

[ ... ]

> +    uffd =3D userfaultfd(O_CLOEXEC | O_NONBLOCK);
> +    ioctl(uffd, UFFDIO_API, &(struct uffdio_api){
> +        .api =3D UFFD_API,
> +        .features =3D UFFD_FEATURE_RWP | UFFD_FEATURE_RWP_ASYNC,
> +    });

[Severity: Medium]
Since UFFDIO_API modifies the features field on return, how can the caller
inspect the returned features to fall back when RWP is unavailable?

Using an anonymous compound literal here means the struct lifetime expires
after the ioctl() statement, making it impossible to check the negotiated
features as recommended in the "Feature availability" section.

Should this use a named local variable instead?

> +    ioctl(uffd, UFFDIO_REGISTER, &(struct uffdio_register){
> +        .range =3D { guest_mem, guest_size },
> +        .mode =3D UFFDIO_REGISTER_MODE_RWP |
> +                UFFDIO_REGISTER_MODE_MISSING,
> +    });
> +
> +    /* Tracking loop */
> +    while (vm_running) {
> +        /* 1. Detection phase (async =E2=80=94 no vCPU stalls) */
> +        ioctl(uffd, UFFDIO_RWPROTECT, &(struct uffdio_rwprotect){
> +            .range =3D full_range,
> +            .mode =3D UFFDIO_RWPROTECT_MODE_RWP });
> +        sleep(tracking_interval);
> +
> +        /* 2. Find cold pages (uffd bit still set) */
> +        ioctl(pagemap_fd, PAGEMAP_SCAN, &(struct pm_scan_arg){
> +            .category_mask =3D PAGE_IS_ACCESSED,
> +            .category_inverted =3D PAGE_IS_ACCESSED,
> +            .return_mask =3D PAGE_IS_ACCESSED,
> +            ...
> +        });
> +
> +        /* 3. Switch to sync for safe eviction */
> +        ioctl(uffd, UFFDIO_SET_MODE,
> +              &(struct uffdio_set_mode){
> +                  .disable =3D UFFD_FEATURE_RWP_ASYNC });

[Severity: Critical]
Does scanning for cold pages before switching to sync mode introduce a data
loss race condition?

If a vCPU accesses a "cold" page between PAGEMAP_SCAN and UFFDIO_SET_MODE,
the async fault handler will silently remove RWP protection and grant write
access without blocking.

The VMM would then evict this page (copying it with pwrite and dropping it
with fallocate), and any concurrent vCPU writes would be discarded by the
hole punch, leading to guest data corruption.

Should the VMM switch to sync mode before calling PAGEMAP_SCAN to safely
freeze the working set?

> +
> +        /* 4. Evict cold pages (vCPU faults block on guest_mem) */
> +        for each cold range:
> +            /* Read from io_mem -- bypasses RWP, no fault. */
> +            pwrite(storage_fd, io_mem + cold_offset, len, offset);

[Severity: Low]
Does this code compile cleanly?

The pwrite() call uses "offset" as its fourth argument, but the file offset
variable seems to be "cold_offset".

Also, io_mem is a void* from mmap(), and pointer arithmetic on void*
(io_mem + cold_offset) is a GCC extension rather than standard C.

Should io_mem be explicitly cast to a byte pointer, and offset be changed
to cold_offset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525113737.1942=
478-1-kas@kernel.org?part=3D14
