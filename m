Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735EC43D4EA
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491131; cv=none; b=ZwCu0XWiBIQU7nL5QLDA08UBmQyHH3p0DevJb8CK4coknhw/HMpjQrXVnfierrHefih1mewVgU+QvsYYeXlw5GyDMbzfcyup38MjIUGBlQCjfNTAl9J+B6CYHZcKfz/H2VZ5f9G6mIpkJ1h2r0McgKG9U/5muJUJbHcsf5GvRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491131; c=relaxed/simple;
	bh=9P1N+U6tAgbtQxQdGe0alY4blfHZ8OoTYWLTIWDTarY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jSiDuvHG312YEdcnNuqsLOB03mo/K4Fufc9Z1O0KOh6BlHRUMosBeeDyuv0ptn7vcAgQ7CXI5TKaqKHaw4gAOs86UPtTJK4DKhcCAgyT+t5jB1Kk6gI/sOwoFsB+YoGGKJffD9V/zfRY5AypxPKBmOf+bH3CE3vGIrBU1rq8qjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pgnlOoFj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pgnlOoFj"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b7c55406bso5078471a91.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780491130; x=1781095930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9P1N+U6tAgbtQxQdGe0alY4blfHZ8OoTYWLTIWDTarY=;
        b=pgnlOoFjehs7kHcq6bXghQWAkH4Rp8p0FyhciNOp2fZn5XVNg81AuHh2tDUdu6zPrL
         2wlOZOi3wf2QfCv3KundyOVd5xCA9Q6++7wcSBQ0dzLn0HGcEHHBdkz8i7F/D3Py3OE7
         jW65fkW5RcbNcdEgPp/trfm1wvTohUGvyAfeWTt4zuxfJt2y8CNxQf3JRxiWh7sr/fI5
         lhmzoiJ6oHhgx29p78me/Xrsbwh391Dn45q2sMY4JqnvkQiBveGl31dRC0406jNJizaU
         ZjjtTnTrcbULvuttY11TQ3V97nrxWJlJGsTFFjXE0pNVH/AIEOeGQnQqPZrs26rEz7tt
         23UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780491130; x=1781095930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9P1N+U6tAgbtQxQdGe0alY4blfHZ8OoTYWLTIWDTarY=;
        b=JCZ/dIE2GBAVS8+7MmV88AYukoSDiLzqSSNeWXfLoO0ue+AopLuhtVXMvvaF6i2ciI
         0ZFb6Pn6n5+eYs+svgaPKwE8jzeze6g0ylQPTCreMq+yWRV/HvC2l5ej4LiGyE//SN3M
         SMH9cxVEDoipE8CI99DOn5EBL0nVKVcW9a65fyTu423xURAC1URMMEngeRYljVPDiPmi
         sdOanuZfrWlUnpQXrlBZhY0CF5ri8xewnjxfvJjmX6qYg+i7AVQAYLcWkB/3dSgOztzm
         PYhtEAVKT8EaP5P7mr9sMzYSqvo2jVi0YYu3jowTxEjRXuvvgUUYZChq3ivc1F4C0jfE
         RWRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+G42N5eJsCtilWDsSbeXgcH4KZO8XoCzg1uykZPpp1Dukw/E8yozCT9vj8KOMEbBGcX/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAMvaQyKgITThDWfP32U5sz+NPwNgTAx6H2cT1tSAB1MRNtxge
	yJuHMfSRYryp/9QMVhOwRufGDruERmE6zRFrJOnayVP5KkZ5nIGVtZdqHRVWNezXg3T1i0I9SaC
	6H8SUUQ==
X-Received: from pjtz16.prod.google.com ([2002:a17:90a:cb10:b0:36b:d2d9:a587])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51c2:b0:36b:b4a1:2939
 with SMTP id 98e67ed59e1d1-36e3237e151mr3428994a91.15.1780491129250; Wed, 03
 Jun 2026 05:52:09 -0700 (PDT)
Date: Wed, 3 Jun 2026 05:52:07 -0700
In-Reply-To: <CABgObfY8_vam2OfhPRrCx79ApK9er0SWVsToC0vLjHQNdmzQ_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529183549.1104619-1-pbonzini@redhat.com> <CABgObfY8_vam2OfhPRrCx79ApK9er0SWVsToC0vLjHQNdmzQ_w@mail.gmail.com>
Message-ID: <aiAjd_VgR2Q0D82V@google.com>
Subject: Re: [PATCH 00/24] KVM: x86: fix various GHCB issues
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, Paolo Bonzini wrote:
> I think patches 11-13 should also be included in 7.1.

+1.
