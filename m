Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794257803;
	b=PZ4FSrm4Ufbx7XE/xIzLOTFE2tpCzS0R/A4TZRvDUZKfIaDvl/Tn+1tZDNqSgemqd8vr
	 RsnnhBbcfAesHgrMZrmbSlCaMBpfEVu79pBSakAld8e6U4FPbEK9q/EpQW4JH93hU5u0t
	 MmKuGKyV88PQrY8TULrprCcYBViJphZvfBdOf+lDnn3htp4bmoyq+tduwH/jjuOhJo1M9
	 6QRIkOi4mg9f2d6Tlnq5LImxm0j9nijgagkDW9BeQ71xt/WNNISl0R9K+aAph/rH+6l+j
	 Qa+3kutD/i7YoGliIUWnqHw0TJI3M22LcQ8iYpkxlBLisSh3RhofYXAt265Ez+dIJRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yQSdZKmmpcQWU+DJnbn5X081+EyRYqo2+GaLjQwTf6U=;
	b=wFlb0a94qe8N7TJZ+XmUCIS8Fwes0/KE1V6sYDLKOv2zWhhyVJrZEcKnTLR8a++nfCm2
	 oRip8m1E0Agr26dSCV5mAbJ40AhNZONDppZG5CYwJWxFpoxEfvuzUZ9g5El4z2gTfwlFx
	 FpVfqG6JxljdJIuAfB+nQ2wgyhPHujapkV53VRXKQIPVE7S38ielqtuo0BAyuLGGiapK2
	 SvYRgthKg1jga9EOwU+q430fbMjBXa93GCTkZ8l2bgJuFtok/h1xCrNU6REOXszsznTZR
	 95Cnx0BQdPWfeCOuPf6PUIZ+sLf2ivlEadY5mIs1zUZzKpg7YiI8SKNV9kWRfrMBjIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=frn5lMeg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F9606A326
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 20:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B23F9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=frn5lMeg
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b71ee00f0dso634a12.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 12:56:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794257801; cv=none;
        d=google.com; s=arc-20260327;
        b=al1Uy/69jzQTqUpIuu5EzaZkDhVzdRYKRpwJxjP9W1mYRN2eCfOhySeUNHdJnp1TbG
         QwXIHLf0BQi4uxXZO21P/1VlqaKjTYmbBF4CAvXKItwhgSVlDIVLSOo8SgNZ91bVJ9AX
         i7SBuzPv6TGQddH1WQtKVL+7imbzppa7QKjK3Ax9owptb2jCi64A7g32GnyDRmxm3zwg
         DFIZgwy3IvjIG0M0kcLTvjFud9PRl6vGh5sDQbHzVb0qGBdJE7u8HdBQmQivhNhlnjfy
         3gfL5CFq6tyRdtpnJ4v+6Sp3UUYRCLGPrn7hI/6kgZNOJ4UjaJzH383qaLvJD3McclSe
         +5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yQSdZKmmpcQWU+DJnbn5X081+EyRYqo2+GaLjQwTf6U=;
        fh=AytPzH0S8y1++tqWrCfqJFU1ZWf7A5Ay7EZypeTSJw8=;
        b=SVVXis6STqgJBExKVyELMfZSmwORC9ejL33LfPcbieqSNbEt3BQ4wPdEf4vYeNduG9
         W6hxrSCIJI/obrWKQh+7EZ+DxRm3puOMLE9vnzeaVeU+1ERhToN1vuDfBJlT/zasKKan
         Xgu4LMR64pma8KtZzlo027eha2yb36kZY3ZiUkO7MyLR3g7GOe1hKDJeFwgVlVO/vbYr
         AR8YqUMQOT7nQnhUYdBfhu7XrYK9Z3aLTh32nZcCE4o1w+Tvn0nwjgKooOjIcFUridc+
         JusPvpT6uerbCcOuerev1kJQg6Q/NjqoAPhBmfRJAHchac7i7EQgPKNzaqqnRjtiewrA
         m0Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794257801; x=1794862601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yQSdZKmmpcQWU+DJnbn5X081+EyRYqo2+GaLjQwTf6U=;
        b=frn5lMegsdCiwPlyqKmc1WsbA+58aVroqKji9Soxm66qwDIEnhsfX/gJ8Sg4wHxUXw
         xCGCqsF7GI2nojk3yrLYQWgOQFNI1lyX3L54l+9FC3DEV/wwE8pwYdSOC0H7827HD+mU
         ZK6CZW2fqVjqAcxrb7FY7s5qPNp122oNkXTRSTGpf7QMhJYmsVYirRX5vi0hGxMUsqqi
         emZ+Y9PHB6nwflTbpYdatipyRJHA+DBwiEb+ByBY4Yl4PAdiuhT22n0TH780kBSqfHB+
         O4MvAhrvktpgp3UcBDzqJTnZP3rYv/MtTil8dHXpkonEYu1QNb4SKOcaEtO9FxPLRphJ
         SMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794257801; x=1794862601;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQSdZKmmpcQWU+DJnbn5X081+EyRYqo2+GaLjQwTf6U=;
        b=ryJep0XSuL2CEDNPoAqeaFtzCs1dWIR9Qg1W0cUJFeyNbLX7646dEhh022x4k6v7AI
         d3vuBxABuGjqNb7p6B1IUrW6FOHsHHi+bNQSGkTnf+7n2vsG28zr2CyibfeQt9Na7tF/
         KEa7aJJe6u7mybIpYm0tcJ4XXJs+fddGcIGnQGhgcxPGMoG9d9vs/NmXoHkjZkKSzrBl
         eTI8Iht2txfTlnFuds5qiAPLCdh/nLXxJjiNv025WzhPxDTq/aGXWBbBAqZQcHejPIqR
         qx53d/HWKZ3Rafz2J6rXTEBcVu0q8jIXRqLroKszHdmug2Ohnj6YSxsQL50LgIl69oXn
         smYg==
