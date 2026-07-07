Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CF72E7360
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429441; cv=none; b=biPrjDM8QcD73+d6Xf69cFpewpZ98OB0TS9B1y04rLbH2d7c4bY30xLJ5pEtPOMMSe7Gzk7KufwSs3Sl5DHLSDnvw0aXz9yYdk5Vr8bfz65V8dHZRDyDrTMSYZyU4AutrJoH9HWi1Rid04p9nW0/3bg9kcUeHRlfT2acgY+I5Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429441; c=relaxed/simple;
	bh=EYo4B5IptUIoFdMm5vnUrB7f2/9mFaqiO50i5QPEnM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RgB7baRgX1XBZ0d/Mu0n5pDTi7fSgbd7iAQ7oNwu0X9hmXhXdR53rtEpJ7TNEkjcy4x/Vvko+o8uyMBLbnucEdD45LMXg3kDq+kBAHvQM19AUo14cDf8GHFCf7T/uKqlr4bEH4LV+ajsv9XFQRyLKldVr4E1sM5Fh7sZXizteJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR0utZ9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR0utZ9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEB91F00A3A;
	Tue,  7 Jul 2026 13:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783429439;
	bh=F/K0ZrRdlGB3eNGQmdQZB69yzSSm2DwxJtFaOD+q6w0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QR0utZ9qA3qaRVNt0Pn4WuT9LAPrBxFoVddtBnzVC3+wDUj07HO7EXkAD9DJuXT4m
	 Fp0HtciDitfvy/iQqUf5U9i5gLfO8oJY0D27tzrVDOKfjnU01ou15RvUQv2v77fZtz
	 c0pFbceHiOYXCQTY1e6qBTSq/78LKLoeW7KRCpC1zDIZhHutNhXIyv+TDyysGjXgUQ
	 jRYPk33X3VCDphd05B011DzZjUsX/+/L3eUUGt1OWZ7y+ohwHtVjKHYqVwKU1N01YF
	 zJc7KA0zu+yJaBTliZsxyEevt564aC1gIsLZJz3R4NkGY3Cwf3OLv247q5G4bnQJLA
	 PoJVauupjiQvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] RISC-V: KVM: Introduce
 make_xfence_request_nodata for FENCE.I requests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707125034.416521-2-wang.yechao255@zte.com.cn>
References: <20260707125034.416521-1-wang.yechao255@zte.com.cn>
 <20260707125034.416521-2-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:03:58 +0000
Message-Id: <20260707130359.6FEB91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Stranded `hfence_queue` entries cause permanent fallback to global=
 TLB flushes.
--

--- Patch [1]: [PATCH v2 1/2] RISC-V: KVM: Introduce make_xfence_request_no=
data for FENCE.I requests ---
commit c3b95cdce701530ec81cfa3b256ee7e3d2dd263d
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Introduce make_xfence_request_nodata for FENCE.I requests

FENCE.I does not need hfence data, but it currently goes through the
generic make_xfence_request() path with NULL data, incurring unnecessary
per-VCPU checks. Split out a separate make_xfence_request_nodata() function
to handle FENCE.I directly, and move the data validity check to the top of
the generic function to avoid redundant checks.

> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index 993b25ea94d67..5a9c75e458013 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c

[ ... ]

> @@ -347,9 +373,6 @@ static void make_xfence_request(struct kvm *kvm,
> =20
>  		bitmap_set(vcpu_mask, i, 1);
> =20
> -		if (!data || !data->type)
> -			continue;
> -
>  		/*
>  		 * Enqueue hfence data to VCPU hfence queue. If we don't
>  		 * have space in the VCPU hfence queue then fallback to

[Severity: High]
This isn't a bug introduced by this patch, but can this loop in
make_xfence_request() cause a performance regression by stranding enqueued
items if a later enqueue fails?

If any vCPU's queue is full, vcpu_hfence_enqueue() fails, and the loop
overrides actual_req to fallback_req (e.g., KVM_REQ_TLB_FLUSH) for the enti=
re
batch:

        if (!vcpu_hfence_enqueue(vcpu, data))
                actual_req =3D fallback_req;
}

kvm_make_vcpus_request_mask(kvm, actual_req, vcpu_mask);

The vCPUs that successfully enqueued the data earlier in the loop will rece=
ive
KVM_REQ_TLB_FLUSH instead of KVM_REQ_HFENCE. Since they process
KVM_REQ_TLB_FLUSH without dequeueing from their hfence_queue (which only
happens when processing KVM_REQ_HFENCE via kvm_riscv_hfence_process()), the=
se
successfully enqueued items become permanently stranded.

As this repeats, the queues of healthy vCPUs will eventually fill up. Once a
queue is fully saturated with stranded items, it will permanently fail all
future enqueues, forcing all subsequent fine-grained requests to downgrade =
to
global TLB flushes for the lifetime of the VM.

>  		 * a more conservative hfence request.
>  		 */
> @@ -365,8 +388,7 @@ static void make_xfence_request(struct kvm *kvm,
>  void kvm_riscv_fence_i(struct kvm *kvm,
>  		       unsigned long hbase, unsigned long hmask)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707125034.4165=
21-1-wang.yechao255@zte.com.cn?part=3D1
