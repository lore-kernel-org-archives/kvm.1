Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF154279E9
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895242; cv=none; b=MaAUF6cQmi/Vqlrx2W0SYtVlbluRkCQyXq9mhDoHVO5U7/MIoESYiWurDpzlAxE/aHhojrYEXjkViON2Yy0m86QxI2kdynvfc1luMsZJVYHNfcsyRPAelnMSwJWl+3o1OAgsW1CBImpuyaBDf1yyYwHWfz9fo1zWznhQ1vyySXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895242; c=relaxed/simple;
	bh=PvJhErzwWQhYhkgxqrLa44kRP4FZaB5QpBmUUE6SEHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T/fd1/UzT0NsPriUhIfMZh0abJfaa3+QEcVdRSogdi4UPAWcRKPYhoML9xpBmBlFA4eHsDiFufUBTxZu6RyyZ9NsHtI/ZvZwL0I86m7z+D7cymQ2PyhIeNBcGsL+xoy7ElFkw5CS9M5pr7cv05nwPvZKVMsrkLQ6WdV5wbMNZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP9CUnyh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP9CUnyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466EA1F000E9;
	Wed, 27 May 2026 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779895239;
	bh=9T6KTP8PA+bSNLkFq8ygLQ0oMZESLXkBvVoa5WmMmqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EP9CUnyh7wuekLe4nwnY8HEwIq1gu/9u277YII7QWqgbLSCU6812AOyS/Zj04BoZk
	 RHf4rOSU9s2r5CaNZhhnGv/g4vWHLeZwqNKj5Q5RksWiVZHiWvu/SKWvYQl+t+6AZm
	 gpN+dtz8cmleSqy6wx5cKiFH3vzIwsfRjKUaxmuizl+BqAuyA0q2P2VP7dwh0EFwyR
	 EJU8/TKo7LfJPWG6ZTaV8EpCHWROJFYwInAH1CjfJ9BRlBXcfhm53ESCYf9vdl7l9T
	 fGsFvJWM4TbiZDiWrDTT3/c8UFr9IIPEJTtTKPE3ov2bRrgLYRV+rmD8w9IzLlvIsH
	 +BLoeexVTt6NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] KVM: s390: Track page size in struct guest_fault
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260527144358.186359-2-imbrenda@linux.ibm.com>
References: <20260527144358.186359-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 15:20:38 +0000
Message-Id: <20260527152039.466EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] kvm_s390_faultin_gfn() silently returns false success when a c=
oncurrent MMU invalidation occurs, skipping the gmap_link() map operation a=
nd memory access callbacks.
--

commit d74f84462345c6d6532552f9a640e4eaeed03bc3
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Track page size in struct guest_fault

This patch adds a crste_region3 flag to struct guest_fault to indicate
whether the crstep used to solve a fault is a region 3 entry with FC=3D1
(large pud). This allows callers of kvm_s390_faultin_gfn() to determine
the page size used to solve the fault even when locks are no longer held.

> diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
> index 873e13ac5a27f..fad605305e05c 100644
> --- a/arch/s390/kvm/dat.h
> +++ b/arch/s390/kvm/dat.h
> @@ -501,6 +501,7 @@ struct guest_fault {
>  	bool write_attempt;	/* Write access attempted */
>  	bool attempt_pfault;	/* Attempt a pfault first */
>  	bool valid;		/* This entry contains valid data */
> +	bool crste_region3;     /* Whether crstep refers to a region3 entry */

[Severity: Critical]
This is a pre-existing issue, but does kvm_s390_faultin_gfn() silently
return false success when a concurrent MMU invalidation occurs, skipping
the gmap_link() map operation and memory access callbacks?

In kvm_s390_faultin_gfn(), the local variable rc is initialized to 0. Inside
the while (1) loop, if mmu_invalidate_retry_gfn() inside the mmu_lock
returns true, the code skips the gmap_link() call.

Because gmap_link() is skipped, rc is not updated and remains 0. The loop
then evaluates "else if (rc !=3D -EAGAIN)" and immediately returns 0 (succe=
ss)
instead of retrying:

arch/s390/kvm/faultin.c:kvm_s390_faultin_gfn() {
    ...
    int rc =3D 0;
    ...
    while (1) {
        ...
        scoped_guard(read_lock, &kvm->mmu_lock) {
            if (!mmu_invalidate_retry_gfn(kvm, inv_seq, f->gfn)) {
                f->valid =3D true;
                rc =3D gmap_link(mc, kvm->arch.gmap, f, slot);
                ...
            }
        }
        ...
        } else if (rc !=3D -EAGAIN) {
            return rc;
        }
    }
}

When called via access_guest_page_with_key_gpa(), this false success causes
the caller to return context.exception (implicitly 0). The actual memory
access callback _access_guest_page_with_key_gpa() is never executed because
it is invoked from within gmap_link().

For memory reads, the host kernel sees a successful return but the output
buffer remains completely untouched, potentially leading to guest state
corruption or information leaks.

Furthermore, for the KVM_PRE_FAULT_MEMORY API which relies on this function
to populate f.ptep and the newly added f.crste_region3, if skipped, these
fields retain their zero-initialized values, causing the ioctl to silently
skip up to 1MB of memory while incorrectly reporting progress to userspace.

>  	void (*callback)(struct guest_fault *f);
>  	void *priv;
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527144358.1863=
59-1-imbrenda@linux.ibm.com?part=3D1
