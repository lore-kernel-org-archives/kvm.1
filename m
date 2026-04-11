Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20440DFDE
	for <kvm@vger.kernel.org>; Sat, 11 Apr 2026 00:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865748; cv=none; b=bwZXQ2O21QLOaSnMLLacVdfCfJDVbXWLYm8bxYNaQAjkQe0t5yrAGTDkCTa8RCRzR2TBm4k+z3LIS/RLqzVjdon1BBpvRZ3L7fgNtUh6MzoWjD/BW9iJXC46v4nneejP5YIhG/MWgCIZskUIZv1pgkf2LYkFQiL7x6YWGzMuKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865748; c=relaxed/simple;
	bh=kS2O+VK2c3qYX7RMHuF0imPVPxHDOzPkyOgWJI1BR+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ItYPP99fLT3CcA2AvgubDNVXulLs+I1aHwStaoTsM+UHLchQhsjTsN5mwBXayI7fVDQ637n3u2ukOFM8YxuCcoeISAVYhFJUw+zveYMLcog4wODDSLCpr9S+jQoZYxpMrRH4K1ottzU6d5CG/keXbcwnitJEM8fhkLuxuqiANKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7CwE+aq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7CwE+aq"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82cd9fa609aso1708153b3a.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 17:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775865747; x=1776470547; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tgj500tgZHfbXwXonrInaOfT8cNL+fIh5uRLtFj2/YE=;
        b=v7CwE+aqNOiToTJXnQ7PixmfyA3zYhEmZrZcBiE98Vjul8Ne8SZh7rKVn0yVvAwDEU
         ClNDPWz7s1aKM4nDv/VIrlrsTpeTKpiDNsSm0iiS8T5O96l0g1DrtFNPpjwBCUZ7w3Sx
         vV9rj4SbLk9f15gZkiCqcxkSQPhTj3cZtFtDmvS2WEG+M0yZNqtPH0bRuDeV+7QOHnky
         NLfqyqNe7cyfs5QwjpVTugpqCYnr30XJz4OZMINV+dkxeyhcWITJ2GLZzWDSq2tTOX7L
         3K2w+Ep2jzLKZnPwCuw9fQ8As15GA56AQVG5ITP079svBRgeOCdCXLfifHHehOxcTkAX
         Xc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865747; x=1776470547;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tgj500tgZHfbXwXonrInaOfT8cNL+fIh5uRLtFj2/YE=;
        b=AvAtp5F+ZYDMLwY3NmOmN++yGMHPE+NBhqcqdQ7UjhrmsIb96SKyYaoQNWW6Yrn7mO
         54Rn9RTxGQrYssRAoFlphw96AsvIDHqjZQPpTBjiFunHuF2qNTRmaMgxlTrM+vpweLE0
         /RO9VBPG284YVdrSWueZYOxmV8QkYlM7FNn+1NhJN2uyk0zaQTZIynKBU91RlbQ3Xd+1
         cHttz6+6OBW9aaaxJ6xLu9onKMBX/J6KxjVv+NDDNmX5vxsVXnSkrethD23YYMhCOhbJ
         U8SMAMQElUXbV0ELAtnjXBzxr5U6QloL0vjFKIvUAJDlAEPaLUp36VGZ4EtyR0JBa0PM
         J6yA==
X-Forwarded-Encrypted: i=1; AJvYcCVilv6G//sKliOr5c89R7DjZbhZdj/jkuzmsaelXxU65Lu91Cq29IpTMGRyh8jk1xjBZ8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd9q1SiRXbGeri/8uUxBaamYY9N3JlU7oKRyouUvKjtdpQI0PX
	kHggiAM0RverBdFDn2sQYGW9Oq0xz6P/M1rwL7yf3AH8Tx3CmRIppq+0ubntySbHOArq7EZu5W2
	xEqNssg==
X-Received: from pfiv6.prod.google.com ([2002:aa7:99c6:0:b0:82c:90c5:5e0d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd12:b0:82c:9897:7102
 with SMTP id d2e1a72fcca58-82f0c3168efmr5839232b3a.39.1775865746830; Fri, 10
 Apr 2026 17:02:26 -0700 (PDT)
Date: Fri, 10 Apr 2026 17:02:25 -0700
In-Reply-To: <20260410235832.2312342-12-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com> <20260410235832.2312342-12-seanjc@google.com>
Message-ID: <admPkd9VvImN-sXd@google.com>
Subject: Re: [GIT PULL] KVM: x86: VMXON and EFER.SVME extraction for 7.1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 10, 2026, Sean Christopherson wrote:
> Move VMXON and EFER.SVME handling out of KVM and into the core kernel so that
> core TDX code can do SEAMCALLs without needing to ensure KVM is loaded.
> 
> As noted in the full "svm" PULL request, there's a superficial conflict with
> the OSVW changes.

And I almost forgot, there's a lurking conflict with the tip tree due to these
changes tagging a pile of TDX functions with __init.  The only notable thing
with the resolution is that get_tdx_sys_info_version() needs to be tagged as
__init as well.

https://lore.kernel.org/all/aagjzN07Pv1fnSHq@sirena.org.uk
