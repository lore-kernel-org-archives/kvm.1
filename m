Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF671FFC59
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780758761; cv=pass; b=s1xsEwpVHK/FDlF454sBgRSbsDzyWxQtw3poHUbUNqlDR3Y+Gsp7IfTihDfs6Rd37NCip1I/T69NmFy3DpAEE0O/FSN7zvntR/yeax6JLo6TsHyNsjpwbOBacfOd1w2AWOSqDzIDyyUI0ekkInM9JT6JDib90btd0JhiKaMdi7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780758761; c=relaxed/simple;
	bh=In996MaRK1b1yryCiDiuIu5JXDlTrgSFPed3GJ9VBus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5/Wk09WEn/2kYaIhckKkh+0jsoILZJXAZLCyo2i1b/jDJyP7x3DqpwRlqnsNUEz2RzW9sza6u+O1FEvIW3XxzMAQ+NK8RjvCVMfVgTzpcfITwayeWameHXno2XT3CrtbmbouudCGzrSnXFqz6HLjkQHOHV0gp01L1HXeLq2754=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhcrVXVO; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhcrVXVO"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68bd7ec2371so17385a12.1
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 08:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780758759; cv=none;
        d=google.com; s=arc-20240605;
        b=dkhEXHrfUfoJpkZEFqNnIj8gQBbVTLNB/t/0yXoBUK3PBSSnQjEruYDkbe33dBfv/W
         04omqGBvcVlyep4BF7uQWdiKtPtg6cZQWMTcqJ+D4FhKab0eOzJREaf6EeTnaVprqkPi
         ztcX9ymjrFQJC71plAKi/yPkCmme3f73fm3NIz1MMkCLqUAwyelOolzDmxeTK2u68Jz0
         6CZsxx5F7FyPsous2OKKu8ZAEQDivWV9VugeXWan4eNZgz9ZuzoQlq0Oc/8MXetkMpgw
         Xab3TQ+NEJzYdDKGXelesQpnVzQjih5wn3mXpKfMQp3vexibUMPWm7J4fAZz/LXcv946
         JjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yaXDAm37FQ0K2c4b/udh9SWP+t2z0xMe7ch2lO/r3W4=;
        fh=+DSbpPcM0Kk8dZr89L0UYAlApKAOwefu1woolTRf+yc=;
        b=PDGv90Lta8peQTE4v1R9Uj2vPxaT7N9Lla+0RmOj/dvl5uYITW8iio2PEkg0cyeO61
         Iwax1acMW1dJiiN65+zra1y7kqifqsuLULloxWoJrNBVNOdj4vfFc8ZDkNPXLc7sJDz/
         lvHqASHNy3y82wHiim3r9ppDaPfkw1N7+1af3DZJIYO0aYAqGNh+Nr6kXx9fIvnYgKQW
         Mh0wXvs7y4WyTlDJ02CBU1ejzs4j7NNvxRiR0Mijhi26PBD5YfViUDjOZ3tbXbldzTA0
         ge2ir+hJnE3i089p8g/2V8KtHcMz8H6FTScKYrxEgsJaV2pBHwMJT5MvNLFCmNOR3O1D
         vt9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780758759; x=1781363559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaXDAm37FQ0K2c4b/udh9SWP+t2z0xMe7ch2lO/r3W4=;
        b=OhcrVXVOl4qt2NANBJfhglGH8mS4/L4fjXNODD/2p32cAultMvdJceT7adS9ERy46N
         9xhczzDCLrA+2WMorhvuP4pybQLk74LZFcFvIxYqipfywO89BvgpW26Gnf7xlYqCGR3O
         bDSIO2gqhZnBeMFsOAZSRNuKHYvkIFKJYrIFWeVLSd84GdfENf2jxLGZqJefdQ4eh0Fm
         oJ66RruaN9ALTufcpS2H3svjJypVYFXZGkL1a4HuirEFTbAUU4HceTHJprjg7nBgNNV8
         rRPGtDYRVdYw8DobDzvzYlBOLwEqQLyOK5JqJGPd7GU/YsJ8d0YA+UBa8pRtovEnE7zq
         hLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780758759; x=1781363559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yaXDAm37FQ0K2c4b/udh9SWP+t2z0xMe7ch2lO/r3W4=;
        b=AicwpWpqb5cNOoHInYMEiabPDqwnktGYCbMZ2elHjtQZz2X206JngFbcWN2DbgTrwf
         Rlh4IpCM7zFKA6Y41abZEErHkNRHjakXbHOaAlUflnHJXkqKd4v+DNc13HmGecKbL/5L
         yheZEY3W36CEhotoHHugC8J8kBlLc9ENgM0VmWsMiMhgHI7aeBNdsaU8wqPe/RBu/e7/
         RhaqNFz2xifeW7o42TxnFACA6r1BxnO8yi4Y8XGhjQku4AP/IqdB46jaFTEfxQ2dTBQF
         jQbVBMarUGa3s9IePqQ8vaXjKJUUYl5oEivOIKQgPp4M23KTId2B4HlwrUnGHkB08Z4h
         zwjA==
