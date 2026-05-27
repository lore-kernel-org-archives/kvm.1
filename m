Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC6B478E57
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905665; cv=none; b=YyraGmXzVOa9iydoLpW/hbhf70iaoUsOh8rrl1b9X+T+M/IGzhaAnMmXRJjNH5sKuh+ZuWQEnQ/G70EM6g8C5qwi/UXH7ccgUJ/VOHxWu8yLAi/iynK2UkLN1WGrzcPxUEFp2gtSFjxfPDt1qxtQ4DZ9AMj6p/RUcjDfrLV+VYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905665; c=relaxed/simple;
	bh=IOKoyHLxY/z5hLsO3htY/vrG3Fzj2MXOzTE5IC9IOAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DhWEEqae7TldYRm3TmAjP8dX1IUoKRB6Ao38qDeXQSN4v7Dtb2vCu9BiYSJ7jDiwnKU/aA8wqorVjGB68mIQJBwsqkey6r0KTQOeYNgFQ4p4MQxd+affx0c6a5sMcMmOq/Hahf5WfgfdKMBYAQwW3sPKFla2MRHWn13xT91BWhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GiBPuq+T; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GiBPuq+T"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf02e2f864so102695ad.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905663; x=1780510463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=90QoHoDQFIalJTQFQDHyQUQDWaZ1Brl3VNnvhBjJDmQ=;
        b=GiBPuq+TjpWlHLG7inhuDN2/z236u61k9tC6iWTQdSL04u/ngGJBFEu5DBz7f0HsjC
         wMHiQmFeLCFKnkgiwvWN/NC8iVvuNug/8/6EqbWddCuP2qcIkZDghpJX+GEUDe0bruIZ
         +Ju+83qTm/f8o+2LSgN/lq9L9fMplTIK0n4MFNGLglrl/UHdt5/k/pIsHNyon+GZRI3V
         SbEb6hVJBRPjSmI9jI4gnpwUat5ySTBFv7hP2WExtoc4OmpZBUSthhvtTvJk42ROurH5
         rlq7xMZeHQNYcG+B1PxWhVLHQEmDT9NytR0Hmyjgz3x5StY+cp9K/H3UvqJyI79nc29X
         +2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905663; x=1780510463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90QoHoDQFIalJTQFQDHyQUQDWaZ1Brl3VNnvhBjJDmQ=;
        b=VnJ59ALnc6wLf2eDrWjgSJUZ2Xxj+i1MLvzxdA06Qg+XzO2zfFcn3sBY5lIz6jcr2W
         E3232ZQxC1WxlE3+Bk/nX8GmEjvDwFVrrbgvfqe7CBAEV3Iwg7teEvWLNUbtpBf0XZg4
         Q4C2h0Kw8gZ10mKty1yoZqQPO9ZgMA8BoPqNiIXlGeolejZgZ+qBVwsveLGXqRNc/o9H
         Ao3Fx2/poCg/50DFbdw9Aa3mD9ZG9VIu+rcJjZi/Lc0RUcRiQd576jOxT4URwx+/Tvbs
         2WcO/oT1Qf5CsOWf8hp+7HLG7+yBjfimQgyckCPw9RjpAfj/xwEIgSFKxFUEAowjopxi
         zDVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Di7o66zHQg1v8p4s8m5wP7W5nNGV/jCuPBGMeBcD86KsRKhGm1ak7oyhM5xi1xV7CzkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjmw7ONVNSP5LIfWksYRC2r/1Gij4j9kEZKH7d/dd3sgKNvV7b
	ukCbhhIdAs05fAawkBqA44U4XcRFg83tzQ493rCtrrvQSk5YKSQsgXj34c+2JXDfHLeBmrxOAUP
	i4S+AKQ==
X-Received: from plsb19.prod.google.com ([2002:a17:902:b613:b0:2b2:51df:a515])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aae:b0:2b9:5d1b:73da
 with SMTP id d9443c01a7336-2beb0741079mr277701145ad.30.1779905662956; Wed, 27
 May 2026 11:14:22 -0700 (PDT)
Date: Wed, 27 May 2026 11:10:10 -0700
In-Reply-To: <20260522151534.652522-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522151534.652522-1-vannapurve@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177990512633.4119760.10440459060511762147.b4-ty@google.com>
Subject: Re: [PATCH v5 1/1] KVM: x86: Introduce has_protected_pmu state for
 TDX VMs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	Vishal Annapurve <vannapurve@google.com>
Cc: rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	kai.huang@intel.com, jmattson@google.com, michael.roth@amd.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 22 May 2026 15:15:34 +0000, Vishal Annapurve wrote:
> PMU state for TDX VMs is virtualized by TDX Module [1]. Host has following
> toggles to control the PMU functionality exposed to TDX VMs:
> 1) Configure TD_PARAMS to allow guests to use performance monitoring.
> 2) Restrict the TD to a subset of the PEBS counters if supported.
> 3) Limit the TD to setup a certain perfmon events using basic/enhanced
>    event filtering.
> 
> [...]

Applied to kvm-x86 misc, with a heavily modified changelog.  Thanks!

[1/1] KVM: x86: Introduce has_protected_pmu state for TDX VMs
      https://github.com/kvm-x86/linux/commit/986833d381d2

--
https://github.com/kvm-x86/linux/tree/next
