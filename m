Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794257643;
	b=X6cOWkFMGyz/rb1qclXw23VIatjJtom27y8ER/cbW/RK135gHZ517ZZrWSLkKsgsy1hE
	 C4LEeWoUJZ9+QQc+d1Xlw73pZIVZpfV/RnNTlY1OJOhH9FliR+3kqRWf/kH2FelIp13J/
	 SyeQh1GdQK4egFGEuynYCHcdLfidf3HgE0aCcBjoSte+Frti+mp9j17AXwbA33koN18go
	 x2RohKJivwI+UNe7aM7H4YRT70DEwUyI9msA6A7HEGwcheFzQj9NmcwIYLoIBmCG+w8/D
	 MOtrIqFOvN1kw068BtCQpzM9GifnEvgw5SgwMeiSZ8nd9ZR4l+UpKGN3Apd2Wn3cYcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257643;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tJshWkDF2CVYsp27lgxloaGQimeueesl8RBwt1ZwDYg=;
	b=bUgN7KpeOxikp2N7VDxuqzU10L5573LFom6aP9OIzBEjNYJevSoVm1mb4JjjqJEOkLYo
	 hzvkKRw661s5/qlDLpjqSuSO4/wdOFhtL41eyvHSdxF48J/UBCsZl61FV5UbwD1BjXxE8
	 14vZ4QnGEPWv1+pZkadFt+VDf0pAk5Xpjp9+BJB2dAUsHYNFjahzeU+xGNO2TegQWFhko
	 ebi74gfZLFxqBRhanqEmlr3luerYifvNih89PfBahLdPsLyVb29ZaCUP+qz+hbEoyeYNY
	 K0JDStthAlQQQgFYVVUiknacrPt1OcDEUGnvRmH2ANZ69/wy+VSGjgiva3Hxmcv5Auw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MX0a2LBF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06628606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 20:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06628606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MX0a2LBF
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso3853a12.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 12:54:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794257641; cv=none;
        d=google.com; s=arc-20260327;
        b=ebFYRT4GYPRnttT4PnKeuJAGHPD6gQX1eiLaGR7X5Q50GzBO+CFrOvK9sUA3I+1PY/
         HxhR4UxCcoIA2vXKMMpbpIXmGz4dQEil6zHFVXATc45ACydUf1ChnfyTrWl43M8SiIXL
         jBmvNfkopgcZJCrfXTG8OmCWvsOrNJTgtiiq6m9dHJ2wBeSlDInk48NI//V04WISgO1z
         VUFreSFa2BNr0Xyl3T5hSN4pncF9x8aNJpeMay7H8cNO5i9W1zKybIE7md385fwF/V3l
         NOTm6yTTm3Yy+B1ZzWyGlvhKvxzciiEgH1CZXv4qkM+SCPSDy25Zun1gcfS8jN7dnDKQ
         VBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tJshWkDF2CVYsp27lgxloaGQimeueesl8RBwt1ZwDYg=;
        fh=ENogPgdhe11COetCDqKKakVeFBb6A/tAdQlqeuevU54=;
        b=XUG695isD/9fUkC8UeOCu74NElHdS2CQ+jtbnSTr3HN+tONf749ZrbBZpQwPaI7/DN
         LrEPoGO7FHrnrwbCdbODOwZs6p8qwx6Sp+bhKE0xaONWl+34w8JMPer0WKNV97h+80km
         EqBeE8U8ANdDQ+DNWW/kxU41lSLUNQJPCF3gfNHeofEIcY4I6FlWh+TDsrBL4eeQ1iZ9
         RNDx+Wza5/V6rKDFTNpoNVl7Ch5qrcUHTSSQItJJjgOJnLFOT8InHx9/zKQjWDzaTE7C
         8jdCEmQMT4zRpQLVtd+fj9scNhwdAuSmKIJ82fZV513/P+Sy5BrW6sRsmYp6ZtdcP0Yp
         CQgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794257641; x=1794862441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tJshWkDF2CVYsp27lgxloaGQimeueesl8RBwt1ZwDYg=;
        b=MX0a2LBFjEV/RZFucaGU1f86oj+oUPzt+1Iajv+AwZjKMVAXMjp98s38uDKBu2Y0Dd
         msolf7iuG5qJMHHfjJpAyuvD81hiKWUTfdopzkZhWSFyWAZNl4wb0uI6flyUE6Yggt+G
         6iSAa4UGQ1o5WXAaoCbaic7cqOYR5BdaytLbWmkpVyAYp1yKBrSQadtaTkge1pB34Nl3
         SDz0OHRfF/++Am5gmjBpCwv+ZJGcocSrI3tFCi1wLQCCRTgEhU6LVxdcsQoqtkzkWJZX
         eDpW+gFtwM0nZ59F2G9LyyDRAnOks44IqrvXqW8OR8Jas+C/LWC11fwy9RvM5yfO2sCf
         +78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794257641; x=1794862441;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJshWkDF2CVYsp27lgxloaGQimeueesl8RBwt1ZwDYg=;
        b=wgwraO0Iwdxiv6muoI1Iio1bHLaiPnChkvhv7DVT4zjFzZEi2RMX7ymqHBXDBPg1cj
         3hnJqQn5Gm3t20m4nvjQiaKBZx2icKelDYfPx+lQMenLvMQ2mxFlu1CRKBagVdYakYoI
         CS9e9oMlrsUaKBLNLfv3ZBAr8uMLurvuE4r83nQHuaHTWboETP758DfF4hcUg2oHQrOb
         DVXBr8Mqt0dkpIfTseK1nykQGML1XDTyGDzKpDftFDkVwtp7XWnOqQxBX3HI/q2SStFa
         aWbHW8qCcG0mbLWJYaGNOS5b9mZztmfCEe6fypoKymL3xb77kkx7BplzXD5glCSJdKdv
         QwhQ==
