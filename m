Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6D0449ECA
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571025; cv=pass; b=bkPqbOtFyQN2E5yp2XBLJRwPckYt8MteAsH31nTD5JIXt9ohaprnHwJrt1ACY+D5gDMvDNoDVKwiN2aMRiOpeEk6lTCjpwuMHIhl7+D++vvfbaP7VGCPIC1diU9HGDGn2CBFINEM/LD4HxS3pLYr7vsFGQ+ntJ4F/LAIVQU2198=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571025; c=relaxed/simple;
	bh=y2FdPNAP77JnWzC+HDR/v/b8dkvosRIA6fuCTFn5zoo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAb/E+m7yiKC3kuOQZuUtuP23bGfZriI4Xwze7lWNgHjkocXJd51jCRVBqZJIcrUaWDs3NPXpwAI7kq+1GwW83eWuO+jXmEnqbNkDzLVjL/jN6SdIk8BW1++P60guRJ1LO2pNwdYK5bnxCKdsd1FkFrvHRcuESQoh0HpABP57I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZJmxbBz; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZJmxbBz"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so411444241.0
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 10:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777571022; cv=none;
        d=google.com; s=arc-20240605;
        b=lSebMsp7x94qnJYGjojQWqWjIaLEzSa/VXCxLVkpzF6zBcMIKRso0W3c9+s3xZGHXL
         47OCtJdWUMgq8ZN98AsN3hHpWHNkGI2I5m3Dnd5qAVvjO7EUtOmbZWyG46vSMFuSnLpu
         3O8w+BJEnaBaTTZzEOKJPqfZxzpNb1mImzktaxFTalyaoQLgbkM2mDze+2NRjUvEpRZD
         e3GZYLua6/Xlz51nWS+raffa+fOn+psw3edU5OWGTL5RILdA2x6So+9/2EJnBwGqLpua
         x4nFOQz9NTbjh5SeeMWCRXKvEbUvUhn0LweCL0wYe/c2xML+mBO6QHTa5xT48xlTOtJ/
         SloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=y2FdPNAP77JnWzC+HDR/v/b8dkvosRIA6fuCTFn5zoo=;
        fh=NojzRtzpA/vKzZJMaaGbT5pLHJbmBPaN36D4+gQ6KNk=;
        b=S2idpBE3vmX4VWiaGvBM4XvBo70DTLuixaS1V9FkMgdPHqZzDGTC1RlyAgzdFtwWg5
         1d67DnyhT0TYylgngkhMPL9y4BqUKz992dO62ShhxfJnfdqI9W/rfX1cW66EXBSv70WF
         v/aChObSRTZv3YLR/2sYYkHDZv95C3hMXV0xBKOuRcY0S63AThJAV5r7UW/5E/3uP94D
         FiOoqyw47hv/6r3+Hm3WjHOVf2lkzaT9zUnRDVwyEvQhE4oqncm/Ppimk6B5B3xXWoUE
         6rdm76sR+EYdq9G+DA/AEtqvAU5ABKbC6/0KosifJrO47F1efVaDF5CwdPzGyM+p98JW
         5WWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777571022; x=1778175822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2FdPNAP77JnWzC+HDR/v/b8dkvosRIA6fuCTFn5zoo=;
        b=aZJmxbBzQ6566gIJSbE02OS0q2PL8yauPR2Oi33eTEdZoQTYUVuNO8syDvXJeWS/Sp
         xJqOFuexMINDWfP6ZqTxkqxwA7alziNkgeU0r+ZzZPI0w/LFN7zZxx7+U+sR4xL44z8t
         piJ5oKJb7zYdcX6UX+PbG4UkKSWTqWrochRn7yegqljZXAKA+a6ZeYGHP/+EkAOa1qWv
         CCSO3sjpJwn0NytmHY4o7iHNV13T82A4NKmNGCX0n/J0lqUrYbY0uxUyNfloBb/YvBDk
         u+8MISF3wjvootpb7cmX24QoBWvDmEdG+lVfWgH8mDjdEYHSX6mt9pMLTJGNgP0yQYfg
         /mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777571022; x=1778175822;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2FdPNAP77JnWzC+HDR/v/b8dkvosRIA6fuCTFn5zoo=;
        b=KtnHwLSwi8KKxxg4gzDN2sPB/8pD67Qt6UfBIONN7nfj1H5iWynLQQ+dtpqatYYT1u
         QKhRdQvVqRpxg75vh+6g23aM3u8bWiWsZa312EJoWSAXzBeGOq39ULe7QmapFQavY1CY
         eyLvPpEdarLpQgadigN6h75x+htehmTu++3bRcWged81Btr9D0tEw2vws4yttBGiqiP6
         w9OtEmjgZJTfdSP6oi99gZoAYWGF6WBXHYMU76s86/D+ndhMcEHKAaJQ//yqplqBV3Pn
         mEjHNUr2scUvBxjtZEtZ/lNpdFhVh1yyhUgsUi221qe14yt2X8T/8Btv0dBVk/mYnrZd
         LS8g==
