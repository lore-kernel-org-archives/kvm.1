Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3336D50D
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637642; cv=none; b=X/qxRaEhK9KjSKzMwptCOLd5ZU4/CB6V/Jz6Wyg9bmAaP48e0DMs2a0DGWAB0Ko+bHurSoLa9ezzvqGSdsGB7bW+bbNIq2qPXU1T6C/3yv4j+ydymnFQ0w20rGdIyJMj4/mfDD+D8tN59K6B5SV5WnmCl2zKlZVHEiSFPfL5boQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637642; c=relaxed/simple;
	bh=COxtpClv/wSqaNLIL/cO79S7D2VBKbRtlkLryQzvYVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stYQMYCz21Z9i/SgpXgh/zPeJx7wmpoGhAw7U1cHuuSnHy3WTz7ndLJUTUW8qDI4GkuxyGD4Fkh2+6A8H42NjIebN/PkcmE77j5YDZeqAyTsqp2KhH4J1w+QfRT8uX8uVOpOeGfqa39J7vANso21LgDzfRNMyJlgvGaTEiZKj70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WsbvSP6p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsbvSP6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775637639;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=vNzURTCjft3pnt4tIwyfboVA0t93gFW+FEnBhvEAE3A=;
	b=WsbvSP6pM88/Wyl+0RG+ekmci280s7q05psRcTMbDqH1wCUj9bV6ogyXMATQAppcW6qZJ9
	M9Vwi+I0JeJTG6wZJeUp3rvIWdkaux7Ei8PdYh4mI6lzi9Elm7kuUUHCpwG/EUDW8C9qoY
	6bEWHznZXgyu4WrwYQdienfhMvS8dBw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-nDRVTIecPha0KzhJ2AdGjQ-1; Wed,
 08 Apr 2026 04:40:35 -0400
X-MC-Unique: nDRVTIecPha0KzhJ2AdGjQ-1
X-Mimecast-MFC-AGG-ID: nDRVTIecPha0KzhJ2AdGjQ_1775637630
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC2A81955F41;
	Wed,  8 Apr 2026 08:40:29 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D84FC1955F2B;
	Wed,  8 Apr 2026 08:40:21 +0000 (UTC)
Date: Wed, 8 Apr 2026 09:40:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Matthew Penney <matt@matthewpenney.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Samuel Tardieu <sam@rfc1149.net>, Cornelia Huck <cohuck@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	"Collin L. Walling" <walling@linux.ibm.com>,
	Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
	qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
	Jason Wang <jasowang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/8] tree-wide: use g_clear_handle_id() for GSource
 cleanup
Message-ID: <adYUcqM4py9e_Q-B@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260408010026.4611-1-matt@matthewpenney.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408010026.4611-1-matt@matthewpenney.net>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Apr 08, 2026 at 01:01:42AM +0000, Matthew Penney wrote:
> This series replaces open-coded uses of g_source_remove() with
> g_clear_handle_id() across the tree.
> 
> This is a more modern (GLib >= 2.56) approach than directly calling
> g_source_remove().
> 
> g_clear_handle_id() simplifies cleanup of GSource IDs since it
> checks the ID is valid, calls the cleanup function and zeros the ID.
> 
> This reduces boilerplate and avoids open-coded calls to
> g_source_remove().
> 
> This series follows an earlier fix that removed a dangling GSource tag
> and replaced an explicit call to g_source_remove() with
> g_clear_handle_id().
> 
> No functional changes.
> 
> Link: https://gitlab.com/qemu-project/qemu/-/commit/34aad589019c8687fb3b19ba79d64d97071a7205

Looking at your git repo fork, while the commits are creditted under
your name, all the activity on the repo appears to have done by a bot
account:

  https://gitlab.com/mj-penney/qemu/activity

What's the situation here with authorship ? 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