X-Forwarded-Encrypted: i=1; AL+hErEvB6VnuS3tN0dfyRNJ+i+jFjCif159ZAwgP1j5U4pV82kla4UzwxT37R5dFB70UE/gI4A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8o69Hp0SvpTIi6/BvR+VNsY4PmjDB18pRNEDiWOngeayKZs+ZO
	YbDF+c+RnheYvjcC2R7L5RzMZwQc6kmxT/wKMrqu0JKnvolg3I8RX6pegjlKGPdiNQ1889drjgj
	FVVZd0lZEXYT5D7mhW0TvI4H8U34Rt8px4lTr/GQW
X-Gm-Gg: AYBFou34DYntbFUa5m772wy1vJ4+P9IE7q2Anjs25iJbg1kRNNuxQlOzwrhF9kNrZ3o
	m8tBfoYPjXc0zzfu2vcsu5JTrZqh98JOZRawxAx3zW+ZB9KwNscgTN2u+r/5pUyD7vsLtqWIS+t
	UFoBH8I5QYo3dQD18zQ2YvKuXnan1jK1hiKzb5Y/OCh4Bct9n5bUOr6z/tIFTRXVxL28C9qJV8I
	cjKQWY53GTKam8am8O5DekYIeO3FIib5hKq2i0Qup08ValRBETn42xdXVj8OtwuNpzLFH0/C6a3
	42PsQUk6f1dhG+0/j7uTFiQP+glMq8/cwGwjvnIIZLTdPMsT4jPCr9vb3fz07/SDuohV2USrRAa
	CFPgMUfZrIsk7vyD8wxrdzOSGvEz3fwW/xll6AzwEWgJhW/ftcKulCp9D6Rg4hNikgCCLYLUB
X-Received: by 2002:a05:6402:a54d:10b0:6b4:18f4:94a0 with SMTP id
 4fb4d7f45d1cf-6b757764774mr18849a12.1.1794257641073; Mon, 09 Nov 2026
 12:54:01 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106013927.166209-1-zide.chen@intel.com> <20261106013927.166209-12-zide.chen@intel.com>
In-Reply-To: <20261106013927.166209-12-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 9 Nov 2026 12:53:48 -0800
X-Gm-Features: AclHuK86JHMc3kTFU5jaWNU0Obj4DoYc-lJkIPeBBJWv59wReMypWf63mqzRBHA
Message-ID: <CALMp9eTKzAMK5G7t+Z6_MYHfUi9kE3t0YQDUYDu83G89xP-njg@mail.gmail.com>
Subject: Re: [PATCH v3 11/18] KVM: x86/pmu: Emulate IA32_PERF_GLOBAL_STATUS_SET
 MSR
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
> Intel PerfMon v4 introduces IA32_PERF_GLOBAL_STATUS_SET (0x391) to
> allow software to set individual bits in the global status MSR. Reads
> of IA32_PERF_GLOBAL_STATUS_SET always return zero.
>
> IA32_PERF_GLOBAL_STATUS_SET is not part of the VM state, so it doesn't
> need to be advertised to userspace, nor saved and restored during live
> migration.
>
> Always intercept IA32_PERF_GLOBAL_STATUS_SET to prevent the guest from
> modifying status bits that are not virtualized by KVM.
>
> Bit 63 (CondChgd) stays unreserved in pmu->global_status_rsvd to
> architecturally allow the guest to write this bit on STATUS_RESET (0x390)
> to clear it, and allow userspace to set it on GLOBAL_STATUS (0x38E).
>
> However, bit 63 is architecturally reserved in STATUS_SET per the SDM.
> Reject writes to bit 63, injecting #GP for guest writes. While older
> processors had silicon errata that accepted writes without #GP (e.g.
> SKX95), strictly enforce the architectural specification for
> deterministic behavior across migrations.
>
> Platform-specific EDS clarifies that CondChgd indicates a change to
> IA32_MISC_ENABLE[7], which KVM intercepts and keeps strictly read-only
> for guests. This guarantees hardware will never assert CondChgd during
> guest execution.
>
> Thus, the architectural asymmetry among these three MSRs is safe; being
> unable to restore bit 63 to hardware via STATUS_SET is benign because
> the guest will never legitimately observe CondChgd. Filter it out
> defensively before writing to hardware in intel_mediated_pmu_load().
>
> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
