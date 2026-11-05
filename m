Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845757;
	b=yFQmJD4o/NMv2DU5ZQqa4JArQbAKhsMeyRdDg3rOtg3N1rHNQVUl/rDRx6LFq9TQnZRo
	 S/5hN40vWPln5wIMaFF/PxDqb6ogn/2MQcmgvSGdwnpxNCCc2vGxmYuESdAriitPdjRR+
	 MFRghiWcgjbTtinNwp7s07s0V1P6/b/Q/wqF60Hmj21FKVULQF7Yrg7ij4UNmZVO82WCq
	 fnIJdmemUb9RarcfldUIS53D9A75r8G4QyixY/vSC9q5fM6Tr7eiC4s3LV2BjFlYae/Of
	 ctxbrCQNY5xhHsBRnOhEOhrmHOG1IP5DBHeBjBrxRStVMfLx0dKHeC5mzpRFEUjlXUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845757;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8bQIuq0EDapgRaeQlX3rx0MA1mdiNGFeQSBeDJ6I4dI=;
	b=HQOaplw0BkbTC0qzUtAdPsXyh5z6DGOfCNbv4iOtqr3lukUWJKoUiQ5drHwCryY6TzWC
	 /FNo5wNhWO3/pvIs9k5Prbb8jwsyGtyzeFCH/lvtcKqYDVrkXwKDX6ll5DXicOhnXR4AW
	 bjnUTeFAsl7nnAYsBM9B0lat4VxQUnkut6CicY76nKYXUCi2rECVQDKkCWG14Z60PR5qo
	 dZsZ07Ti1ywnPq1LLYIKXIBylIJn/epxket7LURnUAp1zdjuVsO1Hs4fynKPkQde8TV1L
	 u4t90SOhdEuT/LAhpPob1Ws1Y2zJZANtsJUTiMxGyl6koznlvtSOOMiJiOmKqHJXzSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HnNB46O+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7AB606A31B;
	Thu,  5 Nov 2026 02:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HnNB46O+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D36F1F000C1;
	Thu,  5 Nov 2026 02:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793845756;
	bh=8bQIuq0EDapgRaeQlX3rx0MA1mdiNGFeQSBeDJ6I4dI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HnNB46O+pNHEoi370ZCHnnOjUx9o/bUJ55UMsIKbCExZmhAvyhhBBQE8/ihrH446o
	 +d6v0zrJcCL8d37Wrlk7/vrSLyMizfUc3oc75X5of5cfwzeM9pGG34RBS/Cpl5t0BV
	 +E1VC5hB29Y9YGmtDOaCDhlCe2LH8x/Ms1n9PmyVLytPlOKsShB+9xsMhfafWZ9CNs
	 uR+amI9HncEvdrE+BAQ7HGFkDnO3ZjibTo/UXGbnY7q+aLZcrZJnrOWAA2FKfrL7ve
	 +x3zy+oQKyJCCA9YeuXHQXALx4TzGTJVe5tgzmMjrXRTKYGha3exmWbsKIbzePK1CZ
	 QyrB1F6OLERwA==
Message-ID: <sashiko-outbox-198464@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/20] KVM: pfncache: Add guest-mode pinning
 (GUEST_USES_PFN successor)
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261105020104.2507083-11-dwmw2@infradead.org>
References: <20261105020104.2507083-1-dwmw2@infradead.org>
 <20261105020104.2507083-11-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:29:14 +0000
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
- [Medium] KVM: pfncache: gpc_kick_pinned_vcpu() re-posts vcpu_req on self-=
refresh
--

commit 9027e5fc5e4260b0089300dc0cf3173581bbcfed
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: pfncache: Add guest-mode pinning (GUEST_USES_PFN successor)

This commit adds guest-mode pinning support to gfn_to_pfn_cache so that
caches whose pfn is used directly from guest mode force the vCPU out of
guest mode and post a per-cache service request upon invalidation or
mutation.

> diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> index 1c98b7bdbf09c..5cb30525e577c 100644
> --- a/virt/kvm/pfncache.c
> +++ b/virt/kvm/pfncache.c
> @@ -25,7 +25,9 @@
>  void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long st=
art,
>  				       unsigned long end)
>  {
> +	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
>  	struct gfn_to_pfn_cache *gpc;
> +	bool evict_vcpus =3D false;
>  	bool cleared =3D false;
> =20
>  	spin_lock(&kvm->gpc_lock);
> @@ -127,10 +129,60 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *=
kvm, unsigned long start,
>  			 */
>  			if (old & (GPC_VALID | GPC_INVALIDATING))
>  				cleared =3D true;
> +
> +			/*
> +			 * If a vCPU has the pfn pinned for direct use from
> +			 * guest mode, it must be forced out of guest mode
> +			 * before the invalidation may complete. The pin bit
> +			 * was set with a cmpxchg only while GPC_VALID held,
> +			 * so this same read of 'old' cannot miss it. It is
> +			 * NOT cleared here: only the vCPU itself (on request
> +			 * service, before re-pinning) or a mutator's xchg
> +			 * (which inherits the kick duty) may clear it. A
> +			 * stale pin costs at most a spurious request bit:
> +			 * kvm_make_vcpus_request_mask() only IPIs and waits
> +			 * for targets actually in guest mode.
> +			 */
> +			if (old & GPC_GUEST_USING) {
> +				if (!evict_vcpus) {
> +					evict_vcpus =3D true;
> +					bitmap_zero(vcpu_bitmap, KVM_MAX_VCPUS);
> +				}
> +				__set_bit(gpc->vcpu->vcpu_idx, vcpu_bitmap);
> +				/*
> +				 * Set this cache's own service request (what
> +				 * the vCPU must do before re-entering); the
> +				 * force-out below is common to all of them.
> +				 */
> +				__kvm_make_request(gpc->vcpu_req, gpc->vcpu);
> +			}
>  		}
>  	}
>  	spin_unlock(&kvm->gpc_lock);

[ ... ]

> @@ -224,6 +276,107 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, un=
signed long len)
>  	return true;
>  }
> =20
> +/*
> + * A mutator's xchg of the state word to zero may have consumed a live
> + * GPC_GUEST_USING pin. Clearing that bit obliges the clearer to do what
> + * the invalidation walk would have done: post the cache's service
> + * request and force the vCPU out of guest mode, waiting until it has
> + * left, before mutating or tearing down what the guest may be using.
> + *
> + * The service request is posted unconditionally: consuming a pin means
> + * whatever physical address the vCPU had latched (e.g. into a hardware
> + * control structure) is stale, and only the request handler makes that
> + * good. That holds even when the pinning vCPU is the caller itself =E2=
=80=94
> + * a vCPU refreshing its own pinned cache may re-map at a different pfn,
> + * and without the request nothing would rewrite the stale address
> + * before the next guest entry. Only the waited force-out is skipped in
> + * that case: a vCPU running a refresh is by definition not in guest
> + * mode. (The vCPU's own unpin is the one silent path, in
> + * kvm_gpc_unpin_for_guest(), because unpinning asserts the address is
> + * no longer latched anywhere.)
> + */
> +static void gpc_kick_pinned_vcpu(struct gfn_to_pfn_cache *gpc, int old_s=
tate)
> +{
> +	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
> +
> +	if (!(old_state & GPC_GUEST_USING))
> +		return;
> +	if (WARN_ON_ONCE(!gpc->vcpu))
> +		return;
> +
> +	__kvm_make_request(gpc->vcpu_req, gpc->vcpu);
> +
> +	if (kvm_get_running_vcpu() =3D=3D gpc->vcpu)
> +		return;

[Severity: Medium]
When gfn_to_pfn_cache_invalidate_start() invalidates a pinned cache, it
clears GPC_VALID, sets GPC_INVALIDATING, leaves GPC_GUEST_USING set in
gpc->state, and posts gpc->vcpu_req to gpc->vcpu:

	do {
		new =3D old & ~(GPC_VALID | GPC_BECOMING_VALID);
		if (old & GPC_VALID)
			new |=3D GPC_INVALIDATING;
	} while (!atomic_try_cmpxchg(&gpc->state, &old, new));

When gpc->vcpu subsequently services gpc->vcpu_req on the next guest entry
attempt, kvm_check_request() clears gpc->vcpu_req and the request handler
calls kvm_gpc_refresh() (or kvm_gpc_activate()) before re-pinning with
kvm_gpc_pin_for_guest(), as described in kvm_gpc_init_for_vcpu().

Because GPC_VALID is clear, __kvm_gpc_refresh() does not take the fast path
and instead consumes the leftover GPC_GUEST_USING bit via atomic_xchg():

	old_state =3D atomic_xchg(&gpc->state, GPC_INVALIDATING);
	gpc_kick_pinned_vcpu(gpc, old_state);

Won't gpc_kick_pinned_vcpu() see GPC_GUEST_USING in old_state and
unconditionally re-post gpc->vcpu_req to gpc->vcpu right in the middle of
handling that very request, causing the subsequent guest entry to abort and
run the request handler a second time (or loop if the handler does not hit
the __kvm_gpc_refresh() fast path on the next pass)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105020104.2507=
083-1-dwmw2@infradead.org?part=3D10
