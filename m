Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAF40DFC3
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776125717; cv=pass; b=pjOT29oKUcL3o4XPRNFyQR0jo+kqMjmWkAMZWrO0PEh9+VVB+wQoheLlrhB+OpKv7+NOBKpCBRiKiZ9YOpCA74ymytHIrLcQGCXU6CHwPB9VohJ2f/Zn7x1l9SNii2grX5NbSfuWcTr8nJBitpwsnOv/JiBAvnSVrIXg3NOPnx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776125717; c=relaxed/simple;
	bh=XPFWHpBHIs/Yeh33DMnIHZItF+TjF0eQhp6D+JiK3wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftDMzDJWR+7zFkQAo9QopA2Ff6LoFHB7KpTPor7/leEVqyRh2bGtDXn1G812nab1gzP0Y1XtQtFUZNTM+M4jNFN3fQj9D9OJnrzq/GokD4JhQKpn4R/nqeXwlFXtyvMTzIqlBFLA7qFvLGRIrUO35qk3OOrk56QILVgQpYxoWAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCuWAjv9; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCuWAjv9"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d836552daso3046381cf.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 17:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776125716; cv=none;
        d=google.com; s=arc-20240605;
        b=deZoAFU4QpjRZzwjG4GMjdiGMdBOpWogjkGcGnkRyuX1DRu6tlOsjkcc+S36j41Psf
         EFE2hIcQzGFuAmmcsbusuD66eo7zcRZ07HVXAk2pGnO6WXfL7PaTnMAsIVOQkm+Bx9qp
         /sp4QJXJy5XRKQ0Q+6hm+/W3YeehplNf/2yXqxdhGZxQUwg+rGPfdL03/aznMraYuBGu
         7wflboEQOWtwFqOm+2gYwCqw740RCLsgdodP+w7bUaTz/3Gw3SJXMN9VKuUy2RFArJ8q
         bVw5bAUlF55XUbkcM50YOiBUBbNehkIYA0jsw1UtCJ/VSqo7U/k0Ecr0ipchNpVbzR5K
         F0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XPFWHpBHIs/Yeh33DMnIHZItF+TjF0eQhp6D+JiK3wU=;
        fh=cIZQ5CJb4EmdRPlbDsHVCmT7RHFOOYV5SXZ2A7zg2FI=;
        b=Lc7mE7mqVAPNda4hyvuneCKkQD1N9gjw4gcgDUCNSOhBziObqXHL3dt5JtFuLQ4vYe
         WR5iiP9XWOYvrWwr7SD69Z5glMrPm32dylbOu86ddzFHTomD4xOC7Wn3oyA+7Eyzonl3
         ovfH5IEoPTRE3la2ixecuHczyU4kNG1TnHlBTvth7pbLj39o9+xmLF48P917A1iBhzgp
         7MdwL2GnUUjLz/9YLf2PLK8NAN3wrI+WLHEa2mgoO/BmCDLF4yspolcHawiMfUBUrHJD
         JDjXrlfDCZJ5rPnACsS+otwMYt1ADO0Wj6kQB6YntBJKZQjk3Ui9WQxMNNg1x9YTJWgQ
         t/Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776125716; x=1776730516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPFWHpBHIs/Yeh33DMnIHZItF+TjF0eQhp6D+JiK3wU=;
        b=jCuWAjv9LY8igzXy1bctiEwoyPg9sRjpjjLYA1tryUi+o+PUCUKbufw/SCMz9fRfih
         HIDhlkbOkTPsUigvjZyBVL3BeILPlXnLJ4u0Sza501/kPAh6mamU8GFnSGopfHSDc5ge
         gbCqpuizlMR2wVfUU56qKxKgBUfVBAMhTmSYqxqEjwhuMSWXaq/DSHTUvOJ7aKRhzUgp
         R+yiqODDWyhDSZkGuIK0MYdBcZmQFNE83opqWfcEPzzM+IZ0NSbqRQ7BwQWMVVMpuIfJ
         e8i3R6A4jcsfoZZC9QAOJshzASntbhGZ/pUSf+CqZt7I/rR3f149MQO9EoywoaFcN+Rv
         p6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776125716; x=1776730516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XPFWHpBHIs/Yeh33DMnIHZItF+TjF0eQhp6D+JiK3wU=;
        b=Hywuud8aGMMRJX57b94chAu3/SdY+XNJSbgh0/1UTQUB/4c/jRONrbuMr9w5+f/v4N
         +N1lfIn/tAYgVmgl6HNxnh7o6xcZceHXv4e4uuJbwYJlkyvzHw+tyXqWaocyTANz0ird
         D/Vf9L1BCX3JLTIelZ67QAixdRl5a73Zym66GskGxeEJjs6NPgjbye+owNHErykBkfaE
         zGeE41PPthkDpGhuPHPsXlh1213LQPlp2u3kLPMjv8qZNbtf37b7Ycr71527hH2zSt4L
         RpbNEpQeU36L3Ngcy8gXMsVimN5kUypO/nNzui8qniCMaWJoPZ3houqMR1yfhwBvlNC6
         Af3A==
