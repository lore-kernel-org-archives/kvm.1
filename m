Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794257435;
	b=GNe00ALE9kXdKwrohSZhdaB1gKILc+0M0mK8Z1JG4Eh0GFgXNWzT4hql3jCDeTH7rI87
	 NINHBc075qxD69B+bBytoJKJENUAkw9BbyoSSespQ7uEP+Ofzrdk0QclWvru5lQt+/21C
	 XhtjoMqCqYjQlmwmcgkjY5oIV/zO0mc0TMrRImUmXyvGmNRcIqcmim69xjsADYKSJyDr2
	 6tD+CE77PMXOBmAword6ST4nt6j+Y1YWIt23HvrOTihA7RDmXp8Z8b2VYOiN97bTcWK1I
	 qc5MPeQ9Sh5BAUwQO+z0FsExy+c/dGVqhUu7dCfDdHrrgktPOpVaQc22ym2je6Tpsgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GA8L4hGmAO2Ltbd4LpUw+HGTw9ExVwC9vVc3s9jVzIY=;
	b=1mleY6Vsc+pbYkPlDZSorpwas2PSCgeoDyRXY7zBAOO60JsSdGy54EPyX2SwMVA37KE1
	 twiYHadlu4NXXSCMj1hrngF9NzJ/f/S3WT0E7Sj7iGcWCF42hefyTGiWu/8LE+2HUhIlf
	 KxdIze0rQ0wwgyzl1VgkeTXYVXF5ol3lrbxe5i8OREOif0CscwLCtaAFP5V08GB+CeFHK
	 JQ/S9FlJvEu4a5dlLOCqhhLU2NEygAEa9+n9jaIXZ3vT61MkiGWHVtALVBJiMPDbZn7Gw
	 zVuCKB3eg9Uj0zf7FNgJbtEFxTO/y5+2hU5psifjT6n+WI55daoLmDmBaWASN2Yv5MQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jljl5C1o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B9C606A33D
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 20:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08B9C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jljl5C1o
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso3766a12.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 12:50:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794257433; cv=none;
        d=google.com; s=arc-20260327;
        b=Oyiei0zV7++np9E7jiiUTiHthBxJqLoKqDXHS1hX38n/60iqVrL2ICpi6wBmclZ7SS
         dnzO05EstlkM45JD8Z32UW+wFrnZPucdtXX/1DZDAiqjXVjhrjpCLqthy2preJZvtSyF
         WbQUdHC/Gl1SuzwnjXg2QSt1ofF/hvr8NVVZiDn2Y8ZCX2QWzIdsaSskc0aLPkqMSuuD
         UO8T3qSQD32vASrrFvtxgFofrvJGrAOh25tyk/qRByYkzF8s9dt5HRkkOR7Tsqg0En6g
         aJvTOu/i8xh4y1iW2EYz2heB+xrj4zgUh1nk1qaFYPZNgCFhPkOix7cuHzM5fIqTKQi0
         y+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GA8L4hGmAO2Ltbd4LpUw+HGTw9ExVwC9vVc3s9jVzIY=;
        fh=6tHOIPkX/VXEv7o2c/2nwmkfFRw1OhBBy1xJXntFhwY=;
        b=FN/Yt/cNShm2dHiZKJHxh2p5CuwQMxJJ17I9RPqxsZ+dJ2HTZZ0VmjUjDgyaLT8RkN
         m3QLulMhtfOYbLumbI/RfV2UYhdmQ/XROjXo0fupHwIaTSTXVaYrtkcypPTy7WDGNsrV
         YfgWdDFrwdlE6yR/gfLVZ1eoAGwYPQ1M1VDmOQO6VJcLfwjYdwRXjCoib+rvzdC2JsQV
         irWhM85SOFKhvrry/VkBLaWEHYsnM7MWguDO9DEBGXqSZc1Y2D1xy+TxJ7lid/nIL71Q
         z31eY0KzRJEw2vPae5pqx2RvlEZ2p5HifTFVZoLSrWngFXl6T9INKRCUATFF9AAKjxts
         ANzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794257433; x=1794862233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GA8L4hGmAO2Ltbd4LpUw+HGTw9ExVwC9vVc3s9jVzIY=;
        b=Jljl5C1o4ArGRpAZbn4DjdP+lM44ctynb9Sz8vaKMQxRr31sH9hX/sUHqhL/resu8h
         AkAtQZ0ZZZ+dzXQAWbG4HPnJEBEU/1Yl9Lj5k2VcSYFddk6pc2+h74MxnHo2ikb7Ngky
         58AaqbtjOLgKv2RbzwZkhsdNqbcUdP38lWIEVtzNgbaVlO6vQJ07Xk31FmVgT2ym8okz
         PGcIIUQivqH2oIr9pegq8iSivcdQ0ES2a3LMs3zi4PJAQHaeNV0abatakyOwwTaltiY2
         CxwgeLRpsBnsMR7JJu+wQ8Q2R0LblFscdSJ+em2uf2uGdcpkBJR1+xgAYXDpOZmTl2xq
         5cWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794257433; x=1794862233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GA8L4hGmAO2Ltbd4LpUw+HGTw9ExVwC9vVc3s9jVzIY=;
        b=FiUT13bIKHIIrJaq5rkYLezLIQZtjRr7HNhUzQSyOmERWJ8TAknEQlx+93I0OPDXHa
         QjuSk6Xid6Jlyf6G3SMI2CDQblqpHZ2mPT34M7iUEZpqU4rxq+rtE4SBn47m7Z9rAI/c
         TRuleLtC8RQDtVfQS7vdhVQNrbyiruwaLtybXWbENmGEtoBzCjUT+AEUz/45hPnAJSHl
         VEc28DVSK+qp8ZjDoz8H7B1exbc8QRww4Fxl7hHUt6xBQJwhw2oDCI5+IvWCxVKvaDvl
         AkLKIw43cPbVP7/YJ/H3UHAL8tP2h1YY92CzZ5qABLdrOf45PzxKNhJ/m1W35d9BdyIy
         Ilnw==
