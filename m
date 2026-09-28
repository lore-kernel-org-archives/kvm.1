Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716BC496D5E
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593040; cv=none; b=Vx9wlg6/DmKsGar+UHw9tIGZHaFu1zw3pUci+uOLDjttV5a94XIHeSQxlpGe4umJ+e81D+PnGNfWwzHFzf59dexXVXG7xNeM2BHnPCI58qyQY1AnVliBK+yA2MdhHdNqU2NBZ5DrYDkcXfo2iSQ6dwZx9RrCuTvbYbgKwcJYpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593040; c=relaxed/simple;
	bh=9Uc0wAdERe1daog+4RCvnNHwKCsA3ndPdG/Wc6uOvOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V84bVRY4+4105dkRrvytXDVPpgix/8D0bdU4xGyuMqrdKFxY/WSyUce4W0AeAwhpEGpMUi9qxD8thVQ2Q7ABSO6axCzMY8RLP/XF/MsJ/HIMKWMPExYmX3sZFWPojBSS/Megh3Gpjc1jHzZoetgkryCAC9Y7aqfP5l94HbRn0lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmGS0Lhr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmGS0Lhr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790593037;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YDar4Z7zDZs3Gf1LVC2IUvdH1Oto7aASa+E88d+qPwo=;
	b=EmGS0Lhr4DyRJcQgODRkuWbx5yuYqz2Z7YW4u2vPssaR6/4WETyIqerqzRhSdGEBKMwVYd
	0DBKt8k2bT9o9AwjdpWmfsBWtNzgtLIeV85biyaTXPxRfy5cvqQmv57u5Cjd6TBzhoumoq
	MUXa9ea62QlM6Nu1n0gPe5G5imaJ65o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-dBhQGp6tMvW_GPR04Ctp6w-1; Mon,
 28 Sep 2026 06:57:11 -0400
X-MC-Unique: dBhQGp6tMvW_GPR04Ctp6w-1
X-Mimecast-MFC-AGG-ID: dBhQGp6tMvW_GPR04Ctp6w_1790593030
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0FED195394F;
	Mon, 28 Sep 2026 10:57:09 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76C7C1956087;
	Mon, 28 Sep 2026 10:57:06 +0000 (UTC)
Date: Mon, 28 Sep 2026 11:57:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org, kvm@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
Message-ID: <arpH_2anGV-JU12e@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com>
 <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
 <CAE2XoE9qsZZ+AnfGQ797SQj5yXP8SDOZyxYoKP=oh57UPFqq0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2XoE9qsZZ+AnfGQ797SQj5yXP8SDOZyxYoKP=oh57UPFqq0Q@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Sep 28, 2026 at 06:51:41PM +0800, Yonggang Luo wrote:
> On Mon, Sep 28, 2026 at 6:39 PM Philippe Mathieu-Daudé <
> philmd@oss.qualcomm.com> wrote:
> >
> > On 28/9/26 12:13, Daniel P. BerrangÃ© wrote:
> > > On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
> > >> query-targets lists each linked target, including none, with its
> > >> arch, endianness, and the machines that target accepts.
> > >>
> > >> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > >> ---
> > >>   hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
> > >>   qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++++
> > >>   2 files changed, 65 insertions(+)
> > >
> > >
> > >> diff --git a/qapi/machine.json b/qapi/machine.json
> > >> index 6aaa2af709a..d8cdea6203e 100644
> > >> --- a/qapi/machine.json
> > >> +++ b/qapi/machine.json
> > >> @@ -307,6 +307,41 @@
> > >>   ##
> > >>   { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
> > >>
> > >> +##
> > >> +# @TargetMachines:
> > >> +#
> > >> +# One registered system target and the machines that can run on it.
> > >> +#
> > >> +# @arch: the target architecture
> > >> +#
> > >> +# @endianness: the target endianness
> > >> +#
> > >> +# @machines: machine type names, not aliases
> > >> +#
> > >> +# Since: 11.2
> > >> +##
> > >> +{ 'struct': 'TargetMachines',
> > >> +  'data': { 'arch': 'SysEmuTarget',
> > >> +            'endianness': 'EndianMode',
> > >> +            'machines': ['str'] } }
> > >
> > > We already have  'QemuTargetInfo' struct which is used
> > > with 'query-target', that should also be used with the
> > > new 'query-targets' command.
> > >
> > > We need to add the 'endianness' field to QemuTargetInfo.
> >
> > Why do we want to expose endianness, and what endianness to
> > expose? Endianness is a runtime bit state of CPUs. Sometime
> > this bit is hardwired but that is an implementation detail.
> 
> For some targets it's, but for some targets it's not. for example
> 
> mips-softmmu.mak
> mipsel-softmmu.mak
> mips64el-softmmu.mak
> mips64-softmmu.mak
> 
> 
> mips64el-softmmu.mak
> mips64-softmmu.mak
> only differ the endianless

"EndianMode" is a tri-state including 'unspecified' as a value,
so we can cope with both scenarios - the targets where endianness
is runtime switchable in the CPU can use 'unspecified' as the
EndianMode. That behaviour should be documented in the QAPI
docs for QemuTargetInfo

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

