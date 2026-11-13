Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577880;
	b=oz+bwpm/uKD6iKQqKKI2MtWJsV5uMLrVK/bcteAmHp1yv7Yn+zeMc57aQGUKS2pLgB2S
	 1Us4i9YwDZP+zQSiEJ+gVU98mB25OU5/+UuYsffsAXQig5vT3uiIYwO8JDwsdlRYjAZTf
	 n9EA4kxhDK9Os3+hTlPe3c/OMb3zK1kVyGXT1OK0uiicaJDtWBED00+gA7fj4JyfXLWiF
	 mqxydb45Mpv/Uh5pcCz1DygvXhw74EM9xFPepC4mgeGRz7b0ShRXdhItSje2ywIwdzUzK
	 5WwVEBORCi/lfZO1HrnEtoi3TO8qZaykEEnaAjOFIUuv6VbWrItgqIN8cm87yGtYhWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=uJFEo3da6mApyecz0gSXP2yjHK1yQMS2ugcFfpj5CrA=;
	b=Y1+oNm1AjT4xm7Kao2wPQGlkUMDy/9A90hPKYmiPTPb5H/ELDYek+HdQcEwlI7wv8iCj
	 /gfUg3dGbcDaHHab5jHc0zG6PPnImLLuuKfm3516PPWb1TjGz+FWYyVHMGXnrI5O5ZzwG
	 rN63gGg8EXZ6XZxdI+Mbg10Zx8Vgp8kyIJdJ+nAl4ZpK0djtZf7MoY4AYcWdHRk8XllEJ
	 Bl7DCgT4eOWiVTTOpaK2WGUv6GM+QREhQA6dAKKFqdcyJzjetlo4JVUnHvNuGTE4caBgS
	 JbmOA3uyCwHTDWwdKf9M3MbAgXzbDngE24eH/P1GgtSViPYMwu3I/qxyhTcME7VhhgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gCKOMTLC;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89E606B1BC
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B89E606B1BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gCKOMTLC
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b175a69ab8so1467799a91.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577879; x=1795182679; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJFEo3da6mApyecz0gSXP2yjHK1yQMS2ugcFfpj5CrA=;
        b=gCKOMTLCXj4ap5oN4yRlzwMH0lws3z33L/C3natTDYSKrhyBn3fxp0Ul23o49sA99f
         Hmzdh6srBAdDg2LuESNRAsJgEtHnHFiA9ify1hZhBRIj+sJn2pa90OahDfjCpIXPS9TI
         rSF9yAfsMRdpgFjFlixs7kYAG+WP1IThXmSqE4/4j/f9diWCaxzE9LriMDK9FWG0MY0t
         /eDgPmfKmSdZvEdXoy3YXEk/Itc90W8UMBDgsxLs9cmh/nqf05RplOagrt6T47V1DDtA
         sPLY+qtrX2mlYBxGn0KD4EkEqr4k63q6n1AMoV38NI8JPOop6Kqx+QDxMR3WW4FPKrEz
         tYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577879; x=1795182679;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJFEo3da6mApyecz0gSXP2yjHK1yQMS2ugcFfpj5CrA=;
        b=QH8W4PU2phkZyHjSd6cBmWmNBUjA2+eBpWSCqRfOInjT3fW6AUmF4VyGeR2+qByBsj
         wb9WGEqTKyKinUcniqnDDwUcdHpJyK9ZwMyCURn9iiOWyM+nxvKSfqNhhwv0ORPx7Zpr
         QvmO1XLn+IeuY8R/1DgdUsiXGUD5KeNaTRfd82fTEq1RVPqLdegfezJGa0BRZ7tsDFV7
         g+JeIOcpizU8ksFueVECnQtcxrccOWSK7ZvaKxZP6y18zZ+cEiG2mQZzemkoEdPyGo/I
         jZBdyqYKgkdABUVsGqBvw4GMU4KoxM8znavMv/4buj5SH42m+nudspmUY+YcpXpQgwXW
         /8YA==
X-Gm-Message-State: APuU4Z8BuDWbVO9I1UMpVUMHEF+Z3EnkQvsjJE8LNo+U/JU5u6KQv0IS
	gs+jDEVC6OHMM8JwcsKsrQzLhP5DgrHOoRbamKFpKap8dR2SPs9fsUpLhsl23raxdSPuRDAWvwZ
	9XQgbkQ==
X-Received: from pjbgz3.prod.google.com ([2002:a17:90b:ec3:b0:3a5:f1d:43a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2548:b0:3ac:a521:959
 with SMTP id 98e67ed59e1d1-3b1b0ba3583mr2074587a91.29.1794577878313; Fri, 13
 Nov 2026 05:51:18 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:10 -0800
In-Reply-To: <20261110182451.44207-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110182451.44207-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441799422.78529.8123717597715087423.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: selftests: Undef musl's PAGE_SIZE on x86 to avoid
 type differences
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aqib Faruqui <aqibaf@amazon.com>, Hisam Mehboob <hisamshar@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 10 Nov 2026 10:24:51 -0800, Sean Christopherson wrote:
> Before defining PAGE_SIZE in x86's processor.h, explicitly include the
> system's limits.h and #undef PAGE_SIZE to workaround a conflict when using
> musl where musl defines PAGE_SIZE as a signed 32-bit value, but KVM expects
> it to be (and effectively requires it to be) an unsigned 64-bit value.

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Undef musl's PAGE_SIZE on x86 to avoid type differences
      https://github.com/kvm-x86/linux/commit/3efa3f8b6eb6

--
https://github.com/kvm-x86/linux/tree/next
