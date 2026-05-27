Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14C22C0298
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779848015; cv=none; b=B/fTG63xfuh9Ngc/U4j5/m+Uz2My89TUVxoPi672GmvIy5MTeNt2ACuuVgQSWkYE1Xk08Mw6W2x0VwWvKJG9dby/YlEF+47Tbv8deJH1JGVXm26P98wV4UvGRJ5Oe7DRqM5Op/nxVwfBXlrNHejbGqeHaD54fpehs3KQcOW/XGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779848015; c=relaxed/simple;
	bh=RHEwAkAz2V6V9zfr/HgBS/OvGoBJ/qN1F+ze/BdS6nE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F65XRI0AyaQGyuTcaM5j2ZnD8qNmn7/UJdX+9fLogNPUkPcPRIsffZFeRL6xmKEfmuWjpsyIO/znxUWfnS1P/wOG6W/CZAdbO9xw1X3ULPDJ5JKycuH8+k/bvTNqr1h9cFI08zgZnKg7V32/MnijyjAO74vUFNRL9V/o4yCmd+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MV/nqFFk; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MV/nqFFk"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828659ecd4so4828259a12.0
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 19:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779848014; x=1780452814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VTxZMh05MvgaPgNky1AgRBpNAAN2GiJz4+x9R6ldL/A=;
        b=MV/nqFFkw0IpgQ3YMNia4WCK1OVCdwbji11PR9f6kuR4qXWIzPE3MFUk3Pcx6oOblQ
         9JQgveVG8gmVe+LraZaEI8Bo+ogeok0CsnBLgr11YXWYueaxrCzkM3ztGdMSriWDTE4T
         LZ1MUOeyIT7Ac2YWBzxNjP+aFkTo3VEwFwZGddwEKM1qcim2GmhOWbuHGOsS2qqQ4FgA
         hYwc+2Qf2iH8LzDYnHvWDOvMZLLidMp+EQKdJ59YV3s1JZabINtQcIXqYxw5FOn95dJP
         aTGraxmq5VzEFBV9TmiGzL6R9kmMhVLmffzlCv3XHH8GosAPpX4b/ZZVwJU1YCG9FUVl
         PrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779848014; x=1780452814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTxZMh05MvgaPgNky1AgRBpNAAN2GiJz4+x9R6ldL/A=;
        b=q90taLlTXoXapapUyRhPl9BDmmtcEqcKgVooIknheVzdTwjEF8SZY+csD2myLaYmFd
         jAnVVdflYyvuhOpAHJpHh7V5aYzfG89BFsbffFhkTQYnKMwfgGmxDFTEq5fQ1T3s8s3Q
         QfZ39QY2P5RIjIQkANrdtprVjrjhK9TDotRYggQpJvls6QSGzthJozoDdeKVvXCZ2N6M
         RfOG/WFZ74LHwrpLf35pOMDpbWsaBibIAq8BdbPWefV1vG5NBazAAk7CMbCHw/1+ATwl
         pWPFMz9CTK+AZZRH4fbaWKaN/fpwO23278DZNle10T9aI5oIZ+xk8XX+TZXiaev2ggxB
         taPg==
X-Forwarded-Encrypted: i=1; AFNElJ9YdM5MJvOqcp5+kA2ZPaFeKgwFkgsydFQrOHqd4sdJ8rr3BWXSxs+rZww7zyol5UPX1BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOaNSGAkb1Yt5v8FVBrLDf4DX22JHsirUMsXDoLWqf1ScIoPx
	kDj4Af80o8PrB9QLgVts8LsAj7Z5YxGaDQwipqhzvQcv9787O+/lygmJpZMRr1y3r3iD6krtAgj
	z/YVnWw==
X-Received: from plbkf6.prod.google.com ([2002:a17:903:5c6:b0:2be:3021:1a0f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e7:b0:2b2:67ca:5ff9
 with SMTP id d9443c01a7336-2beb026f4c4mr226655835ad.0.1779848013879; Tue, 26
 May 2026 19:13:33 -0700 (PDT)
Date: Tue, 26 May 2026 19:13:33 -0700
In-Reply-To: <20260421231557.1254270-13-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com> <20260421231557.1254270-13-jrhilke@google.com>
Message-ID: <ahZTTSEgpgJqvo1M@google.com>
Subject: Re: [PATCH v3 12/16] KVM: selftests: Verify non-postable IRQ remapping
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Josh Hilke wrote:
> -		for (j = 0; j < nr_vcpus; j++)
> +		for (j = 0; j < nr_vcpus; j++) {
>  			TEST_ASSERT(
>  				!SYNC_FROM_GUEST_AND_READ(vm, guest_received_irq[vcpus[j]->id]),
>  				"IRQ flag for vCPU %d not clear prior to test",
>  				vcpus[j]->id);
> +			TEST_ASSERT(

A very special kind of hell.

> +				!SYNC_FROM_GUEST_AND_READ(vm, guest_received_nmi[vcpus[j]->id]),

Add a macro for this one too?

> +				"NMI flag for vCPU %d not clear prior to test",
> +				vcpus[j]->id);
> +		}
