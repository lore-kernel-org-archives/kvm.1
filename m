Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73294BEE53
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164844; cv=none; b=DiEEv0ENVmIidZUkBvjOr9At6ggntZ2mwGfxiqXNhCfgv5G1V+Zl2aI0KLvRMnSciHUhOr4AP8fUaGbgD7lmq+nnR9MohtPALtZbeKwzOPB6mHnzUVuNNxrnAiURs7ZwCDoL78skpkXtaHFvERfNU8ZVKk/F1zPlWNZ0k2Y6EAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164844; c=relaxed/simple;
	bh=Ny189n2TGusj1130uHhO6qanQTICxllt6KynpLu9dEc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbA9q7ODKexPFt4TC9W//jikWlNm0xKQSLDCHyd6yUojyVR6N8wD1rNaNrJHM1ff1GuQCGLifvF55+Wo1FdNmvKIRTMMO6qci4fZ1f92wq4Sjnr92l3MoquqdAzxmD2nIEZZ6wzC1Sf1Pk5FcP152izofXZJcEDFtWyV7Pd6E2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HTjDYZUN; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HTjDYZUN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789164833; x=1789424033;
	bh=mvyrkVm8V5Pc7U36SGBMBgg98PKVGXtLlkL0BnXwbh0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HTjDYZUNIGklV0wPCOFvRmo3IfBvmC6hoJqpQb+2hQQ/GzeX3YWn5awhC/GZzVoe1
	 aALQm86un3IpE6nUUO4ToVswCcFhQQikKWqOn10n60maksdVhR873pkyMnNN4oHjme
	 0Lz+OgEnhti6tnODafczICLB+MeDp59CDYH+iBdEE5O+qFAtc2rIOcgFtQ/Sz7Fp+5
	 IgFOyFijT9FKI67J2dsJOodBH8+sdT2Y3wTL6N7IMTb1KfWXoY1GwuFSBS5xhqGPU+
	 TjDleb3BTakjCpvleZwNzw3cGhbgeHFZHVd0UAajU/PAIzFl+mMqQigkM+c118ehyT
	 rpIfe6Px+stAw==
Date: Fri, 11 Sep 2026 22:13:49 +0000
To: pbonzini@redhat.com
From: David Ballesteros <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org, security@kernel.org, David Ballesteros <davimaba.v@proton.me>
Subject: [PATCH v2 2/2] KVM: Account mem_attr_array nodes to the caller's memcg
Message-ID: <20260911221302.53013-3-davimaba.v@proton.me>
In-Reply-To: <20260911221302.53013-1-davimaba.v@proton.me>
References: <20260911184819.101123-1-davimaba.v@proton.me> <20260911203238.30088-1-davimaba.v@proton.me> <20260911221302.53013-1-davimaba.v@proton.me>
Feedback-ID: 219068424:user:proton
X-Pm-Message-ID: 6ddf08285af46ae0594137e0333cb1a9114884df
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

 =09INIT_LIST_HEAD(&kvm->gpc_list);

