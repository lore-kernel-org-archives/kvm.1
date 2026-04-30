Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD50D221721
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554594; cv=pass; b=G5YAUwpyDOE8MjjCIpPPgflyiMHaHgJ9WN90dyiXPRQrki1qWnc9gsgCepy9kjjskTxr1F9414OXPFqbWR4j7QkCykObUu4dsIMz3EnIptfcNkQpbJFtWxGH7eMeVKPgZje6jEBwcGSSx1vjnB7qNPDBZYlr7pL+vFRj6vetAr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554594; c=relaxed/simple;
	bh=I+YiL94/NsrvrrDIRxF2of5F/mABo9BsdOwKiBBPajg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcIK4GiW3omnPbdOQKNOxTfGPf55aEfLL00jkJD9gZ5c5z3469pznwLgWxlbWVS7B0JdHTOrK8nWLR+Kl8tRkR/Icyprv25KBwvE7BcZT6sFwvj5pxDEpGqtBJU+vzsMx1yATET63lqo4/zb0NIIccYrzOcAqoR+rmLY/NrCR98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wxXvbcFS; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wxXvbcFS"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65c0bda7f15so864824d50.0
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 06:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777554591; cv=none;
        d=google.com; s=arc-20240605;
        b=IXriabWDyF/ukHtyEmUQdUsBJaaXCm51itgWYy2Evj8SrRVhT5bVoOsAo/j0aWWyLH
         xPApnFYl8I1+PpbrSUekYIClcvSnFYvaXEpBeHMDnRJaYBqKoP0APtIJObAWt8W9bwVP
         gpJ/PfWmr4GORrIvePV7tt9aJgwKKVJKhZm3ATDuxNXhvImSdU/8rk2ulTCU5mVPMSfW
         CCShJ6YCOJ12BAto9Q/EnqywUCAu/Fs3DW/GwyEOCd/HXR3fyHw5c4AfBSlCC0JGdiAs
         gOLxJMX+7PSWxELNhSNyeCNX5aG8xRkqP+UGCsB+tvpPcvKkdQ4cxZ8vu3f3peZcRCmp
         8tig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FxbWF8KbXOGlfQKsgorPOT1msBKMLNNbj2kYslbT5dc=;
        fh=bOpwRoGQkCUCcMYIzL3Nymc/XUc6JHpc/7Kez2SBGkc=;
        b=ISvqsKq8HR0WC3BaApMqPw9nuCwJ9vuXoBoEKC6H4vXgJRZ2sGdp7QM1/huaB+bUll
         3dq0J0IIcE4QixtREswfyyaUcoRUchyI4zsJ0cv02Nl+WJhsdxNR+ywDtxlMD4Kgeis7
         1Sb4b5yDQQ8tL8x/R76xYEweWDgqgmOWEt8d7B3hxHy4E5m5CAlHi/QfwSJ9GNZVOLiK
         J7nzyVjvuYW16Ll8G1azgUUD/y5N5WeYmejg1MUQB3vQnUmbDxCoQ1D2T+d1NLetoMRa
         1sG+bIdZ3iF59iIHiD7uZs9Dk5vA/jCWV6dS5Ndpmp1bFpeZWEqekiaEg3V0KJqvQKk7
         NeRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777554591; x=1778159391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FxbWF8KbXOGlfQKsgorPOT1msBKMLNNbj2kYslbT5dc=;
        b=wxXvbcFSbnyxfI9nZI39nhU7BsVPSKdEHP6hSiC52uf5MdzNqS3q4+7BuDBmRFggoo
         N7bLMvtMh18Ay30ORn+r+qumOVEBkN6hIbHhtwaVjsuiS7rQJt+XaT5HP/7vNJnjdFbZ
         7julKCcRBTAAJBKFdoCV/26+TXSf+E8t14bsicHMPjnqA9BgXRpbyQrcN8BCJE1w99mz
         BYGsjwHJ6Evr/Gx/D1la5Cmfud3u7JVITe8/aLwftMYtuhYjhDn4BcF8MHx96jfQ25XN
         y/JKWGPmhbmfBv6/8xxO/ZQMVI8hOC0TplhfmQpCkOT+GEUG31YuYQGeeKACmkfXzk7v
         sinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554591; x=1778159391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxbWF8KbXOGlfQKsgorPOT1msBKMLNNbj2kYslbT5dc=;
        b=nsVTbMEMAlkTW727jg1SZBCexnfzsScmjuRfXWggZuK6en+WKxn3ji0IpQaoa/ORHZ
         EnSL0VPWWco6I1auWA/UGzCPb0fyjfl/52kzxLphlcwNQ7VPUjXyUCR5zwxbQ4Zk3gDc
         bSnV73MCOQBv92Sf1N+7OMxud6K/THlhWQ+5FllGZGGtN3+e3xIic1DhVfXrdn+PFZY5
         QA2tP3NZ6w4jKupSy8AvTowu1iLoSN3Y6/IBWuGXBFTHiSUu9J3RortuWOJUGXkF84xK
         MBkIyWRAOG2hK1zECgE70fIbH3QH9+LL1FV7Aarcgv+KqxocA3FV8TMwBtYO0Gp5Byz2
         Jw9g==
