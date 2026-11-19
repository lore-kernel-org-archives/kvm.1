Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108159;
	b=S629/gy5CikAfCuh8z4TK48Wx7tB/jbc9st8ZxtrFiXGwYqZ8nlKbIu1tuxT8RaRQM9W
	 VbJwJcZfHRnbs6N1PrWInB45JnDaVEEsrYzMPwUtQabreS3ih6/4JAIIi4p7fkerKGdiC
	 N4nZRjQoRgWUoKVxkVY8XgZvP44pWVSdl/Uw1RqGAGL70USywrzRpXD4LhCnKg9t3KaKO
	 5wAwDVxXQsyh6fhgM7WLh7htOBz8wAl1NeS7oLkv9qqH/ZRmXGwdzunwr/PR19PEy5jgH
	 I+UWmWgHW5+Qi5BAovSStDgKbQ7aJiUH6eVdc/5kansBOvonfJ0oyGG7Z8UAd8WLEUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108159;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=S8IGrx1x8iWsTP5Lmg78emE+63ORRJD0YqtAAQJu9f8=;
	b=BJTiOtF3mxHm4yCIQlgxo0ALWW/RklSeN+hD5M9SU5e5+ULDQAKLoSjTuWgK3YXjxrVb
	 yAxPGSTp9qqx+65Pi4ld/VrI2SI6kp8XAQh6YK9rTgaH1Gvf6vBsLN1KUNCnK7I/stPnV
	 bIbGmZ27q8sQW5+6+2VvPyMIGeggLeUU9tAj5Na4SXxIMJOGc4Ikj2KzSMwkqyU6/HYLy
	 ZE5vVAXxIpCy2wPTU1fkwS+fDKTbvD8PH/JYQHB1WdFujZW5x5JHLmk7t/56TG59EThCp
	 KrvYz2bKYEgSD2VaSHlT4aJtJByj1f90EuE8nmOoQahMY8Yp5x9RyfLNz0fLDVZB5Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ze5Z6LYp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338760A383D
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ze5Z6LYp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B933A1F000CC;
	Thu, 19 Nov 2026 17:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795108159;
	bh=S8IGrx1x8iWsTP5Lmg78emE+63ORRJD0YqtAAQJu9f8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ze5Z6LYpSNz5r4sRiArQ3u73skEahc9pQ9ZA5peRunpCvG4CJqBCkOtD+uwseclOI
	 YSeCmNszH1jz6wVQ6c72gAbCwE6qpXLCIJDcAfYEZqNU516ojNLVRuqMnfb5cuhM3q
	 kAcZjpukWPwgM0tkUFkBbBnloS1Q8/aSgPEetJLdeaFR0RSdnwTjrZBWsz+89SPskD
	 UvKNsF2cMwJvVbQKKzFaU0YX17d39ZR37eFAhfINOmFc0Af7Srxm7S5Bmjs0VBiP7z
	 uOnerceBdAAuCZtbeWCieA9cJi0no3E2PR1JOJrnSIeivQ7hvreYkHu/8DwNNn3xPj
	 IkIC6wxyD65nQ==
Date: Thu, 19 Nov 2026 11:09:00 -0600
From: "Serge Hallyn (AMD)" <sergeh@kernel.org>
To: Peter Xu <peterx@redhat.com>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
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
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	David.Kaplan@amd.com, Mathias.Brossard@arm.com, tycho@kernel.org,
	"Adam, Mahmoud" <Mahmoud.Adam@amd.com>
