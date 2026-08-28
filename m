Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0FC327BFA
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 21:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950948; cv=none; b=CIMg0X5Faxvz1gmplBNrHW7kA/2EvaxaqjGOpZU8Z0Hwx62Vwljx3xncpS6euOFiVPnhNy2PeuroIdSMkE5P29ca8cTKV1/XWE5/AQfvXP8g2o5Dq9lVWkY6FMZqokkltIxKp3b5mCezJWXg5dmNPQvrwqubqyX2stC+aOIFNPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950948; c=relaxed/simple;
	bh=EBbufZZ+sAD2y0V21+jCB7JK65ijPEhb88MVaJjhjEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BV3jQoBOhdvx+nhcgpNoKwX5RsyRSCBYRQS6/t1HgfzmLi158u5kvx2R6M5YOHupSpavrsjnSjt5tPURqJir0VUNZfAk4x8yrLqn+/uCp6liW+J3SBHKOrj6mx6Mc7DDqwMj0GRHVY5As7Ne+vT4pqgVIYVr93RfN9qd9Mws/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=QFM0yykF; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="QFM0yykF"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-465e7ba7b4bso602809fac.2
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 14:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1787950946; x=1788555746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EBbufZZ+sAD2y0V21+jCB7JK65ijPEhb88MVaJjhjEc=;
        b=QFM0yykFakcDROj0ZxYTNDPkCd1psaEuxQYmDbEyVnH9heMHvJEet4awPLmmW8FG3W
         TgW2gSj/E97dRA5Qbu9kOULddW7Md8/iJTnvR21a0EifkJWP0aSDF+8d5LyAn2YiSrei
         Eq+/h0SEwuYxhslxSKfvZbCms7Ej2d1deuDhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787950946; x=1788555746;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EBbufZZ+sAD2y0V21+jCB7JK65ijPEhb88MVaJjhjEc=;
        b=rxIzcXPQWRV2wywJkZxYKG0DHxtVUluxlSt72PjffoXxgIvkkH9r4Mu3TBQm+k4MMq
         lAKL9lQ1EEvs5/7jLdSeu/0bVy7pEmH7XVN2MFqF/jec3jBDk6ofUXsu5neHxbRMvkoD
         1Huuqt3fOTgG+iuiSf/gHAmH4s8RvWBS5gWQf7JQZDPmQko4OTpJF7LbfAp4pW3G6/Mw
         Bk/S9rsoy3bqIms5nG9t9/+NHmro7YLeUPByzJJv+zabMiiAuBrEvapseZSPsv8t8B0j
         S20pYSJMNNnWdRmGyjXCcg+zTp6fk3HuaXxDQ8IZx1rHzIx8sHClVEpSRJrr0fr366su
         Ef5w==
X-Gm-Message-State: AFuF++lhyKfziRUm1OUZE0hMAeMQi/Yz+nbKAtNhSjIYwzfxMSbKnAiP
	BjnK9V+nb5XEZ0EHBKYEpAUYIUoPHI0QAJK8/6x0cZkaL/8GvXq2p5Ejl0mjwrys4pg=
X-Gm-Gg: AR+sD13sPPuEreGwnAZCy8HRwy5/OdJXlhHSWPpQTmxnqu6vB4OuTN4SoWd58GwpPXq
	RQsqy+DURcrMgnPCHMW1vi0q00qlNk9aNz4eZXuroRxjxHvH9YJL6F7GkA/sIQ7pSAFURWeBPIp
	fNY943F00MYyAgc08te+4ED/jTkF/++07dJI35Sw+Lt9wjVfwsaY9q1wZuzOTx38/RMSTF9T+8O
	4lQMCZFKQMEZ1X0uiFFoVrMp0J+JpbsB0SIDZLjegmK9Izt9ipq3JY0mBj72uC/IqFWnsuT5xXm
	E5PDvasyzwwLbHEmoC/SxOQJ90JDCtcD3Xu1c43/QhEwQCcVD8habBJFt4m15Ocs1Tb/O20DhKk
	A+fa5g+XGzTMuYiojRPjchwne18bmj1CN/ll8WYXat3B6RmHcRFcewGz2sw9V/SL+eIQXk5nub9
	7LycFo9n8LOmN7JtTmRuUWjsdgBZBJ/R4OWlJdJa+f5TBF298tSdQ1D87YtNtO7O6MmejXN1846
	7Pb/iGVmIQR4z7I22K64UIf7AokW6JuY6QBnzm/wWo=
X-Received: by 2002:a05:6820:180d:b0:6b0:589e:42f4 with SMTP id 006d021491bc7-6b1c66b745cmr9469438eaf.20.1787950945751;
        Fri, 28 Aug 2026 14:02:25 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1ce14f77bsm2321969eaf.7.2026.08.28.14.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 14:02:25 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:02:21 -0700
From: Kyle Zeng <kylebot@openai.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Restrict saved GPA writes to hardware write
 faults
Message-ID: <apH3XVa_uzt2ieGa@com-75606>
References: <20260828193055.59623-1-kylebot@openai.com>
 <20260828194912.E4DCC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260828194912.E4DCC1F000E9@smtp.kernel.org>

> the hardware does not set PFERR_GUEST_FINAL_MASK
> (as this bit requires GMET or SEV-ES).

Is that requirement documented somewhere? AFAICT, these are ordinary NPF
bits. Bit 32 identifies a fault on the final GPA, and bit 33 identifies
a fault during a guest page-table walk. Both are already described in the
Current AMD manual
(https://kib.kiev.ua/x86docs/AMD/AMD64/24593_APM_v2-r3.44.pdf)

KVM also started preserving these hardware-provided bits in
5e3525195196 ("KVM: nSVM: propagate the NPF EXITINFO to the guest")
back in 2014. See the original patch (https://lkml.iu.edu/1409.0/01003.html).

If a CPU really doesn't set FINAL for a final-GPA write fault, then yes,
falling back to a software walk would be a problem for SEV. I haven't
tested this on Naples or Rome, though. Is there a known erratum, or an
actual EXITINFO1 value showing this on either CPU?

Thanks,
Kyle
