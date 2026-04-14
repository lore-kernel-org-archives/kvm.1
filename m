Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A043E6DF3
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180779; cv=pass; b=EQ9eiegkd4+3bWRiygoPL4U171judnIBgz//BM1wCKdKbd0XgrbJmJIrM/YHcRp5TDdXfJXW7K+z5+3EkAlWqHC3NUjYz7HN/VPDyLpG6ZpeqIbGLmLAJVawiG+7E1IEpoebQ8PDUUbfjvi9ucaU3lQBtltHBFaJDEw3/KiGDSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180779; c=relaxed/simple;
	bh=pvwmtT4PA+PkBkXtYobPu80ZJFdB2W875yPcdEQEZHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCDDK5fmUS5HVjmfnAO5x4iNsvizFe1aiWUJEhV9oi5NrZiuVyfMuYmV0k7xUmc4UFqefY/4rqfZo1bKUGMeC1iPLtQbf4nabVXLeSI317+j+4ACDhnms6Z59pjHz9n7b9c71LcbGV5yD/9vygOZ76e/Ksbq7pmT1+91+nGdlX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZAc3vXlv; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAc3vXlv"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651b6a003f6so1690292d50.1
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 08:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776180778; cv=none;
        d=google.com; s=arc-20240605;
        b=jqFMcC/znAEfOZ6hFtsP83UZCqmT8DGAf5q6WUx7pd4wX14vf949qyh6kLL8IAdjME
         KzSU3o+/UjP7sUiRIMtmNWMBzVNZHjdZzmQ/Q/7D0wzszLOP7h8KwQBJIFJTE0qez2G+
         Tabv19c8O7f/ncc8me8GF+YCJ8OclBeSo9yi+NH2IxFVBiZlbO2lUHiYYoVGZNGfnkbg
         JvEv4bEZexLY06hlMNeLO0JiHxqeE5oDW5+WyXnH9jVDGZH30484ZeuOlL6fgV+s3UZT
         A5WvqemTfqH/E6kAZKbjJULGO4u1nKouzAG+OKFU4yim66OxqyCWARzJRygVazdQfyFr
         VgPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9XcKb4ic8SZ75FN0QhdHOTzfREVld7nJw/v1GdoJ6P8=;
        fh=7fPBey2k48JnoYikD/kzAUIaJyM+GrNzwLEGmtsAI2c=;
        b=TrNUT30UzXa1gJzEoKpU0hvNAp/alc6rpiMW68DlfWIyxrFvK8z7SnrUV4Qo7z7yN6
         Xys76+nHjoMIb5fINL5apOExN4PpnP7NNjWP57BZ7eb0UDLhgIvpXSYE28avER7hmm8c
         i7WiOZaYK2caC98BSZyZymZp+1EFDeFwjNiMpEc0D9eyPvmc7E4GP8yXv3kfI2t6qWKo
         n7fnmxIqi7uZVKXBfbsYKn2pxHan8nkkKcSR43rMuWCjlaL721m/qlSu1mP012S4K+4T
         MuAaJMpxrfibiaQKYfwmP7O9ulg8kBtAPl8urym4SgSJvdQ/zRmg2G5P7rolaejmPU20
         NqCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776180778; x=1776785578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9XcKb4ic8SZ75FN0QhdHOTzfREVld7nJw/v1GdoJ6P8=;
        b=ZAc3vXlv4ekQRaG3N2GjZnA2HwqImuJEMbkNwxOgz2TGAn+mZMQB25VLo4BJFsYeSS
         ZMx+bsnCoIrEhdDm7I3fXlR2ljk8hUOSg2uLP4p3T5zWWSon4NjiJfNT6ffXrOCwZp9U
         WgdHlbSVMCVkWcHujeVi7RMUpAz0d6hOWKn8/aacbtzFZRVt8GtedBL4O2lKgcEWseC4
         SGGt1yX46+iFVTx8WowBultJMU4a7VWrwVhOjUQw7dFmhx2vfry+f6eEIk4sIT90jXYE
         +3A2CD6Xsb3utJZBnutPD7RJk+8tlmvf6tDZ0J1ijlMqNDQ9G2FOeY9rCfJHQj2Tm0dI
         LY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776180778; x=1776785578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XcKb4ic8SZ75FN0QhdHOTzfREVld7nJw/v1GdoJ6P8=;
        b=N+5my+cICWmOID0f+ipGqtnQtNMxAx88w9SjlT8F7Bu+nRjbvBOLr+ighk91nPfgoA
         AxhP1XBoJV3a1gdi0uAI3SxndA9aDNihTfR7L5BKu9/uaKNMxcebNmebiAFjCGFDnwP9
         mgehG7ruO2DkCislo0KkMHMPoe7M+LF3GkyW+6hQ8Ff7wyF0b6wRho1H76UaYZ6Kf1/n
         QfLv7xSdmCSAqBZnDplQOZ4Wz26MtgTbI4suuEeNUUN2JMF/54k5J1yEJOijJ+j9qpPR
         SyMNRUQN9JIC/cEt7vYj1E84u71YfF6HEQZfxhV/UKgMQqtp7gHy8Pg2j09txyRNLGlp
         TK2w==
