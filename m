Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D5618C008
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598952; cv=none; b=Pr/CXeuZl+2UZYuNtjGxwWYVQ2F46j92UX39yc9FQpkVKhRa10CSYq08xSM2NgDM8Y6z59Soe7SrT8JmrHSIV63NpkKyT596q1sPlKgpZhKXI+OsAnyuWs7XIBWbKoMvHWwCfiMYgc/x2g8+FBsYti3ZmxRKB/YpL+4uOUsGBR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598952; c=relaxed/simple;
	bh=UI1JTGnTRkhg/YzWAk1s/Q6IgUGuMZVe5AfaJ5Cr5qY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eJ+AbELFf9Ve9kIb4gRfd2UmcdwSdqPmk4HZHBW3aCLUZ65nsqvpozflwCmLZVszZY/8YUIHyNKQF/31Dv+oE1An4ejNQqbIFqfAUzLol4oJSuttIkePmNhOWzdAnHiJ0kQxUZwbIuN48wesnjjYQ7ZuZi4nLpTmCUBB8PKFGRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG8kaM1D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG8kaM1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52957C2BCB8;
	Fri,  1 May 2026 01:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777598951;
	bh=UI1JTGnTRkhg/YzWAk1s/Q6IgUGuMZVe5AfaJ5Cr5qY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hG8kaM1DZSLP/NhWnpCzh0k/uz4Qw2q/mx08rS2tGGCUKipCZitLubMSdbX8t2FwE
	 rI8uvMkwATVxic8cMi7+IpN6C7z1Mla3knqBD4zEAYgrDJv3PQsB9GCcnbuMFI3AlO
	 Ti32g2lPsgU9no2OZKFRzZOOnyXXgT/N8z3ha2EtqP49XI8vkiIqePwv8c79O4pU88
	 efRaEUJ5gYKBIHPYaRtmzq1jIYu3KePGcp3OcZ+2nl1TsDFj9E3dKOjBAu+wlkF5jy
	 ah3A42u9Y54deTeyEOu/Ox4zJO1+0vVPHJDKw/wW9QmWThr1YqC6Tq2arGxWE0Miss
	 tBCFNkWSOcfRg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5DBC4F40086;
	Thu, 30 Apr 2026 21:29:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 30 Apr 2026 21:29:10 -0400
X-ME-Sender: <xms:5gH0aT1QvMsAJ_m88vJLQrGZ9IPkmxaA4Ldnvr1K9R70_3HPyg_DCA>
    <xme:5gH0aRLz6Vt8rYLIVrhhQXcTmG-5ABH0btmTt26JD8zMQNzPmPhfkKT_qGC0OH794
    xkO7G5nsTWvBr25-_kLrYMJg_DMVJm1UGwElgbthrYOod6IQM8zXvI>
X-ME-Received: <xmr:5gH0aaFoI5d5KOU9aZJqvz_Ym8sxgadS9G7G-pAyyKURwoQsXP3b9wJbSS3CQTVptRprM7JNgcbUcp8_DOvZI86E6MLeDFaYLYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtqhertddttdejnecuhfhrohhmpedfffgrnhcuhghi
    lhhlihgrmhhsucdlnhhvihguihgrmddfuceoughjsgifsehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhephfeijeetkedtudevueekveehgffhgffggffglefhfeejtddv
    vefhudffveekkeevnecuffhomhgrihhnpegtohhnfhhiuggvnhhtihgrlhgtohhmphhuth
    hinhhgrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfe
    dtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehjrghmvghsrdgsohhtthhomhhlvgihsehhrghnshgvnhhprghrthhnvghr
    shhhihhprdgtohhmpdhrtghpthhtohepughjsgifsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhitghk
    rdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhvmhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghlrdhrohhthhes
    rghmugdrtghomhdprhgtphhtthhopeihihhluhhnrdiguhesihhnthgvlhdrtghomhdprh
    gtphhtthhopehirhgrrdifvghinhihsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:5gH0aVVQabEVZ1GBCGUqz7NXGQY9ragtMDaJN5397LLJUVclYcT7Mg>
    <xmx:5gH0aawgnhTLX_C8NKBpQJGRRt4ocTOplYsB5XFOwtAjnHY3P2UpYg>
    <xmx:5gH0aSRv9v83FkiLkJqmK6YGQlZci0Ild4BUI_gejSzBm5l0OO_gxg>
    <xmx:5gH0aej6upM5GMsCi6R8vHFSxZfkhEnXTfzIk7UH-CV-RLnF2Xehxg>
    <xmx:5gH0aRklnZTS6SUJf-qznWBohpbxwg56Oc76i-uWJ80dYUvTqhoxnLHX>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 21:29:09 -0400 (EDT)
