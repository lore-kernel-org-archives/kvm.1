Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA21B3BB100
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803133; cv=none; b=t0ECekf/GH0bB3UI+/KShrjm2tt+87MBrjxRuQ39azLz9isfjsZ+1C5ciMOoeFb+p38j5f7MbdEMWfEIgALolNYWOR5VcMlEoGvPSPFLMWZpGs6alvwsrkU6gf0QhdsisFpYqnqCpVU84s3GyJVvXeNg3HEWaWgrwm487nxs9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803133; c=relaxed/simple;
	bh=dCYlgKZTH9VMy9Ru1zjAAcfghHXcI8RvqEHyTqil3Oo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OL87LK1gQBdmET4/abb+S+n9IenLwtKfJA9el4OCMxXamY6FazC+VYpxD+W+wkcmeQtosI8ZuQvIv0HkVevriaF2HMAQMOyjja1zD4nt97+5FcAbiDj6zN1H7G2R0DE/7WtAxUZjhZqmBdZGsxUHS1M3bhUwM87k5ZwPcH52TZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AC88d2hD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AC88d2hD"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b9b8137828so107745165ad.0
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779803131; x=1780407931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7ogrWNYI3gepg7QyExihjmhdR3tEft22xe63YUoKhA=;
        b=AC88d2hDRIMP2hWNlK5MFK9WKAZgqMaZk1HGviuTyF0lHapaPGXYx3zpEPrwDhLlcT
         UEHoUhQ6cKMvm+Y7uzTTiND2lXGcD2vxKcQEtMpbByFRcz78ujG/275nvu5nTbnXDAx8
         /uRhuduVY/NYj6sc918zN2+ZlL+Ntimxw9CzBFSVs8WRHmAyaBqWhAudaNQbENmYTlbW
         eXg63tCgYtnAhxTB9s1mILTcI7BBM/GFMlxOSKxJBH+rDhYMZH5CjJQh0mRAmGDs82e4
         H1VHYhkleoVxCg++d/ly5HVCAwPiqtosXXEVgOWS86tzC9qbYewY4RDRizICUSabR1Vq
         V2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779803131; x=1780407931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7ogrWNYI3gepg7QyExihjmhdR3tEft22xe63YUoKhA=;
        b=bQ2OstM2hmf2wisMzMRo35qA5zymRMl/GRzoeV5li+0/TjWpEYXnxHmmhU+gbhVxsM
         hD8KvrrbLWo/sVnBx20MEXnXrmg3r8Iao/2sgho4ETJUO8SwGFgrh1NZvryHSvkyetCv
         BuezgJp1KOss7Lrvcp1SKqqclSu5GpSR6ZIgJaxUSygr1QaoYwM8m7X/6Qrq9+J/xR0u
         DRsR9iQUtpiFO8qVswJkL+roSmmLDkYARagWTkUIom/BcVR1PAbapY8ia7WlCyuoZM/O
         eDsoDVx7nkTnSE0ko9pb90Wukkj0Zv9FiHs3nbI2bbnuoCMjsckzyGjHFBWEblpsY2FA
         hiyg==
X-Forwarded-Encrypted: i=1; AFNElJ/E4INdB/GP7UaklMmQgR4GoaQiUCFHYMQN5Ut0eh5hQHIq1VT1fDWyVujppEGKVbSXaFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEMAbDMSrFxiWVEEUlHLKN0giDhFjiPJuN0szpCr6pPYfjxH1g
	OoX4bc6Id1akrC5AVlMh3A2WlDKfwaIPU4pXwXPJNdWf7QSqj84S86DBeDRppV15qM78S7+GJ8v
	sC1mIwg==
X-Received: from plsa3.prod.google.com ([2002:a17:902:b583:b0:2b2:4270:9f7c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:15c7:b0:2bd:8938:b811
 with SMTP id d9443c01a7336-2beb0700897mr225723395ad.34.1779803130936; Tue, 26
 May 2026 06:45:30 -0700 (PDT)
Date: Tue, 26 May 2026 06:45:28 -0700
In-Reply-To: <ahSMMAUQ83P-NeOi@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ahSMMAUQ83P-NeOi@mozart.vkv.me>
Message-ID: <ahWj-P_1uOlYku4m@google.com>
Subject: Re: New "no-cfi indirect call!" build failure on 7.1-rc5
From: Sean Christopherson <seanjc@google.com>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@kernel.org, 
	vishal.l.verma@intel.com, zhao1.liu@intel.com, binbin.wu@linxu.intel.com, 
	x86@kernel.org, kvm@vger.kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 25, 2026, Calvin Owens wrote:
> Hello all,
> 
> I'm seeing build failures with the attached kconfig on 7.1-rc5:
> 
>     running 'make' '-skj32' 'oldconfig' 'tar-pkg' 'LLVM=/home/calvinow/llvm-22.1.5/bin/'
>     vmlinux.o: error: objtool: idt_do_interrupt_irqoff+0xe: no-cfi indirect call!
> 
> It bisects down to commit 0701c9e17bd903d95b2ddf7dd2e1d8be5027f331:
> 
>     Author:     Peter Zijlstra <peterz@infradead.org>
>     AuthorDate: Fri May 8 11:18:29 2026 +0200
>     Commit:     Thomas Gleixner <tglx@kernel.org>
>     CommitDate: Tue May 19 20:25:51 2026 +0200
> 
>     x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into x86 core
> 
> Nathan noticed it last week in -next:
> 
>     https://lore.kernel.org/all/20260520230621.GA706311@ax162/
> 
> You can reproduce my LLVM with this, in case it matters:
> https://github.com/jcalvinowens/kernel-testing/blob/master/scripts/build-llvm.sh

Peter is on it: https://lore.kernel.org/all/20260526090631.GA4149641@noisy.programming.kicks-ass.net
