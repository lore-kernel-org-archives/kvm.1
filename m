Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B230EF68
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780124188; cv=none; b=NjgLRs85CqwbOdgIfv2BLDdqd+NDgrPcQm+q544tzw+dQLK1eiOanYbKxBnUed4ZvNQynhZslp/rLKrXg/QjtuF60vlb2JQQq5Z+cmUQzB4Dhy+BPVXq4nkO233vUbjcRWMQIerrQvgT6pX4qP6QnkaHbi9+xrFsTuy/ZeUtKE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780124188; c=relaxed/simple;
	bh=DeOIRroXBUAc+FJqoqLSGDlosbO23imJt4P7tll+paM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ouZZMgYd089hi59DDOOgAjRWZLWgMaRrH4n5TTLB2WvzdTwkqRrvEQLmWbtonhSi03jSvPJHehmETA4w2USxhnKfVEWLROjXAp0z5f6fNpNZ4AhYvzGB3rwzGhTE8bz/8e1bOux/nxJ9QnMAPuSziWNxRMF8yqFdEGgC9tD4/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5CwOOeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5CwOOeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C7F1F00893;
	Sat, 30 May 2026 06:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780124187;
	bh=UDGHERP5E4rcYAYS/DMHteSvhxuey3rr09yyNVElHO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D5CwOOeBi5c4+9H3ckhnTM2a08yImRrSHazwtLhmWPJokDcdZCgFRVJCRomirAmqk
	 P+PhldFJMvhLidEeTaxQtwk6XA81XTvj9Cw6D9eDmw+eXKnlwKTBtiSnaS5wgmWwU9
	 bv9YPpUWkD+dz968aiuqSWouSwbyVHGuRPoxaq8GgLIMQGtM14/DyM3tII8Yx/Y1EM
	 weDk9L19syoYegLrGfIlpoHl3VUoq3QNnNaguQ+nktTqYyhSVfwp4ikij9wLlvLSyL
	 /t1DMvamvbtTnNMgaUpaJY/1dJv0sOpYI5pltr0hbWZYfKa2a50HriMRwuIz0ca/Ro
	 geqoE1mfLxDaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/27] KVM: S390: Refactor gmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-16-seiden@linux.ibm.com>
References: <20260529155050.2902245-16-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 06:56:26 +0000
Message-Id: <20260530065627.25C7F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Memory allocation failure in `gmap_commit_memory_region` silen=
tly leaves stale guest hardware page table mappings, risking Guest-to-Host =
sandbox escapes.
- [High] Non-atomic clearing of the KVM dirty bitmap via `memset` races wit=
h concurrent memory faults, causing permanently lost dirty page records.
--

commit a87cd956788430d74dd24a5b4e2b190986ff3010
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: S390: Refactor gmap

This commit refactors gmap code so that a second s390 (host) KVM
implementation can use it. It moves relevant definitions into the shared
kvm_host.h and moves mmu code and traces from s390 to gmap.

> diff --git a/arch/s390/kvm/gmap/mmu.c b/arch/s390/kvm/gmap/mmu.c
> new file mode 100644
> index 0000000000000..d424aa361e795
> --- /dev/null
> +++ b/arch/s390/kvm/gmap/mmu.c

[ ... ]

> +int gmap_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
> +{
> +	int r;
> +	unsigned long n;
> +	struct kvm_memory_slot *memslot;
> +	int is_dirty;
> +
> +	if (kvm_is_ucontrol(kvm))
> +		return -EINVAL;
> +
> +	mutex_lock(&kvm->slots_lock);
> +
> +	r =3D -EINVAL;
> +	if (log->slot >=3D KVM_USER_MEM_SLOTS)
> +		goto out;
> +
> +	r =3D kvm_get_dirty_log(kvm, log, &is_dirty, &memslot);
> +	if (r)
> +		goto out;
> +
> +	/* Clear the dirty log */
> +	if (is_dirty) {
> +		n =3D kvm_dirty_bitmap_bytes(memslot);
> +		memset(memslot->dirty_bitmap, 0, n);

[Severity: High]
This is a pre-existing issue, but does using memset here to clear the
dirty_bitmap create a race condition?

Because memset performs non-atomic byte writes, could it race with concurre=
nt
mark_page_dirty calls that use atomic bitset operations?

If a concurrent dirty page update is overwritten and lost, could this cause
guest memory corruption during live migration since the missed dirty page
would not be transferred to the destination?

> +	}
> +	r =3D 0;
> +out:
> +	mutex_unlock(&kvm->slots_lock);
> +	return r;
> +}

[ ... ]

> +void gmap_commit_memory_region(struct kvm *kvm,
> +			       struct kvm_memory_slot *old,
> +			       const struct kvm_memory_slot *new,
> +			       enum kvm_mr_change change)
> +{
> +	struct kvm_s390_mmu_cache *mc =3D NULL;
> +	int rc =3D 0;
> +
> +	if (change =3D=3D KVM_MR_FLAGS_ONLY)
> +		return;
> +
> +	mc =3D kvm_s390_new_mmu_cache();
> +	if (!mc) {
> +		rc =3D -ENOMEM;
> +		goto out;

[Severity: Critical]
This isn't a bug introduced by this patch, but is it safe to perform a
fallible allocation in gmap_commit_memory_region? Because KVM commit hooks
return void, the common code cannot roll back memslot changes if this fails.

If kvm_s390_new_mmu_cache fails with -ENOMEM here, we jump out and skip
updating the hardware DAT tables via dat_delete_slot. Could the guest
retain hardware-level access to a removed memory region as a result?

If userspace reuses this virtual address range for sensitive internal data
rather than unmapping it, could the guest read or write it, leading to a
sandbox escape? Should this fallible allocation be moved to
gmap_prepare_memory_region instead?

> +	}
> +
> +	scoped_guard(write_lock, &kvm->mmu_lock) {
> +		switch (change) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D15
