Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499249;
	b=gpl8mOVLywWbl71n8Y3bJO8uQ6E14yjuD7o05QsuYKfb0hn67caM9Goxuv/6iiqrpkKw
	 gOSeIXFw15nRtxEpdRaWGCgUSk3Uxh6xG+2zie5tZjtMk104fPlMWbcnEpSAxlNC092V9
	 /dlnBrslzRjbsNvLScZ4BsxhWmO2xeG2ZMy0hGukjt2u6O4mRD2AUWDMLrcvTL2qzxEBE
	 yyH3rMKclMeKxn+438WL4E9uLYk5jpmSQ0SRNWIMbrfrAb0V/Ph4M1k0oTmj44yOUGoih
	 6buR1m/Kbsd05v8dxmj5BUIzHqGAFU1xjh/UUjQWpHpZTH5zVxaXGYotcR5QptQYRew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499249;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=+n0OFyyGfDnnXctOkrVom7bxVJwocACuoUpJlcAls08=;
	b=c2YCc/k0dc7/spfiqsZR8wkAb2JM1Su6hf+fuOA644RnlUmpf3CRFMBWJCYA3oRhK0w2
	 2/TJhg/tE3yQiE8yIfVD478TwqcaF+iKNrWhKD2xpBRCusFB35I/nmGGnu7s08rUUWeal
	 K6MyouDPY65Tjv8MowMaUJP2qDBiTUc4qLqc02b+D/6tV+RJTOF7pNO3Bk81Sj+bi3lnt
	 RhhwakI5cKdCKWtY/o0VlHSN72XAtSK7mkX7714FZPNnkWCydPk6jmz/o6rqM9IuGCUqC
	 joGlmED3y2QJPdh8LyVbkcETMismA8Oy4BIslVaF37ooiUPu3eJp4lL4AZqj+ELhvNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c495FJ4e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5396606A31B;
	Tue, 20 Oct 2026 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c495FJ4e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BBD1F000CD;
	Tue, 20 Oct 2026 12:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792499248;
	bh=+n0OFyyGfDnnXctOkrVom7bxVJwocACuoUpJlcAls08=;
	h=Date:From:To:Cc:Subject;
	b=c495FJ4e6ovoCXEKPHqH+LrQK2jQ+E/N4wkxfE46lglJr4q6ONeP4mjP1zxhgAlOy
	 NHzygDgZHF0l+SLNKWb5njJz424yVkdHdvYWAaVfc5arupmitZhVQgvPOxhQpr9XFZ
	 DmH2XMoejYbQdtkPHFlKNYLjvT0dxpxhL6Qq+s6SvRkM9dPr1eJFONGWHsvOdSfnk9
	 9+iuBL+dKUcMW3+gtirGxHfjYIab0B4YjyRthDZsch46X5jbi6moGXfBylJ0KN7OJa
	 T6xD/BUSJiGkwGaBkuQ0lR0+4Z2en+CmDmAJpX5AQXB5BlIMqZKv+nGVBtJCNWMTdN
	 mT9c+M5D6dewQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id DB9401AC5994; Tue, 20 Oct 2026 13:27:24 +0100 (BST)
Date: Tue, 20 Oct 2026 13:27:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: KVM <kvm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: linux-next: manual merge of the kvm-x86 tree with the kvm tree
Message-ID: <atdeLNa8rtifVnaV@sirena.co.uk>
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
	protocol="application/pgp-signature"; boundary="wv56ngulGZy3Rkab"
Content-Disposition: inline


--wv56ngulGZy3Rkab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-x86 tree got a conflict in:

  tools/testing/selftests/kvm/x86/nested_x2apic_test.c

between commit:

  994489f04ebbb ("Merge tag 'kvm-x86-selftests-7.4' of https://github.com/k=
vm-x86/linux into HEAD")

=66rom the kvm tree and commit:

  8b0aa41839602 ("Merge branch 'selftests'")

=66rom the kvm-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined tools/testing/selftests/kvm/x86/nested_x2apic_test.c
index bba301cfc0b5a,2ae698c9aa1ce..0000000000000
--- a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
@@@ -86,7 -86,7 +86,7 @@@ static void l1_vmx_code(struct vmx_page
  		   SECONDARY_EXEC_APIC_REGISTER_VIRT |
  		   SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY;
  	control &=3D (rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2) >> 32);
- 	vmwrite(SECONDARY_VM_EXEC_CONTROL, control), 0;
+ 	vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
 =20
  	vmlaunch();
  	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_CPUID);

--wv56ngulGZy3Rkab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCatdeLAAKCRAv73Ows9A4
iQ2BAPwKDKZbLk2oZmyEPhjtfLyaldWmIYW0V1Jcyv/5M8xDVwEAyu3ApJ3EnUdk
v6jbPmDPqTwD5YF8bUvTsWaTzYmgEAg=
=/K4V
-----END PGP SIGNATURE-----

--wv56ngulGZy3Rkab--
