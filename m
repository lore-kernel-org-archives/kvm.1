Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651F3EDAAE
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152535; cv=none; b=dHnRVuaBs6gGS2VpZYmKdWNL+boiqou9dxPuTNpuQfrEVbuWLqOYPsSCbvguaCKH3VkQPImRDI1a8AeAOYymC2PMdKIDwojqFNZ8/cQBDtsoJeMYq89hUtBR86Y2TZjF5NmtzlBImoXJl11zFcTWCVZVksGeHtdZxrPkW72bvpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152535; c=relaxed/simple;
	bh=tzwWPJiMgYVyvGHkKvNlCIy+lCnz4/3ZdVbkzuWEEl0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5K3OyFz8fCawyg8eKWcaf2xl2mFvMfkQqSL62TwcnE/P5rs/BdWBbdHVdguvFAuFrhWqO9IbxG3DUOwzIBBZ+DhT+czqpgHWzkdVDWc53dhzsbLEWgFF3Q9A3s1KuvCNJM11F+Y2xcOziSGcYx9OFcPQi8vI/Z4RcgyVIh+dNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Qv7Sfrnu; arc=none smtp.client-ip=185.70.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Qv7Sfrnu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=pdvwzr6q4rh3fhlmnwqsi6bpqu.protonmail; t=1789152527; x=1789411727;
	bh=jBNjAlhIH8yO4bPZSd1tjaD4l2TRVj+yjfh6H9gmFd4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Qv7SfrnuekjtNqeUaAOiaCEB82wuNYq38qY//WYQQ7kzMsLBV6XcZyb0O6u8n6Ynz
	 gdnrGDWK+6GxcgmhRHGx7FN3pSxGWaw3o17RnKjabyZhDu6+VWgbZBb1IgXFcJZN8I
	 hNE/gSCS2YA0sRe/NkNCwW7zxcXm9E1VWSk4SmJGhbVAtmxPotm8JSWCZCeF1hxRk9
	 ADdaayCo2+EhvimH+5rEeH66wztIJiuqz2UmSqYqJXM95YIOiCRdks6GL1xoELWN+Y
	 UFgT5UTG3/vUxCoGXbAl+QCtUGzMCF3Q7zR30mUmzA2NccIXzkLWhp2o85ueKNZww3
	 hgvIVoy8zEOMg==
Date: Fri, 11 Sep 2026 18:48:45 +0000
To: pbonzini@redhat.com
From: David Ballesteros <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org, security@kernel.org, David Ballesteros <davimaba.v@proton.me>
Subject: [PATCH 2/2] KVM: Account mem_attr_array nodes to the caller's memcg
Message-ID: <20260911184819.101123-3-davimaba.v@proton.me>
In-Reply-To: <20260911184819.101123-1-davimaba.v@proton.me>
References: <20260911184819.101123-1-davimaba.v@proton.me>
Feedback-ID: 219068424:user:proton
X-Pm-Message-ID: d29167747385bc4ce2e0533f15000786861d9ca5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

kvm_vm_set_mem_attributes() passes GFP_KERNEL_ACCOUNT when reserving
xarray entries, but the nodes are allocated by xas_alloc() with
GFP_NOWAIT, which only adds __GFP_ACCOUNT when the xarray carries
XA_FLAGS_ACCOUNT.  mem_attr_array is initialized with plain xa_init(),
so the flag is never set and the nodes are never charged to the caller:
measured on v6.18.48 and v7.2-rc5, a process inside a cgroup limited to
256 MiB grew host SReclaimable by ~450 MiB while its memory.current
stayed at ~488 KiB.  Per-tenant memcg limits therefore do not contain
the growth described in the previous patch.

Set XA_FLAGS_ACCOUNT so that the intended accounting takes effect.
This is a mitigation, not a bound (it does not limit growth); both
patches are needed to bound and attribute the memory.

Runtime-verified on v6.18.48 (KASAN build, isolated VM): with this flag,
a process in a cgroup with memory.max=3D256M is contained by the cgroup
limit (allocation fails cleanly and, at the limit, the memcg OOM killer
selects the attacker itself) instead of exhausting global memory, and
cgroup memory.current tracks the materialized nodes one to one.

Found by an AI-assisted security audit.

Fixes: 5a475554db1e ("KVM: Introduce per-page memory attributes")
Assisted-by: Claude-Code:GLM-5.3-flash KASAN KCSAN
Signed-off-by: David Ballesteros <davimaba.v@proton.me>
---
--- a/virt/kvm/kvm_main.c=092026-07-26 16:45:48.000000000 -0500
+++ b/virt/kvm/kvm_main.c=092026-09-10 14:20:00.000000000 -0500
@@ -1117,7 +1117,7 @@
 =09xa_init(&kvm->vcpu_array);
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-=09xa_init(&kvm->mem_attr_array);
+=09xa_init_flags(&kvm->mem_attr_array, XA_FLAGS_ACCOUNT);
 =09kvm->mem_attr_gfn_count =3D 0;
 #endif
=20
 =09INIT_LIST_HEAD(&kvm->gpc_list);

