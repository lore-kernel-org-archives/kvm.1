Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345246EF78
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787836043; cv=none; b=MLZDBoIqbhEFARirrz8QY7GjvU3+G0gZE5RG2Z6WUmZ/pZK3zV3nK5785vCbYs8QIozf7naGQzZWzzH0xLGQ/7hCFWLoePL/qX7AXwSKQ4Mw7dfsn2NqkfR5Knfar4ALZBKTh6NruXoNBH/ugktbYDsKKnEgQlVtCj0akfEoJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787836043; c=relaxed/simple;
	bh=nwDTZJHZOcBwl9ilmZZ3o0oMQpMitgYWB4DCLi/dwlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgB78KeRHFKgYea7lemudQ2TGCkjMu2RzGhRKHGrqC6aYN0dGfkwxK1xJHsGNlinHtmI9fIHuQnLHILZsu4fPZnwBYnPsHdpqeWMW9jl1UJem4toN1ord/ODoSf+oPw0K+D+OSYiDisuKfS2CAtzd5SBsgr7DLaSniWH3J8kRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EM+TWHxb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EM+TWHxb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787836021;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=Mh3D0c8HMi9HiFStvEOvYPHkOE70zz9VonxkPPBkf8U=;
	b=EM+TWHxbAVLCEC7AdWv1Sl0hKX3c0GfT3y1M8YqbG3JDJqynTwLm+cgmM9lb+K0sjw2tfq
	WU/s/k7BhjVJuZLznRH/hQmlZQM6zMd10ibOSUp84OHimcPvS+rvHTqIYSId6OGjp15SuR
	Odae6tjP7Y+fHwRARRlLeWOpB/cHn1o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-S5OhsjGJMCCQALStn4DJcw-1; Thu,
 27 Aug 2026 09:06:58 -0400
X-MC-Unique: S5OhsjGJMCCQALStn4DJcw-1
X-Mimecast-MFC-AGG-ID: S5OhsjGJMCCQALStn4DJcw_1787836016
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44C17195605B;
	Thu, 27 Aug 2026 13:06:56 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 610E81955F70;
	Thu, 27 Aug 2026 13:06:52 +0000 (UTC)
Date: Thu, 27 Aug 2026 14:06:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
	lorenzo.pieralisi@linaro.org, gshan@redhat.com,
	enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v3 00/24] Add Realm support to QEMU-VMM
Message-ID: <apA2aSd4Gcic9vAP@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Aug 25, 2026 at 04:00:37PM -0600, Mathieu Poirier wrote:
> This patchset provides minimal functionality to start a Realm VM
> from an Arm RME capable host using the following command line:
> 
> qemu-system-aarch64 \
>  -M confidential-guest-support=rme0,memory-backend=ram0 \
>  -object rme-guest,id=rme0,convert-in-place=on \
>  -object memory-backend-guest-memfd,id=ram0,size=1G,share=on \
>  -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..

This example mentions 'convert-in-place=on', but I don't see that property
implemented in this series. Is the example a mistake or is this from a
further follow-on series yet to come ?


Also as a more general conceptual question, in there going to be any
equiv to SNP's  "hostdata" or TDX's  "mr-config-id", that will let the
guest owner pass in some bytes of data that get included in the
measurement ?  Trustee has mention of "CCA_REALM_PERSONALIZATION_VALUE"
for Arm.  Would that become a property of 'rme-guest' in future work ?


With regards,
Daniel

[1] https://github.com/confidential-containers/trustee/blob/main/kbs/docs/initdata.md
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