X-Forwarded-Encrypted: i=1; AFNElJ/OXBfd61rzsHAEaWmuVsQmhoyPFwm+5SRBsv8aE7vueWWUBWK6wXB7vBy6Ac3hAmGbwL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6/sxIPLnwAQc1lwZ+X4kV90lA2TStU5MvI2HOdybvbNBnXuSK
	hGP19YImkrGuo+TQKreN5zn4CwxxRr0sn03LFEgjXs6qbyn6zvQUqr8zy1ogZcZ2zZHwRGu9lAY
	BxkzCex7wpwXMZqgi/QN4mXb73dHY4FcQ+/r7DoNu
X-Gm-Gg: Acq92OGxgoqubOJZRwTEsMAbfApUH1g4hdGVnN3Yv2eHh0lnuDHOP+2eYqa1/QS5Icp
	f9N8GtJ/l8svtSqMcnYgVc53lf+N/Ezk8u2UAWZKih6Jqj3uNktli6oDeQPUBW4QB0yD0Y2h+ms
	FCfqziLzYhTMsTnQyzt1o7Bxo4FWGLybArzo6slqNBgonKFjHUbAs9raWGGC3Z+923bSV2SklSc
	col3Wrk9Hr5Wq+CxTxglgruGY3UFWC7OATpDCWiGI+TVVdVVy/HVnUB9rR7RVpW8X+knw0VHjl3
	dB7IhIPjBRdOd4uQTUIA6Vfnrl4Q
X-Received: by 2002:a05:6402:4249:10b0:678:93b4:1fd3 with SMTP id
 4fb4d7f45d1cf-68fe8c55bc9mr79664a12.6.1780758758706; Sat, 06 Jun 2026
 08:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527174347.2356165-1-jmattson@google.com> <178009472318.880870.7878635650921105255.b4-ty@google.com>
In-Reply-To: <178009472318.880870.7878635650921105255.b4-ty@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Sat, 6 Jun 2026 08:12:26 -0700
X-Gm-Features: AVVi8Ccv1u_7HnXyuP6YGCfDy3Eax8Y6OgqoRW_J3t3Bw-oamTD9jbnsNtAMOy8
Message-ID: <CALMp9eQ-8h2F4HO8S666mJF3QzyH=0b30kC=n_9p7SMbBhxCMA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] KVM: x86: Virtualize AMD's "disable CPUID in usermode"
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com, David.Kaplan@amd.com, 
	binbin.wu@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 3:47=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, 27 May 2026 10:43:42 -0700, Jim Mattson wrote:
> > AMD's "disable CPUID in usermode" feature is analogous to Intel's "CPUI=
D
> > faulting" feature, but it is advertised and activated differently.  The=
 AMD
> > feature is advertised via CPUID.80000021H:EAX.CpuidUserDis[bit 17] and
> > activated by setting HWCR.CpuidUserDis[bit 35].
> >
> > Add virtualization support for the AMD feature.
> >
> > [...]
>
> Applied to kvm-x86 misc, thanks!

Oops! You haven't sent a pull request for this series yet, have you?

Our internal Sashiko asks:

> In kvm_set_msr_common(), the MSR_PLATFORM_INFO handler uses cpuid_fault_e=
nabled() to prevent the host from clearing MSR_PLATFORM_INFO_CPUID_FAULT wh=
ile CPUID faulting is enabled:
>
>    case MSR_PLATFORM_INFO:
>         if (!msr_info->host_initiated ||
>             (!(data & MSR_PLATFORM_INFO_CPUID_FAULT) &&
>              cpuid_fault_enabled(vcpu)))
>             return 1;
>
> If a VMM restores MSR_K7_HWCR before MSR_PLATFORM_INFO during live migrat=
ion, and the guest had enabled AMD CPUID faulting, won't the write to MSR_P=
LATFORM_INFO fail if it doesn't have MSR_PLATFORM_INFO_CPUID_FAULT set?

Sadly, I think it's right. Even on AMD systems, MSR_PLATFORM_INFO is
enumerated by KVM_GET_MSR_INDEX_LIST. It does come before MSR_K7_HWCR
in that list, but userspace is free to restore the virtual MSRs in any
order. For any sane AMD-hosted vCPU, MSR_PLATFORM_INFO will be zero.
