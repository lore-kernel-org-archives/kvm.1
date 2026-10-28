Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793196221;
	b=zBy+gKwMDSboqvziygPB98nveB9GCxWpmf3VbvkPEScgoLoUrinspRzJgPWC6vwD+45S
	 tCIoZeOYubigVHavyvkcxFVCViTjE7btgLBWyU8c6hfRmftFktxnrfqSiacbvSo77Re0R
	 pIqcT5OqaLm1TyP+3GzQf5lNT5/8qIlxlVW06jgIOqLY5/crh1pbkSPcMO7/OBJEBDwuU
	 lELf2ztgGruNdZ/RZq+SaoALyCPXzlaREP39WseUPr9mjZpDJy25HPYsJIhUkgAv7pcUl
	 qto501vcpYvotqVTJGZdciBYAfa9RBiUiS239GgMH5eb0rtkzDuKfFiKzUzH93Z2YSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cpfmEgae6k5vFKgQGlkHKShN8Dis45x4arKxMEWCmng=;
	b=QNnF6xgDCURF1Mc4IwSLkb3ugcXxmfQAqNu3T/KRLlTOw9VVlLA2wCL/FF4ZZcGK5u5M
	 oqmWpE4nOtRj1gqK6UFad6tHoczU037jPt7n+nn63KNV/RVbX2/cF31eNqPffyXUSlpU5
	 kB2E1/U80rERePxuVeK9IkOKG3qdSdN1cSGhWiFfD3zUVTI2M5yOzf4uGO93qZYzIazlB
	 9KFXnFKd7PS0x70yQskD2vuPWnQelQUaxT0SInclvfb5XJ97lLMo4zjrFs4GIy1M8kTwF
	 GOAs5fhxLjYgc9ouG6pwRZwen/rC+/bWS4RchVFJ6RmbwMw2iVEagvK3+NlXoFyQAQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AasyhHij;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0F7606A325
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 14:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B0F7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AasyhHij
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so12579a12.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 07:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793196219; cv=none;
        d=google.com; s=arc-20260327;
        b=Q6OTSu65wnXfYim1ARqrcsi9e0wNztGYiw/5nzwYS5slMUiRUqORMb6ks/P5//pWwR
         YIcUkDtnSev4eiqS0QHsb3fNv//+H2ALjuDJHmDTXouhWcg2g8kXzW442L5yvAy25nbe
         XzcpCHM2KdfcikH2fLxMEYU4DATIXBdw0aM0zbJwe2vGaKe4k++Ven2UxnDlvxWuFGtN
         ACL5vez3OMbUl6ma51FnnWrKxgSjvLktgIyazR/LukgUZVbrJG9NpIM8JcG4p7hUM/t9
         +VI+6AsZao2DbxtOcy+/UKj8IGikZ3B9uWqJTWWrPt/e2l/M6rKyiQeS1prU7AiUhlRX
         FjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cpfmEgae6k5vFKgQGlkHKShN8Dis45x4arKxMEWCmng=;
        fh=3HTG4WgOFJ7GbK7OuMmJ59RyevY35UMGcoNu02CMRj8=;
        b=V3JhSZHhlvdamrozgcnubA1cWRfpFGPhvDfYrrRJJBLcak0qRgl1gCv/T05vs5fIKs
         Lm4zQRemC03WA7/NyDCblTTC2wA5o8M6VTG4lkqBqJHR3u7ub/KzIdyWhZfzkojW/ez9
         hOVAAU4Gf5KSgcZ/iqmK72hw8IlZ1eAOz3CfyWe6Gv4JaiIw5FacdWq5V8uE2zWjo1RZ
         lTUOgDi+QGsWEs4vRfaYAv+I+lOANQaKNsflduNZ1Ov47yhfftxbGIKwKwwAFRzv7Jze
         gUbayB1eAHrpavK/Lmlq0q4r+HVR6PeclybHGiQUEztolxhTE5Js6L/n7ErTut4ENfZI
         fHQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793196219; x=1793801019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cpfmEgae6k5vFKgQGlkHKShN8Dis45x4arKxMEWCmng=;
        b=AasyhHijWVk27KSw4bkqXndC0Gp7CW1gh1AhPX2N92gr2mrkRmJuGDb0L7bVj8b64e
         wT0EotOdOLXslQlqgiJpmeBBFVY5t6M+EtSu0V+TNCuBfD/cmznWrh1hpPEevRmmuMGZ
         7NIEvPfg0vmawLiM/PrwrCOF7w1WQgIMbMkJgWcDoKSV8eygtbko2vPGoSFoWhlDczUa
         RpOF8Jxh63Rb6NFfYp3xzrxLQ3n5SQgyhO9wkyy0HhQf5m0Y1ybVtZxAVFyoBoJFSKIU
         hWJ59SW4mWNysqYSTGEs+1TVvmecn7CJev96N0Umq4zX01pKKvnY7vKCa4PZGpiKv+zn
         fFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793196219; x=1793801019;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cpfmEgae6k5vFKgQGlkHKShN8Dis45x4arKxMEWCmng=;
        b=dKrdlN3JB//HLa4oYTU2HARaqfYJ3FPhTGB9OigbOsSG0uMfVy4tthKXeGcaTM+dig
         c86Ht2hQiGeRP3JNmwXFpgP5XBMSUdZk+9Y6tRj2r09XLOViORU6elEV9f82Lm822llw
         jSystdJdg5WZ1wIEzC+PBneD83fbouTUEj43FwWyIfG67LXMaXXV6Kbp00S6mBZA7Y0F
         EBavn2T7QxGNr2iWgs+HXaM52KmABh4pg2oLK4km6+JYYJ7Rft6lWafBVc6B++VPjk9u
         XreBmGfpnxpOGhg0omFY2RFiBSMgWfnbAQi0JsN2bpQ+uvPQKTCfCfzMEQrPX7SZwf7g
         TJBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgurxnPkfXcjC/rV/rEgjhiCdENen1yuwZoxPkOquynNvNYG5x6b5BvWjgxkerLJJYMzY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIA0IilDu1aelTEPGeiR94cGwwsfHFP7XFBIK2tCFSkq6rxOeK4
	jMJ/9o21qQu78mtn/jwqGj6L7L9r8b9kS97cEOfclrnZ50Ml7LyWCcLWl0NCl57AzBznIxU2osB
	3KWQlgQUaH8LBKt3xUVpXYkWDrm3DTMz6s3dajwoz
