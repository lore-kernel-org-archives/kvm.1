Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB33845AC;
	Fri, 17 Jul 2026 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784304724; cv=none; b=dFnhvSYuHLjCqKSYRon05941xShbBUnoR1zKYRivDgt3RtRdXP3uBXXTkEAU/jpByfUo/iKSlfwfi6S7irZCMpsrmKDdCTv9kkdcwrJDdvRCiDLLt7CMQr5/2Wv3jQ4DMsRImyws9MCENC5644guIKy0MUBdOC4miFa7oC7iX2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784304724; c=relaxed/simple;
	bh=SEN/YeVMsxQtS7bmwpsfCTPZCAfGz7/VhnW49BhQgAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IrHSjCqU62PxtHXtSZLuU6UAv7JT0mQqCfQlXc1p16X7CvFfRztFZuUfh07zPRQsMUIwtF84Zss6ol39Jx7z4qe4gDH8czm1omKxIuJlKFKgQTlCIB4IhFBheX8EDdwZPAxsef7s8fqIHf0a7/VdmcEbZOyCLDIxg3yhvOMZKSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKwmtxA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKwmtxA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294A91F000E9;
	Fri, 17 Jul 2026 16:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784304722;
	bh=UBD5yB8QIwgb8/LoWSnAjYgoqm58BFAYbzBEn94/G1g=;
	h=Date:From:To:Cc:Subject;
	b=BKwmtxA6ztStMVuuuKwFvbwirs9pW653fLedz1zHe9O5GMLyb7wR5nh42tHsp6ZyH
	 kOvIejH73TOVCN+unPwa0o9/DbVzUDhrIzA+y0I/yaHlI6YOQI7YJY7MG8VwclxWFD
	 R1DuTDnFsQ61RUGtoxZSBGV0isQ38xY150qv41CemchOYq91k78X75XHI+NTbI1siK
	 7T6zl0PFMmydZCQPIORtFvryD9XIuD40Yj5vh4CoSF4kByv63WZxCw9yWuO6s8wQnY
	 c3Y+VTm/GKSk+Boev/+djX70c+psFmrVrlZvEWtGYzopTu8o8XUIHhxsSxA4U7wQ43
	 HOo5HgyV1hOBg==
Date: Fri, 17 Jul 2026 17:11:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Sean Christopherson <seanjc@google.com>
Subject: linux-next: manual merge of the kvm tree with the tip tree
Message-ID: <alpUTu5ttdBcjZCP@sirena.org.uk>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yEMEG4PtvOkWsDVy"
Content-Disposition: inline


--yEMEG4PtvOkWsDVy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/kvm/x86.c

between commits:

  3eaa50e1e255e ("x86/cpu: Hide and rename static_cpu_has()")
  1620ddc0dcefc ("KVM/x86: Stop using 32-bit MSR interfaces")

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

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index c230b18d87e38..764cda8045a17 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -2579,9 +2579,9 @@ static void kvm_probe_feature_msr(u32 msr_index)
=20
 static void kvm_probe_msr_to_save(u32 msr_index)
 {
-	u32 dummy[2];
+	u64 dummy;
=20
-	if (rdmsr_safe(msr_index, &dummy[0], &dummy[1]))
+	if (rdmsrq_safe(msr_index, &dummy))
 		return;
=20
 	/*

--yEMEG4PtvOkWsDVy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpaVE0ACgkQJNaLcl1U
h9AaDAf/Umw/i22hIiN+2r6CNNZMbdXh5JMfavq0YXwFZ1TtREWHTXgl6RE7IYyH
pLr6fuPGlbvjZH5oOZ6lflQFuUwqW+mKiaWGQIXX8XRYJff16rdnsws5lhGizXDP
qSUY5rPjwex/OiNhjk37luLSxnMtevHGoncmLxn0xwzCe5a6CPWSUdstttBot7lt
g7NeIHwVicZX3oEcIWpgJ0nwWipieNMRipBxOyqFI8T1v/Poj91B2SqUlpx2CUug
HJDZfRC6CUHnSPwYdMaD+na9bLAKSmIbP82kIU1hNvVzVjqG+BcsofqEfaFtKdJG
M8OOqCPMduKgiVjft71IooluV4/p2w==
=dgoq
-----END PGP SIGNATURE-----

--yEMEG4PtvOkWsDVy--