X-Forwarded-Encrypted: i=1; AFNElJ8HI0ukb9UfLJ5Jychokm7KtRn3ZpAWmEAeZoRoq1UyFJDZ4+VgUmU/wo17s9dpqWiiNis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4UZaHQlBamdzS1JpsD2zPMu9+oXEfC4eW97LiINTT3z5pWa0b
	d+eGYIU9jiL2VvSi82U29E7ge4Hfwvx7rvaHJSZ2/vbPopIDvtR6bYEDJ17369qxqBKhTi+RxMD
	XseW6ePXx/bKpkD/owdpUa+QV16HJfavGJiYU13Vl1A==
X-Gm-Gg: AeBDievs6frOH4mZPbzQZ0CMWQZOhC2pKslyqML0Bh5+ngqbhlH6vNue9pX9q38mNLp
	CQPSoWArDLs9tJjZ6z6ORMQi+8cKd4+n17OuQan+7mR9smtwierPouNkSzuhwZef80+yqLW8VuB
	sh2ylDJvVBF+kTQSSrx9apaNXYg83s35E1VErL6k9NXkPkK0b1twCQmbGi1GU9/afyWgxjfPBpz
	XEdyEtXP4IGpG1Ts11mzx4yIYMvk4hmNBLDc7VkBTQEgV7ZZJBygsl7jPn4suMDtPy9GNyyv3Lm
	mVGTs4pRvRnh6VjIgOdi1vWgxEsI1dMtopn2PfN12VUlqOP0uj46EZ8sLfUwfHtxvLxoYVDuZlW
	aQw==
X-Received: by 2002:a05:690e:2451:b0:649:ed08:1a01 with SMTP id
 956f58d0204a3-65c18de27b4mr1561059d50.35.1777554591429; Thu, 30 Apr 2026
 06:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-features-v1-1-1841b39da7e6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260428-features-v1-1-1841b39da7e6@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 14:09:40 +0100
X-Gm-Features: AVHnY4ISyJss64q1Mf2DvH6h2BtrzOWFl1ukcMtkQZ4nxtYAaw3YZoAhJwZVxFM
Message-ID: <CAFEAcA9_Sc=+Cn7JiPOo9GjOZFU4KCc7nFVqU=9=QAsNBG6AsQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm/kvm: Cache host CPU probe failure
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 09:07, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> kvm_arm_set_cpu_features_from_host() does not properly handle host CPU
> probe failure with caching. The current algorithm can be summarized as
> follows:
>
>     If dtb_compatible is not cached:
>         If kvm_arm_create_scratch_host_vcpu() fails:
>             Report failure
>
>         Cache dtb_compatible
>
>         If getting register values fails:
>             Report failure
>
>     Report success
>
> This algorithm has the following problems:
>
> - If kvm_arm_create_scratch_host_vcpu() fails, probing may be repeated.
> - If getting register values fails, later invocations incorrectly report
>   success.
>
> Make two changes to fix them:
>
> - Cache dtb_compatible whenever a probe is attempted.
> - Record probe failure by assigning QEMU_KVM_ARM_TARGET_NONE to
>   arm_host_cpu_features.target.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Supersedes: <20260422-arm-v1-1-106a9a9e22dd@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
