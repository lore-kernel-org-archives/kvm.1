Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109275;
	b=uWNbXkciJvWyIk6jzJeYjz5nmVje1iuGn0IkRyQntF/Pd0yfy06GZCHrQqLk1d9DqQGY
	 euB66rVU/L1YCxzN9utkcjkGFH88oQDxJ1EI3KSn8JrFapiZi9gjGor4BFd7GvWqmbGLC
	 rNWTiL36jphxWgTU0Sk4sfv4VtFSIbhEz843mspXn7kxheD70j4587DL7tGUtb3Pf94RE
	 1W2PspUuqhzIA8Y6x457JAvVYHUR+JhKauo52CuQjFe/i4WpcAC1cG3V72eSMkLap9WNG
	 xcGEdO3N6xMvmI6q9T2IxQDM7lDdqD6+bgQ4S2wxt5FcTeTffGRoyIcNWt3erz4sgLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109275;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=R30vV1ffX0wtflzAphxIYRxgMU8xWFxTy6RenazNjSo=;
	b=GjbiBI+pGJ6JWOap1IbdtX4diWme+KkKKbXp8sBvZQA0NMFFK0Rw0d9C+pTByBmblizm
	 1BqH+pdC3+p3H0gVSM9jJaHAMovb8of2Kh4vBBc2Y/nnh3RlZ2fKPTjNY5eIl6lm4Y8AM
	 BI+gsKstPt+20CM++EAU/L1TtoQ5rhzbpJQIAqwDE5/AUtttRvGGuc36oA2BjUJTEICJs
	 yk4LmzBxaRCZ6LRy/kjtlgJJJTF0qaLXRBCsSMSxh5W6oq1zLqCFFUL8HAvkFZizH8zoO
	 mVQ4yhbEHrTSWuzWvm5+1H5THCDc0BzO5ndJjwOjsthjvwA9M4B0QO8igkUkeYWlGUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GTO5UWrP;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TWgyP7E9;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1FA606A32A
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 17:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B1FA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GTO5UWrP;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TWgyP7E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795109274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R30vV1ffX0wtflzAphxIYRxgMU8xWFxTy6RenazNjSo=;
	b=GTO5UWrPmKnoz4JpG9TBVyRkQ7g5zg/bmmQOeXWu38ww8WsWEg2THlO2wBSZJZj2vWCIob
	fTzCETionmW9zUsEn3eoyywprUGL4FO51HAMpMf/s/0ElTXutRiFTGQd3+OPoHff69Tgw5
	07ThTZZUZLozLtrS2UxoMemBYW5r+zw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-QUwLgLBSPh-cnf9f7izN4A-1; Thu, 19 Nov 2026 12:27:52 -0500
X-MC-Unique: QUwLgLBSPh-cnf9f7izN4A-1
X-Mimecast-MFC-AGG-ID: QUwLgLBSPh-cnf9f7izN4A_1795109272
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-537548d4bc0so169581cf.2
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 09:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795109272; x=1795714072; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R30vV1ffX0wtflzAphxIYRxgMU8xWFxTy6RenazNjSo=;
        b=TWgyP7E9+BqVOocV7/BVO+iMECise6o191iA0t6092VkIhJoA3RZ2PeRcGQgS4Y4e9
         3REqCCfHqDS0AJgIxv5Tx1v+fpTg4MWP0M4bEys6dPLZydfuen1WSJmsWJcT0oX8EKE7
         qgUNjpSb4FJRdr5iYSZLsgTgUmH+A6cT/AdQaLsiBGO+vd0ZPtCA435Dcnstb59Xq9Gi
         o12PZ9S5RJqIlZM2FwChgn5cJFuE9aordj404IW38YwR8pKa5yg6d3YtVxz7v3dSTYhg
         1GT6LAVzmpxhGrxiHreu+G5CY610tI4y7JiPuYOp12JAplbcCyvKGHkYKE+LRQDQS9Yp
         ZKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795109272; x=1795714072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R30vV1ffX0wtflzAphxIYRxgMU8xWFxTy6RenazNjSo=;
        b=pkzcQSYpGkb2G35wYvI0Zva4jAJ3dxlZmE4WKvnOMCIujHTL+fLW1jr1EYmKiBy6wv
         XOQtuY61MD2gblakij4Cq8T6VdgEg3Y0DIbnPwKK7gllW6FR2QgVdlG+DQP7Gn1I3Xw+
         xVxwkVyuFsPk0fddA1AGz1daRhJjfFO40Bsywz4E938Yk6lEvM6csNje9BSRkXkdAYcX
         /uOREPbEWvJtjsvVm9c8cRsHrsJ68OCfw0s9o4xKLTgmjIMrGo04BrEkqquT8MemIoFO
         qukl+5lpb9n8RU7s+v5QQvqfg+myVEpXnfM6fGHLc7Ad/R/Ae8qa/vbEyVc9daQ9/+Db
         zxFQ==
