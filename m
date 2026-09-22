Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5206A1FC4
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 05:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790053790; cv=none; b=EeNaHdAhIaXPubEcH3L7Fn+1EzLmTLWb1EfA1pfBaOi1/nXFj4GNG1Xq9jxm4RvHReR1SvIZJCxlv/YfYcosq/ri5L5dX/xkQXPUiB6fj7wjOp4VvvhozWbQNMJahxRA0Ss/3xkUJanHyAT+QgPFUZAYZCtjp4QTFJ0Q+KGWrGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790053790; c=relaxed/simple;
	bh=2HLtP2Yv4Nx2CymfguppB+nP7otJIt8dCa1AtZHyA8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTiXWGnmdQYUyl9aaCV2eiW+y6DbMXiyeoNA4zJnit0MXo2S08SpVZoLM5fFvEroIJKIgnynQZC0v5aVcWUwE5+1Lc2XHB5TEyjFMR6A1cgloEwh9xOoBLcZ4H9uueQFGLDUNC+3HnH0GxKTd2Ak7/c7ZxsxgJ9cYHVEk2qmVyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJmzFx4n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJmzFx4n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790053788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8lySgQTIwlN8yYS4Yr7rj9AXvFidDh1HZ1sZdHYKoR0=;
	b=fJmzFx4nQYlkWAn9IJ6OG3/2XqBK2NnvLpwAwgbM719hXEDmPRCM0XamzPIqJ6WeNFhqLq
	nU61YDh9EzaA7hMwF0s3XO++sFD+a5ZOQ8Vo/RmA/1ivnop2NB2IMuoeDs5WjJC97guNG8
	BtiHM0SM5r+Nir8x08zilg+DjrgkEeo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-mo_Ppq1zNyWIsqqwiQiCTA-1; Tue,
 22 Sep 2026 01:09:44 -0400
X-MC-Unique: mo_Ppq1zNyWIsqqwiQiCTA-1
X-Mimecast-MFC-AGG-ID: mo_Ppq1zNyWIsqqwiQiCTA_1790053783
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73591180063A;
	Tue, 22 Sep 2026 05:09:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4C30418;
	Tue, 22 Sep 2026 05:09:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 42A4821E6A04; Tue, 22 Sep 2026 07:09:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  kvm@vger.kernel.org,  pbonzini@redhat.com
Subject: Re: [PATCH] kvm: turn fprintf into error_report
In-Reply-To: <20260921164442.1137615-1-vsementsov@yandex-team.ru> (Vladimir
	Sementsov-Ogievskiy's message of "Mon, 21 Sep 2026 19:44:42 +0300")
References: <20260921164442.1137615-1-vsementsov@yandex-team.ru>
Date: Tue, 22 Sep 2026 07:09:40 +0200
Message-ID: <87a4p998iz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Quick drive-by comments...

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Main benefit: ability to print timestamps.

Possible additional benefits:

* Ability to print guest name

* Print program name

* "This is an error" is obvious even at a glance

Benefits not applicable here (I believe):

* Print location if we have one

* Automatic redirection to the human monitor when appropriate

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  accel/kvm/kvm-all.c | 64 ++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 33 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 83cbd120a84..d271699db87 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -300,7 +300,7 @@ static KVMSlot *kvm_alloc_slot(KVMMemoryListener *kml)
       KVMSlot *slot = kvm_get_free_slot(kml);

       if (slot) {
>          return slot;
>      }
>  
> -    fprintf(stderr, "%s: no free slot available\n", __func__);
> +    error_report("%s: no free slot available", __func__);
>      abort();
>  }
>  

Bah, too much ceremony for me.  I'd do

       KVMSlot *slot = kvm_get_free_slot(kml);

       assert(slot);
       return slot;

The "print something to help developers fix the programming error;
abort()" pattern leads to having __func__ in error messages, which is
normally an anti-pattern, because error messages are for users.

But all that is outside the scope of your patch, and the maintainers may
have other ideas anyway.

[...]