Subject: Re: TDX migration model
Message-ID: <av8tLIFEpHgluthp@shallyn-amd>
References: <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f4f34bc3dd22c0e47b5ee764b1a4db8940cbbbec.camel@gmail.com>
 <auyZnIfxMnxYD8rT@shallyn-amd>
 <85f899cd277b2188cd4b33f8f21b206fa2ff6f6f.camel@gmail.com>
 <auyx8C67zCnbPpuL@hallyn.com>
 <c77156d1-5a47-4a93-a18b-392081fad3ff@intel.com>
 <avF6DcmdoGeWeRxg@tlindgre-MOBL1>
 <avJGEYIohYUN9l10@shallyn-amd>
 <avKolvbIuZj-aLD-@tlindgre-MOBL1>
 <av8F-DwJnTkSeYsz@zhexu-thinkpadt14gen5.rmtcaon.csb>
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
In-Reply-To: <av8F-DwJnTkSeYsz@zhexu-thinkpadt14gen5.rmtcaon.csb>

On Thu, Nov 19, 2026 at 09:21:44AM -0500, Peter Xu wrote:
> On Tue, Nov 10, 2026 at 07:16:06AM +0200, Tony Lindgren wrote:
> > On Mon, Nov 09, 2026 at 04:15:45PM -0600, Serge Hallyn (AMD) wrote:
> > > (Adding Tycho and Mahmoud, who will be working with me on this)
> > > 
> > > On Mon, Nov 09, 2026 at 09:45:17AM +0200, Tony Lindgren wrote:
> > > > On Thu, Nov 05, 2026 at 06:00:41PM -0800, Kishen Maloor wrote:
> > > > > On 11/5/26 8:42 AM, Serge E. Hallyn wrote:
> > > > > > On Thu, Nov 05, 2026 at 05:59:01PM +0200, Artem Bityutskiy wrote:
> > > > > >> On Thu, 2026-11-05 at 08:58 -0600, Serge Hallyn (AMD) wrote:
> > > > > >>> ...
> > > > > >>> So, looking at the section '### How the Setup Session Works', is it safe
> > > > > >>> to assume that you are using the qemu migration fd for the message
> > > > > >>> transfers?  So basically qemu loops over KVM_MIGRATE_SETUP calls, which
> > > > > >>> ...
> > > > > >> Yes, that's the flow. I’m not sure about the migration fd part, I believe we
> > > > > >> pass the setup session data via ioctl buffers. I am sure Kishen will can
> > > > > >> clarify.
> > > > > > 
> > > > > > If you mean pass via ioctl buffers from tdx->kvm-> back to qemu, which passes
> > > > > > it over the migration fd to the other side, then that's what I expected.
> > > > > > Othewise I'll be interested to the details :)
> > > > > 
> > > > > Hi Serge,
> > > > > 
> > > > > Your understanding is right. Migration setup requires a handshake of some sort
> > > > > between the source and destination. So the messages KVM_MIGRATE_SETUP returns
> > > > > are transferred over QEMU's migration channel to the other side and processed
> > > > > by a matching call.
> > > > 
> > > > Serge, on the QEMU side, we have been enabling the return-path early for
> > > > the key exchange before migration is active. Not sure if the key exchange
> > > > can be done using a VMState, possibly could be if we can ensure it happens
> > > > before the migration is active.
> > > 
> > > Key exchange requires bidirectional communication, so I don't think a
> > > VMState would work, at least not on its own. If the destination's
> > > info got send to the source out of band and delivered through migrate
> > > command option, that could work, but it seems much nicer to me if it's
> > > all done more transparently.  OTOH if this simplifies the qemu code
> > > enough, maybe it's worth it.
> > 
> > Yeah agreed and can be revisited.
> 
> Just FYI: on QEMU side, we should be introducing handshake for migration
> soon, so that there'll be an early stage where the out+in messages will be
> all done in the entrance of migration_thread(), trying to have both src/dst
> QEMUs talk first before really starting the migration procedure.
> 
> Agreed that vmstate isn't designed for bi-directional conversations.
> 
> That was initially for other things, including channel mgmts, sync
> migration caps/params, but it sounds like it could be useful for CoCo too.
> 
> Thanks,
> 
> -- 
> Peter Xu

Is there a draft repo/branch where we could look at the current state of
the 'handshake' feature?

thanks,
-serge
