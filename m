Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC36455176
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789159467; cv=none; b=f45jCBGwrH6ltrYCd7W5gGX+UWskHidFaY2rUoBPvfJFTzV9ulPcrbH4sdVnd+gWTR6ZR93g8sOCiGpf7ahg709tjT+LD+nzSlM6KDbPNBqR1vHRbC5Jpbnnhkv5viUH9o57zfJrzvJeq6l/6SDC694ipt6pEt1cslEBLRUZL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789159467; c=relaxed/simple;
	bh=ih4SzhGDnwMOyTFmhnEXXLIIm/WQx0f9j6sHGjq4Ans=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bDmvZsjnfkvuD5ckMq068htpEW+ApJM9d7b0IijDIjX9kJKfnTZZjPh2r8B/hDfk0YN9h59JtM64N9+zWdvVP3qkla9GWLKIurLzDedjBioLNGzKXuCHHfzI3+btlFQ52wz9yG539mSde2fD3Ks0jYrrnSwrdL691tZOSJT7xyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX5NbFtT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX5NbFtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213601F00893;
	Fri, 11 Sep 2026 20:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789159466;
	bh=J/ara+qxD1Xv0fMYatexqf5XKaIbL7bzgIQn0DwN2QA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MX5NbFtT5/du4GMqWiQMreu+GjqS+WY6lIWplIRRzqov8kruJOEgQ9OhmtPHOhsX3
	 Si7s3chkNpGdhZ4/LSohCe+3qDWmyJod7Jhr6BhtZlBpAnYCR8nMtE4n51R0Dv5Tyz
	 Ubxga0a/ggxbT0VIwXdqKw4ZmMikAfuuLBBYyzc+nZCwHrfCNxxeo66oRdMwGQiRQC
	 hYN3A5u3eNuXEjox5xJclqwDvoJYxNupObXzkXdj8TEmt3O7f8YLhbnqN9UO75LU0/
	 g9ShgGx9fPLbAtfJWdV/E3ocNQHgkwVHx3Nm1EVsYCligXoHx83uMcclvt4T/Rn9Y1
	 7QfJ9JOFkYtSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: Account mem_attr_array nodes to the
 caller's memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Ballesteros" <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911203238.30088-3-davimaba.v@proton.me>
References: <20260911184819.101123-1-davimaba.v@proton.me>
 <20260911203238.30088-3-davimaba.v@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 20:44:25 +0000
Message-Id: <20260911204426.213601F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional cond_resched() and blocking MMU invalidations are ca=
lled inside an RCU read-side critical section in KVM memory attribute paths.
--

commit c6abdd494ec28371324dab717f8c1bf7e27a654d
Author: David Ballesteros <davimaba.v@proton.me>

KVM: Account mem_attr_array nodes to the caller's memcg

This patch sets XA_FLAGS_ACCOUNT for mem_attr_array so that nodes allocated
by xas_alloc() with GFP_NOWAIT are properly charged to the caller's memcg.
This ensures per-tenant memory limits are respected and bounds the growth
of host memory allocations.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index f623c5f07344e..14ca73aedbaf9 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1127,7 +1127,7 @@ static struct kvm *kvm_create_vm(unsigned long type=
, const char *fdname)
>  	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
>  	xa_init(&kvm->vcpu_array);
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> -	xa_init(&kvm->mem_attr_array);
> +	xa_init_flags(&kvm->mem_attr_array, XA_FLAGS_ACCOUNT);
>  	kvm->mem_attr_gfn_count =3D 0;
>  #endif

While reviewing this, I noticed some pre-existing regressions in the same f=
ile
related to the memory attribute paths:

virt/kvm/kvm_main.c:kvm_count_mem_attr_entries() {
    ...
    guard(rcu)();
    xas_for_each(&xas, entry, ULONG_MAX) {
        if (xa_is_retry(entry)) {
            xas_pause(&xas);
            continue;
        }
        if (entry)
            count++;

        if (need_resched()) {
            xas_pause(&xas);
            cond_resched();

[Severity: High]
This isn't a bug introduced by this patch, but does this call cond_resched()
inside the block-scoped RCU read-side section established by guard(rcu)()?

        }
    }
    ...
}


virt/kvm/kvm_main.c:kvm_vm_set_mem_attributes() {
    ...
    if (!attributes) {
        XA_STATE(xas, &kvm->mem_attr_array, start);

        kvm_handle_gfn_range(kvm, &pre_set_range);

        guard(rcu)();
        xas_for_each(&xas, entry, end - 1) {
            if (xa_is_retry(entry)) {
                xas_pause(&xas);
                continue;
            }
            xa_erase(&kvm->mem_attr_array, xas.xa_index);
            freed++;
            cond_resched();

[Severity: High]
This is a pre-existing issue, but would this unconditional cond_resched()
also execute within the RCU read lock scope established by guard(rcu)()?

        }

        kvm_handle_gfn_range(kvm, &post_set_range);

[Severity: High]
This is a pre-existing issue, but is a potentially blocking operation execu=
ted
via kvm_handle_gfn_range() (where may_block =3D true) before the block-scop=
ed
guard(rcu)() ends?

        /* Exactly @freed entries left the array; no resync needed. */
        ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911184819.1011=
23-1-davimaba.v@proton.me?part=3D2
