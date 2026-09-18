Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB430D3F1
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720446; cv=none; b=GT2a+H7opea7GewWUGyaybgyzWJRyFGwsBpeF9FbqIRjRbpfYumykj11pozSTUaDk2kvUVXsyV4hIBs2GjqvPpQNaGNjdIIG+5Fx2aWy7dyjY1J2ifAuMdvlzS7LRcwisgDWE7a4yGYMCHQfK9jz4u6Ch3L7yhBI45bTgl5lu7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720446; c=relaxed/simple;
	bh=jsepeWXGpfJGXmxjnpKApdmuA6MLzODlt763rQ4oCIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sSilMWhZlnVPeXHXzQhEZcalJZ9/fnl8/WMyoYAqm0qL2ND0EfeTUsqQmBcXkPUnLlQ+CHjUbadjBJfhCYGZgVCLf4sIUIzWXSORBjF3iPB0vMEhJhxIZhswgZeWksZwKispdC1krZ5fSgoBRwvIeyXVLbwbBstCEL+0wvMbHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYEogAcW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYEogAcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884F01F000FF;
	Fri, 18 Sep 2026 08:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720444;
	bh=oPVqxRodynwDcYovS9uuJqn5fdweiuvCT+LOCfkIrNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QYEogAcWB8FAoZTT/g2EIjxGaeNpAmaxWpBtbLBmZcaSwgBHc+QTcf3FOYFBxcIkv
	 1uIkYkiYDHwDeBwWx2GfqJKBbku4Kt9l0EK6W53lU5FuXOV0X0iI3ED3taUQky7L7Y
	 O1OUNkAWGKevBQa+YZJ6w1oE6u5t/PgvoUMgqglZNyfG6ijligiUeepq5jvg0SqWTx
	 dFimQd1nFWSlUBSLwNQipgzBYHxioYm2QYRMktvhmRWReYprvyn46qt7yzkyNZA17V
	 LQWthKfki39we0CIhlCSxV9yIvUucSvy80Vn9oSNOIfQGZ+JqtxrdkUypuxBwJYkYP
	 khAbDHsCa8wBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/28] KVM: Take memory protections into account for
 memory read/write/fetch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-16-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-16-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:34:03 +0000
Message-Id: <20260918083404.884F01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: vcpu_map bypasses KVM_MEMORY_ATTRIBUTE_NR/NW protections
--

commit 79f1cf1f5a4245adbef80d2c22573dcd13309746
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: Take memory protections into account for memory read/write/fetch

Take into account memory attributes when accessing guest memory through
the kvm_{read,write,fetch}*() family of functions.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index c910beb7a3aa5..e3ea9ceed01ea 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> @@ -3395,6 +3409,10 @@ static int __kvm_write_guest_page(struct kvm *kvm,
>  	addr =3D gfn_to_hva_memslot(memslot, gfn);
>  	if (kvm_is_error_hva(addr))
>  		return -EFAULT;
> +
> +	if (!kvm_mem_attributes_may_write_gfn(kvm, gfn))
> +		return -EFAULT;
> +
>  	r =3D __copy_to_user((void __user *)addr + offset, data, len);
>  	if (r)
>  		return -EFAULT;

[Severity: High]
While this patch updates the read/write/fetch helpers, does it inadvertently
leave __kvm_vcpu_map() vulnerable to bypassing memory protections?

In virt/kvm/kvm_main.c:__kvm_vcpu_map(), KVM resolves and maps the PFN into
kernel space without checking KVM_MEMORY_ATTRIBUTE_NR/NW memory attributes:

int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *m=
ap,
                   bool writable)
{
        ...
        map->pfn =3D kvm_follow_pfn(&kfp);
        if (is_error_noslot_pfn(map->pfn))
                return -EINVAL;

        if (pfn_valid(map->pfn)) {
                map->page =3D pfn_to_page(map->pfn);
                map->hva =3D kmap(map->page);
        ...
}

If a malicious L1 guest provides a protected GPA (marked Non-Writable or
Non-Readable by host userspace via KVM_SET_MEMORY_ATTRIBUTES) to an interfa=
ce
mapped via kvm_vcpu_map (such as a nested VMCS, VMCB, or APIC access page),
KVM will successfully read/write it outside the guest MMU. Can we check
kvm_get_memory_attributes() here before mapping to prevent KVM from acting
as a confused deputy and violating the host's memory protections?

While pfncache and cached offset accessors were explicitly fixed in follow-=
up
patches within this series (e.g., 'KVM: pfncache: Fail to refresh if it
contains memory protections' and 'KVM: Take memory protections into account
for accesses with cached gfn->hva'), __kvm_vcpu_map was missed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D15
