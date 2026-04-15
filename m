Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EBD23EAB4
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776213401; cv=none; b=PahzOFPwW4oa38u2HZF31a3S49Tns+cD3igPcVUSAZZ2soKnzfuMgYD6yOtPztCbRMIgPCopCo+o+pbOREPGedsujCQqiGVpzxVR0ZEITNeuzEeV0ofcsu1EAw6NuldfzXFnVEKdyrX3ocQsQzhCqEEypitfERrkQPkghadOLgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776213401; c=relaxed/simple;
	bh=Blgnk0+1W5cs6tUlVgA5wPc4aYFBdXMo4PCTqtBJuvc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=N0FxPtVfsp8TSm45QoR1tZEcp/d9nBvIypaDVzSiQvdu0wqWgwlZxpambTGNHC3bEiZql2o0nSzIQ3W6m2ySWLR4UY41qayDlNIG2H3ZkVRUGVrfQkK7ixSuCwfVffAffZzDgnDArgniESr+3rwaDkZ51NJdDnrujQGiL/eho5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eai3/qMF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eai3/qMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C38C4AF09;
	Wed, 15 Apr 2026 00:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776213401;
	bh=Blgnk0+1W5cs6tUlVgA5wPc4aYFBdXMo4PCTqtBJuvc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=eai3/qMFTihnCiJFTik1iTXgy/oqnBJ+bYnK7VBff+RMYx1oOIazBlunZ2snhZLIM
	 jLxF7FeGQBk1TgXQ2jwFqNTWJId9hp2BslvQjya4gA55lOcM54S9RocnHsZeHx63sa
	 6Q0kFUN9Kdl73uWuB/p4d/99RtoWlK+Vt9EtfY3z/9gooM/14dF9Pp7g5lcp35C02j
	 T56ovZUAtuQaexdnDrOYOMnEqCg59Rlby9rSB3/DLdugGLuiXq8/MqCRAvVVOvO/Jq
	 gc58TprxDH/msuTF5udEckGJfe85x22iwAgHxSkP5y0U+eYshp1dUpL6dmfDaqD29U
	 DJh9S+fExrjAg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3592DF40069;
	Tue, 14 Apr 2026 20:36:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 14 Apr 2026 20:36:39 -0400
X-ME-Sender: <xms:l93eaRomV-NJAojxhhgi8orsVqKjV-QRONB528x9dsiZsmLK4Hlq1A>
    <xme:l93eadQYmkAJLrYEROcy2B0uie4Mb8DXXwP6jBJUko6KTmeEcVN5cd96LVAjMjGgf
    WpXBMtJ4_6xd1D0Ty_IdI8ocPrGFQU34Ths185KOpeJvu-SI90l3SNL>
X-ME-Received: <xmr:l93eaRpywNu97o3CsCYl71w8HwHh_3nfLWFyMEsnA5q0gA2KvEfjTFKsXtjJerCla4j9qUPx1DmAnLvyKQGDUh16OXsdJzTUCSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvdeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtqhertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    dukeelueetjeekgeeiheelvdehleekgeejvdejvdetgfdugffgveefgfejhffhvdenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepughjsgifodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqddujeejvdeftdegheehqdeffeefleegtdegjedqughjsgifpeepkhgvrhhnvg
    hlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvdekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehrihgtkhdrphdrvggughgvtghomhgsvgesih
    hnthgvlhdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqtghotghosehlihhsthhsrdhlihhnuhigrdguvghvpd
    hrtghpthhtohepughjsgifsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgroh
    drghgrohesihhnthgvlhdrtghomhdprhgtphhtthhopeigihgrohihrghordhlihesihhn
    thgvlhdrtghomhdprhgtphhtthhopehkrghirdhhuhgrnhhgsehinhhtvghlrdgtohhmpd
    hrtghpthhtohephigrnhdrhidriihhrghosehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:l93eaTzRc6GRLLuYJSneyyJbD2enrGidinW5pNseIUsRCpQWLV2dTg>
    <xmx:l93eacBccrKEdpY3S4A_hbNAplw1NTE4T_vSrOI_xxifmX84skaMSg>
    <xmx:l93eaRI9-04o3QD7zr7Wa_xq4E4drzIAH_4Wv5RbqlPnJXarDcoxHw>
    <xmx:l93eafHaiJxeL_7Ke6I1ws2tMnHtueUkDPEI8n0x_WQh8_9wd2KKUQ>
    <xmx:l93eaUGyqx6Sp0LlbLj2fShD8s6z7-lMmnRlu9mWNoqvfxc76bA6GinZ>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 20:36:38 -0400 (EDT)
