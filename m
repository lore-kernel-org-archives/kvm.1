Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2453D8135
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181087; cv=none; b=N2wx9/dpja525QM2QWF2CkSDgMp4GV/fm3NTs6pvcFJfj5ZDATj413FH0sRM7hKiZavVnDF+iQWxT4V8JkMVwVR1LPb4V4DWYjMhuev15Rr9wCroKF0kciIgif4v8WUS6AhJ+GiQLSsOU3r2iOOUE3pf9CE8Jo8cqAtYwiaMQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181087; c=relaxed/simple;
	bh=pDXF8QRt7ZGKEq0AdjebnFgpWu1BsXgK6gD+2dgsUZo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rz0Jt0I1EuGVzDYHd2HlkLPV2FGVIouth+BulIUUrOVGENjyx6FpGmGyqGnxBEr/nH6Yc4WTF8bBxBJFEjYto4TTCk/oo+o/rDfkCUAohAOgH/K2b6sVui/oZxZD2Vkg5/slTNv3eHrCj4EgZLhbasxSdRHbzwnWYDk7Ls3cgGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kiFTcO/p; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kiFTcO/p"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35da99b90f6so7284526a91.1
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776181086; x=1776785886; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fTzayLah8spuwGg86ncm2630WsNZvV7i/NqWUT/CAWQ=;
        b=kiFTcO/p2NN7MKSMo0LPdKwYjLAC9Kf0g0xDWdOuoOUxEa6f9ySfMGyiLyWBwku64Y
         TyJlyPy8c6DJRHCMy9kemNYtap08OEuAURFioDhXESAT87lJ7kaf02gsUQpPyJNBWOgQ
         1QbTAtItgod1GBNRn4Hgfog691In/p0QqvipQHaozpX7R/FUhIJ1KSH1GVcELl1BJlnE
         3785vKc2bjLWhKaGLmvW1Vcvw8dnwy506wdrfJ187mu56CxLjBdgx1gDLpPRNyNSwMLR
         ZzYyKWZu1gH5y8acTO6MwMl7pXMKhc9netxlw0doiXGNngKyqs+rCt7c/PhiClLr7xyk
         FPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776181086; x=1776785886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTzayLah8spuwGg86ncm2630WsNZvV7i/NqWUT/CAWQ=;
        b=J3zPchgmLVPeE58lK6PkPu7UrQBldidWv24IfEABO4y4byk3cwacxUXfVKacFoYL19
         dmH1WWr/LowKl1Xwahs3G217aP1se2MUeJpHIJz5If5gHVhCc/OU3sHAFn+W9I4fVRRo
         FSL24dv+qw0HuTS8o3bLeSh4VBEKLrdAE2FQi/2UnYw1Scgd+qDJrLBmO7gQ+sCU7DCR
         +pyQqoCb+G9TTH2PkkRIKovGsdbMBmdKdngsUmgsLtPmYuTzisBrDWEzaLBdKOQJgCyI
         JkOKyxCyvuuq8QI7fvl1NyZ8gsCd5RSF/ftATkiSFQhtleXc3djy4USHHpneubwrM6DH
         ww8w==
X-Forwarded-Encrypted: i=1; AFNElJ/uQFnLY7LTB5FteyUOTI8UnXsccL96MKanMWi4IIUgZNvCYj8VRUTNFJzdx7P17O7QXQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5/QoJG+5WovzKlbNMDF8DMUi9ves6Z5ry08JIzvTjQiwd4QU
	83DVKeoukYfqA3TbxCvoF1cFkxar5o87LCQ5aJ3YGgykXdLVSHgUL7x2mW5D/3f/7Dx5igLsEWj
	eA8UYgg==
X-Received: from pjyd3.prod.google.com ([2002:a17:90a:dfc3:b0:35c:e6e:959])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1802:b0:35b:e566:15a6
 with SMTP id 98e67ed59e1d1-35e4286354bmr18000661a91.28.1776181085761; Tue, 14
 Apr 2026 08:38:05 -0700 (PDT)
Date: Tue, 14 Apr 2026 08:37:55 -0700
In-Reply-To: <87e767b6-0324-44e6-92cb-f933002dec43@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409224236.2021562-1-seanjc@google.com> <20260409224236.2021562-2-seanjc@google.com>
 <20b82b65-b156-4a2c-8094-b86dccfb3025@intel.com> <87e767b6-0324-44e6-92cb-f933002dec43@intel.com>
Message-ID: <ad5fUya3W9BKO_iA@google.com>
Subject: Re: [PATCH v2 1/6] KVM: x86: Add dedicated storage for guest RIP
From: Sean Christopherson <seanjc@google.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 14, 2026, Chang S. Bae wrote:
> On 4/14/2026 5:31 AM, Xiaoyao Li wrote:
> > Even leave RIP in regs[], what is the problem by just allocating the
> > index 16-31 to R16-R31 and making RIP the index 32?
> 
> But why?
> 
> Even though the array isn't explicitly labeled as GPRs, that's effectively
> how it's being used, and RIP isn't part of that set.
> 
> I don't think there is any benefit of leaving it in regs[]. 

+1.  Chang's earlier argument that RIP isn't a proper GPR swayed me over, e.g. RIP
doesn't have an architectural index.

Keeping RIP in regs[] saves one line of code in arch/x86/include/asm/kvm_host.h,
at the cost of making the code less readable (IMO) and incorrectly suggesting that
RIP can be accessed like other regs[].
