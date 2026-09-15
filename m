Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440943CE6D
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494854; cv=none; b=EFs1lMBndZz29bllH794EoruNpZ0tLtBYyhqXOgm67ddTCvowfLOKWDnxzpHjohIogrhm1KZcNq/FhbLdw0AfEkhNy8NJMn3E9QowgALxxEhvnS1ivfZOM2/412gQoDVg9dFSa90SP5Z2LsUCbdW2VepZFoLiNiHIKaqqCETvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494854; c=relaxed/simple;
	bh=l5wJLZ+qYp4YnALEuMvRCtAcsZGAclRAMwQTu1jrhWk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Os1xNIt5YMdHHfYBDpvYlZ0xxrPqTHXG8RjGiD2kiorfP6q+7rUNGcTz1hZH4pB739HEDbD88T2X1Oyg0XxBQjBv7ofXXZtcs35g4vwnAl77O8y5UVXLKtfvHoy98+LF/JpIa1DFAzoHUD4Nc98wIRFPEcJ8/MkJSEhHNUWEF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Mn4EBae+; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Mn4EBae+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=bbvwys7yf5dzdi3hk7qoqfoho4.protonmail; t=1789494843; x=1789754043;
	bh=+a8hOjyqA/nNyf5/vNUyHc7QBQwDmTAe84U8l3tR9CU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Mn4EBae+3ZtqVcQjmpVCN5jJaCYM2sFRzEfB0RGS25dyT9Ez9/jtFFrqRfH08e1gU
	 kpM1vzy/LQx63NIN5gDUmZ06qGPYLhkFgiJAVNKTQXPreU2HdOrQ1oCxJEi5nd8Niu
	 EOstnJHdkrKOT6bt7brcYhn/ZzEVTHfr9P3V41b7EtZMFS8KmxVEmDfBjj9KbvgoIl
	 lLIhl/6+MR9lLyvegnbZARDa4DR52/m+mh6RkEW+fr4sz93JeBtyGmL6ndISx+dY+K
	 uz8+gUqn04OJti5FVwkPqlSdZOec2eItv88wruZYvgvav2q9JVhHOfPVcpC8IaI7Ab
	 ee4z5ZnpgMLvA==
Date: Tue, 15 Sep 2026 17:53:57 +0000
To: pbonzini@redhat.com, seanjc@google.com
From: David Ballesteros <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] KVM: Account mem_attr_array nodes to the caller's memcg
Message-ID: <20260915175335.138547-4-davimaba.v@proton.me>
In-Reply-To: <20260915175335.138547-1-davimaba.v@proton.me>
References: <20260915175335.138547-1-davimaba.v@proton.me>
Feedback-ID: 219068424:user:proton
X-Pm-Message-ID: 7011f62075307131ca7d0a6488dabe2651063920
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

kvm_vm_set_mem_attributes() passes GFP_KERNEL_ACCOUNT when reserving xarray
entries, but the nodes are allocated by xas_alloc(), which hardcodes
GFP_NOWAIT and only adds __GFP_ACCOUNT when the xarray carries
XA_FLAGS_ACCOUNT.  mem_attr_array is initialized with plain xa_init(), so
the flag is never set and nodes taken from that fast path -- the
overwhelming majority -- are not charged to the caller; only the rare
__xas_nomem() slow path is, because it receives the caller's gfp.  Measured
on v6.18.48: a process in a cgroup limited to 256 MiB grew
radix_tree_node slab by ~512 MiB while its memory.current stayed near 0.
Per-tenant memcg limits therefore do not contain the growth.

Set XA_FLAGS_ACCOUNT so the intended accounting takes effect.

Note this is a change in reachability, not in contract.
KVM_SET_MEMORY_ATTRIBUTES could already return -ENOMEM, but only under
global memory pressure, since the fast path allocated with plain
GFP_NOWAIT.  With the nodes accounted, a tenant under a memory.max limit
can now hit it from a cgroup-local condition, i.e. conversions that
previously succeeded may fail.  That is intended and matches every other
GFP_KERNEL_ACCOUNT allocation in KVM; the alternative is letting the tenant
grow host memory that is never charged to it.  Userspace driving
conversions from guest KVM_HC_MAP_GPA_RANGE hypercalls surfaces the failure
on that path.

Runtime-verified on v6.18.48 (isolated VM, no KASAN): without the flag a
process in a 256 MiB cgroup materializes 512 MiB of radix_tree_node slab
with memory.current flat (the memcg is inert); with the flag the same
process is contained by the cgroup -- the memcg OOM killer selects the
attacker inside its own slice (CONSTRAINT_MEMCG) instead of exhausting
global memory.

Found by an AI-assisted security audit.

Not tagged for stable: unlike 1/3 and 2/3, which are pure corrections, this
one changes observable behaviour, and new -ENOMEM returns for
cgroup-limited tenants are a poor fit for stable's regression-risk bar.
Happy to send it to stable separately if maintainers disagree.

Fixes: 5a475554db1e ("KVM: Introduce per-page memory attributes")
Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: David Ballesteros <davimaba.v@proton.me>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1116,7 +1116,7 @@ static struct kvm *kvm_create_vm(unsigned long type, =
const char *fdname)
 =09rcuwait_init(&kvm->mn_memslots_update_rcuwait);
 =09xa_init(&kvm->vcpu_array);
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-=09xa_init(&kvm->mem_attr_array);
+=09xa_init_flags(&kvm->mem_attr_array, XA_FLAGS_ACCOUNT);
 #endif

 =09INIT_LIST_HEAD(&kvm->gpc_list);

