Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE43A2E21
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589606; cv=pass; b=ukv00IMkM5HNAvJhc0n7my7Qu2y75hiGj6vg/n62fFyAmw326CGoz2F67uXSYTNWSk9le0dUBhe9yLYO5GDy9Y0c8eGhE5WnixR5tVecK5wt6lNnhtKQfzydzVltpZ0PMAJE89cofb+aMqU/gBqxkrth4xfU6CnEMbyMcEFXbpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589606; c=relaxed/simple;
	bh=ZjnY8vIhRprJOct81kjjG0QGweHvVimxLsEl6GOTCtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHaOkJR9Q152qXZfi1J07IBOSffD2+RhVAexFYBzxKu/GnzfXAAIHuCM2uDzmp26KMoZZe7Ib7b++SWXm2phRCMVdt1a+Rpk6dwotuUa0jrhm4KuCdY0dFVMHN3yN18CX6gDgfMBi6KhPLZeVHNdng5g5cMkDF8WCyS+/j8hJpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+WQjrAU; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+WQjrAU"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so71a12.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 05:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778589598; cv=none;
        d=google.com; s=arc-20240605;
        b=QR4C2+wvAbWt0fEWdQx7PzkH7H1ho74XFC5ULwem7iY+wYx3MPCRAH14wwLzkjgIVq
         UcHpmWyMo9gQLE7lXkY9EoCtGIwKJSt7iopBcQVpVdik7R1PJHworiLsxPw4ACy9Hsgj
         pPO6uikBLpBm+Slf3dHkIVspnEVqDRevn4DWA+osW4vtQlihBX2gT5OhW42bheFMluSE
         hwGjpPL4EtZwojIr9keW2xhLYKV1fVzsjTlHcz1K04WJck12EehjI13r7zEPk4Qtb8Wl
         HscsA3vH7kflKK7FcaebG6UpJW4+pEseEipqv6yNWsehwmwsUDUzrwK5X9zCwoUAjuvG
         QDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GZKiNWlWL2FAZflKzAl5phrZCGRQJtgrE7BPel69owI=;
        fh=IKrFi+sBNnZ0PtoQvj4SFECUyrOOcbovWnd2PY0zfQE=;
        b=TkSY3Bpav+7nxvvK3L/BHzwYfTfAn7wXpWd0ufPfe+kx/oT9Fj+AxZnhiz0S0Yvk+S
         MfFpvP5UhvbO8PnNkZ51b25Yu91DSdZVYhGBIlix9qJsb5QTHGDB0Mgdd3uGkZ/RKlKH
         J1pKUKTlLbZoDH6sknm4NsSdlHiN0l4BIWBAzdSAthQXnokj5hRH0BwdLguYl+SjpRtD
         55Wh48jDqDUj9tzFggUTvnSmWx+xsS9BdR0Z6J1y18hNoQ6deQ6XMbjiLHV6CmDZ4LOt
         IUSQJ/c9cFytgTC74fjWyn1pCPkUm5WFvZPABsGZp0C/E9EIsSGUmwWXRBjLUP8QLeb/
         Kgkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778589598; x=1779194398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZKiNWlWL2FAZflKzAl5phrZCGRQJtgrE7BPel69owI=;
        b=t+WQjrAU0yMoz/73MBtW2am2mOoXDtdLZCwevLTkPiHNM8X/5GJwcJwg8PW8Rox4DW
         qAENuuO7gLDo384Ek26I/EgF5e9zNcHykCsDRhj3CDhLKe8bGM3gBZbXV2RTCfj6PW2z
         UwF13tI0SMf/WyOipLXntPNmX/eieX6lqFdcr47lEGnh69pfCPt5aJQ7z5qFtWEzJArn
         lQdWEiAoNNKL1RFhkbBsYUcqRSFvDk+pz4qiT2p7Ci6UoXziZ+gxpxHytYaFJmebz7hm
         Cccq7U4+uZp9rirmjhJh1z2Mz43QL9cW6ycqb56CJJFC9AIax2hYzUUimYwEL4epiWcD
         r0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778589598; x=1779194398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZKiNWlWL2FAZflKzAl5phrZCGRQJtgrE7BPel69owI=;
        b=YpA2Z9cOYGXc1STLlAKpqhxtZ17JzYvUnFmZycS7VOaZXFnLi96ATftgWWUahEOOv+
         Rl9TD/yrdV5dVJ3DxPiDZSoXE8u6dA/V0LPOISxKEmX8pO85IAsQfCzOuVC5TiD0wbUh
         kxWbZTijOz8nd0I5Nw4aeZThcuV3HZ66BSuoCsdt4e2NsO/2VSeybbT/ItCgOsh7rrW7
         XPkBS1D9OZmbmWSDl/yuLEqcVJZjwD7rvEan58dfl+CGSWuwteWELMj8RZyPDEWaqJXC
         M3ZB9zzPiBplEAkIjp/jieOVyQRMkrikbYmRi+YhOnhD2tyYn7pPPO/oh0WHBumP/Xng
         tKQA==
