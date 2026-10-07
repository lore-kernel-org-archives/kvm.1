Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593047606F
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382838; cv=pass; b=Eh3RUYaOeZAy0cPqXW2Z0Uw1NPs6DzrziNb9Sebs1xIL/V03KBERefObKVyfrQL3igA4bpdI0ebCp9R4cZTO4pf1zZFbC4kl6XBJZgWET+oaa0WS1EYBkK00BXM6QjkVLX7dkBPLJwtpLEDnRyAAhVrSyD3pSacq4MkXWuDn7Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382838; c=relaxed/simple;
	bh=o3uLcb/w+UjgedlrqzsxP4CDLrNZM+eCbg0hqnND8A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHALdLRWYi5IzywWoRWKOme2FQ50xJXg3vlyr+vOk9JXLt4MrYOuUDQpdWUZcbc+Yve4xYuQ34ZQygso9NxbP0h1S92flZtwCKdF5NPouiQV8oWMwoEIW5qDz1cWVQx0ZlD98nW6aD2pbiFq4gkJSEFYZQgswK1pFnk2Bh6vbmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZAmsLf3A; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAmsLf3A"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5ba40832934so7329e87.1
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 07:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791382830; cv=none;
        d=google.com; s=arc-20260327;
        b=dE234tAVhbLgoI+mPFUcs3CV8qHUSrqPHp9rW3MU8rp+mRVpOEMWYqlufuvjtgNBol
         mMGjTy+n3KWFfQofButoWaAQHy+fJ8BO5W3X8PDJn4zbL0zPcErPzNPNwymJKAjeznZx
         jCWuG3K08Mqla5aCpS3w9sjwVN2qMDySydxfZcp21GjZTurHkxtROk4LR6W9rbAWR4cw
         Y2hnUzfxa+2VClZDrzG5TDSoHOCImb/7oRKcj+LJMjT+YM8uRnBXKcvYLOhaz1Qj7miS
         lbUtamNKlBdGZWDwerYsILAcHtjRDEhECiDGzQxmSlnLe3/+5AA0tQQrE60udIxYzvY9
         PBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4UyXA6Kbx2RrlHyZTfn8yf8h54TNQENLjWNQqtxe20s=;
        fh=rnIkUf6r+pm8oCQPQDOHPhdYLJEIYxB5Eh3hMNjkNs4=;
        b=PeMXShWGd503qaeKK+k18aA7GqRLWouPaRXGZm8lrpycsfYDQC+gOZ4OOrGjD1RrNK
         2KQ7jXStRmDnadYYUEI6L4/fbv2TStMd4D1Wn3ffzU4ZucObyBmnmzjlB+JIYuEALQkZ
         4qtKC79eiKasoce5H+MBSbDvtw03wOL/5YkkABibuDN0ijhSUdqRcNqv10Ef/M6en5+o
         KneAECPLNGLcUZlg1wuE828J58UMVBBwU0nkL09YQx09Ts9e3dDkGvoiI/Cl3LcjDrtF
         ydDU9bg9Ks52V6FNirwrqbwGLbZUOdoCSwVZ5fQFLobtbz0VRRhpRgatlfrAeZma3D8R
         y5Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791382830; x=1791987630; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UyXA6Kbx2RrlHyZTfn8yf8h54TNQENLjWNQqtxe20s=;
        b=ZAmsLf3AEfxRGGILcT6b4JTHQ2Gnl0qh5SnBSieL70Fa1t8pKG3XCbyYkIkRKdlHuH
         eQFVG8H0G2JTWOA3n49ILD0M7V1yB4NQuFZaRv1igPMVQd+7uYDPQ6QjRrCm+ynNqc8D
         xv/GoB0z0ttGP10454y8QaaAZaAl8MlVKV5T47vICAsrrzurucVKj5zAHzwQL37BhBAX
         058gNC8h6MnUBqyD9tIOxVpzVKSWBfXaj9cXUU6LrVPZPdo6hUKdiGIQdq3WQjWej5s4
         Vw3aIvEL56150HyyMEkclaIxynW7vcMZch8yUuNoHlNhZ5UbjaPNkvOFj5ADaki+NCQH
         hOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791382830; x=1791987630;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4UyXA6Kbx2RrlHyZTfn8yf8h54TNQENLjWNQqtxe20s=;
        b=fdQM+0QTx9lBAhoj9Zcfok6FovW9OJ+0Y1BUKlR4sQAgvuOiFWbrXasLW5gwBmdG1g
         8eZCDvc6pLQTKNu24trxjS0BJP/ymDa4oY5fO2Pe7khpA0TMTV+2eHjN+HTwHEkjVRZo
         WoGB24id+tEXi/3ssBWz9eHw5L8SUk/R4PpofviL1IM1oUrlO5TUWeZZBAdfx9iQGr7Q
         9oPX2wO3RIQeAU5WbZBD4wWCr7lmpM24OHIXU9xFlUlwQyfUNZM5oxdtRQTwMuXPSC3A
         4pEtTCFhzFZR3TQSgBeUYM5dmZtqb6QnilDdCg31bf4Dl+Ae6H39y2N2ji3M/0kVaLl3
         wzPA==
