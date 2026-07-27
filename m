Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CEA29DB64
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785115783; cv=none; b=BlBUj6vKvaYMHqFSGA6Bi/qDpXpjVWE6Qpy5FHKUZrU+FLmclsBpBHIgSP0/9igYLsZdd3KZGfhjkpr1+eGqJOfNqSBmAF9AHPbiM5GSpZWtDmLLUJ9c/667SulPSl+wFhmWj5Gf4BJHvfME+xVmGNT1wzGnIukq4XNJM0qLbag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785115783; c=relaxed/simple;
	bh=RyoU3ZpzMddQVcQ2/wVb7GAwCV7PAxhNXmADjgcRvgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ultIpiPtScVxG5T/dF3EuDuLY740HhU01i46masHH8HoY9VLb1QvYXaBXqawsG2t3QfMiP0gHmX9pC+xbuBXLk/bMuO5k7fQ9leMfbTGOz6jhenX8gkdIy0lhA9hXTC6rim3aclR3wdJLKc1dZURYsqUun+IYdp/C7QhyLrpVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Pvl/OnbM; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Pvl/OnbM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=EG6v1b6c6lWJbvSY7tX26XZzELFTawg9mXy2jaOVF5Y=;
	b=Pvl/OnbMYK3AgkdLZAmmb9AY6B9IljjdpnhXFozYDjcnsAchWSUw6iN2uspS9u
	EatQzy5kcIR93Xv4jQOmok89rF+L/HaAcmHF6bcG2Cz/gaOToExnNH6Z/dBAUod1
	qHonjzyPLz/FEoMAlATj4Vd+7O2raicGhUFWFK8hey9FM=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAHL7JYtGZqgN0UJQ--.46025S2;
	Mon, 27 Jul 2026 09:28:57 +0800 (CST)
Date: Mon, 27 Jul 2026 09:28:56 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Sean Christopherson <seanjc@google.com>, zhanghao <76824143@qq.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	Lisa Wang <wyihan@google.com>, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH v2] KVM: guest_memfd: Fix ABBA deadlock in
 error_remove_folio
Message-ID: <ama0WJdk-UzaF8BA@192.168.1.215>
References: <tencent_7DA064CAC9B463EB9B651801011E2CE4230A@qq.com>
 <amN6VptoRxbZJE2y@google.com>
 <CAEvNRgFTz7LETUpNeuR1sBXPFJ9N1e3ZYyPRg7R_HWARKmPcJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEvNRgFTz7LETUpNeuR1sBXPFJ9N1e3ZYyPRg7R_HWARKmPcJA@mail.gmail.com>
X-CM-TRANSID:PygvCgAHL7JYtGZqgN0UJQ--.46025S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxur4DtFykKrW5ury3Zw47Arb_yoW7Gr1rpF
	9xKas8KrsrWrn2vr1Iy3W8ta4Fq34kGr4UZr13Gwn3ZFyqyF17KF4aqF17uFyxGrs7Ww48
	Xay0gr9ruFyUZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaoGQUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3Rp3ampmtFoHSAAA33

