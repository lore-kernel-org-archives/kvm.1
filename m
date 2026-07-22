Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C554582C5
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761563; cv=pass; b=olR0sNBF3ly9j5qdPBgaF5O0mcCoefol4MiCQIg2bQTuMXEPVpUzVeKiV8Vx5NLmpMCMXYp0UOPO6wY1WosrXhw7WaPxGWZ+LNETVFawWOnk5aJnrojqo/xc9r49k9a3I5jCAC9ZEAPUXkrvNeAx43ivpNj5iow0l1tiWIhGbZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761563; c=relaxed/simple;
	bh=kUaCB3yg5kGyxe0LZ7rb0xVCWaeZsoqNl9ndTp7k3hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jy7YwcrbiU2jNPlM+CAvh2LFOAx3bu+J7a4CD1oBdmWZGYKyWVvk4GNT1xCUCTR8yxRpm6agPMCvKinlsw6Ea+3VW1JzDopZQlKF634akNuU5cuYP6dhSyti8q8y8Xy5FrFrzMsrn2VwIe/XzT2R5SShMegRUB7jiH3d+rR6tH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJ09g4aK; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJ09g4aK"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c10e86e52so26261cf.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784761559; cv=none;
        d=google.com; s=arc-20260327;
        b=ff5A4Dl/vOn0BbIfXGdJdjrrMQt451OBmYXi8fTWLFq3Jr3PMm/c3O5g9A61u5iVA7
         SLue4cBo+X8eRWfOcGfD7lVW3asnzwfqd9+ZN86IFW+Ebxuq38DFvBQIUmxxD55gM6sX
         VDQcfAKu/FEFdki5QbiJFkVL3N1H5XZ88+Y7DynySmgsE5Y+8mq2/gqmxwKZmCmdXaRS
         Mnr3uJhXm94wxwOvAEfthkh9c4JHkdy9qOwRiH2ivAaHmUtqMX0KBnzCtuPwE3g5DJW6
         W0yA1JWg43IjQl0SGBhrVSxcRb4mW8MRLdCh+Dky7bsF2cv6/iJyqk7ZjHIy+TIWcLn9
         HAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AHZospa8mdOiGQxDwYah7qkDBOlerzIS95gGntALhNs=;
        fh=ui+ahdXufnlXvUpqVy0VS6vDKLKFMAGKZQmME5/PRa4=;
        b=VxTheIPFaC/oQT03oc2lHhcGBsG452VSGB9REHzT2AExrlPBC2B6RwJnooudEOZPci
         ZN+ZfzXtbljNjb2iatBOnIFP2jEnha0P35XHXpJX3H5u0kJq/+G/IGn1gnhdqTv6YMCN
         U1RVhapO6tRrYt5L0sS9X3a89uYWsqkNQF5ec5Em4wFlmo2nBZRDgSl9UbO91eHFU3il
         oasoVW/uw3CPZzd4BWFbLUasMcRgA/grQIPtuZF+0dM5QjKr8gF7bpi0WMHgiu+gQWqI
         m5W8Y5Qd43tvTT9x7bZTx5+S1pRDEaJisnHLgdazcz9eGtgn+65vaFDbbZHIs6nUw1cz
         OwaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784761559; x=1785366359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AHZospa8mdOiGQxDwYah7qkDBOlerzIS95gGntALhNs=;
        b=WJ09g4aKRI5FWw+HRSGTDtcAAIGZBi5eEUQdka2E4X3PcTlOl9/Teoo/LyCRVO1bRL
         FCVbN+JJH+aryHeVhH9Bdr9umlI9xFnbrpV0Q6Dtz4HTv/VvYSuHNzikwjTN/tjzj7lL
         zOi9jdydb8jjuywKMqbxPte1yn4P9sR3SNtdwhap5Pf9k59JMXXFbaV+lb6sNEN91n5p
         RDDNFiF+YwvBtKnx+M248mQzem5HynbDvsPsNXKNy1Lwjy244m4vlcBNPx61sjHvRUxp
         dLlRGIzCVv7hdQy2/h3y01GsYrbK3G6mkLCv2E4z7oebU5g66EsOirB1Hfqrl/Bg/N7t
         oJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784761559; x=1785366359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AHZospa8mdOiGQxDwYah7qkDBOlerzIS95gGntALhNs=;
        b=WYl9AAmKGRxJ8Zn7W9ZmjpQhNxpsABca9n3ecUmJ6Bq65+b1loPEq8Rxf24k5UP84X
         +v4hc0bRxaxg1veAOWPk3m2RQ8maJR4ghpkbf/6BpWN5sTZ0ZFNmgssS92RMEJCWCB9+
         W8ABnhq39YXL0yeZxzcq6V3ko4N7oKcF/W0rbxwslx0jZsodf6+oLUvVxEjaAXpqpA4h
         SeizNRwdF/Aigdcf9ZRvB4+msmJw2ZSRHE+K0KaL4Mc8+Yq9yCzmpUQrBYC7z3NEoXzc
         ELnzS41JUJCu3anfyoA/hEx7pa+SpX2sIH5/jLmDzoSQ4HYOKrAFb30dXeHFqkqzAcEg
         2k9Q==
