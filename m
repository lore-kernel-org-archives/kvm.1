Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF7549620;
	Wed, 30 Sep 2026 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777080; cv=none; b=eN3VFEVcMjVKmTmSq59xOuEf8Le12geIGIvcW8cmoCfxpgF6pWk2GDFrPaIwhXmTFQn7IuPgVj069uEC9pOyq+fJ1mWqhKAIDjv1oRrjZNZ8yWu+YaBF+gR0m2hpmzoeynaylb1lyVPCcDelkdLpDCurB2CdrH6ih6otnm731Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777080; c=relaxed/simple;
	bh=/UyS5PrZ9dFy4qnf/lpFn1MRDCVbyU3hO93UDTitrEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pa4fhx2B+aTS9EHSUDAdCFhk06QAt5YY4ud84tPd7PBwotc5CPy/Q+RtmfI0KegxY+7h8yOpD88GiugV6sj8Gpi7ggkPYAD2kK9AVfgFbumVTWOdXF2ep6hu5G1iGlTxj+kJSBtmCKAjYQgJbepQ5a933BQjWAmtNaJCKrdXCeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvdjq9oZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvdjq9oZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4701F00893;
	Wed, 30 Sep 2026 14:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790777067;
	bh=qDrsdiaQZHHhPeXe5jyxrlwF2+7RvAtBFzgDhXFPP3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yvdjq9oZV45eCiEN111hi4vet2W/nLS74DMopHuojMM3wMH/N4KAcu2+0mW20EO9c
	 IDSXxS2tPynj794wBAz2EOOq7Kr3OlGB+B8Ek3jJPJVX2lfyLH8vR9z38Ymfsd0t0S
	 1dDbmYiQEkrtHddHTxHXUapMTACsYOmOJOpt+34b6pII8Yf2k4tSzSHIgEfRKZ9vBv
	 1NytRX0mM8j1MpboL6ewdR8epwy+56yA7yIHarrLY0H1ziJQgOjG6dYYH2jb2MaI68
	 EbFkOONbsAAt13gzGzY3F5AtT+IKqxbSRLXJ3b7VC7xf3HR7EjeHWzEak0OgGM/jrB
	 4QvhyYzW+jvkw==
Date: Wed, 30 Sep 2026 15:04:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: KVM <kvm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: linux-next: manual merge of the kvm-x86 tree with the kvm-fixes
 tree
Message-ID: <f8d5ab37-7bc5-494f-afec-6bd0cb0c412c@sirena.org.uk>
References: <ar0KIZ8HQEfIRvVJ@sirena.org.uk>
 <ar0RN3FICQ-PEqNW@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GnQle1IfTViYMuA8"
Content-Disposition: inline
In-Reply-To: <ar0RN3FICQ-PEqNW@google.com>
X-Cookie: (null cookie


--GnQle1IfTViYMuA8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2026 at 06:40:07AM -0700, Sean Christopherson wrote:
> On Wed, Sep 30, 2026, Mark Brown wrote:

> > between commits:

> >   b630929bcc4c8 ("KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt")
> >   b0bc51910f039 ("KVM: selftests: Extend nested x2APIC test to validate using eVMCS for vmcs12")

> > from the kvm-fixes tree and commits:

> >   9b2f8146fcef9 ("KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt")
> >   a4bab1c12fd52 ("KVM: selftests: Extend nested x2APIC test to validate using eVMCS for vmcs12")

> kvm-fixes got force-pushed, which is what's causing the weird conflict.  In a
> tree that hasn't refresh from kvm.git, I see:

Ah, I had thought it was an old version of the patch having landed in
kvm-x86.  It looked like different versions of the same patch got into
each tree so I went with the main fixes branch version as that's what's
heading for Linus.  This sort of cherry pick/duplicate stuff is always
hard to follow. :(

>   a4bab1c12fd528ccaafee00360e07463873404a9 (kvm/master, kvm/HEAD) KVM: selftests: Extend nested x2APIC test to validate using eVMCS for vmcs12
>   9b2f8146fcef9faa73f9dc1bad9a8d6c585cfec8 KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt

> versus the newer version:

>   973ea70393e885e540f714904e51bc6cac80e3d7 (kvm/master, kvm/HEAD) KVM: SEV: Do cache maintenance on the source VM *before* clearing SEV state
>   8abbc76120a74bfba1851bd97528099d715e45c6 KVM: SEV: Nullify "have run CPUs" mask pointer when freeing it
>   b0bc51910f0391fea09c0a1d32352fec2acb2686 KVM: selftests: Extend nested x2APIC test to validate using eVMCS for vmcs12
>   b630929bcc4c867c9abc8cd5a0ebee3bb5ce5dcd KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt

IIRC my conflict resolution gitk only showed me the two commits that got
duplicated, it is filtered by file though.

> >  -	prepare_for_vmx_operation(vmx);
> >  +	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);

> This resolution will probably break the final selftests build?  kvm-x86/next
> moves these asserts into prepare_for_vmx_operation(), load_evmcs(), load_vmcs()
> etc.  I.e. kvm-x86/next should "win".

That's entirely plausible, my kselftest build tests are for arm64 only
since that's what's native on the build machine.  Sorry about the mess
here.  If you send me a confirmed resolution on top of today's -next I
can add the fixup, or I'll try to take look tomorrow?

--GnQle1IfTViYMuA8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq9FuYACgkQJNaLcl1U
h9BWZwf9FT0rfa9zbY50MuzgJVVd/RnGiurcqZOaldeL5c9hN8b4ZTQUj7DCmR2K
5pHhIbS4SXVJxSOIZAClX9Kn27Lw7GDlzWenyFNsohU5vT6DuySlhXXd6PTxAq+M
h2VRa85MZsqIWbn3XVxI4oeRfUPFEarXmMYw4LGbGTYCvcEvV5gWTHQ5QrXD3AvL
Y01zred9poBzoTqKVXDM4mHDhBUuynW17wbhZzjXuWCVoDw8OWeM78k3UQqUD4b5
cBw0ORUqqSPj4+YtdDVegZeHV1mHlfczODN9yViGY154yWcEv0xZreZLpDQR+JTp
HLF5Z+QBnvgu0li+qNRANyhYGo9Yhg==
=xuDH
-----END PGP SIGNATURE-----

--GnQle1IfTViYMuA8--
