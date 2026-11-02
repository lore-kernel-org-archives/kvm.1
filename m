Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642136;
	b=vptjhwFtOLfrNC8dLR55dw7juYeglDLXYfUItK/V67O1oZ/KMZcpyZDQ3dBE0hkG+4OM
	 UNZb4moR9V7durLQP34KVeMCP47ZJtccj1IWfXTsJnKikldDzEYVtRNXv6dGP5TnGGg2C
	 G3cQEt4FcJsMEiH5oAQYobIfSt8T4YBC9UWr/LPscW9eJG/ZuG/3d3uww14ZUfkDRt7Xc
	 JWxJn/bXSIjm+s24tb5QaFYAbCea+Ii665Pr2J+UWUz5OB1szBUSTmgnQLnIZYsYtLFKe
	 iKOgIn1doF87sxBLkB7mPUH3TachAWDfL5V7g5WhsVBuYOXS3bJeOU2LrRcI2EpBZnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642136;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nfpcDvIfW+PqEgEIC4pgr6+hGE9CZr3GnkXbBZuUWCg=;
	b=O10q2aLxSjWXP06hcRZx/48/ESRxHzH8g+qnIzLcmDyku4sgCquV4wu6VY6U80v7U3wv
	 TBEL0QC29n6VpCjWMHI7xu8zsHqeVpGvQnSQPv/JqkfyqabCYtUVD3/QVDkN/c0e0JNKD
	 PAmW92LWf86x6udypIv51XLEWFKtP70CXaMB36tWV319N9vGcI5GOu18/j/FTHYi0AM3z
	 RKOqONXaOJXfI13c/ZHbGCUSDkRuJ0YoPYqDvGozv3QFoxZaY1oyXhb5U9uONZvBQ25o0
	 oB8Fq2RTOqViP2xNzMbGDN0nKE5BabOYOIIDxAxLswNaGMMDjxn2whHwyKNpfNog1qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qxw6oE6a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292F0606BA5C
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qxw6oE6a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353251F00A16;
	Mon,  2 Nov 2026 17:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793642135;
	bh=nfpcDvIfW+PqEgEIC4pgr6+hGE9CZr3GnkXbBZuUWCg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Qxw6oE6a2q911N6ljG6mqpMK+WX/L0/rzdoWIZ5Y+XAUkzDp+JKgJ+PLln613oEDG
	 mk2Zi/DkI4A3bFZgBRVJ0u6+bAC6bd66qcBbrjp/m/S9xgCbst1/OqCKtei73KAj5h
	 pFateP0Y2QOY8n7zUaNAC6aFC1lAnSJVbjuxtsl0w6WMR6t2wfweMqWkMkcXoGV+71
	 iVdh7sF+wbvHoSi1sbzXuG39z3Re5JyWkRis3HeSpjrHbkHq4etNuIRMjyghoMkPqQ
	 +cYOfakGKjweuh/y8qobrIzrNI93Il6E3O+XZYs5hPpQyI61f8aNr/nE2zezlfN3/R
	 MUKK/mjQ/QJ8g==
Message-ID: <sashiko-outbox-193884@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/45] KVM: Define and communicate KVM_EXIT_MEMORY_FAULT
 RWX flags to userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174130.8779-10-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174130.8779-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 17:55:34 +0000
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
- [Medium] KVM: flag change in kvm_prepare_memory_fault_exit() breaks selft=
est
--

commit 97c15077daea43ee7bc4ecb13d9cec2a636fe69e
Author: Anish Moorthy <amoorthy@google.com>

KVM: Define and communicate KVM_EXIT_MEMORY_FAULT RWX flags to userspace

This commit defines KVM_MEMORY_EXIT_FLAG_READ, KVM_MEMORY_EXIT_FLAG_WRITE,
and KVM_MEMORY_EXIT_FLAG_EXEC in the UAPI header and updates
kvm_prepare_memory_fault_exit() to populate vcpu->run->memory_fault.flags
with the corresponding access type flag.

Link: https://lore.kernel.org/kvm/ZR4N8cwzTMDanPUY@google.com/
Link: https://patch.msgid.link/20260918135030.171564-4-pbonzini@redhat.com

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index e7fc94e2910a8..5e386c3d24957 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2556,8 +2556,15 @@ static inline void kvm_prepare_memory_fault_exit(s=
truct kvm_vcpu *vcpu,
>  	vcpu->run->memory_fault.gpa =3D gpa;
>  	vcpu->run->memory_fault.size =3D size;
> =20
> -	/* RWX flags are not (yet) defined or communicated to userspace. */
>  	vcpu->run->memory_fault.flags =3D 0;
> +
> +	if (is_write)
> +		vcpu->run->memory_fault.flags |=3D KVM_MEMORY_EXIT_FLAG_WRITE;
> +	else if (is_exec)
> +		vcpu->run->memory_fault.flags |=3D KVM_MEMORY_EXIT_FLAG_EXEC;
> +	else
> +		vcpu->run->memory_fault.flags |=3D KVM_MEMORY_EXIT_FLAG_READ;

[Severity: Medium]
Does setting KVM_MEMORY_EXIT_FLAG_READ here break
test_private_access_memslot_deleted() in
tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c when
!kvm_has_gmem_attributes?

In that test, the vCPU runs guest_repeatedly_read() on private guest memory
while the backing memslot is deleted, causing kvm_handle_noslot_fault() ->
kvm_mmu_prepare_memory_fault_exit() -> kvm_prepare_memory_fault_exit() to s=
et
vcpu->run->memory_fault.flags to KVM_MEMORY_EXIT_FLAG_PRIVATE |
KVM_MEMORY_EXIT_FLAG_READ.

Earlier commit 628770546898 ("KVM: selftests: Take into account mixed memory
fault flags") added a bitwise check in test_private_access_memslot_deleted(=
),
but left the exact equality assertion in place right above it:

tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c:test_private_a=
ccess_memslot_deleted() {
	...
	} else {
		TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
		TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVAT=
E);
		TEST_ASSERT(vcpu->run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE,
			    "Memory fault didn't occur on a private memory access");
		TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
		TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
	}
	...
}

Should that leftover TEST_ASSERT_EQ(vcpu->run->memory_fault.flags,
KVM_MEMORY_EXIT_FLAG_PRIVATE) be removed so the selftest does not fail once
KVM_MEMORY_EXIT_FLAG_READ is set?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D9
