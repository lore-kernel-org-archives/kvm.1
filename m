Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163BD218845
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603936; cv=none; b=SnaJHc4/xWbuMcEZ6KTcWYq0pxvXswTpluayYZ5BwOKlp3oYM6HUo4EoPw/frpRLqNRZEHE9WEOlriqXd4bzjXZPIkahJxx1WVUxWcszbCwOZp1Hg1U0a3BvbhwE8ompP9SOBhs3Dn/8CBkzEk61WUUK7OP/9RJyNBKDDZixKoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603936; c=relaxed/simple;
	bh=ZTuzgcPbUyZN2TS7s3bSSQhZ1tSs+TllIC7bXaAEUAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rC8mV2VikLYUZXnubzDaMXzcwCEamxWLJTyLGVfVztLV4FDYDorY83BalJVoK7X3G2aJ3zJrHw7/xpVzP+2DHlbS5brSYwUtuptUZ3obA8vUNryaP+PnXKXtQxxr2y87C2+OxgvdgKsgaw3825RFhA6t0wyG1EsfW+wQ5GLm66I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxmKl+Wr; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxmKl+Wr"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c860544c077so3939637a12.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 06:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783603934; x=1784208734; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RdKuPRK/5J+rU/jhEzum6xrxN8s4WcbjUAqcp7f6fIg=;
        b=bxmKl+WrGQJBnu8iWzmrEzzOnrYML64Us4oK5qwAFuRn4E8qYgDTiJsKBcRKoCaHne
         tknqci7hHDWeZptxYJBLxrcv0chiCPVKOPBmgl+swoXJOOGr/4pA/JIrp5Yd6N/QbP1n
         j7pw3v5igKUt7/zf3+/oLv9svPErtMsylxLTujoF82NCGFzGUu+DOYjrftnwOdSpy+gR
         F9qXFydd6YwAhhFQu47V3LrkJkEvZNXhyCrZWuw7Ou9XVGbilvg2NHZ89llnWtglEN5W
         500/xPZgX6sV+Yd932f4JyRM/5GZp7ICDmkhvXinG/JiIjtd7YhP1yO5FcDmbe8ufsQd
         rPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783603934; x=1784208734;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RdKuPRK/5J+rU/jhEzum6xrxN8s4WcbjUAqcp7f6fIg=;
        b=Nmf4lOUhRakltvVWUggQHrPIPiXWi1+tqLU6Z1XyfJjFZ203CycPbpRVzzgIg9F4XE
         P6aMOFIO4iDiNxrn11/ff4sPatbCRx0ec/gJQKJCj0yPhXs355pVUggj4IZeYiMEwv1O
         YWTyVF2mtwE9kBQPSQ3SFYxmI+I0/LjFaIv7owRYgK93PkIxcz36VyMQFF5Pq4mmD4OC
         T2PiJCoDnJjH835gRoqoCX8rXc4G9OJxUnZXud3EV9HuCeJeK8oaKz+1jI5JA4HCFAth
         XZhraOk0oUSOaR1rYa5deBYqgRR9xpXHk6NF+Zc9xxr1P2oZ6b1bvXECBXT7+sLKGuLz
         DOww==
X-Forwarded-Encrypted: i=1; AHgh+RpY+OYEYYhsnAaKUbfMXPfHmhprglwXColOW4pAP2OxwdbQNq1P7/jUusJU0l1H9IRBolw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxegD5NAFQ18yDRDZf2pHFh6OGkja5pOggpMqzUZzYEBB1qhXzT
	aDE1IyTgXUJKKP4DFTO8DkL1e9QC4c35RMaSs8l91IMRiOHpk5Qj7+FMrcVIrX92XHKB5Hrd6Ey
	C3EVazw==
X-Received: from pfbgl5.prod.google.com ([2002:a05:6a00:84c5:b0:847:7765:a4c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1251:b0:845:d284:9e11
 with SMTP id d2e1a72fcca58-848438c5228mr7084292b3a.56.1783603933946; Thu, 09
 Jul 2026 06:32:13 -0700 (PDT)
Date: Thu, 9 Jul 2026 06:32:12 -0700
In-Reply-To: <ak78MvlryP8vSPVe@zlvmac.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708134101.1073574-1-jerry.lyu@open-hieco.net>
 <ak5VuvKjr8JqFOPf@google.com> <ak78MvlryP8vSPVe@zlvmac.local>
Message-ID: <ak-i3BW_hxLQSdaO@google.com>
Subject: Re: [PATCH] KVM: SVM: Do not warn on IGNNE MSR write
From: Sean Christopherson <seanjc@google.com>
To: Jerry Lyu <jerry.lyu@open-hieco.net>
Cc: pbonzini@redhat.com, joerg.roedel@amd.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 09, 2026, Jerry Lyu wrote:
> > That said, KVM does effectively support the case where #IGGNE is not asserted, so
> > I think we can simply do this to avoid the useless logging?
> 
> Yeah, that can work for the current case. However, if another guest
> initializes the IGNNE MSR with different value meanwhile never enables
> the IGNNE emulation, kvm will again print uselsss logging.

If you find the logging useless, just disable that class of logging entirely by
setting report_ignored_msrs=false, either when loading kvm.ko or by writing
/sys/module/kvm/parameters/report_ignored_msrs (it's writable by root even when
KVM is loaded).
