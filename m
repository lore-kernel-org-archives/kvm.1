Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67B8003D
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783379803; cv=none; b=FiFqf+guwZYj2VoGn3Aouzt3RMExd0Zq+4/gXriNQub9SUGgZ570P+50hTvsagg4ArzSTV1C4bSqY6Knpa3iyeOi7Uzlto78z+lWOyXT/H2WJsOU5+wk9DevsE7kalGhzn+0/He081ZDCtClXOuuaNnSK7gIRq+8TPy7WMnurEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783379803; c=relaxed/simple;
	bh=LBsERILn1RsTbzBee8hFdg40stF7dMkbmTLRcDQN3ro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aQR3n3qlekjXKgmd4HMoXLTnL7WWH/4ssdvvi8u93LQCpZN9tQpO6WMLDr4AHwXwdDwVGjXZ9ilU+tDE/u3PAEmwdYC1hH3mfclhfFevLN665SZRNfJUJYOIEHfwG61I055mD9t6St9RWhGxiof1b6/fCzsFKUkRI4oZpJGyKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iC3Rs8fh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iC3Rs8fh"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88ab059052so81214a12.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 16:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783379801; x=1783984601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aPu1yjO3YE9jowlTRoZpRIUWlo/hc/PNoecgFLgtNRA=;
        b=iC3Rs8fhk78n+8fRyQkLCxy99wvZCxRLh/QdRu6PuzpFnGs7SzqJrMjTM2Bl5ZhWQn
         s+J5lrjDg4ADHKlMs3CxOSsT6I6oAX/5eF3ay5j2Uatc/aBmhcxS+fdoBP6Drd51YRvK
         n+deHji1zOXjlddWKYFx7CFlGgjT+GsFyEyHTA7aPyzvxqQBXe831p4KCQRy/L+iQK0X
         zB63/Buql1OQ09shl1w5B9sFfMKk1KmYuuEA8CD2M13iAde3pZpNfIT1OxPGMGrr+4+J
         3Toad61vg8a2YYiMpXXXe2rCNqxi7gaYz+34j0uiKeYTtauN/0lRqB/x7y2yuM/6D3vW
         qmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783379802; x=1783984602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPu1yjO3YE9jowlTRoZpRIUWlo/hc/PNoecgFLgtNRA=;
        b=hZAorlYYEh9esIL4nbTKTsoTffLHkqhgtpuJIcofOeC5tg2n6s8x56m3mSq6BZNGDV
         +cXqf3WJJW5Izq1RCdSPWHN94RiEzk2CvZYKU+HdA9+yoiPHI5w08LKmf6MGONv6cxMk
         +B1QnOYz9BoDjodGam0bC/MD5rfBe0vk5zO5KKI9PoPJC2xCeaG/8AOcd3BaS8ArSKUc
         fakOZv5EuImHPkgCnWsj0QYlRYRTh/JWDoAmXjUdbCvCoXV9CVnS7s9hCFBtXmxO63hD
         /DKRH+CuymffUtSOH3ujcdjXJCxq4pHW9495GCbWt6HOI2tpG05u8HkC1IvlADYI2SGQ
         o0JQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDtU7pkbwZ7z83tlKs9cVNWFikN5lOQkpUbtUHYXxtRONVb/wLAZRQb/FxbxONHlL6xOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjXUTG4xElOoJU5nsGtSqHLOYTV/k8snJS8+HKI6AMuHOGQjK7
	YKjFx8yl8BcfgT3ndxILNl7rMjhPFcwNFF6wfhje06ZXnLaqzER94vr7kNDpkM+cAGaXlk73iKx
	QOHa4og==
X-Received: from pgg3.prod.google.com ([2002:a05:6a02:4d83:b0:c96:47b4:65c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3020:b0:845:cad1:d691
 with SMTP id d2e1a72fcca58-8482f17c7c8mr298869b3a.5.1783379801393; Mon, 06
 Jul 2026 16:16:41 -0700 (PDT)
Date: Mon, 6 Jul 2026 16:16:40 -0700
In-Reply-To: <mxhv67srfonr2nh7eoecujibf2umlbhyrhutdiizmm7qimrwyq@c357mnkz7lvi>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com> <20260630222607.497895-12-seanjc@google.com>
 <mxhv67srfonr2nh7eoecujibf2umlbhyrhutdiizmm7qimrwyq@c357mnkz7lvi>
Message-ID: <akw3WA9IduOkTK0C@google.com>
Subject: Re: [PATCH v3 11/12] KVM: x86: Guard .gmem_prepare() declarations
 with HAVE_KVM_GMEM_PREPARE=y
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, Michael Roth wrote:
> On Tue, Jun 30, 2026 at 03:26:06PM -0700, Sean Christopherson wrote:
> > Wrap the .gmem_prepare() declarations with HAVE_KVM_GMEM_PREPARE so that
> > non-SEV code doesn't try to wire up a callback without doing the necessary
> > enabling.
> > 
> > No functional change intended.
> > 
> > Fixes: 3bb2531e20bf ("KVM: guest_memfd: Add hook for initializing memory")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> Reviewed-by: Michael Roth <michael.roth@amd.com>
> 
> Not sure about the need for the Fixes tag, but it certainly guards against
> some future problems.

Copy+pasting my response[*] from a similar comment about a liberal Fixes tag:

 : > This LGTM, though I'm not sure this deserves a fixes tag.
 : 
 : Yeah, it's borderline.  Because KVM (x86) doesn't do AUTOSEL, i.e. requires an
 : explicit "Cc: stable@vger.kernel.org" for the vast majority of cases, we can be
 : very liberal with Fixes.  And so I like to use Fixes to create a paper trail for
 : anything where a commit did something that would have necessitate a new version
 : of the patch, had it been caught in code review.

[*] https://lore.kernel.org/all/akMLDayXmzhmvJBG@google.com
