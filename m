Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905702;
	b=zq0G5MttlX1g/1xtDbZi4n8ypC4BXhWuGpUHyxftf0IyukPF41jlRLB+79/wXHRRWEA6
	 C+J2+8BoWXe+tysApQY6YyOaOWZaO0VLdygb1c/CRTwRr231Z0JZFz+/4wLgFtFixjSe8
	 9SqVrJuzU4LOdEzE93Y21Z4jYZKswtAydfVTgqdO7y6BjSSDYx1GgBO+xIoYifP9W4Ikr
	 PkoyiZtmWiUPrFKfheeYNu7aXoABi38+2sgr0EM5l6YKnQSFAa5w4ryKHP1M5PWFLBJmy
	 OP6y8fAoSFNTuiqFNeeVyyjBg/ab/k/mZZUjuZ4985u5Swp3gOjPa5nThpol1gvGkrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=EgrEjWq1dkccGneJGxtKcBDSZQyn1idPPnv0strekvo=;
	b=mwQLi6t0gOJI8N+uGD9gMLt/OdkmOmdgEqOqBT1g8kD0mxM3eRphiOcSg0jKZtEwX6Jw
	 syynHeP6go0NpxnCXKnEQq1LB+8U1Ba3dhnUIf8sxIXjIabPp5zAFMywJ3bZ7hrLY2W5I
	 M12bFG2F2omtIkKZN16jXNN6DKPTw4Jg23taN4Kcm71XCBGxBP91vBXf2uzx1JTIF6WBM
	 YsmAGPkByuWBgLxJS9KN+2pobnFp6vhYdEK1n4w55Fazy2I3SJaSiXQYPt+o4duXUHLiG
	 oUu3wc2+vejbHlv3fEDe/OCZ5QF4Y1fN7Nsy+Kds2bavn57gVd+BLUbahGL+M6FP2lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Z1t3HC4J;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1C606A326
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 19:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89A1C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Z1t3HC4J
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ea381ce04fso13261275ad.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 11:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793905702; x=1794510502; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EgrEjWq1dkccGneJGxtKcBDSZQyn1idPPnv0strekvo=;
        b=Z1t3HC4JPfaqY5QaOL1TJjLm2Yf8K3fz6vV0RGq//80ezjK0r8FvaUcvEGDJz83cjv
         prpeOohIpU9/yXt/YPfd1Bi39Hh2QwZC8jzoXly0ZI5jRTrxKVvX31zF2oJQdkWdu4h4
         crWCNQFLe0zGzMVrLw+B4jCGZvm4+8OBcqu0Je+R9clIwI0dqEw/OiT9VjKKhpWXa7gS
         XGVPy6CRxOcVctae7OkBKgeSrrtGPcy07MRquXAlr5+elHzx0itjg4Gle0OzSUQY8/fg
         N29D3GkDi0xB14axB4uWFjW7gZMdXkl619+h+Rnc6ycPTHexMkknQKYVgCUFSHwpUfPG
         JfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793905702; x=1794510502;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EgrEjWq1dkccGneJGxtKcBDSZQyn1idPPnv0strekvo=;
        b=covUeUq4w2SPzxDbrou5z8hudNp+ouytWkTAJERa4vJ8mkQHLpbFJm1Um8QEKdVP+W
         8cEC3FRh0tAgN1/bZCDGwUK6RthE3L/YZfbO2Sbjy17E2LfLROLBUInezKRVp6gcZ1kq
         qPpngvbib/YewukZKXzkDNQYdn4p/09ee3igbhyBsUuxm3RToYHgviiRaaMAxIj9paIu
         E6XGOUGaki7laQ28A7INFbB+ew3+YR/HfpFQZEWSLSZysOEYZgtAXsWGNVWILf5M9jW0
         SGdx2vSOgGyI03BcoorUufUST7VVKGaevpRmga+qug2UwPf+6da3dQmJGu0MqFH1WJP2
         ylFw==
X-Forwarded-Encrypted: i=1; AKwUvBwq5sODYOjH60OvcAEgqhPQIW1djA/suOhbrJxO/vE+if+VSCpOpRbhgtXBgU3romD2R/w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uKYBg1GvtKUyuZU1toJ3fBzIXmk5OCzX+0lpLHxfParzR/61e
	SwnxOzQbd/eQ/bMeGXMw8ieZpWixaI1GksQ6v7Jas/ylru8ZjCJsxCx7Ap7bzaEnCPpUAcD8NxX
	Ut1yYXQ==
X-Received: from plbay8.prod.google.com ([2002:a17:902:8b88:b0:2eb:337a:cac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19c3:b0:2e7:67ad:8e9d
 with SMTP id d9443c01a7336-2ed40da6654mr4115955ad.30.1793905701489; Thu, 05
 Nov 2026 11:08:21 -0800 (PST)
Date: Thu, 5 Nov 2026 11:08:20 -0800
In-Reply-To: <20261105164531.313849-6-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105164531.313849-1-pbonzini@redhat.com> <20261105164531.313849-6-pbonzini@redhat.com>
Message-ID: <auzUJOrdHz4pwMuL@google.com>
Subject: Re: [PATCH 5/5] KVM: x86: move asynchronous page fault handling to vcpu_enter_guest()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Hillf Danton <hdanton@sina.com>, Steven Rostedt <rostedt@goodmis.org>, Harry Yoo <harry@kernel.org>, 
	syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 05, 2026, Paolo Bonzini wrote:
> Fully handle the PV async #PF in vcpu_enter_guest().  This has several
> advantages; first of all nested async #PF code (which has more to do
> with host page faults than nested MMU page faults) is moved away from
> MMU page fault handling, second host_apf_flags is hidden (though only
> partly so, because it is replaced by EXIT_FASTPATH_APF) and the node
> put on the stack.
> 
> Reported-by: syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com
> Link: https://patch.msgid.link/auqAsEk9o6buPNiR@google.com
> Co-authored-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  6 +++---
>  arch/x86/kvm/mmu.h              | 21 ++++++++++++---------
>  arch/x86/kvm/mmu/mmu.c          | 21 ++-------------------
>  arch/x86/kvm/svm/nested.c       |  4 ----
>  arch/x86/kvm/svm/svm.c          | 14 +++++++-------
>  arch/x86/kvm/vmx/main.c         | 20 +++++++++++---------
>  arch/x86/kvm/vmx/nested.c       |  3 +--
>  arch/x86/kvm/vmx/vmx.c          |  6 +-----
>  arch/x86/kvm/x86.c              | 17 +++++++++++++++--
>  9 files changed, 52 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 93170c70a17c..f72028efe2ca 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -209,6 +209,7 @@ enum exit_fastpath_completion {
>  	EXIT_FASTPATH_REENTER_GUEST,
>  	EXIT_FASTPATH_EXIT_HANDLED,
>  	EXIT_FASTPATH_EXIT_USERSPACE,
> +	EXIT_FASTPATH_APF,

Ha!  I had coded up EXIT_FASTPATH_PF too, but never proposed it because it wasn't
useful since my approach used a dedicated kvm_x86_ops hook.

I'll take a close look at this series today or tomorrow.