Date: Thu, 30 Apr 2026 18:29:08 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Dan Williams <djbw@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "michael.roth@amd.com" <michael.roth@amd.com>, 
 "Xu, Yilun" <yilun.xu@intel.com>, 
 "Weiny, Ira" <ira.weiny@intel.com>
Message-ID: <69f401e46ee72_2fadd10073@djbw-dev.notmuch>
In-Reply-To: <96b0938a2ec7a83c7d2010c6a363e8417749cc27.camel@HansenPartnership.com>
References: <1f6e9052c0c748f023e880503ed0001a9a919599.camel@intel.com>
 <CABgObfasYTWmuqkz4TaTprcivwkzKGxAjdYZJVgO66HB1wK-5w@mail.gmail.com>
 <69e19cf75b5e9_147c8010018@djbw-dev.notmuch>
 <96b0938a2ec7a83c7d2010c6a363e8417749cc27.camel@HansenPartnership.com>
Subject: Re: PUCK follow up: Trusted IO call details
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Bottomley wrote:
> On Thu, 2026-04-16 at 19:37 -0700, Dan Williams wrote:
> > Paolo Bonzini wrote:
> > > On Wed, Apr 15, 2026 at 8:59=E2=80=AFPM Edgecombe, Rick P
> > > <rick.p.edgecombe@intel.com> wrote:
> > > > =

> > > > The call I mentioned is officially called: "TAC Subcommittee:
> > > > Linux Kernel Special Interest Group (Linux Kernel-SIG)". This
> > > > seems to be the info:
> > > > https://confidentialcomputing.io/about/committees/#Linux-Kernel-S=
IG
> > > > =

> > > > Paolo, unfortunately I did remember correctly that it is not an
> > > > EU friendly time.
> > > =

> > > This one is friendly (9AM PST =3D 6PM CEST). The unfriendly one is
> > > the IOMMUFD one (5AM :)).
> > =

> > There are couple topics at present that would be suitable to raise at=

> > the EU-US friendly time. Specifically whether all of the per-arch
> > implementations of "transport large attestation evidence blobs over
> > shared memory from host-to-guest" would be better served with a
> > shared generic transport (simple virtio-pipe / something equivalent
> > for vmbus to publish).
> =

> Sorry to be a bit late to the party, but why invent a new thing
> (virtio-pipe), why not use the existing virtio-vsock (and hyperv-vsock,=

> so no new vmbus device is needed)?  If you're thinking it's because you=

> need a simple cat into host and out of guest, then you can do that with=

> the ncat --vsock utility:

I missed replying to this while I was on break. The problem with
virtio-vsock is that it is built to terminate in guest userspace not in
the kernel. I want to see the same flow for bare metal retrieval of
device attestation blobs as guests, which points to not having a
userspace indirection dependency for the PCI core.

I have also heard concerns of the complexity / availability of vsock
early in the boot flow (firmware?). For that concern a "simple" pipe
protocol, like drivers/virt/coco/tdx_guest implements, pulls the blob
over instead. Except, now we have simple drivers/virt/coco/arm-cca-guest
transport, and simple drivers/virt/coco/sev-guest transport all
duplicating blob retrieval over shared memory with payload size quirks
and bugs.

The problem is about to get worse with TEE I/O because all of these
archs have defined extension blob retrieval interfaces for the new PCI
material. That duplication is not in Linux's long term interest, so a
common "blob transport over shared memory" implementation is the
proposal. virtio has already done the work to handle arbitrary data
transfers, no need to reinvent that wheel. The only hangup is that we
would still need a vmbus filter to feed the same mechanism.=
