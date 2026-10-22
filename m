Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669636;
	b=G8Akk97Vz56OKCv9gyWktCylgFqt74+oBtY5OAERb/F1pSWBaAguiU6IQsVVlAxVEh1s
	 HHoHen7PgHVJc40jBiSmsFlyuvQc79syTq4kGD3WZ2n6F0oUSn1r8elSCTm/hmYC8mJ0z
	 WwE67H/VoRGKIGHrV+QJRLHajXeHbVMineFCqcUp+lsL+05Sec75CchaEhh0TiJ1I0KUc
	 lxKUohxEd2eBk3DvSoSasZPsN2LuvbdKd2rpYMxu6/jUZgadaS9JQ6q+C6CoSQnaUbCZ1
	 BbYixXEdPpwnD1/1JkZiOAGhpMvEjuhKYtGuzjDBnLZV04ek4bU70zbNiepPaJRfmQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669636;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=EP0p8TkafN3QQnnmNUx+hSQ9exkYsh7jf0voP7LEZmM=;
	b=kbsZXMpp+CvFmAsZvPM1iBQyohRrdZ7O/TnUqobbTU9UIOYj0uoSoDscbZWzUYGBkC07
	 Qo0rh+P2nlH7vW9pmgsBFnHEahN4QhwAm/224Za9l9m71xeXuUKZ6Vt1qIXP/pJN393RV
	 wrVqd3tOFs8tA3lzsiTmtfUERe4JPWcPIGWjPQCd4q/NVYoRZCFz2YeXRN8jefw2BgAHD
	 ijVk/uf+4+dXQFcuo/swDKAsSpTTDL+A0FKkxlb5MQkDfUPGNeZsngZ+gb4DNB298AEtx
	 AIneokgGf/+dgG8mO8PD46KCYetI74qQHoh+oRFvuLhjLUbOyHO/IIcYEBI1lLHSEXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQHOiO8o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4F606A319;
	Thu, 22 Oct 2026 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQHOiO8o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEAE1F000C1;
	Thu, 22 Oct 2026 11:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792669635;
	bh=EP0p8TkafN3QQnnmNUx+hSQ9exkYsh7jf0voP7LEZmM=;
	h=Date:From:To:Cc:Subject;
	b=FQHOiO8or8DqcGHB0p+KocgPNy6aBfAe6Kw47pngKq4iyGzXHYQrVvXfqQfSxhw0c
	 weBWLUuj0J5r+36VY3Ch1BB08Rtjmo2B1PmlF13w5V1xcna3BsA7sySL0Af0RdyGxr
	 YAumb5Ii/77FqZaWPSBUW5Mf+1LKWp5y1ktcgBYG5MwjYqHnmJfW4lHnE8n5GSuJbr
	 FOO0q1SQBTvGgUI/ckaiG1xTvsZiPARJDjkqPYLKPXH91RLOenm3Rq6JUPvHEmVd12
	 aKr6tLPjQNUYiDnbkIqcII/w6+Ak8TwqivjM9M2Mv6pDnMrHwVIP5Edxau9b+Zc5Ep
	 A+BJrXMoRMGWg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id DB9951AC5994; Thu, 22 Oct 2026 12:47:12 +0100 (BST)
Date: Thu, 22 Oct 2026 12:47:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Anup Patel <anup@brainfault.org>
Cc: Jinyu Tang <jinyu.tang@linux.dev>, KVM <kvm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Steffen Eiden <seiden@linux.ibm.com>
Subject: linux-next: manual merge of the kvm-riscv tree with the kvm tree
Message-ID: <atn3wGrmrvW0vQKi@sirena.co.uk>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s80RrSSL0CN6hqOI"
Content-Disposition: inline


--s80RrSSL0CN6hqOI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-riscv tree got a conflict in:

  arch/riscv/kvm/Kconfig

between commit:

  b62a0bf95825a ("KVM: Replace CONFIG_KVM_MMIO with __KVM_NO_MMIO")

=66rom the kvm tree and commit:

  e8b32e3779513 ("KVM: riscv: Implement KVM_PRE_FAULT_MEMORY")

=66rom the kvm-riscv tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/riscv/kvm/Kconfig
index 2e3c4e6c1cd7d,8ac209e8ac870..0000000000000
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@@ -26,6 -28,8 +26,7 @@@ config KV
  	select KVM_COMMON
  	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
  	select KVM_GENERIC_HARDWARE_ENABLING
+ 	select KVM_GENERIC_PRE_FAULT_MEMORY
 -	select KVM_MMIO
  	select VIRT_XFER_TO_GUEST_WORK
  	select SCHED_INFO
  	select GUEST_PERF_EVENTS if PERF_EVENTS

--s80RrSSL0CN6hqOI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCatn3vAAKCRAv73Ows9A4
ieFzAQDqzvTh+tnMhkAUVjeOgw05D+uqatGRotcXH8xbrFd1tQD/UL8D9lg8zWXo
xLtOwlv7xCW4N7jq2vDZn+JOHnUhgAU=
=fqle
-----END PGP SIGNATURE-----

--s80RrSSL0CN6hqOI--
