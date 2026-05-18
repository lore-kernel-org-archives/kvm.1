Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44D38B149
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137575; cv=none; b=sHJTZuQc4AaIG2A2zBRdpz1xpJgpM6S6xY0aZRiSTQ+m4FNCJtCxKjjCKBhhlQ9mqX4PGSyWZAzphkWSPKcD1oKCq7+qsmz82f3uYMCntivjvq/DjANVSCWz/pkuGICbpInDMPpp3mynVhogwtkr6VF/EBgNYstKR5tS1NBzy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137575; c=relaxed/simple;
	bh=J3wIzAmtDrAGuo6CNNtpUcBgRzCNFDvTNMSSmYBVxLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H8fKHq56gg/BTdgZxlDzDH9Ln2Yq14ghdq9Cu7JFIahY/s9G0spVSbE7mvzTFHx7IU9rbTxsr+IzpVKWDgH99TB2p2UeVOZ09I62t/qRYQUwbhcTzE8RTIquMW+NM22jQlYVK8xI9FCTl+lK2FfuKfi0jb99+ZagdeqzJD5iLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GLG8a45Y; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLG8a45Y"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc977e6aedso25217875ad.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 13:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779137573; x=1779742373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WgO1KNL8/U9E/DVqPyF+7ERcgH8vwTkrChGAMO4svKA=;
        b=GLG8a45Ymhn9tns554rxbI1dCWTxGlpOd3nw5cIgENgtYhX+FNgmQX04U/qTvYRUfy
         /tH3X9kUDaP4V5D/EvyyR5FGd8ovCkhj0gwJmRH8//BsXxA/N9Dc2QuwYscIkfz22a+v
         Uyaw0tgH+fGq13Ticaqcq2HXq5naJieHlhlgaXukcXkfjL5yLMTZRNsUVk49/xkKj2ZI
         K8L8ydduIyLfUNWZLY7TIm0IRn9+rYAdy5DakEsVlArLYblktvcYDZiMv2gwnsHcTHEN
         XcBMEcO2Oij6geVYZSIT7vPzvE5fjKAr91LA+2VWAHb0Q0bVM0Zdd0enoferFL+l+cyg
         mhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779137573; x=1779742373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgO1KNL8/U9E/DVqPyF+7ERcgH8vwTkrChGAMO4svKA=;
        b=oQkisABA0M6FKMpDn1b2u2jRRU4YFNCai0G+hVlrjXRPo2IktVODoIZztRCjAN1MaB
         yHfl274wt74Pa659DPm2JC2k6JAHHU0BwLkDBtzM5m6fOzQT5/OUI0akEFzodDQ2Z2mi
         s1si0oZUTYQxZtk9R/HYb2PHo5qiYU+KzQPCcNgjIS9oyoSixBUy2S54XsZ/CkCZ1Uvq
         8a0QnDwDqwlUNi2U9RM2xm/Z6aYTvPxT7DTAfL1AOxAbRRGD+YScj4xh43Yvw3BenhSY
         ejYpYh91ia04zNZIY2Qx11573QcEWINk1o+2+SwQhkGeesaLXDjCqr6585TEUvCmdRqm
         C/Yw==
X-Forwarded-Encrypted: i=1; AFNElJ8adBHxofXT3wslUfRZmbSWgfAwIdnM5rd97JGe3diMfdLYM/i0OFBGJ0P6QTtaj0lDwz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTu9EKdKFaqs3GT51FvI5DIKsIasWHUefsKy9d8zpufS9SSFk/
	0Giz1MkkKnYxQgbNqkmYf2kQ4cmr1/j5uKiVGrRa9+X1Ga8rw3Gez9pQrxgCV+fMNqQ+2sfxp1b
	ST96rxw==
X-Received: from plje19.prod.google.com ([2002:a17:902:ed93:b0:2bd:3dba:a4c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230d:b0:2bd:9803:9304
 with SMTP id d9443c01a7336-2bd980394b5mr139925665ad.39.1779137573153; Mon, 18
 May 2026 13:52:53 -0700 (PDT)
Date: Mon, 18 May 2026 13:52:52 -0700
In-Reply-To: <d3c461415e05345a9b82e6f995828c1ae64a4e61.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260509224824.3264567-1-dwmw2@infradead.org> <20260509224824.3264567-5-dwmw2@infradead.org>
 <0ae8e471-db7a-4842-aca4-8ef643acde8b@oracle.com> <d3c461415e05345a9b82e6f995828c1ae64a4e61.camel@infradead.org>
Message-ID: <agt8JM43BlLPU-kr@google.com>
Subject: Re: [PATCH v4 04/30] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for
 accurate KVM clock migration
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org, 
	Marc Zyngier <maz@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Jack Allister <jalliste@amazon.com>, Joey Gouly <joey.gouly@arm.com>, joe.jin@oracle.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 18, 2026, David Woodhouse wrote:
> On Mon, 2026-05-18 at 00:52 -0700, Dongli Zhang wrote:
> > On 5/9/26 3:46 PM, David Woodhouse wrote:
> 
> Huh, I didn't write that then; it isn't September yet. Did you mean
> 2026-05-09? We aren't all in the US... 
> 
> Strictly speaking, you just misattributed a quote of mine, which is
> very poor form :)

But also pretty darn hilarious given that the thread is all about accurate
timekeeping :-)