X-Forwarded-Encrypted: i=1; AFNElJ+z7mIdyAAQa3Tpbd//+/PNYCbxzU3dxfmxAFgmZ8JCEb+VV+Q5PjPc5JXrk4its7fXqPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqFAyFaveluzEfMAhEBKbsxnDUOjJ6+Gfx0CKsfw5ShutwqVeN
	JUY+lLWhRFDpQJd3jfKeaRHpHosQ9cRER/XAcqt4PiVgP7sRTMm5PXlbHRi2GLJHyG0Ge6e8IZ2
	SgSvwQOq4Aj2gfFE1RyG9MIxDyFKCZ/tJv34+631c
X-Gm-Gg: AeBDiet9xicg1IXWcb3HnTcJRwUfW0ufZrXgmdLYMAZNOKSHLJAtHL5KpDMQRPHrNG9
	VhTLW/Omde0AUp9c3zSOiFys0MiGFQ0fjATNFs3i1jCNB6Kv610JYqsDOsmUi4QeInkBnFyCRLi
	K8TvabDT8yM30Wm+7iAobHDPEn+kbxulMFm0WwCNHESaCx0fOegxP9H7k+oPM/k0yClI+roYFto
	c9AqnU2OIJyoTjhmRFUc/cPtWXb3SHNRz8458dCUGkUTFmR3LOX4OnktINdIrOqJcV+P7vJexip
	ZhE1dSSx6SM6WDRDnbt8J1qpbC+IhkLUO7mx7M3nf3wtKXP894bHUNgCQ85Tsmu8qXeF4MiOLc4
	UD3iFZ3kvdGeua7I=
X-Received: by 2002:a05:6102:4b11:b0:604:e063:4fa8 with SMTP id
 ada2fe7eead31-62ad4da0ed6mr1942860137.26.1777571021515; Thu, 30 Apr 2026
 10:43:41 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 10:43:40 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 10:43:40 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260430014929.24210-1-yan.y.zhao@intel.com>
References: <20260430014852.24183-1-yan.y.zhao@intel.com> <20260430014929.24210-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 10:43:40 -0700
X-Gm-Features: AVHnY4J5rn5Jaagn74pUA-cynNYnmPoCwD9s7pVEVIJhT3yHhX_wIsfsGry3Jz0
Message-ID: <CAEvNRgEBSCN3NNgABy48KXTdsKTfVFvafhgjKSC94YMjwqMUbw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] x86/tdx: Use PFN directly for mapping guest
 private memory
To: Yan Zhao <yan.y.zhao@intel.com>, dave.hansen@linux.intel.com, pbonzini@redhat.com, 
	seanjc@google.com
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, kas@kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, kai.huang@intel.com, rick.p.edgecombe@intel.com, 
	yilun.xu@linux.intel.com, vannapurve@google.com, sagis@google.com, 
	binbin.wu@linux.intel.com, xiaoyao.li@intel.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> From: Sean Christopherson <seanjc@google.com>
>
> Remove struct page assumptions/constraints in the SEAMCALL wrapper APIs for
> mapping guest private memory and have them take PFN directly.
>

Thanks for this :)

> Having core TDX make assumptions that guest private memory must be backed
> by struct page (and/or folio) will create subtle dependencies on how
> KVM/guest_memfd allocates/manages memory (e.g., whether it uses memory
> allocated from core MM, if the memory is refcounted, or if the folio is
> split) that are easily avoided. [1].
>
> KVM's MMUs work with PFNs. This is very much an intentional design choice.
> It ensures that the KVM MMUs remain flexible and are not too tied to the
> regular CPU MMUs and the kernel code around them. Using 'struct page' for
> TDX guest memory is not a good fit anywhere near the KVM MMU code [2].
>
> Use "kvm_pfn_t pfn" for type safety. Using this KVM type is appropriate
> since APIs tdh_mem_page_add() and tdh_mem_page_aug() are exported to KVM
> only.
>
> [ Yan: Replace "u64 pfn" with "kvm_pfn_t pfn" ]
>

Thanks for your help, Yan!

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Link: https://lore.kernel.org/all/aWgyhmTJphGQqO0Y@google.com [1]
> Link: https://lore.kernel.org/all/ac7V0g2q2hN3dU5u@google.com [2]
>
> [...snip...]
>
