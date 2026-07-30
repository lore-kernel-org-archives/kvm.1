Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E023C1D7C
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433018; cv=pass; b=CTIbXyZ80zIijtCrfoYr+7ta2IPPiEtvPX9o5XWJDbcbcmXWIJFqGg5XQx9Vr66twARIzY0ZNDmmlqphSsQ14yp/haCAXGdW8ZfRx480gLEN3hm6zpc2iCpfcdhpp+LdaA920nNqsIssDknF2glb+Kfa5i3ZAKV86g532xGaNqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433018; c=relaxed/simple;
	bh=bEZVfjW3X/ZJJhJsMcL2gQZGx4De7c1nlF8QDVmWlMY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ph4jhesV4vw7SoHWQt04Jo6VoAzThS/2qcBbPGp46W9j2Qg2G10lVm0U9AEx4T9im3X8BuDF++8X2l5Vp4hV3xGJDGwMzctIVYk5or+HN/ZRFM7GcUPCc3p4pWw/lw76nhZf+dS/kl27LYH7eGkurGhxGNX3RA/qJKvBSltkGnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cagJfX0F; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cagJfX0F"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caed617615so557865ad.3
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 10:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433016; cv=none;
        d=google.com; s=arc-20260327;
        b=U+PD4nAakI09gEXl+ZhCoE5rl6LEgvypgX//zd5ADANgxKNpXbCYpSp5j81c8dH88C
         YaOOsueTz4pLzkxPZk4Gb34r627L+r6HWVsaCXwk/aT4c5ZIW0WQdC/4URhtdt44RhNP
         NmLpFtnZGNgKLJl0uKNkUfyvrvDEv3T2fbf3+XqPr1GsW8E/PBVVCCLssRjDXy8R3Q8Y
         s/hP3KoJ3l1z5wG3WnBqh3LWWBiMBAerNhEdgywzGFS5y4xH6bzz4CQJau2FnFMuboG3
         NdspRZVEoZ6hav3hRuDO7AOh6JCA9A7+kG/NXjpY6FUxE8K0bp7lC6JYlcC6TLXjwfzV
         RW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=cF6Glwk5JHPcXFLYP8vDOSrow7Ekc+sBztL/w45l/K8=;
        fh=SNBs1VRVUfvNvGCVV8/Ls8TOAxATegWGkniUl5WCma4=;
        b=gNu5HFEKgsb5Nrm3gEDdX5lKf77orKtM3KXR7UqpvMDNesy/GnFGxvvp6X9yGJHFNz
         U+aMovwBSuNRnhfdihJPGRulIikXcv0cuwv9tPFyQutElhKLikT6Jk/rScOgGAptqeOm
         iLqjBb6gWda4xVI4PogOZvs+2uwgoAava0+07moWsnFed8RTJqlBwH6YgcwWhinbD5nK
         8B3oSQO4nq89emhIMJRFLbUS0vFvpZqoBpEHF1aHlLBPcfSp3JlrGMwlFt6dCwF/cAZP
         z5WZN/RtatPl5cF/XUPiTIpc+FdLSskcv3Qr4CLCuUBB9mtnMP3FLZjGoiO+0MHVu64p
         asDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785433016; x=1786037816; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cF6Glwk5JHPcXFLYP8vDOSrow7Ekc+sBztL/w45l/K8=;
        b=cagJfX0FCSgk1ujuaijcW4jPR/t8fGWlyob+Gx8vyrAs18Wjrm/zgCJCz4fd5qUFYl
         d95wNBU20RdJe9VwhCkD9FRzlgChn8vRXrJJlxoBkTzaO+61XDz8ticDicbtZdyTP8vS
         EwzWdbDOk1akmjDje7XW3iX4NKCec3drxMv+LKHJFLBxTcVnFBBb2LzRLQ4qcpQ5/64r
         jgsxwUTpw7zQcs85u+bsR0TG2udwHua8VZealKkm1IA8BItSYdFmLMfrOITwvFQ8BY8k
         ykTxQyKuk35OUGY1nsMRUP1sNOTx8QEap+3AqMtr2wAyQV1h1PtXzWFqCDnJF8/RJJYs
         OJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433016; x=1786037816;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cF6Glwk5JHPcXFLYP8vDOSrow7Ekc+sBztL/w45l/K8=;
        b=juVT8bm22/oXAYfqhmq+7pkWsWu8uWJpcdDFpjr2q/vXPjqE2H98zqrsY82WkkPExm
         8b2ESX5yyWYM0s5irSNDLBDUa8LoN2dWAgL6ZQcXNR1sTHDdM/iLbJvUuVnskxIg9dr4
         1+SFaTL1ut+wnyz3asAWudPZFp/fCKendf4ynQEHq+obdqWnSjswHAqEdA3CTFjcrUEH
         nFBKIb8OjQL1LUxU/27GDAf0VW36/FsWsaYCicw9MUC8X3zhtembCLJDHKlsr2PqfNji
         zC69zVig89JSi5esUZ4g4rBlf4C2MLuvIdEDGHqizU+qcrZ5pm+DGVVyADtymsGb0r8x
         fjHA==
