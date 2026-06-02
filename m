Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061E3B992F
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388534; cv=none; b=WpTR4+bwFfXpSSlicZu12ohedAu3p1EJq65EL9DE1VyLCcukrUOFlrLUM0FpeyrLgXTM6kF5cLgipRRimK5BoP5aFdnOTBjBH2WNtOieUql3bUCuPRpBvIcIG7XygV8mcrm9sqCCg9SF6pfpbfsdF6MkFO2MmnpZh5IJoyvEw1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388534; c=relaxed/simple;
	bh=blH/TH3DPDlZMNnrL7AMZ3qp6Ajm0tsbE6gqdjkETxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wfs++rm1blRzHySsDG9g7fdbO/9lyU0Qr+6xSdb2ja9yK3jkd87tYn1bY2wdrenNM0ugGpl9j/G5zShGgEv8qUBSSd4homSU3OvJiFOLJF/6wmVLBEnybrXhvkKF/1eN5GjMKHPLueuDato4zf3WA+RJ8ZrqYkNHg5e9S2oYFeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcvSTlGD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcvSTlGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780388532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVaJ28YncjhCLTaSyTtA/MThSayBHlneCG9Gaac4gfA=;
	b=UcvSTlGDhcMUqrkrZqc80iqBm0tQuoERdZvbRTWZsQVzFSc7nRtWcfJp8+yNWu+vrjMbuy
	83m99i+OCnBDa3h9+EdYGFv0k7wgKkyHUCb2GTw9EUB/tA/9LZPI1p+fBn9xo5iPkaGa1E
	WAc10ZRiLZMA4XIz1wW0to0RTJ7+rlM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-SkdbMs3PMu2HihVbiuwNMQ-1; Tue,
 02 Jun 2026 04:22:06 -0400
X-MC-Unique: SkdbMs3PMu2HihVbiuwNMQ-1
X-Mimecast-MFC-AGG-ID: SkdbMs3PMu2HihVbiuwNMQ_1780388525
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73B8018005B8;
	Tue,  2 Jun 2026 08:22:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A71C1681;
	Tue,  2 Jun 2026 08:22:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 16CE721E6A01; Tue, 02 Jun 2026 10:22:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  <pbonzini@redhat.com>,
  <berrange@redhat.com>,  <pankaj.gupta@amd.com>,
  <isaku.yamahata@intel.com>,  <xiaoyao.li@intel.com>,
  <chao.p.peng@linux.intel.com>,  <david@kernel.org>,
  <ashish.kalra@amd.com>,  <ackerleytng@google.com>
Subject: Re: [PATCH RFC 02/12] hostmem: Introduce dedicated memory backend
 for guest_memfd
In-Reply-To: <20260528000416.8161-3-michael.roth@amd.com> (Michael Roth's
	message of "Wed, 27 May 2026 19:03:27 -0500")
References: <20260528000416.8161-1-michael.roth@amd.com>
	<20260528000416.8161-3-michael.roth@amd.com>
Date: Tue, 02 Jun 2026 10:22:01 +0200
Message-ID: <871pep73o6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Michael Roth <michael.roth@amd.com> writes:

> In the initial implementation of guest_memfd in the linux kernel, it
> was not possible to map memory into userspace for direct access; instead
> the memory provided by the memory backend would be used for cases where
> a confidential VM wants to access normal/unprotected/unencrypted memory
> that can be used for shared memory use cases, and for access to private
> memory a guest_memfd could be associated with the same memslot. A memory
> 'private' attribute set via KVM_SET_MEMORY_ATTRIBUTES could then be used
> to have KVM route to the approprate backing memory.
>
> In that model, it didn't make sense to introduce a specific backend for
> guest_memfd, since there was always a generally need to have a separate

a general need?

