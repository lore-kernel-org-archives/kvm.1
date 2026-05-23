Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A363CB
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779497760; cv=none; b=l3i9ymvTMcGGFVoO96X2l3RwGMOQbekpOwvNJ+tGmC343C5AFuZjfeKTlqcspbXecfKLQSHCaiDNFPD0OyUIsG3B/13D4xTllMbjPuSiX5Ok3Ds5lBD48fwt7Iku1K47rrKQPEBupJrbCfBskHlTr8C1AXQlqcOkz1QMcxfJf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779497760; c=relaxed/simple;
	bh=8gSYgA2agHWKhpdpY99I7RZgN/m8g4Ca8Uk8I9kbgWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ehaCV/lHw15sR0Iftp60Laf5WHob9+VwENym5RPqTm4ifyQts9FgWWcIo+jMxDFvOTsof8orf81B73KzCEt9W43bIcpGw1nae9Er6J5E80dtnVvDC1r/eYtHwFWs5nYRCvmMaz/sG7g1FIPZN2XMPeQOuiO6WVms5/Q25vyIvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkhfJeN1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkhfJeN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1581F000E9;
	Sat, 23 May 2026 00:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779497758;
	bh=DAc1NxWWLcz9sALoXVhbmf7SG6yOmdXC+2Sq5njWfrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WkhfJeN1TWNF+8Pjq1kvG6Zwr+tlECsP5BQek97qVL7xw9OIHz3zekrljy2q2GqvV
	 fwW6FaXUL3Jok64fQ6k0zOw+omdZ+3kwu5wzhG9adU+rPxjiGEgmwHFM8bNFi1ZnVW
	 GYz+FZnXyAwLMFVDHlEY2tF6BLmTDmniGTap0aGc1shqec3iQkZZvHsrz9hz8todzC
	 9WRB4Qzn/tkRPJeU9EKf97Hd2bZJ1m89GgXxjCrWUdpxYTQeGKEDmsYa96xcEUrbfI
	 ZeIk1Ld/tcGOgdI1rZZBfOW/jDeIsGLKJRkDGtdj84OTJtO5+liO1LD0/I9uf6XkLa
	 /M2fdZVrh3NNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/42] KVM: guest_memfd: Ensure pages are not in use
 before conversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-gmem-inplace-conversion-v7-10-2f0fae496530@google.com>
References: <20260522-gmem-inplace-conversion-v7-10-2f0fae496530@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 00:55:58 +0000
Message-Id: <20260523005558.BF1581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The safety check for memory conversion fails to drain per-CPU LR=
U batches, leading to spurious failures and a potential infinite livelock w=
hen userspace retries.
--

commit 1d1f8db35321bd7380e94b62c704d6ef2854187c
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Ensure pages are not in use before conversion

This commit introduces safety checks when converting guest_memfd memory to
private, ensuring pages are not accessed by other parts of the kernel or
userspace. It updates the kvm_memory_attributes2 structure to return the
failing offset to userspace alongside an -EAGAIN error.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 91e89b188f583..d1a6cb56626b4 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

> @@ -572,9 +572,45 @@ static int kvm_gmem_mas_preallocate(struct ma_state =
*mas, u64 attributes,
>  	return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
>  }
> =20
> +static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t=
 start,
> +					    size_t nr_pages, pgoff_t *err_index)
> +{
> +	struct address_space *mapping =3D inode->i_mapping;
> +	const int filemap_get_folios_refcount =3D 1;
> +	pgoff_t last =3D start + nr_pages - 1;
> +	struct folio_batch fbatch;
> +	bool safe =3D true;
> +	pgoff_t next;
> +	int i;
> +
> +	folio_batch_init(&fbatch);
> +
> +	next =3D start;
> +	while (safe && filemap_get_folios(mapping, &next, last, &fbatch)) {
> +
> +		for (i =3D 0; i < folio_batch_count(&fbatch); ++i) {
> +			struct folio *folio =3D fbatch.folios[i];
> +
> +			if (folio_ref_count(folio) !=3D
> +			    folio_nr_pages(folio) + filemap_get_folios_refcount) {

[Severity: Medium]
When folios are allocated and added to the page cache, they are also placed
into a per-CPU LRU batch, which holds a transient reference on the folio.

Since this code doesn't drain these LRU batches via lru_add_drain_all()
before checking folio_ref_count(), could this cause spurious -EAGAIN
failures?

If userspace retries the ioctl in a tight loop on the same CPU, is there a
risk that the LRU batch might never be preempted or drained, resulting in an
infinite livelock?

Note that this issue is explicitly fixed later in the patch series by commit
"KVM: guest_memfd: Handle lru_add fbatch refcounts during conversion safety
check".

> +				safe =3D false;
> +				*err_index =3D max(start, folio->index);
> +				break;
> +			}
> +		}
> +
> +		folio_batch_release(&fbatch);
> +		cond_resched();
> +	}
> +
> +	return safe;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inpla=
ce-conversion-v7-0-2f0fae496530@google.com?part=3D10
