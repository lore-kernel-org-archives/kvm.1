Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212767;
	b=qavanLfeecjjCrc2ahEkvPdnXW1GfmBUfO5+EBHD72orGveeFcbii+04wtDdIkdT2YpL
	 2fr5KbGDTxlreYth8fdGehIy8pInolTsDx6Bn5Y/xcGglIZaxRYJdY+vQ8Wp/0vthnXjk
	 wtsRrMI5zeksTj/J97LSo6hqCNlm8rL8UaP9/yRQlLERkat/4TLCHKzrix86EYpTWL/OO
	 HyZXYU9MYrHCDPb1U0NODnyA3UKbh6BGpmPsbTz5jV+jT5Y19gjWyvEuC6aW3P+zQtMNL
	 FS6fvnOOt6Q5D1wcOyDJsyH8Ewh5aHg/FUIziV/w2Oszg8HZGNPdV6A7szHOXugJz9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212767;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Scanned-By;
	bh=/FEiyF7lvO+VeZfL6NdcHQ6bGh7nnima0uaaaqkLF34=;
	b=CyuDEgS1mBnDuTJcRIhWnIOnKivOYUL4Emx3T6TdyV4aSl0Ooe65mInMpcYIHx8pUmMb
	 xXMG+6R3BMiPNg6/CIMYxblY0zF0pQjv/c3HmkkUjzEUw9ZP8h/eW+/Kj1so+8IM9rDA7
	 EgwBr9LpIf4smHHSkzhvIgYxn30crixT1fAHJoM6vdssyWZd/7hLp/aKIBv4b03FXHwRX
	 2Fsbnsib0zDjTW3jgytSrD+lCrdwJZrsF0+0/B5jvv7FQRXjd7bGhSgMIXurXpWuU933W
	 FhrOKNrs5BodY7sTKKgGPtFf3CwlcyQGnZYYx9RdXogNC0VuP8etoMggehxgoWBMMpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XGon51NN;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF4F606A32A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 18:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DF4F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XGon51NN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793212766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/FEiyF7lvO+VeZfL6NdcHQ6bGh7nnima0uaaaqkLF34=;
	b=XGon51NNy30FQbRP0wyXmGis65jnbmh75Igmnh+tVx4E3vy1AePfSRASy55rZixlVv7AA1
	D7HzoVGf3sdKbMv0mqwW1tGh4etA59gg10Bi0vu/5VQRsXsguMknXbBv3lxLGX4RH08zep
	GqlYK6oWHG/YOEdNIcHJzeRAJM9I8JE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-fwgowlEDPm2is9-hyDytfw-1; Wed,
 28 Oct 2026 14:39:22 -0400
X-MC-Unique: fwgowlEDPm2is9-hyDytfw-1
X-Mimecast-MFC-AGG-ID: fwgowlEDPm2is9-hyDytfw_1793212761
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 200EE1953989;
	Wed, 28 Oct 2026 18:39:21 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7236A1800765;
	Wed, 28 Oct 2026 18:39:20 +0000 (UTC)
Date: Wed, 28 Oct 2026 14:39:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Cc: "seanjc@google.com" <seanjc@google.com>,
	John Levon <john.levon@nutanix.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v3] KVM: optionally post write on ioeventfd write
Message-ID: <20261028183919.GA1305253@shajnocz.csb>
References: <20261027180903.1008-1-thanos.makatos@nutanix.com>
 <20261028164728.848-1-thanos.makatos@nutanix.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028164728.848-1-thanos.makatos@nutanix.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Oct 28, 2026 at 04:47:30PM +0000, Thanos Makatos wrote:
> Add a new flag, KVM_IOEVENTFD_FLAG_POST_WRITE, when assigning an
> ioeventfd that results in the value written by the guest to be copied
> to user-supplied memory instead of being discarded.
> 
> The goal of this new mechanism is to speed up doorbell writes on NVMe
> controllers emulated outside of the VMM. Currently, a doorbell write to
> an NVMe SQ tail doorbell requires returning from ioctl(KVM_RUN) and the
> VMM communicating the event, along with the doorbell value, to the NVMe
> controller emulation task.  With POST_WRITE, the NVMe emulation task is
> directly notified of the doorbell write and can find the doorbell value
> in a known location, without involving VMM.
> 
> Add tests for this new functionality.
> 
> LLM (claude-4.6-opus-high) was used mainly for the tests and to a
> lesser extent for pre-reviewing this patch.
> 
> Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
> ---
> Changes since v2:
> - Require post_addr to be naturally aligned (Sashiko bot).
> - Goto unsupported_len instead of break in ioeventfd_write for
>   consistency (Stefan).
> 
> Changes since v1 (Sean):
> - Made test x86-only.
> - Added explicit padding to struct kvm_ioeventfd.
> - Renamed ioeventfd_test to ioeventfd_posted_write_test and moved to
>   maintain alphabetical sort.
> - Dropped post_addr from kvm_assign_ioeventfd_idx.
> - Expanded comment in kvm_assign_ioeventfd_idx.
> - Refactored part of ioeventfd_in_range() into ioeventfd_get_val()
>   and reused it.
> 
>  Documentation/virt/kvm/api.rst                |  14 +-
>  include/uapi/linux/kvm.h                      |   7 +-
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../kvm/x86/ioeventfd_posted_write_test.c     | 632 ++++++++++++++++++
>  virt/kvm/eventfd.c                            |  95 ++-
>  virt/kvm/kvm_main.c                           |   1 +
>  6 files changed, 729 insertions(+), 21 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86/ioeventfd_posted_write_test.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

