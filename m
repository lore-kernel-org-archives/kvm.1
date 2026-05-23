Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74DB2F851
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779497733; cv=none; b=loxsXTB92d3e1GxRrm+erPpcCXW3QBFm3IthG9+84986Jorp4lnk2xbQvdPkGzNTl2DRuP9rWyOFPkL1kSwDxZTMIkEY8LCU5FqS3yYmR7dHsUBHpPHNjdDcQBAFdst3wOUdHJRZ1Mps0N50LFke8g52odT8xP4n2HW94Kbtzuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779497733; c=relaxed/simple;
	bh=m3J2s0kR9ZBOUHtGwUosiFlxP9gu8Lz0rrnTC5jbf4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OkrNFct9Wipzor5ZcMUkAHSD6sjcvb9Rm7ZVdF1c7c31j8xXBSQZW70lLSd7M0pzsouis5t01WcX6yIlwLrCVmjFeP8u/F89d6YrPAu4WUsPhjjma9w8MTfDWhCLDjiUPo7Wu7jkLGli5/L0dt6JeZQNiuGjS5iqsCagqluMXhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoRC5Wye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoRC5Wye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0DE1F000E9;
	Sat, 23 May 2026 00:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779497732;
	bh=j4Bh2h7G5o6lRS3Eb970fq+UAo+A8BhiJ+NMzjpfBqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SoRC5Wyeh6p1uNuenVtZOqbLyn6cF7QfsYqxruEPgh057Bo397vbStRu0s/gDmHTD
	 O9HMwBmdZq+f5j+fiGEHTgaeDsh8XvvXK/G6yUXixl0vNA60embS6f7WiW4zhAfH5f
	 d46Wj2C+QsUfl5r9PC18Qv3UPANnDlsnSBJs7DJXKaRdqwYzLTg/MaAiH0pM/vu+aE
	 oJU5x9VHKxxvgqC2FaEsSMU1bbqz7kp7L1LlIvnk3RWsUWeoQ2xtWVUoa2qps/QF1T
	 n+r5boZX0XArwrrOyOkoQFC1NeLUjmVT4rJSR9LeCJyMjB3cg6LuGh7Qp9WOGkebVA
	 8C+0sgD8p68Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 20/42] KVM: SEV: Make 'uaddr' parameter optional for
 KVM_SEV_SNP_LAUNCH_UPDATE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-gmem-inplace-conversion-v7-20-2f0fae496530@google.com>
References: <20260522-gmem-inplace-conversion-v7-20-2f0fae496530@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 00:55:31 +0000
Message-Id: <20260523005532.4D0DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing FOLL_WRITE pin allows unprivileged users to overwrite =
arbitrary read-only memory globally (Dirty COW style vulnerability) in the =
CPUID error path.
- [High] Strict LIFO ordering violation when unmapping local pages via kunm=
ap_local() in sev_gmem_post_populate().
--

commit feb1b4a1de59f0eb64cbf36005ae06dfcdb9b8de
Author: Michael Roth <michael.roth@amd.com>

KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE

This commit updates KVM_SEV_SNP_LAUNCH_UPDATE to make the uaddr parameter
optional when vm_memory_attributes=3D0, allowing guest memory to be
initialized directly from userspace. It enforces non-NULL for
vm_memory_attributes=3D1 cases and updates the relevant documentation.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 940b97d4a8523..107c6ee60472c 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2390,7 +2398,7 @@ static int sev_gmem_post_populate(struct kvm *kvm, =
gfn_t gfn, kvm_pfn_t pfn,
>  	 */
>  	if (ret && !snp_page_reclaim(kvm, pfn) &&
>  	    sev_populate_args->type =3D=3D KVM_SEV_SNP_PAGE_TYPE_CPUID &&
> -	    sev_populate_args->fw_error =3D=3D SEV_RET_INVALID_PARAM) {
> +	    sev_populate_args->fw_error =3D=3D SEV_RET_INVALID_PARAM && src_pag=
e) {
>  		void *src_vaddr =3D kmap_local_page(src_page);
>  		void *dst_vaddr =3D kmap_local_pfn(pfn);

[Severity: Critical]
This is a pre-existing issue, but does this write to the source page allow
unprivileged users to overwrite arbitrary read-only memory globally?

kvm_gmem_populate() calls get_user_pages_fast(uaddr, 1, 0, &src_page) with
gup_flags =3D 0, which explicitly does not request FOLL_WRITE.  This means =
an
attacker can pin read-only mapped memory, such as the system global zero
page or a read-only shared file like /etc/passwd.

If the SEV firmware rejects a CPUID page (SEV_RET_INVALID_PARAM), KVM will
attempt to write the expected CPUID values back to the user-provided page:

	void *src_vaddr =3D kmap_local_page(src_page);
	void *dst_vaddr =3D kmap_local_pfn(pfn);

	memcpy(src_vaddr, dst_vaddr, PAGE_SIZE);

Because kmap_local_page() creates a direct or fixmap mapping, it is
inherently writable and bypasses user-level read-only permissions.  Could
this allow an unprivileged attacker to map a read-only file, pass it as
uaddr, intentionally trigger a CPUID validation error, and cause KVM to
overwrite the physical page globally?

[Severity: High]
This is a pre-existing issue, but is the unmapping order here violating the
strict LIFO requirement for local page mappings?

The kmap_local_page() and kmap_local_pfn() mappings are created in this
order:

	void *src_vaddr =3D kmap_local_page(src_page);
	void *dst_vaddr =3D kmap_local_pfn(pfn);

But they are unmapped in the same order:

	kunmap_local(src_vaddr);
	kunmap_local(dst_vaddr);

Unmapping the older mapping (src_vaddr) first causes kmap_local_idx_pop()
to incorrectly decrement the kmap stack pointer.  This leaves the newer
mapping active but marks its index as free, which could allow an interrupt
handler to overwrite the active PTE.  Could this also trigger a
WARN_ON_ONCE in debug builds and crash the kernel if panic_on_warn is
enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inpla=
ce-conversion-v7-0-2f0fae496530@google.com?part=3D20
