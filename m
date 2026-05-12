Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B5728F948;
	Tue, 12 May 2026 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551199; cv=none; b=jCmNRybeY+p7KKPk6kl8UGlmXfBZbdctU1sn1j16tZcneqqMfZKwLAZXanDjbkiLRmUO9EWGPaiz5mCzdH4XLrIIr+zjP1q6m/PpVRb24QyuYKK5LkFZU70LzFsSVT+OaPM+eDXq6MZyYP9IkDFdT/MMXTtOLPAJtHo0ibw+Ojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551199; c=relaxed/simple;
	bh=JqUKm1zabpCzOKVv8zteO3eSNVnNbK68AaZt1Yo4LwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6bF5NJyWf1hTuKT1toPfiCkpknNdHvLAvyc7P/bzla+kZrIYCNm9yqBXNq7ljivILm971DJjK31Ygakn95yNw6hGRDMFS4xynOegB7nqG7ALPozRm0tLlEUGP1gxN1UrZLX20fY87CHeKuQDHbojqb7Uq7egAfJ2GaAVqDYH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amiXDQpl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amiXDQpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E25CC2BCB0;
	Tue, 12 May 2026 01:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778551199;
	bh=JqUKm1zabpCzOKVv8zteO3eSNVnNbK68AaZt1Yo4LwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amiXDQplOjPOrSnNOBF7LEJ+/6eh4XlQI5wNiRtAo0rNSJnfQpzdCEiNMqMkyEfNV
	 sS2bW8JA4ZmxPBy2K3vglpLXfjButk5eoxbQBK7hz64jRaxN14hoDlaNthKBAdDcgI
	 08YexPxrpbj6dHvIC2fVi9oETcXGuLc1vWV0sZGIaI93m97o/XVgCaapDU0NrA40aP
	 kKgMwmdV9yRret4upPWBVeK5B1NA+U7xGJHGNl7BXz/f2PhixazkJPHWBff5LgC70P
	 prKwEC0Car3L0JhQZXIe3WFY1AiU4fRi0m4KkPozM3/7MrJFYTGdRV6fy6vjsPSAA5
	 5LUvHHJk4ykgQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id B02A11AC5843; Tue, 12 May 2026 02:59:56 +0100 (BST)
Date: Tue, 12 May 2026 10:59:56 +0900
From: Mark Brown <broonie@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Jiakai Xu <xujiakai2025@iscas.ac.cn>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jiakai Xu <jiakaiPeanut@gmail.com>, kvm-riscv@lists.infradead.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] KVM: arm64: Add memslot for ST_GPA_BASE in
 check_steal_time_uapi()
Message-ID: <agKJnKOcvbPZ5cgA@sirena.co.uk>
References: <20260501021639.2563219-1-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uWRoW7NMniSf8PmN"
Content-Disposition: inline
In-Reply-To: <20260501021639.2563219-1-xujiakai2025@iscas.ac.cn>
X-Cookie: Truckers welcome.


--uWRoW7NMniSf8PmN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2026 at 02:16:39AM +0000, Jiakai Xu wrote:
> The refactored check_steal_time_uapi() creates a temporary VM via
> vm_create_with_one_vcpu(), whose default memslot0 only covers GPA
> 0..~2MB.  Setting st_ipa to ST_GPA_BASE (1 << 30) causes
> kvm_arm_pvtime_set_attr() to fail with EINVAL because gfn_to_hva()
> cannot find a valid memslot at the target GFN.
>=20
> Add a memslot at ST_GPA_BASE in the temporary VM, mirroring what
> the main test already does.

The regression in Linus' tree that is fixed by this patch is still
present today.  Adding Marc and Oliver since this bug manifests on
arm64, adding Anup and Atish since the patch introducing the regression
was merged via RISC-V.

> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/lkml/afM8WEe4gG5tL4fH@sirena.co.uk
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Fixes: 40351ed924dd30 ("KVM: selftests: Refactor UAPI tests into dedicate=
d function")
> ---
>  tools/testing/selftests/kvm/steal_time.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/sel=
ftests/kvm/steal_time.c
> index 7df2bc8eec02..2b01b466ddc1 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -213,6 +213,10 @@ static void check_steal_time_uapi(void)
> =20
>  	vm =3D vm_create_with_one_vcpu(&vcpu, NULL);
> =20
> +	/* ST_GPA_BASE needs a valid memslot for gfn_to_hva() to succeed */
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE,
> +				    1, 1, 0);
> +
>  	struct kvm_device_attr dev =3D {
>  		.group =3D KVM_ARM_VCPU_PVTIME_CTRL,
>  		.attr =3D KVM_ARM_VCPU_PVTIME_IPA,
> --=20
> 2.34.1
>=20

--uWRoW7NMniSf8PmN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoCiZsACgkQJNaLcl1U
h9Aztwf/TJOL07dodf+kbqHGMGanbVGP2UgWLGXE9K1upoIUu6EOLDb52Qn10qVt
Uiq0EHGtwmhChGZqkdaP7GRRUuP2/3UbVC2O7Ts/m4RWs9AtBdmr3pn0pxwUNtg6
w4wYmTNV1Czs782mzaa+ad0VcEXjdY3uirSYPMbDgwTEL+IHbrVs2SS20fTH8i/V
BAi4DqyDVCRnu49QmGRqa0HvwrmNzP+5fBnJXauS5bbQqxBb18ePzLNKQ9fypFP5
NEZvRAiRn/hwhWa/zh3YCqYrm3lFaR3uh0y+ndMHoD2BiPNPZzkVqF0/rzEZ//V2
T5msZhZHP8j1DVjINnNAFjQ8p07K/w==
=toXn
-----END PGP SIGNATURE-----

--uWRoW7NMniSf8PmN--
