Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7432B556B81
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182385; cv=none; b=NDsrvB8qQ12BXLnuLJsV5S91zBm9S0AWMx6iZ1+TMNC+EznH6gTL/mOX/eUiHE/EAw7YdrwtbhgokJrBQhUZhD5f7F+b2K7SuPV91brx8nIhowco2aveTn7AO/vgJO0q9H3umZMhq2yhhm3Yt53jLgm2qtmnWGzJxlmVouD/JAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182385; c=relaxed/simple;
	bh=JX72rW3BuU2DWlTQZVFBpC3rZT/ua9g8z8BkoQ4+NDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f10PvAEzy9OatG/NNwB6eyoWyFyK7NVzbl87XEifWga2fiEfSBZvRbYxrCY/pLDuezPirg5WX9BLD2aAFj0JQSKj2x4e8y6f9ENUDjx2Q74g0o6MC/8yqpxHMiHyS8dKQKTJ365Dhk+bV4EDLQIEl1UzGUdmWhQ4bI2oUpNTH4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob7+uyee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob7+uyee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1662E1F000FF;
	Wed, 23 Sep 2026 16:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790182384;
	bh=8LKx2w6Atc9RNnebK/VkYmSfOkjzDcITEEXjlS/iT3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ob7+uyeen5QRuiAc3LkVQg+IYLAKjviIyRhJlkrET6yemIpMVy8794DUflL0gqTIW
	 xkhI9r10Rsqy2XQPC2fcibNO61kwtZRlVOdk5gKSBCu2vx9rX2cNkZVDAy4EGJzttN
	 L2EO5qPLfmS/604UqbktJa3JZerXVKFkX7UWM8eVm7bzXeu6XD7HB3KGAUKMHy0VDI
	 qqHHcP1LRhdFhXbcsxIyd3t/ehzfx345Cf6TK/flPZUW0ky5Dh94V+MMcpvzOeQ/+a
	 EuH+3saI2SB+ET8a9U61ihHJZOMijpcjsWFrLMeWjsBZ52SFsX1wC8ikRHrUA46KmQ
	 RA41R8TastXNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: SEV: Do cache maintenance on the source VM
 during intra-host migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260923163721.1584779-3-seanjc@google.com>
References: <20260923163721.1584779-1-seanjc@google.com>
 <20260923163721.1584779-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:53:03 +0000
Message-Id: <20260923165304.1662E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kvm: sev: TOCTOU race in sev_migrate_from causes host memory c=
orruption
--

commit b97586a7411bd5d8a55967b35859f6e485f10868
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Do cache maintenance on the source VM during intra-host migration

This commit manually performs cache maintenance on the source VM during
intra-host migration. Since the source VM is converted to a non-SEV VM,
automatic memory reclaim flows will not trigger the required cache
maintenance, potentially leaving stale data in the CPU caches.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index c9242c936a401..71923cb72d1d1 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2048,6 +2048,12 @@ static void sev_migrate_from(struct kvm *dst_kvm, =
struct kvm *src_kvm)
>  	src->pages_locked =3D 0;
>  	src->es_active =3D false;
> =20
> +	/*
> +	 * Do cache maintenance on the source VM as it is no longer an SEV VM,
> +	 * i.e. memory reclaim flows won't trigger cache maintenance on the VM.
> +	 */
> +	sev_writeback_caches(src_kvm);

[Severity: Critical]
Is there a race condition here if memory is reclaimed concurrently?

If a userspace process or kernel reclaim triggers a memory unmap (for
example, via MADV_DONTNEED) concurrently with the KVM ioctl, it could happen
in the window between setting src->active to false and calling
sev_writeback_caches():

CPU1 in sev_migrate_from():
    src->active =3D false;

CPU2 running concurrent unmap:
    Since active is false, the automatic cache flush in
    sev_guest_memory_reclaimed is skipped.
    The host frees and reallocates the page.

CPU1 in sev_migrate_from():
    sev_writeback_caches(src_kvm);
    Executes a hardware cache flush (wbnoinvd), which writes the guest's old
    dirty ciphertext over the new page owner's data.

Because sev_migrate_from runs without mmap_lock or mmu_lock, MMU notifiers
can run concurrently. Can this cause host memory corruption by overwriting
newly allocated host pages with stale ciphertext?

> +
>  	list_cut_before(&dst->regions_list, &src->regions_list, &src->regions_l=
ist);
> =20
>  	mutex_lock(&sev_mirror_lock);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923163721.1584=
779-1-seanjc@google.com?part=3D2