X-Gm-Message-State: AFq9FYJjJ4pga9Ev6IVg0T1MUlQEWSg3hleRaOfr9nvwamOyDqFgc6TP
	K1vGv41ctWSYjLTL+pdpaCbRlAFvp/J/TJruwWaBtYyJ6mWTo4rhDtiXllxeLobi9OP62P8L8bO
	doYhFAd6dtcWbmtXRGkztykb7oYQjoOMlNJ3it/pU
X-Gm-Gg: AYBFou1tqQTBrFiuN7udkb5wMeIJX/aCOZb6J/PbBCVAOUppwlz2MX3JKWg0uDh2mcp
	gU/FtpO+rO+qwB4ftmAB59Tkev92LgTK8BzaKOXqXkyfPLuH2KQtTCkabzAJmRKdo2Eyh5wRCi6
	n+SX8ruQP/ifUKqjV/bXA7qs6si+DKqh+iko9ogFt7VcEEvZ9rXfQjtPAYo/D4E7qOHsxGqjifx
	qQz/QM37dyQ2z6IB6lOA/TVHz5xBI4lT36q9lFEnub7bbncgmV3Mq1+wOOwQJNRBEF00R8VCDXg
	JpUbphpeMLb6I4vt5OlgftIKfy9FLLmPeVMPWtpn+BQSTUj/gUCs/OAA
X-Received: by 2002:a05:6512:1555:b0:5b8:ebf3:3370 with SMTP id
 2adb3069b0e04-5bcca158f5emr347184e87.5.1791382829437; Wed, 07 Oct 2026
 07:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007073537.2454351-1-suzuki.poulose@arm.com> <20261007073537.2454351-15-suzuki.poulose@arm.com>
In-Reply-To: <20261007073537.2454351-15-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 7 Oct 2026 16:19:53 +0200
X-Gm-Features: AclHuK_RXJYhqf_nHqmpzWADAUDPbDkHCi_xcSBTNQ3epFkbXZUQQ8UXgywpORk
Message-ID: <CA+EHjTx-niYPnnRDvAAiY3MXLpSYau_PhiBTCiE9mOYUChASPQ@mail.gmail.com>
Subject: Re: [PATCH v23 14/14] KVM: arm64: Prevent unsupported vcpu features
 for VM types
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com, 
	jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On Wed, 07 Oct 2026 08:35:37 +0100, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
[...]
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 4d0e6bd2009ac..97089c81d6428 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -42,6 +42,13 @@
>  #define KVM_VCPU_MAX_FEATURES 10
>  #define KVM_VCPU_VALID_FEATURES        (BIT(KVM_VCPU_MAX_FEATURES) - 1)
>
> +/* As dictated by kvm_pkvm_ext_allowed() */
> +#define KVM_PROTECTED_VCPU_VALID_FEATURES              \
> +       (BIT(KVM_ARM_VCPU_POWER_OFF)            |       \
> +        BIT(KVM_ARM_VCPU_PSCI_0_2)             |       \
> +        BIT(KVM_ARM_VCPU_PTRAUTH_ADDRESS)      |       \
> +        BIT(KVM_ARM_VCPU_PTRAUTH_GENERIC))

kvmarm/next already restricts protected VM features through
kvm_pkvm_vcpu_allowed_features(), shared with EL2 (0b7d843ef3bf).
Could you rebase on that and drop the protected half of this patch,
rather than add a second list?


Cheers,
/fuad
