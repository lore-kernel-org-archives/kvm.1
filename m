Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428382;
	b=OdOT5zQcgYECaO2EZc3yjGPTfJVE3yPGQWJG3KSJCXDlVuf8AbVdLmH9jHSv2EJ966JY
	 3gAXB8v694/San9Biq9qOIHxLxWTToOsJDFIoYxxsJ+ZnKnl/JdsKKs8cy1d/mYqagVQt
	 i58ABwjpoJGE5xqjTM7NDmMAXmP7WpnTMHokrVX3PfwSqzu6yq7fzphDaj/I23h2hEQ6v
	 zVMHakJuUKkcxqRYExWlmre6R4nF598XxN13fUEOdvyjH2ISS3JMEtboYFafk/96lmYPY
	 A6NbM1f9IX/q2/f7WiwMTXu30DDzNL55YzerYzHVKuSMsFtqAW8mKe5huk+W9lOOhTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428382;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PpUm1Z1e638n0+K7OgzaItxVh9BcbeBTISpg9/I5NAo=;
	b=yIQVBIwPDv0Bmh7tqry3+//VFhMlbnOeNFFqS4yK2WZqAPZLreHIa/Z2YRSfRkSKNy6g
	 jQUkc+6UwPwwAt69ZPs3kpX3apIGqqT++bx3vNYLGf48S9FF6+U8WfqVGfzMgyJHXyGfF
	 pYS7715L8D0v2snzejxe4BtNZsh+HS8VkKtW0BeU2WrazF0XT0qjDUpXpdfQSA1n2ymUX
	 mMmKI4psfdWGB9Neftfrp3qAFMg9NRAhqciF7ppRM9oy4irTbkOejDJXqxr6g6/vyrcF5
	 mvEWOnjVfro4QkFLlfvVlZMtafSSJ7y3AmRexPEXB2DFTUCmos6jbHvUzI+P1Ga9VXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=da+OgQyQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAAD606A32D
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=da+OgQyQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA621F000C4;
	Mon, 19 Oct 2026 16:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428382;
	bh=PpUm1Z1e638n0+K7OgzaItxVh9BcbeBTISpg9/I5NAo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=da+OgQyQBZ82HuIeVFOjrN9+ruCi0KSbvGa3RAlqEfdg5ZlxKuvwnsOhGN8kgYdVA
	 /xOVJ9xKFDsGqej/oHCFm3YJjsZ1UwsKY6mqtTbDVgDh9yLEHiuEXCDMCwan+pbwmk
	 tIsbVFEYCMTMl5OF8a1tLRxxcKHQNp/88NXrUN/ku2YRghVN3JXm0Ir8dF9KDVVusC
	 V9p4xW0sbeMuanH5xP1pxfrebL6+Y9bsDjDez1GYFFQLofC+M6kFFmg9ODJSOzd0Gl
	 KSfvDOoKj4qYuuYtkOxiQA0xweRyTujuzZDTGRH1eqRm2HDurX/rH0fMFduULNjyNg
	 ssi6fRFo08LIQ==
Message-ID: <sashiko-outbox-177931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/12] KVM: selftests: Fix unreachable timer recovery
 in xen_shinfo_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261019162445.37219-13-dwmw2@infradead.org>
References: <20261019162445.37219-1-dwmw2@infradead.org>
 <20261019162445.37219-13-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:46:21 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: selftests: wrong fix in guest_code() for juggle_shinfo_stat=
e() GFN 0 bug
--

commit 36db2d77eb09cc5d7b05a58f930d6724ba060038
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: selftests: Fix unreachable timer recovery in xen_shinfo_test

This commit adds a 10ms timeout to the SCHEDOP_poll hypercall in the
TEST_LOCKING_POLL_RACE phase of xen_shinfo_test so the guest does not hang =
if
the timer event is dropped while blocked in the poll.

