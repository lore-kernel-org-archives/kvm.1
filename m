Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C2A386C34
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203015; cv=none; b=BcOY7d3RY7B3EJRF6OIz6obYiCzUojWvBzSv5gzc9ffu2Pq1azCGZr0GjSRT2D3a4mSH8TMfwrN9JTWkH8gBUqb6YIc8PCN8mZM1LZ6isJ2EWvHnejnd71bbniZhgZ6FAL0BJbMOjghCRbsb7aalkF+VajyP4xoERoSYo6tfiH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203015; c=relaxed/simple;
	bh=bFm/ov3R15AfIu4qKy3h759hr/wjIxU+uB+kiMovwe4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Zrbu0bRy3Vny/ZAnmc7XNC73sHhRJBeg4KGc6f4RPOSDe3xiqLbQb3TAKozyvGYcrhH7Vcs6MqiomTWNYXn48xS2f7t27NDpIiIDuqMvPrBEjj9sD5DePh8ow5CSJVd/B0tG3a4RTsqvNL3kUMDC4Z4rbRjBi5CTxzcn0aTpf0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpGULMuT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpGULMuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25696C4AF0B;
	Tue, 14 Apr 2026 21:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776203015;
	bh=bFm/ov3R15AfIu4qKy3h759hr/wjIxU+uB+kiMovwe4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DpGULMuT862bekajv3xLPPMmie7nbY3QdmZMLhcy0cjLVwjW+7BnmH4oSidPSjMfn
	 cxXy0dE30G6n3PRp1WiRQNhsOuejI5AQfnQj0bEAtWft2+Bdl6r+lFswLXlLTuKh6A
	 76BHiYMVgGPOWyrF1imGdnYvoo7dIyKNa9bGGyMvcrn7Pr0N0MpIA4CymCchbR6xTC
	 R1XVoPTmpMYXhRawuKlKL+xFtHBKiSmV3h5TpynJ80fKQsbqNL4H+k1RwLT1mjAGxj
	 9Q5ycBSBd37sJzygOy8/LevC6dQ82njJNuS0b26tYN9PLn/tfy76hW/sfDStf49WFi
	 yWkey5it7sQZA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 29A99F40068;
	Tue, 14 Apr 2026 17:43:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 17:43:33 -0400
X-ME-Sender: <xms:BbXeaQF4woxDeSyu1QIdwz58OOOZmDg98umspas_oe5Iq4fe8H7ozg>
    <xme:BbXeaS-C1aEkLf_XYp4Sce5_BLnBfhfmGim_blwYacmkTfJLpHOe5u3_m7PbbKOHz
    TvABtSb6Csa-rxB7Mk2qdHh5R_xQT1-fp4ysKisXSXziNMdYKgwS9E>
X-ME-Received: <xmr:BbXeadkPmKx92lHtvEzpsjdgnnK6PEVqVfufoksS7Xz_XliGEbEUDd08MxSVyHRaVE0fO65MjuPrAFIpmt2xp6x8JmhuNJFr3Cs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elhfeiudfgvdeijedtleeltdduueekffejjedvjefhgeevjeefueejledtleetjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopedvkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhi
    tghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhvmh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtohgtohes
    lhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgrohdrghgrohesihhn
    thgvlhdrtghomhdprhgtphhtthhopeigihgrohihrghordhlihesihhnthgvlhdrtghomh
    dprhgtphhtthhopehkrghirdhhuhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohep
    higrnhdrhidriihhrghosehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhgvrdhhrg
    hnshgvnheslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:BbXeaY-VD1M-aRpy1ZpS_Mi_-6NFUZul5T6B6PWV7AI9jqug8dFqjQ>
    <xmx:BbXeaReGqzq-wZEWh0JCp7LynCfKEQhE-CBxKJqL12HSpo0r2aaUwQ>
    <xmx:BbXeaR0BqjiuLbGOU0Qw-sTo0-DXJCzApyG5YeTvw-IAvVD2unswKg>
    <xmx:BbXeaaA1OGTLpUIJ9x6A2jVvp7XlPMdnHyFVa14TQJocCthx3xlMGg>
    <xmx:BbXeacSIIgvAbdlcVi6891WVRgfkf2tJsTxlYT5QYO5X1ooObmCcCko0>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 17:43:32 -0400 (EDT)
Date: Tue, 14 Apr 2026 14:43:31 -0700
From: Dan Williams <djbw@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "Gao, Chao" <chao.gao@intel.com>
Cc: "Li, Xiaoyao" <xiaoyao.li@intel.com>,  "Huang,
 Kai" <kai.huang@intel.com>,  "Zhao, Yan Y" <yan.y.zhao@intel.com>,
  "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
  "kas@kernel.org" <kas@kernel.org>,  "Chatre,
 Reinette" <reinette.chatre@intel.com>,
  "seanjc@google.com" <seanjc@google.com>,
  "pbonzini@redhat.com" <pbonzini@redhat.com>,
  "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,  "Verma,
 Vishal L" <vishal.l.verma@intel.com>,
  "nik.borisov@suse.com" <nik.borisov@suse.com>,
  "mingo@redhat.com" <mingo@redhat.com>,  "Weiny,
 Ira" <ira.weiny@intel.com>,
  "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
  "Annapurve, Vishal" <vannapurve@google.com>,
  "sagis@google.com" <sagis@google.com>,
  "djbw@kernel.org" <djbw@kernel.org>,
  "tglx@kernel.org" <tglx@kernel.org>,
  "paulmck@kernel.org" <paulmck@kernel.org>,
  "hpa@zytor.com" <hpa@zytor.com>,  "bp@alien8.de" <bp@alien8.de>,
  "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
  "x86@kernel.org" <x86@kernel.org>
