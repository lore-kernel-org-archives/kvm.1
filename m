Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A61481B1
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780751081; cv=pass; b=nE+uNl74y8JxO9smR2rKNUKoV/vWEtz9MgK9ip8QRTxFsWS7zc9MXeVpizic04DXJ6u6BGeDqZbyMcY2Qwo3T1ec+MO4tXZb/Cz7A9ODdHZXjstrQOam5M3C+FhygBH98A79bUGvCd+0nvR7cX33vZ47Mkv9D/gjG0l4KRjmlO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780751081; c=relaxed/simple;
	bh=aFQ9H5pS3DwRsF3bm2nF0IOHwvtLms8oX1Ewtwlb3/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+95nSaLSh4lfzqnPckYPkRRiuxJaRGloCnqqXa7sbyKlsya/BbbMTdY14TYljqnCpmSUBperyS3GklSOPAEHGdeYKoWmsu1Ef8lUQOKg5vfcFpkcZVViQRITTilX+G6hj7sBXkUJi+qDsdj71OYtR3jjzdCoCR49c5VoJbf5pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YDctUGUK; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDctUGUK"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so19227a12.0
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 06:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780751078; cv=none;
        d=google.com; s=arc-20240605;
        b=gYAWMmd8QKpxwFY5ZGisHuj5/PqZr2335RPPqi80x8uXcik1mjrN2vcbdqx1q11VE7
         J75qQyajaaQ4gxznsPsukgLwBbjXAzddbuZUCZMe1XoncYfLbmg56p3u/SJA6dLzhh9v
         LTHGLk0RAnCq5Ro07gZUufjBjebOJTgwgut5XKGhvxfR2mVEdD2cc0eROusLbSs1qV3v
         rb0SSM2s9JaZfhQUiOp74j2SzmUXZSj0hTQGVom8KtYSlSwg0NTsGkmT1+EjGgADBSqN
         aIpqUqphAhgAev6Y5CtQtzMpLmFf+vg3t5/YIyAPxpPxCPKdmVVLZVtpfNj21c4I90nC
         ff/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aFQ9H5pS3DwRsF3bm2nF0IOHwvtLms8oX1Ewtwlb3/E=;
        fh=o0R2tSoAEq2ik4P5LYpEDf4DGQzcl7XvX0ggCzrbBx4=;
        b=bF0A1qjC8AKJk0kodQEwW4DITbeGyLkvBEQ826mvvXsmBXMlL2/uCcTa2Jcafi2QB0
         +La1SKSclXDpV8pbsjsLjEymupCZVuQ06B8QoKDUaTh9zuAzVCz3qW4hgsJYyRlMfxmf
         N2RAO5uTalpfSeEJOpGBQzVEbXuBSV9+oY27jWgxW8kXfBgfTBoDUclYnS6f58ulYNfB
         D80O9mehsiLtjRhxEsfUec42BDXgaF6+OPxMyO0FME/1cvEqLMAwBEUNkGg6Y5297BZW
         bXFbUZPnnF5FOg2cCH+py4SzZG9oB+C3k5vM5MM9s0lD3Yv+jRJbzL8Z+OAL1MgsvUU/
         +qSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780751078; x=1781355878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFQ9H5pS3DwRsF3bm2nF0IOHwvtLms8oX1Ewtwlb3/E=;
        b=YDctUGUKjtdyGq5qo8ugtFKouzWODWKhJKkYdOz1VhoSCDVCfpDePtDd1FF77YtSCo
         b5ZOt+hkzQ/Q6zphgYhR3s2+bKmE58i3uBPZd3QmN8xbAZUnbIfu6JB+VO8LIPLdfV7Q
         rfGptBTNB9KBFHHC4kbeBKZfMvMIIkVjDTUksgpyaxUPNXxJ+O9me4OwHYrLWOvjllSC
         oe6EXI322etCPqII8/0/UZRd/l4wE7ejr9NnuA56iUd/U7gsisxTqYaPUDgv1STzkKeq
         hZEAmiZ1jUbABB+5fLAaHSwy9917bj51wqDC9pHwyp9OiZt5RKxjohsgyyqVidAf8IfG
         Lc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780751078; x=1781355878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aFQ9H5pS3DwRsF3bm2nF0IOHwvtLms8oX1Ewtwlb3/E=;
        b=ImI4rACcuVDyW5oxHyQpDo7j4s8dHvmfUL95nsxCE3tyXIC31kyVu5MxEqueSmlj9f
         q69NfLRaW/JxNF4N75vKhpPVKwkr0KtbqqBV8A4qKDbZbbYFRp4cL5GSRmBYSaxIn5wC
         5ldRwqfMpf28P6WO02JHCde9B13CAeb2u/3oyHUdleYbnAUud1Cf7bfwq/AgD0PrCMa8
         d+1WYaFHF32RKBfydZT4aB1uk9NuJdIRR5ezFk8XkYMWjGNSfYxIWtJ4IahKQcqTum49
         TOOf7ZhMv2mdaBOVpe9o91UUcUXFw9WGzAHpNKImycw6X1XLo8dcVeB3u0hE4dwLLtAb
         J4sQ==
