Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761933C1083
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216622; cv=none; b=drbiyeuKSN2NerxFGopeOYemlDaIfXz7iq8VVG/MyRR1x08tiyb/MEgpmRfB5vbR8bqIs/Xerbc3e8Ezh6XYM9mkmbs5FmEfjcrvpxeSRWbyB6W08BMIwIFLoEkT83sX1ydxC5OD9SWt5JlOayHJKFkc2VZ9n0CYck7kAo0gMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216622; c=relaxed/simple;
	bh=wV2giUzxPa7nWn9etR5tIweiz4sk5QjM1HkoKEN6Jd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HECdMMtVU8rez+nbpoR2XpazJNpBQaNTr+w/fpKQV0U5rGMDcn35NMY1mC16vAPw8fSaq54rnJW2JMHTftLW3oDtNHkJd3IESGBZxHDQLjhOpiyOBB8p9AiX3RC6+4glc0krNnddT1C/liVMh3szAYksTiNmHkXglLd6Xqk4l04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFswKXB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFswKXB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0431F00A3D;
	Mon, 31 Aug 2026 22:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788216620;
	bh=ixi5dtXidPhcO1Us0h2W1LdmWZl/UiJcymidYY6k67Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FFswKXB2lzMalzd0wHX9MadzS6tFuWqvVU43b/pnbdlNuUIRIds8QBqcDc/csySPe
	 0clBPAkbl9SVIqCMLCxShsst7uyjsXWopVeQbzqQHHA2cTX0lYv+yJVzOL8fF5RQNQ
	 T/ETP4irxFZ+dtPcPhICvr166xnheBAp6V9aFQCiJX8KNvXtcU2s6GguDrR/BLxuZU
	 HJzoaWEc3VO9I/q7JjLhF8Y+shg/IEK2lZJwDvDQYoQf2AM/Fsk5/sxAKjfeS7E0XE
	 5uO9MrxNmQfFmtUb+Xg43nR8y4nVZzxcSeyppUjhjUc3C67SrLseqEuhxned0g6+au
	 m+ms1rIWZDnig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/13] KVM: x86/xen: Use 32-bit locked bts for
 vcpu_info evtchn_pending_sel
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260831213632.81023-8-dwmw2@infradead.org>
References: <20260831213632.81023-1-dwmw2@infradead.org>
 <20260831213632.81023-8-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:50:19 +0000
Message-Id: <20260831225020.0F0431F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing dirty page logging for event channel injection breaks live=
 migration.
--

commit 71bb4c7ed046d44bbf5b561e00bbc1a82294213c
Author: David Woodhouse <dwmw@amazon.co.uk>
Subject: KVM: x86/xen: Use 32-bit locked bts for vcpu_info evtchn_pending_s=
el

This commit replaces a 64-bit locked test-and-set with a 32-bit equivalent
for updating evtchn_pending_sel. This prevents a split-lock exception when
accessing a guest-controlled structure that is only 32-bit aligned.

Closes: https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel=
.org

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
[ ... ]
> @@ -1879,19 +1888,29 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn=
 *xe, struct kvm *kvm)
>  			goto out_rcu;
>  		}
> =20
> -		if (has_64bit_shinfo) {
[ ... ]
> -		} else {
[ ... ]
> -		}
> +		/*
> +		 * Explicitly use a 32-bit btsl instead of test_and_set_bit(),
> +		 * which would use btsq on x86-64. The vcpu_info is guest-
> +		 * controlled and only required to be 32-bit aligned, so a
> +		 * 64-bit access could generate a split-lock #AC.
> +		 *
> +		 * Note, this does not apply to the test_and_set_bit() on
> +		 * pending_bits above: that is in the per-VM shared_info, which
> +		 * is page aligned, so the access is guaranteed to be 64-bit
> +		 * aligned.
> +		 */
> +		old =3D GEN_BINARY_RMWcc(LOCK_PREFIX "btsl",
> +				       *(u32 *)(gpc->khva + vi_pending_sel_ofs),
> +				       c, "Ir", port_word_bit);
> +		if (!old) {
> +			struct vcpu_info *vi =3D gpc->khva;
> +
> +			/* No need for compat handling */
> +			BUILD_BUG_ON(offsetof(struct vcpu_info, evtchn_upcall_pending) !=3D
> +				     offsetof(struct compat_vcpu_info, evtchn_upcall_pending));
> +
> +			WRITE_ONCE(vi->evtchn_upcall_pending, 1);
> +			kick_vcpu =3D true;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but is it possible that modifying
the guest memory here without dirtying the page breaks live migration?

Looking at kvm_xen_set_evtchn_fast(), it modifies both the shared_info
page (via test_and_set_bit on pending_bits earlier in the function) and
the vcpu_info page (via the new btsl inline asm on gpc->khva here).

Because gpc->khva uses the cached kernel address and bypasses guest page
tables, hardware A/D bits are not set.

If we don't call kvm_gpc_mark_dirty_in_slot(gpc) after modifying these
pages, KVM's dirty page tracking mechanism won't record the changes.

During the pre-copy phase of live migration, could this cause userspace to
skip re-transmitting the page, resulting in the destination VM resuming
with an outdated copy of the shared_info and vcpu_info pages where the
pending interrupt bits are missing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831213632.8102=
3-1-dwmw2@infradead.org?part=3D7
