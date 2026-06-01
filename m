Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C82392C2C;
	Mon,  1 Jun 2026 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333180; cv=none; b=FotwF84TvXJwQ9VOlzayI/01Yq5bQMmVVolAnkuhB6wRvzXPivsvTRCCkEfjYz9zLR/jqdv/FEpxBSJwrI+8jGhc49dKk6dhK3AnxsifzMOseLZN8sMFenk6l5T8cKZ0zk05fHOuPkzxD1EiZIA+DxHeg1ZNsC7S+xtK0GEzBlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333180; c=relaxed/simple;
	bh=7+W7A/iCUFdV7o/RwZl5GjCiYYvn3t+ukiQndMRFjbo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rUaG/EwXlrXf16xJ6wCykloFSYPucyPXT4QicsBKn83g236orcLSFQNPt88QLP5kJM+S1g20Q8cHaXJ90BJ1Zq5pWU368SVvfko29K5LA69VP1abez5PRrGFZ8q3/VBfGj2xkkPDTzLrmmIgVt8bE2FDMv50Ngr7aQVOqwSnx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1P5OvuE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1P5OvuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6B01F00893;
	Mon,  1 Jun 2026 16:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780333179;
	bh=Dl//ADrhGnwbvKZKpYGzjN2yfPuCsGneKL+WlC5Dojc=;
	h=Date:From:To:Cc:Subject;
	b=U1P5OvuELPnqBY8nADqS8U+HGQDY+wkmlekWeLLOBt13b2IECGpqTrziIlhou1nxE
	 wWFhlCPXgWkrwyTXWQQvB59qqXuWNXA1OhVU7QYP8qPV8jinHKLLuXxaZRCHXo9kmd
	 X3k8CtHxAN6rcItURHO5fviPY4BlJwKUz4yPGMHHrQJGXBED1etE2vzY22zPIO0Lhd
	 NGdAjyxphoCxG4DKXvovhBi1juSofqoztz9i4pqjOHoGg5znaKxtFI7lDmAR/lzYKu
	 81Lh5/XEF8TQqUwaxOn5hXTNzaOx6DfveNryrNkYBs1fNrUmJJk0lOomDeEU5CwQlU
	 fJB/soODol5UA==
Date: Mon, 1 Jun 2026 17:59:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>
Cc: Emily Ehlert <ehemily@amazon.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Sean Christopherson <seanjc@google.com>
Subject: linux-next: manual merge of the kvm tree with the origin tree
Message-ID: <ah26dyqFIP006NTt@sirena.org.uk>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5W2flVS5uYSL/Dn+"
Content-Disposition: inline


--5W2flVS5uYSL/Dn+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/kvm/x86.c

between commit:

  b60621c5121c9 ("KVM: x86: Fix ERAPS RAP clear on INVPCID single-context i=
nvalidation")

=66rom the origin tree and commit:

  e31de5791093d ("KVM: x86: Drop the "EX" part of "EXREG" to avoid collisio=
n with APX")

=66rom the kvm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/x86/kvm/x86.c
index 0550359ed798f,48f259015ce44..0000000000000
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@@ -14330,7 -14309,7 +14316,7 @@@ int kvm_handle_invpcid(struct kvm_vcpu=
=20
  		 * the RAP (Return Address Predicator).
  		 */
  		if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS))
- 			kvm_register_mark_dirty(vcpu, VCPU_EXREG_ERAPS);
 -			kvm_register_is_dirty(vcpu, VCPU_REG_ERAPS);
++			kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS);
 =20
  		kvm_invalidate_pcid(vcpu, operand.pcid);
  		return kvm_skip_emulated_instruction(vcpu);

--5W2flVS5uYSL/Dn+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmodunYACgkQJNaLcl1U
h9BiEgf/XhErtfezKjqknMO641rzYqBNWABH0iRPIUd1+w/uxoL+DKjNk6fcAPq8
szNwm8pWFBF0Tvin0AEW+j1BhKsKc8PkwA0IxYrIqKV8JRJp8nTo+EkAiZmmaGp2
/DRob8ZMxwghKaFYpft0FDk/PEh812BQb9vvA1ymJOIAJZ8niwWn9rfHaoODnz6m
2bKk06rO4Kw7AAzUoaU4nqRlqvOcXlSYcOr2XTBIyYAkHKXIb61j5PIJYpqvX5WO
Ux4wc2Kzz3SbtF7OFHCzAfTfaRgYpure9ytPLcU5wxUkTHrRh9nhtLIKfz/5cJEw
QKg6hdC/nxNtmujsj0+VeVyCuB0Fog==
=Glwc
-----END PGP SIGNATURE-----

--5W2flVS5uYSL/Dn+--
