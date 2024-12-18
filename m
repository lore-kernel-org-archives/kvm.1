Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE121FBEB7
	for <kvm@vger.kernel.org>; Wed, 18 Dec 2024 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734557872; cv=none; b=Kj6NhKQi3crpSi+ATcLmSaCPglvq9AONIDwURovQtU/az4CslMhEEJ/FGzXaxMi4HT/+NBripNLXR3nDZO/amzjCAwJOHzofQxUbJuJOYOK017MUjd0Oab8Rjw1Qp7DEAJjnaXCPHtRo0JExj0trcuuc56469wV4BGo1toOQosE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734557872; c=relaxed/simple;
	bh=Z0grQxxymEt0iej/U411Hr9y6+t0LNvaPALtibuXxHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mmfAB1n/kp9AqpB2b535FTXx63bPbTPTpY7RulWDh45IqXlUtg9zTDXug8kb7/NTs69hxVOQMGkyljFRriuAHD++1UkMKDcPmZ7egs+I/uPArVYYx1LdsyZ8Q6/dDNvQM7TnmjOyQmYrA7NwSVOwv3Vhdz35z/O749KF6LxrzzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GsAaOsg5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GsAaOsg5"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efc3292021so148695a91.1
        for <kvm@vger.kernel.org>; Wed, 18 Dec 2024 13:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734557870; x=1735162670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKW6RYDwVNOGp97UdIa1U2fUa+fRF37h4zaoaXCLjlE=;
        b=GsAaOsg5SJDGoRb3u3Z0EOZgr5eM3Uu2nLp/diyw4Gny9deiRjtPh5SBTzwocJfauM
         si7MHStnbRrmL4T9fC3yBIG1o/mpamZ+QcUnxpf+XfQiUemvvqwL4xfgHPu4QO2e4GM8
         IFF2tHRFCYWFe2rfku/97qD0tI4cvN/dBXjQ11Y87qBeFSp05dGQ/WOmseDNKwcBkcyF
         Gi/eWzlLeNcE8x9GJ8QvTMPt7i1kOz8TlmG4B43WtsPoHdK7v8juaydIbBIwLCyYV93R
         n/KMIHiUlNDi6NCNC3WNpJtKs+aziNEPmBHlNZpfy3B+YXkoEnsxG+c7O8KXThetq6AR
         rHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734557870; x=1735162670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKW6RYDwVNOGp97UdIa1U2fUa+fRF37h4zaoaXCLjlE=;
        b=lnPII/LYTgTwJbVp7/Qef4rKL8yXSrk1MRTH/OS7Uz0zGTNw3RfJ1K2EgmyZBTYu0i
         sDB4r3CoIcc1zN4SFDSjcs/XNuugC4gDIJeQlaQ/XDsNu7Lz4qssa/Ntb2nJm3N/QzYd
         rOEoe4hebUe4nEEO3BE/M+9Ys9pkdZztgNpuT+LEF6Mvvpv7Ya3QXx69B2ps3sEzWp9c
         ROQizXqfRtEtZXtG9bhZjrVUhMyDECtVN/UikWW1nAgjbvOzzIVM3jhV/8b14n33ieij
         uvadTroOCGiJGZR0+V85cg/tpt0hfdNxiKxDVAHRJMjsiLwBDWagogiQcdLUwcL84RvR
         sv7A==
X-Forwarded-Encrypted: i=1; AJvYcCVQcSAPY4coEcLqOheOA4hBMmvdOCGV/rmQmGWaY0utfjTJPlWU/lqcnHWoHDNYQB1UA40=@vger.kernel.org
X-Gm-Message-State: AOJu0YycYR/sxknqBsvz1OQVQnPZq8hb6SYKZbBIRYDwmFKCPSdkS+mp
	MwUFwUYqwuBppzwim9WwA731h4D+tMQWRKG4lXuqcU+bVSxuMZOQj99D3cSJ+DUzM2VtJ5ekjYy
	ctQ==
X-Google-Smtp-Source: AGHT+IGRqhtqkL9hKkzXjSkyFpptnWEVrJn395W/rGkd0x7zdgCLY+aBw2ILiLv84mQ9u5OCA+5V/nk9SSw=
X-Received: from pjbpa1.prod.google.com ([2002:a17:90b:2641:b0:2ea:5fc2:b503])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5252:b0:2ea:498d:809f
 with SMTP id 98e67ed59e1d1-2f443d45486mr1113117a91.26.1734557870279; Wed, 18
 Dec 2024 13:37:50 -0800 (PST)
Date: Wed, 18 Dec 2024 13:37:48 -0800
In-Reply-To: <5b5b12bdc8a653901f28c754fcdced9103ae5c27.camel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241214010721.2356923-1-seanjc@google.com> <20241214010721.2356923-6-seanjc@google.com>
 <5b5b12bdc8a653901f28c754fcdced9103ae5c27.camel@redhat.com>
Message-ID: <Z2NArA9PtR7OdIs6@google.com>
Subject: Re: [PATCH 05/20] KVM: selftests: Precisely track number of
 dirty/clear pages for each iteration
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Dec 17, 2024, Maxim Levitsky wrote:
> On Fri, 2024-12-13 at 17:07 -0800, Sean Christopherson wrote:
> > Track and print the number of dirty and clear pages for each iteration.
> > This provides parity between all log modes, and will allow collecting the
> > dirty ring multiple times per iteration without spamming the console.
> > 
> > Opportunistically drop the "Dirtied N pages" print, which is redundant
> > and wrong.  For the dirty ring testcase, the vCPU isn't guaranteed to
> > complete a loop.  And when the vCPU does complete a loot, there are no
> Typo
> > guarantees that it has *dirtied* that many pages; because the writes are
> > to random address, the vCPU may have written the same page over and over,
> > i.e. only dirtied one page.
> 
> Counting how many times a vCPU wrote is also a valid statistic
> 
> I think it would be the best to include it as well (e.g call it number of
> loops that vCPU did).

Heh, I originally had it that way, but dropped it because it didn't seem all that
interesting.  I'll add it back.