> backend type to handle shared memory access/allocation. Instead, QEMU
> configures the guest_memfd support for the associated memslots
> internally for cases where it is running a confidential VM.
>
> However, with recent changes in guest_memfd kernel support, it is now
> possible to mmap() a guest_memfd FD into userspace and use it for shared
> memory, as well as continue to use the same physical pages for the same
> GPA ranges after they are converted to private ("in-place conversion").
>
> To enable the use of this mmap()-able/guest_memfd-provided memory to be
> used for normal/shared memory instead of just for private memory,
> introduce a dedicated guest_memfd memory backend that can be used both
> for confidential VMs that wish to make use of in-place conversion, as
> well as for non-confidential VMs that just want to make use of
> guest_memfd for normal memory (which can be useful both for testing as
> well as a stepping stone to things like software-protected VMs where the
> host can be trusted to provided some additional degree of isolation for
> the VM independently of hardware support).
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index dd45ac1087..502fafeb15 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -661,7 +661,8 @@
>  # @share: if false, the memory is private to QEMU; if true, it is
>  #     shared (default false for backends memory-backend-file and
>  #     memory-backend-ram, true for backends memory-backend-epc,
> -#     memory-backend-memfd, and memory-backend-shm)
> +#     memory-backend-memfd, memory-backend-shm, and
> +#     memory-backend-guest-memfd)
>  #
>  # @reserve: if true, reserve swap space (or huge pages) if applicable
>  #     (default: true) (since 6.1)
> @@ -780,6 +781,18 @@
>              '*seal': 'bool' },
>    'if': 'CONFIG_LINUX' }
>  
> +##
> +# @MemoryBackendGuestMemfdProperties:
> +#
> +# Properties for memory-backend-guest-memfd objects.
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'MemoryBackendGuestMemfdProperties',
> +  'base': 'MemoryBackendProperties',
> +  'data': {},
> +  'if': 'CONFIG_LINUX' }
> +

Identical to MemoryBackendProperties so far.

>  ##
>  # @MemoryBackendShmProperties:
>  #
> @@ -1234,6 +1247,8 @@
>      'memory-backend-file',
>      { 'name': 'memory-backend-memfd',
>        'if': 'CONFIG_LINUX' },
> +    { 'name': 'memory-backend-guest-memfd',
> +      'if': 'CONFIG_LINUX' },
>      'memory-backend-ram',
>      { 'name': 'memory-backend-shm',
>        'if': 'CONFIG_POSIX' },
> @@ -1312,6 +1327,8 @@
>        'memory-backend-file':        'MemoryBackendFileProperties',
>        'memory-backend-memfd':       { 'type': 'MemoryBackendMemfdProperties',
>                                        'if': 'CONFIG_LINUX' },
> +      'memory-backend-guest-memfd': { 'type': 'MemoryBackendGuestMemfdProperties',
> +                                      'if': 'CONFIG_LINUX' },

You could use MemoryBackendProperties here, and drop
MemoryBackendGuestMemfdProperties, similar to how memory-backend-ram
is done.

>        'memory-backend-ram':         'MemoryBackendProperties',
>        'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
>                                        'if': 'CONFIG_POSIX' },

Should we provide guidance on when to use which memory backend?  The
commit message provides some clues...

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 96ae41f787..3c754c149f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5858,6 +5858,11 @@ SRST
>          off will cause a failure during allocation because it is not supported
>          by this backend.
>  
> +    ``-object memory-backend-guest-memfd,id=id,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
> +        Creates an anonymous memory file backend object that has similar
> +        semantics to memfd, but is also usable as private memory when
> +        running as a confidential VM. (Linux only)

There is no object type "memfd".  Do you mean "memory-backend-memfd"?

If yes, that one has additional properties @hugetlb, @hugetlbsize, and
@seal.  Why are they not needed for memory-backend-guest-memfd?

> +
>      ``-object iommufd,id=id[,fd=fd]``
>          Creates an iommufd backend which allows control of DMA mapping
>          through the ``/dev/iommu`` device.