On Fri, Jul 24, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Mon, Jun 15, 2026, zhanghao wrote:
> >> >From e7f25639c05eac51b4ac8add3dd3e3a76f6f7340 Mon Sep 17 00:00:00 2001
> >> From: Hao Zhang <zhanghao1@kylinos.cn>
> >> Date: Thu, 11 Jun 2026 15:27:27 +0800
> >>
> >> memory_failure() calls ->error_remove_folio() while holding the poisoned
> >> folio lock.  guest_memfd's implementation takes mapping.invalidate_lock for
> >> read before zapping KVM mappings.
> >>
> >> That lock ordering can deadlock against paths that hold
> >> mapping.invalidate_lock for write and then try to lock the same folio, e.g.
> >> guest_memfd punch-hole via truncate_inode_pages_range().
> >>
> >> The invalidate lock is needed for page-cache invalidation, but
> >> ->error_remove_folio() only needs stable guest_memfd bindings while walking
> >> them to zap KVM mappings.  Add a guest_memfd-private rwsem to protect
> >> established gmem file entries and their bindings during invalidation and
> >> removal, and use it in ->error_remove_folio() instead of
> >> mapping.invalidate_lock.  Update bind, unbind, and release paths to take
> >> the new lock when modifying bindings or removing a gmem file entry.
> >>
> >> Keep taking mapping.invalidate_lock before the bindings lock in paths that
> >> need both locks, so writers cannot queue on the bindings lock while a
> >> punch-hole operation is blocked on a folio lock.
> >>
> >> Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> >> Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
> >> ---
> >> Changes in v2:
> >> - add a guest_memfd-private rwsem to protect the
> >>   gmem_file_list and each gmem_file's bindings
> >>
> >> Link to v1: https://lore.kernel.org/all/tencent_4B051B84CDCC0D1964EC00337AA32E40DC07@qq.com/
> >>
> >>  virt/kvm/guest_memfd.c | 38 ++++++++++++++++++++++++++++++--------
> >>  1 file changed, 30 insertions(+), 8 deletions(-)
> >
> > Well shoot. I know I suggested this approach, but oof is it uglier than I was
> > expecting.  I forgot that it's not just the bindings that need to be protected,
> > the list of files also needs to be protected.
> >
> > And thinking about this more, I'm not convinced a separate bindings lock is
> > sufficient, as a concurrent __kvm_gmem_populate() could establish mappings after
> > kvm_gmem_error_folio() completes, if kvm_gmem_error_folio() runs between
> > folio_unlock() and post_populate().
> >
> > So for a stopgap, I'm leaning very strongly towards going with the trylock
> > approach you proposed in v1.
> 
> I think we can go with the stopgap for now, with guest_memfd
> conversions, the filemap_invalidate_lock() is relied on for even more.
> 
> > Longer term (or maybe even as an immediate fix?),
> > I think the ideal solution would be to rework truncate_error_folio() flows to
> > allow .error_remove_folio() hooks to unlock the folio.
> >
> 
> Actually it seems like having the folio locked is part of the contract
> of removing it from the filemap. IIUC filemap lookup relies on folio
> locking too. If that's correct, then it kind of makes sense that
> the .error_remove_folio() callback, which is meant to let filesystems
> take folios out of the filemap, is called under the folio lock. Or
> perhaps that's an assumption that all filesystems use a filemap?
> 
> The folio lock also prevents concurrent faults from happening. At the
> point of calling truncate_error_folio() the folio is supposed to already
> be unmapped. If we drop the folio lock for a short while, then
> truncation can't rely on the folio already being unmapped.
> 
> Since guest_memfd kind of monopolizes the folios it owns (on behalf of
> the guest), and with the restructuring that will probably come with huge
> page support, maybe memory failure for guest_memfd should be specially
> handled?
> 
> >>
> >> [...snip...]
> >>

Thanks Sean and Ackerley.

Agreed, v2 is not sufficient, especially because __kvm_gmem_populate()
can establish mappings after kvm_gmem_error_folio() completes.  I'll drop
the bindings_lock approach and send a v3 with the trylock stopgap from v1.

I'll also update the changelog/comment to describe the dependency as the
poisoned folio lock vs. mapping->invalidate_lock, and avoid implying that
mf_mutex is part of the actual deadlock.

While preparing v3, syzkaller also reported the same locking pattern on a
newer 7.2.0-rc3 based kernel.  The new report was titled

INFO: task hung in soft_offline_page

but it appears to be the same issue as the earlier

INFO: task hung in memory_failure

report.  In both cases, memory_failure()/kvm_gmem_error_folio() waits on
mapping->invalidate_lock for read while holding the poisoned folio lock,
and a concurrent guest_memfd punch-hole path holds mapping->invalidate_lock
for write while waiting for the same folio in truncate_inode_pages_range().

Thanks,
Hao

