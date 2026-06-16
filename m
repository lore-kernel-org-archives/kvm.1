Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2F212564
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569218; cv=none; b=duXagpa4L5ZnKl3jcWArjlCXkL+YEBGfNYJq/lPnka8UkSwkOoLH8NuGTdpG6tT8X9UVAvOTkLazznO3b/QRM3jVCB7S130mrT+zLPjX+xS/CNfIBRK7tDpJ9OG9JVjMcaysNW29Ebn3u6AfGeJz+XwOzhjI9GELt2LInmYDHSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569218; c=relaxed/simple;
	bh=HP/MLYcu2qofsaAWH6o5C2ohaOug8WeA34uOkkSGKCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k/38q9xgs1k0TmID65nIRJ7LSYETh2fv/9/4vqJ/oYKtV0vY9MUPqQdNZ3+H9oEewMXhYVhAVkk7F21Zk6Yi0+o87jeDmhH5Gd07J8c+WCwynAMY2NmexDWKNR9no5GPJ7M4+s55Fgv1I5Ij0JE/peV8+phMrE/qd1KtiHQEFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LTVIj2u7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTVIj2u7"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8421ffff8a3so5060823b3a.2
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 17:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781569217; x=1782174017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlXlR0cDKLK7sPP85mOdTn35W6J39Q7tBkuBSzLoIYk=;
        b=LTVIj2u7FVrqLfRj5QXcTzpoYGVpfCvhj5P5GCexb76hdBrbIRCQQWzXqG9VBVh5zM
         1CnpmLCBDfBn5d1R5OAa5lzHoj80SceeZJZ/ubr6AAVMxn75klAsS5SmgVygOI+QHyYO
         /GW5zVRvIiduUahNLHIzvYHca0e1Wn1IhFxibxDj7aEubWZdSsF+ui5GP7HkzmeYIrOE
         5kU9FuAlGt1R2ZKDvlAzVPdnuRK+jjco8YvjTGzJF1K1+KAuKMMv2Twl9uxqE8vkz/Gr
         wuFLPODUEZ24jz5WHytD0RjZNpBp/oLntlMKMWOkyaBTJrvzlrqeOVcW70FvlrPVE0Hb
         68Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781569217; x=1782174017;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vlXlR0cDKLK7sPP85mOdTn35W6J39Q7tBkuBSzLoIYk=;
        b=hF1Q1kEH/vDpKLZpBK64G14sIxExRcddSJCkGNx/DCokAXdU5tq/JVSTW0tTORdHrE
         H7mwxqnoiEhDzQBfA7OuLckcwvNiQ64vS1dN3oYCGpbsUQxa4yYg6dca3/AllqMzaTlJ
         TljqK+tDoazjwCcNMHh+PgPr5cgrBL4erdgtn1U/BrIJvHELy5WEipwsbPLbsajl2CLX
         tUj2GtvSsE5NYAiWMhh7xC/m5aY8UQXkUeAgmYh5ZDSBs4wHGc8jxbwqR2cEWk75e9z3
         BTDlhHCrCTUbsKjIFRRYy3U/ldlAxnxsgcRLZBe+IOeTLyg9lE/XW8CQjftEGL2MKi5z
         F3UQ==
X-Forwarded-Encrypted: i=1; AFNElJ/AYUyIIKQNQ5SSppkJm6qP4Oeztxoh1zzIfJLJvBjEEZ+F1gP+jPHe3HSGZGgNObujeq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfYtO09AuhhGBQNwwSaPd0B82kfhfkHydCucWh7hSVEEX785EZ
	bv/xcalZ0rQW6vg1lcyWQps/ebmpbRm81HfLBcJQFzWtYO9DGmJwYeCwLl1vk6H4ZLHxJkQxT9D
	crqdUHA==
X-Received: from pfbjw11.prod.google.com ([2002:a05:6a00:928b:b0:82c:99fb:e874])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2356:b0:837:db4e:a35d
 with SMTP id d2e1a72fcca58-8434ce465c3mr17109823b3a.23.1781569216623; Mon, 15
 Jun 2026 17:20:16 -0700 (PDT)
Date: Mon, 15 Jun 2026 17:20:12 -0700
In-Reply-To: <CAO9r8zNqhUHCs=Q-jWUhQr8VJF7SgL-Kh4Ztji0E5vWpSB2UOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612133727.411902-1-seanjc@google.com> <CAO9r8zNa+ueRh0hf-CJ8sdyOFrcF+nEc7S06ZkMmV=GAvum6hA@mail.gmail.com>
 <ajCOzEV6zIVegeWV@google.com> <CAO9r8zNqhUHCs=Q-jWUhQr8VJF7SgL-Kh4Ztji0E5vWpSB2UOg@mail.gmail.com>
Message-ID: <ajCWvIiTDcYyjC-c@google.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Expose number of shadow MMU shadow pages
 as a stat
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026, Yosry Ahmed wrote:
> On Mon, Jun 15, 2026 at 4:46=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > > I guess for most cases, mmu_shadow_pages will represent either the MM=
U
> > > pages used to shadow the VM's x86 page tables (with TDP off) or neste=
d
> > > TDP MMU pages (with TDP on and nested used) -- but I do remember some
> > > interesting case about direct mappings in the shadow MMU or sth?
> >
> > Yes, there can direct shadow pages in an indirect mmu (guest is using a=
 page size
> > that is larger than the host, in which case there are no gPTEs to shado=
w and thus
> > the gva=3D>gpa / l2_gpa=3D>l1_gpa translations in KVM's shadow pages ar=
e "direct").
>=20
> I never understood why these are "direct" tho. Sure, they do not
> directly correspond gPTEs, but they still are shadowing guest
> mappings.=20

No, the *parent* is shadowing a gPTE, the child is not.  Overall, KVM is sh=
adowing
a mapping, but individual shadow pages are shadowing a specific gPTE in a s=
pecific
context, not a full mapping.

> IOW, if the guest has a PMD mapping and KVM has some PTE mappings, aren't
> those PTE mappings still shadowing the PMD mapping,

Nope, as above, there is an indirect shadow page with a base GFN that corre=
sponds
to the guest PMD entry, i.e. that is shadowing the huge gPMD.  And so if th=
at
gPMD is modified, KVM needs to adjust that parent shadow page.

But for the PG_LEVEL_4K shadow pages, i.e. the children, there is no corres=
ponding
page table, no gPTEs to shadow, no gfn that needs write-protection, no prot=
ection
bits to account for, and no additional lookup to do when getting from the b=
ase GFN
to the final GFN.

See the use of sp->shadowed_translation, e.g. in kvm_mmu_page_get_gfn() and
kvm_mmu_page_get_access(), and also commit 9ecc1c119b28 ("KVM: x86/mmu: Onl=
y
allocate shadowed translation cache for sp->role.level <=3D KVM_MAX_HUGEPAG=
E_LEVEL"),
which optimized KVM to avoid allocating unused metadata (KVM only ever need=
s to
query the gfn and access protections for leaf SPTEs).

> and still need to be sync'd in the same way they would if they were shado=
wing
> PTEs?

Ignoring for the moment that KVM never unsyncs PMD+ gPTEs, "yes", but only =
the
parents.