X-Forwarded-Encrypted: i=1; AL+hErGaKZPLh/amVaY7Wb0FekPF2oo5m4ReIzHSAC9buuPW/piDUG02K4ZOoAkJacU7BHEUBH0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FglMlf+87FrFZpn4YGEpI4DSkp7y0jYzXKwABWhR/4k/I4cvR
	9js5TKaHkCzjnhDtrq0CsUOw3SiSOQmVyfmrqy4znl8g8DRJ0fxTczqZQa12C8kYFGvEgpBuuU0
	fGnSNp2PZ7kDTXKe13tmCVj+L00Vz3QGEmV/ED8rlynkBgYRNGPKc3g==
X-Gm-Gg: AYBFou0UIdxIbURUoBbkLSlBRie8prnztAkPThhD6YvpyrDfYVBqYdeniRY2ulA+k81
	lrRHI1IMCp25ni9r520CjD27NnXvdNqSNO/LZ9db0Ft19xAO8vLzdO4guEg+bm9HEw/1jPxb3x3
	+vi1fh1nIEZCJY0UstVEiydVNeYtXccQ//zoX+IKV3UwQL01fXVUtXEICn6zNxRV4ImB3RAx3e5
	JoGzfJhMTuIwZ3gTDfbE3MOyScBoQ+qCHf/JHW2fyPKptAcjyzYPR7S9CP3oGcFEUubKxvtiGos
	QGHeGMFI/aU2RRPFRVpR1WZcaiINhyd0obQHhkoXNpVCSdIbu4WpordmvbYkQ0kkRsBMutKssvL
	k7iCNe54wrjfaAzJTEDW7zTgD/NhKZt6JlbMxlj+Y67hl
X-Received: by 2002:a05:622a:507:b0:55c:5ebd:8823 with SMTP id d75a77b69052e-55d76ad31b1mr11441011cf.66.1795109272026;
        Thu, 19 Nov 2026 09:27:52 -0800 (PST)
X-Received: by 2002:a05:622a:507:b0:55c:5ebd:8823 with SMTP id d75a77b69052e-55d76ad31b1mr11440201cf.66.1795109271375;
        Thu, 19 Nov 2026 09:27:51 -0800 (PST)
