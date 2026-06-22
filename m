Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17932283FDD
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154838; cv=none; b=o1DfFuOd6GrLhBjRkluh636PCtI5o0QVj4FaGkx/JT6G9c285rYsseG/PaqKbU5r4V2L89EzL+XCpVayjkguoD94DCoeYbg2R1kpLbLjrTwTCPQEaoCWossp9SdxKP5Vj9N4F6T/T33AWIVd9cUp/Ewrq86ZUikdsB1m0/u02kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154838; c=relaxed/simple;
	bh=w5JJ31tyMwi4GxSQqN5lZltgsTXtqszu8jcmbUzhhIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePRGRdWWIvb2Vn8MicffhcomLNHr2CdHegbdGf5EYCDzkOHwm2xo4Z+iReQAcKWOPb0TPrUP2gXrQffMW1Izlkg59Oqc4DAO8IJv2jZc/4tEnHbT5o8/bOkPob7CtYOw/Kl8Tx5V9jEIxRy8FHEKMxl7LlWr3gasxIpocUn6sG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KgP/5tqF; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KgP/5tqF"
Date: Mon, 22 Jun 2026 14:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782154835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScuQLW+KiJFMDI194GLk7yKbACsBZDHcS03XkYLHrO4=;
	b=KgP/5tqFrveMqyKfe2sp5L9p2SzdGcFIyY13bhJJt/YwnUmIYFQ+Q05uw4X2lE4pKr6SEq
	9Xi0XDtGZ8PMahG6dOIc+sLEjHbHwZKvF+EXZozoTlrtPTNJTUQJZKE0vJ3eRF7YlBLkFB
	djJT4PQbbXWhTQ/eYsej5nIoIgcK/fE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH] checkpatch: add support for Assisted-by
 tag
Message-ID: <ev32z6yxkujq3ctb66f6l3e2l5cx2b33ye76mlqvo6jdsydxsk@hwmgkv5rmqym>
References: <20260622164109.26350-1-andrew.jones@linux.dev>
 <CABgObfYzDQN-2OpM7JjoPe32Y=y=FokJEq2oePYbyASUuxy2yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfYzDQN-2OpM7JjoPe32Y=y=FokJEq2oePYbyASUuxy2yw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 22, 2026 at 06:43:45PM +0200, Paolo Bonzini wrote:
> On Mon, Jun 22, 2026 at 6:41 PM Andrew Jones <andrew.jones@linux.dev> wrote:
> >
> > Import Linux commit d1db4118489f ("checkpatch: add support for
> > Assisted-by tag").
> >
> > (I should have used AI for this, since it'd be fun to include that
> > tag on this tag-enabling patch, but sometimes I still do my own
> > homework!)
> 
> Personally, I don't see the point in providing free advertising to AI
> companies, so if I had to choose I would do "WARN(...) if ($sign_off
> =~ /^Assisted-by:/i)". It's more important to know what AI was used
> *for*, than what AI was used period.
> 
> But I won't complain if people want this patch.

The process is now well established over in Linux kernel land and we
encourage kvm-unit-tests contributors to follow Linux processes. The
motivation for this patch is because I just queued an ARM patch which
used the Linux process and it failed checkpatch. I'd rather checkpatch
succeed than to have to tell people to remove/modify the tags they're
used to using with the kernel.

We can encourage contributors to also add sentences stating how AI
assisted when an AI assistance tag is provided in order to capture
the "AI used for what" part.

Thanks,
drew
