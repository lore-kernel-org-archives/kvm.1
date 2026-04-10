Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D8B346777
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859651; cv=none; b=Rqv+/TE5jbXTqllL+/8Ff+CYYeQQqlWlEqZg0jV9oAJ8CWbbrSy4Lnrd7Q7+UuB+mz7AhtUC9zhfi+VapaWeB9lNmqZvNl3Q67kgcIgx3A4VAfPREi7bf+xNP3IhmWNB49n+0pKsT1kcoNFBPQQKD8Pal2d/ebTOjTK+GwCgSVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859651; c=relaxed/simple;
	bh=g3NOMGmXLeaY5Hm+6uXFs9vOKwGtQmC5SUzaeEBOJzE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nafFSrnb4Hs20z2ysiu/vhkxZ9ryGcj3vGGX1fSlnnm6XtTFqJywZlWUePmObteacPZmB1dmEwhuQVYPr++dNlYenhIe5KulCPj6+kodSCWheNxgsGxrWuSTDxOjFQmFHN3tXVMJt2CS2+Q7MIWDZfYOr2tp89GObFHlgvl94rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USumkm4B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USumkm4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BD0C4AF09
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 22:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775859651;
	bh=g3NOMGmXLeaY5Hm+6uXFs9vOKwGtQmC5SUzaeEBOJzE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=USumkm4B2wVNzIw0wKck+EL/nqccNrJp9ge/CGuM1yo3/6OmuKX4W8KGB8bMyhLRq
	 SjSdrUVgDi/cE3Boc242xZNHmFxota2wCITPmBloTYLmw0imr5TT1s71HKYTbpI7lN
	 9RLPLMk1c+CW/nEypqWnEIHcgLToJo6CYdadmFlbbkT3FOJXEyXVqFk/4OVZJ3TL7H
	 ooZz1s8rssCHLmG5fCqbMT1YatrPmbtILIVc/GJgRoqb1vzzYwXjnsMv8q/bj9pXaU
	 JjezfsY+3S7iXdNGz1511fHDLtdB9/dlvEz/l2P4SsY19oGR5RWWovfznasZ8kHm/i
	 oykcHo/tTR82w==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5779DF40081;
	Fri, 10 Apr 2026 18:20:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 10 Apr 2026 18:20:50 -0400
X-ME-Sender: <xms:wnfZaQ0tEpWNdQxzgxFRtAoMHreBA5O321OYYxWsdPmaqgv_TlG7Pg>
    <xme:wnfZadXgAJpa0irMUEkZd7iXaXWWVYuYmWhlFTZ8GFLIEpzs5nwvA9No6E0CgAwHl
    D660_tNI5qe0C5seBPYXfj7QxoXO_XyItG9Gn2ztg70pt59ey0jQA>
X-ME-Received: <xmr:wnfZabL0_kGKCSJ4phfRv8CZQcoGRxPS-MItOgSBMWCI4o-YHhx8kKSFUsIhoMitZLQum0L3XHfa74WB_X968dwJ24KE92CPcCo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elhfeiudfgvdeijedtleeltdduueekffejjedvjefhgeevjeefueejledtleetjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsvggr
    nhhjtgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsvghiuggvnheslhhinhhugidrihgsmhdrtghomh
    dprhgtphhtthhopegrlhgvgidrfihilhhlihgrmhhsohhnsehnvhhiughirgdrtghomhdp
    rhgtphhtthhopeihihhluhhnrdiguheslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:wnfZaf2JLahKmi1-7SrINhuAHPCmUhbVIoYRfviAq9TSJg8WIEkQYQ>
    <xmx:wnfZaR7jTWhryO2SFaNKD_WAU3qu5dTPBD2jUzDm1JCh5OJAVSTyxw>
    <xmx:wnfZaY8HLBmVWf8YP2O3Jzy_pT_XDDtERI4ewQeNG0ab9M2ugAuOKw>
    <xmx:wnfZaYUNOLRYXY3588F4bG0jU2Xty3z5MJNPVST1fw-OyqxQ_r7G6Q>
    <xmx:wnfZabo6CHNBB1sQ05cbo9LvG4qrqu-SLpEWb3b2iMAtz-Ouq3S98qMh>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 18:20:49 -0400 (EDT)
Date: Fri, 10 Apr 2026 15:20:48 -0700
From: Dan Williams <djbw@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, 
 kvm <kvm@vger.kernel.org>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Alex Williamson <alex.williamson@nvidia.com>, 
 yilun.xu@linux.intel.com
Message-ID: <69d977c0b367a_6c31a10021@djbw-dev.notmuch>
In-Reply-To: <adkFk3ZN4HJtpLA3@google.com>
References: <20260407180107.1603697-1-pbonzini@redhat.com>
 <20260407180107.1603697-2-pbonzini@redhat.com>
 <adf29Rn7q9Db0hxc@google.com>
 <CABgObfZQ8kcdfiaUyGi6AcZErJztEmcdTcLwo946qtXfUwDM4g@mail.gmail.com>
 <adkFk3ZN4HJtpLA3@google.com>
Subject: Re: [PATCH 1/3] VFIO: take reference to the KVM module
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Sean Christopherson wrote:
> +Dan

+Yilun

[..]
> I added Dan because the PCI TSM stuff is picking up "struct kvm *kvm" references,
> and I want to head that off too, i.e. have it use the file approach instead of
> whatever it plans on doing (can't tell from the code, because there are no users).

The PCI TSM *reference* for 'struct kvm *' will be inherited from
vfio/iommufd. However, the TSM driver needs some context to manipulate
the VM. For example, TDX effectively needs:

    to_kvm_tdx(kvm)->td.tdr_page

...for operations like TDH.TDI.CREATE that sets up the context for the
privately assigned device.

It could follow the example of arch/x86/kvm/mmu/page_track.c and do:

    kvm_tdx_tdi_create(struct file *kvm, ...)

...and use file_to_kvm() for that limited helper that does not need to expose
'struct kvm_tdx' outside of arch/x86/.
