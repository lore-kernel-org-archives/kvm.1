Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A53DB334
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 21:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374895; cv=pass; b=dHeSnoj80SVKRCFY6Au5VcDMvnUPYnfxjrLCKU+k1OeYbew33mZz7vIYYPz7VILLJ7S7Wr9X5uX+159rJW0HXZVV44pulhFAhDtA6IVTw2Czn7YKgAkDHm8nJfPPS4zty5cvh4xqw//bzkWkiWWhP8Vqfk3FOLHYcl9lW9yi0QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374895; c=relaxed/simple;
	bh=FbctLHl/2Qa/tnihCp3GuLHMWV42t60J/b2sg54zq5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mknCBfs+aczWaWTfd/otUGv7HKwlNyfJ+YhQovmPRRz9JbuifjUU5gMeLJsKq7nwAGNElnt1ZMUgF+mvOLGOaAI7pfgjonhYpqQVGnPTvCrbUcIogpT75MOt8ZGbC6qy7TXd+MA8tvZRuLG+jVHuv13onZFmlX9U+JfbAO9DW/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TCNI76T5; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCNI76T5"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so950a12.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 14:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783374891; cv=none;
        d=google.com; s=arc-20260327;
        b=k8PIgrjVQa8wdKFq6N5JNwjNhMI7aGoRMUyuWFq8QJ6i2GZjLdZd0yHE3ZurFSg40L
         v3icd68kHVbmR2DAssX5BPGgH/qNVOEJ0aOXcNrrTHE6DNUoHgitFWr1QPpIcSknHJW7
         7MTf+m6CX2tAwqpk9t9pF4IF6IHXkoPy1/+1xL3EJ4NHaRuR5cb/sSMEWW0weTV1Nedw
         GgpLSVgm4FkE09T849HoMzTpwrJwx9dVzI/wMxrb6RDqklg5HFjkj7GFQ6o+DI8ciiTP
         +Q2QSb0TmCYkO/XbEm/InVfAwjPHjFOKRtQtOZqSi/4RwE5tlCFdAy60inItmER5/vum
         QDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FbctLHl/2Qa/tnihCp3GuLHMWV42t60J/b2sg54zq5k=;
        fh=ordERZXns/x/L14sharYIPI5xU1w0R0HLqx2fqmKS8c=;
        b=f2QuyGBedXOY3o2OepAyiOO54m+Q6VvOeOqi0mzLtkRJpccw8TpwbKeHle2FUZ0zn9
         QDrHVemhVSDYPwKKNzcL96FHdPuSZx4W4Tb+AjhyLeUvyqJtSqSBNuFDO1SBl2yhLZv0
         20TAt8gyozR5eyItR1cqpfPAWQb21b3P+r66EVNAewZkj45WcYktsn39wk+vbOz3dStq
         Da8VG8LGcsQ050e2LQ8sEEBIhWuetVCbDy+RbKEgdHNAeJUIaWytAMAFXxv2UuqD8MXD
         hmfPgHtiemh6tSIj+5SmxP9yI3vVW5rWVI0oJgoaXzhCOK0eHw3w5/YmaXomgA+/UvAh
         MKyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783374891; x=1783979691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FbctLHl/2Qa/tnihCp3GuLHMWV42t60J/b2sg54zq5k=;
        b=TCNI76T5gOV0Wmkdq0G5QZJiHKE3ayR5N8yMNbngO9gCDVeaJiL8IsSEAzZ1r+tCYb
         Zqh4W5Q9OmTM/RmOTWa8afkE1rnKBbfGF/OEPWNoQr974nuOhDDgS1WJXNUHjPUE/CVZ
         68zlgdwAR9IGLhISkc6m1Ri2ChZ58MaKjFmG/7Eg1da3aw90te3heVr1q2UR79zxAcXJ
         D95+X7WiVQwmxO8oG2NeT4Ps65Tx3Upf5rNnlDkd1QeOwfvmX/ZVrL/sKwNCTDPDcqT1
         dS1GZugfVLu/1s+JVtKCq2H71zabWfDr28c1e87xaKbydWzTy/S7sjpUdYhbMizc102f
         Jdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374891; x=1783979691;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FbctLHl/2Qa/tnihCp3GuLHMWV42t60J/b2sg54zq5k=;
        b=WkDXeZr5IhjXDPqGbXbSzHKszVANyfMFw5NqCmlb1ruUUvwz+upO42cDKe/Ies6hvb
         tTGeqo4osnsbaep4R1E8jFEEZYSN70kluvCgLMwrzcaYGM0yBPyis5Lw5OFHCciSDwft
         nnOkQWjj1gLGF5EGPx+eoqLa3uevZuMwMpaHeMMea182pwIA9GrJAz2q2HpVrKtW460T
         VTO/8My+6S/amxetiD6F3rdWu3CFuT1J2iumOkzLVNfMNMHCmhzsa8SrflDFdnzfyJvU
         KHjpywe8AfgNoaqWbpnqWas27f/MYc5sJFhXI1oHzlvVjLr3mE0X0Bqs0MQ8Am4hWE7G
         CpgA==
X-Forwarded-Encrypted: i=1; AHgh+RqcphcZNUPFnzVz6V/GyOMmTnoO6pHoPqfhdgJrVmlowCKXHJRt/LsOz0g8yGxiXWByc34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Sr6JwTD4IL6GpDiTj1tWR1Zp9hpvgNlXlTAwlVxkY3b5gb/V
	xZIwYC1t9zD6TTVfHUyNffSI019fZSjRU0iTrru23lm4zEbHaz6Fa7me1RSAYJSeg3/NJnQXZzc
	Auca4jhkQR/vsx4JeTRftD/jHBAz2oDBCPLcEgcNZ/B+c0QfrRvaD5JVs
X-Gm-Gg: AfdE7clXVh3z9ODZy1NF1e4UrueJ8hB9kcgatmBxvLSVeH1O3Lxgd4SCnkPYVHhE05m
	VUx5DKFEYreoEMLhgrDhoEusIfIgI0MBvH/8CVF+MMsQoNxTRW0SZxohmwQdKB1SqAkSbXegxTq
	pocx5w2zijYw9JJn4c8fJmv59sUwZ8k0UnIA/fiOZ0Qf516d+iPzzplcbHND+FRGRqMwbAHvJ5e
	e7RkSZNXrc2h7AGK7bv+EYaVwBM1gh+KILdjVbNvevmIzpkrYZdFMl7D6Cs22lB1YmIBe2K
X-Received: by 2002:a05:6402:3046:20b0:697:9254:a66b with SMTP id
 4fb4d7f45d1cf-69a91340f8bmr1054a12.6.1783374890924; Mon, 06 Jul 2026 14:54:50
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619152006.3684428-1-jmattson@google.com>
In-Reply-To: <20260619152006.3684428-1-jmattson@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 6 Jul 2026 14:54:38 -0700
X-Gm-Features: AVVi8Ce6owdCihap0HdZ-lI5QU-pkwuBzqOCeHOwUI472sAueCncjFv7W2xmpHY
Message-ID: <CALMp9eRRMga2zMrAK8-bbxcjWwyW-W+F1KE5bJqXLQN6eR8bog@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH 0/5] x86/apic: PV IPI robustness and
 subtest selection
To: pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 8:20=E2=80=AFAM Jim Mattson <jmattson@google.com> w=
rote:
>
> This series improves the robustness of the APIC test suite, introduces
> generic subtest selection, and adds a new test case for a PV IPI boundary
> condition.

Ping.
