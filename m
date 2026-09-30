Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932804E0B98;
	Wed, 30 Sep 2026 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773818; cv=none; b=Y3mF7jW0On7We20Sno3X88OG5mhRLsNDaAQm0bGy2G2PnlttoVGkhkSDmnrt2Hm88HitDwOKOceeWzmjwpLV368D6cJMli8b1TGHx9Vxc+3UMQfa+YeMI1GFBlSzZCYqEayJGhklRP8y7W9c8uf9b9nMFQbQ3tACyfEPgzXJ/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773818; c=relaxed/simple;
	bh=x9BFXEUD38TmCalVEpv6QvinZ4CzTIuDOIZA1ZhZtLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hLDAF60/HKIdMYlu9Igz04PRBt2lcu+3Z/RrDmw5597M+3SGk5EdaQ4r3LnqNDWVtEOtCqPfs62v6XvKFGn4zfHO+f3tTLrT3/G39r3De198uI7MOrMQlKOOXziqtxnsIMu5K0p5sJFf34EBGjVHRwVhcxCHuc5g50fCJnuhxJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlKALZ1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlKALZ1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B771F000FF;
	Wed, 30 Sep 2026 13:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773797;
	bh=pgseS9kkS3c6pxTUn2rM8YX89VhD5mi3D8vHosAISJE=;
	h=Date:From:To:Cc:Subject;
	b=UlKALZ1FHkMjEV60LnlS2oBmWdDcq8OJBDraBRVw8vRoQwMpRx2ZX20vm9dAW7q77
	 E/uxWoDzyBD6ciEuOM97LdgTH65wNjbC+Z5TEhuJH83p2ix8KdROrsgj6w7Awzyz6I
	 MW/ZK2tLmnvcRNZGVsJrHYgXmR9VbK3I7aLca+1PBlBlyMdvHgf8VZWxVUNg6O/rKy
	 IRQ9FUtk1huzVTGBo2nbQp+Qnl+6J5ZKqZfrJwvd9C24IbjoEdBx1kY2O/prkMY3FV
	 DZua+0OVFYcqztdciFHfopQbbfhsSy+eAD1cqYMqLutPvUwg3z+e4eqd1XqTMCF4St
	 RtuwGx7i66udg==
Date: Wed, 30 Sep 2026 14:09:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: KVM <kvm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: linux-next: manual merge of the kvm-x86 tree with the kvm-fixes tree
Message-ID: <ar0KIZ8HQEfIRvVJ@sirena.org.uk>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ivdqjJPsbVNhrDm6"
Content-Disposition: inline


--ivdqjJPsbVNhrDm6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-x86 tree got a conflict in:

  tools/testing/selftests/kvm/x86/nested_x2apic_test.c

