Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896955;
	b=ujgM1cvBjabfK7OzlQ2zG6vINiPjUKiFWwCAeARAuD7IrW87ATTjb8KCoLO8namdZBkz
	 7xTr7/NqQrpR6HpSRVOiRShebbkbYHST3a5RJY96jroi0i8UeJx+u43kbmCChqIdPPY2U
	 vXZO0GViDRkH0ComdEKE60BZ4qkYiMRrRkwXaC8FZDrub+wpZryWawAc9xjZLTIUubysh
	 3Vz/jvCJTqdOmmjYwX7mbpZKcDrE5PDV/r4xvlkurrwEhTYjBuPA65qX5ZLFt3hrBB8f5
	 CvoBMZfAk6dMJMgvsW+N+aO5J1UHx6aldhLwG4Yhobolwtq+QkhgLNzV+rfRfcegz+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896955;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=t2FuH7Jo8ZcdZbICEjdlHjyy/k1niD+kPzrNFz3X16U=;
	b=Mwwk4KVcM8j+NR6OWnJDw7IQzhGfDnVyjmsRrRUdvl13179eMuqFZid6TaFzxxCLpHqs
	 btfPCfHCM/T/QddoGhMtbLCReEkwLOgFFOOucA1ABDlwue++fNizE7NKOHc/jEFvn9r+/
	 J/TzTrCsLDaoOAy0m/Pa0i7ac7ogcFqqsuybfwMvZc/KbxYD1Z7J3zDDD78QXOj6cIYp2
	 EBkzOl52sIPHL81qiJ6iipRuGsOWBV4JQ+c0Q4eKgGRDSOBpnYnAt4DCE4FoQ0SXVBP36
	 SojifZdcKPCDboo0OFwf49AJH304rbw67Bhy/qpsv4qPTTvpbZnOVkEFkFTgxrHjc8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=(null) smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=1uTHnVN1;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF619606A332
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 16:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF619606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=1uTHnVN1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1793896944; bh=nne4VO+hFrI4n/pJlpGjE91HQgn1YCyVF81fG7x0K2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1uTHnVN1CiNRmFUqbbviIyzTcHjQFH9dvG0Uk+yXyU5Uz2Sh9qPWSjIU7FCn+LPe0
	 KoAoLCOJHFLheoijJ7L5pD23UB2Noy4kKWQ/RSjuMStcIS3CV9LANfn0T+CTn+G5Ys
	 h+Oe39ZNJHBazX7lk0UerbArh4U/f2S/cFRddkWys0EVJNUjD4XLbhE/t+SQ2WF4pH
	 84g1d2xdDg6o6CjqYaPnSXXFz1cfs9Wk+tJTWlXPr2GTjJER1E+8rRX+92nz8ECGw+
	 BmZsAwNn63Cz0H69lgG8wj7c7q65pSwkQsyy107uMA7vfYGuGnnGZ2zkVbSlYuQl5x
	 ZkOxtHx59w3iQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 85616C7; Thu,  5 Nov 2026 10:42:24 -0600 (CST)
Date: Thu, 5 Nov 2026 10:42:24 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: "Serge Hallyn (AMD)" <sergeh@kernel.org>, Peter Xu <peterx@redhat.com>,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	David.Kaplan@amd.com, Mathias.Brossard@arm.com
Subject: Re: TDX migration model
Message-ID: <auyx8C67zCnbPpuL@hallyn.com>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f4f34bc3dd22c0e47b5ee764b1a4db8940cbbbec.camel@gmail.com>
 <auyZnIfxMnxYD8rT@shallyn-amd>
 <85f899cd277b2188cd4b33f8f21b206fa2ff6f6f.camel@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85f899cd277b2188cd4b33f8f21b206fa2ff6f6f.camel@gmail.com>

On Thu, Nov 05, 2026 at 05:59:01PM +0200, Artem Bityutskiy wrote:
> [I dropped a bunch of people from CC, sorry about that, just restored the CC
> list]
> 
> On Thu, 2026-11-05 at 08:58 -0600, Serge Hallyn (AMD) wrote:
> > On Wed, Nov 04, 2026 at 03:51:45PM +0200, Artem Bityutskiy wrote:
> > > Hi Peter, community,
> > > 
> > > Here is the TDX migration model doc that I mentioned in the CoCo migration
> > > uAPI thread:
> > > 
> > > https://github.com/dedekind/dedekind-share/blob/master/2026/tdx-live-migration.md
> > > 
> > > The doc focuses on TDX only. It does not cover CoCo in general or
> > > Linux/KVM. 
> > > 
> > > The goal is to lay out what the TDX module offers in terms of ABI and
> > > migration flow today. Hopefully it is easier to read than the TDX specs,
> > > which are much more detailed. Feedback is very welcome.
> > > 
> > > The uAPIs that we suggested were modeled around this flow and ABI. But
> > > we kept general CoCo VMs in mind as much as we could.
> > > 
> > > The TDX live migration PoC implementation that we mentioned earlier follows
> > > the flows and uses the ABIs described in the doc.
> > > 
> > > Thanks!
> > > 
> > > P.S. From the ARM talk and hallway conversations at Plumbers, I understood
> > > that the ARM live migration flow is very similar to TDX. For SNP guests, we
> > > have not heard enough yet.
> > > 
> > > Thanks,
> > > Artem.
> > 
> > Thanks, Artem!
> > 
> > So, looking at the section '### How the Setup Session Works', is it safe
> > to assume that you are using the qemu migration fd for the message
> > transfers?  So basically qemu loops over KVM_MIGRATE_SETUP calls, which
> > is directed to platform-specific handlers, which in the tdx case calls
> > TDH.MIG.SETUP, and this loop continues until TDX_SUCCESS?  If so, great,
> > that mirrors pretty exactly what we were looking at for SNP.
> 
> Hi,
> 
> Yes, that's the flow. I’m not sure about the migration fd part, I believe we
> pass the setup session data via ioctl buffers. I am sure Kishen will can
> clarify.

If you mean pass via ioctl buffers from tdx->kvm-> back to qemu, which passes
it over the migration fd to the other side, then that's what I expected.
Othewise I'll be interested to the details :)

thanks,
-serge
