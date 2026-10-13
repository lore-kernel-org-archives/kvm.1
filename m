Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF9525A81;
	Tue, 13 Oct 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905192; cv=none; b=ut1W/DhovEXVK75redH0YBqmGeoSeYdiONv1QGovMTfEwHsItjp68azcmJXvWWaO9sVU1Q7xfW9KQyCB73eqertARrwMHBHt5a3anReC13aHxqCQZYSIlOuZ5cPoWel018kL7Wh5GRaJ1HVCiPcD+pe13wzCrqZK0AhY76CQAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905192; c=relaxed/simple;
	bh=m41TWuEwJE/xRh75rAG2WPfrBRVB2yumdIRDiH0i5tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e42lWJwSWLRoVxYeQWXwIbi4DZP+yucP6ckzJgUE62OpTRKVQI+wvP39WtZOEHRkO/52PXFVInUBF/jvKXF/cgiENsQP7MBTFGHWr3WssCkE9fSFZs6IFHgayovCcqdY6rKHwWR7EDz1d4OA+ERkFXPqIId9m3BydkiGHPwl5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=IAkmGGUt; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="IAkmGGUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1791905190; x=1823441190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=58rhhcexDgMk2SYcHRrbfJU4LmZDNf9c9uP6HmDCZ0M=;
  b=IAkmGGUt0Xe/jYZo2x1vxV6S4ue2QmzoLby2TnX7Xzza0cz4JjwEC55d
   uUaDBKg6/tFwqdEuYbVhsEz9no5iXZyjdP86E33dt2gbGMVsay0VpSz5d
   LWu7hiP97kxR6/RoTKphiHh06qMNqwOGizDa15n/QiySTR8ctpc4Z3+/y
   zUpuomzPBr7Dys2IWixNpySfLOdTJMkkzDSxHIQtrOfcVetpApryqslp5
   JPNszm2dPg1bsyEAPGYXjGtU0SXsjfTN5GIoWEeNy16HGdYKlxIjvr68H
   oeWNqxzIqSKZizKBe7tX6LhD0nr+YoeMgU/ig/01clG1MOdKhFvPHE+4D
   g==;
X-CSE-ConnectionGUID: QNr8tit0Su634Je3FESKKw==
X-CSE-MsgGUID: taFEz58CSvCZwrQ9VLnCQA==
X-IronPort-AV: E=Sophos;i="6.27,155,1787011200"; 
   d="scan'208";a="31173283"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:26:27 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:10673]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.175:2525] with esmtp (Farcaster)
 id 13393493-f492-42db-9553-1d180b22329e; Tue, 13 Oct 2026 15:26:27 +0000 (UTC)
X-Farcaster-Flow-ID: 13393493-f492-42db-9553-1d180b22329e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 15:26:27 +0000
Received: from b0f1d8753182.ant.amazon.com (10.106.82.29) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 15:26:20 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: Yosry Ahmed <yosry@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Brendan Jackman
	<brendan.jackman@linux.dev>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Wei Xu
	<weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
	<ziy@nvidia.com>, Lorenzo Stoakes <ljs@kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, Sumit Garg
	<sumit.garg@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
	<rientjes@google.com>, Roy Patrick <patrick.roy@linux.dev>, Andy Lutomirski
	<luto@kernel.org>, David Kaplan <david.kaplan@amd.com>, Thomas Gleixner
	<tglx@kernel.org>, Patrick Bellasi <derkling@google.com>, Reiji Watanabe
	<reijiw@google.com>, Nikita Kalyazin <nikita.kalyazin@linux.dev>, "Ackerley
 Tng" <ackerleytng@google.com>, Takahiro Itazuri <zulinx86@gmail.com>,
	<cc-open-source@amazon.com>, Kevin Brodsky <kevin.brodsky@arm.com>, "Gregory
 Price" <gourry@gourry.net>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 03/26] mm: introduce AS_NO_DIRECT_MAP