X-Forwarded-Encrypted: i=1; AFNElJ8kN5jrL0yxUvgAcgbpaKbHPWcClN+NLmq/piUEhND85O6uND/bGAMDxRLGe7cDz9Wegz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVkEMtl4T/Fy1eTmLJbsSV8eh+MUdDNymcpMNkIqxPS9g30HkZ
	5kxNvBrnrf0gpCcjTfoAwTExbOHty8LxWXRi73TC1dJfU2EO/csJkq4dr1Ctnkpt3WQ0JNoD/aL
	DUdu5416160ip+twg903QM/7hbW6zXvrzWrjoBfudxRGYxiDPdadd0Re+
X-Gm-Gg: Acq92OHIFyE7ho7suU09PmIeqf7SiQ16eS3AyoE9UaVgMBHkM3oW5aJrxmDe30KpSAG
	LXTgvSZuItcugLNNFFN4jDU8fc7f2ItQ9i+OZ3Du83uF+zUmQKOJxRMWcOhA3dDdtuMUykdBkPO
	P6iDw8oIqZ+be0zXPY/owmWjNRjsfmjYfvqF+21xie1X9aGkt65PTAlYFv0LubyiI4tuJqBdQXb
	BZ7L8g+6vP5M5YiOwI14YYjEg/4Hp/kg4PPaWtzvweOyj0DbRDXbQTMHLWLL9nBhDJRczsReSP1
	gviV0jMF/e37+6g6ow==
X-Received: by 2002:a05:6402:321f:b0:68f:a01a:7677 with SMTP id
 4fb4d7f45d1cf-68fe8b35ae9mr135022a12.3.1780751078234; Sat, 06 Jun 2026
 06:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605174611.2222504-1-seanjc@google.com> <20260605174611.2222504-2-seanjc@google.com>
In-Reply-To: <20260605174611.2222504-2-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Sat, 6 Jun 2026 06:04:26 -0700
X-Gm-Features: AVVi8CdrBhef8L9O4JoX3196AAOe0-4RT75Spz9KB7vq8ECfrKJL7zAL9qgEwJY
Message-ID: <CALMp9eTNOZR9XHvnm5paDQG37B80MGTYGyF+7MWXY1KFfv78pA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Recursively zap orphaned nested TDP
 shadow pages on emulated writes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:46=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Recursively zap orphaned nested TDP shadow pages when emulating a guest
> write to a shadowed page table, regardless of whether or not the associat=
ed
> (parent) shadow page will be zapped, e.g. due to detected write-flooding.
> ...
> Fixes: 2de4085cccea ("KVM: x86/MMU: Recursively zap nested TDP SPs when z=
apping last/only parent")
> Cc: Yosry Ahmed <yosry@kernel.org>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: James Houghton <jthoughton@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
