Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F83E169F
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102254; cv=pass; b=eXoUOP3MBMZz/Zr6xE8RYhSQK/EwwwGAnaW3vTDesvAkufdSt2dFa2UQPdqwlMHFBcix08MN1mpdsJSXXA/qQwaVh/uRcBX3D+ernVbCCLrbp5nkXS0T0dMuTnrq1n7AyQyUd94lT7YSMiS7NpAmfnbMnmesX1Gd67izNYT6Jh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102254; c=relaxed/simple;
	bh=HrOPWKV9uRiqcVmFgZretdSmBgeyb74MAmTnswv+yAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vwz8nBl6jeXp2vra1EPFfiwslmQpesxxvXaxMaVbNh0VsqPiHGNubELMd0F48a265ZOzKbvaO47Q98OXz4z86CwNG7INftfbtlF3SuUmLaluRXeVH8DbKAatINDLTncSS3pis2MCV3cwpJAw+xgU1fKFzpAOnR41HdwOnOxdLC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yx5dJdWg; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yx5dJdWg"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5337fa12431so55011cf.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:10:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792102252; cv=none;
        d=google.com; s=arc-20260327;
        b=SxHgqELjroTwQJiGX3bm7R9k9Gq1FTpvD8R9NAYhT7DaehsXSZYdq2jXVC0YK8EWuf
         gKtGz4v7DvS+QNItUJ79Z+Os4WmHLATvgQumf2FdRw49OOZ7UF2g+jbSY7nzK1FVz3ix
         uZPqsjlLymPWCQYy0E2CGmwpW1PdZCRq/opqx6TC4ozeG/Tyrg4zVK2xmhdVW8Pu9StC
         Ypy7xLsRxeLgKCjh6w4yWJaLmYZyutzVmIWddrA04RC8LL+33iMnN7e98jI1YaiykUNQ
         M6HTBFJNpYeyb7FW7kHK/8ViL0JyUVTbXaBSy4apfMhmim801Ln/aUUnYQE2my6XB5BR
         Fw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HrOPWKV9uRiqcVmFgZretdSmBgeyb74MAmTnswv+yAs=;
        fh=ueAaANsAtZJ8Aviml4XKRoqjByFBw/cB51A5x2wlYno=;
        b=KT65ljywWDzKToEQJWYsDgVUci/A/zDmROtAOrAsyGYHJsSLW63cRJGMFR1S4DNB5n
         ybKrb1aNe/KTGkEANP9v5jTt7s1AYrDwFIscWCwGAIpNIY717kzHRjDOjxaHErylr5Dd
         qr5deqS+KDkyMRWdpBAWDCQbL/NQYcpJOKOEQxIQKUnlt+zzZ/038Lc/o2cMcfPvHRDK
         IAOjwp9h919DW26iXmF/JhHuP5DNzU60935GIzxi6W53gV5wliiV5iL5MAr6CBbvKNhs
         DbsHXtF3dD4zgTiGnyIc4/GRG3uS0JVNgXhPjJkJbhuky+gPrZB8dITtsOAJFmylOzNH
         3j+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792102252; x=1792707052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HrOPWKV9uRiqcVmFgZretdSmBgeyb74MAmTnswv+yAs=;
        b=Yx5dJdWg6GGbAiaUF1wuXAqfwP1RIS7hZUEF44jPJDjtSDMMO1KUX7jOqlvWlGZ727
         dbuyRXAizRzeepUh+w8T7jf1YX8is6THGCTcgR6K2ZN9nLawUghDx3pcGp9L1IhEwcjx
         m4P3YmDCOpA8ziaqQNooG7ifyRyAnSeP9FY+v6pK4/pD/bWGPt198S/5bxHG1gnMMstE
         psy1p8hCOK1/6jpSKM0znszmlw4+LbhVp6Nc3NXwklLgbPlhL+d687QujHBjbvM24BJ6
         pm3qbkqPgxRtNcnF26Wjshs5jY9WfZGMH+5z/KBbdowo7mKujKRD8ULxdOhcbUhxaeCD
         iHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792102252; x=1792707052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HrOPWKV9uRiqcVmFgZretdSmBgeyb74MAmTnswv+yAs=;
        b=SRN/X1gVXraaONSeP3n4QTeX7xE+bRKDcMUURVhLxhrv4PNQi9sWKngH45KhYradr6
         UaUHX6RbnoyIRKUWjlkCRkixUb2XKrBx4U5zVpVWuIIzayhjL1ltigVpqNmOIP/XEGHp
         6lulLgicwM0AWOUNoVsc1DMprW2SyqED3PfGEjsTV02Ca0DtkQ56F1sUOQWLw22o9Qtj
         C5c1r4j0wCLNwj7+dFAHI49GYDrY3Cbj1ztJwnbaf3slwYMqiFDaAROA9E9SJ6YtR+tD
         vO2GbSKgNw6GeEAUzmnke/YJVBfqTUpIuhgT3OLshNdM6W96k2wIEsSjDYBY0tCGLUrv
         469A==
X-Forwarded-Encrypted: i=1; AKwUvBy27fq9M5P9zass2hWh5OU0g+tjQ77NDm3lCfu2sbelG1jULf4DE8CAHN1JGSpAQVeWgBA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDhjX4XRuNBJFOc4HITXH4taVL9QCr+xkmaeITyR79m994B7qE
	zfLDfaDJ6uLYBzxbfmkQM4dvbJy9Ux+PQuev2JAs0hf3wISApcdvHrwPolbcs5xEnrjg9N39Xkz
	MjQIOUQYxkKZkA8xutqi5R8dGl64EUrm2izrnu1zV
X-Gm-Gg: AYBFou3Ye/Y7XJ99VvGJxFpZTGbesWZc/PPuviN49lZP8ni+9cfmnAKNw0C4hmklMsV
	aafYNA0dS4MEf41iXzfgZaJ41JzsKHV39BfTiqujkd5fQN2gVttzjY/L5WXjPRU5JqfUujGspYf
	srtJuPOVq/LF59Xxs1Ruci4xGvV3l2/0kOlddyiPHuiIHobHrufMHYC0YfmEbWqIERbtkKZGh5d
	i7TidNs31NoXzJ8cfXrLaFWnw53tWzV0A0DPey/5FwCuhwFMDWXJHWaHc6ON5M6SmoOAh3Yi8SN
	9aoFV4jXT1yzMohkqTHbHZIpEXMBD8dqHe6BPzHS4u/gf12i4lfqW2M=
X-Received: by 2002:ac8:5a0f:0:b0:532:9220:a9ae with SMTP id
 d75a77b69052e-53629ac8fcbmr4055361cf.6.1792102251473; Thu, 15 Oct 2026
 15:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-19-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-19-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 15:10:35 -0700
X-Gm-Features: AclHuK-0h5rHSnqyAiLfJHcCVzzx_T8eixjFxdrxOULNj_D687GEFjRgA8p0a3Q
Message-ID: <CALMp9eSeDzKxf===96Wv7enq9-tO0EZhJoXTYvcCgZxuBS1pRA@mail.gmail.com>
Subject: Re: [PATCH v3 18/27] KVM: nSVM: Split nested_svm_transition_tlb_flush()
 into entry/exit fns
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> The handling for the entry and exit TLB flushes will diverge
> significantly in the following changes. Instead of adding an 'is_vmenter'
> argument like nested_vmx_transition_tlb_flush(), just split the function
> into two variants for 'entry' and 'exit'.
>
> No functional change intended.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
