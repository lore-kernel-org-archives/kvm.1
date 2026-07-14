Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECADC27F19F
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035183; cv=none; b=SGPStXRsEowo2cWuV/jUJpV49o8a1CsycxPgRhIivbkwKRtRWERBQ0F5HVragZOmatNjBVeiMVuxPMAysB1FJJQOhFcgCwULCFT0ntUxgG96yWIyqSBZL53H7X12lWP+aVQtZkCET4L5Ka9k2HAzDxRzowEdFGCxjgQaxjhxlG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035183; c=relaxed/simple;
	bh=gNQbWMo3+xuQy6Kz29z7hYNh1vRqVYw1Xiy6UBJ5LhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntiKU7AdZ74bZN4XpJvTEVdeSTjWwtkNwnDpm+J4uZpkleSX2kuZeS/Cd8seW4b/GJMgFgW/YdSEM1TrdbmuZ/SVJQq4v9/b2ZWOVDjtItwdIaIljCSXzc2G5ll/FfmXA4fuinwcFfGpr9YyI+CKqGtkwpP1t94Zvsycm/g5VXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MO7qv0lb; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MO7qv0lb"
X-Forwarded-Encrypted: i=1; AHgh+RrsEc7sdTxDPlqO+ae81EnV77IRTovfEfEIjMd7MViesevTl8/KHuzAKJvXWB09D/0LBBE=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784035174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MisgD/Dm4jfxdL+N9uTf8UsCLM0Rw/O7yRZ2Ejr0nAU=;
	b=MO7qv0lb4JZYNcQZNPTe8YyMcAFTwHU/QFACiZm5DHg+oMUsTivp2fc74wSVX2P41kXlLh
	nZMuWyd0UxIn2VmbSr7KG/IF8j8Tlqw0uHgRUah5aZ/WkySoBseG1e2RmJ3SL+Ui5pfHkf
	9i0bkMtnxFkz4kUj4HJLIFahDIX/C/M=
X-Gm-Message-State: AOJu0YwBcMI30LtjAYthftHGeQIrMEuPMU70uJNUUnrbo8OpFHYRe516
	LoGRF0EqLRxNZGA2+Xr8eWu3bpPkdFNCD+Em2gzlRnUqC1434GOkt7EXBb+AoHf2JdHNj+AtB+S
	F08OGClVUASasGR7V+TpK4vfxccywNqMILBm5muOp
X-Received: by 2002:ac8:5787:0:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-51d7bcc7aacmr14328561cf.8.1784035170138; Tue, 14 Jul 2026
 06:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714091641.1970822-1-maz@kernel.org> <20260714091641.1970822-13-maz@kernel.org>
 <20260714094609.4ACD11F00A3E@smtp.kernel.org> <86wluxokv5.wl-maz@kernel.org>
In-Reply-To: <86wluxokv5.wl-maz@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 14 Jul 2026 14:18:52 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzFRbu+woK8yyGLdhrVe+qEerw2cZVaQ-06XKDx8mX8UQ@mail.gmail.com>
X-Gm-Features: AUfX_myOmQ_-286nUyOzdr2MXl-dvEjJDih84jWWsiAddgpppNcY09PrjHTx-ho
Message-ID: <CA+EHjTzFRbu+woK8yyGLdhrVe+qEerw2cZVaQ-06XKDx8mX8UQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/28] arm64: Add FEAT_NV2p1 detection
To: Marc Zyngier <maz@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hi Marc,

<snip>

> Fuad, can we please either teach Sashiko about out of context register
> updates not immediate requiring synchronisation? The constant
> insistence on having ISBs all over the map is pushing people in doing
> the wrong thing.

Done:
https://github.com/masoncl/review-prompts/pull/87

Cheers,
/fuad

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