X-Gm-Gg: AYBFou0zQWD8ozlVtDMtWYOJZKLwcGmRnvzsxX/EUffUfeENN5EP8TeLvWPX0td1yo0
	y3KelPuL7VtlGKAMNlmOk5hM/pHhTc6RWsmv9V+ArPjzMOGgtf8hSZoBfxWWYZR/91ysNty7PjP
	JHX0bmChfx9O30XKY9sbLKuPZtXc4RGjRFEi+iMne/ByM5Wm9gqC9BygXYZqZR2/tQimle0XYSg
	to0vnxLeFON5GieNwUgnszkOJa5f0EXMHgNq3bETSLG10sMdZGfEj9yfYwUZYQM0ECXbsFgbD8w
	ykAi5/hPR6f1qQtQJjjMwpjxZ3l3gWdTIPhI6O1wR2+Tn7MZbytYNAC8FnSpHc9Bfi+atMs1lhr
	EZ3Ffrk+3CLmdvvC7NuyZ9fJT9jjVhTX5pF8J
X-Received: by 2002:a05:6402:115a:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b49c132c7dmr60883a12.15.1793196218894; Wed, 28 Oct 2026
 07:03:38 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-2-zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-2-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 07:03:26 -0700
X-Gm-Features: AclHuK_ME3QwLivxpHyWL8t1qkaUd-6BovWGILM73O3fpD9S6gvRlw9IFhopxcQ
Message-ID: <CALMp9eRwgCs9PGPbfC=WA7Jg9TQMZUU1V+2YbJE+XC9ndrR45g@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] KVM: x86/pmu: Remove redundant Perf Global
 Status MSR bit definitions
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:48=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> IA32_PERF_GLOBAL_STATUS and its SET/RESET counterparts share bit
> definitions with perf_event.h, which is the canonical home for Intel
> PMU bit definitions (e.g., PERFEVTSEL, FIXED_CTR_CTRL, GLOBAL_STATUS).
> Drop the duplicate definitions from msr-index.h and update KVM code to
> use the macros from perf_event.h.
>
> Drop the comment as well, since the macros now match the MSR
> naming.
>
> No functional change intended.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