X-Forwarded-Encrypted: i=1; AFNElJ/WN2E9JnmyiGdpVBfvhFBfcgcIy/6AOwk4Z6Quyjo82Y/Sn+6iufPJbWvt1g9R3eH6LXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKhfenrs9igYYXOV1s/tdaY0oey46Z9oCHqdroodY9h2Sdlwg
	BpiBGC7EusL5FhP1cVAUYg312iEd1mNvzCxwBTBMsOxCxLYOCssL4G411HY666CFpP2r0xCQ9gL
	/g8MhnmDu2lXxH2Pxk1EYluaSBqz5sYTNn7HZjZr3
X-Gm-Gg: Acq92OG4yKfYo1NJhDBa1B+RCcHjwcSXvcoJcny0AL4wmGHYVILz2DJ2NhvTBJrrYAO
	5wo1qCMqOC8r5YJ+m5Abkm8oXM8bry3233BGPaLtzMPxFOjHsIMK7DyDGTpBIPeAhbwP+Q+UMND
	ZUrPYTEnDs7cFaybQ9ZLEKSaDY7aIwBFyMEMe3AByLm+TAtCMK47HUfMGrhGZYM5mHdtJYxENq9
	D7gm1YsaUblU23JnyRWaavR8BSKJm7QECpyeHrC8aEVs30YVkBY3HHG5JsIZF/i1QbsoE+dJPjI
	pmHXn0K/QRlZkcofcQ==
X-Received: by 2002:a05:6402:160a:b0:66b:e078:5934 with SMTP id
 4fb4d7f45d1cf-680daf097a1mr34294a12.12.1778589597723; Tue, 12 May 2026
 05:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com> <20260508231353.406465-5-seanjc@google.com>
In-Reply-To: <20260508231353.406465-5-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 12 May 2026 05:39:45 -0700
X-Gm-Features: AVHnY4LX6uhXx_8fzCenS_BE6k3foQYYVMRhYxLYCauWDZIM_aClZOiuzSgeNIc
Message-ID: <CALMp9eRcOMSrrtp0SR+hVLAKaOu2AWKJnpGT_51mQ2vJOJpzfA@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] perf/x86/intel: Make @data a mandatory param for intel_guest_get_msrs()
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 4:14=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Drop "support" for passing a NULL @data/@kvm_pmu param when getting guest
> MSRs.  KVM, the only in-tree user, unconditionally passes a non-NULL
> pointer, and carrying code that suggests @data may be NULL is confusing,
> e.g. incorrectly implies that there are scenarios where KVM doesn't pass
> a PMU context.
>
> Fixes: 8183a538cd95 ("KVM: x86/pmu: Add IA32_DS_AREA MSR emulation to sup=
port guest DS")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
