Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0FE2405E1
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830737; cv=none; b=p51ykRCx7gbKx1rg3J1WqeSu/AO4Fhoc7PlUY32pQyXXLv4F0ihdY1/ajxddnZB7XZxSJwRiCSMXqwD1jf/HGH9QjgOsrW6TKmZF+kXfyMZDbCnGgDLQdqpw+prdtAHKTrdY8iMX+L+3peC8z668XmjKHjox2Kuz5jDO6hHGu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830737; c=relaxed/simple;
	bh=liZPaD89SxNIb1j5iDeg3EQadQHVggNlJz6WKjrl14U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tJknrNz2k3/jRR5NghhKO3JmbbvjC3tFZ2r38SOf8xoKWDV/hA5gA2ImbbjFuTu6J2JLxe6ptlGBzjLZpmPx7vt9wt3tsEX5ssdDOM+ChiMXS1CXUZ2Thabf7BPomyxzcJJg6HtOTdSJdNU7KJCfwPJjJkI3QDsKgq5GJ1ojXiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv+4UgXX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv+4UgXX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DD81F000E9;
	Fri, 19 Jun 2026 00:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830736;
	bh=0xhRvFQa2cJCfQmEqY9JJ1Jge2hKE0a7h8QDS8ePmOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bv+4UgXXnykRHzhE7XJI9H2QqN+VKkhbSTb8IpNBtPDEvHo7jM0rwMtmE3WksPdrO
	 a1Qm2sOs1K/bQQtVDinQAg/4bYHRXAipTx93lUJ72JODv1m3nTIa4LJu0p6hYMydpJ
	 MSleHS6p7b7TMSAD0pL084vavRTHIz+UhVsdl6qpYx/pfJrk3AQQEAmm4DNlHLUEDA
	 zUJLxAh4iSmDwLkRJYIJdPZETcGgCflA61UsDzEJ5VYoHRmZqghnkUpS8aKg9+F8sq
	 4TfIQYOXk0SuqjSbEIz7uRROlPapUQJsFplH/z2xsonoJKW79mNfkbaEaJ1vR258/j
	 FUja1y6hP+IPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 24/46] KVM: guest_memfd: Make in-place conversion the
 default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618-gmem-inplace-conversion-v8-24-9d2959357853@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-24-9d2959357853@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 00:58:55 +0000
Message-Id: <20260619005856.09DD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unprivileged userspace can trigger a WARN_ON_ONCE if the host ad=
ministrator misconfigures a module parameter.
--

commit bf8cb04a544d7b8235d73034e0febf195ab335c3
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Make in-place conversion the default

This commit makes in-place conversion the default when the architecture
supports private memory. It introduces a module parameter to override the
default and adds a warning in the CoCo VM memory population path if in-place
conversion is disabled without enabling per-VM memory attributes.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 86c9f5b0863cb..5cb73543c03c8 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -1193,10 +1193,15 @@ static bool kvm_gmem_range_is_private(struct file=
 *file, pgoff_t index,
>  {
>  	struct maple_tree *mt =3D &GMEM_I(file_inode(file))->attributes;
> =20
> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>  	if (!gmem_in_place_conversion)
>  		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
>  							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
>  							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +#else
> +	if (WARN_ON_ONCE(!gmem_in_place_conversion))
> +		return false;
> +#endif

[Severity: Medium]
Could this WARN_ON_ONCE() be triggered by unprivileged userspace if the
administrator misconfigures the module parameter?

If the system administrator sets kvm.gmem_in_place_conversion=3D0 on a kern=
el=20
compiled without CONFIG_KVM_VM_MEMORY_ATTRIBUTES, it appears this warning c=
an=20
be reached from an unprivileged ioctl path calling kvm_gmem_populate().

Since an unprivileged user creating a CoCo VM can intentionally trigger thi=
s=20
warning, could this act as a host-side denial of service on systems configu=
red=20
with panic_on_warn=3D1?

Would it be better to convert this to a pr_warn_once() or perhaps validate =
the=20
module parameter at initialization time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inpla=
ce-conversion-v8-0-9d2959357853@google.com?part=3D24
