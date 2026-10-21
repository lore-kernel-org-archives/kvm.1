Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792558676;
	b=v/s8nlQ2TJn2q7flqlEKBNzwiuluA2HV5NyCPoY3gvFtwdLps9I4qgIrKtePDIwIfnNz
	 v6BOgfrHWIoa/ruIuCKiQ1MCeWDB1lSjyEdCQKfERDlQV1UxtW/euskns8P/2q4jL0dvO
	 hwDXC0fNaxGnNgwU3/0pS2SdNr9madDngb7XTKaqOQs3Affjbvl3HuNCWqs0cY7b3hsQ/
	 ZMqarrq/tdc9WJHATd6GbRZgerW86xmxVrDXDijVV5NWZ66/MyDdpzqS1WyoZAVZm88lV
	 flIXGoMF5szFvfEHm9fVml3aDREXhD6NwbNlFGpP2SCZ6rAvpP4UJQ/nbwtWw/wI2eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792558676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=eDGFI2IEadNgqQFug4AHiz1l4wqWmmt7PhVcyHvgfsE=;
	b=ZMgvMP6H0KpVrIPIaiBU+B5dM4XEHiugYPpFkuFMrbLhxvvkdJ0VkOnDcPnmB+wYXQGT
	 dJFHTjeGPZb2imsvJXc04saruvYRFMK+ogasax8jVQ39k3sQJ/OxevScAPf0V27kgljd4
	 lKZ05AScdlEAe/ClV+Isq+SyV8s88vdBLPmywgKPzg0geEynPb9XCNBf7IKY6EQu7RXCH
	 n1YOXsX/qzqXVEgFuGEfxHqBTX8suXVR7nsoDCDFksji1NVTg2UK9MuRskFb89mFo0RS1
	 VReJF96V3M989u7caXmMy5EqcnvkYAWsX/uK6Q5LrGoifwPpuJiWs4Abm8fcIeL6wNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ct319Ehg;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD16606A31F
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 04:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD16606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ct319Ehg
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e80f7acc67so3378125ad.2
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 21:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792558676; x=1793163476; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eDGFI2IEadNgqQFug4AHiz1l4wqWmmt7PhVcyHvgfsE=;
        b=ct319Ehg3lL6sMr8u+OlHxNUrxTeysyqD0Um7paTUw5D7k8aPynY0H2uQ3rRbk8sqQ
         15P/Wg8149kS14ainieBK/ZKn/EsVloQwCqnx68FbVxPeeaWx0Rbaqi6Ddn3P52plhYL
         IRYNN7HtyyBrLL71VvYeaVhsJYM1lkPoRnjnVLs+tG93ullclSJaji9eD5V6ubXRzNMT
         9le5M3QC8b5zx+4+u94ho6HMqrGYGtxRdCnEpDS7uVURf59HNUq7lw1YCi8DpzJXPG9P
         puyz6fESr1Oi1GysOT64JMY3dMC8WQwv3QuLd6EZLWTTs0j490cJ4MRKU8NpPL05kctv
         6IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792558676; x=1793163476;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eDGFI2IEadNgqQFug4AHiz1l4wqWmmt7PhVcyHvgfsE=;
        b=ydr9KGKDqTeEmrHoRFQNGOfS1jSo6VrSFAiZZh0GqbIRe17a37lBIGZMClOtdznEac
         EVrQFZ1skV5xddAHLznuDxYIIhqdi1dFj/RCmXfc2j8IbXBp9cNhWS9n6LlZWR4C8A2a
         zGCkTqJ0nb5a0WQsK125Zx8TbIHlD2Ox62NK/854F7VnB+Yr3+WD/4+xnvlBuW7Pf7bU
         rX1/l3WguudRM1O5/I7PTDh0gG+D+XB0lvdWUkkuh9fAI/XJZJ4B3EJDtMK3Su/+CCmP
         qyDbS+ua9z2L98ggIWV9MoemG8m9lhgF0obMAMUnMCS81K1GAPdoUy8l2pLYwg1Ql9q+
         vmQg==
X-Forwarded-Encrypted: i=1; AKwUvBzBl4VY3ew4H+DsxxMY+B7HUTOmjHLQNUZTMW9NUKv1763dJqMxv87on3vsLmo3VXrxtdE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcucS2cqFaZxvKRyWi3iQAdvd/OEASmkyzrYBpWkTbq5DV9wMI
	Hrf+F3WZOLT1Upz41KeUuVRkKj8YXdQf8emcDCx08hPIsxPqu1k6/J4bub9/PhbKhfHcvYncghn
	IMKhxMw==
X-Received: from pjbbd18.prod.google.com ([2002:a17:90b:b92:b0:3aa:ff61:94cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fc2:b0:3ac:7378:be04
 with SMTP id 98e67ed59e1d1-3ad86a44fc6mr962610a91.0.1792558674143; Tue, 20
 Oct 2026 21:57:54 -0700 (PDT)
Date: Tue, 20 Oct 2026 21:57:53 -0700
In-Reply-To: <20261020131447.122096-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020131447.122096-1-pbonzini@redhat.com>
Message-ID: <athGUdkDw6rSatUW@google.com>
Subject: Re: [PATCH 0/3] KVM: Kconfig fixes for the VM-wide private memory attribute
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Fuad Tabba <tabba@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Shivank Garg <shivankg@amd.com>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 20, 2026, Paolo Bonzini wrote:
> A late review of the guest_memfd attributes changes...
> 
> With Linux 7.4 the "private" memory attribute was moved from the VM
> to the individual guest_memfd file descriptor.  The old semantics are
> available for backwards compatibility via CONFIG_KVM_VM_MEMORY_ATTRIBUTES,
> and disabled by default.
> 
> This change has two problems: first, it ties support for VM memory
> attributes entirely to a backwards compatibility symbol for distros.
> Second, it is incompatible with all released versions of QEMU (and
> perhaps most other VMMs?), thus the default is arguably not the
> right one.

I was hoping we could go with a stick approach, but given how painful double-allocating
is, hopefully a carrot will work too. :-)
