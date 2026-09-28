Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A84DDB53
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606303; cv=none; b=NmE5eXWo2ltq0SZkCulOTxktxJbzsj2gqtwNtsjnHDpyzUr2fBoK6FnK1q4+/Lw7HWslPLPQDoPUGMrTE1j/4qOY4agI4Jp5DRYnpnbsNEM2XvPuYR7cTqYxpVF/JgzSatYm5QDWWzHDjW/2Gtl5BdaP9eVt8nRfNCEagEN+pBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606303; c=relaxed/simple;
	bh=1+l2wjt3tFi8SVn8ALzml5oYkVrOCcl2WJGva96EPYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBP1NVrcd4xmEzKFogntiyIQAAamrDPzJ+VXLkV7KqanpINRu4wJ3RBflRwX17pAKL2a5quw6sQnRZLllmfZbAZG89zkGNRGDfbRbC2nhw6A94VhGbVF+mA/Hq++gcoTG5kIRagzi+cuPJh8Sld9ZeBRS0bkZ1PLqP0rBVQ/n7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuLRm67W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuLRm67W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790606289;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HRoEARxt1LOAlBRMjh7dtiftjocLyio6mFCv66oqEZc=;
	b=PuLRm67WKMwjFBuzQcl+L70u6qBHvNT/lvgm/gQ1BxXHjjPq0FLQV8mCsyQK7MmuAuDnQG
	6PTgOvqqk/kUvatlFvuF/ajoBMkz140RYHAALS4cmNDciCKyr9jvCDycWkXJUpf7n8jlWN
	i8g/cfd96CRE040TUgjf5TPGNssJM1k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-GGmtSyjpMXSE4Ss8IdUdpg-1; Mon,
 28 Sep 2026 10:38:06 -0400
X-MC-Unique: GGmtSyjpMXSE4Ss8IdUdpg-1
X-Mimecast-MFC-AGG-ID: GGmtSyjpMXSE4Ss8IdUdpg_1790606284
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEBEB180A217;
	Mon, 28 Sep 2026 14:38:03 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81ABA30000E6;
	Mon, 28 Sep 2026 14:38:00 +0000 (UTC)
Date: Mon, 28 Sep 2026 15:37:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
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
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
Message-ID: <arp7xUzPHmkgfxLC@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com>
 <CAE2XoE9AAz8KfJrpErBaZvW5p5COxfE1yveA_AMPwa0j=ghyEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2XoE9AAz8KfJrpErBaZvW5p5COxfE1yveA_AMPwa0j=ghyEA@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Sep 28, 2026 at 10:24:39PM +0800, Yonggang Luo wrote:
> On Mon, Sep 28, 2026 at 6:14 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > I don't think that we need to report machines though.
> > We already have 'query-machines' which gives much broader
> > information on the machines. "MachineInfo" needs to
> > gain
> >
> >    "targets": ["SysEmuTarget"]
> >
> > to list which target(s) a machine can be used with.
> >
> 
> This is my final design for the query-target / query-targets / query-machines,
> for consistency and testability.
> 
> Per review: reuse `QemuTargetInfo` for both target commands, drop the
> per-target machine list, and let
> `MachineInfo` say which target(s) each machine runs on.
> `QemuTargetInfo` stays small; `query-target` and `query-targets` return a
> derived struct that adds the target's device and accel Kconfig state.
> 
> ## QemuTargetInfo
> 
> ```
> { 'struct': 'QemuTargetInfo',
>   'data': { 'arch': 'SysEmuTarget' } }  # since 1.2
> ```

> ## QemuTargetDetails: QemuTargetInfo plus kconfig
> 
> ```
> { 'struct': 'QemuTargetDetails',
>   'base': 'QemuTargetInfo',
>   'data': { 'kconfig': 'any' } }
> ```
> 
> `kconfig` maps every device and accel `CONFIG_*` symbol to whether it
> is enabled for that target.

KConfig is an internal implementation detail that should not be exposed
to management apps as we don't want KConfig to become an ABI we must
preserve.  QAPI introspection provides feature based information to
the user. eg instead of querying for "CONFIG_SEV", qom-list-types can
be queried to look for the 'sev-guest' class.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

