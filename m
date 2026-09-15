Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27F4398F2;
	Tue, 15 Sep 2026 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494835; cv=none; b=s10DHrWhP+b/lyw8qlG+DZGUvfjMIo1yOgAo537Zzgq2y37Q0YCt1w3NoQUp8p3i4D8KdqM5LDsFBHpAk6Vk+kGdL8JZdt1DHwTeHM8NNXuI3iF/wZ7VEWOCoIySusqrtkSax1doI96E8AQBJJPsc68p1HQw+ykN2k0OF3vdBGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494835; c=relaxed/simple;
	bh=w/JotG/w8Y7N4t3Kkq1rsKQJNYp3wTyHKEJsL7bhERo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmWLYgh5GUm+LRKg8ST8eLazHjUM7yqrytMloUby0pCPb8r+56MzGtTLNT+Wf2E3a1VeMUvDDwmPljLucffuUbDVUMXui8TtjZOBDWz+85N3EhyUK7vBHff8/9DXOrGPDppf5l6cKiA8AUT2KnD5I6rrUESsNou2/hPFxAMeR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Bw8gxOC9; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Bw8gxOC9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789494829; x=1789754029;
	bh=ZaEH1QYOsw9tgItJ4v4fWLtqFRZdql3u3G/MJ4VVsfc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Bw8gxOC9VoIDXEO9sobxCg89tfXtrqfZ9Ej6dS9TqiMr5aqlup3eTPj9thtQuLARE
	 VlU4/btc6i536ldlghJITLoGyO+D+l6IDsg8/w+h8TSmvxHQdUAFIh/tOh3ZziuK/v
	 V2L4CFbFy7l1cB9OYvto8FHk3kc76k9P8KS0jmJmaYfa+ye7GEbzBtm0LrnwoL/CBy
	 5WRObouaxnYIWSTmhOY+/yrjFXfrdlGNdBMJAvNl4hrQPiQk47w1DTIavuxNosuqTD
	 5PxNSPpZUDBGgsMNJ0lO/4CaYB7O0zGQ94vxn1XOb7AmsmtbIb0G8DF2KwkDqncJpi
	 ngT4p0IVV7brQ==
Date: Tue, 15 Sep 2026 17:53:47 +0000
To: pbonzini@redhat.com, seanjc@google.com
From: David Ballesteros <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] KVM: Release memory-attribute reservations abandoned on ENOMEM
Message-ID: <20260915175335.138547-2-davimaba.v@proton.me>
In-Reply-To: <20260915175335.138547-1-davimaba.v@proton.me>
References: <20260915175335.138547-1-davimaba.v@proton.me>
Feedback-ID: 219068424:user:proton
X-Pm-Message-ID: 7ccba3ddc29020674a2e39f701e2d1a392c39b7c
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

kvm_vm_set_mem_attributes() reserves an xarray entry for every GFN in the
range before storing anything, so that the store phase cannot fail partway
through.  When a reservation fails, the loop jumps to out_unlock and the
reservations already made are abandoned: nothing in the call releases them.
A later request that clears a range covering them does erase them, as the
clear stores NULL over the reservation, but nothing obliges userspace to
issue one and a caller exploiting this will not; absent such a call the
entries live until kvm_destroy_vm().  An unprivileged user with /dev/kvm on
a VM with private-memory support can therefore leak kernel memory across
calls (a 576-byte xa_node per 64 GFNs) for the life of the VM fd.

The abandoned entries are not inert.  A bare reservation is an
XA_ZERO_ENTRY.  kvm_range_has_memory_attributes() is inconsistent about it:
the end =3D=3D start + 1 path and the general loop treat it as absent (matc=
hing
kvm_get_memory_attributes(), which maps it to NULL via xa_load()), but the
!attrs fast path calls xas_find() directly, which returns the zero entry as
present.  Via hugepage_has_attrs(), that makes
kvm_arch_post_set_memory_attributes() mark a straddling head/tail hugepage
"mixed" for a range whose attributes are in fact uniform, so KVM stops
using a hugepage there until a later request re-covers it.

Release the reservations this call made on the failure path.  xa_release()
erases an entry only while it is still a reservation, so value entries that
predate this call are left untouched; it takes no gfp and cannot fail.
Only [start, i) is walked, i being the index whose reservation failed (no
entry was created at or beyond it).

Runtime-verified on v6.18.48 (isolated sw-protected VM, no KASAN, no fault
injection; the reservations are left behind by real memcg pressure via
clone(CLONE_VM), not by fault injection).  Unpatched, a failed request
retains on the order of 450000 xa_nodes (~250 MiB), and with one of them
inside a 2 MiB region a clear of the region's head page leaves pages_2m
unchanged (the reservation is invisible to xa_load), a clear of two pages
drops pages_2m by one and raises pages_4k by 512 (the hugepage is
degraded), and a clear covering the whole 2 MiB restores it.  With this
patch the same run retains under 2000 nodes -- three orders of magnitude
less, at the level of run-to-run noise -- and pages_2m stays at 16 across
all three clears: the reservations are released, so the hugepage is never
degraded.  Both arms used the same kernel config and the same test binary.
The bug reproduces with XA_FLAGS_ACCOUNT applied (patch 3/3), i.e.
accounting alone does not fix it.

Found by an AI-assisted security audit.

Fixes: 5a475554db1e ("KVM: Introduce per-page memory attributes")
Cc: stable@vger.kernel.org
Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: David Ballesteros <davimaba.v@proton.me>
---
 virt/kvm/kvm_main.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2575,7 +2575,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm,=
 gfn_t start, gfn_t end,
 =09for (i =3D start; i < end; i++) {
 =09=09r =3D xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
 =09=09if (r)
-=09=09=09goto out_unlock;
+=09=09=09goto out_release;
=20
 =09=09cond_resched();
 =09}
@@ -2594,6 +2594,28 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm=
, gfn_t start, gfn_t end,
 out_unlock:
 =09mutex_unlock(&kvm->slots_lock);
=20
+=09return r;
+
+out_release:
+=09/*
+=09 * The reservation loop failed at @i; the entries in [start, i) were
+=09 * reserved by this call and, without releasing them here, would be
+=09 * retained until userspace happens to clear a range covering them, or
+=09 * until the VM is destroyed.  The retained entries are not inert:
+=09 * a bare reservation is an XA_ZERO_ENTRY, which the !attrs fast path o=
f
+=09 * kvm_range_has_memory_attributes() counts as present (it calls
+=09 * xas_find() directly) even though kvm_get_memory_attributes() reports
+=09 * it as absent, so a straddling hugepage over such an entry gets marke=
d
+=09 * mixed and KVM stops using a hugepage for a range whose attributes ar=
e
+=09 * uniform.  xa_release() erases an entry only while it is still a
+=09 * reservation, so value entries that predate this call are untouched.
+=09 */
+=09while (i-- > start) {
+=09=09xa_release(&kvm->mem_attr_array, i);
+=09=09cond_resched();
+=09}
+=09mutex_unlock(&kvm->slots_lock);
+
 =09return r;
 }
 static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,