X-Forwarded-Encrypted: i=1; AHgh+RoznZJJy8//rjAPkanBOYuAs5Eb0UkmDBCi0OBSq8PeHnE3XfX6x7P7Y7WVGAjBj0ZP4a8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MgY0MtPO43pC8gUfkx/4oOD9PMhYfwhWx5vPEWY9Qj1qxbHS
	fCwn3+P+iJhltahZeb3Lb8AdiFvRvIkLUYo14pUTmzBXU39E5iweCMJdDXGnTFKbcOFae0wcW9n
	xsPlBCLoIPzK6tLaqlxjjy8WayP4UarNV79E/xdT6
X-Gm-Gg: AR+sD11JcZVogBKuu5CcXj8rZuTO4YcpjSEqwCHCfqh2qTnTuj2COUuE/pk9bsNRVy+
	eM45N6IA92Z2lN4fC+VA3boyCGmQLQ/UC2BULJXsxE/ybUh2zLwacPqfKqNEBIIHeUWQupGQkMB
	+18gejg4pwvipOgpHB1tcTuQ8WLZp9QwCdf2mgzuaXk+cZjCLT5dlFAbEIMf4wOISwfppVxpNEX
	xlLGvrTvnH6I33d6v6ogPTWSV1P1iV2qjidwlDZvA28mkrpvGDywqcWXa0bTA==
X-Received: by 2002:a05:622a:aa43:20b0:51c:7a90:a797 with SMTP id
 d75a77b69052e-5283d85b7b0mr1924101cf.23.1784761559160; Wed, 22 Jul 2026
 16:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-6-zide.chen@intel.com>
In-Reply-To: <20260629231938.15129-6-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 22 Jul 2026 16:05:44 -0700
X-Gm-Features: AUfX_mxzmMctSpOuQBV-JfvLh_8i4ZkAZ0ic8xvGZpx0BUWGOH4AK5zqOhLoIS0
Message-ID: <CALMp9eRwNkdpH1UBJM6_ULiNWy53G3FW1beaHY4RVOWkt-vHtA@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 4:28=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Bit 15 in IA32_PERF_CAPABILITIES indicates that the CPU provides
> built-in support for Topdown Microarchitecture Analysis (TMA) L1
> metrics via the IA32_PERF_METRICS MSR.
>
> Expose this capability only when mediated vPMU is enabled, as emulating
> IA32_PERF_METRICS in the legacy vPMU model is impractical.
>
> Pass IA32_PERF_METRICS through to the guest only when mediated vPMU is
> enabled and bit 15 is set in guest IA32_PERF_CAPABILITIES.  Allow
> kvm_pmu_{get,set}_msr() to handle this MSR for host accesses.
>
> Save and restore this MSR on host/guest PMU context switches so that
> host PMU activity does not clobber the guest value, and guest state
> is not leaked into the host.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
