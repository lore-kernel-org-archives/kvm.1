Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098111;
	b=dXQJIL1pHrbmjdPs02s/GcsDTaAX6GsEWSIWbnYjZRJ7R7d7Ipe0jQc+BWDEZapbn9aP
	 VRNqNaFGIwtEgRfNWWu/ZyReNbvShzQJd3mE1niUBbDEGfraW9dw0WXZeQHPzyoZdUF9s
	 EhILOPHjC9eDsJS7ZrWPdHHaNH9/GYKBzqk3YEq80sj85PcMG7dxedp3Q29qQQ4Mzp6py
	 nU6a3T7lfn2qFZ71udfRTL7UdfGWLLKxm1l3rknB3nfkKmPktOJ/G3tY3SjTiF9S7PALT
	 qOXQiQMeUwJPAH2sDUdGHPy4vVvyhoKtW6PPudi0UzrRleuY8WaW7twTncXj3WdditA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098111;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=IkqO8A6QS0PAndl0gOo2QYnrynvbrcGU9eQw37shdb8=;
	b=KKDypAiSJwLLFyy/enNAjftHu4EUuB0x63SgonI1FPrkvMxgiEStstyZOOa6BTKte8cI
	 YZG0bEFolHGMC/SvPM9htpSsid4cLLAIJiMop8lJ7u1ULmaa4JcmBhIEitfuKYv0v1OTE
	 FIFyU5PlTUBlNN2kQeKEOHTVv7FrFUl2+JrYZJoIqZFONgpz1XDhKYMRyHnis1ArHkXil
	 yuF8DWazUQXEYDwyFV1FarLbYnvb6jbq/X6AK8qKJ2N81N9kaXza/PXsvLEVHprw1FoXJ
	 3rAQMDsA9F3grmGsLSW10dgYayBvCWPZQFZNOo4j69VYIQHoqtgJaxiHub9fou6h0oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MJACJ9f1;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="dyc7/3gn";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A5606A320
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 14:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 131A5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MJACJ9f1;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dyc7/3gn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795098110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkqO8A6QS0PAndl0gOo2QYnrynvbrcGU9eQw37shdb8=;
	b=MJACJ9f1OMezremMIW39T51aGQ/DiDWrIhaD2CZVfUuLDc+ftxQFfnRCSUGBGkqRCRkrZy
	sXdiuaQpEbF1cI6xGZHM3H6H04FIhxLDvMQn6SK13iCR2pnoKWw1Ob29C5w1J3BFTm4WUj
	NYpf9UoxRso3E5YJ+cjgCLztaFnJ9nk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-wLJvGpy1OeaesYgT7l0ZJg-1; Thu, 19 Nov 2026 09:21:47 -0500
X-MC-Unique: wLJvGpy1OeaesYgT7l0ZJg-1
X-Mimecast-MFC-AGG-ID: wLJvGpy1OeaesYgT7l0ZJg_1795098107
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f32050e72so596347585a.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 06:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795098107; x=1795702907; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IkqO8A6QS0PAndl0gOo2QYnrynvbrcGU9eQw37shdb8=;
        b=dyc7/3gn4MiCherAcbBgHh7mmwyxsTCwRq6oMbfxgAqEoJPzjUiGuM5EjEbKXFN3rL
         V6oS0DQrVbBudeUIXdnUJW+l3PziY8xsJ4f/HBj6fuFvleQREbppm0WeRkN9nFji/4zm
         J6+xnDQuIlKTs+d+Tpu5VKm7HpOX+KXwQ4D9p2CkUXNQ8t23bpOrixLIhaBuubOlp6Zb
         89aTSIaqc7y63FTGZuw5VThuTAZEqcEIt6GeeAcuDf1QmxIntXUieiTD/gATZBfMaqB2
         BvvfVbGiv4bXaFr9r1Y+0oZgHArn0QttI30B8ghHxUj5Ua+2nf6rAvrMMV3d1VjKzEAs
         AVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098107; x=1795702907;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IkqO8A6QS0PAndl0gOo2QYnrynvbrcGU9eQw37shdb8=;
        b=WpEjqVASLnixSFLhtCt+3yLzBbvGdbUZKQSVyzYeMIn/Q+Vm7tsXH0kyXsqg3sOfmv
         ET+glDzuzyeSt/Gpiwp3BSS+cOe4BV76hE5tEXeMoDGvBM3tv1jr7QkPGDn7c9OXGh2a
         kHi2IhFG1bUmOJ/2wdDUIV42nZiyoloxcJ/0DZccgePRM4uFrc5Ql8xHYevoseYzqAIp
         5yEyThnNR4pRViSZD8CsSKw+F7hh2/fGdG+e/oryolkGOn3+WxyuIuiqx+atBi6GIsdd
         iaIONDXYNavdwA8TVmuGxYzGMoa2ox1ZZgMBbDTqyMCdgImGyojUu/czux6OtrYZ5HPl
         HZ4Q==
X-Forwarded-Encrypted: i=1; AL+hErFyZ7HnDVq59BDWwd2UCGeAhvKOfpECks4lg/qSAlJlBxsEYru0Q4iSGL4RDtB1gvBtRNQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1UM8Ptt2Rc5KNPsnDsWAF1RozXCSoBYBB8qK/msSJkq9GYXwP
	O2UGiQYoPhoJPqmj8cXjDZFIGp72sv6Ndj370whjGbvaOEeb90rvBtjdAptZPScI7opWyZkbNNP
	9thl9hAk4bWjSahzbTmkpLtdHHcJDS45kfkfLRgzaTieoS6dxp153DQ==
