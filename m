Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCAB3C3F60
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926614; cv=none; b=UyU2jFpbVCopJrQ04D09T0Us0iFt2cr6d2vZ4aDhP2PUH63T0uOJJ45qurgQPFtdPgIpjgs/XKu/vW9FpZegoggjT3+VDetXtseE9SgTLehTHnwCo3Ud7Vxr75iUiKf6cJg0jkmhBnBZQRIkdLNx9wCYTK/jb2Z2tRcjBJqOAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926614; c=relaxed/simple;
	bh=vlJRBPYBgIP3/SyhsiDNWaVnmbYtEvUuOhYiO4XYFb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IZq7cyxdq5/Tdskd1elEKA7fJafO55Npqv/yeopvESXkSbUqNChRggALTCC5y+06jJHxihbdhQVEHP8dR0/LPy7H6TEULzotmhP1Nq3Gfk9JZGqZtdlVO6mNMzmNHJ6XLB0caDRHHLABANrbKFAqQGb+Y02LinnSE3Zyeq5oXQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJs55RTG; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJs55RTG"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc86a9ef97so14934645ad.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 13:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784926612; x=1785531412; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X1df79W09/y4avz4t7gCCDelvBPsQH0Sq/MegXpdKLs=;
        b=XJs55RTG19em3n3u+MKgLcIRLgpfxfJYLwjS+xqZk6S11a/9ccTy/v8jcSP3YOBmpD
         K2A5N9zeAm9/aqbzuY9sr648rRpr+rxARj5ojuc7c+swrualSP0+pdUf3DNRVG05H0Zt
         HvIKswaj93t4OlnYiBWNKAgdT8jAxTK6B1szLRX+qYnjxw38wdGyFasuTvHAQRzrAag/
         zByQmleFKeX6FtKM+qN5rTQcdTnXGi1a+XcIzL2umYUs11eHEqX7PNMzXvKsjh5SfoFs
         Qjq7pDB4pOt2ekw3kaMuGennUjjvZy/ZnC4CNow1ZTRZVZ63ATVV3bCVOjtEvaejpuM3
         VenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784926612; x=1785531412;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X1df79W09/y4avz4t7gCCDelvBPsQH0Sq/MegXpdKLs=;
        b=imguBtmJi7XsGp29ACfZnhZhGwafxBjrzKMDN5z8VMQyoq22f+4LnakIViXKXx5uu5
         qSM7F1+thCPAi6C77i0Kxv32XJsyRokCb5FT2drw9ZQHvlL4wI7Yv0y8NLsj3n1G3MMg
         WmHptPG1ZoLEFcQd/V2hMQpPsnpW9DpclXrhKTmWXv04Qa68AUpP8eNehTEq3PWpPtIn
         wd2Tx9oIZL3r6Sv9MzZfbwZGyNgdT2Lx1xaVkVxGSoTzX6nNtlBxYG+xj+b3r083jDfq
         I2xEwtlh8R1PgeUtpKAzCp4omtEoVTcFTD74E0+7TF2slZ6v4UWoJn/1pDG/i0BkEAXq
         C8EQ==
X-Forwarded-Encrypted: i=1; AHgh+RoywinIg/dvHsz9ID22hmhVBdeEfgqXfYyWaWUjT5eubXq5KxSewrNDvPGVUkLfuuvtaDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrd+wLNNkknuz44z8G5xJD0jeHhhC8P7mjJjOlg6zR7WRTvwhH
	+ZeJPXaEbkH3uO2C3QmaC0lVXRiO9dzYe26C9ar5iWlLCamc20kHZlPuE+c10n4YreiSM/8jsqo
	TSy6jgw==
X-Received: from plkb6.prod.google.com ([2002:a17:903:fa6:b0:2cf:7a5b:f7ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e541:b0:2cf:1536:3d41
 with SMTP id d9443c01a7336-2cfde84b893mr430755ad.28.1784926611994; Fri, 24
 Jul 2026 13:56:51 -0700 (PDT)
Date: Fri, 24 Jul 2026 13:56:51 -0700
In-Reply-To: <20260722143024.3938899-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722143024.3938899-1-jmattson@google.com>
Message-ID: <amPRk0SfBJLQpt9X@google.com>
Subject: Re: [PATCH v4] KVM: VMX: Cap VMX preemption timer to work around
 Intel erratum
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: pbonzini@redhat.com, chao.gao@intel.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 22, 2026, Jim Mattson wrote:
> @@ -8735,7 +8758,8 @@ __init int vmx_hardware_setup(void)
>  		 * value.  Don't use the timer if it might cause spurious exits
>  		 * at a rate faster than 0.1 Hz (of uninterrupted guest time).
>  		 */
> -		if (use_timer_freq > 0xffffffffu / 10)
> +		if (!preemption_timer_limit ||
> +		    use_timer_freq > (preemption_timer_limit - 1) / 10)

There's still a 64-bit DIV in here, I'm guessing it's this one.

   ERROR: modpost: "__udivdi3" [arch/x86/kvm/kvm-intel.ko] undefined!

I'm not interested in playing whack-a-mole, please base v5 on my patch to make
this code 64-bit-only.  It's small enough that I'm comfortable sending it to LTS
kernels if we want to tag this for stable@.

>  			enable_preemption_timer = false;
>  	}
>  
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
