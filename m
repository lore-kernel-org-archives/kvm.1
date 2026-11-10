Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342643;
	b=E27nAGMBXS4ue6qJv/W14ydRkd+PbYqWB/hYia/2UuBBjVu6t2dFbUXgSDy0OYkquHjR
	 RFoQn5W2eOVXn/U0eAbZbOrfBLrtInJaIQ/oekhPa6G4Cp91MbTZLpgXlX6PpILI0zzZh
	 zDfifi5cledpWfaD7lpkBQdfczG8p16kG14cNnHUGJ0SjPCr5RCKKGjaw8JoYj0ToufN1
	 zXPX1Ru1fB8fJgjKbZuoWLHxesmGwCcCsnvEF+CKvlr7jiLnzQxwTM5Mr7TVlL7DpFDFh
	 39BncgJLYdqqHfaLqewkdPsvHzjjvfLXV8U8Y3TF6iLlMNrSGZIh1QIDK5wqIwgZLCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342643;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=gjXaKiyZQPSwExAfhsrIhyKjre3uu8ziTpIkVVhFMVE=;
	b=0dxlKJAxaYSyvraqyzaSG6rUJYzF43031zji/LrJjsaiVcIuuLJuXfnDh7MPYB4f/NNT
	 Fg0NeRo0uagbg2Znum6+yE5a7vVJIRzWbt38q9GWFxsR1U25pafR2QhhvMBw6JWr508XK
	 p9/Ly+peoSqjkFQktKd9aBU8KImdmfZjsIpY5MQOFno1cBSdgGuAlkfOKRcfWTmM8vLz9
	 QlYlKsMB3iAEKzc4bKcuoqVRiq3AfixvAk6e5TA2aCcj/Lm7l7bUDNLy3yXxhlHUnDhE4
	 aV6Nd0BKpsU9WeDpn0Ku7zjJeSbZS3hfDnrxfINL9n0EZ4tSjBQFp5AhCsbu/3WMR1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UoOUfTg2;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE8F606A89D
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 20:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EE8F606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UoOUfTg2
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd3b9e70f88so2548574a12.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 12:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794342643; x=1794947443; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gjXaKiyZQPSwExAfhsrIhyKjre3uu8ziTpIkVVhFMVE=;
        b=UoOUfTg2yqPTh/qUZmSVUD+IwCw0OUgLMMD6LSka7zvDZKMO4le8vd+EJXFV1z9F7+
         tspzi3+o/OP9YwlQpanoHsvg4lS7RJDh3+3Y31DKVB6ZdGsFRD2aLvngRdSNC0aTilQ1
         JJ6hwru8FCtXQFwqZXSJRyQh0IrOtDRua38glQUhKp+83idHftkUwmoGr3J6LXRDVmmD
         /L1b7W73bevLJMCg06Y5cSZv41F9Qr/pPS2UUS9+cXmoedHik9V7rpAvRIKS1zwDRPM7
         7MMB9b2eRLPcvFR7WY6cQzs6Lgv+mIRsGgUGZa8Qau2Ae9E+0vmLTbZMDWEe7DJ0cVEF
         J3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342643; x=1794947443;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gjXaKiyZQPSwExAfhsrIhyKjre3uu8ziTpIkVVhFMVE=;
        b=DNSYzmxPNRC6z7ct069wbP3AmRt9C/QkZm5yNKLyGfl/dYbwIJ3yNhtnblJZll7L2V
         BleEtlfz3fyKxqSTaJhDgH5/y1gi6bV62vHdFm9qyC49tTAkHxqncsJraUzOkwQ1w2/q
         KWgCtNqhZLAT1FPrnEqwmhKXAriNDTV2tDcb062ZgEWKB1nu8HH6bFSWzF649hDElLjC
         +aHITTeeXHR0LxPgQZ2kba39U4FBYaz2mFu758qzZz9Fb2etgLI8IWYVvHMfO8XCKfbI
         D5rU082FLV2yV259ZvRnLaUkRw7AXEoZ59vdvTKkMDiP3ANl7PTWwcw91KV8EI8NyloX
         SGMw==
X-Gm-Message-State: APuU4Z8MocQZEPee4+raEPgPm83XLu0H3WriHCjIUO/zHasp7PDsbupZ
	3tXoJbDsKxR7YK5yE/tcQXJ9KIYYkhk65HG6FFpvITjhP76unn7otKHkc1esBEvgYsVAiEGC/PK
	ZprVhFw==
X-Received: from pjbsx15.prod.google.com ([2002:a17:90b:2ccf:b0:3b0:f7d8:3b91])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e8e:b0:3ac:ffb8:183b
 with SMTP id 98e67ed59e1d1-3b182f3e1e0mr113027a91.51.1794342642319; Tue, 10
 Nov 2026 12:30:42 -0800 (PST)
Date: Tue, 10 Nov 2026 12:30:41 -0800
In-Reply-To: <20261109210833.1250548-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109210833.1250548-1-dmatlack@google.com>
Message-ID: <avN-8S4iZKD6xRMu@seanjc-mac.roam.internal>
Subject: Re: [PATCH v3 0/5] vfio: selftests: Automatically detect the IOMMU mode
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Alex Williamson <alex@shazbot.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 09, 2026, David Matlack wrote:
> This series makes the VFIO selftests library automatically detect which
> IOMMU mode to use, rather than hardcoding iommufd as the default, and
> makes tests skip, rather than fail, when the IOMMU mode they need is not
> available. This was suggested by Sean while reviewing the KVM selftest
> irq_test [1].

...

> David Matlack (5):
>   vfio: selftests: Automatically detect the IOMMU mode in iommu_init()
>   vfio: selftests: Skip tests when the IOMMU mode is not available
>   vfio: selftests: Print the IOMMU modes when a requested mode can't be
>     used
>   KVM: selftests: Use VFIO selftests library to pick IOMMU mode in
>     irq_test
>   KVM: selftests: List the IOMMU modes in irq_test's help output

Thanks much, looks awesome!

Acked-by: Sean Christopherson <seanjc@google.com>
