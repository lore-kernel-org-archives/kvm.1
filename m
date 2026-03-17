Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FA4372B2D
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743679; cv=pass; b=rMtKoVSSR54LW2OuFdobqHU55wAk2uS2XWPGW4cfw7+otZsX0QAKchJbyEBQehKbl3VtTHiWoIHI2hQ3IXuuo7G0wCd7g90iEHyBGASiG9tOtzTJcf5JQMW7PILwISFogW7JCrKv529u838ZXKB5Lv9n2ImebpmdciVYBnnEOBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743679; c=relaxed/simple;
	bh=Ct1tVEpEh4ae+UzwFCfZDfYvJiNypQeG6UnAogEym0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxR+XPDqEUAOP451iynxu1YMI4BuHrudRQEIaeYJS24K/HFp523Vd0PcVnVfHVyHACxGSaRewRnY123R0GdZ7CTDwHVqt53Hym5AvFXLuRh0N83/31mOlP/f2KyrffNqhfSEpuHBZFCakBptao51PUHr7qECIBNmp+Cb2KmN47s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCvHN7V9; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCvHN7V9"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50917e02532so68648571cf.3
        for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 03:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773743677; cv=none;
        d=google.com; s=arc-20240605;
        b=YGvkjOnil4EjXlxwoKCSdmNbPZk62oUDo04nP//LVsDdShqET71soEu/l8cUols7VA
         la34pr+wUbn8bfyIrfotJpcSKqsHf78jTFGbx0uJagEVj4v7ay3bTFllyiAgqn2Km+Sr
         3TkpGlV8yBLIOieEXOMpkkHgcYXX+1oQ5ULxVUBHh27qCtVvQz8DtqPWqhg28suIr+th
         JpzKtnsLmtm2cwr/8SpJPogrWkwM+YB1XOydlSF7uRW0FS5YRBIwCGIokSZfsHz9tBbd
         0vCO3N2r9/pjXCrjDExe7npBnCg8+sTvOgT4H7sEzKAMghFlqHsMg/MauE0DqEGSdcsj
         ti8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YEALIkjEd7E2l9VZKv/d474jTdI1vW57SKSoYPDM85Q=;
        fh=oG8vZNECx89DIzGedX+A5uvzfp6zQI6uJ58qhSQu888=;
        b=EIFSgAip141kWlZQz0p53yGdeCgNIiCW2zVToRTZOZSXKDoqKvKh9aIWUbcQV4Fo10
         6nHhBYprYIoMiUBMzNzGvsM5SWr/oHB7OaZQBtd6tHzaFHqKMbTfZb92K3eqm85f9iXb
         ks29u4PsbbVxGG3FYD9FzOZuCVUWuxrnBq5Ty1YQQjw/QAR4pZSbqfrLnCjKKpyC4e+W
         4cAxOxUWGAWv06/KB+uMruYGeXW1WwbAs5fJ5xnlDz2bMUWUJSPX2fFxxt2if/orG5h6
         mHsaP0qqkyP7a8SbmNTN4OIr+ZDK/4Csxzb1w0teAhM1if3LLmEmuLB7Kz46S8/xuh/F
         q8Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773743677; x=1774348477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YEALIkjEd7E2l9VZKv/d474jTdI1vW57SKSoYPDM85Q=;
        b=jCvHN7V9TEXZ+BsRSzXoPdQsl4QqPi1f9NN5J3wgM+Mk+Fa0Kst5/FEpAadiV0q5QX
         KDVMkz1mqf5Ray2VJJs+oA4RsYv8e5d/HQO4TO54+8MrTZLSQllAX3i0v4X8l7pqUz/A
         9dbhFkW9jMcXxtdDCGSIlwoS5c+M3yj9b0Gp9PgZCWlcF4L6Ip/+d2YtqEfyNH2Oydwa
         zUK6yZvD7q0GwftXdPZtyxSkHW23S41RiAcu+DPCHRssLXbVSSNTuV2Hp+vDskGnwJah
         Qx1hgLQup9jHa5vR1h7KkWdhE7Aex2wNfmuT71DAdoHK10kj+2DMXyifWitSkS6qKoEs
         zukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773743677; x=1774348477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEALIkjEd7E2l9VZKv/d474jTdI1vW57SKSoYPDM85Q=;
        b=rwOAXI/qtvvf+7owESHKYVPqK0fH1HT3w5MtVgDO3JACD+6oRhJhgzzB659Y722bHT
         5dbmRySBSO1CccOARvXIUGM0O1fdGTmEIBMWbhZwWH47HwxQ2LK5OU3dqH1buINdYOEG
         J/S5rayaSQuISRt0lhY57no6Fzsbr3r60mQP95XUSkcfZMrPISnqs9F1Zkg8ouYDN/ue
         XMxf3HrYygvypmJtSCHR0zORnpJvQhfY/MOY/FMZS63TqwQwyiGO2je+hEfbIBz57yYa
         I0wXshGhxl4m0DRFrPod115gUtDfiNOwhLw7+z1LJjIX4aJBUaKphP7TnyzZgEJGOXgc
         fHvw==
