Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B873515D6
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838202; cv=none; b=gL0U5ba2C34Wd2MXDixHYIrFpOSm/ypZgvbjAA7CYP99yRA2GgYqRbF5XLWxnJKW5evfRretEmhyUGnAHv4WFXA7P6Wvfnmrlt0HMtOBuMTl3rBLDgqZFQOimok1WMCE8fD4yto0O6OW7bhOCaKXAEH0mjNA7+IO0nmIub7JF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838202; c=relaxed/simple;
	bh=8ONDUDAg2dM8ZoH59YtZArNDROq+JIIjaSpnOUiHVnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kefWyZ2B0nLZwjP5Xai/OcTkcQfD5zt5jHwngwastNS9UziXBsHadKYsCWVbfgdzPfZddz3Grdnug8MrGO7W929bPRkfJJSFh+EiB7mEytsGnMc63qrS9qzcRw/XTjhcAkGRPNpq7dgZ6MgAoB2cAV28yi+KidiUq8PbGAfeX3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oo8Kmyqx; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oo8Kmyqx"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfc52ddc55so32609165ad.3
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787838200; x=1788443000; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYncMrF5RzKjUOnGrPhMmfgObwsKBG4ezJSAsq3PxiI=;
        b=Oo8KmyqxLCBhU0E05tUBeNjE5TtPZJw5hX0o9yAIU3+aDpM6nWaGtA3NTeAlR4l+5K
         Rpxng6TmjyFrTJbTDDpazM1Gn6qqQYDaonUbU/lPvjACB7gfo5yfmg/G1kiSv/JoSPm2
         UiKRUsdnjQ0k/V/rK0WvwTdyFyB+kxLHCNcLtD9C+TAvkQrgnQYsfOCc0KQjofjKAbmw
         vT4MNSoeX7blDf0yN6ISyW9cGZ8MrNdoWtj0KMUdgD7+7wp00KKQ9y98YsHuviYtYRmd
         pQNwLO3TMd/7sNzNK9tljiRaTBCe4OvHS5MoawfMexkmUhoqYByMQGIXOXXVsnpiGNoF
         4oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787838200; x=1788443000;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYncMrF5RzKjUOnGrPhMmfgObwsKBG4ezJSAsq3PxiI=;
        b=MQ6ea/uYDJBOym9YbZQuUEfVByMpzt2xdTgRFJbLkUMvp5r8992+hIAmaYFDwsNt6q
         EaQ7Q9xFGeEfdQ70G8PslnaFQxB0Y4l6L5e3cnZ4jMk3AjDg0h4NL6N4IsKdLPKbxz2i
         q7jB1iBvmSRlvOu8Mr4BIzX/cxj/4Iw8mCJX8UC2oWy8hcKuP5os4qiWhp+QEVhRieXV
         b63x2AufBh9ucxhT7WCFMWKrynMs2rUebGDGma0g008vXvBBSXuuigMSbUgixtBEMIQD
         QWtuIxQB/HIpSGefhDvUm8CTr7V9eUeWDcxBaLnmRnNEhoHdGtaVT44PKi3wwcWE3Mbk
         jbCg==
X-Forwarded-Encrypted: i=1; AHgh+RrJN4GKphshWV6RK1sNe8Gi+nXH2Gugs9PKIT+41nqzV6dkDZrgWktDkMGBfW7HBwq6fgY=@vger.kernel.org
X-Gm-Message-State: AFuF++lOeMY/Zx1liy6N7VI6KMlJRWZ1h2fpxDTtnMIAkuLAPiPlPjRk
	cL95+8A+yPj7F+KR65n2IDS4ZjlIGiVQWik4VdBX11eO5JODLkowXfnFvS9DWKLv2eaxObAlkrq
	fV6RhGw==
X-Received: from pga9.prod.google.com ([2002:a05:6a02:4f89:b0:cc1:be9e:35ed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e290:b0:3d1:66cb:d49
 with SMTP id adf61e73a8af0-3d166cb0e18mr7225133637.4.1787838199681; Thu, 27
 Aug 2026 06:43:19 -0700 (PDT)
Date: Thu, 27 Aug 2026 06:43:17 -0700
In-Reply-To: <ao_Ms5alWwKa30U8@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ao_Ms5alWwKa30U8@192.168.1.215>
Message-ID: <apA-9UEveHuHhKkV@google.com>
Subject: Re: [PATCH 1/2] KVM: nSVM: Restore L1's debug registers on nested VM-Exit
From: Sean Christopherson <seanjc@google.com>
To: Hao Zhang <hao_zhang_kdev@163.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 27, 2026, Hao Zhang wrote:
> From: Hao Zhang <zhanghao1@kylinos.cn>
> 
> Restore L1's DR6 and DR7 when emulating a nested VM-Exit from L2 to L1.
> KVM loads L2's debug register state from vmcb12 on nested VMRUN, but
> currently restores DR7 to its reset value and leaves DR6 untouched when
> switching back to vmcb01.  As a result, L1 can observe stale L2 DR6 state
> and lose its DR7 state after an L2 VM-Exit.

Well, yeah, because the APM says so.  The APM very clearly says:

  Disables all breakpoints in the host DR7 register.

In typical APM fashion, it says nothing about DR6, so it's reasonable to assume
it's preserved as-is across #VMEXIT, i.e. is L1's responsibility to ignore since
there's no #DB.

> Restore both registers from vmcb01, matching the rest of the L1 processor
> state restored on nested VM-Exit.

What happens to other state is irrelevant, what matters is what the architecture
says happens.
