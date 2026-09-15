Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A8443B6EB
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494851; cv=none; b=tEkDorXAa0cpK7pTCMdjwpTOTfOCJkzhLF/qNCMhz0S1Ec74YG+iPVfpPIUVAoKs8tMCOXWS5OVOjuGaVV5rsz0QgRJRCWxiKl8AyP1s82s0lmWCe9tPN70GEo+HaBmLu1lk34krcLxIaTamH+Jd2pzZo6iIsXkSrzzyvkkygEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494851; c=relaxed/simple;
	bh=W1hyEI6kOMOo8EHgS2PCjxcbqIuADogaI33wCiuwb9s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chl1dY9zJYLq4ommexpIOzUxpnREvvNYvMXJ+gYdUD2qZ9pRDyMqPi9zJIopzXXNRpiKzeT4w+2rJ72mNH5AXPbUX1i8JeGMT5HabHIQPs45jZW9UX+Fkwe/jgd4HAvDv9NcPROCIKvcgoIhq5ozBT6WzNQuYil4ORXFweG1iCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dtweb133; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dtweb133"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ev7gdfhd5fdgbih4uqu2gprziq.protonmail; t=1789494836; x=1789754036;
	bh=vyAXEBM6MVKBMtMkLJ4x+mOU4Va7jwOb58XaLGnaMPI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dtweb133ChTn59DTZCM3+j85MhJudihtH+4x6riZl1Wndpf3OY/a5D48OyCWQRl32
	 5d3+J8XxPXWwKWvv19DG1eWI8/Hmutsj7/yp6FmyqsAp4hePJCJLN2z5hWoQrDLSGE
	 n11UNbx14d/RY0tofBSBqfR5g2WBgZINP3OnZaXx6JFko3uxsWXZLI2sdV2ojrISJG
	 JjoQj6weieqI4+p3Ad+rrox0Yf9zdIfiNGBTYUqfeemwXqIGvCtx585Ah53HTG1KrX
	 etm5nC2MmFv7wLKTpBgbkI09JorU4Ang00gZxc/qq4i4vcTDB6PiCsNCDt/Ch/q/V3
	 oniOdPwE4BgYg==
Date: Tue, 15 Sep 2026 17:53:52 +0000
To: pbonzini@redhat.com, seanjc@google.com
From: David Ballesteros <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] KVM: Make kvm_range_has_memory_attributes() consistent about reservations
Message-ID: <20260915175335.138547-3-davimaba.v@proton.me>
In-Reply-To: <20260915175335.138547-1-davimaba.v@proton.me>
References: <20260915175335.138547-1-davimaba.v@proton.me>
Feedback-ID: 219068424:user:proton
X-Pm-Message-ID: b8f2b0ac85f47a753093554cc655603fcd4f6f35
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Make the !attrs fast path of kvm_range_has_memory_attributes() skip bare
reservations, so that all three of the function's query paths agree on
what an XA_ZERO_ENTRY means.

A reservation carries no attributes, and two of the three paths already
treat it as absent: the end =3D=3D start + 1 path reads it through
kvm_get_memory_attributes(), which maps it to NULL via xa_load(), and the
general loop skips it via xas_retry().  Only the !attrs fast path calls
xas_find() directly, which returns the reservation as a present entry, so
it reports a range that is in fact all-shared as not-all-shared.  Through
hugepage_has_attrs(), that marks a straddling hugepage mixed for a range
whose attributes are uniform.

This is a consistency fix rather than a fix for a reachable bug, and is
not tagged for stable.  Every caller of kvm_range_has_memory_attributes()
holds kvm->slots_lock -- the idempotency check in
kvm_vm_set_mem_attributes(), hugepage_has_attrs() from both
kvm_arch_post_set_memory_attributes() and
kvm_mmu_init_memslot_memory_attributes(), and __kvm_gmem_populate() --
and slots_lock excludes the only writer, so with patch 1/3 applied no
caller can observe a reservation.  The function should not have to depend
on that to answer consistently.

Note this patch depends on 1/3 and must not be applied without it.  Today a
clear over a range that holds only reservations does not take the
idempotency early-out in kvm_vm_set_mem_attributes(), because the fast path
reports the range as not-all-clear; the clear therefore proceeds and its
xa_store(NULL) loop erases the reservations as a side effect.  Teaching the
fast path to skip reservations makes that early-out fire and removes the
accidental cleanup, so the patch that stops the reservations from being
abandoned in the first place has to come first.

Found by an AI-assisted security audit.

Fixes: 5a475554db1e ("KVM: Introduce per-page memory attributes")
Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: David Ballesteros <davimaba.v@proton.me>
---
 virt/kvm/kvm_main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e7844..4e5e497 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2446,8 +2446,17 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm=
, gfn_t start, gfn_t end,
 =09=09return (kvm_get_memory_attributes(kvm, start) & mask) =3D=3D attrs;

 =09guard(rcu)();
-=09if (!attrs)
-=09=09return !xas_find(&xas, end - 1);
+=09if (!attrs) {
+=09=09/*
+=09=09 * Skip reservations: a bare XA_ZERO_ENTRY carries no
+=09=09 * attributes, but xas_find() returns it raw.
+=09=09 */
+=09=09do {
+=09=09=09entry =3D xas_find(&xas, end - 1);
+=09=09} while (xas_retry(&xas, entry));
+
+=09=09return !entry;
+=09}

 =09for (index =3D start; index < end; index++) {
 =09=09do {

