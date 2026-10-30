Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394745;
	b=MN1TlJxQDLB9oVehA289t55j50s8uw300sUkDJoP7+Tpw26OBihMy4bGkNYeYbycfWer
	 Tom7bfhVskkZuYrAUsci0kMvuoJsSGmA3b4YLksIA1mBgtpsMc81CqHKiHe6CE584hwlg
	 eOiytLtZrNVn6qmIpnZYJqKka7i6xrsmRKw163eyZWnRXlulODmuqVDfTrtW+fDHvuGVu
	 G+MSc1htdvwXL8ehrwTeZKY25UPeVgdyTgOTAICZaYfela+PzW/nzr0Y9ok17CoOhKJMc
	 SFJo6BIv5mqQpxQZIQuOk/K73Ep3LWvU95aMIk+4DQWuDh6ES3CRrG7eYwQ9Umj5fWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=FaBKDSZurFDBrV6Nw++HxcBhs9Np8w6Jcz9bdCkkKak=;
	b=DobSj4YbrRWvpK+nF1oQIXHCVh5OnHycDJ5ajiuYe0p68aU6bMvs+8Mjie7q9Sjd/wcm
	 KIJ6YQQpjQXtyWhe3sSG4sxvoJkuJU4e9xrxjNdalfkSvyL10OItq+IJmIdCkVlg5tgmS
	 p/niQl6SczzDL4G9hbLggg9k/uECHtVZKpZedUKtLzNUNDZAPsNg4sh6S4FH8pYD2YLD9
	 4V8ssBZKXG4CrwoMoQM67CAnxEdSLLslDnImI22UwwziEGhMYIrV5/XfprZIRkHMyBdkY
	 aKpy2j5vIsjhR5bjzI6QjWHRNQ0axU+GkxwFmx1SyHnlWHV9SGbFPsrfuPhUP5Ohg7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="a789mJP/";
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B0E606A31D
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9B0E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a789mJP/
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eb2437d752so16751545ad.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793394744; x=1793999544; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FaBKDSZurFDBrV6Nw++HxcBhs9Np8w6Jcz9bdCkkKak=;
        b=a789mJP/L010wTflRpqG+m0KAfDFeMS2dNFRgqrwWd6ACJMAZ72SCb5s2p5J0MbZxE
         0UVmA4ridzFKPfOnTB4MgsuXm9OIMpoYKIZXog2YlWOqfJkWIeB0Bye9iz0p47McN9Ly
         ovdtyeJOws6GdfjNkF7x/zU3ccQjbArWVXAN5qnuTH258+1j7bZJrUAAJ5w+gm4aqAc5
         ejlLb9I4Ts1KZZmW0wmDR/VO1A0H6cEJuUll8ndNMTMDrrm8UMeJB6q41wWknSRPJPJB
         yDw4vcwfW39iy+AZl0wW1P3QLTVRdqzyClkRA+GGWlwPLcpubB5u25vY92H3tRv4VC7i
         kZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394744; x=1793999544;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FaBKDSZurFDBrV6Nw++HxcBhs9Np8w6Jcz9bdCkkKak=;
        b=SnTdmMYM7OkyAci7//L/co66XuGxlpa1d9FpgxKIYVCxHAc37ylFIx0tRk0btOA8WI
         0FbCBtjnciQ06yCzx8kT+IwKsaLLasPsFU/u1RFJgsDVSEl6fYxJvFJ5SqISO5zCZYN7
         gSHVmoSYN9is2DGvI1AbR9/qZUmfBpxIZFgTsOD3blaCitANs07mzPrFP1bi+PFe+UyO
         wD6eKdAcGgA6S5ezjvkylrSR/vBJ/6bv1vbp4oGDWk9qKDG91Pk0qaifKe7OVtj2x3Aa
         84Qv2l95TWGrbmy4gTNmXQOHw3lMubf5uFOqueurJmhtwVz/omiTbxI7nM7BO0kJWa3N
         +ZqA==
X-Forwarded-Encrypted: i=1; AKwUvBwAQ4YS4DBere7PhmYTjab+8lyEFqEs9XbWIva5ph8mG4T1OPAbAjM2DSB0XW3JmcYRJ/0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIE+bVL95HMz4v+XJzCR5d9ERZHXjEY0QeuSrBJEXgIPbUUrk7b
	A53l1RWoG4EzuADaKvpg+jeqaFN5HJ6Xp7GQPqo7TvZXQCUmazd8aSZEXFfKNrZB047S0yGg2Ut
	WMjTZJA==
X-Received: from pjbgz11.prod.google.com ([2002:a17:90b:ecb:b0:3ab:2813:f1c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ec5:b0:3ac:a203:e0a5
 with SMTP id 98e67ed59e1d1-3ae897eb741mr3059575a91.11.1793394743896; Fri, 30
 Oct 2026 14:12:23 -0700 (PDT)
Date: Fri, 30 Oct 2026 14:12:23 -0700
In-Reply-To: <2026-10-30-1-daily-reply-0005-kvm-nested-ept-gva-6-18@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030103643.573356-1-doebel@amazon.de> <2026-10-30-1-daily-reply-0005-kvm-nested-ept-gva-6-18@kernel.org>
Message-ID: <auUINwzMTjKCrzZA@google.com>
Subject: Re: [PATCH 6.18.y 0/3] Backport nested EPT violation GVA bit fix
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	Bjoern Doebel <doebel@amazon.de>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 30, 2026, Sasha Levin wrote:
> > Backport of commit 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT
> > violation GVA_IS_VALID/GVA_TRANSLATED bits") to 6.18.y, with its two
> > dependencies.
> 
> KVM x86 opts out of stable by default (Documentation/process/maintainer-kvm-x86.rst),
> and none of the three commits carries Cc: stable or a Fixes: tag.
> 
> Bjoern, could you get Sean or Paolo to ack this series (and the matching
> 6.12.y one) on the thread? I will pick both up once they have.

I've seen them and they're on my todo list.  I'll try to look at them early next
week.
