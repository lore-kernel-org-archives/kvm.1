Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6F47209F
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371286; cv=pass; b=hEB9+5CpbYRdpv+LLJebtQQ0HIGzy6piuXMcEKXuGtJ2upFdy1r7qLu0Fk2w9nFZA5rn8dfYm4cx9L0mTEtFIUsREZxxHBkz6f7BiB6g0MmyTOKxdPz0Puc9LMlnNiFDx5P0uOjpQk8bNM4TSdMYeayuF3meNZN1y+7X+ZfLZuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371286; c=relaxed/simple;
	bh=n6pA0UCaHovGcyxtuarmqmXJupW57jUc87NPA1SduJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zd0JPAOax4MwDW1eFdyuQHyhM31fgirS6LkWT5KFtyQ84XnJylXl0nOOtJJ5Jv8cofvsep37W8q6wLRZopwBpZcTSdaWr4vOdQpcekYb0ot5lG0gPFVXTcLygIvS7TZ7hf2lyb7jc4lt8Y91NtZy5Yl38dJGIfpkRRksnjWhnkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKNUYZrS; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKNUYZrS"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5ba40832934so5770e87.1
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 04:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791371259; cv=none;
        d=google.com; s=arc-20260327;
        b=e6RLFRAyB2PHjLzElIN1wzzLYJJCjqGIZSKKglwrqnu3i9ZiOH7+gyC8/kqwC2aGqH
         hE4oWWjiRyp24lO3YGGPHSef5coPTtSEGuP7G3NcSJ+8izm2oFZ0xItOnWiFpMTP7BCT
         9ffRka4D0xg0npmcWWSDeDp2JAqXDcP/qdyJP4pnGEiCb/tAXIo32WeN4YIEs0CzVsr5
         PzfeHv6rtnbi7rmHhblC9U2tPeeB6jTPL4LV1nyMoPXyUvUE1zyUsbw9AdfmI8I+M7L/
         kHZBEKmvhHT5oZHSDve0n81RAb1Gt0hRzCWoCHQKadVK2lVC/4i+JY/W67swPAS3LqIv
         G5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=n6pA0UCaHovGcyxtuarmqmXJupW57jUc87NPA1SduJA=;
        fh=rnIkUf6r+pm8oCQPQDOHPhdYLJEIYxB5Eh3hMNjkNs4=;
        b=Wnvw5XDVT5nDasU1pd5iNb53otcXShrSkXmRN2rTZQSOFfeKxzHypNG3N/T9oV2ozq
         uz3WN1YrB9J3KpkGF17stxsaKPqfXiTgYv/PyM9cLtMHvAYVKIA93L/eWCsJwuiW6MAw
         a2P8cyDxI+hjWYqaj9lWSJRJ8TlQVCiOHOSdxO/4mzHJvDei3xzUSUeDrnll6er+QgoW
         CVAAmd51/69D92aZD9tykF3cYm2czI6Pq0RjzlLtCRropfdU118RtNDg3bNDrw+Bm7qf
         vhdLmW14MOb3RjTgosr8j8obuNp0qCZiNsYBskrPnjVwdU9J0FFIsLkTPxYiz68dJ2Ew
         U+GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791371259; x=1791976059; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n6pA0UCaHovGcyxtuarmqmXJupW57jUc87NPA1SduJA=;
        b=VKNUYZrSB75c5LLenbrV7FhHAZNT2cDeAHIYOkHFR+dUV/Qn4gwjrgwLQ1qBnYROF8
         krdtkgOwoSFFGzpYzotuCrzgjh9mDwqz4ghA6HgBdBaMGNcCFi2uYASdXwmRfwtwBX3h
         288cLJ8ZLu7GMo7ei2iPtJVNGzrCF5P8Vf2fv4kbQ0kXipl3Py/1yJ7ZeIYWUtCFzCH4
         h4X87JtOqjf+jNnfXTpT1tMVl1OEUQl/oQ75LlZ7Lm+2QYNe8JYO15IlO8PR3BP18dio
         WP1yGoWU0lxJU9m2fJCdoFBvd2BJOayBYsuR/62nCsWhVPMW4WMNlilrvBZVSZg6HTWv
         QAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791371259; x=1791976059;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n6pA0UCaHovGcyxtuarmqmXJupW57jUc87NPA1SduJA=;
        b=HMjTuVmm5k4TazVbk/nnNdCX3rkPOrS3SXyg3QXpsWKJOI1cSJpdgKtKISgXZBkget
         QOBWoCEMMOwJMzOkoZExepgkkxfEOQHcaBeOPWcr/e66HuitAXpuDRUGLF3e6WytefSP
         03lrKL3S7L/agVWpIt7UDrnRmsvvqLO/bpcUlKoCYfYerFyNuJ2jed5FrvRLHL0Cjsys
         SmceLlnuHWh/N+CxYQ04XeVDGdErlUVSz1g9DWMZ/WHSFLbiwnyNy8YGFUBkdAlQbQgV
         4MQ4a0urBzqL4ewy+/UxR+vh8SNuqx7YnkP3LeJebr9MFqMXbNyA/YKCygsb5D4DDW8o
         OwjQ==