X-Forwarded-Encrypted: i=1; AL+hErFLGntzsDVGctmESAhxsVDY6axA3H0bJljVmW2mNwkEJeGw0pMmryQr5vOE945W9ocrF6U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DxCSN02Tt2HXKxvJ+vQ2jTt6vSCODkGJbLCJ/Zcr/lclrZd/B
	zY7WGa9XsUK6P69UWdhxCJSkYMuf5mvO+35c6PwRJ9T+PsMLJiCRWtmmj/0zOAgPq/yPVzs3vfc
	LvxHPz3hx8Bo/6snYPTvWx4saMopWWbffC0hMJhcZ
X-Gm-Gg: AYBFou3JxsDB4hYn7buWDB9uieask9T4pNylQU/xCwcqHxtDUKnPSB7BqFeduB14GOO
	E9iM1voliYNQXeYU9Vqx2shFMy2K9+ANIv0FHSMWTyWER2F6vv7oOtQcwnMxft250c3b60zdemM
	1xC9VJgMRPe/RiRyuDLJWHsUVwypxFIwQyx85Rl6p8ryYWMVbzlY458/SWZ3/zvy04Ds8GgwjVg
	DZeQnm10YKddhGs/BL/rZtYFdbgYRAUYVUJe5DtH5wT9eXZ3DAAWQywMrancUW2d5F5q7rj4rQP
	l1f5Sce+i2sdlBrigiwaDwZq1KpUzb39Sxf7ovzjJ29DQtv8ZyHjwzrJuvrHksroVVe2bB1NYTR
	1i6t+u7tNFvI8tRktjzyoUBv7QqlKuP5Zy+kyZVp4kMzzTVjdIyLro+nLDQOtvf+mbh7Cb2aTyw
	==
X-Received: by 2002:a05:6402:15d3:b0:6b4:597f:50ed with SMTP id
 4fb4d7f45d1cf-6b75782c6f4mr14194a12.5.1794257432903; Mon, 09 Nov 2026
 12:50:32 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106013927.166209-1-zide.chen@intel.com> <20261106013927.166209-9-zide.chen@intel.com>
In-Reply-To: <20261106013927.166209-9-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 9 Nov 2026 12:50:20 -0800
X-Gm-Features: AclHuK9d65x0k_uzknW0QEmJhRZeXsPMSFJ7esl5jri3Kotct2khxELM21sZaLM
Message-ID: <CALMp9eRuhRXuFXmMQuFk3U6x_2DzeBYbjjhsziOjm8-jKdK+5g@mail.gmail.com>
Subject: Re: [PATCH v3 08/18] KVM: x86/pmu: Switch to bitmask-based KVM PMU capabilities
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
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Intel platforms support non-contiguous fixed counters via CPUID.0AH:ECX
> starting with PerfMon v5, and support non-contiguous GP counters
> through the Architectural PerfMon Extension (CPUID leaf 23H).
>
> struct x86_pmu_capability now exposes {,fixed_}cntr_mask64 bitmaps,
> which may contain sparse bits representing non-contiguous counters.
> Switch KVM's kvm_host_pmu and kvm_pmu_cap consumers over to the new
> bitmask fields, including iterating kvm_host_pmu bitmasks directly in
> VMX and SVM PMU MSR intercept setup.
>
> CPUID.0AH:EAX[15:8] and CPUID.0AH:EDX[4:0] enumerate only contiguous
> counters. Derive these values from kvm_pmu_cap.{,fixed_}cntr_mask64 as
> the number of consecutive counters starting at index 0.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
