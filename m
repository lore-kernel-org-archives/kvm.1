Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EDA19D89E
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567183; cv=none; b=mdXH8DGtdBNyi1ZtO4V4Ge7Gf115tKLGRjX91IUxYTL0fcA2GCKgQjOkVxHNOBLy5oulLpQLzBjzh7kfJi7eHSnw8aVJdBn4du8jH0H1gNYsH3Wd+4PIn35/zLNpdnzZNQtiANUOAwE+/ySXlBszx+zWtIGCDhFplqMP5nBcsaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567183; c=relaxed/simple;
	bh=MZvk3XawI1zyNZtjsA0KB3dVTCMPEwIxxwz9Rq3Z0V0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lEMCo7/wiIl7ugQlL0vwn9y2EjHG4Pd6XkDg9SlJJOHzHp5piwfldSxmqGP/9cPnzBjs4XWgh4sOHYHza8UdH3TV5wJtZtUHMSWHMXwQliskvjKotGdvQ5ypAB4yzOmy4hxFIgOVtqqfLZx0L9+BNktrjNns6NrjpmEYqva+eV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUgZzP2z; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUgZzP2z"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2f1d1e5so1989280a12.3
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 16:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781567181; x=1782171981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1v0z5O2hMK9AN1iypwUpu0g1rCwfm8MEubwWooIlZAg=;
        b=qUgZzP2z2OP3zS+DJ9mlLl8Cn+jDy9CmDIZ+Nwn+swOUHcnUk+vDLdi6iotTmw5FNt
         4cEvPjOhzMW14ztZNuD4G01p1fg0qGJvEXr1Ay7vO8jEnCoQR2zxsi55l3zFVG8Pk72r
         rbD3hZq3s+i/q/B1z0fZRDzgiz3b2T8ZNiNgRji0QA6gEX12Xb59qCDPRpzWycRLHyAb
         cxNrWw/ZFe6jiy3E60Yyq+DZYEAu7n5m5VWlN0asfc97p5zyzcFwKd6VvqOE/3xbYIvl
         kXcVeYwZ5kBK1XBi/P4OsQidk2pfhiHz99MRjnUhbB0PsbVrcVll1b0CLx75U0AacjVK
         r72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781567181; x=1782171981;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1v0z5O2hMK9AN1iypwUpu0g1rCwfm8MEubwWooIlZAg=;
        b=oVDH0L9OKwXUTbDGLosCvRkfckGBBhIloS+cvpB2XuZzKOWvKDa/TuzgsvZZ8vaRn0
         sBiMG/YMvmHyI1Z4Xze9DZFCed4rCjDcgCekkCGryQdpJuAAO/auDgmhIqYyQomVw5pt
         pVe8mc2ekRy1VqfVZY8srg4B/Zaw5g1io6N5AfiR9AT3uaTcqnO4PbTQ2LEp2IYF4SYr
         stBHF7J5ApCpm/I1qvvvgxNjDXKQRD++AcN5dnJVipaFye2DUM6Us4phk2+bxzKqns74
         r0vkYRDQuBeAwRSA+0MNAb89r9LimrVLC5czuhAHRZ7kFpkOA1RRB8WPO0k2HUdGj1sT
         Luqg==
X-Forwarded-Encrypted: i=1; AFNElJ9B26/MT6c08AUH1XoaIlFE1V70/oj1HCrvtlEnUigubqRc+lNiX7MK8HSuuSu9o2KysOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6NdnYhpFaqM4ByofXq3aQ2ThaatFiQkOBLHR73XBdKdp3/j0p
	KfFo2tK30t1lrKjkMCLUaNymwLdq7urIu1mnjTRpQ+pqavLNTqio/+FcMC9/1TA1W1D2i7bMXhT
	MtprI1g==
X-Received: from pgch24.prod.google.com ([2002:a05:6a02:5098:b0:c86:4cc6:2ef8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a341:b0:398:6ea8:21d2
 with SMTP id adf61e73a8af0-3b7e474f09dmr1309513637.19.1781567181409; Mon, 15
 Jun 2026 16:46:21 -0700 (PDT)
Date: Mon, 15 Jun 2026 16:46:20 -0700
In-Reply-To: <CAO9r8zNa+ueRh0hf-CJ8sdyOFrcF+nEc7S06ZkMmV=GAvum6hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612133727.411902-1-seanjc@google.com> <CAO9r8zNa+ueRh0hf-CJ8sdyOFrcF+nEc7S06ZkMmV=GAvum6hA@mail.gmail.com>
Message-ID: <ajCOzEV6zIVegeWV@google.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Expose number of shadow MMU shadow pages
 as a stat
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026, Yosry Ahmed wrote:
> On Fri, Jun 12, 2026 at 6:37=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Turn arch.n_used_mmu_pages into a stat, mmu_shadow_pages, as the number=
 of
> > live shadow pages is arguably _the_ most critical datapoint when it com=
es
> > to analyzing the shadow MMU.  Before the TDP MMU came along, i.e. when =
the
> > shadow MMU was the only MMU, explicitly tracking the number of shadow p=
ages
> > wasn't as interesting, because the same information could more or less =
be
> > gleaned from the pages_{1g,2m,4k} stats.  But with the TDP MMU, where t=
he
> > shadow MMU is only used for nested TDP, it becomes extremely difficult,=
 if
> > not impossible, to determine which SPTEs are coming from the TDP MMU, a=
nd
> > which are coming from the shadow MMU.
> >
> > E.g. when triaging/debugging shadow MMU performance issues due to "too =
many
> > shadow pages", being able to observe that 99%+ of all shadow pages are
> > unsync is critical to being able to deduce that KVM is effectively leak=
ing
> > shadow pages.
>=20
> Why not expose indirect_shadow_pages? IIRC that was also one of the
> stats we (mostly you) used while debugging?

Because it's a subset of mmu_shadow_pages, and I suspect mmu_shadow_pages w=
ill
be more helpful if we're only providing one of the two?  E.g. if the proble=
m is
that KVM is leaking indirect shadow pages, then either number will suffice.=
  But
if KVM is zapping old SPTEs due to the KVM_SET_NR_MMU_PAGES limit, then we =
really
want to see mmu_shadow_pages, otherwise there will be a blind spot with res=
pect
to direct shadow pages.  And if there's bug that's specific to direct shado=
w pages,
then we're probably hosed either way, because it will be difficult to obser=
ve just
the direct shadow pages (unless they happen to be the _only_ pages, which i=
s very
unlikely, but then we'd still want mmu_shadow_pages,).

In practice, thanks to the TDP MMU deliberately _not_ accounting its pages =
as
shadow pages, the delta between the two values will be tiny on setups with =
TDP
enabled, i.e. on practically every modern deployment.  Because hypervisor p=
age
tables are typically tree-like, and hugepages are, well, huge, the number o=
f
direct shadow pages in indirect MMUs will be counted in tens or hundreds, o=
ut
thousands or tens of thousands of total shadow pages.

> I guess for most cases, mmu_shadow_pages will represent either the MMU
> pages used to shadow the VM's x86 page tables (with TDP off) or nested
> TDP MMU pages (with TDP on and nested used) -- but I do remember some
> interesting case about direct mappings in the shadow MMU or sth?

Yes, there can direct shadow pages in an indirect mmu (guest is using a pag=
e size
that is larger than the host, in which case there are no gPTEs to shadow an=
d thus
the gva=3D>gpa / l2_gpa=3D>l1_gpa translations in KVM's shadow pages are "d=
irect").


