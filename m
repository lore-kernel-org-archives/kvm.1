Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439310;
	b=OH+Y7cGQFBYoUEmrixWwJHhOpGuBE2B6nk23ItAvSzKW2XeNoSnGYTX+NhVit8aAjHNE
	 FKSpRkqJf0bEoM1t8mw6ZWJpvTVxm4agDjU5o4z4EtK7pYT774ewp0EBVEvNZXawU8w4Z
	 2NhUGnOSnxmk1t1CzdhmsJ1z8zO9E2F1Rypoqz1wXXYlOpv37x3Oan+OqeYMiUuaXafHr
	 n78n8kyJjj2iCFNpm7FR1fbmFwo1FCYTfhiN6SZ9NmcIzWK37WTZvmpSXthGAiEke+EAH
	 Vq/S5qcZi1XMz07R5FhVwDU40egmOgcud8qUEdCS1WcgVxW8wX0kkVBbqxjkEO/dEzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439310;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Scanned-By;
	bh=pdvPNczTwLl4TbsrQeGwtn2bpfA7wPIowKpcfjyQjto=;
	b=5KHBzHAHfX3GwWdCPBzN9jUl6++qWX+SMHM2LJ+Ly4F2prr/xjdoE/xT4JUnWLOrLQfO
	 yz3m63BK1z8hidGbdg6G4uFeUsOd6kTDsP+yPObOrjy++rAUAxzG3i0n3UKj0Co/Go+WI
	 iZ798wwqCZn3TwfplI9dLp7ao3JlFBFqGzMK/9tXSnsSmXQD71Bzmr3LgD5MtC+gL2E+O
	 vQu/IlxLTVGr5DIa/hQRXs41KJ2dRdiD8/OGTlEDT1HIWkbEAxpR+Js2o4Vsd+4pXKymJ
	 7J3ph1JBX2XWeh7jmY+FR0Recw9qtAFPkM0ldnUB3KN3qy+RhqN/z+APHO1Dq0x73gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KKDrIXL3;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1A606A324
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 19:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7E1A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KKDrIXL3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792439308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdvPNczTwLl4TbsrQeGwtn2bpfA7wPIowKpcfjyQjto=;
	b=KKDrIXL3b65xa30L9fb3ymFIo021PJBf2k6/LC2Mj85YwDUm8k4/DeME5F6VAZbgTHhosf
	qk4unvtm4vE+GdyKZ3vm0XripunNQAPmRJteCo8eXWhI8SUHv/5tmBoQEkSR5SHu09aJPb
	76adiaeXBj9CIK5u9Q2xn+feAZRWqFQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-W37X9w1oP5CsYqTiQVPi5Q-1; Mon,
 19 Oct 2026 19:48:24 +0000
X-MC-Unique: W37X9w1oP5CsYqTiQVPi5Q-1
X-Mimecast-MFC-AGG-ID: W37X9w1oP5CsYqTiQVPi5Q_1792439303
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E2F01800868;
	Mon, 19 Oct 2026 19:48:23 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0E5830002CE;
	Mon, 19 Oct 2026 19:48:22 +0000 (UTC)
Date: Mon, 19 Oct 2026 15:48:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: seanjc@google.com, pbonzini@redhat.com,
	John Levon <john.levon@nutanix.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH] KVM: optionally post write on ioeventfd write
Message-ID: <20261019194821.GA157850@shajnocz.csb>
References: <20260306125651.2485-1-thanos.makatos@nutanix.com>
 <20260922135102.GA24134@fedora>
 <c18ef5464ff4fb4d607c6ae02c58024b41b3f17c.camel@infradead.org>
 <c213ca93393bffb774ac1642a4718f91a4c14891.camel@infradead.org>
 <20261015182208.GA1504100@shajnocz.csb>
 <fbf7e9f63141a539b69896edb07805abcd0f23d5.camel@infradead.org>
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
In-Reply-To: <fbf7e9f63141a539b69896edb07805abcd0f23d5.camel@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Oct 15, 2026 at 07:43:34PM +0100, David Woodhouse wrote:
> On Thu, 2026-10-15 at 14:23 -0400, Stefan Hajnoczi wrote:
> > On Thu, Oct 15, 2026 at 09:44:54AM +0100, David Woodhouse wrote:
> > > On Sun, 2026-10-04 at 18:16 +0200, David Woodhouse wrote:
> > > > 
> > > > FWIW while this is sufficient for implementing i82599 VF emulation, to
> > > > get line-rate TCP *performance* I also needed a directed yield_to() to
> > > > the consumer worker thread when it gets triggered.
> > > > 
> > > > And to get line-rate *UDP* performance I needed the consumer to be able
> > > > to arm/disarm it, to avoid getting throttled into lockstep with the
> > > > guest.
> > > > 
> > > > I'll clean up my proof of concept hacks and post them after LPC.
> > > 
> > > FWIW after a bunch of other performance work on the emulation it turns
> > > out I can live without this. As I was preparing to send a version of it
> > > upstream, I did a final retest with/without it, and it isn't needed any
> > > more.
> > 
> > Neat, were you able to still use ioeventfd without POST_WRITE or did you
> > take a different approach?
> > 
> > We ran NVMe emulation benchmarks with QEMU recently and found Windows
> > guests need ioeventfd POST_WRITE to get into the ballpark of virtio-blk.
> > I'm still keen for POST_WRITE to be merged.
> > 
> > Thanos & John: do you want to give the patch series another spin based
> > on the feedback?
> 
> Apologies, I was again being lax with my pronouns, and expecting my
> choice of citation to carry the information about what I meant by "it".
> 
> I am using the ioeventfd POST_WRITE (with Sean's put_user cleanup).
> 
> As cited above, I *had* implemented a directed yield too, and further
> made it possible for the consumer to arm/disarm that directed yield
> (becomes sometimes latency matters, and sometimes throughput matters).
> 
> Since then, I've done a lot more optimisation of wakeups and batch
> processing on the emulation side. So when I was preparing the directed
> yield for upstream submission and did a last-minute A/B test with and
> without the directed yield, I found that the directed yield didn't
> actually give me a significant win at all — neither for TCP nor UDP
> traffic.

I see, thanks for clarifying.

Stefan

