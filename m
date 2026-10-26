Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000160;
	b=S5L9f3dL8ASSkcPYF9R2N21xzpiCjlIME7aD1+Tvwo4uorpvTJpW4+Svcw8f57GWiW/O
	 EjNJYSIcnzPal3xDYwxHZrPTvkpA1KEchfaHRBhGlYJ1dZ7nO2NHD2hkTeAE98oVJXPRK
	 nv2olWW6lO7OAVuJKI1b149o5d9eXeaZQICq+rSK3Tp24GMULiDFHW4RwP5e7D/MUAV6H
	 KocC872+x8wUuHYJQ32ks4V75HYYOufkt39JJB/KyNvU6wAuENHSIYM4IZIy+73cHlH7S
	 pyiGqO9IlVRkwetWgOktBtW0AVYctL+3Lm1+t0AlKIX9JyBFbUHHiZ2ZlGvWTA9mwpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000160;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W4aGUUJNgkmH4WywgrlMXxv329VDCA9p+jUtQYZbo0w=;
	b=LtlujY82ZHx641HRb0CKFpbQFK7KDUKMQBvdb2DK+ne1yLJkPc1j9SnK7AcCY/kykALD
	 SD+3izkBPeqYgmrx2/A+z3iR55QqDcP0Jn73d7TOairsLHtyLmsaz3Y4F0fPqO4mT00Y5
	 m30BSUmL3dA+vSfS9iDist6WGieIqz03hhPPz0TX2MxeRaXahiOUKcB/8ojyvUBY6D1Kz
	 xnGpox9EKl+z4zEH26yOEwPkCwFk9Kzbm6+PrsDAxoFAWq2PX9MLcihqwE+mdn2hYwErB
	 JBor9V5hQSPc1eR+NpXV0nFuDhRY7V4JAnPOtNJloJS83VMcqiBhY0LrA4iCL9S3Mdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDqC2fMe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E859606A31D
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDqC2fMe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF251F01825;
	Mon, 26 Oct 2026 07:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793000160;
	bh=W4aGUUJNgkmH4WywgrlMXxv329VDCA9p+jUtQYZbo0w=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cDqC2fMeF25/JKerwdiP6L/hwfoviv09WqUxIArU/J2npADSTpVaEJxYe/E1govum
	 lCq555MLnnl4GDf+wOFon0xKhVsHLELhW4dWz6A8m7xeQrHW1fBhPI4IuidRJmHPMf
	 OupqIR3tdVyz3w8y5lOcCMAnWK1A1KM4T17d4vlErEq2OSa8cDBjiJ0vA8dPq1cax5
	 ba1T0TZ4g80HysCphzEbUXYEGhm5UftbS2wQIa6+fxB7JKQ3VSlanjdbL7hHZpqN91
	 im4360Cs826ESMldIwcE+KfOduLSbKct8/4ljiAL58bILL6vsZPpEXqMTdLVbuhpD5
	 q9Yo/5VXqcaLQ==
Message-ID: <sashiko-outbox-184661@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 3/5] KVM: guest_memfd: Advertise support for
 KVM_LINK_GUEST_MEMFD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Gong" <gongtao@google.com>, kvm@vger.kernel.org
In-Reply-To: <20261026064424.3003536-4-gongtao@google.com>
References: <20261026064424.3003536-1-gongtao@google.com>
 <20261026064424.3003536-4-gongtao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 07:35:59 +0000
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
- [High] KVM: guest_memfd: disallow linking guest_memfd across TDX and SEV-=
SNP VMs
--

commit 22378b77744900b2602bc894dbec906d31acf8be
Author: Vishal Annapurve <vannapurve@google.com>

KVM: guest_memfd: Advertise support for KVM_LINK_GUEST_MEMFD

This commit introduces KVM_CAP_GUEST_MEMFD_LINK and advertises it via
KVM_CHECK_EXTENSION so userspace can discover support for linking
guest_memfd instances across VMs with KVM_LINK_GUEST_MEMFD.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 70521371b64ab..135e7bb7609a8 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -5008,6 +5008,8 @@ static int kvm_vm_ioctl_check_extension_generic(str=
uct kvm *kvm, long arg)
>  			return 0;
> =20
>  		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +	case KVM_CAP_GUEST_MEMFD_LINK:
> +		return 1;

[Severity: High]
Should KVM_CAP_GUEST_MEMFD_LINK and kvm_arch_gmem_link_allowed() restrict
linking guest_memfd instances for confidential VM types such as TDX and
SEV-SNP?

Right now, kvm_vm_ioctl_check_extension_generic() unconditionally returns 1
for all VM instances, and on x86, kvm_gmem_link() ->
kvm_arch_gmem_link_allowed() only checks whether the two VMs have the same
vm_type:

arch/x86/kvm/x86.c:kvm_arch_gmem_link_allowed() {
	return dst->arch.vm_type =3D=3D src->arch.vm_type;
}

This allows userspace to link a guest_memfd between two KVM_X86_TDX_VM
instances, two KVM_X86_SNP_VM instances, or between a legacy SEV VM
(initialized via KVM_SEV_INIT on a KVM_X86_DEFAULT_VM without changing
kvm->arch.vm_type) and a default VM:

1. For KVM_X86_TDX_VM, private guest_memfd pages are encrypted with a
per-TD ephemeral HKID and tracked in the TDX Module PAMT as exclusively
owned by a single TD. If two TDX VMs link a guest_memfd and both map the
same private PFN via KVM_TDX_INIT_MEM_REGION -> tdx_mem_page_add() or a
stage-2 EPT fault -> tdx_mem_page_aug(), the second TD's SEAMCALL fails
with TDX_PAGE_NOT_FREE:

arch/x86/kvm/vmx/tdx.c:tdx_mem_page_aug() {
	err =3D tdh_mem_page_aug(&kvm_tdx->td, gpa, level, pfn, &entry, &level_sta=
te);
	if (unlikely(tdx_operand_busy(err)))
		return -EBUSY;

	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_AUG, entry, level_state, kvm))
		return -EIO;
}

Because TDX_PAGE_NOT_FREE is not an operand-busy error, TDX_BUG_ON_2()
triggers a host WARN_ON_ONCE().

2. For KVM_X86_SNP_VM, each physical page has a single system-wide RMP
entry binding it to one (ASID, GPA) pair. When a second SNP VM faults in a
private guest_memfd page already assigned in the RMP to the first SNP VM,
sev_gmem_make_private() sees assigned =3D=3D true from snp_lookup_rmpentry()
and returns 0 without checking whether the RMP entry belongs to the current
VM's ASID:

arch/x86/kvm/svm/sev.c:sev_gmem_make_private() {
	if (assigned) {
		pr_debug("%s: already assigned: gfn %llx pfn %llx nr_pages %llx level %d\=
n",
			 __func__, gfn, pfn, nr_pages, level);
		return 0;
	}
}

KVM then installs the page into the second SNP VM's NPT, leading to
repeated guest RMP #NPF faults; furthermore, if the first SNP VM is
destroyed while the second SNP VM keeps the linked guest_memfd alive,
sev_vm_destroy() frees the first VM's ASID via sev_asid_free() while the
shared guest_memfd pages remain assigned to that ASID in the RMP table.

Should KVM_CAP_GUEST_MEMFD_LINK and kvm_arch_gmem_link_allowed() disallow
linking for TDX and SEV/SNP VMs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026064424.3003=
536-1-gongtao@google.com?part=3D3
