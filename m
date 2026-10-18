Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DF639E9D6
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792367621; cv=pass; b=iwz1ZnHNrLkZjk4O02PFgFAgwxAPOw77InCVhv90/I8jkseHM414yA+KjM4sRoFA9l0Bk0dWPYDRGZTNXZnZhAolTUpCc3/E2TUl0IPjzp75Muhhl/tRwt9tH1YPsN+UratbVz9F4YerkOBTaAO/AWz/XoYW1X7Aon39uIdXajw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792367621; c=relaxed/simple;
	bh=ikcStFONhfs5hokFZ9u0J5DwZzPFduPyuFeHVqSmKog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pful3PwyDJZ67DSsFUNXjDR3auRM52vkqHc58eQe3UdypUYksg3c7Z2t+kbUWj/ZZ23A709GvMYkbNDzz2Dd3EDTOVCxG80pRIyQ11sreuoF2fkUvugl3wm4IqVQ3fd8BQezLMdsnmXKtSXkqTbthU2NSNokSAe7eShQmhNsl/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZDgA8XP; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZDgA8XP"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so881283b3a.0
        for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 16:53:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792367620; cv=none;
        d=google.com; s=arc-20260327;
        b=KVxkz0hqGd7Wj7cJa13aQMjFseTA9OB3uJSCCOLHeBxWz3EuEhIdhp/+4bpAp9yyoZ
         ASjhjtWZ7Ik7AMa9ddza7E9g7NLDeumgrsryRmaTt8BJD+FbuNqnlFYhr4U18wg95/zL
         E879GqduLa0YoIvMND3bpI3c2LMQ9XbYjdwypAp9NBaNFfmp60bqM5Eje3WcWox9VI/t
         x7LNzwbk1eKVDi88QLz9Cu/DcmarHxAIF62kIN+gEOqvbw3ptiXfuxkvTttZ5/7DfsxV
         7GiZiIJ6FIO96noodOrpfiURqt6bPiwcDl9FEjgsz1EVfz28aiVND9ZJ07e49cX/G0tI
         QLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ikcStFONhfs5hokFZ9u0J5DwZzPFduPyuFeHVqSmKog=;
        fh=+dgUdqa1VWZ4fOG4X19fhqh0ETplOI1uEg5IaR+0kcQ=;
        b=Pp/RVLhA6E3FYWm44P3p781Geobtag9ABGwDJ4H27nqyCydsKF4PvTa/QNAZyUzxmL
         d69fCRHCgTQDPyJ666muTLJGzeEJgkO+BZhDnULDfsAUOR6cNkCDVrIvOkvPWcuZUthz
         WHQiGYuACY7xL9aUbDTTK7eHwLcLOomQZVqU8W2Esi93wPdcCRfoBL7V3wSfG/pvuBp4
         VdbD7Fk/Z2DSfOJseQEu2+e7B3odWpbQOTOKDEFN+Ai9Q6ytvGpWWrCJf5cvSGnH95WA
         U5cZBfTrm+Z9llClEaYJFDsD2XqwHD3gFGHhxNnXUU26/MsnnmjwkjU4l59lOttiLfRb
         nPlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792367620; x=1792972420; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikcStFONhfs5hokFZ9u0J5DwZzPFduPyuFeHVqSmKog=;
        b=IZDgA8XPxtSh5SmNztAw9myhG61BrYOUczUp3QyZ3U4M+b/31OnoF0hdpSfL5a9W5k
         SpPaQA4NCvjY+GWzDVkjQV69DzntUDS4Ha/r+7fZn86vIwu+VmFE45/Ck7dzcO+W0JVn
         x/My9Pz7dv+WqOzz/StA6xrhvATJoLdO01IcgioEpSnVnJWn8Ogdya6qJUpGNhte2N+Q
         GBJYQQYzLlELK87jq34hmdd7p69WK4c2g3UfEFkmE/G5EmOvx3d/9U2LaVcqjo1YUb9j
         XX4j1xByvqrIP//XQuoJ6Uby3mYfgTjlMF2qCNt9T/2+eRhh6IqYmuOcrMis2cTt/Bhr
         8w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792367620; x=1792972420;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ikcStFONhfs5hokFZ9u0J5DwZzPFduPyuFeHVqSmKog=;
        b=tpOliwAnEfLVVSo25c+waearizkYZTv83ywSoBtO35gK3hVthWxGneFKDqU3PjOKyY
         LCAc+NevcSscmnZ2X12AJX6wDaiTHo4C3zYcxaz7YYjIVhcV93D6slA71O35YDNJ84l+
         FE2/Z3PxoPgyTjkCwleDsGKJJJka/+gxM+TybDkfO7uR4ZuRkA6lY5TEONCtmamtZXHm
         ueiA3C3LRsIkeZuFEEbPOxCkDyKZDysrA/Lq57WhWmDNKSbvrXEG8mF2M64man0dv0lf
         +jprbiHfRink5zvTnByuMyAL28rbZ4Wom2IZMczzXh5msIaAW8q8W0NOEvduCK3oEVt0
         Sabg==
