Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5591EE7B7
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198400; cv=none; b=snwPng09jgrmpceAgw4R+yivOiNvQloXJ1b8qUJy+ZBalkwI/6AOmK0z5T3NjMQfhz7M0YojKWDD80nNS2uzFfbh2eyOpt7bYaca05xDcf+hlbgWU8fkcN34GMLQQmNJ+VuUOgLIeZsdKj7JxlJ/zYsx9tYYMqgY1sG1iJXObhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198400; c=relaxed/simple;
	bh=IqIvPw2GAUltX9HEH6RUyDa/gEt7fX8k0zmvqix3DLg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lFSbR4cqvsJI2++hilHfkCZMxr34m7eSLHRo2UdlPHUNaky8G2a+bJ03wgtPsCuBl/8nV62utknVdoKb1ABJk2/r+vxcvf2YUnUZPpSsrmig52Lg8RR0AgQxGXDh4g0zOYcnw4IIhn0sOtrWew5LX+s+thUAogRpGiCmTzDRSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+jVnImQ; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+jVnImQ"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ce7dff6253so4169075ad.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785198399; x=1785803199; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y5huOaApwRhbfQfuOXpldTZbMEIP25k8ATJQE5Txyxk=;
        b=t+jVnImQ13Mpw0eXA2MVltC7eQj4s9PesKwrHzlKdZLHMWVgcSttCWUvEa8v/E1XSB
         6kCECxtuC1Su8pR8bh1/WjkvDb+RJMwFeqKuQoH5SbMYidTUzBFn9fqpHi1+F4rwsCTB
         sqvHu10BdTDCWXBfMR6JH5Mzm1NmagmuM/wYDfugBsE+AQoKu2GOEVem7NXsQt0DEIxp
         SODtKs9YryKaAiX4HPpVGnGUSRgDCYSAQJkAJSzueyn6K2pkhKnSPVgJAvNvn8AGienR
         8I+8qRQbLf2CGZm3UyOlhw/CloM4jIYzMWcS2m6nYhKWkb5dnY7Wb0xvzXQC24YLbEIB
         qilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785198399; x=1785803199;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y5huOaApwRhbfQfuOXpldTZbMEIP25k8ATJQE5Txyxk=;
        b=Zxk9yZ8ItBImk7CUs9wOHm0UuFdtUs20HR/iYesVn/tx5ZAKJdLtOpLW8e2GnOm2E7
         qn0QeZY9GfnDxQhXKT8ae3Y+hVeLGVyyLrIIGRBIjXpZbqxuED0V6xpDhufhvxKhGaQz
         Q/dlGGIU0XDgoxs8adsHgQgoeZBa5PoRtNeyHns5fsayRMv1Zq3G3Ur2rrMv7bFvJ1jy
         rk8La7NsTAQ2y2ibHJVWudPxaq27E2BJZOUTy41yvPHwH7TKHAkRYGd7D2ZrxoyTSn1O
         6lBYc7dYBetRBKgYldX3Lf3YRMaztAVpTsKJwAwDtwix0UDJ5wz6i1K1FHb4FrqGtjj7
         Ui8w==
X-Forwarded-Encrypted: i=1; AHgh+RoQUtBx65iIrGmpLnJHcBelM5pk9BxOFRzGm2jHcdqdr4LJeaXhqVZvOqgQMi3NOXHZjuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGUBwGvLtZfhbzxnh+NH5NaBcTOaOIh0NpUFrYh/NNMzq6jHH6
	WxPBiEx8aGqi2PpgYhfbWPlc69Di0CWHi57LKZyFXoPtmp1VZX6yiGJiOzs1SdyRlh1eyC4GQr6
	gLReHIQ==
X-Received: from plblc13.prod.google.com ([2002:a17:902:fa8d:b0:2ca:caf1:5e10])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c407:b0:2c9:d8c5:d55d
 with SMTP id d9443c01a7336-2d015d7f3e3mr978965ad.16.1785198398786; Mon, 27
 Jul 2026 17:26:38 -0700 (PDT)
Date: Mon, 27 Jul 2026 17:26:38 -0700
In-Reply-To: <amcOaHsgnHjdhcsm@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <al8wZQwqC9IhlBZc@192.168.1.215> <al-SKXoha-dqz047@google.com> <amcOaHsgnHjdhcsm@192.168.1.215>
Message-ID: <amf3PgliChzqL-fB@google.com>
Subject: Re: [PATCH v3] KVM: x86: Mark nested RSM-created VM-Enter as untrusted
From: Sean Christopherson <seanjc@google.com>
To: Hao Zhang <hao_zhang_kdev@163.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 27, 2026, Hao Zhang wrote:
> On Tue, Jul 21, 2026, Sean Christopherson wrote:
> > On Tue, Jul 21, 2026, Hao Zhang wrote:
> > Do you happen to have a reproducer I can test?  Either way, I'll try to add a
> > testcase to tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c to
> > cover the SMRAM => RSM path.
> >
> 
> I tried to capture your suggestion in a KVM selftest that covers the RSM
> path directly.
> 
> The test extends vmx_invalid_nested_guest_state.c by entering SMM after L2
> has run, corrupting the 64-bit SMRAM image for TR, and then executing RSM.
> This makes KVM attempt to resume L2 with invalid guest state restored from
> SMRAM.
> 
> On an unfixed kernel, the test fails in the new RSM path with KVM_RUN
> returning -EIO.
> 
> Please let me know if this matches what you had in mind, or if you would
> prefer the coverage to be structured differently.

Very nice!  There are some tweaks that can be done to reduce the amount of
duplicate code, but this is exactly what I was thinking.

I have this massaged into a proper set of patches, I'll post v4 shortly.