Received: from localhost ([142.188.212.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349f6959sm3536706d6.31.2026.11.19.09.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:27:50 -0800 (PST)
Date: Thu, 19 Nov 2026 12:27:49 -0500
From: Peter Xu <peterx@redhat.com>
To: "Serge Hallyn (AMD)" <sergeh@kernel.org>
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
Message-ID: <av8xlXjzeRvz2Exu@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <f4f34bc3dd22c0e47b5ee764b1a4db8940cbbbec.camel@gmail.com>
 <auyZnIfxMnxYD8rT@shallyn-amd>
 <85f899cd277b2188cd4b33f8f21b206fa2ff6f6f.camel@gmail.com>
 <auyx8C67zCnbPpuL@hallyn.com>
 <c77156d1-5a47-4a93-a18b-392081fad3ff@intel.com>
 <avF6DcmdoGeWeRxg@tlindgre-MOBL1>
 <avJGEYIohYUN9l10@shallyn-amd>
 <avKolvbIuZj-aLD-@tlindgre-MOBL1>
 <av8F-DwJnTkSeYsz@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <av8tLIFEpHgluthp@shallyn-amd>
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
In-Reply-To: <av8tLIFEpHgluthp@shallyn-amd>

On Thu, Nov 19, 2026 at 11:09:00AM -0600, Serge Hallyn (AMD) wrote:
> On Thu, Nov 19, 2026 at 09:21:44AM -0500, Peter Xu wrote:
> > On Tue, Nov 10, 2026 at 07:16:06AM +0200, Tony Lindgren wrote:
> > > On Mon, Nov 09, 2026 at 04:15:45PM -0600, Serge Hallyn (AMD) wrote:
> > > > (Adding Tycho and Mahmoud, who will be working with me on this)
> > > > 
> > > > On Mon, Nov 09, 2026 at 09:45:17AM +0200, Tony Lindgren wrote:
> > > > > On Thu, Nov 05, 2026 at 06:00:41PM -0800, Kishen Maloor wrote:
> > > > > > On 11/5/26 8:42 AM, Serge E. Hallyn wrote:
> > > > > > > On Thu, Nov 05, 2026 at 05:59:01PM +0200, Artem Bityutskiy wrote:
> > > > > > >> On Thu, 2026-11-05 at 08:58 -0600, Serge Hallyn (AMD) wrote:
> > > > > > >>> ...
> > > > > > >>> So, looking at the section '### How the Setup Session Works', is it safe
> > > > > > >>> to assume that you are using the qemu migration fd for the message
> > > > > > >>> transfers?  So basically qemu loops over KVM_MIGRATE_SETUP calls, which
> > > > > > >>> ...
> > > > > > >> Yes, that's the flow. I’m not sure about the migration fd part, I believe we
> > > > > > >> pass the setup session data via ioctl buffers. I am sure Kishen will can
> > > > > > >> clarify.
> > > > > > > 
> > > > > > > If you mean pass via ioctl buffers from tdx->kvm-> back to qemu, which passes
> > > > > > > it over the migration fd to the other side, then that's what I expected.
> > > > > > > Othewise I'll be interested to the details :)
> > > > > > 
> > > > > > Hi Serge,
> > > > > > 
> > > > > > Your understanding is right. Migration setup requires a handshake of some sort
> > > > > > between the source and destination. So the messages KVM_MIGRATE_SETUP returns
> > > > > > are transferred over QEMU's migration channel to the other side and processed
> > > > > > by a matching call.
> > > > > 
> > > > > Serge, on the QEMU side, we have been enabling the return-path early for
> > > > > the key exchange before migration is active. Not sure if the key exchange
> > > > > can be done using a VMState, possibly could be if we can ensure it happens
> > > > > before the migration is active.
> > > > 
> > > > Key exchange requires bidirectional communication, so I don't think a
> > > > VMState would work, at least not on its own. If the destination's
> > > > info got send to the source out of band and delivered through migrate
> > > > command option, that could work, but it seems much nicer to me if it's
> > > > all done more transparently.  OTOH if this simplifies the qemu code
> > > > enough, maybe it's worth it.
> > > 
> > > Yeah agreed and can be revisited.
> > 
> > Just FYI: on QEMU side, we should be introducing handshake for migration
> > soon, so that there'll be an early stage where the out+in messages will be
> > all done in the entrance of migration_thread(), trying to have both src/dst
> > QEMUs talk first before really starting the migration procedure.
> > 
> > Agreed that vmstate isn't designed for bi-directional conversations.
> > 
> > That was initially for other things, including channel mgmts, sync
> > migration caps/params, but it sounds like it could be useful for CoCo too.
> > 
> > Thanks,
> > 
> > -- 
> > Peter Xu
> 
> Is there a draft repo/branch where we could look at the current state of
> the 'handshake' feature?

Nop, I can copy you (if I'm gonna write it..) when sending, current plan is
before end of the year.

Hopefully it shouldn't be anything complex. My current expectation is the
migration thread should own the main iochannel (for bi-directional IOs) for
a short while because the handshake needs talks back and forth, and it
should forward the return path channel only until handshake done, then
it'll become almost outgoing traffic like before (unless there's a postcopy
afterwards).

Thanks,

-- 
Peter Xu

