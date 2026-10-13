Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F0522691;
	Tue, 13 Oct 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907618; cv=none; b=LNgvONNcGE6n3+/g4SbdA//r0rs66RahE+YgDPK9sf9vgb7z35bSbV00qDtGJxmNbzcv9NtrRtiN+iCt80tTfgSlDyqyn2giwZo0SeLfuXBuBZ2fl6Bn+XT4qVh/8ShXg5RxyAUWpnPAfmPNfxoyTnshiwBAse1Zd/cs9eIyuRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907618; c=relaxed/simple;
	bh=5RGsatsPAyQIBEtdraUseJGGZDIDfWt4LgToyJkkY0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwEPVTqsaLlR81Mkoz6udBLqrncfgyjXv8jB8daiqAmnO1xuvlkwZXHLqTGSy/ilN6dlCjxFAdLMtk4teUWk3RRMPb67nXpnMb6pSUuB3ndV90woAZT+qfudq4L7AEKR+NA8fv2P/2lHBDvSVd2e0DWCbJQhmI8oRIUTEgnFg+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=itiPWJga; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="itiPWJga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1791907616; x=1823443616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5RGsatsPAyQIBEtdraUseJGGZDIDfWt4LgToyJkkY0g=;
  b=itiPWJgaFtqSKsAFys0hLcKLcXAlWnhhs5ZPsTf60+/E4wIaw+1/Ca7L
   qJ9+g1Jee4D1GQww1pkqQHI0aUPke2D31VInJpaqUBRen4G2C7tAh/2Qy
   UyRk+Kn4MyF/fMNaUSpA1Ouoj9pvGG39eZAMqahfkgi9hQm4iBQpCqO+H
   yAftk5eArI3F0M0b7xtTkjZ3xnY0P9fx5rcX2Ifexsbi5SnIfNXdV1JPu
   Ej3I4ZTKkqwsZUt2FCey5JkYDdtMsQu6d6rtavdUygWgxYJGDgokQiCce
   G4+QZEXkeMCjJWlrarxlH6n3zQsBWrUEYA1hq6CFXw1Y2oFnOhBqjggRn
   A==;
X-CSE-ConnectionGUID: EzT8FQ1qRkitCh9eAqylmQ==
X-CSE-MsgGUID: 0N5fJEVHQK2EpK1JLFPKKQ==
X-IronPort-AV: E=Sophos;i="6.27,156,1787011200"; 
   d="scan'208";a="31138648"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 16:06:53 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:15933]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.46:2525] with esmtp (Farcaster)
 id 95bf7a0b-1374-49ed-916d-f238717f74ff; Tue, 13 Oct 2026 16:06:53 +0000 (UTC)
X-Farcaster-Flow-ID: 95bf7a0b-1374-49ed-916d-f238717f74ff
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 16:06:53 +0000
Received: from b0f1d8753182.ant.amazon.com (10.106.82.29) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 16:06:47 +0000
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
 Price" <gourry@gourry.net>, <kvm@vger.kernel.org>, Derek Manwaring
	<derekmn@amazon.com>
Subject: Re: [PATCH v3 03/26] mm: introduce AS_NO_DIRECT_MAP
Date: Tue, 13 Oct 2026 17:05:58 +0100
Message-ID: <20261013160557.54828-2-itazur@amazon.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <CAO9r8zPOkuRGv0X=nBbAzTUjUyaB7zAJLUigetSXEVPxWpyGxw@mail.gmail.com>
References: <CAO9r8zPOkuRGv0X=nBbAzTUjUyaB7zAJLUigetSXEVPxWpyGxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Tue, 13 Oct 2026 08:36:54 -0700, Yosry Ahmed <yosry@kernel.org> wrote:
> > 3. ALLOC_UNMAPPED and the mermap
> >
> > AS_NO_DIRECT_MAP itself works without them, by zapping the direct map
> > of each folio. However, guest_memfd will eventually need a temporary
> > kernel mapping to populate guest memory via write() [2], because
> > folios are already unmapped once they are added to the page cache.
[...]
>
> FWIW, I think the mermap can still be used without ALLOC_UNMAPPED, and
> I did have a newer version of the x86 patches repurposing the LDT area
> for the mermap, and simplifying the mermap implementation a bit. I can
> share them privately if you want to take a look.

Yes please, that would be very helpful. Thanks!

Agreed that the mermap can be used without ALLOC_UNMAPPED. To give a
bit more context from the guest_memfd side: I can't say anything
definite until I've gone through the use cases, but as far as I can
see now, guest_memfd needs the mermap only for write() support.
write() is an optimization for populating guest memory (e.g. when
restoring a snapshot) and isn't functionally required, because
userspace can also populate guest memory through its own mapping of
guest_memfd. So I currently plan to keep write() support, and with it
the mermap, out of the guest_memfd direct map removal series itself.
Since ALLOC_UNMAPPED is the main user of the mermap, it may make more
sense for the two to land together later.

One thing I'd like to look into is arm64. Firecracker also runs on
arm64, so write() needs to work there too, but the mermap currently
relies on the x86 mm-local region, and it sounds like your newer
version relies on the LDT area. Kevin, do you happen to have any
ideas on how something similar could be done on arm64?

Thanks,
Takahiro
