Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF3B2D238F
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784229193; cv=none; b=NiQksRD5mNp7svUFdGJndnNcBrcCNj+Ziq4jTpELSI8P+18ctPITvw8mdKENMNUUHDvK/6qeOyDNI31SrEw7Yupe0vG9FX5groxIAbaH7RVQQdB+uGVMhtdzTYdpo2oP9g2B+r+FkCAc8cQVq3T8Ngh/0ogizeWoIrXAilbP99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784229193; c=relaxed/simple;
	bh=dpFs/JJjoy79UB4mkEjO6hDCFzSWnZZO2gnpr9Kzi+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lnESOSaxTii9jtLTobxyHsdIs4/xfmLJ3rG+cgMY+z/dcaE68uggRO/+yOKqqgHyG4b2+cz3w1Mv4zJGhKNbp+xKn2VkMcdQ+JbFdLiwqSl2VFRq9jtGEe0YcoXTdg3ZyfXPb0pBPjVpOTBpm0T1FFno86E9FFqilQXR7+yz0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap1tDKqr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap1tDKqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EEE1F000E9;
	Thu, 16 Jul 2026 19:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784229192;
	bh=coMb/Dyu0GiC8AyW4hmjAXvy+lQUMRRQeoT+N+D6rqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ap1tDKqrygTxHAUcDPFPa45dis+0dLqPVPwHk7RxZLhYj9WGZqC8cNRzsa5JYNneN
	 7YtFOrcwWUzAgB4hAVkRP7HRRoXMK+/5qk2kjFsyYZW4hD3pnyUCOZlLd8hrfYGQXy
	 WKE3jZ63cJZfAszUz9dn7sWZcFRkT/c2v0CdLFhuLy/PIKljeftM/phhrQel9cWwFq
	 kBk4vcHU3gQY/6P77++DDGH3JJtLdTdrtmAY5XAcWDiCR7PczlxQ+uJwcPZoxktjkt
	 uFntCVCbu3JxKDJsckObFQd59him8Nr8jYPm/Ax9UJyxO23uAcv9YcpbGVIvMT4mYL
	 b9X3GkU/uOvSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/24] KVM: x86/mmu: Take memory protection attributes
 into account during faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-18-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-18-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 19:13:11 +0000
Message-Id: <20260716191312.21EEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The new `kvm_faultin_memory_protections` trace event directly call=
s `kvm_rip_read(vcpu)` inside its `TP_fast_assign()` block. This introduces=
 a dangerous side effect that mutates vCPU state and triggers a host-side D=
oS (via `WARN_ON_ONCE` and potential kernel panic) for confidential VMs lik=
e Intel TDX.
--

--- Patch [17]: [PATCH 17/24] KVM: x86/mmu: Take memory protection attribut=
es into account during faults ---
commit df2f2adf06ac42cf5912c212a4b41b02bf9ceb82
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: x86/mmu: Take memory protection attributes into account during faults

This commit updates the x86 MMU fault handling to check memory protection
attributes. If a guest accesses memory with prohibited attributes, it
exits to userspace with -EFAULT. It also adds a trace event for these
memory protection faults.

> diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
> --- a/arch/x86/kvm/mmu/mmutrace.h
> +++ b/arch/x86/kvm/mmu/mmutrace.h
> @@ -447,6 +447,35 @@ TRACE_EVENT(
[ ... ]
> +TRACE_EVENT(kvm_faultin_memory_protections,
> +	TP_PROTO(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
> +		 unsigned access),
> +	TP_ARGS(vcpu, fault, access),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, vcpu_id)
> +		__field(unsigned long, guest_rip)
> +		__field(u64, fault_address)
> +		__field(bool, write)
> +		__field(bool, exec)
> +		__field(unsigned, access)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->vcpu_id =3D vcpu->vcpu_id;
> +		__entry->guest_rip =3D kvm_rip_read(vcpu);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: High]
Does this code trigger a side-effect that crashes the host for confidential
VMs like Intel TDX?

Reading the instruction pointer dynamically via kvm_rip_read() inside a
tracepoint evaluates kvm_register_is_available(). If the register is not
marked available, it calls the architecture-specific cache_reg hook to
fetch it.=20

For TDX guests, VCPU_REG_RIP is explicitly omitted from the available
register set. Consequently, kvm_rip_read() will fall back to calling
vt_cache_reg(), which executes a WARN_ON_ONCE(is_td_vcpu(vcpu)).

Since an untrusted TDX guest can intentionally trigger this fault by
accessing restricted memory, this allows a malicious guest to trigger a
host-side denial of service if tracing is enabled and panic_on_warn is set.

Should this use tracing_kvm_rip_read() instead to safely fetch the RIP
without triggering caching side-effects?

> +		__entry->fault_address =3D fault->gfn;
> +		__entry->write =3D fault->write;
> +		__entry->exec =3D fault->exec;
> +		__entry->access =3D access;
> +	),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D17
