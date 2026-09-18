Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291B4F96C2
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743443; cv=none; b=OHS2k7dXIngRyVpuKJebZujyqrwMQmrd0P+ARxyS7EqPPEsLqoIpiGAVT9YAqHP6WaymXnn3H7c3y8i0uCrtYx7g4lgeXGLWqjYYz/0AJr5QbGyL7rg7zDawJaHing4KResHQsLMw5fE861ViK1yl+GK7jCDUR6wNtfO0XAWoBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743443; c=relaxed/simple;
	bh=ywCDwWczOthwM3LgQSw96QUc3eXfZw1pO4cS+Apj7v8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fhI57wTI5oJ2gM3Euu980r3kEVxg4ySZbNUaTCdFhqay+f/9F2GDByYxHhG6n+tU7VkIsexkW1vB94QKW4kgFGGxnRvu31XW4f4sz8bNQz1wBGnYye3zb+8qJ1ku8vYkpZtD0RFgNBtaY7TGXvBz72JKyIkyCsq5Lk5ZdKQl40E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyZZmoIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyZZmoIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19901F000FF;
	Fri, 18 Sep 2026 14:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789743441;
	bh=i/ot6fI/mfPOrB1LaOYO1JcJ0Oh3MPODjV0WmaEsevo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SyZZmoItPgFmaMvJ+aBqr4nSFjqEfTPTKC4W/gFGrwE5atptoHbvZEKrmFmQrRZpB
	 hk6iYIbz58NXT1/hsDGzLFrNCRts3aRpSYFONofsUsvFDVYo959yyu99Q2a3tR5IOt
	 5XcCFi2lCjSshwg735OxevGU8HnOJsL98HdNMesXJwKXyq32KmJkV50yuw2yxNPY08
	 mswEPTBUq6Ut32hQB1ITstKdpc3mdswIDTZrFNDAJiuuGdEW/CBF6drXWx4Nla5F1d
	 FvdZxstYWD6Dj9rI9nl5ZrnxLGm65FqJzx7ib6veHd+c3YE9h6RGQ3sbvYkOaxdTIM
	 JygYRUEVXY8KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/31] KVM: x86/mmu: Take memory protection attributes
 into account during faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918135030.171564-26-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
 <20260918135030.171564-26-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:57:21 +0000
Message-Id: <20260918145721.B19901F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: trace buffer spam on AMD with GMET enabled
--

commit e48ad04487bab345ee62e42a2457d15e6edd7180
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: KVM: x86/mmu: Take memory protection attributes into account durin=
g faults

This commit adds support for memory protection attributes during guest page
faults, injecting a user-space -EFAULT exit for prohibited accesses. It also
adds a trace event that is intended to trigger only when memory protection
attributes restrict access.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 3c926f95f87be..6bbecbae2f8c4 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
[ ... ]
> +static inline unsigned kvm_get_gfn_protections(struct kvm_vcpu *vcpu, gf=
n_t gfn)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	unsigned int access =3D vcpu->arch.mmu->root_role.access;
> +	unsigned long attrs =3D kvm_get_memory_attributes(kvm, gfn);
> +	if (!attrs)
> +		return access;
> +
[ ... ]
> +static int kvm_faultin_memory_protections(struct kvm_vcpu *vcpu,
> +					  struct kvm_page_fault *fault)
> +{
> +	unsigned access;
> +
> +	/* Memory attributes don't apply to MMIO regions */
> +	if (unlikely(!fault->slot))
> +		return RET_PF_CONTINUE;
> +
> +	access =3D kvm_get_gfn_protections(vcpu, fault->gfn);
> +	if (access =3D=3D ACC_ALL)
> +		return RET_PF_CONTINUE;
> +
> +	trace_kvm_faultin_memory_protections(vcpu, fault, access);

[Severity: Medium]
Will this check effectively prevent trace buffer spam on AMD processors
with Guest Mode Execute Trap (GMET) enabled?

When GMET is enabled, KVM sets the root_role.access for the TDP MMU to
ACC_ALL & ~ACC_USER_MASK. Since kvm_get_gfn_protections() initializes the
access mask using vcpu->arch.mmu->root_role.access, it will return the
restricted mask even if no memory attributes are present.

If access is restricted by GMET, the condition checking if access =3D=3D AC=
C_ALL
evaluates to false, which causes the trace event to trigger unconditionally
on every page fault. Could this lead to noticeable performance regressions
during tracing on these systems?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918135030.1715=
64-2-pbonzini@redhat.com?part=3D25
