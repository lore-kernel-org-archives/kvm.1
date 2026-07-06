Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C22C39183A
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352022; cv=none; b=ZeoqE1el/DP4WLg+5y+n9vJxeyjQ2fxI1sBDODIZX7Olp+SNhOD9qCKCMg8N0GZ3uqRbHbYUiOvR8mjOcNMgi0q0Ywx/n3XsOsvdvKil9supuuKpaZlJ86T0YMmOq9RRhJU+05KCcakchwrdxg/jSi7sufKj1LzDcknANibAHP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352022; c=relaxed/simple;
	bh=ZTp1xbTuBAR0r/TdjbIY7CySNYQrFRc+2IgxMZd/Ov8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxavuKHuEZFcftwA7MIOPmqRP3FeIF4naA5c3MXwiv8Z3K+W29It+wH10fJXOJkurzQH5ed9cQszteXFrS51615cW/Fo6P2H5oFPpHZDNIpvop5qEWfwBU/YWaoDwglTi0Gtx2aBxz8KxdQ2fJuEgGpFS9dEVAo5ezuFf2Uqu/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V9liH9NZ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V9liH9NZ"
Date: Mon, 6 Jul 2026 17:33:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783352018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4GLydLF8RMNvs8CO10hYnQDAX//w5mAKu9BAhuUeQY=;
	b=V9liH9NZxSHz9q0QSiN8ipJUjt9G3QOZD/q8dWwEkRcun9NwZR3TbXVuVcsXYcbMA29Uu7
	1f+c0ezKaq/QzmRmgSSWmlaN1wzxHBcAbXYC7xlYXgk2aa/6qjNMIttWFf52yyZZnH65xa
	NiI11f2jsNNep9GYelVjWE7xafZ0y/w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Huth <thuth@redhat.com>, 
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH] checkpatch: add support for Assisted-by
 tag
Message-ID: <5xi4c2j4r3h4f3ak2yz7mslzuojk4l63zmegshn5f26ov2pzeo@3cj3xyy3dxhg>
References: <20260622164109.26350-1-andrew.jones@linux.dev>
 <CABgObfYzDQN-2OpM7JjoPe32Y=y=FokJEq2oePYbyASUuxy2yw@mail.gmail.com>
 <ev32z6yxkujq3ctb66f6l3e2l5cx2b33ye76mlqvo6jdsydxsk@hwmgkv5rmqym>
 <92a4d803-c545-48e8-ab5c-647bb04f3560@oss.qualcomm.com>
 <b3agpqbu47bnsfcfzskdfgymyag6y6be5danltshzwiimybvnh@r4773lfg6vfj>
 <21cd2f80-64a2-48ca-9821-7a233470af77@redhat.com>
 <5ts6z45hsrkia3gh34cjlfglbp2fwcnwutvzdi236pcmubbk5o@jbmv5ej4gqmm>
 <akV1bbcTttyS-FxU@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akV1bbcTttyS-FxU@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 01, 2026 at 01:15:41PM -0700, Sean Christopherson wrote:
> On Fri, Jun 26, 2026, Andrew Jones wrote:
> > On Tue, Jun 23, 2026 at 09:57:22PM +0200, Thomas Huth wrote:
> > > On 23/06/2026 18.04, Andrew Jones wrote:
> > > > On Tue, Jun 23, 2026 at 05:08:07PM +0200, Philippe Mathieu-Daudé wrote:
> > > > > On 22/6/26 21:00, Andrew Jones wrote:
> > > > > > On Mon, Jun 22, 2026 at 06:43:45PM +0200, Paolo Bonzini wrote:
> > > > > > > On Mon, Jun 22, 2026 at 6:41 PM Andrew Jones <andrew.jones@linux.dev> wrote:
> > > > > > > > 
> > > > > > > > Import Linux commit d1db4118489f ("checkpatch: add support for
> > > > > > > > Assisted-by tag").
> > > > > > > > 
> > > > > > > > (I should have used AI for this, since it'd be fun to include that
> > > > > > > > tag on this tag-enabling patch, but sometimes I still do my own
> > > > > > > > homework!)
> > > > > > > 
> > > > > > > Personally, I don't see the point in providing free advertising to AI
> > > > > > > companies, so if I had to choose I would do "WARN(...) if ($sign_off
> > > > > > > =~ /^Assisted-by:/i)". It's more important to know what AI was used
> > > > > > > *for*, than what AI was used period.
> > > > > > > 
> > > > > > > But I won't complain if people want this patch.
> > > > > > 
> > > > > > The process is now well established over in Linux kernel land and we
> > > > > > encourage kvm-unit-tests contributors to follow Linux processes. The
> > > > > > motivation for this patch is because I just queued an ARM patch which
> > > > > > used the Linux process and it failed checkpatch. I'd rather checkpatch
> > > > > > succeed than to have to tell people to remove/modify the tags they're
> > > > > > used to using with the kernel.
> > > > > > 
> > > > > > We can encourage contributors to also add sentences stating how AI
> > > > > > assisted when an AI assistance tag is provided in order to capture
> > > > > > the "AI used for what" part.
> > > > > 
> > > > > I tend to agree with Paolo in that I don't see the value added by
> > > > > these tags -- except the free advertising --. Besides what provides
> > > > > $AGENT_NAME:$MODEL_VERSION is likely irrelevant without the prompt
> > > > > used. And even if we try to reproduce we would get a slightly
> > > > > different result :) Then by the time the patch is committed the
> > > > > information is almost obsolete.
> 
> +1
> 
> > > > kvm-unit-tests does sit on the boundary of being Linux-like and
> > > > QEMU-adjacent. So I can see why the QEMU position[1] might be
> > > > considered over the Linux position here. OTOH, I'd rather not
> > > > complicate kvm-unit-tests development. I'm also personally not
> > > > that against the tags providing free advertising. The tags also
> > > > provide stats in the long run which may be used to compute risk
> > > > factors and/or evaluate quality of particular LLM designs which
> > > > can lead to LLM improvements.
> > > FWIW, I think we should follow the kernel here. k-u-t has always used the
> > > coding style, header files, scripts, etc. from the kernel, so IMHO we should
> > > not diverge here.
> > > And I agree with Andrew that the tags could be useful in the long run, e.g.
> > > if there is ever a problem with a certain AI model, it's easier for us to
> > > find out which commits we might want to have another closer look at.
> > >
> > 
> > I pushed the commit.
> 
> Heh, maybe jumped the gun a bit?  FWIW, I agree with Paolo and others, specifying
> the exact name+model is little more than advertising.
> 
> https://lore.kernel.org/all/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org

Thanks for the link. I'll catch up on the thread and track it. If Linux
decides to go another direction then I'm happy to follow it with
corresponding checkpatch patches.

Thanks,
drew
