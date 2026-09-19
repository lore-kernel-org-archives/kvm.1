Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD62F3C07
	for <kvm@vger.kernel.org>; Sat, 19 Sep 2026 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777647; cv=pass; b=Emv+q8GaTWy5D2XoC9GJ5SkcgbhEsnUpzYIeX/UcgJKn88lQiXRk0hBFhDtwQ4CT/8qP9bHPvWVG7hBaW34uWSflCfBrJof33O9UO+r6xNVgcSDCYcQwMNSoHaJPpDpk4YQ+3w+kYsTj2Xl78Z+YN+yH4L8ROb574CzGH18bNkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777647; c=relaxed/simple;
	bh=eRYDYXq8mO0xqUTiGna2hw3VEfXp06tx+s1Wx9I3ALI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emU3zrJmlwmL/yEGP9kGQXrGoqEjZA9+pCCNRLwzJDp5RnVHbWIdCm1m6zfJn8RgIKI4NIi4zBPYRlttGMz5gQtLR6pK65V4/d0CUH+2159wJfT2K7hgLdWrgVoY2aIt10SEyvs47O4R8CG4AEgP2c9uDwZfP3MhoZFUU9Lt4HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhCYJju5; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhCYJju5"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d3b445a84fso17665ad.1
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 17:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789777642; cv=none;
        d=google.com; s=arc-20260327;
        b=gV0PUx3AdipluEhYTrUqY6B6kX/KtP16CDByvInCAaSf7wPlEXSoacVkh/XURI9e3e
         Mz81doVCYxF/N3XT7GN+cbT5ccWmQTDVwSbARGKBPEoUioVG9EQj52r9deXvE0vNhh4n
         IQpATme1acYx4snCM+oePT0yo3JTFGaAYKuUpH18Bp7/g1R3nlgd8LDTOqgskMZpbAqE
         TMPRVi0R35oBwG1EAhIfZ3truhWUqsyvfczzXcP/Z67kVVvVzyiFbkAr56Vz5OCEJXdr
         iUen3CZXqmjeJNd1B3Pk5LcB/6IECNwH+vgCLpfx1feIQ/aWeEryLC+GOjrZRh2f4GNB
         /y/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LmqMKPHBB/mFOUskOMGcF49EXv1ypL8clVxsz/MHGR0=;
        fh=eTZBID7v6LHGdUdKTEsVjKhdL4WoNu1ugarfLiSfmvg=;
        b=MdBy7r9Bl9BkdJgVAba6kcdZKQlpDcU4l+SnUTLdvwvQN9tsqljHNXRPOUuISj3iAk
         gZuuiCeBzO0waELu/DP5wjATQQ2HbYe4+P41UFX1fJjZui+TZZuwsyajgrUHGFhKGviK
         GBYhQhjaN0Q5d9osxO/WPqwfoFUcCAK9hyXNKvWzXt4I68M7hF10aZMjl2pO8yXStUm0
         Yj6SHynyiAqhXkRR4l42J05g19uWIhTU+DyWK4jkp3ObFu8F5G9EvYY4yvH+tV+IeON2
         KcXLPDlLpP7/gsH/erVsTSjTh4TFNYC+odp8Mxt0p3wnwEk/0Baf9nBThpXlBovqNcEc
         zU0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789777642; x=1790382442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LmqMKPHBB/mFOUskOMGcF49EXv1ypL8clVxsz/MHGR0=;
        b=mhCYJju5RLperT/80kwTGTcKjRNJS61m/AO4/v9fq01QvhtP1GPxdBUs1rWQZqCLMb
         Q5J7CuPZHfhlDgsVVDTiEQAB1ZPUPVrG2e6x3rPB72wJ3EYwrvOk5HEG8n3yHK4Tp08z
         MAJ5TqgoqwJ363BnUMgRnxMdjHcN83KWP2Uu3Usd9syZRrbK8Rz2UOLfZuTwTT3/GKO0
         S2XOdwRAbJ1bRJFpALEVViREqGx/wSCh9pdaPpB3MHYYrouxgU/L+6KF5GrauP4QvFpI
         GvfZPGIXXPOeN9tgDhcUlVb55min7MhHSYMpelgNS96wvKzy+lVjtejB/OGyVTyRCh1V
         33lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789777642; x=1790382442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LmqMKPHBB/mFOUskOMGcF49EXv1ypL8clVxsz/MHGR0=;
        b=C8sK3ybJTCg8oHqfZhWnOb5uGFOv70G48nL76EPd1ep0tgu6oPaJ+nA0VtWzg7BrEz
         hT/AIKJyAUIOlzKpylupUK9T0FxeNjOv72Vybng63sBORnpAI4URK19KnmYt7gGMZ/CY
         sespWTQQ978C0pwL+RKiN7yWTkOz53sMAYMGR1BqgvSDlgoyT28/Y6V0ohJ1lu1xEAvC
         FXPg3KzZHNKpGnpU0wNoyx9hsNO97JbOiE1lzuGlkjQ80JF4L12L3QGQFyGb1CBsxAVW
         N1p9726uW3JY7cT/CNv+KXvXnMwf06tNqhL+e/vy/ebSI6Kmj+ZnNmd3SPjPtcqKnMoB
         MYCw==
