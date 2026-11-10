Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336785;
	b=zJVoGd7dRn+q6eK/psmDnYewh6LVfoXmyMcwLJC7Cy3rO54V5t+Fcwxs72SJxq9OCs1l
	 u/VX4sX/3YUK+Y9OIv6iTpt83Y3D8Er39EDhX024UAG8pBToOCMlqbYbAC1zVWwMTYDBf
	 RoKcQuLDU4oXp8dcxB+ZRSSxHqatrECUGKK2ZNzUfo8VHeYFQRLYcWCs2//ZSqLmTQQt6
	 z5wbEgUxyhGbnZxWpWH78JN+p/Jqw7CSR79uqp6PNr9VREAKDELwcvKGvjo4qFAAWD7tH
	 KMHcb6VbzBAmOq5yfDDPWERORhSz+WhhtFhFIFHCGa48+DQq0vJiGoSINQ/U//LKnLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=mA4YNX8Ydg/CPBY9GGXckgAP+pIFlnhDeHY6Iu8MWSg=;
	b=T2W+hNBxFcKeAJ6fgLQuM1EGT5wQmANgF6t97IZm/n8HM3+LpGeMQt/CGvqjr3Cy/yYr
	 klIEVA+9XfBxzkyFNIPlACVkxoSv5U12WgzD/0BRc+khyVyQK9rLqisy3iMMehIbqh+sw
	 sO/o6TZ6eqj5PYjI45I/swRisbVU9Z8465/MGi5lLqMyVBuuAjLqh1mhTHCM3f8Qnl8jU
	 ylrj674vCdORjbltWe+3SYQaUzG2s5jxz1OKRmOb1pQyjIERLQ3grQ+ChvAQA14K0JECl
	 gAxPYUyvRm9d2TkGUzsADbXZ7iDabvqbpbW8QxMj2FNarq6m2561i9+u5bOSYB87KFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M3JvO+7G;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A605D606A321
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 18:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A605D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M3JvO+7G
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8b691cf0eeaso3162140b3a.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 10:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794336784; x=1794941584; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mA4YNX8Ydg/CPBY9GGXckgAP+pIFlnhDeHY6Iu8MWSg=;
        b=M3JvO+7GQPB6JuXsOL6dD6S2qMQ8HSXO40UTXzOGHaosOJil5GSywRu8zwDCG+9hVx
         5MdX0NUxml/hP3/YB/yMiXXRNSYqTsMhSKLVVwiA8dSXDlMQw5TUI1Sofgu6ppMUxnfj
         eyAB4ctx/oe7q1aHXivzDosHGDaZyZQnQDotXvjxTrLPuASiGta1cPo5H6NSUHl/0l5E
         6ODAWPpzWqMwolBqB35WMHwkk0b6tccTVY3D9K3y5PkQ8FNLO/lo/wci8zWtcKGzw0MR
         7pAnJa4dz5dHshE2RfrkdGTZ0ir8lrCNmYW8qmMbGDdN8uBxnaffyEeJHsXTLkOyrTSD
         S9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794336784; x=1794941584;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mA4YNX8Ydg/CPBY9GGXckgAP+pIFlnhDeHY6Iu8MWSg=;
        b=0jKTiQNdCIYb2A46R8RTi4unLdspJoBrjBMnMcdwyg1omqZ5uU+vmMgWKXR/OV+o6t
         ZgVPe0f8wMJIK7P2OernU9mDeA/1WChWN/OfbrQTx9mCPnuIuIVlqmVtRt6FV319ZbnH
         WYbNqQDLSBp1hdK3Yxqi7KE7Wb62plglRS+n4LCOIalzLxIwxNFAaG+LaK423zPA3/VU
         J4TqX/RcW9pjIR5Dg8MxK1yg3FUMZK0NDQCfgtvWO7zy2bfKJnIZf8tGDJSDAFIhc6sk
         SZUtnqp/26R3zCPADH8gi5IWKKYh/Un2M63DXlNIEf5fHKyhWGG+Kmn1Rkth2WgcBX73
         K6ZQ==
X-Forwarded-Encrypted: i=1; AL+hErH5MHnDgLqVVoSLmWt4nuAybsXqM4RXqM6fgIZsTqua+mfoxZFk2UBV5cxqQ6SA32GtSdY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VMOyxC3gG6u0M492Ewjny5aQEKUW2pQHFcn6yCvsdrZFPscTO
	NNUjEwulp33FShPalkETvm3yIjlPjIurVzogQK3ID3+/Wl1YpBjCRUadcNO0hzjPtRdWfVaeqrV
	/KkItaA==
X-Received: from pgme3-n1.prod.google.com ([2002:a05:6a02:6c83:10b0:cdc:b85b:3d46])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918f:b0:3eb:a4ae:3aa9
 with SMTP id adf61e73a8af0-3f190086a4cmr3473914637.63.1794336783796; Tue, 10
 Nov 2026 10:53:03 -0800 (PST)
Date: Tue, 10 Nov 2026 10:53:03 -0800
In-Reply-To: <CAEvNRgGHUL4-KSMCsOHznKK3fpvwh=D-H7OwSaqk2A2T0nL6ww@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105-tdx-selftests-v16-18-2024e8fa517a@google.com>
 <20261106164732.3939387-1-seanjc@google.com> <CAEvNRgGHUL4-KSMCsOHznKK3fpvwh=D-H7OwSaqk2A2T0nL6ww@mail.gmail.com>
Message-ID: <avNoDzycqd3PN9gE@seanjc-mac.roam.internal>
Subject: Re: [PATCH v16.1] KVM: selftests: Add support for TDX ucalls, via TDVMCALL_REPORT_FATAL_ERROR
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sagi Shahar <sagis@google.com>, Lisa Wang <wyihan@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 09, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> >
> > [...snip...]
> >
> > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> > index d41a1efc8a63..9982aaaba885 100644
> > --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> > +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> > @@ -4,6 +4,13 @@
> >
> >  #include <linux/types.h>
> >
> > +/* TDX hypercall Leaf IDs */
> > +#define TDVMCALL_GET_TD_VM_CALL_INFO		0x10000
> > +#define TDVMCALL_MAP_GPA			0x10001
> > +#define TDVMCALL_GET_QUOTE			0x10002
> > +#define TDVMCALL_REPORT_FATAL_ERROR		0x10003
> > +#define TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT	0x10004
> > +
> 
> No objection, just surprised you'd add all the others that aren't used
> in this patch.

It's nice to have, e.g. provides additional context to help understand what types
of things TDVMCALL does "natively.  And I almost always do lookups for things like
this and MSR indices using kernel headers, e.g. versus trying to hunt through a
PDF (assuming I even have or know the "right" PDF). 
