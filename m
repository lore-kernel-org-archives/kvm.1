Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AA1B87C0
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252356; cv=none; b=NUTHysDcEBPn5yP9UaGrnus/bUFdxkO/TpS+G2+nBmk4rpP3D7PQ+5/S8zlEogOgRy4pzfI6NqlI6pr3jKX2hUczgmnuw4H1NUhZJbSnT5bcY/FIeGzqfYXqCOd8n4mfszTFiUn72yOgX2K57f8cAaD2Fmuvm0pG681YCVOdfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252356; c=relaxed/simple;
	bh=dXgeHiBRDKBFvph+v48ujtsHB60MaMvrgu8CakQ9OhQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MdxkevXHF1Eomg92nKEqsrUozQ+IFKe320fnYavxv7ZRGuQd8TZg3sCh42+QbDn/zELDDOJST5PU/tDKcNWymjRN9VMo6d3IfRmHd74Bi1rtKbQ9v4Ky7gz5EYt4LPnvmL/kUZSEObTBZANlQvQZhxmCyCcn3l5Qa/ghfM1XFq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQM7RIUl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQM7RIUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C06B1F000E9;
	Tue, 28 Jul 2026 15:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252354;
	bh=HA/VSEn+c/xlLlWW92jJPJNdXueeculkpcYACLmA/r8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JQM7RIUlBrASyfz0wtamgnphyDXvTbKzwdhe948Vhk+A9nJPxaymt1G4yzcnz6/Sq
	 GHnMyNOfUI92EljiMHd1WY1UDi2d4ZzpMmjcTWT0u8RyPHtCpsLfHFTQq/Ep3DabBR
	 BcQwa3Ty3glX1u7ufhDwSjLtVh0B40vf4N0QxMGvHcfXDyozJ37Vap7j2RPMzbKNUI
	 TFYkL8VUy2uLtp6kyvaLiF7a88ZZQ8ISdxxQhAEyq7Ax5fwUdcMNJwt9cQjEJlUOMz
	 KnczTgc5e1oKXHKZs6fPnx3S+tU7NcUmCULb3ZH/CEB7DLZG63/o0ZlonEZX+7keek
	 XgTG7GaNvngaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 27/36] KVM: x86: Remove pvclock_gtod_data and private
 timekeeping code
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-28-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-28-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:25:53 +0000
Message-Id: <20260728152554.6C06B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] KVM references non-existent timekeeping functions and struct fields.
--

--- Patch [27]: [PATCH v7 27/36] KVM: x86: Remove pvclock_gtod_data and pri=
vate timekeeping code ---
commit f5e01c2dbc04eb5669e9c80660aff5b3897195fa
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Remove pvclock_gtod_data and private timekeeping code
   =20
Remove the now-unused KVM-private timekeeping infrastructure:
   =20
 - struct pvclock_clock and struct pvclock_gtod_data
 - update_pvclock_gtod() and its seqcount-protected state copy
 - read_tsc() (KVM's private TSC reader with cycle_last clamping)
 - vgettsc() (KVM's private clocksource interpolation)
 - do_kvmclock_base(), do_monotonic(), do_realtime()

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 3f660bdea8a28..26d2f24aceec5 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -1455,128 +1403,6 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u=
64 *user_value)
> =20
>  #ifdef CONFIG_X86_64
> =20
> -static u64 read_tsc(void)
> -{
[ ... ]
> -static int do_realtime(struct timespec64 *ts, u64 *tsc_timestamp)
> -{
[ ... ]
> -	return mode;
> -}
> -
>  /*
>   * Calculates the kvmclock_base_ns (CLOCK_MONOTONIC_RAW + boot time) and
>   * reports the TSC value from which it do so. Returns true if host is

[Severity: Low]
Are these timekeeping functions and struct fields defined elsewhere?

With the removal of the private timekeeping code, the remaining functions
here seem to rely on undefined interfaces, which could cause a build failur=
e.

Specifically, kvm_get_time_and_clockread() calls ktime_get_snapshot_id(),
which does not appear to be defined in the tree:

arch/x86/kvm/x86.c:kvm_get_time_and_clockread() {
    ...
    struct system_time_snapshot snap =3D {};

    ktime_get_snapshot_id(CLOCK_MONOTONIC_RAW, &snap);
    ...
    *kernel_ns =3D ktime_to_ns(ktime_mono_to_any(snap.systime, TK_OFFS_BOOT=
));
    ...
}

Additionally, kvm_snapshot_has_tsc() accesses several fields in
struct system_time_snapshot that are not defined, such as valid, hw_csid,
hw_cycles, and systime:

arch/x86/kvm/x86.c:kvm_snapshot_has_tsc() {
    ...
    if (!snap->valid)
        return false;

    if (snap->cs_id =3D=3D CSID_X86_TSC) {
        *tsc_timestamp =3D snap->cycles;
        return true;
    }

    if (snap->hw_csid =3D=3D CSID_X86_TSC && snap->hw_cycles) {
        *tsc_timestamp =3D snap->hw_cycles;
        return true;
    }
    ...
}

Could this lead to compilation errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D27
