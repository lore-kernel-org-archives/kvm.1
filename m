Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0230445AE3
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414843; cv=pass; b=quMfrZ4b4vUbIiFyxcpToz0MfCbxaj6xul9ducPsZZEFvaegQDO9cZSdTbQsqA6XYMQuX0/J4GPpjqoAv4FUIyPLDbwu5AZ9Z/axtggvampyul5t/H3ZECOKcJ0uGJtg5OwYo/4k/UqP8cZAZWik0pDtS5bu3mCoEPt69usAj6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414843; c=relaxed/simple;
	bh=IOrLEilFHhnJxPSxRVHThux+VKNAZpXoN8B5i5lUFcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYOQqsHDVMToRMeTZPl6ig586gTpwVg6MYcNaJtup3brdwvHrK3jw1IzI4pL4ELROEMzGJytH1v2O86XzWuvSE0bNGizXxmdGbwQd8s+GGeDeOefHqiFMuBbuE3f/EmMYCUwlyZoJYGJIFqyCWVryhyAmMkum3P6Rse0i0mnKs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1GTsN2k; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1GTsN2k"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9a26ce21aso17215a12.1
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 12:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789414838; cv=none;
        d=google.com; s=arc-20260327;
        b=FZBRQw+hVVgglkWvPaoOwXGfKPT+x6PZ2FrIN0TiGEjHp/X9eRI72ZWm3yXw9vt/G8
         2EP0bVrFZsPxmb0UgFUxo/V/aS1BLTa0fk8RQa3SvUrlTH5JWCknLbxJxDjNJk6Rkx5i
         HlzlCHgnZonrg5ZhZn/su2DOXUsneVpkrPZyEF97QNLwLYlw43n7DKSYRdgVGeuHe4M4
         +LVCNlB/0Rvw3GxG5kC9/k7KkNwtWRDGwXwl53fPGGMK1lvu5QctZjMc+JBMgBtjvK3+
         QEWNStHZypKn9xa2BE/hFlJ5gJgLMDXCp6n9E92ibPqR+tjwX/u1ZL0IfSTXa7ZWooFI
         hdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eZUBkwIq/fO/gxt56/XDzAsEFFKgZRRoosZ19gkheFQ=;
        fh=zeKQ9cp83YcizdjMPVKhkXSLZ/eDQBI5hU5NL9MCkoA=;
        b=kL+PFxZ6Q55VU92qU3rkYJtOU0BrxEt/Ya7bv3qKEmf5cgx4VpubVaKKQtoh92Zko0
         c95NVI5mKreW7dorfxqJtiekD0Ke7wlNCGDB6u6yAFC0Heue42wdf2Y1WB0yvWTF1gow
         cIvY9xDASWjTP4DKO5U6bpTG8LmfLwKe6TDA01hGr4Qc263MOlnaVssC5lOG6H2Dcd77
         KxXM/4IFGNVZftg4Z4lJP3wHMzvbP5/rIMxiP4+chIMn9YObXsA4uBL1rhkP3sIkkMqA
         4IQrDyHHpfdYfdqLdYh86TAF2JFtte1HUB5LwiFUgbLXHXLZnxqwpSk9XeZcCsJdoELT
         MAaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789414838; x=1790019638; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eZUBkwIq/fO/gxt56/XDzAsEFFKgZRRoosZ19gkheFQ=;
        b=J1GTsN2kVknyCzdDaEHMj+c1Max/oEEuJNkiiyGK2zH0OcZLZMAkbyk+z+/qWhtBNX
         nTmb9FpFY7euvMvL4whqstyqFzLc5f+Sa3nJmIi+Wu6IONirPudVcrSNhcMRa27xSgwl
         pkuwnkOdIq+m/B8u4eaQ2w7BaCzSjZufWFBTLmykU/vu+edqyu211NR+B+2blC9cs4eB
         8IpgIfwKY3T1MFonCwT0HJiLmuscfg8HImF7BrkBhzAjtS2SwO1FAuPvmVaPBh+uUz1v
         aiWtdhG0rbe3xhPUxytNNFeNpUnYrt07A/eIgOIPyuYN+zh/PUCUEJyvLEQD1BeMrwqh
         dksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789414838; x=1790019638;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZUBkwIq/fO/gxt56/XDzAsEFFKgZRRoosZ19gkheFQ=;
        b=tKR0NRu+Xtsaxv4WbzCItQT63WKqz69QFpEFWyyqF/QRJHceMiPcU1brV0fkIiyu/0
         4jIT121/NrBo39gHCGPK2HQMzWiMpPx/tPNJp/z4wiX4+Ev+DL+GGN3GU33UYFYl0fhi
         +pWzT3JT2rxjMTSx0+oJpDuJnan5Cn9HNtnJnMzesNuh3BuPw5DShulfr3RIwrLjDD/j
         nqjmpM5f6zmtFGlNrIo9PulgRmOTV+7A8z0c1Nl3XFZh36nkfVH3PyhjYNi5FENrCdlk
         tWwTCxYaQDyzDfB+Fv/CUQHwwYO3WTGn+DRwtMdHZV1GJ/xeG1Nz7AoNCtsY9eBVUDhb
         1SqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxui5BmDiV7DPzgIFOGWwJ8/3v0xDcE3j/m1TmoNrJP7tcYGA5OLo7hnt3ZsvAmCYIikns=@vger.kernel.org
