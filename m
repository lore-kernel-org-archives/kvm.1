Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA31465B4
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 00:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779497544; cv=none; b=fIJD8hPEf4YklcgiYu1Iib+hrSJJQO6hJ2gwUj6KKMw73L87MvJ+Nm/A0+RceQw5v0ZswP+Hf216Bfg1g8U6u5+VacRGg/uWXdl2WkNUQz45/Jwp5wqaNPFnf2oUna2nWQFqklOtHrIptIL7uZj8rQAZ7cLT1XPtdkOZXDy623Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779497544; c=relaxed/simple;
	bh=2Fr+NhthTCG4lQnU0gV11ug9/rdR0uaXesLzRdqCO2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lW09eTGeviVO6pEK5zsR+MgmAKrvGjZD14Onxs+SLm54tTF6owwYlMoTzyouNkXCG0nvtZBK46N13iUlH1QggcmsfXEk/4WOBvQnQxG+a8sEoIcz6sGXusrtP6JKLYljVOXh9nSuiQIYo8Tz2wrthC8vMU7D2obCIRNsluBKHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cS+AXq6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS+AXq6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9651F000E9;
	Sat, 23 May 2026 00:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779497543;
	bh=/GCwrt3UsCIUHkxGTCc3xINrFg+4YeOTGOJqtsAAU9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cS+AXq6U65wvsQaE+irmemxZHungJmOcV6cdmrYUJrPOW4Z/ra7diUXrCrUaK6svn
	 MnyYo8KsgplY9bX8IEFpjcj+AowGmzTEFcQGqY2bYG6NQiYXdJ2/U602wDYUbsC0aj
	 nl6kS1QrbqrXPj+4H2I7K5mQ5ePS/kZfpHdxKxfL7MDuw8xsDTEanaLE/d4ZPWebJ8
	 Gco1Qbxy07glhIZhbrJMGRYTIgvss1zgA2lC8i/WsL48oW62R85F/QDkzZQpCOyfnA
	 tFfsGGbzmMWrjJrme99Q1OICOJiomGhobHsNfwZW/t09D9XzUogDD8tJhs/JHXiG4K
	 0tHq4C7RW23RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/42] KVM: guest_memfd: Only prepare folios for
 private pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-gmem-inplace-conversion-v7-7-2f0fae496530@google.com>
References: <20260522-gmem-inplace-conversion-v7-7-2f0fae496530@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 00:52:22 +0000
Message-Id: <20260523005223.5B9651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] When initializing a newly allocated folio, only the first page is =
zeroed, which will leak uninitialized host memory to the guest if the folio=
 is a large folio.
--

commit fd652f7fefc49fa2d4a303f4d6cbb5c2dad23874
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Only prepare folios for private pages

This commit restricts folio preparation in kvm_gmem_get_pfn() to private
pages. This handles future scenarios where the fault handler might call
kvm_gmem_get_pfn() on a shared folio for a CoCo VM. Preparation is also
properly undone on freeing or conversion to shared memory.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 9d025f518c025..4f7c4824c3a45 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

> @@ -908,7 +910,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memo=
ry_slot *slot,
>  		folio_mark_uptodate(folio);
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but does clear_highpage() fully initialize the
folio if it is a large folio?

Just above this diff context in kvm_gmem_get_pfn(), the code clears the
newly allocated folio:

	if (!folio_test_uptodate(folio)) {
		clear_highpage(folio_page(folio, 0));
		folio_mark_uptodate(folio);
	}

Since clear_highpage() only clears a single PAGE_SIZE page, won't this leak
uninitialized host memory in the tail pages if __kvm_gmem_get_pfn() returns
a higher-order folio?

While comments in kvm_gmem_prepare_folio() state that the code is ready
for huge folios, silently leaving tail pages uninitialized could lead to a
severe information leak once mapped into the guest.

> -	r =3D kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +	if (kvm_gmem_is_private_mem(inode, index))
> +		r =3D kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> =20
>  	folio_unlock(folio);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inpla=
ce-conversion-v7-0-2f0fae496530@google.com?part=3D7
