Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642593;
	b=LGkfR6WALO1pCS7x1vbrOO/XzUks3RyPuramMNnBBRo/D5JuclujNocoRPcaFBmsgUMs
	 ExErhviJfu0Q6yFVpXZbx4Pabrn4PqQqN732DD9gPhXXFmLMmjvD12zk3IFsMzC6lEcbI
	 opdFeuTUVC8KQ/4UyTo5+OoQArRqlxrPLmedWZSetNWJedoGZ2K6DgtmywoXdXKpQnrmW
	 n1VPTkiJ096ts2zm/u1RMD52B/rUPpoiXvWWyoRDJnBTfZR77BJXnAaoUMZvQvfL7ZCiq
	 Bb1yz2yHt4JB9LdFDCi8Op7jLQrGAZZgRxteSbQIqYT2nf6zNYxGPQTDoU6DnHFHZxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642593;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GFarWWkVDJzLp4ZQDuxhq9I/g4bchvjdHZA4b6v+VPA=;
	b=ayRQGGOV9MVZrEj04SyiWTBfH10x+Mb13IVVj0hetaWO5gmRcEXz1wwItT9vh4N3+Dpn
	 SWA+R/a8GwRst/MD+3IpEYcDBGeko0yuVoKDbVhkcRlDbFekmgBUBiANN/oY4WHvFJvWv
	 ebdCqZd7aDV5BiJpINjBURfREJfmz1ypxGiWHMszyzTGDf9IY8NZHhm3FZADZXwH30CIA
	 Y/pe+Lc7CqHyp7WJgvjODauS11WJHlpf6IGjDQ2dCdBPETHFQdC4oNCI0Cm+Dx8Mgn6UV
	 eQkOCGd+MmNjktioeZW+UlqOM5KF4qzDZqH84G4PZL/jeaZP8se9BGZF/zIxbSJshxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9Rvtr+j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD091606A591
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9Rvtr+j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8611F00A16;
	Mon,  2 Nov 2026 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793642592;
	bh=GFarWWkVDJzLp4ZQDuxhq9I/g4bchvjdHZA4b6v+VPA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=f9Rvtr+j9jkAjGZUH5rgv+1Np2aZ2G3AXn9LVCOIAcvx1FFn54WGoeSfZ6995qBsx
	 QOSl9JEez7HlsWfoj/6mX2kNG9fYw9kWKpD2S2CWbfTZasX+QFx3KY5F6JMI1M8IgK
	 FHvufn9NiEGuMpYM3+nICRx2WBbg2Yz5NkHxafRxtnfV9P1psFaDHlDRDQ6t6ciAkE
	 4qDjPIob78k5RAkPs+Kd1V0YtFLCycSd1FiYec2uLlxXgv1jHZRQp91b3LKvdSI0Yq
	 +5i6e7fwgzlKrZMtK9HEZiWxmT0fKCCVdciH3wz6O2C3VS85PypKM3PYMn5hSFZR71
	 mcK0cex1e5WCA==
Message-ID: <sashiko-outbox-193897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/45] KVM: adjust for presence of more than one
 attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174130.8779-17-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174130.8779-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:03:12 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: premature true return in kvm_range_has_vm_memory_attributes=
()
--

commit bc4dd6682729ee9a313a549f79ade166886ce9b6
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: adjust for presence of more than one attribute

This commit removes private-memory WARN checks in x86 MMU code and adjusts
kvm_range_has_vm_memory_attributes() so it no longer assumes
KVM_MEMORY_ATTRIBUTE_PRIVATE is the only valid memory attribute.

Link: https://patch.msgid.link/20260918135030.171564-13-pbonzini@redhat.com

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2fd595a901bd1..17341c689d11a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2490,10 +2490,12 @@ bool kvm_range_has_vm_memory_attributes(struct kv=
m *kvm, gfn_t start, gfn_t end,
>  					unsigned long mask, unsigned long attrs)
>  {
>  	XA_STATE(xas, &kvm->mem_attr_array, start);
> +	unsigned long supported_attrs;
>  	unsigned long index;
>  	void *entry;
> =20
> -	mask &=3D kvm_supported_vm_mem_attributes(kvm);
> +	supported_attrs =3D kvm_supported_vm_mem_attributes(kvm);
> +	mask &=3D supported_attrs;
>  	if (attrs & ~mask)
>  		return false;
> =20
> @@ -2522,8 +2524,10 @@ bool kvm_range_has_vm_memory_attributes(struct kvm=
 *kvm, gfn_t start, gfn_t end,
>  	 */
>  	for (index =3D start; index < end; index++) {
>  		do {
> -			entry =3D attrs ? xas_next(&xas) :
> -					xas_next_entry(&xas, end - 1);
> +			if (!attrs && mask =3D=3D supported_attrs)
> +				entry =3D xas_next_entry(&xas, end - 1);
> +			else
> +				entry =3D xas_next(&xas);
>  		} while (xas_retry(&xas, entry));
> =20
>  		if (!entry)

[Severity: Medium]
When attrs =3D=3D 0 and mask !=3D supported_attrs, doesn't switching to
xas_next(&xas) cause kvm_range_has_vm_memory_attributes() to return true
prematurely on the first GFN that has no entry in kvm->mem_attr_array?

Unlike xas_next_entry(&xas, end - 1), which scans forward up to end - 1 for
the next present entry, xas_next(&xas) only inspects the single slot at the
current index and returns NULL as soon as that single GFN has no attributes.

Immediately after the loop in kvm_range_has_vm_memory_attributes():

		if (!entry)
			return !attrs;

		WARN_ON_ONCE(!xa_to_value(entry));

		if (xas.xa_index !=3D index ||
		    (xa_to_value(entry) & mask) !=3D attrs)
			return false;

Because !entry returns !attrs (which is true when attrs =3D=3D 0), encounte=
ring
any empty slot in [start, end) immediately returns true without checking the
remaining GFNs in [index + 1, end).

Additionally, if xas_next(&xas) encounters a reserved XA_ZERO_ENTRY while
attrs =3D=3D 0, xas_retry(&xas, entry) returns true without resetting xas, =
so
the next xas_next(&xas) call in the do-while loop advances xas.xa_index to
index + 1 and can fail the xas.xa_index !=3D index check.

Since empty and XA_ZERO_ENTRY slots have effective attributes of 0 and
always satisfy (0 & mask) =3D=3D 0 for any mask, should this still use
xas_next_entry(&xas, end - 1) whenever !attrs, and instead only check
xas.xa_index !=3D index when attrs !=3D 0 (or advance index to xas.xa_index=
)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D16
