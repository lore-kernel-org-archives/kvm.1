Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A33E3AAF40
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935416; cv=none; b=DTlXHw+LmqpRoetY8/Sl4KleqAid+7n3Zht1vf1vIrIScC9k04k6byw+8/XNED6r9bHgenRcZsGxFCDxAdPmAnZpSYt0lvO3ym0DAzpw2D2VsfRJEAbvDsNzRqB5kyyaJVpWRdYxhkG3ejYDT3S7B0pw4Wfrzy8hl5s5lEDkuSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935416; c=relaxed/simple;
	bh=Iv0J85Ue3BBsimlxic0Do1pcFve0TCeA0voWH5uSVHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iIzMy/aGbqLo8G7sdapMBWiSgRfroeFtZSycVTid87ZX98jAwQO4tFwT94aLXQ05UK/mZsW7ithEBrqzlTcUB+QN4ECuK/3ikipBEjv7FYFwHFyruYFXjgLDnVoIROuA7l7uwlKEB+ZlVh+1y8Y+aAlATEWm5fH4Sqvb0zb5mrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BleKGxU4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BleKGxU4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788935414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LC8+YbgnfxjDMTWkI2yYU7JFG1cx5/F6SPMn8GP1R3g=;
	b=BleKGxU4Mw//gYfA/41pZb8Z7R3XD0WzzBxFgb/ohPV5MWMsqnZhf/SZPH51gYHoWUoFyM
	5ZC15kw5Y2OGaxAJGXDmm/i57kNb77ljdhXlJeqRPXGah/AuhH1go3I6bIrbH0k928cvjl
	uXsrIjIGZRO3uWN4rKv/xtf77x+2CWg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-wfQRiOkkNlO55PQrgd115Q-1; Wed,
 09 Sep 2026 02:30:10 -0400
X-MC-Unique: wfQRiOkkNlO55PQrgd115Q-1
X-Mimecast-MFC-AGG-ID: wfQRiOkkNlO55PQrgd115Q_1788935409
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AD521800741;
	Wed,  9 Sep 2026 06:30:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19560418;
	Wed,  9 Sep 2026 06:30:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id C62B121E6A04; Wed, 09 Sep 2026 08:30:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  <pbonzini@redhat.com>,
  <berrange@redhat.com>,  <pankaj.gupta@amd.com>,
  <isaku.yamahata@intel.com>,  <xiaoyao.li@intel.com>,
  <chao.p.peng@linux.intel.com>,  <david@kernel.org>,
  <ashish.kalra@amd.com>,  <ackerleytng@google.com>,
  <lpieralisi@kernel.org>
Subject: Re: [PATCH v2 19/19] hostmem: Automatically select set
 guest-memfd=on for in-place conversion
In-Reply-To: <20260908205236.838281-20-michael.roth@amd.com> (Michael Roth's
	message of "Tue, 8 Sep 2026 15:48:39 -0500")
References: <20260908205236.838281-1-michael.roth@amd.com>
	<20260908205236.838281-20-michael.roth@amd.com>
Date: Wed, 09 Sep 2026 08:30:05 +0200
Message-ID: <874ifzos2a.fsf@pond.sub.org>
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

> When in-place conversion is enabled, both the shared memory and private
> memory must come from the same guest_memfd instance. Thus, the
> memory-backend-memfd options must in turn correspond to a guest_memfd
> instance, e.g. guest-memfd=on must be specified. Since there is no
> use-case for enabling in-place conversion without setting
> guest-memfd=on, just set it automatically if in-place conversion is
> enabled.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 20d6fefb04..32df7cb794 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -772,7 +772,8 @@
>  #     resizing of the memory (default: true)
>  #
>  # @guest-memfd: if true, use guest-memfd to back the memory region.
> -#     (default: false, since: 11.2)
> +#     (default: true for Confidential VMs with in-place conversion,
> +#     false otherwise, since: 11.2)

What does "Confidential VMs with in-place conversion" mean exactly?
Which configuration settings need to be set how?

>  #
>  # Since: 2.12
>  ##
> @@ -781,7 +782,7 @@
>    'data': { '*hugetlb': 'bool',
>              '*hugetlbsize': 'size',
>              '*seal': 'bool',
> -            '*guest-memfd': 'bool' },
> +            '*guest-memfd': 'OnOffAuto' },

Valid values change from JSON true and false to JSON "on", "off", and
"auto".

If @guest-memfd was already in a release, this would be a compatibility
break, i.e. a hard "don't".  But it isn't, it's in the series this is
one based on.  So it's merely a "either avoid or justify in the commit
message, and avoiding feels easier to me."

The doc comment still uses true and false.

>    'if': 'CONFIG_LINUX' }
>  
>  ##

