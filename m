Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A84746D4
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486329; cv=none; b=OVWty29P9FVTJohHWtv8+E/XiwRffrs50k/D+1U4q4T3vyWFm8myYbUUEn/gV8cH4WdwfCZZmF54G5yTn/QV/kER87oxCZlPm9uI8Nn5nR2SRryvdoFQYAoL9AR0xrWOzSfe2oi61s1qCfh8z4eyZeP+6lvSgXW1HaiTJeb8Hzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486329; c=relaxed/simple;
	bh=12x4VVPM59hdNqb3G8UucUJzlMxVSdHCWv05LPGjVnw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N8t2cnvm+y9LQvtJ1+APjI1QARgTpi+Z/i9hYQWB4u5F+LagPMu4ml5+k2qugpUF4yDO5hXIdOMFm3Md1z/KgqdV/m0vWK+CwBYuqCIexxPufp+2PMKJmN4yr+Mob3gITM6ZhR723YhOZZP1WFtF8Q6EOS6fVvtIKEHanTy7wsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kOK9SRyU; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kOK9SRyU"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8484f26852dso364169b3a.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786486328; x=1787091128; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=12x4VVPM59hdNqb3G8UucUJzlMxVSdHCWv05LPGjVnw=;
        b=kOK9SRyUG6SymS+TEZOV/Pyh+gS2ihwrULfE80RqgNjGHvCY//4IrOyT557uHDFFKx
         QFmpFNqAnyBYkvSc3bNyz9oqpAMrDu72AnzF8X7Iis9F0eAtV0iMBWEFM2+lzt5V86V4
         Wuto1fASHrmLDY+drQBrZuvOmnqp9ZbdhKy/hAiNpopWV/vEkRcJwYtMFaRrR4LYLN6Y
         2NXMMW3AmivcyobVcb+5dADv1B6QyGnwvwWzAOB4shhL7kqvJT6uYgTA26Yfiiu5hbzw
         tn90oEgQ9V7p0LH9CnfbjWv5l2MhuF83fCCG87woahKu84g1OIVapLIGaoSl7ofzGlPA
         iGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786486328; x=1787091128;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=12x4VVPM59hdNqb3G8UucUJzlMxVSdHCWv05LPGjVnw=;
        b=fnvpRYM3s1DRdyss+4dNtfaxhbpUAhjpv0IQNOCfJgcODTq+kMkaWdR3sFxTi+nUxz
         zXCF/zI6GRFMENS7l6afe3lkpiYac5Nwyro213JE91ZKfndW64yR5cpsxSK7atRoLy72
         GpuUS7omYSKgLpNIl2iXM4f0vOTsimwxNsOkNz7W5Bf5Kd+9jWuNxDnj24sRUZpUV8ER
         rQoCvNZ8SQcri3aiVq3ZUknWHAX06aN5HbV9oTm1k+7knERmoq1XjjJAgoiqpcw3arfE
         oKXtMSeyLVlUfPF7rxtirkg/iNS9L2stW8CXczLQyM2T0QzaCPhoSj66zZX4EWKB3qRB
         t1nw==
X-Forwarded-Encrypted: i=1; AHgh+Rq8RLZZ+sePwWA9OXBYZ5NvoS0BvM/S6LGRR1mN99dmPpMcIDoVjkTQnP6Vn4LE00zcYZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTMgD+mWCNa6eeSStAFUGIYohfHlN25yXlwCxnQDAX7q/jzCpX
	lAIz97bIPqzCnJK6lrQAb3Lbbwoj++c5kG7VwognGdo1/GkSP1PQr7hAxlm8+voYOPqqKzbUE5m
	B8xvQaQ==
X-Received: from pfef3.prod.google.com ([2002:a05:6a00:2283:b0:845:38af:5fa5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:987:b0:845:e04b:565f
 with SMTP id d2e1a72fcca58-84fb5404199mr525520b3a.14.1786486327495; Tue, 11
 Aug 2026 15:12:07 -0700 (PDT)
Date: Tue, 11 Aug 2026 22:12:06 +0000
In-Reply-To: <78aa2a375ce92ac37f084dc44ff8ee126b7ffd22.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <78aa2a375ce92ac37f084dc44ff8ee126b7ffd22.camel@intel.com>
Message-ID: <anueNuwFl_dNRKBo@google.com>
Subject: Re: PUCK coco migration topic
From: Sean Christopherson <seanjc@google.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"Maloor, Kishen" <kishen.maloor@intel.com>, "Bityutskiy, Artem" <artem.bityutskiy@intel.com>, 
	"Lindgren, Tony" <tony.lindgren@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 11, 2026, Edgecombe, Rick P wrote:
> Can we steal 15-20 minutes at PUCK tomorrow for a little sync on TDX migration?

Yep, as usual, there's nothing on the agenda.

> We want to share a high level of what we are working on for the sake of less
> surprise later, and also to sync with the SNP work.

Don't worry, nothing will make me have a more negative view of live migrating
CoCo VMs than I already have ;-)