X-Forwarded-Encrypted: i=1; AL+hErEwMQPifDw1Jx8LySbQwp7srKhStdPLEc/9v67JNjtz4TZpugNTa32od4FKL5BRucZeRgs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kDXoEXgKvXLlqXbdVCzGOk9AZf0UUVZAjonZAdGS2fwoc5qqA
	oIzcwkkv8bRhr3ke3ZsYgzmFSDyjEPXK025rsgkd6rL2gN2QJd7CrlVC0ztly1+8RZnEK8AHocT
	/xTi/EbCQo4JYUbBK2ZhalccG0WMon0rGzfACptJ7
X-Gm-Gg: AYBFou0xDEgvLy8Ho8yR8h+u3jawHt4MCBZR1fHNrgJ9SeQyHeyOQ7Zaqm3lacVGWBz
	i7bCmE1kVknxUy96OR39LS4hrYRZ8iZAmpcEqvNxOuC9XRX9FMST4d7z6MnNa7RxCkn3x/IPA31
	CLIPc65agEiCuELmaTQkBthvSWzUKfLdSBaMKu8q8xxoOYA02tB6DHEhigVQvPUDShDAfmBo3WY
	iLzLUUQ7AuiOUjzP51E4CX55WMjysBlM0sw9UQuXJ3v75jFzXEYTo0DbYG1pm5if6s+qsa+QeBy
	gLw65436KUjZF36J4UuephBsQSL7cfru/GzBMzsMLEt1enjDH4i639AffssnZLwsFslSPB9MNuV
	DkeBo8X7P85vNQPn1ulNgCXjoZ/e45tAYkJiQi3g9j7oVg3MN7//RwTfZ5+ohLugCgI1mTPf9
X-Received: by 2002:a05:6402:892:b0:6b1:bce6:1220 with SMTP id
 4fb4d7f45d1cf-6b75a448a1amr4902a12.12.1794257800635; Mon, 09 Nov 2026
 12:56:40 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106013927.166209-1-zide.chen@intel.com> <20261106013927.166209-17-zide.chen@intel.com>
In-Reply-To: <20261106013927.166209-17-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 9 Nov 2026 12:56:28 -0800
X-Gm-Features: AclHuK8ECB96A84bRe6hbcbSXoigF3kLgPk1H-sOcW8BUGbb2JnHVgbjP5uyQvM
Message-ID: <CALMp9eSKP1SorDWRoYMZBimoBz+aJx8-iB3tfrqJCkmjJn20Xg@mail.gmail.com>
Subject: Re: [PATCH v3 16/18] KVM: x86/pmu: Ignore AnyThread bit if
 CPUID.0AH:EDX[15] is set
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 5:50=E2=80=AFPM Zide Chen <zide.chen@intel.com> wrot=
e:
>
> Intel PerfMon v5 introduces the ANYTHREAD_DEPRECATION capability
> (CPUID.0AH:EDX[15]) to indicate that AnyThread counting is deprecated
> and that writes to the AnyThread bit in IA32_PERFEVTSELx and
> IA32_FIXED_CTR_CTRL are ignored.
>
> Preserve the guest-written value in guest-visible state so that guest
> RDMSRs observe the AnyThread bit, but strip it before programming
> hardware to ensure cross-VM SMT isolation.
>
> Continue to inject #GP when ANYTHREAD_DEPRECATION is not present in the
> guest CPUID, e.g. for PerfMon v3/v4 guests or when the capability is
> not configured for a PerfMon v5+ guest.
>
> Advertise CPUID.0AH:EDX[15] only for PMU version 5+ guests, since the
> bit doesn't exist below version 5.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
