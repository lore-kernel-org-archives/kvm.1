Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244473;
	b=QRpnSXA4wEUWwiD4/P4PG1jWW1qxnA3m5Zw69qaHDzJRr78JMWxiarXriAj7zouIVS/6
	 BbZmPiqW1X4/T/Ez3BozqJg5npzs3ZROm8uh7tt+pf4aXiwWM8gnW9C2wySff2EObN6Yh
	 PcMi89gZgz2OHC75WeDBFjAj066NlVbw8QktzRg60Ek1Zd+2y4+i5FdnDk1pRkX5QX+m1
	 T+J9PHqhhINUxViphhasZdff/++F3XZsGpvYB3pcShu5amJkJ4c93LUjOtLLqlNk5E54B
	 o/VOrS4bDYp/rGjcgr6GoPZdK/gNl53GhoQnCWHthJZFF9Es+kWPC571WmBXL1pQo/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=8jtvppWK1r44koRv7kGc410EeXeuVJn2yevktxLuiSM=;
	b=XzrTgOnPvtyE6AJDUKmpI7ENasZGq7HF2smHJLLOF54my2jeaOKGu0LjuTblG0lBn2zQ
	 TkizMoZNQgLVIpto4HDlM7URNkW0N0KnmTACrZc5t1ZkrFMkjBQfUuvyS9i3speJ1y784
	 cEFTJP4agh3vez1zaZeOY68ThTWvTD2awRgf4+awGcITmIwkA2+aOvD3MihIgT1Wa6htK
	 p84BOnTmHGdOsqQMROTclrL2Cejw5MEM22V+tnjC+ItaBBDJqTt//r+GUs6c446jkc8P1
	 BrMaIJHqD48dpZEkDdZabDosZPNdENf6JPX1Fiz1niw5dfoPLx9VdicZiFCD7ReJdXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cfDEwHnA;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08434606A321
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 17:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08434606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cfDEwHnA
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b32efd7ec4so835050b3a.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 09:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794244472; x=1794849272; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8jtvppWK1r44koRv7kGc410EeXeuVJn2yevktxLuiSM=;
        b=cfDEwHnAjkjINNuQSEBYfr0VIaSnYuojPe6iCL31rE0vyVH5GIT2jhbSgw8IDBC78e
         wIlcf6SwizR1c1qu3vw2OYVzKuIo52iHw4FnsT37VFxdZWCPURCQXMcEhfdFz+E/u5F1
         2xnGoTxB6pLW9nPiLT4XN+8NzE34TkcSNrqWb25HTRAT4Q0NOzrb4nPWEQivO6uvaN7X
         ecHZzVDFEYTGF/opFS0vjbueL7N2WqIRseAx9W1t8JWNYSq8JXYQibM64QfPx1f3n+A9
         wQ4zQAMAbiLBWGkMrrE6ApMlGXh1xG39Ai8yHnOCiNYhjwNX9Ye/a/UZSoWINnr5mO0f
         8/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244472; x=1794849272;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8jtvppWK1r44koRv7kGc410EeXeuVJn2yevktxLuiSM=;
        b=ZX5xifYOII0iwsSm3Fjsf+vgLM7Pv4BrbWCvm3hl8fxBh8YEIRjFriWPbFThuQ19l8
         JYWyWxspoJbCyYmXZdj4Q4kcO6aj5jIxTtpnhb+qbGdklGqB0GuepP4oAdS54ae7OFXe
         cUWlFwC7SyrAK4+iDhzzhRZLUV7ivJ8zw2cK/hNKcDxYfI+SYLMRQlM49vMd4DBK+HRw
         qh6BkED82+GHNehhE5IlqLx7qWm7Hnp+bFdRry/Pn/QBhULQnSIC4vbLUzpl0RXe4SSv
         j29V9WIb4rhl4pUDbHsYpfDCje+/6hRzYysS+D7SMYnQlfOQIx3C4Tgh8DlCLynDjfOe
         6Q4Q==
X-Forwarded-Encrypted: i=1; AL+hErH8IkvG/A/zEmYYnso+dBUwyZ4149enzKMukIpCWba7ZUdDrEVerPjZBHGWFLwSRmRtvOA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QtPjN+43+XnnplJZazy3pwVf6E8iKrCfJ6x9/beSD33mFvKTs
	vkeXRGhYEjoYVBECGO8YKP5OiQ50ovZx9pHRsSLwP9n9ITC4oldgAKoGMOb1qQDZ/3uZeQPtiSh
	RY2Socg==
X-Received: from pgac19.prod.google.com ([2002:a05:6a02:2953:b0:cdb:932c:948b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:8b0f:b0:3e1:1e99:9463
 with SMTP id adf61e73a8af0-3eed2b02236mr5016786637.38.1794244472001; Mon, 09
 Nov 2026 09:14:32 -0800 (PST)
Date: Mon, 9 Nov 2026 17:14:31 +0000
In-Reply-To: <avFfFqotCajjCzTf@stanley.mountain>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <dab486f129c36ba1cfb322ceb56ec6fdef020ca3.1793959700.git.dan@cryspen.com>
 <avFfFqotCajjCzTf@stanley.mountain>
Message-ID: <avH_dx3-8qshOXvT@google.com>
Subject: Re: [PATCH] KVM: nVMX: Prevent potential user space corruption
From: Sean Christopherson <seanjc@google.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Karthik Bhargavan <karthik@pereq.eu>, "=?utf-8?Q?Cl=C3=A9ment?= Blaudeau" <clement@cryspen.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 09, 2026, Dan Carpenter wrote:
> Oops.  I sent this from the wrong mailbox so the From: header doesn't
> match.  I'll resend.

No need to resend, already posted: https://lore.kernel.org/all/20261022021820.298886-2-seanjc@google.com
