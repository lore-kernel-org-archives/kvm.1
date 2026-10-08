Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6683BB690
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 06:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439922; cv=none; b=mZ+fheRf0O3J7A3lYzeG9e6ozz8GUyic9CcpOy+PWWariqVk+4GHRA4f5zMEIhn/0gmCMsV1Zci6lbDFPzQejQhimyi3U2RtlVnceekVld+ZWfSKBwIqhZVP57VaX0ZK2eUI/6AGDekRk5J1W9tHHkqYYBXPecAcOCpy/K81L5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439922; c=relaxed/simple;
	bh=VF0P8cXBtZGAqzc8Bk6iLQpqW+1Z5Wx/laLVBflWsV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kke9gzeLwQEsIc2S/91A76amCskhWOFoLETy4o79wEgrTViWOXt/E+YwyauEXBJ/BY5dDDY+dgV3ayhvGfQv/LjHJE52rVXu+3S1APLvyU4o9pLK47slPf5XUdDdIxev8ipI9WL4kyhaglnQUJqDkbG9xdP6y4prVUODkbRS+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I17z1ywj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I17z1ywj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791439919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZoP6DJV1dVljcwC85DxYwTcpMtYwWwv9PxinZuWJ+8=;
	b=I17z1ywj1em9HBjohNlC61Zq/Br8BkpumOiZL4Mrx27N9CoVjMHf8L9jpfakLL5qzCGkQ8
	HbN2+IW39UJC8B/3oTgeEzKMqbWsJojlNfSkZ6JjdHByq47FYVqMGGtboul+sxbAlyoXm3
	ScFYM/2sNR91qV+D1KJonVkuMjW44bo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-ec-VZ4teNga6FvuFlnXmrw-1; Thu,
 08 Oct 2026 02:11:55 -0400
X-MC-Unique: ec-VZ4teNga6FvuFlnXmrw-1
X-Mimecast-MFC-AGG-ID: ec-VZ4teNga6FvuFlnXmrw_1791439914
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCA031953972;
	Thu,  8 Oct 2026 06:11:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24D8B19772CB;
	Thu,  8 Oct 2026 06:11:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id D5C4121E6A04; Thu, 08 Oct 2026 08:11:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  <pbonzini@redhat.com>,
  <berrange@redhat.com>,  <pankaj.gupta@amd.com>,  <xiaoyao.li@intel.com>,
  <chao.p.peng@linux.intel.com>,  <david@kernel.org>,
  <ashish.kalra@amd.com>,  <ackerleytng@google.com>,
  <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 18/19] i386/sev: Add sev-snp-guest parameter to
 enable in-place conversion
In-Reply-To: <20261007134323.1606088-19-michael.roth@amd.com> (Michael Roth's
	message of "Wed, 7 Oct 2026 08:41:42 -0500")
References: <20261007134323.1606088-1-michael.roth@amd.com>
	<20261007134323.1606088-19-michael.roth@amd.com>
Date: Thu, 08 Oct 2026 08:11:50 +0200
Message-ID: <87ld88pvq1.fsf@pond.sub.org>
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

> The sev-snp-guest object is currently used to provide confidential guest
> by using guest_memfd for private GPA ranges, and for shared GPA ranges
> the normal memory backend is used, i.e. "out-of-place" conversion
> between shared/private.
>
> Now that "in-place" conversion support is available in QEMU, add a
> parameter to select between these 2 modes of utilizing guest_memfd (it
> cannot be enabled transparently due to noticeable differences in
> behavior (e.g. memory usage accounting and lack of hugetlb support for
> shared GPA ranges) that userspace needs to be aware of when selecting
> the mode).
>
> Note that the actual capability checks for in-place conversion support
> in the host kernel will happen later in kvm_arch_init().
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  qapi/qom.json     |  8 +++++++-
>  target/i386/sev.c | 17 +++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 49f222796a..84166c2457 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1099,6 +1099,11 @@
>  # @tsc-frequency: set secure TSC frequency.  Only valid if Secure TSC
>  #     is enabled (default: zero) (since 11.1)
>  #
> +# @convert-in-place: If true, the same physical pages are reused
> +#     when memory is converted between shared and private states.
> +#     If false (default), separate allocations are used depending
> +#     on whether the page is private or shared.  (since 11.2)
> +#

Guidance on when to enable it?  Link to suitable docs would be fine.

>  # Since: 9.1
>  ##
>  { 'struct': 'SevSnpGuestProperties',
> @@ -1112,7 +1117,8 @@
>              '*host-data': 'str',
>              '*vcek-disabled': 'bool',
>              '*secure-tsc': 'bool',
> -            '*tsc-frequency': 'uint32' } }
> +            '*tsc-frequency': 'uint32',
> +            '*convert-in-place': 'bool'} }
>  
>  ##
>  # @TdxGuestProperties:

[...]