Message-ID: <69deb5032ff01_147c801004c@djbw-dev.notmuch>
In-Reply-To: <af7732a08fcce4a21ff14b2038acbb85200c6f34.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-18-chao.gao@intel.com>
 <af7732a08fcce4a21ff14b2038acbb85200c6f34.camel@intel.com>
Subject: Re: [PATCH v7 17/22] x86/virt/tdx: Avoid updates during
 update-sensitive operations
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Edgecombe, Rick P wrote:
[..]
> > If an update races TD build, for example, TD measurement can become
> > incorrect and attestation can fail.
> > 
> > The TDX architecture exposes two approaches:
> > 
> > 1) Avoid updates during update-sensitive operations.
> > 2) Detect incompatibility after update and recover.
> > 
> > Post-update detection (option #2) is not a good fit: as discussed in [1],
> > future module behavior may expand update-sensitive operations in ways that
> > make KVM ABIs unstable and will break userspace.
> > 
> > "Do nothing" is also not preferred: while it keeps kernel code simple, it
> > lets the issue leak into the broader stack, where both detection and
> > recovery require significantly more effort.
> 
> This subject has had a lot of debate (as linked below in the log), but the way
> this is written leaves a lot of questions. "do nothing" is not an option it
> says, but the code does just that when UPDATE_COMPAT_SENSITIVE is not supported.

Right, but that is not the kernel's problem. If you run updates on
a module that does not support conflict detection, you get to keep the
pieces.

Like other cases of Linux not wanting to deal with the eccentricities of
early modules, just have userspace know about a minimum module version
where this protocol exists and accept the risk otherwise. No pressing
need to burden the kernel with carrying worry for early modules.

> > So, use option #1. Specifically, request "avoid update-sensitive" behavior
> > during TDX module shutdown and map the resulting failure to -EBUSY so
> > userspace can distinguish an update race from other failures.
> > 
> > When the "avoid update-sensitive" feature isn't supported, proceed with
> > updates. If a race occurs between module update and update-sensitive
> > operations, failures happen at a later stage (e.g., incorrect TD
> > measurements in attestation reports for TD build). Effectively, this
> > means "let userspace update at their own risk".
> > 
> 
> Above it says we can't just do nothing, we need the flag. And then this argues
> that we can do nothing because we can rely on userspace to deal with the
> issue... This log is maybe just trying to put a brave face on an imperfect
> compromise?

Not really, the log could be simplified to just say "module versions < X
are not safe for runtime update". In general if the kernel had a minimum
supported module version concept it could collect all of these early
deprecation conditions under one check.

> So, while I don't want to re-open the debate, I'm not sure the patch
> justification is going to pass scrutiny as is.
> 
> In the link [2], Dan says "Do not make Linux carry short lived one-off
> complexity", and also "Do not include logic to disable updates, document the
> expectation in the tool."
> 
> It seems this does not exclude the option to just to always pass the compat
> flag. Basically assume that the TDX module will always support
> UPDATE_COMPAT_SENSITIVE if it supports TDX module updates. Which I guess we
> should expect should eventually be true.

Right, assume a minimum module version.

> In [2] Dan was also against checking the UPDATE_COMPAT_SENSITIVE feature0 bit to
> gate the feature.

...because if it must be supported, why check?

> For the record, I don't like allowing the update without the compat bit set, and
> my concern has nothing to do with userspace roles and responsibilities. Instead
> it's because we are over budget on complexity for handling SEAMCALL errors
> within KVM and this makes things worse to keep track of.
> 
> tdh_mem_page_add() does a KVM_BUG_ON() if it sees a non-busy error. Imagine
> working on this code and considering if it is a valid KVM_BUG_ON()? After this
> patch, the answer is...well sometimes. It depends on the previous modules
> specific feature0 bits, an understanding on admins expectations, and the
> behavior of some far away code in arch/x86. Gah.

Why would it be variable? The user tried update on a module that the
kernel deemed unfit for update. "Doctor, it KVM_BUG_ON()s when I run
update".

> Actually, the diff Dan objected to was checking and printing a specific helpful
> error. Maybe he does not mind much more simply checking an extra bit in
> tdx_supports_runtime_update()? Otherwise, I'd think to just unconditionally pass
> UPDATE_COMPAT_SENSITIVE without checking for support. Essentially mandate that
> it is always supported if TDX module update is supported.

In the end all of the hand wringing we are doing is misplaced. The root
of the problem is the TDX Module claiming "runtime update supported" to
include these corner cases of "but we corrupt things if the update tries
to replace the crypto library at the wrong time".

That problem is also solvable by not classifying those updates as
runtime compatible, or defining a protocol to mitigate the collisions.

Neither of those was chosen. Instead the module implemented 2 additional
complications Linux chose one that fails update, other VMMs chose one
that maximizes updates at the cost of needing to restart TD
construction.

I think the changelog is a bit non-commital trying to be diplomatic
about the mess. Simply, Linux wanted the easy button, all runtime
updates are safe. Instead, module exported complexity and optionality.
KVM voted for one flavor of that optionality to accommodate the module
complexity.

The solution, make modules with the option KVM wants the min requirement
and move on.
