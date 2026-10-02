Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B844C66C
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933686; cv=pass; b=igSefyRgDFxb3Jzg6qkDAnfvk7XPLF6ovpiiOtgNJJfAFHEZRNly3QEIdYw3pvq/tUCU1HO1906fE1TFudiTS3g6ZjnP1nNcDRUMRvcags2s/6lXSmnzfZP1yKaf/CbZFJQv53RMGdkKpc01NLmHjLfOtVZI8JIodTsrSC0bCvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933686; c=relaxed/simple;
	bh=x9JTFIhcYIzkewGT1y4B5m/45uK/p/cDf2r6ve5Iqn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWzPHCghpGnHnsjDMCxZDtpBiSIN5BdmLhRgnGyGmU2t1zNNUD9df3ew7b90q4o5TCRiR90LprWJQWmrWBk8dUW5mGCPmJ8Fj/dMYQLgSMt15aV0fKd0om6OBa8IiiYS6OFpAe5tqkBAeipW0IRtZRpPbhTCYXpdVyJBWdfak2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxxX6cFJ; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxxX6cFJ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ba4065fa07so6487e87.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 02:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790933681; cv=none;
        d=google.com; s=arc-20260327;
        b=Q3JCMW7c5CBnCB7W+CiaQdkIR7m1M7V4baDjMkfnzjCdiRq3aZOK3tTROp5N8WzNDr
         AZPteczEGGTVh3IVG47Z2Bm1R5IIsHKmRywzioiz+dD+7BgjQRFkjtEvQmO/MXRB87rx
         DWBQPUwJXXxvGqVzfueohUNBsOvc/n4R1fPBmBBACwgXyBXrxK/BbNE13aUsMK4zoQy7
         gBMFfkiO1B5fTkEMQ9+CHEhRjtrHztwMciAQxLeyTPFLG9Is/eV758mR7U9cHEBVQnvb
         h8bK5Hygm9DYdZCUQNe2ikt6ky4FdKIX0z5pzqQaXM3YfuZfFsES6MDitGZWF6PRwkzk
         mK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SuyjNGNTaeTrwozTD0DPhcs6tJEVH09iyMIGVlGNB8o=;
        fh=rnIkUf6r+pm8oCQPQDOHPhdYLJEIYxB5Eh3hMNjkNs4=;
        b=OxjdUFDzFLpd0RdRnVEN1ZV4ay4UyHXbyylrDpdVUrSInkvCpn/JtaAY1XBoTZQyyM
         DroQgKuJcvIRaWm8Ysh2VC3fBxu9+FljPV0YoSRFZazhqEq2mfco/XnhVB5WwRxvBt5j
         Mh45B96Aur3VZeWXs3wtJE/1lc1zOG9vYBAVdyWSRcp7OocY8pU6JVKxdDLC8nmSIZmE
         emotkaVshcb0RrNs7OkTupy8ZJL4t7JKaH64VwakFmVN+Y3g4qE2WPYO/LVv7w7vGhWF
         zf50vubv0Ctff6JXSTzVFI9sa8n9BGlj5Nz/ctvP9m6vVnjZX9pZVjma9IHcmWHrRklP
         RK8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790933681; x=1791538481; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SuyjNGNTaeTrwozTD0DPhcs6tJEVH09iyMIGVlGNB8o=;
        b=HxxX6cFJCTw76A3QP5JnbCYmHgzHAqlQq+BJqap6bjOYNNz4yp5siGzjbVQPmqpGXS
         5PG7GKRNJQmFmAs7CU1UBV9zQpaqkvQStTfPDVJSKYqGcRhOUo/hj3Vo7j/lQvKicKc/
         S0n1r1ai55iflZ2fYap9xTYUVvxXKzD1qxFm/8nUl2fYpNuOhWMqezG1q0tkHYh4/vD0
         +6Ubc2Mzx2ycwIHAsNyvTF7E+Ro1Zd9Vb1hIkp+NGAcffBoM4NADpvxAc1fHxKuy+b0D
         6oImIabVhK7LvWmPTGeDDqI9oYnttVo9paAZNkfRfxjUuBCRXdd77MeETYRKeWFrtTTo
         xj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790933681; x=1791538481;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SuyjNGNTaeTrwozTD0DPhcs6tJEVH09iyMIGVlGNB8o=;
        b=EW2atMDJ76acEFa2wHLElenWnlKKxfcdhsWxy12oDaTHWBAhlBpZx3q4BC2bNXDtG2
         ik2Czx7mqXj2hjorRswbH3WxbXjP7XQ8CIGYHliRJuIAJfY7NNsRSIBYjM4UI6CbdB3V
         KTUHW1TnpkMX5dhfHN678XHvIS+b+JDqho+aS2fZLnKKMgTXU7/8LUZrgih0Xv1m4bO4
         oxF5H17+cLtglghjhBbIWxaUTIqHIUPEDhcdvpefhdybojznlufuM1oaEyYRCZ9yYryb
         b3AZ/Z86w671JPySz6YYVibkk9Wbfy0vYmKVCuD24mX/JvmuuYJItqE1lROd3LWGHspd
         vImw==
