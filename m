Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E50035B651
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 23:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775173564; cv=none; b=rXpuuA85tAMsJZEBzih36I9BxHMdWp9aBdL9mwxOzdczUNlPyBh78spkTPDLCiwkYqdpKX+eCafPnSEZv2U82FrRpIcWsbolGhFan5yEikFwlGoPSunj5eyg4qmZzz4Lsn5XrWaKITWazL594pdo3Cdu1fQH8yyBwvJA6RN53wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775173564; c=relaxed/simple;
	bh=sMkwJRRm6h1x6QyWZTJH+aX5zaPLMYQe7o6L+QM0rFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dh73ol+XDtPWvNA0zFaeeXHT2k65cZFJ/lxVrsGLdhkHufQ+l8Gqz81mf9Wv7JHUic6RQa5s0bWQslP+I2ix2pOBdMdQKQgH56/4SRglfKF/QWhDAk4HbzoLQulmYmE6CFdXnIQE6gm2Aqg8KXXGA1QhKNdcNPtqjy/xjuXi1/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjHos49j; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjHos49j"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so927382a12.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 16:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775173563; x=1775778363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wBzZnyzYqE8q8BPqM8LP8G//b/Lm4z/jG0ORFAET/o=;
        b=sjHos49j3QgooYzboxEE+PFKaX+MzS9OhUgWYfAAQ5Kz7rEvfYaZP8AJ0cX3lcgfXF
         ZSeZ6lEEGsMzARLdrCNuymcjiTiUM2zHvhCb/nhwind7C9kLlatjIpSLP4TEJreK+YQA
         v/KVc3sjcPXoCXJeYWRksnt1efRAKumfRUB3hUAr8Y23eht7xHpfrZQUv6U8GUQdftzs
         kVTgR3w5aS9QZUtCgFNUYVq4T1gRf5vei2ZI8g8Umw3ZnRfUxRKyMlhfYYMZb22cclHG
         T4pVLy17/R5KJMNEroxay6H7435F3FgqgFD2a93J6K7PxvuTg2AsdPgCTPbhQbL9/vIa
         Q0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775173563; x=1775778363;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/wBzZnyzYqE8q8BPqM8LP8G//b/Lm4z/jG0ORFAET/o=;
        b=oFDvqC4gRKCvSbYpEgMkLRNmO7FDgNz9NpzGxNhcka/UYIWfG6fTTxAqKEgm6FJtXv
         wFiIfoM1XGHYXSyIw1/yPAULHIJXEnMjQQOm8Wk3WFqRlXooXdxkYCGJwq9sU4g1LL73
         9Tl7o/IR4wXAKMuk9uAE0caYAXLQQi934CgV0ESxTlhi9eV+HXFeQyzDiUxZmrXFyI/x
         QTC4iNTOJiXejXflmhKMIvCZMF5KMa0MGrcfNM3soj9/Uf0eUOyPzayN2WApyVMhOcWW
         SYgqk57iuXMa9ZEi1syVaoG4fReGRhkRXZQ6Dc3DYX6ZVFg7jjZKWFXN643TQ/BeJck7
         7SSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl/FiqgWuUiOWZuMfkKafPelHPXuApBNP0yzhj5g79pGg1hnT9pVSDEr7TrDsY1I5k2II=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIp89rgI7PrU+HrXXaNCbTpF3D0Pv2PFelg8GCL/1/3e+QRBKi
	RAm5VPMVfmPaLwE4T3Dx9yJm9SNKHpyIOqgpfcxXCZL+Rn0YEnfLtlnIpj/fOkajSGxttPj6e7/
	3vbiayQ==
X-Received: from pfrh12.prod.google.com ([2002:aa7:9f4c:0:b0:82a:6e03:a17f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3902:b0:82c:8c6a:682b
 with SMTP id d2e1a72fcca58-82d0da6a4efmr844869b3a.19.1775173562802; Thu, 02
 Apr 2026 16:46:02 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:46:01 -0700
In-Reply-To: <4f0a5d5f7b743e3872547e14d02b894cd9f60550.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319005605.8965-1-yan.y.zhao@intel.com> <20260319005703.8983-1-yan.y.zhao@intel.com>
 <CAEvNRgGknoP=QscA-efLB0LSS03XttsdN3v0KBVROAXTknAakw@mail.gmail.com> <4f0a5d5f7b743e3872547e14d02b894cd9f60550.camel@intel.com>
Message-ID: <ac7_uQc5t0uU3a1h@google.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "ackerleytng@google.com" <ackerleytng@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "sagis@google.com" <sagis@google.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"kas@kernel.org" <kas@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2026, Rick P Edgecombe wrote:
> On Thu, 2026-04-02 at 16:23 -0700, Ackerley Tng wrote:
> > Yan Zhao <yan.y.zhao@intel.com> writes:
> >=20
> > >=20
> > > [...snip...]
> > >=20
> > > -u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, struct page *page, =
struct page *source, u64 *ext_err1, u64 *ext_err2)
> > > +u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, stru=
ct page *source,
> > > +		=C2=A0=C2=A0=C2=A0=C2=A0 u64 *ext_err1, u64 *ext_err2)
> > > =C2=A0 {
> > > =C2=A0=C2=A0	struct tdx_module_args args =3D {
> > > =C2=A0=C2=A0		.rcx =3D gpa,
> > > =C2=A0=C2=A0		.rdx =3D tdx_tdr_pa(td),
> > > -		.r8 =3D page_to_phys(page),
> > > +		.r8 =3D PFN_PHYS(pfn),
> > > =C2=A0=C2=A0		.r9 =3D page_to_phys(source),
> >=20
> > Perhaps in some future patch, are we considering also passing pfn
> > instead of struct page for source? Would we also update
> > kvm_tdx->page_add_src to be a kvm_pfn_t?
>=20
> Can you remind me, with the new API we were going to do an in-place add r=
ight?
> Then I'd wonder if we could maybe change tdh_mem_page_add() to only have =
a
> single pfn arg.

No.  In-place ADD will be supported, but it won't be mandatory.  Practicall=
y
speaking, we can't make it mandatory unless we're willing to completely rip=
 out
support for per-VM attributes (or at least, per-VM PRIVATE tracking).  I su=
ppose
we could require in-place ADD when using per-gmem attributes, but I don't s=
ee
the point given that TDH_MEM_PAGE_ADD itself takes a source and dest.
