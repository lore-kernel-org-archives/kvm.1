Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ADF3A641B
	for <kvm@vger.kernel.org>; Tue, 24 Feb 2026 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955414; cv=none; b=BR1J2ivCQRYVkCUWKg7BJZ6msPB3dVzD4HmbB8paG8iCcCFItmIp8KNBp4NeqE11exb4SxtSqt/7KYYn/aV5+jih1yPaJ5G4DqHGpGE+g4GbJ58usuo9b7xG8Zn3z56O5cqCgkWj6vEXO1UqeddOWN1441uGlhe10yopd/WLz2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955414; c=relaxed/simple;
	bh=Rqe+DV0JGKG3N5xInoIymTuwjlGQzgFPyP40I1T9dtw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JTfUhXmHguwIG6hoiLwX3DFe414xCz9qtDBefjDSRiDCNqxYcIME3tUJH5an2k17tLR1XXDiV2JB394lX8n4Jik9bNFEDjZm6SUcdnRdZSeAkd3HIpfBFUAv2bLuljpXg0drQ3pIJGxG9jn1x0t1BRdr3VZCB2p0htN0QzNkwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1RhcQ5x; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1RhcQ5x"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354e7e705e3so4107630a91.1
        for <kvm@vger.kernel.org>; Tue, 24 Feb 2026 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771955413; x=1772560213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xP2Yvk9LjV+314PihNF72RJZub6L9XofR0CT5YjYokY=;
        b=U1RhcQ5x55v9QNuYquBGsCyq67CDbyHxGb7lkVIeCOebYHaTUDSW8El+oH6qMb/l+C
         1Yb3rALrVIUwq8w5/KeO4qMLzcdflqSdoX8mn42Xk8MhmWjc2/e7hy+4kbXy60nPo1Q8
         us3F3rdQVRBwNHcvLoQHkF9MaEG2IxDSiYFN2fNDzzTdLE0J8UhlZdFa1JXbUpgZ+SUY
         YG+zHgqXzP61y5dcExGnruMlZuDOc8QUY0KOnnUtnswRrWV4IMhKL2tzlTZz4jPwXl/Q
         zEv42As3513ephlZflJyHtRnswgX0YnbC1o1iW+9o1p82cqyF+7L1NzR3u5dKc3sg0gA
         39NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771955413; x=1772560213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xP2Yvk9LjV+314PihNF72RJZub6L9XofR0CT5YjYokY=;
        b=sl0BHDVjk/Ba4vxQVRJkci+JNeLBubdBCL8rDpGhTHTxZkkvrQssJis4qn/ONozfo3
         7fm8jQvcjgEOTb8tKHnrGZoJF2HFy1XrEMfD9k3VsIWaLUGZWQMFgkuKCXt4w6YfyJtu
         owvaO9WQ9kta7Oyje2zj5TWQ4Udq8Mbua547qhyvfilDXBCh9BP1/7CaJybgrd9VE9Sf
         1g/VaDF0q1B2eTeHXR+ZrRWxgobQ/thJuq/uOXGvEe4kB7ss6sdoCTEIHR+INTHOj1B5
         btLmLdxO6A7XDGWCDKUKPtd8Ic+Crjq4Qht/Xq7ot5+MSWSQrUGcnVPb2d2n1EZjw+th
         PU3A==
X-Forwarded-Encrypted: i=1; AJvYcCXak3aFVf228t5OyS6Mug2h/34iVPnm36E2ooErT472Ii1Ep6TvZtpn6rnMyqWKr500Bns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPvNJ4xOQ2o3592xE3WM327hal5ZVohX6n85VeCmA+yhY4/qag
	Sa8nq4VC14/AMQY4+KFEreri+fAoi87KoidMb/Cx1nshwGvjdcwictPeKfytD8fjB5JAnyQ5gYT
	vNAeATg==
X-Received: from pjbgi15.prod.google.com ([2002:a17:90b:110f:b0:358:f878:1918])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:56c5:b0:356:79eb:5b42
 with SMTP id 98e67ed59e1d1-358ae8dc012mr11249203a91.32.1771955412533; Tue, 24
 Feb 2026 09:50:12 -0800 (PST)
Date: Tue, 24 Feb 2026 09:50:11 -0800
In-Reply-To: <aZzRVXp_E3cMcgtX@tycho.pizza>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260223162900.772669-1-tycho@kernel.org> <20260223162900.772669-4-tycho@kernel.org>
 <aZyC89v9JAVEPeLt@google.com> <aZzRVXp_E3cMcgtX@tycho.pizza>
Message-ID: <aZ3k01UObX03Sv-n@google.com>
Subject: Re: [PATCH 3/4] crypto/ccp: support setting RAPL_DIS in SNP_INIT_EX
From: Sean Christopherson <seanjc@google.com>
To: Tycho Andersen <tycho@kernel.org>
Cc: Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 23, 2026, Tycho Andersen wrote:
> On Mon, Feb 23, 2026 at 08:40:19AM -0800, Sean Christopherson wrote:
> > On Mon, Feb 23, 2026, Tycho Andersen wrote:
> > > From: "Tycho Andersen (AMD)" <tycho@kernel.org>
> > > 
> > > The kernel allows setting the RAPL_DIS policy bit, but had no way to set
> > 
> > Please actually say what RAPL_DIS is and does, and explain why this is the
> > correct approach.  I genuinely have no idea what the impact of this patch is,
> > (beyond disabling something, obviously).
> 
> Sure, the easiest thing is probably to quote the firmware PDF:
> 
>     Some processors support the Running Average Power Limit (RAPL)
>     feature which provides information about power utilization of
>     software. RAPL can be disabled using the RAPL_DIS flag in
>     SNP_INIT_EX to disable RAPL while SNP firmware is in the INIT
>     state. Guests may require that RAPL is disabled by using the
>     POLICY.RAPL_DIS guest policy flag.

Ah, I assume this about disabling RAPL to mitigate a potential side channel?  If
so, please call that out in the changelog.

And does this disable RAPL for _everything_?  Or does it just disable RAPL for
SNP VMs?  If it's the former, then burying this in drivers/crypto/ccp/sev-dev.c
feels wrong.
