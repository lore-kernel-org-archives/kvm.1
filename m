Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295B59650C
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889344; cv=pass; b=uAXZyHn+urx4q2+Dc5Bty3m1lgypvg5FiOU+CnAHF0df1379sLlvFS+TLZdadpPu7poPEjNYQEwF4xqsG5BSgz30bYHfppswiAJhrCqKos7os0lWZxe5+drlcWj/QymWF55IlthrnY4M01kjSVzYaro1BaQg7f2d3x1ya0wGvTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889344; c=relaxed/simple;
	bh=ZU4SkGLCQl6PTS0EDxlLzNT+Jubeap1l3JebEpwsgdo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gi1DshXJzXnl10WBpaBjHkI21C94/oHrfjyrzuP65MaPpneK9xocO0I5lWt/jqoem/HL2i4QlPiw+sWFPoFph24aX9oZA97JrlI7wzepPaet1DgaDugFxuZAMKsnkp23holIe+lyBByAOlDiP6Gl9OMhGYQCLw4b4OW1Tc0Aw+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wkhZlVKh; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wkhZlVKh"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90e970f710cso53908346d6.3
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 10:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788889341; cv=none;
        d=google.com; s=arc-20260327;
        b=XUrxE2cHOP8HDJg9reiKEOq7SHyjTctxhUQkqTD3xscCb0Fk4NfLtgpMasJ135yTws
         9Ky1qIG7bjssyWTjMotA4DkSUFtgDRHmk5dkKOPjqbfbve2C8VnFTWNCPwH7g4wpT5gr
         hC44NJv6B7lC7vocVBqBYoENimw9iEKQY9v9yFBAeNaTjPy8l54D9G73FpXS1p+qptQT
         cZEj6m2mJzlNcnvfzxsuRJ0MhRqVOTW+5TopPHz40oNKyO78Rr0EUwXTmgsiJw61/J/v
         G9yvpEsYwmnWON9M+wq+iFtL0wh3WID1wxrII5shcHagELxenKDHpP4d9eiq1j5d5rLK
         r8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mSaZkUcDg9GHS/pD+YIma0jnXw7Vpr67nOJsqfVHzcQ=;
        fh=JZMODi/udyKofpHC22Oik7ypB7wG2Zj/TXpwEXq+Ycc=;
        b=XJXL4FqvKUMeJoHVck+1mamDq051mBsmXu9/kQ0Ysvs0N0dOTEmFsL77iJVzqwliA2
         8s49IbWJzZXYcfu876lU24ZfaOW81J13jDUh7bLg3zzOoegApfiFXGnh20Y1VAlhugel
         FCKNkQqg1D/wPVUHYuHE4V+r17fxdPaeMFNIFinCfMO63PjvWRd5CEY0plSwycTbtj1r
         T26WGhRnSBqMhAK4/j3OuGGPyUGfSgm7HiPqPbi5dZ7HolFUITNiXID9QnsBfxO/nkfs
         J+vkXFSHnyhck/NRdx/zuzJ5BucZf2qGbfo1tBkRCA1vQSJe9EaL+A3be9uA87mFe5Tr
         uGIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788889341; x=1789494141; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSaZkUcDg9GHS/pD+YIma0jnXw7Vpr67nOJsqfVHzcQ=;
        b=wkhZlVKhemyL0fG55dMPed5smxu6hyIptZUoWCotknFmmy6/Ha8pHK0Dq/T8YrR0Wh
         0y8QsGCKhL1Hn8J9todQXEUbKwskSImvq4Ww+WHueQ+L8ssWecfPvgskF90lH0b2JhpZ
         Hy5R0eN1V/o28n/uOXDQTgW4ZV0DEvrs5kvV9q6vfKJPa/wLkpX97GUrAFs/TXEMhGI2
         MfMWEWdT0xg1bmRpfnAW3nOVsGxok6zFMWjJVzG4rA2ZdlzKxRLZJ11TilI2ttEoPw1X
         A8KtwlVEarAVa77PO8QTG0ax0fkXFD7vO016TFiyIVgBCf34wOFfIP4RR3FjBc1ypjV6
         cgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788889341; x=1789494141;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mSaZkUcDg9GHS/pD+YIma0jnXw7Vpr67nOJsqfVHzcQ=;
        b=gj/lzKu+c46NhPFB26z8mzDsz55E/CoiPmbfq7dznfc1LnJO2+n5DqyJLaq0VK04Py
         +4A+olRC5IH3gJVtYDrYyNj+SoorTdrW5bIJzHYhD/YuNVjB8hKWvuMrg6XXpHq5lz9S
         eLjubbql5O6kSjI4EtP4zKy6dMEaaIcEPz8S0yIfcYbc07N3u4816vFkFxMS7UQ3KmPC
         Ildh/apQEy6+0kNBl5DVAyv7216TcTECkQUy7kHCU9WEmAtnXUCfmhxSgZ+BiL1N9GWN
         L3sQqgCGfX11CzN8l4rniapLMUIX3yHxfWqgKo7Fnc1bOzpH9x2qJI83gpTSTD/99BLc
         QyMw==
