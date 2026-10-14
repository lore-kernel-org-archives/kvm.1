Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249454281B
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990468; cv=pass; b=c0lI3xCBJKH3ip9pT1niWdouYfOLPMx7BpUV5JjFvm7/k/7rZsp+5dQ00KJwoja3MW+0B3k07LPjCPOSpGyDbr7vqvOjDIZFCgvuAkKdPWQxdn8PVSBPofn/1ZG0HYaXO2Sv00F0LGH9FKmuyLHiwNjiF7BjZmyuW2TwqTjBGaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990468; c=relaxed/simple;
	bh=5bNzJeuDWgzOabLsmNCJ0zffQhzs+dofJPQ9U1sBXvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LokBMi92fGxPl9r4yCOT5b25B9jwhzJaon/W5neBIouiILtZ1jN5J+scMUclGD6K+YO3wSH71GdTQZgNo6/Xev19CtWFfYaRPt9Jg5/46iEso4ounqyy7LL/dFvrejVzJX18LmDUa2rb55KXlUdz4B91ztp3fwNbrIVIM+6dnNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1WKl78u; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1WKl78u"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so43728a12.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 08:07:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791990461; cv=none;
        d=google.com; s=arc-20260327;
        b=Zzu1Ns93aKzyMolOTtx6hPpaIl5AvLcL0MmKZC26w32bydt9mtz+jR69R+As8wW43+
         QTbtm5d7nuVqefZCbk4FnJIYuhimlLp+r4bVl2uL0Z/irZ05BVnBcIklQMuX+u8UvYXv
         0VmIP4noL24luCd5Je0DLA/RJ2I8CkUwaieMQYYTKLi/KsGUmm7/Wi+BdvhAVQv8GEIP
         2eCi631A3Sa68Vw+7FIIF4pW8qtvySkdnfbGVKhs4WNm6TyHJffjFRUKzC0xxbCXHiBv
         CWKlq409V0SzDwGt5ywSfUCfxvpW0mngmkdAqB+Pp5IY+NYiPAfEdGjERzBdk6Ie4zD4
         GxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5bNzJeuDWgzOabLsmNCJ0zffQhzs+dofJPQ9U1sBXvg=;
        fh=PAQE8Z6Wy3xvun/q1qPwUL/7kftBazTbE1+7c6S0cAg=;
        b=XYZ30RwSRAxZLGvBZuyuNfWSYMoh7fyfNzdWAZNa4y0OQwuvF46aDaKp3MqqTWCDMX
         7a9+6gccxm39AzGny9a2YpRLSLIhwY2KJXPiDPkMFAihXNT6naZ/B0A80sXoWhzdumtF
         pcgx8o3gupIV/RJscfgi77AVUzCtNTmQFFZW0uW6YEdxuSwi26XtwTxgCkp3XEuXNFOe
         2a/iBXhQcMq8e+edtF+t5zjKQARev5wAxkm2vKmCdtplgVvA22Y1ySAl9RNZb/DlR2FO
         ZJrs5KU5/4XNf9KW0LThZJMw1blv1XQ/j6NyFtefqT8lIwWlQ/Oadrpe8QNQ2lJoe7LB
         cxzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791990461; x=1792595261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5bNzJeuDWgzOabLsmNCJ0zffQhzs+dofJPQ9U1sBXvg=;
        b=O1WKl78u4l0pg/uAvepPUynw1yanWeiT48sDPOZQkw8pWVSLOCK5PCClh4VtNRlmM3
         FPdAj7sdUuM3AviK9kKLZDBFl4auB/YddbjbkklwS3EYALLUVmAe2SEmpUl6R+b72EvR
         ANzf4soCQsHZZ+5JI5Hllv6mAQcjOAVUVgPL4HZC9nAPmrjJrOIxGKnpY2Vfs6mWjijn
         bqo7pp1SfajmBSPDsuBWNglhWUsBeU7iDT9wxWbRIXj/Bm0XvesSbrxoyRvANBFDNRu+
         lMMFWrUiSiIHCnNRvLrWg4nWxh0cz5MpN6otmtlge5xLdU/s9pvdtkpBs7vt1rZorzMa
         0ENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791990461; x=1792595261;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bNzJeuDWgzOabLsmNCJ0zffQhzs+dofJPQ9U1sBXvg=;
        b=Osf1btTyMGtCYY9MogpEy4cuoeEWpzKhTHoXkhY35z09GBcC0VdLbPHg1WL+h5/a2a
         08LXdVf3L/8MLWfLYOBmz2RREW/iDGj6wotEguZeDfdYC50d9g/V8JJpHgY0lOz58+pj
         zBD9A79fqf+ieEMy3T9Gz63uf6xEoGgobitkJoSIYRrA2ylysoH1luHwUkPKEf0I2W0n
         IX0KCqm7nxxaBRccGH7oOSfnyl3mh4XSx+s/Bhk92Ewd3rmrHCbd8vVRSCtbIVK905Qq
         nTLTKMqplnuJMrrwkDWcbL2/6sUI6xUVuwEGDgKtHJsBMnYVBFr8AcXSNtAOqBbFOH5I
         hCuw==
