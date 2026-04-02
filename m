Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88E37F75A
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172948; cv=none; b=m7AY82aFoPUj7atZVUeFKd525PAJIhVRCgPVGEXi9OpEp74au0P2eJcM9FeMTXe+GOnjxdyX7Hce97OPawbMBgUADmIriPdCUAC3t7CZNsk+VMyFRug608U8lkEx/xu3zAOcojQsMhySr57eQj0vCdV10foi+inrfsLMHOvMYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172948; c=relaxed/simple;
	bh=qTEpyjbyHUq8In6TOKNr9toPTGYwjz+iaKpJIBBuxJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cwc1KIyF+K3M2E3qTH1vzf+B2DGvpfgig1kB2hxhUAp2EoqApeziaLbHS3zdfmLUjJ8hMUQ87WB1HS3dEcie3pg7OEvRA0GHcG9cu+03hCgO10NUF3wLFNedPvSxf6M0TglwCyGcAyOlWZda1AV7EgpaBScQBEDiV6HGemsT4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJBSzvSv; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJBSzvSv"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76b6ccf298so870592a12.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 16:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775172946; x=1775777746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xt03N7DxSFnebsLjUZPOloGXKpbWKI0ZYVGhb08HfFU=;
        b=bJBSzvSvtvOmePEg4/GmtY0HFZxRr/qycITqFAaiIKk3ZVwl+DF1dFfMp7qxKm1jrq
         AWX/+hE39g3MQHCjJ2noKyUSAcQBuCodWQ7y5sZch6xNZEnogp76NnUcEK7e0B5u7JYw
         cY38PaoAyxx8BHKb2Vn2s1ZGkCUOHd/MvyfD5NMUErqJ/n45xud82W/uLRePjmNfYK6E
         JPTzfkXVLE9OZIaFG/wM5vLOf7pmphuF0ULgoupIxP1Z/fkqQQxvOhnhqqwoz4KiDO9g
         HwLWa2jwVmOt3TEndXfAsXJszF6gnVRXTC27jvbfxhb+27grabJWAn3kJ8SU5jijt15H
         bFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775172946; x=1775777746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xt03N7DxSFnebsLjUZPOloGXKpbWKI0ZYVGhb08HfFU=;
        b=ZcpkPt0L9Qekb+363wdoNo11nYUpzoD4kNEKb1w2/5kPFbpEBFwQrny4EEUyhS4AGb
         e3eqT4LGKOjCHLxmXPKOJ6rVPoUdLg18UVRKfv9DYofXiBfmMsNj/IIgLFAsYfjYxfj0
         GCt/txMOB7+qepRCttMa7KK3xe6SbRtDLYYdzN61dFiqwpnmBNjFHkDhvV4U3qSc7QNE
         pe0NLWMpx1llizw3l5uAD2QKS8nOkQNHmeYW23eaTIGBP46LETEFFDlcD++bJxeoHwJ7
         AbwLETf/H9m8PqnnSlJd/6byBuOtwU9vyjErM7Ct+6LPhYfObW/KgNDSrFpWsDoOXjKI
         liRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9ifWH4cXTzJQGvzvMqQDfe2Sb/8OHqjQkNIuVBSBk9zfXi76SAsYx9+8KLP9njFYM8tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHh7pKBcIOSWphi5WdlYr2X4mKdcLScBld0rFCXdk/J+EJ161
	b2i8TsK00VNUnYdCGInaAbP04W2Dn1nj0vd57IMbDxNoVxk7amlpWV2P9uLv+Y1U6ix0tZH4v72
	7pRO+Ww==
X-Received: from pgcv5.prod.google.com ([2002:a05:6a02:5305:b0:c73:9a1a:387d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3951:b0:39c:50b4:cd50
 with SMTP id adf61e73a8af0-39f2f19b018mr622103637.61.1775172945555; Thu, 02
 Apr 2026 16:35:45 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:35:44 -0700
In-Reply-To: <CAEvNRgGknoP=QscA-efLB0LSS03XttsdN3v0KBVROAXTknAakw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319005605.8965-1-yan.y.zhao@intel.com> <20260319005703.8983-1-yan.y.zhao@intel.com>
 <CAEvNRgGknoP=QscA-efLB0LSS03XttsdN3v0KBVROAXTknAakw@mail.gmail.com>
Message-ID: <ac79UM6t0Y0pWoRO@google.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, kas@kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, kai.huang@intel.com, rick.p.edgecombe@intel.com, 
	yilun.xu@linux.intel.com, vannapurve@google.com, sagis@google.com, 
	binbin.wu@linux.intel.com, xiaoyao.li@intel.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 02, 2026, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> >
> > [...snip...]
> >
> > -u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, struct page *page, struct page *source, u64 *ext_err1, u64 *ext_err2)
> > +u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *source,
> > +		     u64 *ext_err1, u64 *ext_err2)
> >  {
> >  	struct tdx_module_args args = {
> >  		.rcx = gpa,
> >  		.rdx = tdx_tdr_pa(td),
> > -		.r8 = page_to_phys(page),
> > +		.r8 = PFN_PHYS(pfn),
> >  		.r9 = page_to_phys(source),
> 
> Perhaps in some future patch, are we considering also passing pfn instead of
> struct page for source? Would we also update kvm_tdx->page_add_src to be a
> kvm_pfn_t?

Probably?

I assume you're asking in the context of in-place conversion, where KVM will
allow a single guest_memfd page to be both the source and the dest?

Right now, KVM requires the source page to be a GUP'able page, specifically so
that KVM can obtain a reference and ensure the page isn't freed until KVM is done
with it.  If/when the source and dest are one and the same, then I don't think
we'd want to GUP the page (and there would be no need to since this would all run
while holding gmem's filemap_invalidate_lock()), at which point, yeah, passing a
"struct page" doesn't make much sense, and passing kvm_pfn_t or u64 or whatever
seems like the obvious choice.
