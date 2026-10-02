Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1B244838C
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975739; cv=none; b=CfxEWSQNqWgNkZiI76hSqu+lZiYptmVKPJUMYBi15kxJ5R16QaDSlqlUi6JqhaWu2srF5+mS0/00tVxCUE50IPQbxKGq+RSSVYQdGlRS0eXwjGCOhdhHcrNoYrgYTsbqfetw2e7AII6PSAOGAq/35gde4X2RsjEELQwn3FU4db4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975739; c=relaxed/simple;
	bh=I04cdUNXSRv11sYtvtroDjW+zV/3mPPKgJaNsJNvVsE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=njWFkgQ91e3U3tqfUcTfuhsqWO5ZVI5ZTenUV/jh1Tap8jH25wU6TMB3ZW7Q9wt2Hmsaju98N2GGJ0MnJgzybRlbBkZRAJL6T57XpTeuHzH6ynQcwT4MJZFXvVc6+O5vbF4yv6GWY+ewuYZDHMUtTGOx9XP7RwpF8pQ8oiuwTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LnNzybQ2; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LnNzybQ2"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so342252a91.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975734; x=1791580534; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bb11Q3X9HLbRPbjZCs9AlV7uo+0Zv9shnGK3DWxdtTQ=;
        b=LnNzybQ2fCVWBcmqPqbv1rS9HyyVKjPUiPT+tW5Kr34TzALc3vI/brrwKrPuPlaDTO
         iBr00tVaGGZbryICBckv4g+6i068Ld//uBB5Qe6RYoHJpuA+QTP4aoA/vB3/njJsRaQR
         +Qav6chacbc06NmwHe/Tk7+ngQA/9MCSrXgXmaGW/FXHqPDeSp9ccl+7+tS93TYAjMEu
         ZpzBg+muDsyUpqYvdZUrR6MCIopFnmnDS4KHIZ5nwPFG7B2j37evf6loZ+u7CQPHeLs8
         JN0B+6QsYaz8ryFE/7l10n2anRB9AhaX/EeC9yEZr6HuY3QUoB97R50hFsBFjZP/1pnV
         +XnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975734; x=1791580534;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bb11Q3X9HLbRPbjZCs9AlV7uo+0Zv9shnGK3DWxdtTQ=;
        b=VtJIG6WXOEN4UrVYS7VHTNxwuoOQaz8LwomlvKRk0De23ymB8E1A+/iV7xCT8ijbUV
         V7L0hhOh1pKgTWlfOpeYjnWf8wiTVRJBsO1PE7GHLZAndGssYVAUEycyQvWh0/Lsayu7
         KIr5gphXqZ5Q6Xqe5jq4oB+I5zoAxIsgP6KSBKD/mvTQh+qUV/uShw61a12BhWOgJl83
         JmGexUpflW9X2HPpqvoAQaeiAhSh2bYxJ3iBwPBktIKxHI4eU1/CRUZPhj5L3o4FSuDW
         AQwqIGTbsINLp3Ct6b8DHh8u45gY6mp8uoTuOwnc5If+DU4PxR0gc24xpz/hnthCYqWx
         1rDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwE3/WDQlMeGd7R1fKILi1vkDxvlOfBDtRLo3D+W4ZIvnHjmA8V1yn0ZJALG7AxsLqQ6q4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/fewTEphIrSAW26sgAVEmqPkN1/NxbUBBxk1uMSAyOmiy8HTc
	H7MOzxmrZsuZrX4fZr3Pb2zDZZRKyyn+8zXUQdXhRnegiIKNWd6bffD/0hZzL94MYngpLzC9w8B
	m2ekozA==
X-Received: from pgbfe13.prod.google.com ([2002:a05:6a02:288d:b0:cc9:f7f0:57db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52:b0:3a4:97ea:f0da
 with SMTP id 98e67ed59e1d1-3a6cec1421emr3480757a91.17.1790975733662; Fri, 02
 Oct 2026 14:15:33 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:15:28 -0700
In-Reply-To: <20260603015831.41664-1-yexun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603015831.41664-1-yexun@linux.alibaba.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097572261.4090908.4660952008671139268.b4-ty@b4>
Subject: Re: [kvm-unit-tests PATCH v3] x86/lam: Allocate test page from
 AREA_LOW instead of AREA_NORMAL
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, yexun <yexun@linux.alibaba.com>
Cc: binbin.wu@linux.intel.com, chao.gao@intel.com, pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"

On Wed, 03 Jun 2026 09:58:31 +0800, yexun wrote:
> The lam test does not set a guest memory size in x86/unittests.cfg, so
> QEMU falls back to the default of 128 MiB. AREA_NORMAL starts at PFN
> BIT(36-12), i.e. physical 64 GiB, which is never initialized in a
> 128 MiB guest. As a result, alloc_pages_flags(0, AREA_NORMAL) returns
> NULL and test_lam_user() ends up running its LAM checks against a NULL
> pointer, which is semantically meaningless even if the metadata-bit
> arithmetic happens to succeed.
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] x86/lam: Allocate test page from AREA_LOW instead of AREA_NORMAL
      https://github.com/kvm-x86/kvm-unit-tests/commit/5ce4dcd089c1

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
