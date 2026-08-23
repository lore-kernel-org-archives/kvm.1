Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5C33998
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787492881; cv=none; b=Sp8o/HdqCGTqTUihEiT6uzT0axNHjNUaGsZW+t9tl341OmSooGlHe2yu1ZMNjcTE6BO3/ALWmY0hvejsGO2fj4X1N9axdE574pilQMo3LkIDmYuEYDgcxhLle+oBrUoWw8h/eGOhaBUfj6rApU4ancYxqRqhLMKx+YAEyPGWnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787492881; c=relaxed/simple;
	bh=8XGOHUf03o1VQNu0lSWAzPDB8HvlxAuq5rqJpKbn6Mk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m+zFHaSLQ/6hTFxUf9S5pl2iz90FF2/dnfejXe1vQPW+TclBRVGWCzTev883AoAUWKB36IW41krx+JDF2vC2m/DF0OPGnfapT9BAn5n+pfLKUxkZNuyrT0QpfOrKGzHIecIHVtbFt5QW4ftUIv4CeGZKWzvrYtMlMel4f/xZOXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFRfk97f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFRfk97f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596C51F000E9;
	Sun, 23 Aug 2026 13:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787492880;
	bh=prSind0Orjv2KVTOPv4NbVLRCajpUN4UE2Y7lG5VY1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFRfk97fkRqPzQ3sq/3TxWVbwwjZcnNb3I5MBSKD49xGc2ZCQ0lC8Lw8QHuNaRvz+
	 8mpy7fyi0DeN3yGBVrm9+mRuVFZlNPdO+FS7equbMmtOQ+Dn+dg3+gkonMXezl17oc
	 0Gm/OPNaItrYMs6NzVd17ws9N0YExRnolHqB6EvB0ntoT9qJ+QE80X3ez9DzJ17gX8
	 PjoaDZHwgeNqP6h0ZcyA/dWr3VGcJvrvkaa3TW7Rdad35VLk5u4b/+fLDeCA1UuBXi
	 cCbUEhB1EpmTukBj/tMNv4LYjzyaAhRMuhP5tk2rWH720Kbixonro6jTDB2rUEec6w
	 41oRihsdnJHFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] KVM: selftests: add get_numa_mem_nodes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260823-shivank-gmem-fix-split-v1-4-512a29fb8e86@amd.com>
References: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com>
 <20260823-shivank-gmem-fix-split-v1-4-512a29fb8e86@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 13:47:59 +0000
Message-Id: <20260823134800.596C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] `numaif.h` uses the `BITS_PER_TYPE` macro but does not include the =
header that defines it.
--

--- Patch [4]: [PATCH 4/5] KVM: selftests: add get_numa_mem_nodes() ---
commit 307e268608f2261ad345e9a86e81fdd51a53d40a
Author: Shivank Garg <shivankg@amd.com>
KVM: selftests: add get_numa_mem_nodes()

This patch moves the memory node query using MPOL_F_MEMS_ALLOWED from the
xAPIC IPI test into numaif.h as get_numa_mem_nodes(). This allows other
KVM selftests to use it directly instead of duplicating the logic.

> diff --git a/tools/testing/selftests/kvm/include/numaif.h b/tools/testing=
/selftests/kvm/include/numaif.h
> index 29572a6d789cd..55124e2330ab6 100644
> --- a/tools/testing/selftests/kvm/include/numaif.h
> +++ b/tools/testing/selftests/kvm/include/numaif.h
> @@ -75,6 +75,18 @@ static bool is_numa_available(void)
[ ... ]
> +static inline unsigned long get_numa_mem_nodes(void)
> +{
> +	unsigned long nodemask =3D 0;
> +
> +	/* Get set of first 64 numa nodes available */
> +	if (get_mempolicy(NULL, &nodemask, BITS_PER_TYPE(nodemask), NULL,
> +			  MPOL_F_MEMS_ALLOWED))

[Severity: Low]
Does numaif.h need to include the header that defines BITS_PER_TYPE?
If a test includes numaif.h without previously including the header defining
this macro, it might fail to compile due to a missing definition, breaking
header self-containment.

> +		return 0;
> +
> +	return nodemask;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823-shivank-gm=
em-fix-split-v1-0-512a29fb8e86@amd.com?part=3D4
