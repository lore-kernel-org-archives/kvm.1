Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E397A18027
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 00:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830160; cv=none; b=GlPr216aqjEMnv4W+j7SlXRXT7Hm73BGulfCyPRfD0zd8LCStvbSO2K/EiVyMy/N/HBC6JY9oFucmuVLcUkGWQQwIlJ6uuJYhGmJaMhGcjbXaZElAH4S/b3hTuemuJhKBiwVVowCItl9iiVF/Pa2QrO/2DEkpUyTDr5gDP6nAcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830160; c=relaxed/simple;
	bh=jYYuE7JDDV4W0xvdsWfrT6KyNi6Duvo2hIqqW2WVBi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bshBmqdozzu2538T1o0C5QoUaHAxX+szQ0vyTH2OAuCncPXwTSHsX+X/lNqunRBFLAJ0hxtS0S3tAWbmTPTFPFdS/cbyfoj1OXlZHJN7YUvwbraTGm+w9CkDIUQ1NqPDuAr8GvuFBM2UU5w9+bDqGbQTh7MiVC1LUSyNguC2n74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGq+N2yu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGq+N2yu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852921F00A3A;
	Fri, 19 Jun 2026 00:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830159;
	bh=jYYuE7JDDV4W0xvdsWfrT6KyNi6Duvo2hIqqW2WVBi8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DGq+N2yu6aXAsFHmZlX6Zofn/uUuJVpm31EkwAOPyWfvwCm0AAX+3xMo+CbX8nX/o
	 Z22aHgmL3iXOKB5ulB82ZPFiOAZCCTVFOCtDPyp2Ko6GSIJfhr+pHo1fjhwredMnB/
	 fYLZ8AxegTqvu2YNVoBk7MwiaJzDjLJPYk3ZMqwcYUtr4vP0DZjYamM+X6CjzcMhFM
	 73pWbmC7YkdvctO6YNYEhTpEZ4S44SlAOjOsSq8BgXBx0o6HqBgTKAGP7nOMPEFa73
	 UtHAXbZN5tK3ui8FxI8IKMl71t7Cjm7I0a5vP7AVdnPA7GcjdGMTrqEQZeiR0X7XJg
	 eoYSpNCJ3HrzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 19/46] KVM: guest_memfd: Use actual size for
 invalidation in kvm_gmem_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618-gmem-inplace-conversion-v8-19-9d2959357853@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-19-9d2959357853@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 00:49:19 +0000
Message-Id: <20260619004919.852921F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message incorrectly references `__kvm_gmem_invalidate_be=
gin()` instead of the actual function name `__kvm_gmem_invalidate_start()`.
--

commit 50ac1910099f66ea81813150ac7efe43b67fe2df
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Use actual size for invalidation in kvm_gmem_release()

This commit modifies kvm_gmem_release to calculate the actual size of the
guest_memfd inode. This size is then used as the end range for invalidating
SPTEs instead of relying on -1ul.

> __kvm_gmem_invalidate_begin() and __kvm_gmem_invalidate_end() actually do
> not specially handle -1ul. -1ul is used as a huge number, which legal
> indices do not exceed, and hence the invalidation works as expected.

[Severity: Low]
This isn't a bug, but should the commit message reference
__kvm_gmem_invalidate_start instead of __kvm_gmem_invalidate_begin? The
underlying function in the code appears to be named
__kvm_gmem_invalidate_start.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inpla=
ce-conversion-v8-0-9d2959357853@google.com?part=3D19