> diff --git a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c b/tools/te=
sting/selftests/kvm/x86/xen_shinfo_test.c
> index 3b11d0ee253f5..729c0ba9ab4e8 100644
> --- a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
> +++ b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
> @@ -350,7 +350,14 @@ static void guest_code(void)
>  	p =3D (struct sched_poll) {
>  		.ports =3D ports,
>  		.nr_ports =3D 1,
> -		.timeout =3D 0
> +		/*
> +		 * The poll must have a timeout: if the timer event is dropped
> +		 * while we are already blocked in the poll, nothing else will
> +		 * ever wake us, and the recovery protocol below could never
> +		 * run. (As with TEST_POLL_TIMEOUT above, KVM treats the
> +		 * timeout as relative.)
> +		 */
> +		.timeout =3D 10000000,
>  	};
> =20
>  wait_for_timer:

[Severity: Medium]
Is SCHEDOP_poll in TEST_LOCKING_POLL_RACE actually supposed to block waiting
for the timer?

In main(), the host sets bit 0 of evtchn_pending[0] before arming the timer=
 on
EVTCHN_TIMER:

tools/testing/selftests/kvm/x86/xen_shinfo_test.c:main() {
    ...
    case TEST_LOCKING_POLL_RACE:
        shinfo->evtchn_pending[0] =3D 1;

        evtchn_irq_expected =3D true;
        tmr.u.timer.expires_ns =3D rs->state_entry_time +
                                 SHINFO_RACE_TIMEOUT * 1000000000ULL;
        vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &tmr);
        break;
}

And in guest_code(), the guest polls on port 0 (ports[0] =3D 0), not on
EVTCHN_TIMER. In wait_pending_event(), ret defaults to true:

arch/x86/kvm/xen.c:wait_pending_event() {
    ...
    bool ret =3D true;
    int idx, i;

    idx =3D srcu_read_lock(&kvm->srcu);
    read_lock_irqsave(&gpc->lock, flags);
    if (!kvm_gpc_check(gpc, PAGE_SIZE))
        goto out_rcu;
    ...
}

When shinfo_cache is deactivated, kvm_gpc_check() returns false and
wait_pending_event() returns true immediately. When shinfo_cache is active =
on
shinfo, bit 0 of evtchn_pending[0] is set, so test_bit() also returns true
without halting the vCPU. Furthermore, if the timer expires while shinfo_ca=
che
is deactivated, xen_timer_callback() sees -EWOULDBLOCK from
kvm_xen_set_evtchn_fast() and unconditionally raises KVM_REQ_UNBLOCK and ca=
lls
kvm_vcpu_kick().

Instead, isn't the vCPU blocking in kvm_vcpu_halt() because of a bug in
juggle_shinfo_state()?

tools/testing/selftests/kvm/x86/xen_shinfo_test.c:juggle_shinfo_state() {
    ...
    struct kvm_xen_hvm_attr cache_deactivate_hva =3D {
        .type =3D KVM_XEN_ATTR_TYPE_SHARED_INFO,
        .u.shared_info.hva =3D 0
    };
    ...
}

Because cache_deactivate_hva uses KVM_XEN_ATTR_TYPE_SHARED_INFO instead of
KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA with hva =3D 0 (which unions with gfn =3D=
 0),
kvm_xen_hvm_set_attr() activates shinfo_cache on guest GFN 0 rather than
deactivating it (since KVM_XEN_ATTR_TYPE_SHARED_INFO checks for
KVM_XEN_INVALID_GFN). At guest GFN 0, evtchn_pending[0] bit 0 is 0, so a
concurrent SCHEDOP_poll sees the port as not pending and blocks in
kvm_vcpu_halt().

Adding a 10ms timeout here causes the guest to sleep in kvm_vcpu_halt() for
10ms whenever SCHEDOP_poll coincides with cache_deactivate_hva, rather than
spinning in the tight hypercall loop to stress gpc->lock contention, while
leaving KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA deactivation untested and continu=
ing
to overwrite guest GFN 0 with wallclock data.

Should this instead fix cache_deactivate_hva.type to
KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA in juggle_shinfo_state(), with:

  Fixes: 9397b5334af1 ("KVM: selftests: map Xen's shared_info page using HV=
A rather than GFN")

?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019162445.3721=
9-1-dwmw2@infradead.org?part=3D12
