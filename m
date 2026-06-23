Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68929305968
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230695; cv=none; b=kUdjNr+BEOZLPwNMsve4WTAGOzndckvHVoK+MNKopqCcpCsAr78PBsP/PwyGoiUzZipcf9rJP8LyyrnNR9qGo9Uu21msDzVdS3an6QqnYyZLNGi/+cDb+Fsu2ZOPKPQNzrMIrL2ndSfCfceAeUc59kBa+HsDYqUibvkFUga122M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230695; c=relaxed/simple;
	bh=NKYALfrymSfloD9phqouCoon0tF0Fwr7CfmN4KVm1rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjr2pgSlX3xOjCFjN8L00IwR68ajydARca8EgEkUuhZ5tO5bX9zvZxDA2/7RUzK4NE2lKzTCsP+5IJ35KgVeBUj3iMs1zD3wMIRB5Sr8VFejt3TLysI1SjHdzYzTBf98/du2p9x6skUlpKumb8J3ycDPo1MeCbAQh90l02eKLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ukiNsib9; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ukiNsib9"
Date: Tue, 23 Jun 2026 11:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782230690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HUMXCuMO7p6O5rMHTd48qDrDnp9sIV5SbSD9vcVwTcQ=;
	b=ukiNsib9RQNh0POS4icEM61aaTZs1u8fyQ63wd6/eWuktd7EVVXP1VXD26dhcfoz6PkSgq
	+4EbfP050QlmoW5tvJDaMSYCKZoo9f/i3WCdqqDXonkT4osN3LntQa4y/rt5KqEg3kLOae
	f9xu8u9G2yhuyMI/18PP+3Q4mrzpibo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH] checkpatch: add support for Assisted-by
 tag
Message-ID: <b3agpqbu47bnsfcfzskdfgymyag6y6be5danltshzwiimybvnh@r4773lfg6vfj>
References: <20260622164109.26350-1-andrew.jones@linux.dev>
 <CABgObfYzDQN-2OpM7JjoPe32Y=y=FokJEq2oePYbyASUuxy2yw@mail.gmail.com>
 <ev32z6yxkujq3ctb66f6l3e2l5cx2b33ye76mlqvo6jdsydxsk@hwmgkv5rmqym>
 <92a4d803-c545-48e8-ab5c-647bb04f3560@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92a4d803-c545-48e8-ab5c-647bb04f3560@oss.qualcomm.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 23, 2026 at 05:08:07PM +0200, Philippe Mathieu-Daudé wrote:
> On 22/6/26 21:00, Andrew Jones wrote:
> > On Mon, Jun 22, 2026 at 06:43:45PM +0200, Paolo Bonzini wrote:
> > > On Mon, Jun 22, 2026 at 6:41 PM Andrew Jones <andrew.jones@linux.dev> wrote:
> > > > 
> > > > Import Linux commit d1db4118489f ("checkpatch: add support for
> > > > Assisted-by tag").
> > > > 
> > > > (I should have used AI for this, since it'd be fun to include that
> > > > tag on this tag-enabling patch, but sometimes I still do my own
> > > > homework!)
> > > 
> > > Personally, I don't see the point in providing free advertising to AI
> > > companies, so if I had to choose I would do "WARN(...) if ($sign_off
> > > =~ /^Assisted-by:/i)". It's more important to know what AI was used
> > > *for*, than what AI was used period.
> > > 
> > > But I won't complain if people want this patch.
> > 
> > The process is now well established over in Linux kernel land and we
> > encourage kvm-unit-tests contributors to follow Linux processes. The
> > motivation for this patch is because I just queued an ARM patch which
> > used the Linux process and it failed checkpatch. I'd rather checkpatch
> > succeed than to have to tell people to remove/modify the tags they're
> > used to using with the kernel.
> > 
> > We can encourage contributors to also add sentences stating how AI
> > assisted when an AI assistance tag is provided in order to capture
> > the "AI used for what" part.
> 
> I tend to agree with Paolo in that I don't see the value added by
> these tags -- except the free advertising --. Besides what provides
> $AGENT_NAME:$MODEL_VERSION is likely irrelevant without the prompt
> used. And even if we try to reproduce we would get a slightly
> different result :) Then by the time the patch is committed the
> information is almost obsolete.
>

kvm-unit-tests does sit on the boundary of being Linux-like and
QEMU-adjacent. So I can see why the QEMU position[1] might be
considered over the Linux position here. OTOH, I'd rather not
complicate kvm-unit-tests development. I'm also personally not
that against the tags providing free advertising. The tags also
provide stats in the long run which may be used to compute risk
factors and/or evaluate quality of particular LLM designs which
can lead to LLM improvements.

[1] https://patchew.org/QEMU/20260528073412.551117-1-pbonzini@redhat.com/

Thanks,
drew