X-Gm-Message-State: AFuF++kMnRE5XzFby82nev3fVgps9CcMDC1gnOmN+RQVyR8XL0FKGTN5
	mGoRhLvcPIzgLmRPVoHHqtjwo2hg4I3rCpF69M6lu2YMfLn1aIPijmc/zCh/t1Zqp4wxGognjo7
	ysjNbVNfus6v5aCKkOqThTU05NXFJ1gAMV7ro7E1c
X-Gm-Gg: AYBFou0ahoBWj0YKH71dBfKs4k8/DVDk5xIS7rM3bItH/BP4jXFBYvJR3WxStrVynxa
	rBzZ52vkQRMRo/S6kVZFri3/EWcG45PRBk2nx+tuQnlRPRdZKSPb6jiAXsKBM+RYLzSCl6t79qV
	rFT3exLvCtXSAS6jATM1caQc2dkqRkpa0yiAKMlBP38L+WuAsw+6jfPfhIpp80eSzdloUCIqg09
	RqR78Y/37BkjPF1D1DeG33B8MnAwgzqP+ZguPfWT73ujh3HoVEfwVv98MY4Z9kRyfIC1RAoNXg4
	jBx4GkWfy9gGX/iFmpC/VCooLnyRb/VDxwGSf9fuHlzwc3TNvnZjINtv
X-Received: by 2002:a05:6402:691:b0:6a6:9d10:f52b with SMTP id
 4fb4d7f45d1cf-6aa043db7d9mr8757a12.12.1789414837491; Mon, 14 Sep 2026
 12:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789281096.git.zhang_wei@open-hieco.net> <40f8ac084021e48fbadd5697ef16f674554a4480.1789281096.git.zhang_wei@open-hieco.net>
In-Reply-To: <40f8ac084021e48fbadd5697ef16f674554a4480.1789281096.git.zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 14 Sep 2026 12:40:24 -0700
X-Gm-Features: AcwNN1VTxREYw7yGA-RG3H7Iferx9bVJ6dEoqU2hzDKLAla5Isbu_EYHtunu4hY
Message-ID: <CALMp9eQq0-YwL6-jV_ZJke==J1dHa4YFs+xncN-ue0vr9Me2=w@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] KVM: nSVM: Propagate hardware DecodeAssist bytes
 to VMCB12
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 11:44=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco.n=
et> wrote:
>
> DecodeAssists provides instruction bytes for nested page faults and
> intercepted page faults caused by data accesses.  When the feature is
> exposed to L1, copy fresh hardware-provided instruction bytes from VMCB02
> to VMCB12 for these exits.
>
> Leave the VMCB12 instruction-byte state untouched when DecodeAssists is
> not exposed.  Otherwise, invalidate the state for instruction-fetch page
> faults, unrelated exits, and exits without fresh hardware bytes.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Reviewed-by: Jim Mattson <jmattson@google.com>