X-Forwarded-Encrypted: i=1; AFNElJ+lXar6qRsdVVCPbCLBf+JEYSTSOitC+9vau64IQPBdNGqiuE1WfLq/Z67M3zk43pVo9jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDAOrr29iYFZ201qSu1ip87CCrMcQ50Blu1UxkNHs64Pa3RvB
	KeKzhopsC9c0v7iTF3k7BrRQ/JG+IZC5q7BokUeFFKpummvQa3ZUBfz6EHzbNLM2FxUaTXREGmd
	/7x1MqbJcv1dWbpslgouuPtfyaVKmqNc53qOV4q4=
X-Gm-Gg: AeBDiev3/liifmHUYU59SrzQo7dJvdE3B6InL36i+0ZDM6+ilnPvrQ2Y4MjNZZyajVo
	9k8mh0n5cmvJh1MX8iGKNs4NvXQbSG8oxZDo5skOqfQbVNC+SC0GVawyu/EOoaDSwA7QL8RTCMx
	i4AL6FhVhmsk/Ct3YVgyDBpYE8BWuTyG+leasrcj4kNCuqZ5rXAWdtkvdjmX9rqA0oVvUM7Mn1h
	nAqyc4Ev/nD/Av2riZ/FBSMGWBlbbXsq9461HWa48q/CKXTl/A6pQpPSANOVRKX2OAFgkd2jdp2
	FSNoBb+qjVtm6eElqbdbWG0SKVt0jDFm8CvhoY9TRt7/sN5P+/RoPcyw
X-Received: by 2002:a05:622a:a954:20b0:4ed:8103:8c37 with SMTP id
 d75a77b69052e-50dc269888cmr13008211cf.12.1776125715221; Mon, 13 Apr 2026
 17:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409015139.2800185-1-jrhilke@google.com> <20260409015139.2800185-3-jrhilke@google.com>
 <adl_nGI5IEc815fb@google.com> <ad0GqAsFpAgA6g5u@google.com>
In-Reply-To: <ad0GqAsFpAgA6g5u@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Mon, 13 Apr 2026 17:15:03 -0700
X-Gm-Features: AQROBzAZFcp3Gd9bRQpR_JhnRj1khcytCMQpFGZp_la6V3_D4lz31tob6oTycsc
Message-ID: <CAAdrzjtm+fRc-cmWNtg7+qyu2gWmRS9Zdt-M18J-t6rCvvTBTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfio: selftests: Automate setting up devices for testing
To: Sean Christopherson <seanjc@google.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Vipin Sharma <vipinsh@google.com>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 8:07=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Apr 10, 2026, David Matlack wrote:
> > On 2026-04-09 01:51 AM, Josh Hilke wrote:
> > > Update the VFIO selftest setup script to find a device that has a VFI=
O selftest
> > > driver on the system, and set it up (i.e unbind that device from its =
driver, and
> > > then bind that device to VFIO).
> >
> > I am leaning toward putting this behind an explicit flag (maybe -p for
> > pick_device or -a for automatic device setup?) that way we are sure the
> > user is ok with letting the script start messing with devices on their
> > system.
>
> In the spirit of "do one thing and do it well", I would rather put "disco=
very" in
> a separate script entirely, and then tweak setup.sh as necessary to allow=
 piping
> in a BDF from the discovery script.
>
> The mechanics of configuring a device for VFIO (setup.sh) are largely gen=
eric,
> i.e. not unique to the selftests, whereas print_supported_devices() is ve=
ry much
> tightly coupled to selftests.
>
> And with respect to making sure the user actually wants the script to mes=
s with
> their system, the permissions required for each script can and should be =
different.
> `lspci`, and discovery in general, typically doesn't require root, wherea=
s most
> systems will be configured to have things like "sriov_numvfs" writable on=
ly from
> root.

I'll put device discovery in a separate script for v3.

Regarding David's feedback, I'll also use -p for automatic device
setup, and make the phrasing for "supported devices" more precise.
