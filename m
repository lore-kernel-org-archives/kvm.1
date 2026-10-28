Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194880;
	b=LqBIaNiQqnYTbsTEdGBqy1+QieS6XcSF2MHs7HVesh2ADkt6gQxJiC9W4qraWgSZLC5u
	 YWC2S+BbKoq2wdHBk8DNSi8JMcvg38zw+Vb9lM+vaFYBXjHqJ8O+26as3UKqvYAikosCK
	 cVe3CJ545eEH8X8mN25t4sWhp7xs6c+acj0kYhrVAKIBypI52RLSeefBbs33kp2/hrW0O
	 y3Ld9miJFE+ugAdqpsxcc0dAGtuJ5ykCYmOsucjR3pnu8vaxuIv8qMDnp+encJv26Vfmd
	 U4/XGVv0n3eA0XinqZQqqxwYXlLZyfX0wbo0bvQ7WqxgKD7FtT/DcDf7J8eS6bgLQGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=PF7hA8qtLtGMgmmqrzl6s1EtCDWETZWVgUxkDpAKR/s=;
	b=fhsXiT0QCC9sEK4OkGa+ywPnJvBSTrnMjapZHUEY4cTBnGA9CAGGTv1JDjHf6CKXRd9I
	 zUqrAUvuA5icE0xCICCHqWnW6BmA53SmMkVqofr1jXnubxt9iIze7BgMB68MXkoHdMhQt
	 MScbOwgH+O6id1UXj03TB41M04xbBtG4sSetr8c0MEFgHyKJVn3/cLhp4oz9NpwgrjEne
	 HSV4KhmgHLN5q2eSp8DY0hinsM6n8N0dI1bRMq6QN9KAM5QUaZEFc/47uHBuaKCl8jy5H
	 /GcoNfHf5xpi7aHehfdx/cGbwOI2qHzoKmiax/0OsxYiOsixPa6Nlva1IuuH3BkQiTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bph0gd+z;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D755606A31C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 13:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D755606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bph0gd+z
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ab7f1efe5dso1593344a91.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793194879; x=1793799679; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PF7hA8qtLtGMgmmqrzl6s1EtCDWETZWVgUxkDpAKR/s=;
        b=bph0gd+zUXha4ogb18CQyEBJR7jV5gDkpBaIAkiihOtE/AXygtMx2NptDzeGmFuHo7
         lX+/2Yd9M3FAbIiITCdm2UsvHTidcOBUubojVkeyUWWYA1+KZetkFFIYRT2PN1688hib
         ZulthyTFbaDG062cfo/ThbVTLaZiGv+gLQnt9SHXnClRq7CSW1LwDM+UruM3PfFoJche
         14CkqXQTnBPGVZdTRM8MPrHXulOsYadgzXAKYx8lAllMFqhzLoV3Sdz41nezvKzBOVEE
         92lBDYEZFOU3InJlwuz41hFHy1c4GttsZxHlJvLVuwSU0kaPkpWuwiMpAGvSoICiCMsJ
         b+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793194879; x=1793799679;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PF7hA8qtLtGMgmmqrzl6s1EtCDWETZWVgUxkDpAKR/s=;
        b=d4FYfdlZyGrOBhtckHbZVQUF1hlLlTVJLynECvaWCU+1wjALbmjJL8A2taZ6L9eZTG
         1eLzWOCYXpvJkDNKNeMHahlkkcROFOqwmWjNyjqZgX9t1ehlI/QFd9+3HDfUEKSVBoun
         WTeJvTafONFnv8MEImjJ3ARWvrGyDdpszicueJWgWtzNB3vV3dDCHlRbbkixjefYpvcP
         8wRZf40UTxbvyZGRfDpMFF6oYwAPKVzIo7U4FmW3O6UfWn8Coggu4CTkgAj2KqE8/6Ur
         4ji29zkUH3aLgBCg+xSxKqf1uBJ+jwtm0yvAnj848w9lNkSwEuokj7pYg9COYcPIO259
         9QQg==
X-Gm-Message-State: AFq9FYLvQyhad/tEBMit1PDFNc3Tu0jFIhZDPKlz8CYsS1ETuSqayA+E
	WtNQ5+udPEkRpKK8+Z+2WA31jcv6ys/pAcVuWNUDPyjUSLV8QKnRn+tw1goFQAuF/gT04wDWeRl
	65DsuIA==
X-Received: from pjuj4.prod.google.com ([2002:a17:90a:d004:b0:3ae:913:ee08])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d00f:b0:3a4:f75d:d194
 with SMTP id 98e67ed59e1d1-3ae58228c44mr1916090a91.36.1793194878690; Wed, 28
 Oct 2026 06:41:18 -0700 (PDT)
Date: Wed, 28 Oct 2026 06:41:17 -0700
In-Reply-To: <sashiko-outbox-187178@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027224914.1574319-1-seanjc@google.com> <20261027224914.1574319-7-seanjc@google.com>
 <sashiko-outbox-187178@kernel.org>
Message-ID: <auH7fUGZnfGvg6lQ@google.com>
Subject: Re: [PATCH v2 6/6] KVM: selftests: Expect failure when trying to set
 EFER that violates vCPU model
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 27, 2026, sashiko-bot@kernel.org wrote:
> > @@ -222,11 +219,6 @@ static void test_sregs_lmsle(void)
> >  	vm = vm_create_with_one_vcpu(&vcpu, NULL);
> >  	vcpu_set_cpuid_feature(vcpu, X86_FEATURE_EFER_LMSLE_MBZ);
> >  
> > -	/*
> > -	 * Unlike KVM_SET_MSRS, KVM_SET_SREGS runs the full set of guest CPUID
> > -	 * checks, i.e. rejects EFER.LMSLE even though it's host-initiated.
> > -	 */
> > -	vcpu_sregs_get(vcpu, &sregs);
> >  	TEST_ASSERT(!(sregs.efer & EFER_LMSLE), "EFER.LMSLE unexpectedly set");
> 
> [Severity: Medium]
> Was removing vcpu_sregs_get(vcpu, &sregs) in test_sregs_lmsle() unintentional?

No, I intended to delete just the comment, and unfortunately the test managed to
pass on multiple systems (I'm guessing my build zeroed the stack?).
