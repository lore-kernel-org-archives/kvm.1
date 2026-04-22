Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3216D231832
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864893; cv=none; b=jUckZJDewE3lc5kxixQ0cV6fdeyxshhm6iI421iEaYCsSvVZiPbE2Oi4RJInTwC2Z09OZpmAlcPgOyILRsIJdmoBfBrAPjBONa93BE/ItO2IReavuxYHTzfsd4+Fs02ssUTPnTQpv33dIr6Hn33u5ywO7d+mGJhn42sByFPi/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864893; c=relaxed/simple;
	bh=f+vdoNSBhIAXR8eGNWz6aRIzITHhDbGMlJc2mTeG8ag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FCDfcJWdTycK2FrKWeCyROWnKdTeFg3gmg85cM0+vRgHagBUpkgsNBKJLlfTDPn4qoXmwToIpTI18wk7cvUG7CvN3ytEkbYZl7r7MCPup+rRjqIa0xY8fbdgmmjpeqdLtEba5nXmxl6RJm6QwbbDSvdfZSko08akF4NlwpFdOVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHr6puBz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHr6puBz"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35da97f6a6dso5276993a91.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776864891; x=1777469691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX4qgBVFsRHr7bFnkx4qEkgfjySokwiSEEczuUYFOBg=;
        b=rHr6puBzSA221Nq+FTNL32HNhzSaZmqOzmXRadK0wT/NLMlC7YQONpjaAVVdloO8AC
         SOFy9uW/bqReYU/FtNbClkzleaGx/nW3rUCgwwS01KCY6uO9YX+B9BfC5COxGCBo0Tld
         MKHwsC9ByUkhqoa7NXPvFofBEuRh6UxMMmwGCOv4a09C67Gjt6uSB6XkM23NZRpkjn7Y
         nRXthfrrthb0ARDBzh3O3bWWo58S59uTF8YN2l4siYTifpkHvBJxxmyt7VtgCPNyyDN5
         KvgIeSzyn5q5NPj/u8TAOpu8e96tYtth69coF6ewrwIaYudzrAM7lNerRFxX4RauIucr
         iUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864891; x=1777469691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX4qgBVFsRHr7bFnkx4qEkgfjySokwiSEEczuUYFOBg=;
        b=okxO5VwFFyIzONgskWZTD9a5Yi3Sq4BiuPavpZuxjdBUALgl9ngVPeKJwE7EmCwkhA
         j12ZT4Tol0TsbIkRWC8h/msMiyzqRrLpeg1diskvPSPHKKOK/Zfk6vNxJjqbLAQiVK/b
         1kSFK9i9aukjKq3RSwFChyQkoWJfX+M6WTIj1TFPd/dm1NP4RZUcWiHMUqCrnERqIQNB
         UmyUdB5G1txch7hqjkg7oGyojSH0HQqNAarcpiZ/+2CFZf2yaStS8cMVjw/3/HdUkRIy
         XQzNoKApEtGEplQ71eZzfwrVcyxREjM66nlrwR+eTpsUcZH49oqDld5GIuPe476ZXxFr
         M5ZA==
X-Gm-Message-State: AOJu0Yy2n941sVh/Qo4dlX2YdSNnrZZEBM13GJGwZP6ZTBMmUpSUy5rE
	bLAQnvuNhXKyKnl3mz+J8+HhFnVkquko/RKijbdMNmP/lSpbVGnQ+ngbovJUCfixf2ddKHz5f//
	PXTHVdw==
X-Received: from pgdc22.prod.google.com ([2002:a05:6a02:5116:b0:c76:5cd1:8bf6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3c89:b0:3a2:7ef4:81ed
 with SMTP id adf61e73a8af0-3a27ef485fbmr15781187637.49.1776864891195; Wed, 22
 Apr 2026 06:34:51 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:34:49 +0000
In-Reply-To: <CH3PR11MB843450CBD154D42B31D15E93832D2@CH3PR11MB8434.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
 <20260422124536.53756-1-robert.nowicki@intel.com> <aejJup_I4wM0Rb93@google.com>
 <CH3PR11MB843450CBD154D42B31D15E93832D2@CH3PR11MB8434.namprd11.prod.outlook.com>
Message-ID: <aejOedCLuGvmV9lM@google.com>
Subject: Re: [PATCH] x86/tdx, KVM: fix HKID leak when kexec is initiated with
 active TDs
From: Sean Christopherson <seanjc@google.com>
To: "Nowicki, Robert" <robert.nowicki@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, seanjc@google.com, 
	vishal.l.verma@intel.com, pbonzini@redhat.com, robert.nowicki@intel.com, 
	Igor.Swierszcz@intel.com
Content-Type: text/plain; charset="us-ascii"

Restoring the Cc (especially the lists), as this is generally useful information
for newcomers (e.g. for other people reading along that might be new to upstream).

On Wed, Apr 22, 2026, Nowicki, Robert wrote:
> Hi Sean,
> Thank you for your reply,

Please don't top post.  https://people.kernel.org/tglx/notes-about-netiquette has
a lot of useful information for dealing with the lists.

I also recommend asking others at Intel for tips on setting up your mail client,
and other aspects of their upstream workflows.  Many/most companies (especially
big ones) have restricted environments that can make it annoying to get a "good"
setup for upstream development.

> I am not yet well familiar how processes are working here with new features
> development, trying to learn that.

No worries, pretty much everyone goes through the same experience :-)

> That's the first time I am working with reporting issues faced as just
> started validating TDX module on top of linux kernel, didn't know how it
> should be processed. 
>
> Intention was to let Vishal know about potential issue and suggest some fix
> which worked for me.

For patches that have been posted, but not yet merged, reporting issues (real or
theorized) is handled like code review.  Just reply to the patch email itself
with the (suspected) issue.  If you have a potential fix, you can include a sample
patch, a diff, a snippet of code, or something in between (that's the glorious
part of an email based patch+review system, it's very free-form so almost anything
goes).
