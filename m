Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1E37A842
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219342; cv=none; b=cdRsnb99Aj+n4OzWZndSFTTL0PQYn1xc0GDGBcR/uysZBD43J8qfaNO4sAz1ixp0kG/HncN5RI/Q4zhaK/MvQ1n8DA/VxDlLIDuv6C4vXG+1AouWEbzkYT2iYUP4O4vfI/TS9WCqJuVPGf0LUb/4ik/bZp0xKWJbwcuugpHEkEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219342; c=relaxed/simple;
	bh=PnBiw7chvC39Dh+aQO4x8W6kdEV3BbrKsWiZ2ZiAAR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GeaHwPwnvObxQsSFKXrHgNfMLmT5kY+rvywHFrrW/khLVyfXY9Hg6opxbOCOYMZAXToAVddm7tl87AKk4bkSH2MRDYwId9izaJ/lz7ig2DJ+JYTizwOddnJ1AhaFjAkQDtlsFkLWty6M7RJoIvJNFBz+AyN9Pjw/ubBGFnC2Ndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0aO2kbn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0aO2kbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8131F000E9;
	Thu, 16 Jul 2026 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784219340;
	bh=YjO+DtxmEHb3w375ehsEa1TX1B84rcw09MRl92YOWNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F0aO2kbnSrso0ouFUuqxlUpfFfpok2GKzur4mG+gUOwhXh24Bkio4o6Clydisyt8/
	 XEOGq4PRwkGGgczYrGJpjpLBmt6Cc46SX7f+1iO/jsmxhpYPKzewl+fyuZCwcI36vR
	 I9JL4o4cYE2yGoVbGuFsK+1rB2yXIWgzvSWjGEeAmsXo3lPWCOlIBmAqcVhfcz2U7h
	 AHIyC0r4xxEdjdTKU3Z15fmSodJlPWH09H9V6eqrbGnIS3e2+/0jp3Aa9y7RPywv6/
	 H2Qciw0OmSdyqxcQ0BLe4U1k6MAADA2WABD1E/3qXDwEFj/q4wQ+GkapQWdYGrUbdL
	 DaMlAem5e2tTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU
 creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmytro Maluka" <dmaluka@chromium.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716160801.3155582-1-dmaluka@chromium.org>
References: <20260716160801.3155582-1-dmaluka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 16:29:00 +0000
Message-Id: <20260716162900.9D8131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch fixes a use-after-free in VMX IPI virtualization cau=
sed by KVM_CREATE_VCPU destroying a vCPU on duplicate ID, but fails to fix =
the exact same issue in AMD SVM AVIC.
--

--- Patch [1]: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU =
creation ---
commit c59610ef1e5c50c0016e2a7b4db23402a3147ffa
Author: Dmytro Maluka <dmaluka@chromium.org>

KVM: VMX: Postpone IPIv setup after successful vCPU creation

vCPU creation in kvm_vm_ioctl_create_vcpu() may fail after
kvm_arch_vcpu_create() -> vmx_vcpu_create() already succeeded. In such
case kvm_vm_ioctl_create_vcpu() destroys the newly created vCPU in the
failure path. However, that leaves a side effect: the IPIv pid_table
entry remains configured with this vCPU's pi_desc address.

> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kv=
m-x86-ops.h
> index de709fb5bd76a..6a731cab9fb31 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -24,6 +24,7 @@ KVM_X86_OP_OPTIONAL(vm_destroy)
>  KVM_X86_OP_OPTIONAL(vm_pre_destroy)
>  KVM_X86_OP_OPTIONAL_RET0(vcpu_precreate)
>  KVM_X86_OP(vcpu_create)
> +KVM_X86_OP_OPTIONAL(vcpu_postcreate)

[Severity: Critical]
This isn't a bug introduced by this patch, but does this exact same
vulnerability exist in the AMD SVM AVIC code?

It looks like the SVM code suffers from the same use-after-free pattern
when userspace creates a duplicate vCPU ID.

In arch/x86/kvm/svm/avic.c:avic_init_backing_page(), the newly allocated
APIC backing page address is written into the VM-wide hardware IPI table
before the vCPU ID duplicate check:

    WRITE_ONCE(kvm_svm->avic_physical_id_table[id], new_entry);

If the vCPU ID check later fails in kvm_vm_ioctl_create_vcpu(), the
new vCPU is destroyed and kvm_free_lapic() frees the backing page:

    free_page((unsigned long)apic->regs);

However, the AVIC table is never updated to revert the overwrite.
This leaves the physical address of the freed page in the hardware table,
which could cause a hardware use-after-free if a guest subsequently sends
an IPI to that ID.

Could we also implement vcpu_postcreate for SVM to postpone the AVIC
table update, or do we need a separate fix for AMD?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716160801.3155=
582-1-dmaluka@chromium.org?part=3D1