X-Forwarded-Encrypted: i=1; AKwUvBwIzimAf3vj/McyQJemz1S+G6JJCcWn5NOzXclDti3CbjUvIknB5R3oky8FxmSHy+9mIg4=@vger.kernel.org
X-Gm-Message-State: AFuF++lp6IBceNUqhsyO1r3Lnwzh+ApapEDV1j5HI5hJW7L9U6wHS8Zl
	7QEOtD379D1R5C8CIn15iPz0+Cxc+ASGDoF9pRDupqr3/43Bm+0KrXak363iWFVxgmFKRWEZGXR
	RxXU+hWpCAE0PYKAwf9yTLcw57f1/gSOYXvQXUFRf
X-Gm-Gg: AYBFou1DaHCWRnDwkJ+PYzeTmWM3CgHnS5Qw0LxBp+PSpIDPoobcxzNPzHPoEqCqgPC
	/V6xV4A6byQwkkr8vR+Qkzu3IMe31/P2dF49paxn0H4C+n0hrbBUXH1PmLj5a5i1IaXiP5yqs60
	PbUKgYuR8ynN8vav1ZfoRu5YztoiGbSjGfSmN16QIowJoYZEq4NAFbSmFxoT/TWPWJZN4oIhaA/
	ADzvgRoreWEMoCqKSYOjgYgwcvsmEqkFM+42H+EinZieloy2ReDj8wHg+uITvq1dQ4EaGAl/UtM
	oJpvEvhArdbmm8FDU6jYgJEDJHtOvvtEoB2kGkk9KNqcVkqOnBaNFTp39YlIDXYo5gX4NWBWjEj
	eRGTgoUZ0mg==
X-Received: by 2002:a17:902:ffce:b0:2d5:db3d:1a44 with SMTP id
 d9443c01a7336-2dec1f19e92mr1672875ad.17.1789777641256; Fri, 18 Sep 2026
 17:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
In-Reply-To: <20260819094903.3060020-1-xiaoyao.li@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 18 Sep 2026 17:27:07 -0700
X-Gm-Features: AcwNN1VzCFV9uA1sUp0UBFirw4LC7YC87Ka8strvz1IBLR6XIOyhlpfD4-o1ujQ
Message-ID: <CAGtprH9a3Cu80coUpg-1sHrmVF2c6ZQOSe1pOTUbEx4_xuHiEA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] KVM: TDX: Enable VM-DoS Prevention Features for TDX
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	nik.borisov@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 2:59=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
>
> Xiaoyao Li (9):
>   KVM: TDX: Enable Notify VM exit
>   KVM: TDX: Check if there is valid exit infos based on vp_enter_ret
>   KVM: TDX: Set bits 31:16 to 0 for the synthesized Exit Reason
>   KVM: TDX: Don't assume exit_reason[31:16] is all-0 in
>     tdx_to_vmx_exit_reason()
>   KVM: TDX: Update exit_reason on wait_for_sept_zap return
>   KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus
>     lock detected
>   KVM: VMX: Make handle_bus_lock_vmexit() a shared helper
>   KVM: TDX: Enable Bus Lock VM exit
>   KVM: VMX: Consolidate the exit handler for VMX and TDX

Reviewed-By: Vishal Annapurve <vannapurve@google.com> for the complete seri=
es.


>
>  arch/x86/kvm/vmx/common.h | 20 ++++++++++
>  arch/x86/kvm/vmx/main.c   | 49 ++++++++++++++++++-----
>  arch/x86/kvm/vmx/tdx.c    | 82 ++++++++++++++++++++++++++++++---------
>  arch/x86/kvm/vmx/vmx.c    | 46 ++--------------------
>  4 files changed, 126 insertions(+), 71 deletions(-)
>
>
> base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
> --
> 2.43.0
>
>