X-Gm-Message-State: AFq9FYKprZAkhwzYsa8eHlZWN5AJTKIKXX2EEpc68vQhDDPoPFPNOlwS
	ybAm2Tygp5PxZCG7pTHIDQy9daBugQZpVXQwJrkyBEfkMoluxRBk1mCFs4HmZ80U93pC37gYNgp
	8fqwvKPV0P7mMajmkeQhyOwkuxpiZqAemUgG4QICC
X-Gm-Gg: AYBFou3m+rHxUyF3eMMxspxu2tetWMshGuDbi3RHIZyG5S1j97oRqvt7SqqqsRGF4l2
	ntqdeI5xx3oIlnomvxiyffHDCWevt+PdlOetR7L+vkTnd4xEtOM7lsCjzbghdiaCkr3dqtHBDn5
	53h1aVj5PD3sFUgAL/lz1qOeb32TNObsuzijqDEooFFKcHbpq1Lx06lqJNsrD1Wa2HGOGs2HzX2
	5BVF6l9mg6ENzLMPMtCvroyyb6MBgLEFO/1giZ7onZlJu3z65wh0/bfo8WQiPWkwfoM24jIXZBU
	NP6XzGYkodhg3vNbe32PNxZ/v5arwOMKIeig321roTB3Xo1xG7F8+To=
X-Received: by 2002:a05:6512:1189:b0:5ba:3534:fb8f with SMTP id
 2adb3069b0e04-5bcca674bb8mr331538e87.15.1791371258668; Wed, 07 Oct 2026
 04:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007073537.2454351-1-suzuki.poulose@arm.com> <20261007073537.2454351-7-suzuki.poulose@arm.com>
In-Reply-To: <20261007073537.2454351-7-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 7 Oct 2026 13:07:01 +0200
X-Gm-Features: AclHuK_51tZ4nsMn3i-NEL4Otzbz7dcWMCHjhG-tWBC19X6nKIZVcoWjuDrLVic
Message-ID: <CA+EHjTw=9e4xv8SmUggCgHBM+uQ2v7dWSOf9PeBufMUofYPMwQ@mail.gmail.com>
Subject: Re: [PATCH v23 06/14] KVM: arm64: Don't call vcpu_set_pauth_traps for
 pKVM host
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com, 
	jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Oct 2026 at 09:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> vcpu_set_pauth_traps() bails out and does nothing for pKVM hosts.
> Clean this up by moving the is_protected_kvm_enabled() check to the
> caller, in preparation for adding VM specific vcpu load/put callbacks.
>
> While at it, do an early return if the vcpu doesn't have ptrauth.
>
> No functional changes
>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
