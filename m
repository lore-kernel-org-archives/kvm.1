Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2130E48FF9E
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588622; cv=none; b=haIR5EeZqwh750Vj4HKriys/0y0fBKSvvit5YxTrEB9uKXkooKLb/e+uNK+o1ttPs8/3QwcylyB0hl72odL/Cbx9tBd5v6zzW0Dnrrhw7JrB0kC1Id+3xstnKr7S3pvQ5CYgGOA2yMJdlbBpjRXFMWrsoWj/clkyo4QjCrApX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588622; c=relaxed/simple;
	bh=Wo5F+G1aoglsMl5rHHJWkC68/pTer3k+a8n0Lm746KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0H3B5cI1XsGVg8nSyXcqUi6HKZfs8qZ20TCGugH04CZ3R5e6Jmgi/J25Ae4B4vl7lCVQqp6x45gwxyWWDi13fBQGAli4ToT0KAQMpWHFSzA2vkBZvzRXw54eeH2Gy5jX9tHHDYoqn1geizoXAc/6Yiogkj0qwS3YL6A6TyOODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=biOV9UUE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biOV9UUE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790588618;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgwxBd2lhtF/+144PCX+zHLE6EbpljRvotoGAM+4e18=;
	b=biOV9UUEgsAewnYns5rfa7c8UBx7zd37+Lj+ErTe1rkhdlqDBNhpo/tE+x0vG61nuEla5H
	0yAYshs4XxV7RSVkvx7q7VKTg/SzCYGKFERQgNuu185CQAvLAGs3Gyrneo8wWPe4sFSGhk
	gRPLv2YlSkL/NeCWqazTyWAS4vGhafg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-rqxwCjFFP6-0yhehBXP72g-1; Mon,
 28 Sep 2026 05:43:33 -0400
X-MC-Unique: rqxwCjFFP6-0yhehBXP72g-1
X-Mimecast-MFC-AGG-ID: rqxwCjFFP6-0yhehBXP72g_1790588611
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 264891953958;
	Mon, 28 Sep 2026 09:43:31 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F3A11956095;
	Mon, 28 Sep 2026 09:43:27 +0000 (UTC)
Date: Mon, 28 Sep 2026 10:43:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 07/55] tests/unit: add test-target-info
Message-ID: <aro2vIQRSspHUbju@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-8-luoyonggang@gmail.com>
 <87zex1hhhj.fsf@pond.sub.org>
 <CAE2XoE9_R13NsUWu-s12QA9RBJykR87TEMh3VmndNEXQsCkNtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2XoE9_R13NsUWu-s12QA9RBJykR87TEMh3VmndNEXQsCkNtg@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Sep 28, 2026 at 05:21:06PM +0800, Yonggang Luo wrote:
> On Mon, Sep 28, 2026 at 5:07 PM Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Yonggang Luo <luoyonggang@gmail.com> writes:
> >
> > > Collect each target-info-def.c object in target_info_def_objects,
> > > keyed by target dir. Link every value so constructors fill the
> > > list. Assert target_info() is not NULL and target_info_list() has
> > > one entry per linked object.
> > >
> > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >
> > Doesn't compile for me:

snip

> >
> > I have meson 1.8.5.
> >
> 
> Hi, It's because I use a feature from meson 1.10.0, you can install meson
> 1.12.0 for it. and the remote branch I also fixed for KVM and got gitlab
> running. but for this series you need to install meson 1.12.x

There needs to be a patch in this series that bumps the required
meson version then.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