X-Gm-Message-State: AFq9FYLu/lwIdQpPrZG4vd8azZA7rQejHTYKu5eSeAoKTC75PdNKcDF9
	qBvx35wTTSkDabSJXtPgvvXGfmZbwD/fkEQFlrLoIxyXMZcmMe3hhaX8grIve9rRYsq0BYAIobr
	067zc46aOfSNyqSVPYGI60A/cxZqIWS+7wLAgmI+h
X-Gm-Gg: AYBFou3EzrjZEVjPKOF4BUMi2A0UTXoew536YYH/f7JN6DZZT2RkTwiCrdnB+tmlrcE
	ZZoXwFU7hFxAupZVxgVls8RNsfVeRXwgWZkCYD7VZufOqtP8sOcA3Nx2SXvsWAp5Gu1icnWK+SZ
	hFdOP7XG7CScd77YlA+BGsZlV91hU+BIXM3CTPQDHi/jRQmXTOzcuUo0CcNty8eR3TV8LdtNPoJ
	rLco1YCLrSYpN2I8EPc6fFo9bYm3sXaJvIwx7DncknZzItT19il7aBQYqCLcF9JlzQnsD7uvZCz
	xQnDaJOFrQVeXsIybASsjBDm7z3+yJkrI3Mlu4mKtQNd6jAL0sPHpWnQ7vKFKEWiUgWLeSEWgbC
	tol8wwpjGzta7NQ==
X-Received: by 2002:a05:6512:6d1:b0:5b8:f20b:350c with SMTP id
 2adb3069b0e04-5bb7c948658mr120571e87.3.1790933680638; Fri, 02 Oct 2026
 02:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001210703.1597150-1-suzuki.poulose@arm.com> <20261001210703.1597150-19-suzuki.poulose@arm.com>
In-Reply-To: <20261001210703.1597150-19-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 2 Oct 2026 10:34:03 +0100
X-Gm-Features: AclHuK90hdLcclI22eF8PMzgsUup2Pu-fPsPyAyT7zN-k3WxhBppCUIye56E7qo
Message-ID: <CA+EHjTyyKxW2TT9XpjSDkdjWEuGyWmA_isDpOnoyri8ikxZN4A@mail.gmail.com>
Subject: Re: [PATCH v21 18/23] KVM: arm64: CCA: Don't expose unsupported
 capabilities for realm guests
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

On Thu, 01 Oct 2026 22:06:58 +0100, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
[...]
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
[...]
> +static inline bool kvm_vm_ioctl_allowed(struct kvm *kvm, unsigned int ioctl)
[...]
> +       r = kvm_get_cap_for_kvm_ioctl(ioctl, &ext);
> +       if (WARN_ON_ONCE(r < 0))
> +               return false;

The fix [1] is in -rc5, so a rebase conflicts here. Please make sure
to carry it into this copy, i.e., a plain "if (r < 0)".

With that:
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

[1] https://lore.kernel.org/all/20260914093838.1082637-1-fuad.tabba@linux.dev/
