Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA24471D1E
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142644; cv=none; b=fwOZb2jQwprkY5F1pm5DAZWKMoF74rA3eFmBnKAcINHRFYGZKP4rz38CKbzMJZVZWE8CwzUY8/ZKDsHuKjECbr99i7YlIPHXbrnHt0eoI6YdwC+m8jjuvxRWm5Vw/AHQAIt91KCXl/H3kUi7iNeDb91ABUiEY/E7T4TltW7KzAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142644; c=relaxed/simple;
	bh=tMlphX1srqSmwkm/I2q1GT1VN1k8XsQkkzVMJnc0xjU=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=S+EYrSc/qZxU1SpSqL7LSgFWUoGHJjbBdeawo6+WpxDeQrM2LMKq4WfYcZM96mM92gXzBD0lOFKw5k/2EJrVr3VCiC/ZcyxYIyMWWp61EXnKv170WrvIYs67gEd7UjiJjFtBOHc1z1r0YLpE3b9EW/mRKX3zBDur80aTLBDNv+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKRwxDg/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKRwxDg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95501F000C4;
	Fri, 16 Oct 2026 09:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142643;
	bh=Fpgm6bCQCM5yiihqrZPr3RxfiI4wATnSEI/iDPpKImk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gKRwxDg/HVAOGzUZ0F+MTAW4ZKC9dEK2MiPCu9gvIO7wHEn/faatJU0HigHiJbYKs
	 xkc7S9tbA4+//gc6mMILlPXRMetZL0+1Le4k9Bc6QnhProWN/9GW6R3NB2jxA/fGsS
	 PvNm5zfVzq2z4b7EDZoBQbfb+k2OXNEaCMEEaZyWw4KHon8JldRcF0cnbwaqUB0zso
	 TTxkwEa2+mF2M5KyM/5kjpMUtbvpeL0G0DAg86G0F1y1oDtmVVBrDlTCS8633GeBDP
	 FWrNAR1ppkBTKk4ofdUNSIsNV4KcaDIMBws1cs8owq7b3s0TmuF6khEW+ZaSnvNhkc
	 48Z0e0WTre24g==
Message-ID: <sashiko-outbox-174077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] KVM: TDX: Validate userspace CPUID input for
 KVM_TDX_INIT_VM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Wu" <binbin.wu@linux.intel.com>, kvm@vger.kernel.org
In-Reply-To: <20261016091422.3182216-6-binbin.wu@linux.intel.com>
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-6-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 09:24:02 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: KVM_TDX_INIT_VM rejects CPUID.0x7.0.EAX breaking guest sublea=
f enumeration
- [High] mm: heap buffer overflow in setup_tdparams_cpuids() via unbounded =
td_conf->num_cpuid_config
--

commit 8ec54e6006917e96837000de9e4002c7f4499444
Author: Binbin Wu <binbin.wu@linux.intel.com>

KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM

This commit validates the CPUID configuration provided by userspace
through KVM_TDX_INIT_VM against KVM's TDX allowlist. It drops the
hardcoded denylist-based check in favor of a strict allowlist.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index e53f1e98bb04a..80c6519c13ff5 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
[ ... ]
> @@ -2567,6 +2548,14 @@ static int setup_tdparams_eptp_controls(struct kvm=
_cpuid2 *cpuid,
>  	return 0;
>  }
> =20
> +static bool tdx_has_unsupported_cpuid_cfg_bit(const struct kvm_cpuid_ent=
ry2 *e, u32 index)
> +{
> +	return (e->eax & ~tdx_get_cpuid_cfg_mask(e->function, index, CPUID_EAX)=
) ||
> +	       (e->ebx & ~tdx_get_cpuid_cfg_mask(e->function, index, CPUID_EBX)=
) ||
> +	       (e->ecx & ~tdx_get_cpuid_cfg_mask(e->function, index, CPUID_ECX)=
) ||
> +	       (e->edx & ~tdx_get_cpuid_cfg_mask(e->function, index, CPUID_EDX)=
);
> +}

[Severity: High]
Does this strict allowlist check inadvertently break guest subleaf enumerat=
ion
by rejecting valid KVM_TDX_INIT_VM inputs?

CPUID leaf 0x7 subleaf 0 EAX contains the maximum supported subleaf index,
which is non-feature information. However, tdx_get_cpuid_cfg_non_feature_ma=
sk()
completely omits leaf 0x7, and reverse_cpuid does not track 0x7.0.EAX as a
feature word.

Because tdx_get_cpuid_cfg_mask(0x7, 0, CPUID_EAX) returns 0, this new check
will reject any non-zero value for CPUID.0x7.0.EAX. This strictly requires
userspace to provide 0, effectively preventing exposure of subleaves 1+
(such as for AMX or AVX-VNNI) and breaking valid VM initialization requests.

>  static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
>  				 struct td_params *td_params)
>  {
[ ... ]
> @@ -2596,7 +2585,7 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 =
*cpuid,
>  		 * not the index of the userspace entry, which may differ if
>  		 * KVM_CPUID_FLAG_SIGNIFCANT_INDEX isn't set.
>  		 */
> -		if (tdx_unsupported_cpuid(entry, tmp.index))
> +		if (tdx_has_unsupported_cpuid_cfg_bit(entry, tmp.index))
>  			return -EINVAL;
> =20
>  		copy_cnt++;

[Severity: High]
Can the loop enclosing this code write past the end of the td_params heap
allocation?

td_conf->num_cpuid_config is read from the TDX module and bounded to 128
by KVM in get_tdx_sys_info_td_conf():

	if (sysinfo_td_conf->num_cpuid_config > ARRAY_SIZE(sysinfo_td_conf->cpuid_=
config_leaves))
		return -EINVAL;

However, td_params->cpuid_values is an array inside a union with
u8 reserved3[768], which limits it to 48 tdx_cpuid_value structures:

arch/x86/kvm/vmx/tdx_arch.h:struct td_params {
    ...
    union {
        DECLARE_FLEX_ARRAY(struct tdx_cpuid_value, cpuid_values);
        u8 reserved3[768];
    };
} __packed __aligned(1024);

td_params itself is dynamically allocated as a fixed 1024-byte object via
kzalloc_obj(struct td_params) in setup_tdparams().

If the hardware returns a num_cpuid_config value greater than 48, the loop
in setup_tdparams_cpuids() will exceed the 48-element capacity when assigni=
ng
value =3D &td_params->cpuid_values[i] just below this snippet, causing a he=
ap
buffer overflow.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016091422.3182=
216-1-binbin.wu@linux.intel.com?part=3D5