X-Forwarded-Encrypted: i=1; AKwUvBy3XoQKoMtIDZOFrjf8WmY3PDeKCElyCohkiiOuJI4aawPPeeLP0BHfFw4Rc1cRRqEuRB4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAkyamZsgNAk5HHr8oHOFO5t+89CiQUT6vfTyPUkt+1vo16C0r
	GP0OPfxaR7NW1dteE7O9bUaeBnqjA1JltxL47VD5BRXu7eFe0jJQfytgejzUhdMP2tY9eWJXpx4
	mmtuvUSmZrebda6LzBTNTTEqMsVECXag=
X-Gm-Gg: AYBFou3Tfqls4hVrFL0q6IrQ8csMyRye5CNWuQuuunZcql/bFBL/6xE3AwUA5c3BBSi
	NhW8Ng4MMcAH8bLCtab7xGXcRKtDwaBMw2ap6zYPl7OEsdA+HPKJhDRgZVGWyDDbitxoT/7mukJ
	G1z9or731W8cwHzwyTdBj2WzRVJlkMXS7fzeOgb9sbUKWZDUonyTSwh1luiApdW2jbzEZuzWnBB
	KdNisZp1wpZitlP4tMADfGP8BhwaNp30pFm7AUELqKraclmgZvtsTEAzumJt2dXXWongge+EAS+
	U099PfZEhmsXN8take9L7CTs2Juuz/wDCFnl6nDSDZa8NYYJxZ+wqUdz2ySmBSe+CYeLukSN+4N
	tR4094M33SxGWRsiXrQ==
X-Received: by 2002:a05:6a00:1806:b0:892:597f:37d8 with SMTP id
 d2e1a72fcca58-8a04ba18454mr4779902b3a.15.1792367619719; Sun, 18 Oct 2026
 16:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015145053.3664509-1-jiri@resnulli.us> <20261016234354.GA664420@nvidia.com>
 <CANwfdvXFLJpC4Bc1PwRoUUP20fu2K8b+FHZ1JLLFXAikC-cBaw@mail.gmail.com>
 <20261017203407.GM13920@nvidia.com> <atPgqROZZxnihYfC@kernel.org> <20261017231007.GP13920@nvidia.com>
In-Reply-To: <20261017231007.GP13920@nvidia.com>
From: Dionna Glaze <drdeeglaze@gmail.com>
Date: Sun, 18 Oct 2026 16:53:28 -0700
X-Gm-Features: AclHuK9GuI1sFp98b1K0khmGUju9GL5ycOOU8Mt4euoyLz8UHj6wifrtGgAMHK0
Message-ID: <CANwfdvVJRv6++MJ8OCUnHSR_5nVD8Yv6eTmYxxqfzxEk0sNfpA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/20] attestation: Add a common subsystem and TDX support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Jiri Pirko <jiri@resnulli.us>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, david.quigley@intel.com, 
	lukas@wunner.de, ksinyuk@kernel.org, rodrigo.vivi@intel.com, 
	cedric.xing@intel.com, sameo@meta.com, James.Bottomley@hansenpartnership.com, 
	aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, pgonda@google.com, 
	jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Content-Type: text/plain; charset="UTF-8"

> On Sat, Oct 17, 2026 at 11:55:05PM +0300, Jarkko Sakkinen wrote:
> > I wish I had a better picture what is going on.

Me too. I've spent my Sunday with Claude trying to build some
understanding of all this stuff, and put together a static site about
this series.

https://deeglaze.github.io/scratch/ctlv-site/index.html

It includes a review that I've personally walked through to ensure it
wasn't off base, but of course we're all fallible here.
I haven't decided to email the review comments to the list yet because
it's pretty thorough for something posted here as an RFC.

I think something to be really careful about with this series is how
it's managing kernel memory.

* https://deeglaze.github.io/scratch/ctlv-site/review-02.html#reply-7
* https://deeglaze.github.io/scratch/ctlv-site/review-04.html#reply-27
* https://deeglaze.github.io/scratch/ctlv-site/review-07.html#reply-7
* https://deeglaze.github.io/scratch/ctlv-site/review-11.html#reply-8
* https://deeglaze.github.io/scratch/ctlv-site/review-16.html#reply-30
* https://deeglaze.github.io/scratch/ctlv-site/review-18.html#reply-19

Something I and some others dislike about IMA is the unbounded log. I
don't know how many stalled proposals there have been so far to permit
some model of "snapshot/endorse and truncate" to allow a remote
attestation verification service to store existing logs in object
storage, measure the reference and/or trusted signature that the log
was "good", and then drop everything in the log prior to the
pointer/endorsement event, but we have a chance to start with the
right model here. I liked Tushar's talk in 2024
https://www.youtube.com/watch?v=5cXDrIx8Qgo
IMA carries its log through kexec and this log doesn't, which is a
hazard to later attestations that don't have some other out of band
protocol to associate its boot instance with some off-box cache of the
rest of the log.

>
> Currently we don't have an intention to flow TPM command packets
> through this. Anything would be a high level operation like 'extend'
>

If you're not intercepting all extends through other interfaces to the
registers (e.g., /dev/tpmrm0), then it needs to be clearer in the
documentation that users not using the interface will break users of
the interface when they both target overlapping sets of registers.
