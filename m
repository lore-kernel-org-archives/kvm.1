Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793196373;
	b=tXnBcOiIJkyr78omdGOfozSOtSNm40ZQ6pBYksEt2QnXifb5bys5XmQtUMKEe49mdOQ5
	 EyVO67LaTEmKVGDjhAtuGchf4a+JJzaRacJku+WGic7q7Ak4xP/bv4Cmu/83/gVZJ0obG
	 A8QRZG9fJ+6Y6bNH+bCo6shZ0sfP6RO0QZUJ4bHxocYzwAL9uZsLHaKLnubYsLyUq7On6
	 oq68ywlga+z3zhwh3BynFA9+bvitp3tKME4zZkZH9d/0dpgSjVWmogep0nUKWjN4NBfkm
	 0mUl4kJL2gWwO3q92jn0GeND2uAZRC9psuzKzlUNFaeLhoMCTaXKjLk5Mc1EHWK43OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XhVUa5jPeCuPjlkTbV5ixpr3E0TOAw03LN9aAir2Bn4=;
	b=lrqdbbxMqCB19+GvJwQi35ffKs9gPDdVwAMCIeqVgjO94p0uC6p2dWWuvUJ61IWZrw3M
	 NaD+ltCk60/T7zSmdLkIW39+8iedCk510bLfTaokHM9iurllKY6MYGdPcwXGqcVN6G1oE
	 DrfXgspDnxQacR+/sfglU/kpZUogvpag/1HCMwgd/fE/WASVqzXPSmnauGCDTf9V/Dktt
	 Hvy9Cm54eIIlr1dq68wjyf2QOy9OoGSEjxQZ2RisbJj1nELQdDBOKpI/wfUPe1Ijz5GYB
	 XCztA1QMyuUi9XY/GyEfJFEP04EVe+FwH1yv2wd+X3/8elRyJ7/jpWeZmAazSfvvSvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eMN0rMVo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB19E606A31C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 14:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB19E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eMN0rMVo
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso13620a12.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 07:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793196371; cv=none;
        d=google.com; s=arc-20260327;
        b=L9RJW29PDlL5sJMgcbdhkTBpK1d1C9Or8AxZ3mQETr8R3cN+9iT+7PPbYUx7khAvYq
         3/vOeE6/xQ5GvIF6UJI/P6ZAqvlnwNVWmPAjJlz5u0Yb5JMOFVFB92j8CKG4VHSvGAol
         GBbmHaTt9Xxdwv7kr/DnE0eWJoXYL8gXOGCtnHi7UjZf+/mD8fPBgQQblsE0phGndrGj
         r72WdV7Fb74jC3zEaOBYd3TJF/j/7BjbHXeVybTU6xbuRISNi+2LTSwexLnPGE+1cDDx
         2J6t1qYboNez7wqHvn9TVaE4N9/NWZ6pTCc8fJq0uy1U6tyipxsOdo+2ij0cXxuaIVwM
         bqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XhVUa5jPeCuPjlkTbV5ixpr3E0TOAw03LN9aAir2Bn4=;
        fh=stAckJLnEP3wmCUmXMF10n9dxwh/gfQcNcXMb2t9Joc=;
        b=Il+VBSK7ZklSLikX5Q5VnvIhZUFI8KL/B0eR2fgT8XMfxg/+Bdpc2s+o4L8b5H03Ov
         DchoE3qC4WQvxVQq+mA2hxx+JGP+uzU/tSgHpED1Rh58lsheQpV41fDTaZ6G8l543yf+
         ek0xaoLqrG4eplEOkBiiWexbyveCrwn6ifVM31Qpv4qkhwVt5PMAAJu4D8PiFjnpzMmD
         gsf2MElx5XUY8jTTdNtZpg24ukL/xwlvpBDz7PfaqAsZ8UhpNWgdZ+o5Q7NUtKqXzuHH
         D7MSSG0bBbepLvD1HWux8UNBMn4cDEq2xNn1pPuPoD2B4+QSgSF79v1EvFDVs6M2BiL5
         Vqqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793196371; x=1793801171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XhVUa5jPeCuPjlkTbV5ixpr3E0TOAw03LN9aAir2Bn4=;
        b=eMN0rMVomcbHDoi1Fi3sNeSNuwHWSCwTftWgAefVogJ6CuyaupZy5b9Bt3gyV74OdD
         M4xMJRLRiK+vf8zD4/9nnq4JpLANGh2NMN1TALhUTNuTYXi40fNcmhWDSPpraAmND5aG
         PBrHye0dqjRVR18VeJwzqYOxCZYAjMGhTtYG2sTqCFm9CeghId1SRblGFtCFiMJXZ4B5
         YvaI9nyNnSpjniiZB1ZLFuIvNuqhT5Pf2mKRzSS9QVSYIYsizq7VgsZdL2yc7QCQf87G
         N3HH++mL70ujXo53FA8dbCvjdLV/nV0TZ3JuB3H+e077Tq7apyS2kC/dPgoE9UWylj4c
         h2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793196371; x=1793801171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XhVUa5jPeCuPjlkTbV5ixpr3E0TOAw03LN9aAir2Bn4=;
        b=Elml908pd5tixD670d1MnzPWntu7m/mCYOtCgzeQbe47Jgfjsayo15T/bFbeuT+2OB
         X2eXHYn6MPyfHu5m7h9PyPNf+wv3ZkYuuLG6tJ2FR6c4JwGGDNrwWby/aCwQRV09enEU
         AvHHMoAMAz1n+ThNjgPbzH83wc5UyOsjj9BXmPfXuiAPFVMzPsmhG2YJQyj8uAhsjWCW
         vUyEWAHs6bmOocZ/UJRpscwPiayP3Al9ZSbYjlYw7r01ByCVG2KXYx2VNZj3PE0KE5zd
         MfEvvqDtupGE+t3UJM62N4nJinxvXFh8Fz22zae+agESOPYEkrgP+LUzHww+gCml0562
         Q+zA==
