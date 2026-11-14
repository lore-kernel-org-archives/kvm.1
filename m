Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672020;
	b=UJ0HYxZzQZd7Xgsdu9MTu5oYOvHscD4TOEX7tIKjeoprdLN17PprlU67N9svUX/OyoXA
	 yBoLVx9ej3xZ5VgqbGu6oU+sme2xcxCRbOgt0tZ15U89a1mMatXEhkBIZYdLCMUezIZ7d
	 IPUw1zGab5k6Hh7hEjq5O4pYEPPLiNZywJEYMrXSBPxqSMOMuTcB8O3g+2OdhZl8AEXNF
	 iW81KsSTEtgL9Fr/RucjJIPaL4N9McIQsKZhDksIwp//2IVwd4VbeItmeYZovozeIGLVA
	 iFnVEzXiA+dvCvcieADZ4zhdsu5a76mcX9EQAxH+hUGIMyO7ni2tYYv0EuVW/eMLnAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Kg20Kcq4DONDreUespWCLfRZx8NkluUtIwqVtwf2l0o=;
	b=UBfFGkicrHnzJKe+ekxlvMkrt4ZCEC1S+zWPhi3OJSIAam1Dgy/ni1NeMsgeoMqde5Hk
	 Se6cUGl7Hs4YjVpaCRxL5ZJDKFXD0o2VjkATZXQHV+pkPNAaFQtOFbwqf3lDK4R2Di98Q
	 2NLbzVbQ9ASecBF7hPkPIfQDZNtk4/+bP3FaSxE0oPFXm30hhxt4LHP8lz6lVhoRk0ydG
	 /guJTpRv7anL5/Q0rQjfg6luOL+Fmc7/ixWJoDZarCFtOA+VssX2lbjNW6HY91h98Uyet
	 gmGUCU7+kYX2jYWJ9Ac3YfDALcPiXOhIEvfL+3mx5XI4QY8MyQq1Tp18gy5L1naNmrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ks0VXGCO;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8906E606A323
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 16:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8906E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ks0VXGCO
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b18165dc53so2911945a91.3
        for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 08:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794672020; x=1795276820; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kg20Kcq4DONDreUespWCLfRZx8NkluUtIwqVtwf2l0o=;
        b=Ks0VXGCORA53TJ2tFGTPVAAzwzbMp9tmVvdwNfXkpULdwFM817VhNxmRwMZG4hjbg2
         gUPqSQiUQjZgOCdnNZzp32YBJIuuDimc0fgqBr7QrDuBLpIxXVYJnRGNDjcB6KlkimAV
         ecvTq3F2Fm++dBxWlKAHfIOKf6TRC1sR1nA3bdH5lOJzbc7hLQrDYZciGucGQh1NNFgg
         s0sM3HWkABH/Z2x1+tZ6JqRRywh0TXEYYqQr+GhpcpNQTRKKzUjoa583uJkmKCb7j3dG
         lSfKVkMKc5sApcUzarO92FstHB+v/sm7Zo74sgBYqNs4/JnO+nW78rrzRBWGQw/eazFb
         O13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672020; x=1795276820;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kg20Kcq4DONDreUespWCLfRZx8NkluUtIwqVtwf2l0o=;
        b=0TxZfKL9g+QmxOmjcDZQNtDMd8sF1VQbNnqqP36Px0vWRQANJXjVgdbvlMBQcwZGo1
         iewJmzE3OxrfMwkOiykrOrpTvubdUIOt8shlw/rC7aH6gYPxfEVprqEr2JltsuJwko8b
         3QMMZLO1dJU0XX3JfkIhcLEHHeGBZHpUWKpFtgIOYwDBpNGsF74+Sk0ql8s1GSuohFn6
         aoNlgQd31aqKXEMbWVwRiinRMJsSY0oZVPczE0Kbyvsu0Tt+qyKPDH0VBg/LpQmmjCve
         NQAVaL9rr47YKSFLOV8hM9dQRrAzYyfzrSAOLFaQXFBqi9IW3U2MbyZ6JLqFb4jt9qz2
         IniQ==
X-Gm-Message-State: APuU4Z+ISjzRkTsqsP2OS4D0OBQhKkbf825cPa7EocacQbpIdO7s53Ko
	RP8M4/ttoLSEHbBi4qw5liUFlAMJaKdLflEGbgYXcmyukzZ6zgqClsujm4ZENqoEuUIHqvMG77H
	ZN0Cf2A==
X-Received: from ploz22.prod.google.com ([2002:a17:902:8f96:b0:2ed:54b5:6689])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d87:b0:3ab:2737:3395
 with SMTP id 98e67ed59e1d1-3b1b0a3a2f9mr5467347a91.42.1794672019614; Sat, 14
 Nov 2026 08:00:19 -0800 (PST)
Date: Sat, 14 Nov 2026 08:00:18 -0800
In-Reply-To: <CAFD16ODkmQBbtCgR5iKB_xwXyCMhg=JE2dgXVULNsQMvHMYx+w@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <CAFD16ODkmQBbtCgR5iKB_xwXyCMhg=JE2dgXVULNsQMvHMYx+w@mail.gmail.com>
Message-ID: <aviFkm8685qfavwp@google.com>
Subject: Re: [PATCH] KVM: x86: Rebuild nested TDP shadows from L1's memory
 after INVEPT and nSVM TLB flushes
From: Sean Christopherson <seanjc@google.com>
To: Diptanu Choudhury <diptanu@tensorlake.ai>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 13, 2026, Diptanu Choudhury wrote:
> KVM keeps shadow copies of L1's nested EPT (nVMX) and NPT (nSVM) tables,
> which it keeps in sync by write-protecting the guest pages it shadows:
> vCPU writes to those pages fault, and emulated writes notify the shadow
> MMU via kvm_page_track_write().  Writes from host userspace into guest
> memory reach none of that: a VMM completing a virtio request, or any
> vhost-user backend, writes through the memslot's userspace mapping
> without ever touching write tracking.  A device write that lands on a
> page L1 uses as a page table therefore leaves KVM's shadow of that page
> stale.

...

> + * Host writes to L1's nested NPT tables must become visible to L2 after L1
> + * requests a TLB_CONTROL flush at VMRUN.

NAK.  This is not supported and has never worked.  Maybe after the onslaught of
AI vulnerabilities slows down we can consider supporting (virtual) DMA modifications
to guest PTEs.  Maybe.  But right now, absolutely not.