X-Gm-Message-State: AFuF++n5qhdfHXDsBoTUOxh1F/QR+LmwYlqpyNHm2hPnvU59KNwlg/7b
	e+G6jk+PJsgGVmj/HeM23oBzHXLgbc3PFn2B2efzAEDkz4Blz+fE5vnkLJhFCNECUmcj53BBU0A
	AMYekrZMF53fC2EgqmFIh0lvrb2hhgDFcZEG1mJHT
X-Gm-Gg: AYBFou35wqvQcgZZ0690DKxinN1vn7Li3n2cPBiKUlIYdQXwxHIbKJaxYVT4o4HLaeb
	aHbuxNwbMwv6MLlAbff2gsT+zbM/s/+5t1cMxNfDbi91+deHnZoF8NTviqY7tmQ5Q9BVxqmu+/m
	O72By1h68kEZBXINNVnHCEi3NHmOYGaC0mVwFEiHzj0bKMYfcx7RKROuH86Puc1BH6rDPlnbvzM
	sAsy7RSZF5HUCe4If1gobb26Mz+jNofiqaN9niuMmhwnYjaHArZGVUIr7j6ip/XndXvjSmlcDii
	fwtDPmj5sGKo2Y2Do6IGVMR4zalUtWtkuZyDZdDJPOfe9pOeXbN8jQA+q2O+EghvCF235IsCZP4
	rbyV2cL8pKxjSCj4etUrWhWHgLcj5SU/61RRqlPuMhw==
X-Received: by 2002:a05:6214:5543:b0:90c:e762:1f86 with SMTP id
 6a1803df08f44-9103f0d3e3emr182149366d6.30.1788889335692; Tue, 08 Sep 2026
 10:42:15 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 10:42:14 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 10:42:14 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <7327b274ef823e89cf664b33d94d9c2ba99c4ca5.camel@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-2-15ad654a50db@google.com> <7327b274ef823e89cf664b33d94d9c2ba99c4ca5.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Sep 2026 10:42:14 -0700
X-Gm-Features: AcwNN1WIzdwbZuZ6_C1HEL-Qh1G_nx7IFRuMDHksUPDPxufQ1MQ22MWJYpWBBLQ
Message-ID: <CAEvNRgG0v9DKgjwcswtprEwoRC0Y4w3VTYszDnJkbknWR3rvCg@mail.gmail.com>
Subject: Re: [PATCH v14 02/22] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "afranji@google.com" <afranji@google.com>, 
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, 
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>, "seanjc@google.com" <seanjc@google.com>, 
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>, "oupton@kernel.org" <oupton@kernel.org>, 
	"wyihan@google.com" <wyihan@google.com>, "sagis@google.com" <sagis@google.com>, "Gao, Chao" <chao.gao@intel.com>, 
	"Wang, Roger" <runanwang@google.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "jmcrey@google.com" <jmcrey@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Wed, 2026-07-22 at 23:13 +0000, Lisa Wang wrote:
>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>
>> Initialize the TDX S-bit and the GPA tag mask in
>> kvm_init_vm_address_properties() for TDX VMs, similar to how the C-bit
>> is initialized for SEV VMs.
>>
>> The TDX S-bit is used to distinguish between shared and private guest
>> physical addresses. Its position is determined by the guest physical
>> address width, which is either 48 or 52 bits for current TDX
>> implementations.
>
> Since S-bit=1 means shared and C-bit=1 means private, we can't have a single
> bit. I'd justify why a second field is needed.

The s_bit field was introduced prior to this patch series, so I think
the patch introducing the s_bit field should have justified the addition
of this second field.

Did you mean that we should add something related to "Since S-bit=1
means shared and C-bit=1 means private, we can't have a single bit." in
the commit message to reiterate/as a refresher?

> For "untagging" GPAs we could
> have a single field, but there are other usages?
>

I think this part in __virt_pg_map() requires separate fields, are you
requesting to only retain one of the c_bit/s_bit vs gpa_tag_mask?

	if (vm_is_gpa_protected(vm, gpa))
		*pte |= PTE_C_BIT_MASK(mmu);
	else
		*pte |= PTE_S_BIT_MASK(mmu);

I think if there's any unification/simplification required among these
fields, perhaps that can be left to another series.

>>
>> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
>> Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Co-developed-by: Sagi Shahar <sagis@google.com>
>> Signed-off-by: Sagi Shahar <sagis@google.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Lisa Wang <wyihan@google.com>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
> Nit: these are not ordered correctly. I think KVM prefers the order in:
> Documentation/process/maintainer-tip.rst
>
> But I think at least the RBs can be grouped together. Also... can't really point
> fingers here, but that is a fair amount of of patch history.

I was also involved in some earlier revision of this series, tracing
this history is not trivial...

For this series, given the long history and many handoffs, shall we help
Lisa out by explicitly requesting to be credited on specific patches?
Emailing either Lisa/Ackerley privately or on-list is fine :)
