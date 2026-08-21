Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40A48EBD0
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318109; cv=none; b=IbdxG0M9zeGk8+rCjs6Hlh/JUaED7Hfr9eeIX5dj64wZJcKBXLev4tgBrttY6wfU6Ntwet7wMyZT3/ZqIe6nx+0qz1k5ToZ7/Dmss5fAsWQr/C8Ndlkg7Xnh0OAZ4tD9OwJZoRt/kPeSverz+6t6UeQuURKmCyg+nEvHhZiyXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318109; c=relaxed/simple;
	bh=ZgEtJfYhvEx3RUMYzu/QeOmFo1mnqj6uqfkRQxaKdyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bobJc3r65rYHWqwqVX89KtVCFQpVbxcpLowiR8zcmHNcl4nQtyagZvZf7nOGk5/3j0xCio/wbrZBR1UL6b25+kXWJ3Jg/VaWJ/lhvX3RSa/vOi+XFITLH2LZIo4gffgxVtQS5ff8cFsavtBVf3is4pxXTyiHQ1jY/a1iYRM0oYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c6dvQg6l; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c6dvQg6l"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfc52ddc55so16600125ad.3
        for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787318092; x=1787922892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xbkxU3KDRFhwwjU3XLpDILLbXwo99XWxcTGCF4UGzgI=;
        b=c6dvQg6lTgr8WfLyCyDDpuDZqgAEBAZWBpp7fCIezykosTX8xFGBy2loYtaNYVMO2N
         afquEy5AbPQBlEDIibICb1Ey/1PMtRvea5T8kUdNfB9foRDFJPln+AFYfRazXR2V9o1Y
         4VIGgVLrfUF2SxWfciCdNr0NRy37DtLHlOJQZhnlC2s0k2k+FZH93vLWnN/Ps4ZtOa3Y
         VvvuMyjYw4I2qY9VE6DHyii96mwk4wVozgJ7sHZ7X+S7xJHqjm3nE1rTLMDE6kITf3K8
         GoUHQfbqES90zkGO1AoCnk65OKx4Bb560zghBv7V/utYLU+uCta1aTJk9aVlk6AELbe4
         cewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787318092; x=1787922892;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbkxU3KDRFhwwjU3XLpDILLbXwo99XWxcTGCF4UGzgI=;
        b=C6nLa05sWbtJTP9vFGsPQevDq/0ZG9A+ueVZKwfaF1ggwtJV5jGxQvCWFyL716OIXv
         GMj3fbpJhAg8jK7PWg/9wRNNUkfGLlBlgDe46MWwtzQuNhLuaLE6+8Lh6CU9439X/QbC
         cn3RKOHcVV0Qjvr45QRaxJJv+tcd6fC5pPGLrNMnRbNGasjBYYh/WarJsAC88cPOScU2
         DVdgC/Zc/ie6p1KPXupvC9NYZV+K/nuA69goBjGO3eynLQ0AZ54hD7KSPZccE2s+RDsn
         Dp/qKPCuAkNlF0sn5xTsCXqoy/of8zXwMgYu4WIsSMuu/g+g/8N8O6uvhqHJBRHc6IjY
         hK5g==
X-Forwarded-Encrypted: i=1; AHgh+RoaPRu37oFfS0uBS223eEvsJLnlQRwOBwnKWWl6x5cgx3gcWcMt86Itn8MKBnIsV8xh9Aw=@vger.kernel.org
X-Gm-Message-State: AFuF++nXPL+3WYH5ejSPwV2DfJRReHrdGoXbRPmC+G8EBElwcPL/eT+g
	EaqTm/1JB/Kacp7fJQuKnYjJZvPorXVuwccE3uNNgQTWzkX4xgCLaQI7YzVEcwG8PU/kTOsFVA0
	RMGJhyg==
X-Received: from plrf23.prod.google.com ([2002:a17:902:ab97:b0:2ca:b907:d842])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c0c:b0:2d3:78c2:1f19
 with SMTP id d9443c01a7336-2d64b0270b8mr122535495ad.9.1787318092128; Fri, 21
 Aug 2026 06:14:52 -0700 (PDT)
Date: Fri, 21 Aug 2026 06:14:51 -0700
In-Reply-To: <8f715ebf5cb0ef70803ca8c6ad462d9de7dfa8be.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
 <5799b5d637f6b540c45874120aa37749a7dfb955.camel@intel.com>
 <aoY2N1mpG-IQIUDm@google.com> <8f715ebf5cb0ef70803ca8c6ad462d9de7dfa8be.camel@intel.com>
Message-ID: <aohPS45Qc7erio4c@google.com>
Subject: Re: [PATCH v4 0/9] KVM: TDX: Enable VM-DoS Prevention Features for TDX
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026, Rick P Edgecombe wrote:
> On Wed, 2026-08-19 at 16:03 -0700, Sean Christopherson wrote:
> > > To me this is not a valid reason. Sashiko is great, but we can't let =
false
> > > positives drive the patches. Given that the series is so big now, I'd=
 think
> > > it would be better to leave 6 and 9 for follow up, so we can focus on=
 the
> > > core thing.
> >=20
> > Hmm, I disagree.=C2=A0 If the consolidation weren't here, I'd absolutel=
y ask for
> > it. This is new feature enabling.=C2=A0 Yeah, it happens to be tagged f=
or stable,
> > but at the end of the day, it's new feature enabling.=C2=A0 And it's st=
andard
> > operation procedure to do cleanups and dedup code as part of new featur=
e
> > enabling.
> >=20
> > If anything patch 6 should be patch 1, but that's a minor detail I can =
sort
> > out when applying (assuming another version isn't required).
>=20
> Ok. But you disagree with dropping the patch?

Dropping the patch.

> Or that avoiding sashiko reports of existing issues is an invalid reason =
to
> change the series?
>=20
> I think it's good to discuss a bit how to handle sashiko scenarios.

Like we do any other code review: use common sense and follow established b=
est
practices.  If a human reviewer pointed out an existing bug, we would analy=
ze
the situation and make a judgment call as to whether it's better to send a
standalone fix or roll a fix into a new version of the series.  If we decid=
ed to
fix the issue separately, and then a human brought up the same pre-existing=
 issue
in a future revision, we would point them at the fix or the previous discus=
sion
(or if it was the same human, (politely?) tell them to go away).

The only differences is that Sashiko is noisier because is doesn't (yet?) r=
emember
what feedback it gave in the past, often doesn't look at the patches later =
in the
series, and doesn't (yet?) respond to emails so telling Sashiko to shut up =
about a
particular pre-existing issue isn't effective.

But to be very explicit: don't include a patch *purely* to suppress Sashiko=
's
rediscovery of existing issues.
