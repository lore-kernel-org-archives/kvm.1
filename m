Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EFF478E34;
	Wed,  8 Jul 2026 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522752; cv=none; b=BpCqNyJgz/J5uSzN1l788MWmMe2soZeeKVLEk+qzCp7B2GO8tRo2QxMt5/adgsKJ5x9vsaZZh7Qmad9tdhJIDU1OciPckStixh/4E6ySnvTguzC+cqxtGarwTex/EayeaUOXlo1YTBoEW/V9sl4KTnNB0Gr07t6Z5ELUFHcb5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522752; c=relaxed/simple;
	bh=05AHI6Vhp/bYM1HyqjMw2iXuHjrGJkj8PpeUiCG0Fw4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U0yuF7TveXb9UIMpIdj9+cdmxHY0hkfd0mAeHmHjDZTk9Fbnrk3usWxfyVBXl4LYQvlzr2c4Y4hmb5OO1MCAt96p6UOnIaOkiUrEszWVQhZ4q+K4ZPhUEXVbDb/WhGhQ4wSHHGi3F1CdlEoTrhyGzGwdXfA/5H79eMRr9NIPA5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4pb3NCz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4pb3NCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804A71F00A3A;
	Wed,  8 Jul 2026 14:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783522751;
	bh=Yc4gH+LdZe31xJj2/SF6H7jjMkBqTkSgH7335y09abo=;
	h=Date:From:To:Cc:Subject;
	b=j4pb3NCzE2KYj0BnotgMRVHplOeGQ2lq0YknFNu5aB75JE/EOSkmE/nzuOtlq6zHy
	 Cxx0J0yVkMGqRJEY2zxIrMH0PEEYGZvnPN3G/eTEWRUBMNuaYr1oDiCQNmGkM5Dl/p
	 kM4m7XE9agnUKi07qHcFkG1eWYwJJpcIuPIkamNtusbm5U66EDAdqN8Yt8HggL9umg
	 cMzcHW036uYykVKDWRcsgeeApHWsAO6E2qJPCxn4Fr8qZHshIeRuLvuHs/h7yA3ew4
	 Q7OTW6j7VuVYL8AOw6HTIiz08x9BImx7b01mVV47YTM8RvyfwhNTmJs88+uH6lqO6k
	 IsmJvT6EVuI1g==
Date: Wed, 8 Jul 2026 15:59:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Sean Christopherson <seanjc@google.com>
Subject: linux-next: manual merge of the kvm tree with the tip tree
Message-ID: <ak5lu6XQP6PPtQ6u@sirena.org.uk>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fwrjQWqNW7aG2FoX"
Content-Disposition: inline


--fwrjQWqNW7aG2FoX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/kvm/x86.c

between commit:

  3eaa50e1e255e ("x86/cpu: Hide and rename static_cpu_has()")

=66rom the tip tree and commit:

  7a26830801584 ("KVM: x86: Move the bulk of MSR specific code from x86.c t=
o msrs.{c,h}")

=66rom the kvm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/x86/kvm/x86.c
index 63daa4dfa23ad,0626e835e9eb7..0000000000000
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index c230b18d87e38..861d04bfa63dd 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -651,7 +651,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_d=
ata *msr_info)
 	if ((efer ^ old_efer) & KVM_MMU_EFER_ROLE_BITS)
 		kvm_mmu_reset_context(vcpu);
=20
-	if (!static_cpu_has(X86_FEATURE_XSAVES) &&
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVES) &&
 	    (efer & EFER_SVME))
 		kvm_hv_xsaves_xsavec_maybe_warn(vcpu);
=20

--fwrjQWqNW7aG2FoX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpOZbsACgkQJNaLcl1U
h9AdxAf7BZO6f6puPeGQRTJ6k0YvV/m0lD7wTg0TL2MpkK2s3lFDPsAgXaOGFzHT
oADfjYgyee5+m+yhJqbV8tgzAy5qXwuMFFMix+waf85VC05TqTl9qFujY3bgttGf
ZughSO6RKs+SSPX6QlxdYxZlbHN9IoOEVeTLwotwj/lGw78t3pJ1ANAoUUwKxyvI
l0wgMyeqzJlR1cu65zQaOfXsFJm0Wle5OqbKWqtP+4aJWRlPzNm0SNYbHDQGrHHP
7anEbguNC+hzcmiW21ZpD/arbxFNrNs5ypMQt3+kiNgeX+Jb9AeAMvLEdu+fPWyO
ZYNbt0mhqTqG2Td76BjQXiGfyfhpJg==
=EvRN
-----END PGP SIGNATURE-----

--fwrjQWqNW7aG2FoX--