Date: Tue, 14 Apr 2026 17:36:37 -0700
From: Dan Williams <djbw@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
 "djbw@kernel.org" <djbw@kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "Gao, Chao" <chao.gao@intel.com>
Cc: "Li, Xiaoyao" <xiaoyao.li@intel.com>,  "Huang,
 Kai" <kai.huang@intel.com>,  "Zhao, Yan Y" <yan.y.zhao@intel.com>,
  "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
  "kas@kernel.org" <kas@kernel.org>,
  "seanjc@google.com" <seanjc@google.com>,
  "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,  "Weiny,
 Ira" <ira.weiny@intel.com>,  "mingo@redhat.com" <mingo@redhat.com>,
  "Verma, Vishal L" <vishal.l.verma@intel.com>,
  "nik.borisov@suse.com" <nik.borisov@suse.com>,  "Chatre,
 Reinette" <reinette.chatre@intel.com>,
  "pbonzini@redhat.com" <pbonzini@redhat.com>,
  "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
  "sagis@google.com" <sagis@google.com>,  "Annapurve,
 Vishal" <vannapurve@google.com>,  "hpa@zytor.com" <hpa@zytor.com>,
  "tglx@kernel.org" <tglx@kernel.org>,
  "paulmck@kernel.org" <paulmck@kernel.org>,
  "bp@alien8.de" <bp@alien8.de>,
  "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
  "x86@kernel.org" <x86@kernel.org>
Message-ID: <69dedd953ddc8_147c80100d@djbw-dev.notmuch>
In-Reply-To: <c44a4aebca86584ec33a19fbd9ca464443e66718.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-18-chao.gao@intel.com>
 <af7732a08fcce4a21ff14b2038acbb85200c6f34.camel@intel.com>
 <69deb5032ff01_147c801004c@djbw-dev.notmuch>
 <c44a4aebca86584ec33a19fbd9ca464443e66718.camel@intel.com>
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
Content-Transfer-Encoding: quoted-printable

Edgecombe, Rick P wrote:
> On Tue, 2026-04-14 at 14:43 -0700, Dan Williams wrote:
> > > tdh_mem_page_add() does a KVM_BUG_ON() if it sees a non-busy error.=
 Imagine
> > > working on this code and considering if it is a valid KVM_BUG_ON()?=
 After
> > > this
> > > patch, the answer is...well sometimes. It depends on the previous m=
odules
> > > specific feature0 bits, an understanding on admins expectations, an=
d the
> > > behavior of some far away code in arch/x86. Gah.
> > =

> > Why would it be variable? The user tried update on a module that the
> > kernel deemed unfit for update. "Doctor, it KVM_BUG_ON()s when I run
> > update".
> =

> The objection is not an unprepared user having an issue. It's=C2=A0that=
 this adds
> burden to the TDX MMU developers who have to keep track of which errors=
 are
> valid and which are not. Doing that is maybe _the_ major challenge for
> maintaining that code, that code is the trickiest of TDX KVM, and we ha=
ve an
> easy option here to not muddy it further.

I think we are in violent agreement. If a runtime update causes
tdh_mem_page_add() failure then it is simply not a runtime update.

[..]
> > I think the changelog is a bit non-commital trying to be diplomatic
> > about the mess. Simply, Linux wanted the easy button, all runtime
> > updates are safe. Instead, module exported complexity and optionality=
.
> > KVM voted for one flavor of that optionality to accommodate the modul=
e
> > complexity.
> =

> It doesn't pick a flavor.

Oh, you mean in the sense that it proceeds without compat support? Then
yes, agree.

> It tries to handle them both depending on TDX module support. See:
> =C2=A0
> +	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_UPDATE_COMPAT)=

> +		args.rcx |=3D TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE;
> =

> So it sounds like you have no objection to only supporting the mode tha=
t is easy
> (TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE). If we always pass this flag,=
 then the
> TDX MMU developers can have less details to keep in their heads.

Yes. Just pass that flag unconditionally and treat "operand invalid" as
another "can not do a compatible update" case.

> I think Chao took this as an objection to unsupporting
> !TDX_FEATURES0_UPDATE_COMPAT updates, when it really was an objection t=
o the
> kernel trying too hard to help the admin:
> https://lore.kernel.org/kvm/69a0c3d24310_1cc5100d1@dwillia2-mobl4.notmu=
ch/

Drop !TDX_FEATURES0_UPDATE_COMPAT accommodation is the intent. Be mean
to old modules if it saves comments and conditionals in the kernel.=