X-Forwarded-Encrypted: i=1; AKwUvBzBtKJn4Jb29xZhucdM618cSKrqCytifyLgbeglQeXL0TpFbp51TwgbQiRWRVsMJcYgB7g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtdoBUfGBm308dd3GCdZ6m3s6IqO+SFvEvgnu0IqJWc/IExVTE
	ZFFan3oIx2eXtP6ZKFNKwub9pifxANL/d+WLPMffjHOU+4V9KwYE/38ZPlKhl2Dp/c1ulS5tdkX
	fgrkFufrDmJTS30HRqIUAdQBWRaKiKQpk7jheYdJl
X-Gm-Gg: AYBFou2V0CAbrnCG4pkiIH3G2Zqd/reK9MhC3thaS7fLdQuQdnH4dbZB2bnNFaY7wJ6
	XvUnoKIclyHkaiSv7ZM4fQlazJyVkrNDX5CeCHuDC86w4VbJH8679koi6A30ZCUiJkNGpaiwm7q
	M/tvvH88SpTwws4b1i298W6wkG6fBy+aiYOHMr5U35sEub+AeJYDIyTlJ/CRrIFl/nc/feJEY/z
	mWtjqa8N3QA5y38mdaqaqKyg+PR6hO3CdJWpqSLdNbTlu+oUjmV2iY+7XhPNHATg2euLDSKqo4d
	6oS3MrFM+bOJIoSUR4WM57jts4BBD6AM5jZ57UDvmxCbpni1SMXobPg=
X-Received: by 2002:aa7:c74f:0:b0:6b1:a517:5bce with SMTP id
 4fb4d7f45d1cf-6b20ab1840amr40855a12.16.1791990460751; Wed, 14 Oct 2026
 08:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-3-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-3-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 08:07:28 -0700
X-Gm-Features: AclHuK8NO6iuYgw8VyNnfWDxbKtdNmhMVsNN1b0pfwT8hRS29kl-cyJUsaZsV2E
Message-ID: <CALMp9eSgc-aWT7j9Hqd0a-tBy9Su7dVSx36pC9T3nLa4Mt9q5g@mail.gmail.com>
Subject: Re: [PATCH v3 02/27] KVM: SVM: Document number of ASIDs CPUID setting
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> KVM arbitrarily advertises 8 ASIDs in KVM_GET_SUPPORTED_CPUID for
> historical reasons. Advertising a small number of ASIDs to L1 is
> currently harmless, as KVM (L0) uses the same ASID for both L1 and L2,
> and flushes that ASID on nested transitions.
>
> However, following changes will add proper ASID emulation and a separate
> ASID for L2, minimizing the TLB flushes on nested transitions. At that
> point, a full TLB flush from a KVM guest (L1) would flush both L1 and L2
> ASIDs, so should be avoided as much as possible by advertising more
> ASIDs to L1.
>
> Increasing the value advertised by KVM is tricky, because a VMM copying
> the number of ASIDs from KVM_GET_SUPPORTED_CPUID may perceive a new VM
> with a higher number of ASIDs as incompatible with older KVM (which is
> not true).
>
> Avoid changing the value advertised by KVM, but document that it is
> essentially meaningless and does not represent a limit or a hint. Also,
> more-or-less encourage userspace to advertise a higher value to avoid
> potential unnecessary TLB flushes from an L1 hypervisor.
>
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
