Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB21A582B9B
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088605; cv=none; b=KUJ29J63HHvYNi8dOMASHE1Jf+/qv44Rd6rv0VgbEVYzJZZJgn3XTt1ggRkP5TKgcEO6lNoJpofLN7cGFJQTWqBX1VS3Uhv6sV/R9x9Hxar8wIsMGj2VhcI8iKZpQOF5Y12MFJ/dDgBe5MySRVnW/jF91GI/u/eLqNQ/8w5VwmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088605; c=relaxed/simple;
	bh=PZCGih+4abasE3aVmOae6zjEbcUp/Wb0XZbuD70yPRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjUygZt/F3lelHo35CbWT+SIfQCD/SgoIG6Q/oTsTUmeQCXLdVdCE1Wru0fO6f0/xhrUnltvjbHmYGt1JVQvjPUTLp9M29gS/vvSRBiKs6z1KEQfxE+4uCtTexwtPLFkn+RNnUpe0S9CQ5+RZSk5xfaT17IjVUlwtDxW8xJLGEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Md/jC8oy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Md/jC8oy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792088601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qFOZy/qrPiEAf3OFmFsQkV6n6Cn/OUcSi0VbYsNOttY=;
	b=Md/jC8oynG4riCWIQpvI79ryXMoMEfnJ1Ee3xl7fkVRL8n/Pb8hVtWV6qLvx4ClrPUq3mX
	9AWWVAPWReHvMWnG/K0ntDn6+gcPNjq+7qGS5pBCKtOucDhC4cqXSxlerkfVjb9e2cH+Iu
	bwUAWO3FwXOQ0e3U9QKg2Yn68AQmgcE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-AO6Q001lMGOPb0LzKaY9tg-1; Thu,
 15 Oct 2026 18:23:11 +0000
X-MC-Unique: AO6Q001lMGOPb0LzKaY9tg-1
X-Mimecast-MFC-AGG-ID: AO6Q001lMGOPb0LzKaY9tg_1792088590
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9648195609E;
	Thu, 15 Oct 2026 18:23:09 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73A48300019F;
	Thu, 15 Oct 2026 18:23:08 +0000 (UTC)
Date: Thu, 15 Oct 2026 14:23:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: seanjc@google.com, pbonzini@redhat.com,
	John Levon <john.levon@nutanix.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH] KVM: optionally post write on ioeventfd write
Message-ID: <20261015182208.GA1504100@shajnocz.csb>
References: <20260306125651.2485-1-thanos.makatos@nutanix.com>
 <20260922135102.GA24134@fedora>
 <c18ef5464ff4fb4d607c6ae02c58024b41b3f17c.camel@infradead.org>
 <c213ca93393bffb774ac1642a4718f91a4c14891.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c213ca93393bffb774ac1642a4718f91a4c14891.camel@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Oct 15, 2026 at 09:44:54AM +0100, David Woodhouse wrote:
> On Sun, 2026-10-04 at 18:16 +0200, David Woodhouse wrote:
> > 
> > FWIW while this is sufficient for implementing i82599 VF emulation, to
> > get line-rate TCP *performance* I also needed a directed yield_to() to
> > the consumer worker thread when it gets triggered.
> > 
> > And to get line-rate *UDP* performance I needed the consumer to be able
> > to arm/disarm it, to avoid getting throttled into lockstep with the
> > guest.
> > 
> > I'll clean up my proof of concept hacks and post them after LPC.
> 
> FWIW after a bunch of other performance work on the emulation it turns
> out I can live without this. As I was preparing to send a version of it
> upstream, I did a final retest with/without it, and it isn't needed any
> more.

Neat, were you able to still use ioeventfd without POST_WRITE or did you
take a different approach?

We ran NVMe emulation benchmarks with QEMU recently and found Windows
guests need ioeventfd POST_WRITE to get into the ballpark of virtio-blk.
I'm still keen for POST_WRITE to be merged.

Thanos & John: do you want to give the patch series another spin based
on the feedback?

Stefan