X-Forwarded-Encrypted: i=1; AFNElJ8LAMah3s3Qm1zAEhHiq0mdHfxPv/t/CMmLEJjjo4mXVZ+W3fDVIv2dlPF32jNfJKtpGHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+AnApgwTx5kSRmAtf7QpgqkpwHRa6XdTPvp8XGi6TQpqix+Wl
	3hLA1dpmKOkop/mw0bpI6iYTNCP2bnewOJkezARt3Rizg39u9ORR17LZLvgN3xYpjx8/AlNOjAc
	A3P4IOp1/RQ/UVpS1tslWSLV55H0toJaaJvgzM4ijvw==
X-Gm-Gg: AeBDieugCOdk+EGQM+95aIUtdS7LiVfWPW6SVjtT6/VhwahMVgAZPYjHG0/KygwfryJ
	BaPsQHo7SFRICPs7O0GhF7nlv6yBJ0oz4xx9sPmdagTNya5z4SEzsNGEkehLe5RCMO+LMi+Qzma
	osapXDfKRZDpKltYet4O4GuseNO2TVkX6CfyuFFWgCXaCLy4uKV2AOrWluB1TAwehcKovYfk9vI
	Gw5FbAhUBt779E2ESS9qH6QdTNOFLjMHfMLZ0WrhRnq/mPC5iWvIHUykcCza7XNPStluKSYSx42
	/6ck5/nWfoN4TvZ5+DwmoWVgIWonvTzBJ2RcLRggiFhWOs/+R4Rql8SK6oWPsoa26GQ=
X-Received: by 2002:a53:bc05:0:b0:650:814:8124 with SMTP id
 956f58d0204a3-65198a88374mr12857206d50.17.1776180777436; Tue, 14 Apr 2026
 08:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414045911.63662-1-anisinha@redhat.com>
In-Reply-To: <20260414045911.63662-1-anisinha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2026 16:32:44 +0100
X-Gm-Features: AQROBzAtyFB4kKPLg59FH9PyakIZxRSXCgPUtK1ndhEU2FujvTw9Ai7FAomvh4M
Message-ID: <CAFEAcA_Yr1y2fHmMSmcKm8N=_s-VcoFYsSa0W-+nROg-Mk0Dew@mail.gmail.com>
Subject: Re: [PATCH for-11.0 v3] accel/kvm: return early from
 kvm_irqchip_create if kvm does not support irqchip
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, 
	Misbah Anjum N <misanjum@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Fabiano Rosas <farosas@suse.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org, 
	qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 05:59, Ani Sinha <anisinha@redhat.com> wrote:
>
> During refactoring of kvm_irqchip_create(), the refactored code was returning
> early from do_kvm_irqchip_create() function if the required essential
> capabilities were not present in KVM. This was not translating to an early
> return from kvm_irqchip_create() as was the case before refactoring.
> This is because, do_kvm_irqchip_create() did not have a means to notify the
> caller of the lack of required kvm capabilities. Fix this by making
> do_notify_irqchip_create() return EOPNOTSUPP error when  capabilities
> are absent and then the caller can check the return code and return early.
>
> Due to this regression during refactoring, all KVM guests on ppc64le hang
> immediately during startup and this completely breaks all functionality on
> that platform.
>
> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
> Message-ID: <20260413090010.60339-1-anisinha@redhat.com>
> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Thanks; I'm going to apply this directly to git so we can get it
into rc4.

-- PMM