X-Forwarded-Encrypted: i=1; AJvYcCWL2C9RdMlEqk7/jnwXapfj5W7vKVoKv5yxCXozXv9PbSbzbjyzpm9bUGyazyu71c2+Mx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Go5AtF0XWMhoc8oZDu3Thfr69h/vqZi8i6gy2bKUSXK197xF
	cjAXtmpf8Fg5ItFZMHctmp0ZBr/q5SjK2p5A6QtAc1HVjHAhY7clBj0zF+uQ7sGQOTWM2xx2/ao
	kCGNHh1Fo54MBdePv3dIq37we9H1GnHltTZKTpUn8
X-Gm-Gg: ATEYQzx8ZPbFRfNlO8AwybFU/f8mpCidiX/0EI3xk75eapE5E92DszfUG+I00c2maU0
	BNr8X32eyxt/G5/d+nkEA6lg7Tc7/3z0ccizpiKKAimxoxDSyKs7oQrQh5fQ9EUoCLjbpmIYbmG
	ezWO07xEgcw/VUwahDc3SUrcw2u8Uc8KQjUbpxDi5BNngQELatcUcR/GBwpq2sAi6bTRZ73O/B4
	SH7/b1rXAZPJ7Plk3C0yK0/oWQT8c/rV6s9kKd3Ka5SV4PgKJ9Lp4D2NRXUe26PW3tMmUk904Gd
	qb/3E5MlCxqc8OqOkXdfUhbjANhB9WWXO5CB
X-Received: by 2002:a05:622a:178b:b0:509:33b:ed6 with SMTP id
 d75a77b69052e-50957db5711mr240125391cf.23.1773743676160; Tue, 17 Mar 2026
 03:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com> <20260310234829.2608037-11-seanjc@google.com>
In-Reply-To: <20260310234829.2608037-11-seanjc@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 17 Mar 2026 11:33:59 +0100
X-Gm-Features: AaiRm526Pn3X5wuLRL8qMU0-mhFYGEdnHj8tGSNVulkPb22nA62_AaDAQFwnXDw
Message-ID: <CAG_fn=V4ZD8x40sXx2Ctd=LGzQEaeRMJF_yiA8Ekw2ZzuYcSMQ@mail.gmail.com>
Subject: Re: [PATCH 10/21] KVM: SEV: Move standard VM-scoped helpers to detect
 SEV+ guests to sev.c
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

> -static __always_inline bool sev_guest(struct kvm *kvm)
> -{
> -       return ____sev_guest(kvm);
> -}
> -static __always_inline bool sev_es_guest(struct kvm *kvm)
> -{
> -       return ____sev_es_guest(kvm);
> -}

arch/x86/kvm/svm/avic.c is still using sev_es_guest(), isn't it?
