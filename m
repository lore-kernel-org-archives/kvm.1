Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262556;
	b=rcClFhqqdQfVGGa58/oppcM/bSNQP/b04Fm6OP9E3YeIq4BhZnakRyJf0Cz1FGQgGcov
	 3T9VLfi1ivr0YMA6vLsnS1PJILts1+4Ajd4dt4AXAUWo8E8iKhUA6L30GDd5cE5pnINl2
	 GgUcQZfp+7OVBR5gpITHFtIgXLbqOpSPl6gd2anh3Nzyi6ibwzm6R5I3XfK04d7QwvRFK
	 ntn9hWGf3Ou1Epnziumq1jv7Cip/hYcOstQWxM/HgeNdauLQgfezkMTu2HrpXD+ZFOe+6
	 /ZLhFJgD4FDInmJtvX1y/p8Sczdhlo8+tQvOlrGNWyATHJxqDex0d6RjglgZrNUf7uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262556;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Y1DnSqJszqRkFeE7PcAkTPG/+EtNOXSnmFTurLYOO8U=;
	b=OMrM2dicZC+uBjA3XwtABQFB9JNyDZXzvwEWYLP2he23l17PPzuRKlnoOFqK8izAAumY
	 f4pb+evGuh/RAHoxxLdBUxt0ecQ7msY5vIamo9QVAnVo10qcUAnipPRkDUfAkC7IFCwoF
	 oWqRDQmw/dvG/0Gv8yDyzx11hCD1aaKp241Z1fODp0+6Q0z4QsoNTdbGprNJMMZ0ViqPR
	 XoSuR8dXNaAPywS8wuYysMJEiypUamq+I1yFnKzHYGgTfKVp0YZgXkphHxjd+WaJvUVbF
	 9UAbFm1eY3+pNaRQXtT3u7ys50qYIYookdzibQJeOHyGVPJoSQxaqTL388ULR59NOsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0jH95GG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC7606A321
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0jH95GG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536AB1F008AB;
	Mon,  9 Nov 2026 22:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262555;
	bh=Y1DnSqJszqRkFeE7PcAkTPG/+EtNOXSnmFTurLYOO8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J0jH95GG9MgxpjTf4q1MEDLPVWQIGcBN/B35F51qSQYpjPVuy+2OzEkfywp+LiJK3
	 t86qX56CJtMdu+Y88xSXBUTt5j3hFbuKN1yjfIPgHgqlj+J6BT9rZcR/ejxXtiCl93
	 Zx8oYK3Gxlz9fwYqDTRQOJj+m+Q+TJ/TUDwtgmVLteJLm/kfh2zWz9ZYNVceMOpprY
	 rSxKzFHm/VT9bDl7RN1VLXy/xoB2lAtgCo1d3zOfb8PyNDJtLipGyf3UR96gQaEYjM
	 +oFU6Am7ilR7U5Akj0PczElhCCAUX3Sd8ZANXhSsFoRCMWZWGLgIt02ppQTbsgxcI1
	 +0A5to+RqbfMQ==
Date: Mon, 9 Nov 2026 16:15:45 -0600
From: "Serge Hallyn (AMD)" <sergeh@kernel.org>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Kishen Maloor <kishen.maloor@intel.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
Message-ID: <avJGEYIohYUN9l10@shallyn-amd>
References: <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f4f34bc3dd22c0e47b5ee764b1a4db8940cbbbec.camel@gmail.com>
 <auyZnIfxMnxYD8rT@shallyn-amd>
 <85f899cd277b2188cd4b33f8f21b206fa2ff6f6f.camel@gmail.com>
 <auyx8C67zCnbPpuL@hallyn.com>
 <c77156d1-5a47-4a93-a18b-392081fad3ff@intel.com>
 <avF6DcmdoGeWeRxg@tlindgre-MOBL1>
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
In-Reply-To: <avF6DcmdoGeWeRxg@tlindgre-MOBL1>

(Adding Tycho and Mahmoud, who will be working with me on this)

