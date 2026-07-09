Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86533EB0FB
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587086; cv=none; b=UWlxwJlEH+OHSULHQpzZfF9BVgnw7s0mMAHlE77hO+kBqva7VEf4AIK5abGnV7dQjQRQjVuUQf7OQGN2Q20oHBb4ZT/4Lgi8rM9EAFwaWaMqOoAX9PMUxqCpiqUUhGbef+TpkOIsktrWKCGcbWTaKxZChngFlJMNtC0S3xCSO9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587086; c=relaxed/simple;
	bh=VjsHFBKy+x9J5i3Up358292Qp0m7f8AymQAqtW4mK18=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Rz6zOo0cWFYNt+ezclIqSTWABYx/CJlimVGuByRfm/FSv3w5xjU3F0nTkUCMev7MbeIuMUayFr+fV0bA9NuItzBsgfj4k2OmZd/E1nXq85AitIelGHbVDEbWH/82jjwvNQxZvpdSV+iIpUiz0Zmp7EqvhL92b4radVPHqowi8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STG09mU7; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STG09mU7"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso952546a12.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 01:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783587085; x=1784191885; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CNp1e35ro3cQgZeEMYQvoxd6PA+bCrB79PJw0+bppNk=;
        b=STG09mU72e/56VKo9of+DgK2SDlIYMWIVQCtKXSl+v81GtkrMRmgAUp8o6WGOT7xa5
         PhOVlcl5S8YN3Y7NsIeGmMwC8S0N3tt3xd/aCKnL5C0hZHaPqAg9ZVdMoExc2x0fub1U
         sDaGKZXu9CKw/dZlGREXtq3D9V5k4IR7bqjHD2ixfinkRh0CDXr3YLXHG5QIjQprzE/h
         aRAiJXKzCVDKUvDNG1rD02r04LhH5p3x+DiZUPKLrcssPm91zl1+dlB3hmPY6dK+4qCT
         FQSp/OdD8aDucaxLXxVLMgGPY/djM852KMlvJqgquNyTH50TPSCW37IWgIUKJ+HPk/0p
         sdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783587085; x=1784191885;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNp1e35ro3cQgZeEMYQvoxd6PA+bCrB79PJw0+bppNk=;
        b=nyg7UY5oxk3JW5Ay2n0EqOvFOnzELQxP5TuV502frai1Xe2cgdm+tocHxzjGLEo9Ni
         8nDxQnrAeGY25V9ge9YB5HdQnnD3lPjlPg0d1M46ISG5c6FRXRl3ZdmMXbjllZsW9wmd
         1WhxPs6NGY4gJslWZ5oXI9xap9IWZ3NlsLRa/NCK0Ohmqwp/2wykslROcKguDwshQTs2
         YdHB7U59pydCYceGeJdg+qcmDBX1uCyI7RUOMXyRaR9rhHWwbPyHKXrR8GnUugx1G8bR
         599KdDf/nnasKYmhXaf3TzCmBdoJ3Is8m/o/zWB0qEvdJkMVj8Cy1bQHjP4YI0HXbfbG
         vqKA==
X-Gm-Message-State: AOJu0YxYuRE6W6ATHJ/3DiR8rE2xcIpLtmrHpvSYzeaJeLR1HgTf6Swr
	1G4hpq/7MTkjCiPRxtCruhWncrYxWr6sgU7WNQo13+EyN9b9AkGaJpbY
X-Gm-Gg: AfdE7cnpWyjGj4JloN8X4sFG0p+EbP5BEHns0gW7QY5po5WVz4X0Ixq8E6GSoRvYnG0
	w882L69AEFoPAC3+NxLkwXvL0rm69rfbw12Emslzmu/tRc7vObDMlPgmNYomRtD/bfq+DNlGS3Q
	dm+VOEt9Fy+pXMjnyFqt+mbIur+hHUk9AvossemPit8UNzLXLieSi1DD8vfwehb5m9ARs+RIJrS
	E0Z959lh0XG4LomXod4Dui8tnn1vfetggqq9mukwpBSXGcAYHh8Sl14vtNfVRnsTVOUBQ4RIaQh
	SZa3RicdyGgJjlgGwwNuXcLEwPes/xHAu7FzGEpLFX9QSm4YPpeLn3M14Itu0xQyP9yLILRkVzE
	tctVVjdclajRnj/Dy6dAJXRE7U2fMibUhc+SAgd0x4fKeMWFu7JpuV0VftQuUMVc3Sn+Ssv1CJU
	MT4pmqkavb8XU=
X-Received: by 2002:a05:6a20:3d0b:b0:3bf:7ab7:98a4 with SMTP id adf61e73a8af0-3c0bc95bad7mr8044555637.27.1783587084985;
        Thu, 09 Jul 2026 01:51:24 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm5516616eec.22.2026.07.09.01.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:51:24 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael
 Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: Use vma_lookup() in kvm_host_page_size()
In-Reply-To: <71775f561c4b7fb23b7af0725c6ce232a4b27b20.camel@infradead.org>
Date: Thu, 09 Jul 2026 14:16:36 +0530
Message-ID: <7bn4wnwz.ritesh.list@gmail.com>
References: <71775f561c4b7fb23b7af0725c6ce232a4b27b20.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

David Woodhouse <dwmw2@infradead.org> writes:

> From: David Woodhouse <dwmw@amazon.co.uk>
>
> kvm_host_page_size() uses find_vma() to determine the host page size
> backing a guest page. find_vma() returns the next VMA when the address
> falls in an unmapped hole, which means an unmapped address inherits the
> page size of a completely unrelated VMA at a higher address. This is
> never a meaningful result.
>
> Replace find_vma() with vma_lookup() so that a hole address returns
> NULL, causing the function to return PAGE_SIZE (the safe default)
> rather than an unrelated VMA's page size.
>

That's exactly right.

> This is currently only cosmetic, as the only caller is in PPC book3s
> support (kvmppc_xive_native_set_queue_config()) and subsequently returns
> failure if !gfn_to_page() anyway.
>

Yup. The change make sense to me. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  virt/kvm/kvm_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 89489996fbc1..d33761123459 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2693,7 +2693,7 @@ unsigned long kvm_host_page_size(struct kvm_vcpu *vcpu, gfn_t gfn)
>  		return PAGE_SIZE;
>  
>  	mmap_read_lock(current->mm);
> -	vma = find_vma(current->mm, addr);
> +	vma = vma_lookup(current->mm, addr);
>  	if (!vma)
>  		goto out;
>  
> -- 
> 2.43.0