X-Forwarded-Encrypted: i=1; AHgh+RpSf0yh4hhCBap7qwdGvXIQuZbRVJ3pJ6TOFlyL9fHd7mSlw2cA/SfmaSl1l/c9MyuT+8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YypjZURlebChFG0k912CU5JUxwP0vPx1jnCZVbvblhQmHcrndnN
	HwtL2QQN2m2aa5bOmH6SCSTR4MY9tN8sVYMl3jpbAMQo/GeX6yCHEd5yQSZMJ8IJ9GONk7yZi/L
	INSEAy5UfoWb6jDUB7lLatgc/8xhz9TRaycNacD3L
X-Gm-Gg: AR+sD13P1QRSwQZNnBF6C/TcO8GgH3TPXo2taync8XnVF+mBhfGZ/AUypcsuYf7Jeyo
	fLTUe3vis8eafTVGCo6VBx+6n6p49VRRMG8eNIT1FLJQJESxbjQvlw7u8ZysXh3s2IfrNxquwmO
	CcantpgYW/bOik7bI7GV8hRvS4d1nPP6Hpt5t5djC3cK1OvJV2YcsnJoPaYuY3OklZUDPnnyZi7
	dJ0Lfs30/UuxtAcBJov6Ua9E5tmBL5LghtdC9ZTQhTFrcind/Rk1d8V87QYbDOEoCkKbi82ioaq
	ClqhhvD+Vaf+O9v2KQPnxgf/JLcEN3n/paBXSVN35V/DzX2q0s4oLPQURhA/100w5mbnr0Fx9SI
	s1YR2YhA8sxAv7RRB6PACa5LJtYNI0BhdMw==
X-Received: by 2002:a05:6a20:d805:b0:3c3:8651:b302 with SMTP id
 adf61e73a8af0-3c90072a2acmr3423693637.28.1785433015659; Thu, 30 Jul 2026
 10:36:55 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 10:36:54 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 10:36:54 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728121138.1103610-3-tarunsahu@google.com>
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-3-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 10:36:54 -0700
X-Gm-Features: AUfX_mwFoYwitx3VhlqJDH1-k0l0ItJ6i-x625ej1dYBsVgzkh7R-MZiFMgMH5w
Message-ID: <CAEvNRgGazT2D-G7sEem4RD5nUEj7dmcg8vx2=3bpatS_o5uE+g@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] KVM: Introduce kvm_create_vm_file() helper
To: Tarun Sahu <tarunsahu@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Tarun Sahu <tarunsahu@google.com> writes:

> - Move ITOA_MAX_LEN to kvm_mm.h for reuse by upcoming kvm_luo code.
> - Introduce kvm_create_vm_file() to wrap kvm_create_vm() and
>   anon_inode_getfile(), providing a unified VM file creation API.
>

I think these should be 2 separate patches.

>
> [...snip...]
>