On Mon, Nov 09, 2026 at 09:45:17AM +0200, Tony Lindgren wrote:
> On Thu, Nov 05, 2026 at 06:00:41PM -0800, Kishen Maloor wrote:
> > On 11/5/26 8:42 AM, Serge E. Hallyn wrote:
> > > On Thu, Nov 05, 2026 at 05:59:01PM +0200, Artem Bityutskiy wrote:
> > >> On Thu, 2026-11-05 at 08:58 -0600, Serge Hallyn (AMD) wrote:
> > >>> ...
> > >>> So, looking at the section '### How the Setup Session Works', is it safe
> > >>> to assume that you are using the qemu migration fd for the message
> > >>> transfers?  So basically qemu loops over KVM_MIGRATE_SETUP calls, which
> > >>> ...
> > >> Yes, that's the flow. I’m not sure about the migration fd part, I believe we
> > >> pass the setup session data via ioctl buffers. I am sure Kishen will can
> > >> clarify.
> > > 
> > > If you mean pass via ioctl buffers from tdx->kvm-> back to qemu, which passes
> > > it over the migration fd to the other side, then that's what I expected.
> > > Othewise I'll be interested to the details :)
> > 
> > Hi Serge,
> > 
> > Your understanding is right. Migration setup requires a handshake of some sort
> > between the source and destination. So the messages KVM_MIGRATE_SETUP returns
> > are transferred over QEMU's migration channel to the other side and processed
> > by a matching call.
> 
> Serge, on the QEMU side, we have been enabling the return-path early for
> the key exchange before migration is active. Not sure if the key exchange
> can be done using a VMState, possibly could be if we can ensure it happens
> before the migration is active.

Key exchange requires bidirectional communication, so I don't think a
VMState would work, at least not on its own. If the destination's
info got send to the source out of band and delivered through migrate
command option, that could work, but it seems much nicer to me if it's
all done more transparently.  OTOH if this simplifies the qemu code
enough, maybe it's worth it.

> For the migration related commands, looks like we can just make the
> KVM_EXPORT_CMD and KVM_IMPORT_CMD subcommands a bit more finer grained and
> then drop the vendor flags until needed:
> 
> #define KVM_MIGRATE_EXCHANGE_KEYS	0 (New, was KVM_MIGRATE_SETUP and a flag)

We are currently looking at a couple of messages back and forth during the
setup negotiation, to accomplish both key exchange and verification of
attestation reports.  I was actually just using KVM_MIGRATE_SETUP with
flags for that.  Maybe KVM_MIGRATE_EXCHANGE_KEYS could be renamed to
KVM_MIGRATE_NEGOTIATE?  Flags aren't strictly needed, if the
KVM_MIGRATE_NEGOTIATE ioctl will be repeated depending on the return
value.

> #define KVM_MIGRATE_SETUP		1 (Migrates the immutable state)
> #define KVM_MIGRATE_ITERATION		2 (Start a new pre-copy round)
> #define KVM_MIGRATE_ITERATION_FINAL	3 (New, last pre-copy round before pause)
> #define KVM_MIGRATE_PAUSE		4 (New, split from old STOP_AND_COPY)
> #define KVM_MIGRATE_MUTABLE_STATE	5 (New, split from old STOP_AND_COPY)
> #define KVM_MIGRATE_START_DESTINATION	6 (New, split from old STOP_AND_COPY)
> #define KVM_MIGRATE_START_POSTCOPY	7 (New, could return -EOPNOTSUPP for now?)
> #define KVM_MIGRATE_ABORT		8
> #define KVM_MIGRATE_END			9
> 
> For the above PAUSE is four the source only. START_DESTINATION is for both
> source and destination as source exports a start token for the destination.
> START_POSTCOPY is not implemented but would be destination only when
> implemented. ABORT is allowed at any point.
> 
> Any other subcommands needed at this point?

Not absolutely certain, but it looks like this might be complete.

> Then for handling the results, the following seems to simplify things a bit:
> 
> - Results are copied back only on success, vendor error is returned as is
> 
> - Import is all or nothing, vendor code resumes on interruptions
> 
> - For memory transfer, a GFN can only be transferred once per round,
>   duplicate import attempt returns -EINVAL

Hm, does the platform independent code need to worry about this?

> Regards,
> 
> Tony

thanks,
-serge
