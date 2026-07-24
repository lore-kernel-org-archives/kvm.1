Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046433A6E2
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907493; cv=pass; b=hTApcV+8wL26jTnuRgreOnA+UXwPfbwELZtZQn0EGy/oNw2hHlhji2NYLDTsLBzP2AQzYPcR3cJcGwXsCHM5xnGBDEmSbGFWCkbazV8aTsQ/GkDOxh6UhbNdGZPUXuf5byZ6EKfpWkPtwfVYwM2V+scvr4LttFxeyjIcoamt9mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907493; c=relaxed/simple;
	bh=9uqLTYQBiMlGLOFgwOhVylnBn05Ou+bOr0LFGUys/sw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uSAzKtz32ZauaYxEKGqDoqQXysqpnc6cKT+yOk8uk5LPq0CIQqn8X3QG4i82/Lh3KPIPQPEnzBtvq8BdpkMW5ta6UZ+2AuJDi3y62xv0IV5AXyKZHI6cpAEgyvWvQZacVMAg33mJZHrfLRaKtoD1DKLk7mkiTwj4HtZJBXqVJ74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ven2Bbg0; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ven2Bbg0"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so827181a12.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 08:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784907490; cv=none;
        d=google.com; s=arc-20260327;
        b=W97Yfs/15PvppUVY5+4WxlN85CLyOzx9Yc8Jy2f5R4V75ekr6iyNV4ecL9i5quNyi+
         jDLZSzDVZkadR12q8DOv7gQi/jvHAkQPzL4rultLHxpIdveIRIcgtTSplKz3Qptp8onY
         zxW5J+QDLH2T3yPzkvisbAmVUWfnDaI2ruR/WcoZTKd/K477xmJy7heeF8/pLq14l285
         NWiVCiqHnsJ78ZBojwPiHUp6e8fvSP+nueOgv24MMCRNRSG5UrI19Kt8GuBUlpcvTutE
         QfCjNa2wa7EFkbHFrH9EI04VLaPnJLYtzX202yW8V5mpjC4kM3l28DFzBc5qAL67dIyC
         pMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=9uqLTYQBiMlGLOFgwOhVylnBn05Ou+bOr0LFGUys/sw=;
        fh=7cptIeBM74jerFPw1uant+n5p/IuUCUTkwRiyfDXJOw=;
        b=M+jMbZMKIwbMYyZ299+nQtSBZOVp3R68EvgXkTvYPJmMU3So+asmedfknaUsHJorH2
         OphkgTjmSJ3bX+uoYpv7g1oRzov3890zPqxWZL0MTd3Sv9I90l+3mGAERZOaa+X9n0OS
         J0YhStT8UmQd2OWcCtGM0rn5+HiBNeZ6Ge8+2I0B2OQv1n/SQ7exE/S+VAl8rNkzV7kb
         FN5/4NkTSmx4JzK4h6YwJqKInNA9DQj76noJGIwtzeEzLVPCkjaGD8h8d4SBDtd+YjnR
         Bi6rvekpZ2n4ZXZe9iAW+km12w0tTGZKoGZ00YtsGXg/g3uMOLfZAle1ScM9+VCXedF3
         iH3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784907490; x=1785512290; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9uqLTYQBiMlGLOFgwOhVylnBn05Ou+bOr0LFGUys/sw=;
        b=Ven2Bbg0WIHLL/mhuqbj2hWmLIoyL6ZpmjrDCc0DkMO7uCkfQlvtQmAO8O/PUc4T0F
         Y+7ILgFjHvLbm74JYM5Hvgp8X8ULJ7iUH/VsU9lK6UnzPTWtD7xoIX0ukDC4Ykv/JL1o
         eqTDbGl22tfgv1f8BIfVFsOSH6u8n0l1hapXQtP9rQ60We0u5KpmJ+NCoywObcYmffnU
         pMCjmgcE+hBByOuM9C1nozbTnuXqcSnPM7ErLsRHzx9p9qcgjpAoPNQmNt2JvKqkgT7r
         WHIl47EyRK5WbvilW97rjjzGHYkccLKRXoJzZ1lztozTvR+dG80uXeDo6Y+V62fmc+jJ
         ztcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784907490; x=1785512290;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9uqLTYQBiMlGLOFgwOhVylnBn05Ou+bOr0LFGUys/sw=;
        b=lJa2oG3KtJyqM4VcNGCbzOa2dWv6O1Ex8uGhsrXb0REF4xqi8cgRQ6o+kvGBX/L5rg
         uKMNXHviVK85KvG4a7ATiAYqG0AKhtA13CTLAu07ZsK353DTlwtcJhbF9Dw6lwPi0oL2
         CRP121O0MTKJqArSvSNL3+Mz8aTtci1Q2lqX/m/yvvFb4nCyWrB7j6+3OOEYGGklDhC0
         o67PSB+zES5+CWS31ENnBSuvkzXANNXuMajbQkefZxy+pJrmAJ54ndU4igN83gp00/IW
         nexwPEDcWM2o1dMXKnqfgMwF/j9K7P2n11jwH9pLMZnyfpbJFAhQzQ5BAMQWrtgAEnFC
         QRzw==
X-Forwarded-Encrypted: i=1; AHgh+RqkT41pab5UkOJ6/49rW4T4QXpkuoGi5KH4GFi5ceUDUtBlLrGJLJ8a38PwgGAcS2i+sgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymSdT6Hs2nn/Bt8nGL9BsXj3rpxudlsZjgRs/lHf/DY1o7aSu9
	RnhlCVxjNLu2Nj0X6GpVyuIbJyNNSwftAs+Vn3MmAHMAHnqJSFoNxh94/8W9XT4zdfJo1rWf6Ro
	YLtto1+bpSRcwCShy2sO2Iw8G9hPONac=
X-Gm-Gg: AR+sD13U30MIFzor/9SOyxmZkAkRw0ae3X0NZ45hlNgQ5QYq2ubYI8HrKed7GsTQvZU
	l5cT1R4Km4InkIjSgNNGyBm/7yLnVS2ryC2Lzd7xvpSC+yyOyoJanB1MrmZgUdIfKQGR5wdiIWM
	S+wFdcp3UDWL7Xm1uxQw3q9Xg/wA0A+ONzSkfaBSES/tSL8TF5sZW9rEq6F9yINBYaHpFtuP8Wg
	jpc4w38sflUrnrHfRYHoNIVyJzxiVz+KhU+STLSNRLlmRNFg4q70FqDCtxs/n1QixaWTf8sJOFf
	RIuUEkaJhbZRuElyU+A=
X-Received: by 2002:a05:6402:847:b0:698:ac05:5b2f with SMTP id
 4fb4d7f45d1cf-69f6b143145mr3254860a12.4.1784907489864; Fri, 24 Jul 2026
 08:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Fri, 24 Jul 2026 08:37:58 -0700
X-Gm-Features: AUfX_mzU7u5uNdXumU_vcZlVt2HDSLvNSuujJoCvOQwTQn5iM4qD_F0D9lRlIvU
Message-ID: <CAKSQd8V=wfVrUxeU+fDRgKJBLdiyCkkY2SRY+OoRBNE68LFnCg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Remove AMX-TF32 enumeration
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	pbonzini@redhat.com, stable@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

> My understanding is that the revert was considered because TF32 never
> reached any implementation. If that's incorrect, I'd certainly welcome a
> correction.

Both TF32 and TRANSPOSE made it into a product that shipped.

Not from Intel... but.

So their CPUID feature flags and their opcodes aren't reclaimable
and efforts to rip out their software support are counterproductive.

That is all I can say.

--
C.