X-Gm-Gg: AYBFou2T/anmsh8S9dC1z/j1qXkfJM1ENX63i4rjiWo71W122/NiFtsAZ+AmzibCt/p
	cX4SKGeU/rc+jc/wvr/YkeWkS6T4EqsE5G0Q7EE0kIbyvG7IIUTuXhQKJndq+31j+VXtm/98kAs
	0fGMydI2NkntFjZ0eEHu9zBETxzzXphwytTIse7omKkdssBJNAb7LPHVnbi2WsafPxdh8jj9F4X
	SoKbs6X+IDASjiZaEZgUoqX7O6wgunn8YHjzRxGVGxb8Z/vgooWlDG8sfxSPBLTmJOFhBH3kjCz
	rgroMyif88GVKWNcLZGoSlmyMOZJ+8GKiYG3IPAmFNkRkIjmJeX0kFV0OS+GfyYLaA5ecE/r9+G
	FhFVuN0ZayxDRytwg0OCoyZMMG6/JIs0/757/rYrZKc1N
X-Received: by 2002:a05:620a:4453:b0:947:8230:5328 with SMTP id af79cd13be357-949995b341amr1074014785a.34.1795098106974;
        Thu, 19 Nov 2026 06:21:46 -0800 (PST)
X-Received: by 2002:a05:620a:4453:b0:947:8230:5328 with SMTP id af79cd13be357-949995b341amr1074011085a.34.1795098106359;
        Thu, 19 Nov 2026 06:21:46 -0800 (PST)
Received: from localhost ([142.188.212.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949b9a3fd50sm2593385a.19.2026.11.19.06.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:21:45 -0800 (PST)
Date: Thu, 19 Nov 2026 09:21:44 -0500
From: Peter Xu <peterx@redhat.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: "Serge Hallyn (AMD)" <sergeh@kernel.org>,
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
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
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
Message-ID: <av8F-DwJnTkSeYsz@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f4f34bc3dd22c0e47b5ee764b1a4db8940cbbbec.camel@gmail.com>
 <auyZnIfxMnxYD8rT@shallyn-amd>
 <85f899cd277b2188cd4b33f8f21b206fa2ff6f6f.camel@gmail.com>
 <auyx8C67zCnbPpuL@hallyn.com>
 <c77156d1-5a47-4a93-a18b-392081fad3ff@intel.com>
 <avF6DcmdoGeWeRxg@tlindgre-MOBL1>
 <avJGEYIohYUN9l10@shallyn-amd>
 <avKolvbIuZj-aLD-@tlindgre-MOBL1>
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
In-Reply-To: <avKolvbIuZj-aLD-@tlindgre-MOBL1>

On Tue, Nov 10, 2026 at 07:16:06AM +0200, Tony Lindgren wrote:
> On Mon, Nov 09, 2026 at 04:15:45PM -0600, Serge Hallyn (AMD) wrote:
> > (Adding Tycho and Mahmoud, who will be working with me on this)
> > 
> > On Mon, Nov 09, 2026 at 09:45:17AM +0200, Tony Lindgren wrote:
> > > On Thu, Nov 05, 2026 at 06:00:41PM -0800, Kishen Maloor wrote:
> > > > On 11/5/26 8:42 AM, Serge E. Hallyn wrote:
> > > > > On Thu, Nov 05, 2026 at 05:59:01PM +0200, Artem Bityutskiy wrote:
> > > > >> On Thu, 2026-11-05 at 08:58 -0600, Serge Hallyn (AMD) wrote:
> > > > >>> ...
> > > > >>> So, looking at the section '### How the Setup Session Works', is it safe
> > > > >>> to assume that you are using the qemu migration fd for the message
> > > > >>> transfers?  So basically qemu loops over KVM_MIGRATE_SETUP calls, which
> > > > >>> ...
> > > > >> Yes, that's the flow. I’m not sure about the migration fd part, I believe we
> > > > >> pass the setup session data via ioctl buffers. I am sure Kishen will can
> > > > >> clarify.
> > > > > 
> > > > > If you mean pass via ioctl buffers from tdx->kvm-> back to qemu, which passes
> > > > > it over the migration fd to the other side, then that's what I expected.
> > > > > Othewise I'll be interested to the details :)
> > > > 
> > > > Hi Serge,
> > > > 
> > > > Your understanding is right. Migration setup requires a handshake of some sort
> > > > between the source and destination. So the messages KVM_MIGRATE_SETUP returns
> > > > are transferred over QEMU's migration channel to the other side and processed
> > > > by a matching call.
> > > 
> > > Serge, on the QEMU side, we have been enabling the return-path early for
> > > the key exchange before migration is active. Not sure if the key exchange
> > > can be done using a VMState, possibly could be if we can ensure it happens
> > > before the migration is active.
> > 
> > Key exchange requires bidirectional communication, so I don't think a
> > VMState would work, at least not on its own. If the destination's
> > info got send to the source out of band and delivered through migrate
> > command option, that could work, but it seems much nicer to me if it's
> > all done more transparently.  OTOH if this simplifies the qemu code
> > enough, maybe it's worth it.
> 
> Yeah agreed and can be revisited.

Just FYI: on QEMU side, we should be introducing handshake for migration
soon, so that there'll be an early stage where the out+in messages will be
all done in the entrance of migration_thread(), trying to have both src/dst
QEMUs talk first before really starting the migration procedure.

Agreed that vmstate isn't designed for bi-directional conversations.

That was initially for other things, including channel mgmts, sync
migration caps/params, but it sounds like it could be useful for CoCo too.

Thanks,

-- 
Peter Xu

