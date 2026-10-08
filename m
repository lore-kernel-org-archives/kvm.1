Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173983C0606
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440106; cv=none; b=uX70tduyjzsk9KUxs9tS8XqmCMSqzhZhuojXXiEGsg26iJ4pbIXX0HESdNdp3XbR+8H0cg/Kda6/JvpmCqJpuzRlOiu+vFhfJ9FoIuNgMfGEmvoRsG8zXm9a08GmqX4JlojMzNQQqsW8PA1zkIVFHPGU2v1XKbYImMnYwWFqIXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440106; c=relaxed/simple;
	bh=iZlvBhiQYHPEqa6L9KAd+g8PQotaI7euFSjW5CVhJtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WrSGWUM8XwJDtfGJOvDzJ9TOPc5VsTWvsQ3LYCqV2brudPYh5rJvtlldGOaEHX4nKFzyRUNSL78ACDVJXNxyI6K0sUTG5uSeQMgPQHxUc41hhl8Zm1QS+Z4G0MM5E0FGzSJ8iVDnk/w2LF67P9MR/mjTfEpUNyMgmtTpe32u7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahz39jf4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahz39jf4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791440103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7lR3YC/gBBURr2+yOaKT5TXCdHLjx5Uu46t8DzfHSU=;
	b=ahz39jf4+oIN0J6mAP4RHZYHALeGxaUHIgziskJzthVxvX6gKGJSHLADU3y8SgNpBZ7Tsl
	PwTSbCKlGCzTh8KqnR3X9rx3grDdPKpD9R2I9RKPqhIYzOyTkch+JmOswYEQvKpLl9HHPs
	KwM2JkQZ8gSDmNtLr8aBkRKaPbdd900=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-kSF5cEt7PA-P98KxWrGqfQ-1; Thu,
 8 Oct 2026 06:15:00 +0000
X-MC-Unique: kSF5cEt7PA-P98KxWrGqfQ-1
X-Mimecast-MFC-AGG-ID: kSF5cEt7PA-P98KxWrGqfQ_1791440099
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 912BB180B5EE;
	Thu,  8 Oct 2026 06:14:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5BC21956040;
	Thu,  8 Oct 2026 06:14:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 73A2421E6A04; Thu, 08 Oct 2026 08:14:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  <pbonzini@redhat.com>,
  <berrange@redhat.com>,  <pankaj.gupta@amd.com>,  <xiaoyao.li@intel.com>,
  <chao.p.peng@linux.intel.com>,  <david@kernel.org>,
  <ashish.kalra@amd.com>,  <ackerleytng@google.com>,
  <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 19/19] hostmem: Automatically select set
 guest-memfd=on for in-place conversion
In-Reply-To: <20261007134323.1606088-20-michael.roth@amd.com> (Michael Roth's
	message of "Wed, 7 Oct 2026 08:41:43 -0500")
References: <20261007134323.1606088-1-michael.roth@amd.com>
	<20261007134323.1606088-20-michael.roth@amd.com>
Date: Thu, 08 Oct 2026 08:14:25 +0200
Message-ID: <87h5iwpvlq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Michael Roth <michael.roth@amd.com> writes:

> When in-place conversion is enabled, both the shared memory and private
> memory must come from the same guest_memfd instance. Thus, the
> memory-backend-memfd options must in turn correspond to a guest_memfd
> instance, e.g. guest-memfd=on must be specified. Since there is no
> use-case for enabling in-place conversion without setting
> guest-memfd=on, just set it automatically if in-place conversion is
> enabled (unless guest-memfd has been explicitly set to 'off', in which
> case generate an informative error message).
>
> Also update the 'guest-memfd' documentation to note this behavior.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>

[...]

> diff --git a/docs/system/guest-memfd.rst b/docs/system/guest-memfd.rst
> index d62a214a91..4477756424 100644
> --- a/docs/system/guest-memfd.rst
> +++ b/docs/system/guest-memfd.rst
> @@ -53,6 +53,27 @@ exposed as an experimental for the time being:
>   * guest_memfd does not currently support the hugetlb=on option
>   * guest_memfd does not currently support Transparent Huge Pages
>  
> +In-place conversion
> +-------------------
> +
> +Newer kernels now support using a guest-memfd instance for both
> +private and shared memory at the same time by re-using the same
> +physical backing pages if a guest converts a GPA range between
> +shared and private. This is known as "in-place conversion".
> +
> +For some confidential computing architectures, like SEV-SNP and
> +TDX, this mode offers better performance due to not needing to
> +deallocate/reallocate between 2 separate pools of shared vs. private
> +memory every time the guest converts memory between shared/private.
> +For other architectures, this is the only supported mode of
> +operation.
> +
> +When in-place conversion is enabled, it is necessary to use the
> +memory-backend-memfd backend with guest-memfd=on as shown in the
> +"Usage" section. Because of this, guest-memfd=auto (which is the

Recommend to make this a link.

> +default) will result in the parameter being automatically enabled
> +if the confidential guest type enables in-place conversion.
> +
>  References
>  ----------
>  
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 84166c2457..5d66e67087 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -756,8 +756,9 @@
>  # @guest-memfd: if 'on', use guest-memfd to back the memory region.
>  #     See the :doc:`/system/guest-memfd` documentation for more
>  #     details.  If 'auto', the option will default to 'off'
> -#     currently, but in the future it may result in the option being
> -#     set to 'on' for QEMU configurations that explicitly require it.
> +#     unless the QEMU configuration explicitly requires it to be set,
> +#     e.g. if in-place conversion is enabled for confidential guest
> +#     types like sev-snp-guest.
>  #     (default: auto, since: 11.2)
>  #
>  # Features:

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>

