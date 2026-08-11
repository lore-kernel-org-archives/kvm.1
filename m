Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47E17B50F
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 00:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406604; cv=none; b=E7twZ97/0+6Pogm+fCCa86/q/sBPqpyjw0eFaFNWWxLxiuCkGkUB5HIv+NUSy67bsp7rrgRtfa2DA/Tl7+740IK3LNrR8Kk+3oHoze5JRq3WWecYsm6y0gGsoAd9YSeAjL4K5X7SpDiteD5NNxPu0Y4N2SU5ZNDiyNGAMZuTFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406604; c=relaxed/simple;
	bh=VknSZXDkyZLJjuTzL9I1xTfQa1Mt40VNpMN4ud71R3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H/B3cLClkmO0HkOgJ3Ym020CWhlkdwfjvSkCKZxxtf7t5/6SinFAN6BVHVqhQUV8XP+nTSThWkLplypSlJjA9Qw8PAyuEgmO4rblLi9Sfmh+5ZX5MAr2NYmjfqHwjQpCLmYLBokVhostWRmZ6VVnsDxdVw6mJk4xS8lGyjfrulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XyYay5qA; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XyYay5qA"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84fa3b14ed2so183179b3a.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 17:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786406597; x=1787011397; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V34LZvL3zmDJfeGU5wjT5dtwNItHoDZBEfOxW5gT6qU=;
        b=XyYay5qA2PTl+xRd3Agi8WYOcXY26/fKT/cngnUvFAIe0o08p6r5d7/jY2lpIcF8yJ
         glkE35qQ1pxzsE8y6+NyC3vVNcaq0eWer+KAV6Dw9Bw43h8aMgAGI9/inpQKfxAadF3b
         iRs39UIvnKfDD5jDRVoC1X7bf2tTr6aicy9PFmTFmRVK3ytOlh7I/+0Nm9pcucIeoXWB
         ioCSIU+/SWpvQmAtnPgSVGl0nCRM8waij0d2HvdgO5u8L6X2Rg4VhFWOG1gQ+FHtc9iV
         wNNuG3fZ7mCVde59GCht4hXndCOC4led4dH6tqpq2V3Novl1r97VkKlXdvg4NPpOAM4o
         4Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786406597; x=1787011397;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V34LZvL3zmDJfeGU5wjT5dtwNItHoDZBEfOxW5gT6qU=;
        b=j9OYNswFWlq43CjaOL/nFLoeM8dzVTMA3ioOCcX4zDU0dW1w2u5FuViInl0XRaE6+q
         qJgiVKqXNpyPB+AH0g3krzwwLjOvhx1IkOgdkmZGbfRpvzBxlABX2bYfPbdWtk1C7f+Y
         ekUK739PEbILBHDsY0Axbr3x2+Y/cdMXrL77mX5tHXAweI7KsT3BoMzekNrw2bKoTNSj
         yjaB8RTD86nsVliUJLbSmgEOhvHQYXUKX+kQBfMrIE4A/aUyUnDC1HwuSoGyLnpJjkEZ
         XMNRfICVmUU2XAvWP3WdJNrdJIyX4F4hGTHdaPQ47nnuSiNL2KcCfIzkJvQLFx2tlTRV
         OFjA==
X-Forwarded-Encrypted: i=1; AHgh+RrWDXCsLno1jDJw1xGbrSgoP2LMkb9mt2ISHpTknWz7AfY//iOn4+xVIay0Bp/CaPBRIWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhTeAYDaO38itN0fy3gNfomNYDlNI1tHT2tYq/xpu4A8nwLZr0
	N06igyh9JN7E/P7hUYJgF1TQKFnBuOcmQDQdvwSOa5tAVF/DTYO+fY7leEXqg3rXFU3x/piObhJ
	a8/C74A==
X-Received: from pfbgp14.prod.google.com ([2002:a05:6a00:3b8e:b0:847:8e58:df6f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b11:b0:845:e41f:9696
 with SMTP id d2e1a72fcca58-84f2e00ea6dmr48897452b3a.25.1786406597125; Mon, 10
 Aug 2026 17:03:17 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:03:16 -0700
In-Reply-To: <20260810112200.2326727-3-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810112200.2326727-1-xiaoyao.li@intel.com> <20260810112200.2326727-3-xiaoyao.li@intel.com>
Message-ID: <anpmxJOESl3swUpd@google.com>
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

The shortlog is way too generic, and the changelog is light on details.  Over
the weekend, I managed to forget why this was necessary, and it took me a few
seconds to recall why we need to avoid setting bits 31:16.  Of course, one could
argue that says as much about me as it does the shortlog+changelog...

Oh, and shortlogs like "Fix the exit reason handling" sometimes lead to amusing
follow-ups like "Really fix the exit reason handling".  Don't be that person :-)

Something like:

  KVM: TDX: Don't clobber exit_reason[31:16] when TDX-Module didn't try VM-Entry

and then in the changelog explain precisely why KVM needs to avoid clobbering
those bits.

On Mon, Aug 10, 2026, Xiaoyao Li wrote:
> Get and check the exit reason from the low 16 bits of vp_enter_ret, and
> store the synthesized/transformed exit reason in the "basic" field.
> 
> Some bits in the upper 16 bits in the exit reason have their own meanings
> and they might be 1.  When handling the exit reason, only do handling on
> the lower 16 bits and keep the upper 16 bits unchanged.  This change
> also helps remove the additional check in tdx_failed_vmentry().
> 
> Note, due to the synthesized invalid exit reason, -1, is changed to
> assigned to the "basic" field, adjust the checking in tdx_get_exit_info()
> accordingly.