between commits:

  b630929bcc4c8 ("KVM: selftests: Extend nested x2APIC test to validate dis=
abling x2APIC virt")
  b0bc51910f039 ("KVM: selftests: Extend nested x2APIC test to validate usi=
ng eVMCS for vmcs12")

=66rom the kvm-fixes tree and commits:

  9b2f8146fcef9 ("KVM: selftests: Extend nested x2APIC test to validate dis=
abling x2APIC virt")
  a4bab1c12fd52 ("KVM: selftests: Extend nested x2APIC test to validate usi=
ng eVMCS for vmcs12")

=66rom the kvm-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined tools/testing/selftests/kvm/x86/nested_x2apic_test.c
index ce204ce29a9c0,2ae698c9aa1ce..0000000000000
--- a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
@@@ -61,57 -61,55 +61,57 @@@ static void l1_vmx_code(struct vmx_page
  		evmcs_enable();
  	}
 =20
 -	prepare_for_vmx_operation(vmx);
 +	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);
 =20
  	if (hv_pages) {
 -		load_evmcs(hv_pages);
 +		GUEST_ASSERT(load_evmcs(hv_pages));
  		current_evmcs->hv_enlightenments_control.msr_bitmap =3D 1;
  	} else {
 -		load_vmcs(vmx);
 +		GUEST_ASSERT(load_vmcs(vmx));
  	}
 =20
  	prepare_vmcs(vmx, NULL);
- 	GUEST_ASSERT_EQ(vmwrite(GUEST_RIP, (unsigned long)l2_guest_code), 0);
+ 	vmwrite(GUEST_RIP, (unsigned long)l2_guest_code);
 =20
 -	control =3D vmread(PIN_BASED_VM_EXEC_CONTROL);
 +	control =3D vmreadz(PIN_BASED_VM_EXEC_CONTROL);
  	control |=3D PIN_BASED_EXT_INTR_MASK;
  	vmwrite(PIN_BASED_VM_EXEC_CONTROL, control);
 =20
 -	control =3D vmread(CPU_BASED_VM_EXEC_CONTROL);
 +	control =3D vmreadz(CPU_BASED_VM_EXEC_CONTROL);
  	control |=3D CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_TPR_SHADOW;
 -	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
 +	GUEST_ASSERT_EQ(vmwrite(CPU_BASED_VM_EXEC_CONTROL, control), 0);
 =20
 -	control =3D vmread(SECONDARY_VM_EXEC_CONTROL);
 +	control =3D vmreadz(SECONDARY_VM_EXEC_CONTROL);
  	control |=3D SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
  		   SECONDARY_EXEC_APIC_REGISTER_VIRT |
  		   SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY;
  	control &=3D (rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2) >> 32);
 -	vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
 +	GUEST_ASSERT_EQ(vmwrite(SECONDARY_VM_EXEC_CONTROL, control), 0);
 =20
 -	vmlaunch();
 -	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_CPUID);
 -	vmwrite(GUEST_RIP, vmread(GUEST_RIP) + vmread(VM_EXIT_INSTRUCTION_LEN));
 +	GUEST_ASSERT(!vmlaunch());
 +	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_CPUID);
 +	GUEST_ASSERT_EQ(vmwrite(GUEST_RIP,
 +			vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN)), 0);
  }
 =20
  static void l1_vmx_code_part2(void)
  {
  	u64 control;
 =20
 -	control =3D vmread(CPU_BASED_VM_EXEC_CONTROL);
 +	control =3D vmreadz(CPU_BASED_VM_EXEC_CONTROL);
  	control &=3D ~CPU_BASED_TPR_SHADOW;
 -	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
 +	GUEST_ASSERT_EQ(vmwrite(CPU_BASED_VM_EXEC_CONTROL, control), 0);
 =20
 -	control =3D vmread(SECONDARY_VM_EXEC_CONTROL);
 +	control =3D vmreadz(SECONDARY_VM_EXEC_CONTROL);
  	control &=3D ~(SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
  			SECONDARY_EXEC_APIC_REGISTER_VIRT |
  			SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY);
 -	vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
 +	GUEST_ASSERT_EQ(vmwrite(SECONDARY_VM_EXEC_CONTROL, control), 0);
 =20
 -	vmresume();
 -	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_CPUID);
 -	vmwrite(GUEST_RIP, vmread(GUEST_RIP) + vmread(VM_EXIT_INSTRUCTION_LEN));
 +	GUEST_ASSERT(!vmresume());
 +	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_CPUID);
 +	GUEST_ASSERT_EQ(vmwrite(GUEST_RIP,
 +			vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN)), 0);
  }
 =20
  static void l1_test_x2apic_intercepts(void)

--ivdqjJPsbVNhrDm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq9CiAACgkQJNaLcl1U
h9C7xgf8DPs0ImNSHJrqqyeVQJafBADppmLTL30DvHgHMXW0zzxp42m7HjBCH08X
qCyreHX2TukpjV+xYE3iwgBdutI+wSs6d2VqthP74bQ9b/h+BNNI7dGWUWhZ+rcD
wYV6UWXpV+tzHK4HZ4OJQX/qaWFxLl/RnvW8tXgSvJXWtrCimeRu+9Z5KJcJsq4P
M+EiTBzUwKykaBlHH+bHIHVbcFtS8SqvmYtNSbPT8zIDNQWtHlfeFNPUGCjp49be
PTSDbcUKI3DTKXh6ungsy+R4BaZdgE3lPZhWGT2E2b/Ycmf5PCkhqd1hRYfOBpwg
+B3NGM0Uzhdn1tQ+ow6oDxzRghcaCg==
=hegf
-----END PGP SIGNATURE-----

--ivdqjJPsbVNhrDm6--