X-Forwarded-Encrypted: i=1; AKwUvBwhpjfJSP8FR3dsY+sc/fNb+i197bMlUr1bsf2OjAjUAGamyu0XOFCEy96MSK8YNZ6aWJU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLe5hOi7E7ZSNRNo6iYDWbsNG2Qw5ObCeQe8HkZxMI9QXWjKrJ5
	yQS+Jf7RHyKQ/xJrKl3kJGha8D2kEvLyeesXmyhXfszOSJ2k869GbO1sjQXxCIeSgb1jRKfJsgU
	8z43rvWVAui4CR78DJuCfGokX/ZMbTwe9/V6UroiP
X-Gm-Gg: AYBFou3so4vG72Qjuz3/iJBlefmj+yHE5GSOvW3suYfqof+0GNHv1YbKWI6FYLuoK94
	9b4HlC3/uN0waunsSrxvETRd01Maw+UgZNrF7JYVht0leIVZRFkQpdbjTy/nFoBEnZ1h0N8BDSM
	1HN3kNKdQNkkXgFk/dx2wOC4rWYXSkOh/XN9+NK0/4DlA97jcLahsYwpvtOXgdHK7HkQoHCXtRZ
	KJt5aa1ck6UThhR84iT3021SN1bnd1JSjr/LxZIWLAT2ZoPe0WudEM6ZVjRSh5uYa4av1HUl5ux
	cWaFBf4XYCJI48NPiZo59TOXd8vC1kcYVEt9TZkPbZlIh7bLNiVSOvcaBfqjpGLT5j44yxybdai
	Hy48dpXWFDIeAh51KOSMHT97OuquI2B2mx6hV
X-Received: by 2002:aa7:d516:0:b0:6ae:1503:5a27 with SMTP id
 4fb4d7f45d1cf-6b49b872a5fmr76004a12.8.1793196370614; Wed, 28 Oct 2026
 07:06:10 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-4-zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-4-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 07:05:58 -0700
X-Gm-Features: AclHuK_aEVnfXNRRUg-lFYwMwKWRYKASiTuGPMHFAH2Vod9MbJchX0sY8wu9o0k
Message-ID: <CALMp9eT_iXLG0csWyiMHPKzEuu=a8=aXNOiu_uSbzVcykrDp3A@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] KVM: x86/pmu: Rename reserved_bits to
 eventsel_rsvd in kvm_pmu
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:48=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> This field stores the bits that are reserved in guest IA32_PERFEVTSELx
> MSRs. Rename it to eventsel_rsvd to better reflect its purpose and to
> align with other field names in struct kvm_pmu.
>
> Opportunistically, replace the magic number 0xffffffff00200000ull with
> macros.
>
> No functional change intended.
>
> Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
