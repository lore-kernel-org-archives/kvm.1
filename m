Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683835;
	b=FJbnuUXPAyUaqjFtjKGs9ahiJ3sZ5AfVBT9m6MYi1qIzmgVR9uHk4yUMjEGUyGS6fM4T
	 VFsb8ecjD11IuYJzIMDfTEFFvYDekQ+/sBoZ7mepXfTigI04HgMqmXNKOp2Xu+d7f2c0U
	 fvHIpRIdvo9YMLunchjC/2N7x/NIh5T7mPeVl7aNR0JArwRkYNW3CwBsV3ehy1W5uUad7
	 tsJd88R/9D3a2QLAKFm55JOzx0eZmMoQxDcCotvtuJXl8bhDrx8+TOoNbyqC2yPPSL6Xk
	 f1If3Kw8NI7BdmWDKkWmrKms8KhiEJ2dRf1Fm25QHFthk4AELfBgeddgPauch5qvOoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2f4dTVrXUrE9hVjyhnUwkekcOAlJvedcs3DG+VbUzPo=;
	b=tJ1asYCEltrTOsS9pNTpNyjiiD2ql1H6BWSCuGIWX/ptfYX9Yj0vCKB5jRmFIDg6+F/O
	 /9UGPn18UhOf4Z2t4yntcsSqo++r31lx9ZLBW4gcmfpRWDVVe2BrR23obVlejwk7hlOin
	 9eAM1tlADbvYCNIN+l78FwcRmB+3a/fQvUW1YasEUcwvVxuahmPBdV1XzegyA4XdXtzbJ
	 CbjPWicDkfqKz90bZEpZcyZXtyIkipPDQF3jTHxrO4l9dLHUqQdulGOx26tEX85J4cPa6
	 HWM+GLJlMi1V1MJc35bgLh8I3wazZwRbOC+DNloykw0iODswYwMT8cLuH1mX6FQ2ulw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JeX47OBz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED35606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JeX47OBz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CDA1F000CF;
	Thu, 26 Nov 2026 09:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683834;
	bh=2f4dTVrXUrE9hVjyhnUwkekcOAlJvedcs3DG+VbUzPo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JeX47OBzQM3cjhnJ9XriTruUSEoR8PD/qXdzPOsEUW/+e8B5at2aMhGa9STGI0RUu
	 t4BzZMXsZONVKnbOJgid02gJ3Z+KSny0OlFaaFccHPdE9pRH3KWNv5WInvtS/3MZEo
	 09M4FhhZ9Z1FYaLCjId4rqH/3WRgaTQQJQomKn69xOuO2T3vHxdx0B/YfNMCWgD8H4
	 gBGn0YMCZh1U5pM3JXPyqFGLYefLQMKJYQzn5NlkXOF9nPTw+QP4+RCksQz0Mcqipg
	 dPDPhdYCANiFu9E5bmc7LAUUSS7Ju3yw2e/tKoKRefoycLlNW2cS6w40ePReRu3/eN
	 3DvDEgHE9xLTg==
Message-ID: <sashiko-outbox-235075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] KVM: PPC: Book3S: Hold a reference to sPAPR TCE
 tables during hcalls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20261126085008.34532-4-nnmlinux@linux.ibm.com>
References: <20261126084351.32375-5-nnmlinux@linux.ibm.com>
 <20261126085008.34532-4-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 09:03:54 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] KVM: PPC: Book3S: missing Fixes trailer for commit cad32d9d42e8
--

commit e9c775c6ce258aa52807c78d9ed640f4c2596501
Author: Narayana Murty N <nnmlinux@linux.ibm.com>

> KVM: PPC: Book3S: Hold a reference to sPAPR TCE tables during hcalls
>
> Commit cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real
> mode handlers") moved TCE hypercalls to preemptible virtual
> mode. However, kvmppc_find_table() returns a table pointer without
> holding a reference, allowing concurrent fd release to free it
> while a hypercall is still using it.
>
> Add a kref to the sPAPR TCE table and acquire it under RCU during
> lookup. Release the reference when the hypercall completes.
>
> Use kvm->srcu to synchronize active table accesses with fd release
> before dropping the locked-memory accounting.
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>

[Severity: Low]
This fixes a use-after-free introduced when TCE hypercalls were moved to
preemptible virtual mode.  Should this include:

  Fixes: cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real mode ha=
ndlers")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126084351.3237=
5-5-nnmlinux@linux.ibm.com?part=3D1
