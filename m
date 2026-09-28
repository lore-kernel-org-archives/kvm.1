Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309184AA03F
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595413; cv=none; b=e4PmbsewvaZmZBFMVfiDxiywR4ET3Xt67H22YyUvTheXboHE58CenFtVPvpYqcxPZK31XSsYO+slMqIf4fim3gNCgU+hdCnGfhzvN7VaeNmOsOHg85Mm11NE9GOMrC9V1Qoe35GN9+j4sxFRuow1oTxKXv3D9jDqs3S8cL/ITuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595413; c=relaxed/simple;
	bh=xQhIqeV99IWwRvLvzhbah0Y01Qq11k9urTIDpVaMgJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpraMJZ27R4kueSKdmGv7xf+xV/eYodXrLm6xWDdH841vdwImL9aNvqDWY/JTtdBHA5djkkUUDq9bNLltUcvwJBPKGoGi6TuUveeL5xznqNMgu2pgBK5akRgSLis0GuQ8fpPt/HzJJLgXJ9F+MEEvdqcnvUpydD9AMsO//YisQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MN2k/F2D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MN2k/F2D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790595411;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6LKvoo/eq7pgYjH3VfteCqMoe3iHHewt1H6hLDQrfI=;
	b=MN2k/F2D0fUuaDmdjSd6Po5lXquVZAGDYGV8D6yUsrdR9sdIKVkSn9rMkElAg//9vKPWtq
	KwE4BqLXaL6EyVaeIkytWHSTLyOPBdaFlzsqTLUfuLrbMU+shzpAruSXuPtmmIKKufWqme
	006Z5Vw324ff3iKmjm7nXK874tXCQRc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-9Zxv-z9sO52wUk6FsG6iDA-1; Mon,
 28 Sep 2026 07:36:48 -0400
X-MC-Unique: 9Zxv-z9sO52wUk6FsG6iDA-1
X-Mimecast-MFC-AGG-ID: 9Zxv-z9sO52wUk6FsG6iDA_1790595406
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E827B19541AC;
	Mon, 28 Sep 2026 11:36:45 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B49F1956087;
	Mon, 28 Sep 2026 11:36:42 +0000 (UTC)
Date: Mon, 28 Sep 2026 12:36:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
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
Message-ID: <arpRR7cH6nBN5FwD@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com>
 <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
 <CAE2XoE9qsZZ+AnfGQ797SQj5yXP8SDOZyxYoKP=oh57UPFqq0Q@mail.gmail.com>
 <arpH_2anGV-JU12e@redhat.com>
 <4da49cb4-6044-418e-b003-81c4ec6d6ed6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4da49cb4-6044-418e-b003-81c4ec6d6ed6@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Sep 28, 2026 at 01:29:26PM +0200, Philippe Mathieu-Daudé wrote:
> On 28/9/26 12:57, Daniel P. BerrangÃ© wrote:
> > On Mon, Sep 28, 2026 at 06:51:41PM +0800, Yonggang Luo wrote:
> > > On Mon, Sep 28, 2026 at 6:39 PM Philippe Mathieu-Daudé <
> > > philmd@oss.qualcomm.com> wrote:
> > > > 
> > > > On 28/9/26 12:13, Daniel P. BerrangÃ© wrote:
> > > > > On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
> > > > > > query-targets lists each linked target, including none, with its
> > > > > > arch, endianness, and the machines that target accepts.
> > > > > > 
> > > > > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > > > > > ---
> > > > > >    hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
> > > > > >    qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++++
> > > > > >    2 files changed, 65 insertions(+)
> > > > > 
> > > > > 
> > > > > > diff --git a/qapi/machine.json b/qapi/machine.json
> > > > > > index 6aaa2af709a..d8cdea6203e 100644
> > > > > > --- a/qapi/machine.json
> > > > > > +++ b/qapi/machine.json
> > > > > > @@ -307,6 +307,41 @@
> > > > > >    ##
> > > > > >    { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
> > > > > > 
> > > > > > +##
> > > > > > +# @TargetMachines:
> > > > > > +#
> > > > > > +# One registered system target and the machines that can run on it.
> > > > > > +#
> > > > > > +# @arch: the target architecture
> > > > > > +#
> > > > > > +# @endianness: the target endianness
> > > > > > +#
> > > > > > +# @machines: machine type names, not aliases
> > > > > > +#
> > > > > > +# Since: 11.2
> > > > > > +##
> > > > > > +{ 'struct': 'TargetMachines',
> > > > > > +  'data': { 'arch': 'SysEmuTarget',
> > > > > > +            'endianness': 'EndianMode',
> > > > > > +            'machines': ['str'] } }
> > > > > 
> > > > > We already have  'QemuTargetInfo' struct which is used
> > > > > with 'query-target', that should also be used with the
> > > > > new 'query-targets' command.
> > > > > 
> > > > > We need to add the 'endianness' field to QemuTargetInfo.
> > > > 
> > > > Why do we want to expose endianness, and what endianness to
> > > > expose? Endianness is a runtime bit state of CPUs. Sometime
> > > > this bit is hardwired but that is an implementation detail.
> > > 
> > > For some targets it's, but for some targets it's not. for example
> > > 
> > > mips-softmmu.mak
> > > mipsel-softmmu.mak
> > > mips64el-softmmu.mak
> > > mips64-softmmu.mak
> > > 
> > > 
> > > mips64el-softmmu.mak
> > > mips64-softmmu.mak
> > > only differ the endianless
> > 
> > "EndianMode" is a tri-state including 'unspecified' as a value,
> > so we can cope with both scenarios - the targets where endianness
> > is runtime switchable in the CPU can use 'unspecified' as the
> > EndianMode. That behaviour should be documented in the QAPI
> > docs for QemuTargetInfo
> 
> OK but still I don't understand the usefulness of exposing that
> at the machine level, since this is a CPU property.

True, and exposing this does not look like a pre-requisite for
having a single binary. It will be better if we can focus on
just what is neccessary to get the basics working initially.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