Date: Tue, 13 Oct 2026 16:25:53 +0100
Message-ID: <20261013152553.39287-2-itazur@amazon.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <CAO9r8zMxdg2BTFguwcRQn8n-2CPaEJJfg+T8dWcgO2eV4uNaHQ@mail.gmail.com>
References: <CAO9r8zMxdg2BTFguwcRQn8n-2CPaEJJfg+T8dWcgO2eV4uNaHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, 3 Sep 2026 07:06:02 -0700, Yosry Ahmed <yosry@kernel.org> wrote:
> > If that work is not already underway,
> > I would like to respin the AS_NO_DIRECT_MAP introduction and secretmem
> > adoption as a standalone MM series, separate from ALLOC_UNMAPPED and
> > mermap.
[...]
> Perhaps wait until I send the new version, then we can discuss if we
> want to split it based on how the feedback looks like. Does this work
> for you?

Following up on this with an update. Yosry let me know off-list that
ALLOC_UNMAPPED is on hold for now (quoted with permission):

> I wanted to give you an update. I was working on v4 of the
> ALLOC_UNMAPPED series while our team was simultaneously working on
> integrating that design without internal ASI implementation.
> Unfortunately, there were multiple complications with that
> integration, and we will be holding off on sending new versions of the
> ALLOC_UNMAPPED series until we have higher confidence that this
> approach will meet ASI's requirements (ideally in a production
> experiment).

Since the integration with Google's internal ASI implementation needs
more time, Yosry also agreed that I pick up the AS_NO_DIRECT_MAP work
for guest_memfd, separate from ALLOC_UNMAPPED. Here is how I plan to
proceed. Feedback is very welcome, especially from Sean on section 2
below.

1. MM and KVM parts together

I'm withdrawing my earlier proposal to post AS_NO_DIRECT_MAP and the
secretmem conversion as a standalone MM series first. secretmem
removes kernel access to its memory entirely, but KVM still needs to
access some guest memory from the kernel. If the MM part lands first
and the guest_memfd integration then requires a different design, we
would have to rework it right after it lands. So I'd like to settle
the design with guest_memfd as a real user, and post the MM and KVM
parts together in a single series so that both sides can review the
whole picture. Once we agree on the overall design, I'm of course
happy to split it up so that each part can go through the MM and KVM
trees.

2. Kernel access to direct-map-removed memory

I agree with Sean [1] that the way to access such memory from the
kernel, whether it ends up as an extension of GUP or a new interface,
should be generic rather than specific to guest_memfd, so that other
users of direct-map-removed pages that may come along can use it too.
It is also still open who should establish the kernel mapping: MM
could do it transparently, or callers could create one explicitly on
demand, either with existing MM mechanisms or with a new one like the
mermap. I don't have a concrete design in mind yet.

As a first step towards that, I'd like to:

  - List the use cases that stop working when GUP rejects
    AS_NO_DIRECT_MAP mappings. On the KVM side, these are mainly the
    gfn_to_pfn_cache users (kvmclock and the Xen shared pages) and
    kvm_vcpu_map() (mostly nested VMX/SVM). Accesses through uaccess,
    such as kvm_read_guest(), are not affected.

  - Look into each use case and sort out its requirements, e.g.
    whether it needs only the PFN, a short-lived kernel mapping, or a
    kernel mapping that stays valid for as long as the vCPU or VM
    uses it.

and then work out an appropriate design based on those requirements.
I'd only consider supporting the use cases incrementally where that
doesn't leave guest_memfd with a list of caveats or an ad hoc
interface.

3. ALLOC_UNMAPPED and the mermap

AS_NO_DIRECT_MAP itself works without them, by zapping the direct map
of each folio. However, guest_memfd will eventually need a temporary
kernel mapping to populate guest memory via write() [2], because
folios are already unmapped once they are added to the page cache.
The cost of TLB flushes and direct map fragmentation also matters for
performance, so I'd like to keep discussing these with folks
upstream, building on the direct map fragmentation discussion that
Kevin led at LPC [3].

Thanks,
Takahiro

[1] https://lore.kernel.org/all/anZfv81jLSU2qY9G@google.com/
[2] https://lore.kernel.org/all/20251114151828.98165-1-kalyazin@amazon.com/
[3] https://lpc.events/event/20/contributions/2420/
