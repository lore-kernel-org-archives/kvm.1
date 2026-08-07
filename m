Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28512F8E86;
	Fri,  7 Aug 2026 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113423; cv=none; b=foBQ4Pyox9KkizGI7Ant7+eSsjQa9BUPmqRqwhpN87GBUJbc6uz1701YmfgAd7Q4+ZSCCSqrrCGHMYd/FLkpx/QiboTF57G7wi6rbI7C0heZrA5bXQwCyrI1ks0ZOvSKXf0ueY/EMUlvfuNkr0sZKDL4ntFKLiO7sVXXXK9Ahug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113423; c=relaxed/simple;
	bh=AcG/mHbl0tdveN2aTwIeoLBrQKPikZGp7Mg2i8F3ekc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=en0ni+R7aIzIChha5vanpHL/T1uSUEtTScIdjTU1YAZ5KArpVa3ZoaIXoB/fgWOwEvK4tvP25Hju67nVniK5vyoz/mMXqKNrOIYg4UD6RJ/NcN/ekF85EHfMnUSypvOk0O5udLtY62FQSyebAn6KUh9pUrVqhoDaQelWawYGhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE6YxHWF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE6YxHWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A16A1F000E9;
	Fri,  7 Aug 2026 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786113422;
	bh=RxUlCeB9O2aqfowvaH7/dR8e2Z1foRTum1v/OE+CMyg=;
	h=Date:From:To:Cc:Subject;
	b=TE6YxHWFp3KHL6ERC29i2t7yJMIG33unPldRNT56Sn1y9ZGChWHq5q8j76bFhl1E8
	 RZFgaufrKj2JszOCmEkW+tPrsvP9NqP9SeS8RHvfRfKct+zHIlAE+nENFoqN0cd95b
	 21/xTvqWUfdct4/RbSGcrw5GW24lnT62zxH8Acbqlfo+vUvKurXlv8CQ7CB1ItCe0f
	 hnN5q10o/yIrSwW3eyn3bdGgZZkpeiwBnm+UMkNKjf2hgcEYWVtgmxJDLayYBfZh7y
	 U9m8A/wApomTgn8wjaNarZN0k7sMzv2lTbH1HgS5jctp7zfsrj8BI3Q0t/4e9CwAKe
	 ptZz0j9dFAPMQ==
Date: Fri, 7 Aug 2026 15:36:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the kvm tree with the kvm-fixes tree
Message-ID: <anXthnEjE2hw5sOU@sirena.org.uk>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R+ok7wGema/NyXMg"
Content-Disposition: inline


--R+ok7wGema/NyXMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/kvm/mmu/mmu.c

between commit:

  26505e1b5b546 ("KVM: SVM: make svm_flush_tlb_gva do a full asid flush if =
NPT enabled")

=66rom the kvm-fixes tree and commits:

  148fe965df16a ("KVM: x86/mmu: unify root_gva_walk and ngva_walk")
  0a59a8b8a248e ("KVM: x86/mmu: pull struct kvm_pagewalk out of struct kvm_=
mmu")

=66rom the kvm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/x86/kvm/mmu/mmu.c
index c9e4739b26d71,6c13da942bfcc..0000000000000
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@@ -6652,9 -6672,17 +6695,17 @@@ void kvm_mmu_invalidate_addr(struct kvm
  		if (is_noncanonical_invlpg_address(addr, vcpu))
  			return;
 =20
 -		kvm_x86_call(flush_tlb_gva)(vcpu, addr);
 +		kvm_x86_call(flush_tlb_gva)(vcpu, addr, NULL);
+=20
+ 		if (tdp_enabled)
+ 			return;
+=20
+ 		mmu =3D &vcpu->arch.root_mmu;
+ 	} else {
+ 		mmu =3D &vcpu->arch.guest_mmu;
  	}
 =20
+ 	/* Invalidate shadow pages, whether GPA->GVA or nGPA->GPA.  */
  	if (!mmu->sync_spte)
  		return;
 =20

--R+ok7wGema/NyXMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp17YUACgkQJNaLcl1U
h9AVUAgAgIX5tIYRaJG9B3m89By7oIhCs35oJAjtcCHQSTkB0jR7Vz64ClLVnxPF
hav9G+s/hWf3sTzHmJBt1y2h3fDlK7EVzFxFaEJ3cxIYlqFNP0ye2XdmcqKo2zns
m3JYnhfBv+oDfKNZhuTfBay26PXrkUfcHrtS8aIj9eaSXgAyAQ1LRCTJp1rEtbyH
V7Go0ju+/82eEGpb+kSIKZe331K05Oh+wJ7v9ll1XP0naGIflL+4Lv0SfC7HoNCf
S/kBsVeMGwYL13ADn8sbVHlyRwSUSHug1ZC4VKRuZBdruLm3Qs9KbR6WoAU7CXL+
svh4d/D79I77wwPrxbxjaVz1pxD6Fg==
=yEOi
-----END PGP SIGNATURE-----

--R+ok7wGema/NyXMg--
