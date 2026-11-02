Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644089;
	b=iu56sJE3gQ3KD+cdDZmnj14nyQ5KEa7URhW+ohSX1anckFU4EB49NS782K9O6L7H9xQ7
	 LyfTWwbTqtEacEN4HBSx7tpBV/RsG3ewVRHgkwnW17jB7TlQvssbsLX0wibKw1Qvtk7JQ
	 f0CC+x6V0un+HUbSlgTht8PGY6nghYOrd8iJ27ikqUweXYpWwzL/vN5GlDJLK7QHJyGy2
	 lQ11CyuijihTrUJTqU9ls2j4Z4w0NRAa7grd13A4SWnKFzdQNx79BwqC3KXn8PJ0mNqJY
	 wjVCsgKhTyzXIVVTjvkSavNJ5IyFZYHRLpAU9Wi3c4Mm/zVWQl7EVYvIZEKKfcYKEsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=McdyJ/MP027j1EhZeeAKiXXI6O5BCnMQwPKtw4OnIWg=;
	b=H9TDoqEHCAj6N+R2dpqK2vFVJEH5FcNqkOlS49asA9v4/+vjzbTpda0lCiH9Hwz2R0gQ
	 1U90CRuuKJNszKQSf3v07qU0xYDFXLX90rI63bMdRr83Aqyy18fySxpU3HuttJyNPqIjW
	 z2iH7YdN1D6422FCr4haaZPKamRoaHgDPwwY7YUHUKsQefS9yH98fZ13Dr8e8prhZO2JO
	 LijkcFHFJNupcsSDw8s5RpChmz4bIcgryTfkUtQbWXErGICEtGxExCJ8Qj3xQdr1QGinl
	 zTnasZxCgFOkqi9bP9UWPnvZNQJcSAO4QOnKAK6CHRlowIto7EWequ43wDg919d/V1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJnuzKep;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF6F606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJnuzKep
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839791F00A16;
	Mon,  2 Nov 2026 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793644088;
	bh=McdyJ/MP027j1EhZeeAKiXXI6O5BCnMQwPKtw4OnIWg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XJnuzKepjon/We3D7B31njLvEz46QTvjJCmDG2qUIlzdgv+B6AGwTVgA8fV61b9/w
	 5ufgJnAGUgDR3O0lak8U6Q0q4+DS9gLJkVnXtNwXkXpnhV5lDvgU0vwkQHSSoxd/wC
	 1gNzNhdjf0z7db3GSteH7MvUv9g08cJ8+hdgJeoS8EeBzuUGIcanhm/1f9E2qAlLfL
	 CH01FhDItmQJ5kFtSh5u6CX8ae/g0TJ8jd/a/lQTHi8FVmDXLYOYtPSu59URtXLj25
	 QKIpkgRWw2L8QmdQszA+Y3BUfnF+lviCPn4Pb4JsOwo8aTruPBgvaoqkTkqa1ZWBbb
	 b/hq4e7zCqhkg==
Message-ID: <sashiko-outbox-193937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 38/45] KVM: x86: mark VM as dead after KVM_SET_SREGS
 fails to load PDPTRs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-22-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-22-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:28:08 +0000
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
- [High] KVM: x86: __set_sregs_common() kills VM when PAE CR3 page is unmap=
ped
--

commit 4ba7fe2bbdbb50dd511abb52c67718a74b2c9c1c
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86: mark VM as dead after KVM_SET_SREGS fails to load PDPTRs

This commit marks the VM as dead in __set_sregs_common() if load_pdptrs()
returns a negative error when setting PAE paging state, preventing the vCPU
from running with stale PDPTRs and an unreset MMU context.

> diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
> index b7c25b16ffcaf..3a11a6d068897 100644
> --- a/arch/x86/kvm/regs.c
> +++ b/arch/x86/kvm/regs.c
> @@ -634,6 +634,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, =
struct kvm_sregs *sregs,
>  			r =3D load_pdptrs(vcpu, kvm_read_cr3(vcpu));
>  			if (r < 0) {
>  				srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +				kvm_vm_dead(vcpu->kvm);
>  				return r;

[Severity: High]
Won't calling kvm_vm_dead() here terminate the VM whenever a PAE vCPU's CR3
points to an unmapped GPA during KVM_SET_SREGS (as well as KVM_SET_SREGS2
without KVM_SREGS2_FLAGS_PDPTRS_VALID, or KVM_RUN with KVM_SYNC_X86_SREGS)?

In arch/x86/kvm/regs.c, load_pdptrs() reads the guest page with
kvm_vcpu_read_guest_page():

arch/x86/kvm/regs.c:load_pdptrs() {
	...
	ret =3D kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(real_gpa), pdpte,
				       cr3 & GENMASK(11, 5), sizeof(pdpte));
	if (ret =3D=3D -EFAULT) {
		kvm_prepare_memory_fault_exit(vcpu, real_gpa & PAGE_MASK, PAGE_SIZE,
					      false, false, false);
		return ret;
	}
	if (ret)
		return 0;
	...
}

Because kvm_vcpu_read_guest_page() -> __kvm_read_guest_page() returns 0 or
-EFAULT, it returns -EFAULT not only for guest_memfd memory attribute fault=
s,
but also whenever the GFN has no memslot (for example, when userspace calls
KVM_SET_SREGS before populating memslots via KVM_SET_USER_MEMORY_REGION, or
on SVM with NPT when the guest loaded an unmapped GPA into CR3).

This also triggers during state restore of a nested PAE L2 guest when
userspace calls KVM_SET_SREGS before KVM_SET_NESTED_STATE (such as in
vcpu_load_state() in KVM selftests). At KVM_SET_SREGS time, is_guest_mode()
is still false, so load_pdptrs() treats L2's CR3 as an L1 GPA without nested
NPT/EPT translation; if that GPA does not map to a readable L1 memslot,
load_pdptrs() returns -EFAULT.

In those cases, returning early and calling kvm_vm_dead() leaves segment
registers and CR8 unloaded, skips the MMU reset, overwrites vcpu->run with
KVM_EXIT_MEMORY_FAULT outside KVM_RUN, and permanently kills the VM. Should
__set_sregs_common() ignore -EFAULT from load_pdptrs() (or avoid preparing a
memory fault exit outside KVM_RUN) and continue loading the remaining sregs
and resetting the MMU as before?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D38
