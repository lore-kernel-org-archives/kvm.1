Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A09382385
	for <kvm@vger.kernel.org>; Sun, 30 Aug 2026 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788114553; cv=none; b=CQUdap5a/I9/Dt2lyQpMgsilTxIvfbthddY5vrrUdiR6ZQEx2cZ4qHFS3hzzjc7Q/Oh4HjAvPAsYm31xu/psnC/9N9moWp/7xf5sQjq4WBTYffO4sdFMJ15XCH9U4JjZbzN78AeJlbcbhYPoXS4Etv1i9k2Q6xifqEqLI/psMdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788114553; c=relaxed/simple;
	bh=9NKDnSEWfPvKPtUsA/Wf/uYwNlKYFsZ8Y0VhVrZy9KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8CFSCYOfk0NBnlltu5AHtD7BRlWKZnb2ILcrHn6v4brqB3l/X9GMsoCXyh/ZRgu/+cV/9AOEKqHJZK3/TB0f8o7ISPbP6OcDoY1ldN0yDOX0AxSdki8P5+QQTAiHsawiayNlXpAlX9PK5CaBrdfDrJKXedKoIf2ubKQzyIgWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYkHBna8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYkHBna8"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso26142345e9.0
        for <kvm@vger.kernel.org>; Sun, 30 Aug 2026 11:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788114550; x=1788719350; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Ptf7lkzRK2cEQa7tXSLbtyDvUDpbM17dkTmOc5wvcM=;
        b=NYkHBna84dMwXwcWaO6eUatLipedsBp/SSvLivwWHR2urS2QxlcpIo5ptWpFS+ulgX
         ZeZ/PEnrCltO/iLCv6gP3Amw3B807ZN+kCHB5sbIi5VyzeTKGP3RjL+Ksp9j4zaN0O2D
         DI71T2BWqdDJzNbFjgHudIytYWLTJphGx9Vrpejd/h/BV1YqV8DF4fBh8NVPWfQTfqZj
         ajix9JtxC5p/D+61A3txbAEeLsKTwfH1bm9oB9Pa24BxJjmYJpMTkVLmdFFvmsWeo9oa
         mG6lIIuQ+ii2gckr2FTUjlX178q8EXDejGc/XITj91+9WemyZDdkluIYnylK4s5b5VSJ
         OWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788114550; x=1788719350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3Ptf7lkzRK2cEQa7tXSLbtyDvUDpbM17dkTmOc5wvcM=;
        b=oHtyXRzFSXZ+DA+5TndRJbypSc+ILH/GrlWym6OKKOooDh38Rgi0Vt+Pd0FPwWTBuR
         QhH1SIiqj4brMpT4Ot682r+584m/JVriojeZP9xh78DGt9avUy+FGiZHI0jpLKtKTBiq
         3xlJICFXoszlxfWfDV14XY77S0/6iFDLZsI+cTaKi4a1KvhEs/gJdRMfxUvgXoHEy5h/
         JV0uJoYf6z7UKWqQbEwZx2qq69RkayKEbXqZ3pZoYSYSh42tqLyVo9wLUmwmz6b51C5g
         YCk/TRoeHV8v0Z+PaZpPi57MeUPmH4fBtot4T4k2wQqI2mCbuFWe29+5LoDb2VJ45E/C
         5nBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqr95M//pD/4MINORK9QhBwzJKlZoQWG+mOqCGRzUJtD0+zD+6h8J1s9SArmcrl4rT+RWE=@vger.kernel.org
X-Gm-Message-State: AFuF++m0ThVlfAjxeE/ZmlShcv/g/s6Kr27KDPXZq80WniZfta/5iQe/
	TFAmtFU6YxZ1Q5UQyJ/AtR9PzVHvJleO0CIUumi0r4XU89CWzo9scwtP
X-Gm-Gg: AR+sD10OF15eVm4mugM3e1FAJsoiuvttjvp0uq3Sg0xJTv0VBxprTCuav6bRTJsrPUV
	sjGkvUNF3n2vtSIhLt/UPvPuNDC/LoYcdGVUt4YemD45/46N7j2AuRu+h+VrjRHwRU4kUCGbupE
	4+T4p+Ql7IBt4Yc0wdSx/d2husvWovNRaK3WTUI0Cp6/v9wk8zdhvFPwXOG0VTJlVEDUfyNG7Ke
	DXhqky+KUSAVDIkmQLRtAGPIvBUlaFBCQv1Czg6KkX5yqtG7EThGUgSq8C01YAqQDkfInPC6jh/
	U0k6SbN9ibysqSk8sypidyxc647ew/1ZMhLP2XpqzIjkjHF0xG+5eBTxniFhUyZs1di6mRxMp3f
	6BJzXPMRhIfSXwnuI2whkxyg4HLWaDokah40JFOqnOz2SjeWbZJSN7fDkwFKXGAzvwdm1ZOSZtn
	qJ3igF6koJbKGiiagvM3MCQak/5tQMoKv4Zxxkyknqazj9d2DTZoJgyGImsbBxASRqyAIhEUQgI
	IaVyhrvn2PL7MOjVv4lkwK4nvW3qrd7EmJn0XQ3A/6EmpKpB7w36xq5gdCsKBF3NRCdJ9uFV+Px
	xWypCi9m4IPIzPB8QM4c0G0manIrvLAshp2+3x1J4senesDNVCDGQhcCFB9PORXZLV9UN5MZ2Nl
	l2iTUhy0fJjE=
X-Received: by 2002:a05:600c:4744:b0:499:8b13:3a98 with SMTP id 5b1f17b1804b1-49b91c2479amr317299235e9.4.1788114549893;
        Sun, 30 Aug 2026 11:29:09 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-adda-dc01-edc7-8a6f-c6f3-73e0.310.pool.telefonica.de. [2a02:3100:adda:dc01:edc7:8a6f:c6f3:73e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b961939ddsm102089915e9.4.2026.08.30.11.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 11:29:09 -0700 (PDT)
Date: Sun, 30 Aug 2026 20:29:07 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/5] KVM: arm64: fix VGICv3 redistributor rollback
Message-ID: <apR2SFrwBa9tCS5y@gmail.com>
References: <20260822095346.53882-1-kmehltretter@gmail.com>
 <87zey4m2qy.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zey4m2qy.wl-maz@kernel.org>

On Sun, Aug 30, 2026 at 09:28:05AM +0100, Marc Zyngier wrote:
> I really don't understand why this is such a massive departure from
> v2, which was pretty close to what I wanted to see.
> 
> Honestly, you are making things harder for everyone by over-designing
> (or more probably under-filtering) things that should be *fixes*, and
> just that.
> 
> If you want to rework all of the vgic init/destroy, fine by me. Do
> that as a separate series. But for fixes that carry a Cc stable and
> require backporting to 6 year old kernels, that's not on.
> 
> The hack below is what I have against your v2 to make it acceptable.

Okay, thanks. I’ll adapt your suggestion and send a much more minimal v4.

Karl
