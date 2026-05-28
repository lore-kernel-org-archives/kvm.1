Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B513EFFB2
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971968; cv=none; b=WPhppkjfBFHkq+KGVCf8+2NyEmsS65dzbBclFbpuwY4OwfMOM1DZMx388lrexU0ebB5tvKVD4yrWzf2mfeI5N3b4akyPdeP+v0Rlp4M3CSPCYQJsA8uXkF1NLr1pdniRof96LDBl7FGcXFvHOq2ZLoQEzJxZ9omuDPoSQ/OEOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971968; c=relaxed/simple;
	bh=8n9hbgF4uWSdPTcy7ktSobpKut27lgi1U96fKATNLL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VUw5MAFlJrcekMOTVrInm+1LUufShoXp7Y1Ib9GgHwVfRXWV2qciyhh0I2A2iL0/uC1mK8lvJuZ2/oXPsRo9c7Pzevhe+FaX1GDkSATqJvnbPV2dicmDewUdl869SbAa5PBN7Eu4LaGlERDlz82bS4N34VnjXE2krKQaKXfF23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3gdiRFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3gdiRFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61351F00A3A;
	Thu, 28 May 2026 12:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779971966;
	bh=mwJ42WnV5Q5mrO9Afgd2XxWe8tj8wzF6kc/jYFfd5cs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K3gdiRFXeKMO61pcfmx3eAcJijS6h+851Si35saB4dDozUVa0YP9Tx7UlD6N6G59d
	 FCxCvA50s+/ii/mrpswxzlMGzs5Ncbinj5c1dN6zb40p7fVH/J642NbklT+6OEfezX
	 hG95hWiI3SRSG9ip4bt3nQyc/959EPy0v08+tgQM9t29OAzTHHc9PjivlDy/ufjEc3
	 nl3VjUoC20gCH3l1wUhljRKLonb7Ap/Au3VmfQjjVJHqXY9HZfWtSZ4dGBq6daX1CR
	 iLUxH/2B1ZmZS8bNAFfJH4QVjj3jKs/lQPQsPX+RiAN8WxhqybmP/hiQYwULqeXJ3F
	 Xv1qqACtoI9Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/7] KVM: s390: Fix _gmap_crstep_xchg_atomic()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528114727.142178-2-imbrenda@linux.ibm.com>
References: <20260528114727.142178-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 12:39:25 +0000
Message-Id: <20260528123926.A61351F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Returning false without modifying memory breaks the compare-and-ex=
change contract, causing an infinite loop in retry loops.
- [High] Returning false on unshadow events bypasses the atomic exchange an=
d triggers a KVM_BUG_ON during page unmapping, crashing the VM.
--

commit 78e417232a11beab5e106b0965a752bf2abb9761
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix _gmap_crstep_xchg_atomic()

This commit modifies _gmap_crstep_xchg_atomic() to return false and skip
the operation if an unshadow event is triggered. This prevents shadow
crstes from being installed without the vsie_notif bit.

> diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
> index 742e42a317445..122ed85663149 100644
> --- a/arch/s390/kvm/gmap.h
> +++ b/arch/s390/kvm/gmap.h
> @@ -273,11 +273,11 @@ static inline bool __must_check _gmap_crstep_xchg_a=
tomic(struct gmap *gmap, unio
>  		gmap_unmap_prefix(gmap, gfn, gfn + align);
>  	}
>  	if (crste_leaf(oldcrste) && crste_needs_unshadow(oldcrste, newcrste)) {
> -		newcrste.s.fc1.vsie_notif =3D 0;
>  		if (needs_lock)
>  			gmap_handle_vsie_unshadow_event(gmap, gfn);
>  		else
>  			_gmap_handle_vsie_unshadow_event(gmap, gfn);
> +		return false;

[Severity: High]
Does returning false here break the compare-and-exchange contract?

Functions like _gmap_handle_minor_crste_fault() and gmap_sync_dirty_log()
use a retry loop to atomically update page tables:

    do {
        old =3D READ_ONCE(*table);
        ...
    } while (!gmap_crstep_xchg_atomic(...));

By unconditionally returning false after handling an unshadow event, the
actual dat_crstep_xchg_atomic() memory update is bypassed and the
vsie_notif bit is never cleared from the CRSTE in memory.=20

Could this cause the retry loop to read the exact same unmodified CRSTE,
trigger the unshadow path again, receive false again, and spin indefinitely
without making forward progress? This might allow a guest to trigger a
host CPU soft lockup.

[Severity: High]
Can returning false on unshadow events also trigger a KVM_BUG_ON() during
page unmapping?

In _gmap_unmap_crste(), the code attempts to unmap a page by replacing its
CRSTE with an empty entry _CRSTE_EMPTY(old.h.tt) which sets the invalid
bit (h.i =3D 1).=20

If the page being unmapped is shadowed (old.s.fc1.vsie_notif =3D=3D 1),
crste_needs_unshadow() evaluates to true because newcrste.h.i is 1.

Would the modified _gmap_crstep_xchg_atomic() then unconditionally return
false instead of performing the update, causing the enclosing
KVM_BUG_ON(!gmap_crstep_xchg_atomic(...)) assertion to fail and crash
the VM during a valid unmap operation?

>  	}
>  	if (!oldcrste.s.fc1.d && newcrste.s.fc1.d && !newcrste.s.fc1.s)
>  		SetPageDirty(phys_to_page(crste_origin_large(newcrste)));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528114727.1421=
78-1-imbrenda@linux.ibm.com?part=3D1
