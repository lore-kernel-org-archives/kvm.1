Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B62E1F02
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545637; cv=none; b=qwaJuntxfR+prBQLq5PaNz+AZbvR+6e74jxRdtIijGVS6875pZGelghkQa+7BTyI+WG+mBTVHbY8BYy3KiTj/nn3vdQtDmG9KchBHj1jiOsdk0xz7qsSxGGW7/D03rJFseQSMKIsud0h8r/nuFvJ1k6EkTFmMynh+GE+l1R+HTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545637; c=relaxed/simple;
	bh=2wv4DrmR9rVmtjiewqbUMk/LFbbWJqr8zKExRv8iTCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Arh0s1m2qZCo8J5Ut6qc2p1RdA1TCyk1eyFt2U40fy8ZjtaEQzJDJGRnFojRszqKGWtBTamPUV4FD5uwFhexTGEa6Hpc+naAOOIeES6MflCJebx0kZ2rEinYl5EwrMN4ubKvHkJlCByGg06Od7yEGx/nkF1Jo1mMbI3/058jN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jglhkM/7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jglhkM/7"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8581f7723aso1726809a12.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781545636; x=1782150436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VDX/a34KwI6qjOxB+SOsUTAEqmtLSVOgiOVOtsI+2Y=;
        b=jglhkM/7pOYEEHiiVjUzmrzRLf2JbJjsK/E2VAxp0fueOkATEK3vbGFkKOcb4BnONt
         kgVcBAYyfNYysIVPFqWpNEQ338m1IjBxfZxjww1bUG2ymBe2aBkx0CW8aoJm8KhlzYja
         2SkSEZbYmg9MVeyp90pnhijT+BrG3e9a+lZeshszQjE2Eo/vman22trpyAzT3PfJ03cU
         iWSjk67gZP9MxfBtFZyGuIOA5MjPr97OjwqTpM7WAGjE+5xRNIZ4ybZ3KR8urZpW7rkZ
         zmSwhglj7+UaA72GKlen+I3+H7d2NuE4cf1UjMyIpxb1DjSxF7cuQ8tUHiAVFkGy9Hmv
         e7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781545636; x=1782150436;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+VDX/a34KwI6qjOxB+SOsUTAEqmtLSVOgiOVOtsI+2Y=;
        b=jlfgokgyQf7kLVUqk3i1/xWCnjlorlhjcBHmdZ9xhjnsEsRbBIicN10Y+b8HicsHp2
         mbgzU6kRIVkNB+tmcF7cBO7xqRhOuNKI1m4TzNpfjkiE6eBng3HBNKP2qiBPZMol54FF
         WwW8vMaCoX/ED98+xHXS5/g+tCAs81GaChVQlCWJjdmfjEbwmozh1RkpFcVaFljLjhap
         epZsJmHrz6tAG//6AG6zJJ5agwn4HTKIbnvpZ5dRJ/MoLAgA7OMYHjIqmqc6J7g75Fwk
         eVpXGzd2woytxf+ID9PgCqv7weof4/F7Mu85IpNYE6Dn9QLJ/Id71sOYldjDjstIrq/y
         U5yA==
X-Forwarded-Encrypted: i=1; AFNElJ8s1zbkb9YkOI34riMesOhdn/udksJRldlNnAl6SVO4AlUiVp5pD5f5+RP6ORijWON8rvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHTxrqkVQnHstMJaK3xFjb986AReSaYF1ZLU3NgvS1xSHRsrlA
	4sCsh8298LVvlTHKmYc6k2zWOCRf1kcznxPdRTkjSYW6yXd3sb8stwfVR6xCHJny/N1p7Esw1T8
	Nczc1xw==
X-Received: from pgaf19.prod.google.com ([2002:a63:3813:0:b0:c80:2656:4e70])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3c89:b0:3b3:241f:66c6
 with SMTP id adf61e73a8af0-3b7e4cf86b3mr95295637.26.1781545635135; Mon, 15
 Jun 2026 10:47:15 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:47:14 -0700
In-Reply-To: <20260615160901.9A1A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615155244.183044-1-alexandru.elisei@arm.com> <20260615160901.9A1A61F000E9@smtp.kernel.org>
Message-ID: <ajA6ogaNiI3KDv5i@google.com>
Subject: Re: [RFC PATCH] KVM: Ignore MMU notifiers for guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> [ ... ]
> > @@ -592,6 +592,10 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva=
_range(struct kvm *kvm,
> >  			unsigned long hva_start, hva_end;
> > =20
> >  			slot =3D container_of(node, struct kvm_memory_slot, hva_node[slots-=
>node_idx]);
> > +
> > +			if (kvm_slot_has_gmem(slot) && kvm_memslot_is_gmem_only(slot))
> > +				continue;
> > +
>=20
> [Severity: Critical]
> Does this change inadvertently introduce a regression in the pfncache ret=
ry
> protocol?
>=20
> Looking at the pfncache framework, it maps guest memory into kernel space=
 and
> explicitly drops the page reference after mapping it:
>=20
> virt/kvm/pfncache.c:hva_to_pfn_retry() {
>     ...
>     kvm_release_page_clean(page);
>     ...
> }
>=20
> It appears to rely entirely on KVM's MMU notifiers (kvm->mmu_invalidate_s=
eq)
> to invalidate the cache when the page is unmapped by the host.
>=20
> If a VMM defines a guest_memfd-backed memslot with KVM_MEMSLOT_GMEM_ONLY
> but still provides a valid anonymous user mapping as its userspace_addr,
> could this regression lead to a use-after-free?

Sadly, yes.  To land this, we would need to first teach the gfn_to_pfn_cach=
e code
to be able to pull directly from guest_memfd.  I forget if anyone is workin=
g on
that.

> By unmapping the anonymous memory, the host would trigger MMU notifiers, =
but
> this new check skips the memslot. As a result, kvm->mmu_invalidate_seq
> wouldn't increment, and KVM might retain a kernel mapping to a freed phys=
ical
> page.
>=20
> Could this allow the guest to read or write arbitrary host physical memor=
y?
>=20
> >  			hva_start =3D max_t(unsigned long, range->start, slot->userspace_ad=
dr);
> >  			hva_end =3D min_t(unsigned long, range->end,
> >  					slot->userspace_addr + (slot->npages << PAGE_SHIFT));
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615155244.18=
3044-1-alexandru.elisei@arm.com?part=3D1
