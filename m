Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3CD424D5C
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057357; cv=none; b=kliCEEaSl9M42MXrA3smtyxe3VYOVc9jOAFs7bIz8uxldmT2zFs/+RpHkkZV49Qse2+AAqceQdsa9O/LK09Mhxmo5kP3UL1zl9FL/PiEYU259RDBM+yYPiKIVyv+hUhNvjaEgiyYyMXnaeY8svauzLGr3V7CxWPP7xo7/QL3Ccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057357; c=relaxed/simple;
	bh=qOca4YR1l20CsOtuA4Ssjv5EEjAAvpCE15hBy63RH+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ccUXYFug0TrcZihBWIhoxluhrvdUKcSr7YQDw2eW7WQjl8GK1xCUfqgYjcBvMKWEngX1J+fTMPqmN7NqYh+EZ3n364IwJrx9DoGJ2IzuS1KMG4re/jNP3i+iUbBwAvFBQ3D9BGfGHKgBQy/0vCjdQ7qaN5GPi0rkl7zs3iJex+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ua6IaVwV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ua6IaVwV"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38827cee19eso4753261a91.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784057355; x=1784662155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XNjjIz43C1JAwhfqWvaKfYlZpSvYaYMVORbwjGK5Qn0=;
        b=Ua6IaVwVsBUPC8vEr5YMCvFy0OjejLo5h4V5jn5pOU30qSKwebyOxHxaK8k21VbzfL
         1CdhwWmLqWDBntODCULJa7nx1INBdaVjDoEy7pQBHmEAZdApqta5Y+tl6QYv1ekzZjef
         qlcmqnoMHcdF/IWgZEguCraz8k42l9XEf2+CI4VWs6YrL7vnGdO6G5Oq7IHxNq8cqTO7
         I792bj3F6CHXd5m+PfbQ1knzWmcWN3BSl7gBGk3EPnB7UzdktaBN5JLaZ+Zxpr6au9Nt
         0rwOnc6rtL+oPamXQhcx6Brg4jVAUA7/fHCxqm3SaK/UG9AetgY/iIsMqHJTn3eNHd/e
         ePMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057355; x=1784662155;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XNjjIz43C1JAwhfqWvaKfYlZpSvYaYMVORbwjGK5Qn0=;
        b=aDV5BM9lVQ3Lb/yeKkNQoKIqUDgpfGPmkYrCFjkB7ngjYvdbxNgYv4cqN9N6chAzi0
         +u50ZGHl6NmRi5sUCCW5uK1lFeIHIR2AYvO2war94r4FthXUs6Z23lw3JeC1YbxNfZQS
         TkLamaR3RcTFOtlRD1j6e1TIZafajO6YbCbRWf6ENtv/RGH6woeifEFhIWS5ZUDZHq1T
         679Sciu0v07IOn0Di0daEdEBA59hCheEZP07+JcvCuuRRAmuuVDbjSZ0qFbN7SOdXUDK
         kc3mLZKEo0dOyZhPHIAO79bnWzq1cwD/IVWyK0Jr+2oj5SfLhUmbdBhSIChPV2ID9Ync
         Dd7g==
X-Forwarded-Encrypted: i=1; AHgh+RoZsLuJfDI0b929eqe4pes9JruNGVm+UHPNWJFlnvNGWJXMdJNVfeVT+Qf8/rJxk0FxuCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEhMQ5+KHIFL3CZ+rOjRxVMk7TPSCErPdpvk3Tws5V7RpBHxq
	hx0h5Jsi8l+YDudDfnKqrfdTViRk42ynKVOKpygyVveyUCrtbcVY62GQttyxXBdO0+soRKePaHU
	+teD4vQ==
X-Received: from pjqt18.prod.google.com ([2002:a17:90a:ae12:b0:381:9924:ab46])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380e:b0:380:40b:f30a
 with SMTP id 98e67ed59e1d1-38e1ae9fcc5mr3986505a91.13.1784057355142; Tue, 14
 Jul 2026 12:29:15 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:19 -0700
In-Reply-To: <20260609131856.2562222-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609131856.2562222-2-clopez@suse.de>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405244468.3109537.2871662581077641578.b4-ty@google.com>
Subject: Re: [PATCH v3 0/2] KVM: x86: MCE fixes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@kernel.org, 
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Jun 2026 15:18:54 +0200, Carlos L=C3=B3pez wrote:
> These two patches are somewhat unrelated, but patch 2 came out of
> Sean's suggestions from reviewing the first patch (see [1]). Patch 1 is
> unchanged.
>=20
> v3:
>   * Address Sashiko's review. While incorrect in pointing out MCIP's
>     role, it was partially correct in the sense that the MCE logging
>     rules were still not fully compliant to the SDM.
>=20
> [...]

Applied patch 1 to kvm-x86 misc so it doesn't get waylaid any longer.  I'll
respond to patch 2 at some point (hopefully today, but it might not be unti=
l
next week).

[1/2] KVM: x86: Fix array_index_nospec() protection in kvm_vcpu_ioctl_x86_s=
et_mce()
      https://github.com/kvm-x86/linux/commit/249f9be58c7f

--
https://github.com/kvm-x86/linux/tree/next
