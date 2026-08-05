Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2A30648C
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913570; cv=none; b=dnrQDU5Fcb373gTYQoj2Acg8D4QjDOj9sXHibSWdZqBRomyr6LTu2DLGDs04IRt5ETLrdLagAGvJM/9c43qIGzGcpsFbpdm4i30behswqHWi8aT2KM2bbqeHMaUiY1vnOIvLBo/BCJNTKiN81iy202CNjbTmdXYex/oYxlbv010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913570; c=relaxed/simple;
	bh=uHwJ5I0paXHM9l1D567hv7WSaUtXz6c+QVN5/bFIpXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LBe7S5qWPAYDYK1NSOVrqrhlZSRWW3kH3awXnOn1KsUN96ra8wauuusZ5jFMIEgQIzhGWm3fvs9niIRZinDuRuLpraLJfH4/99GrSOt+3EziSAuNEYMKQHp/JM49q5s6kQcH5MJR6AtV1YXY699Hf3QtxZkZN3m8aY70cXMDfkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/exdj0P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/exdj0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C447E1F000E9;
	Wed,  5 Aug 2026 07:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785913569;
	bh=x2Qh+Bcm773vqbfrDbsB6RuLgtczgQnYONaNTDwkCvU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/exdj0PmxxkX3DN/I2BrRz5siqJdxvc0utt3ujuIpL6+tWCgp1Sr1Hhs44SpMaBB
	 z7IVCNvk3O8AwQB1p6W/5iJqMKQZpabUDVq5sQ7H2VPoyNsMKvWULczA9xgTLCuXGc
	 OltQg9OqQypdyYzRbJiLqsymAfqehAH9W5vF+/zwpQWeIIVAFmDfnlXJMVlhgmoW4X
	 aXDfIG1x/TxKSeWMjGmXtz3wSYlTGsvlvyGo1z7Jjx/BfgFC2apaSEMizten+mrvtu
	 Z8ST0jWoIbhqLQh8588qPTjEff24YkDnys8v2uXJiDJkeon8/zk2KQutZ4jFLEXC9o
	 TbonscpqPwQuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] KVM: guest_memfd: take the invalidate lock when
 unbinding a dying file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260805-shivank-gmem-migrate-v3-1-00d8bdec4e1d@amd.com>
References: <20260805-shivank-gmem-migrate-v3-0-00d8bdec4e1d@amd.com>
 <20260805-shivank-gmem-migrate-v3-1-00d8bdec4e1d@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 07:06:08 +0000
Message-Id: <20260805070608.C447E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] kvm_gmem_bind() ignores the return value of xa_store_range(), =
which can fail with -ENOMEM, leading to inconsistent memslot tracking and g=
uest-to-host use-after-free.
--

--- Patch [1]: [PATCH v3 1/9] KVM: guest_memfd: take the invalidate lock wh=
en unbinding a dying file ---
commit 4192ee62a3c9cd53bedefe498647d781d59dfdf5
Author: Shivank Garg <shivankg@amd.com>
KVM: guest_memfd: take the invalidate lock when unbinding a dying file

This patch takes the invalidate lock during the dying-file path in
kvm_gmem_unbind() to prevent a race condition with memory failures.
It ensures the mmu_invalidate_in_progress counter remains balanced
when a binding is removed concurrently.

Link: https://lore.kernel.org/all/20260728092027.225CF1F000E9@smtp.kernel.o=
rg

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index db57c5766ab60..45cbdf4801ece 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

[Severity: Critical]
This isn't a bug introduced by this patch, but there is a pre-existing
issue in kvm_gmem_bind() where an error return is ignored:

virt/kvm/guest_memfd.c:kvm_gmem_bind() {
        ...
        xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
        filemap_invalidate_unlock(inode->i_mapping);

        /*
         * Drop the reference to the file, even on success.  The file pins =
KVM,
         * not the other way 'round.  Active bindings are invalidated if the
         * file is closed before memslots are destroyed.
         */
        r =3D 0;
err:
        fput(file);
        return r;
}

Does this code ignore the return value of xa_store_range(), which can fail
with -ENOMEM under memory pressure?

If xa_store_range() fails, the memslot won't be recorded in the guest_memfd
file's bindings. Subsequent host invalidations, such as FALLOC_FL_PUNCH_HOLE
or a memory failure, would fail to find the memslot and wouldn't invalidate
the guest's page tables.

Can this allow the guest to retain access to freed host memory, leading to
host memory use-after-free or cross-VM data corruption if the memory is
reallocated to other host processes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-shivank-gm=
em-migrate-v3-0-00d8bdec4e1d@amd.com?part=3D1
