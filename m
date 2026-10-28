Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793208830;
	b=o32luqbzPzqVQNE8AY1FPwsQZfb/P/l7C9dgcAwjfSPtDc5FoQxMecWII5eAyryZGleZ
	 AP/MQX1WHAGMQlo/DqHJgWuy6kn0MJdg3UKqhNvAIg18mhFGmL5//gRx7KoNUSJcxKJdG
	 pMCBE3oaetdzibzgqEXQPoW9VgG5qlcQN/5KR9YCDR4ZTz3NKLECFUQasOCF2oy0QEjj8
	 2/5cQouUnYlmHgxVFG+1flNsbyVHH0DLyQqCMdPtXqVD4M3N+FcSZnF+vdrvsQCAqMZd/
	 DLhbnMrFBgutJ1Bm5IYDmMs0mNhao1iiU9ET/pdndUJPm8aPSr9bDbEu4f2paItu9fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4x4ogCcrIz3iULJj4AUcmCmwpvZhGjnxniSpLhEijJA=;
	b=4wqdHVRLjAfYgJVd1qG01TD4x5G4CF3MsNWLH6M2f5Wq4Oe2auo1LxFrJiWrUXz7vlkI
	 ljNdhE+SFs/8G0v2jrsCIgYQOG975DdKcltQ+tkH9egpzufzvvPFqwOeaJ3BlKp/LJ4uY
	 6KqWOmDljExlywY6Mjp4x3AEwesIIXrYG+/lM75WiIDTe/WakcjV7x1Uyhma0DHyeL/up
	 fDpbGiy3krB5vFzMomD80h82GWLmJRZszxt4Xxg4ng23SwjLLzd8BpcqxWQpFZqR6m2Li
	 1+eQB1bLLEFue58LYn+oz3fbnE0TiPjrEWPt8mERhQTMLTN224pvn60X59vCLlJ+YGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hHWgMcjy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BFE606A31A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 17:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7BFE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hHWgMcjy
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso942a12.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 10:33:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793208828; cv=none;
        d=google.com; s=arc-20260327;
        b=CuUsZxIRrN68SPh9DOBl74kW7jeZGqIoXztlzog68dRnXoFllMK6NmkGPcQrSYFapG
         9ROiz4saTmgkh0eSQ9fWzQuP9Ho9CFyqLQXiUC0B59Mqsp7Oehq2XHJZE27Tn5S/kk8+
         yZ38LSilYY9NsgaZCo3Emn4MNMIqQ26/WgcreST8nrfKveOp3m30VPCtlCticKVCI/un
         xZmNr9EZ6f21ErnaOhzjB1U2jSprM/Nw3CA/crVnjzXMHGiA3lyBWIwKe6jGnvSvxY0g
         v/uE8a/N2WdFOJHiIF9XP7CTGWAYZXiheIKQLC+y8cCEO+n6lQ4Mo52EokEwrBi6gZp9
         BLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4x4ogCcrIz3iULJj4AUcmCmwpvZhGjnxniSpLhEijJA=;
        fh=f19tSADCqvJ13UCXzCuioA9lpEpri8T7YjWtVaYTb24=;
        b=WZzzIJ6egYO35IumFbu5lBUWxzlWiUOMtkp9/kL0ypIXrB0hb+Tfs8AFUPXLEMS2bO
         NoyO5fAICPCVOxB4OQ3J/oLO5wfzxUsK5SSJDlqxmGRq8yjUBLfu+doOkS+JcoEhUx2Q
         AbGOknNdSeMOmmfDgR2CchS1hD3TNTiAhQlallK3mHmCIjsZ9+79wW1kuKZVzSUaBP9h
         Vp37GYgQaILWprEj75JNokx1eBxiS1ji3LP1ipY0kD9+HTZq7FBv015q1rpmVF/4FKhZ
         peV5mcuEfGhYZgBOGus4f9LUb2JP/co2dAKIktJ2OteFBB7FXebbYcpv3POBiDMz/kRr
         1dBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793208828; x=1793813628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4x4ogCcrIz3iULJj4AUcmCmwpvZhGjnxniSpLhEijJA=;
        b=hHWgMcjyEXEFs94F0opmrR2osT29gnRS0Wcbon1pb9d0qNq2KamffAiJQABDUWT+t+
         bs1tvpNgwt5Ay4A2BPCuvL+699P5FICIWki9EUnEg6NFcXvWyyhjassWjYurneMOLorv
         632UmjTXENyTpYhAJUOFyvfZEYGE2B0txXFIubn5n+MSPMn96EzmvgP9rpnchfyYONCx
         hSpZLCfLyOG28ATlnQ6uP83+tZLAq+GjSvG1ozkh1OMVWY1W36x/yfZIaFMd4pKdZffZ
         YOxnluTIs1peo/YCOQPxwu3qvKsu+upCyvRTaj72DRybLzdZLSKN9qwvGvz7i6TD2Ogf
         vrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208828; x=1793813628;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4x4ogCcrIz3iULJj4AUcmCmwpvZhGjnxniSpLhEijJA=;
        b=uJiWwRBu5Hxr2BjHHEqTi+UaGP1/1NYBd7Du7iria/67/2SwAfh7uEhr5pnVfUbNaQ
         5l67Wg+Nwq6gRdtien5ZDThhhAFai9YRUV0vi39Xi4tTzpBkxZfSNaFADE1+IEaadkg0
         CyxAtchjs7NzmJbhEyMxN7Q53wNZAPFL6/xvNtM80RbemWFc9MhUIRTjV5nEtJ+vquRP
         19XC2HKIF8A48KVslFa9Cfd/w4Qx5nBeIHW9VNwzF/g+fsbkVdubj/Lsj5StJ/1IFlh9
         zt3JxWrcVztUTnAUOcrWPepMTFlIa+uZpq78fbCZHi/NcgOIPBkeeus1tEWVVaP2LwXL
         C0HQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+5atGjqGcqlq8+clDeDGKNjdRWlwMeVTrizApnLKWBgYM0URfamWiGwkPDUewYLl7MfE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9UM+PkUCMVK+Ob9Q2X/AGDij5+eJq/1RisFML4IDhdxzB4pAx
	a52w8WDUEo4ZrTfUVygLgvTs36RSLrcV4og9ASwg0E+G8eiHoh/yS7mLal4nnrmvyD0dsm22CCu
	LBGrr2t0yHkV+tOmR/avDPkyNcTwM6NslaevYr0wG
X-Gm-Gg: AYBFou0i2IPWG16Aei69JeExRKHN1+tjfwDk24pyVj3rV7sJtIzFKMtnSu5p9vEUkE/
	2AN6i36Y6OWJmnuUO03RelB6mtSrIBFCRVzxgqVUEDIuOnCG62IiyGtheCIvCZwPgksAnDFYpjw
	znZyNIMdyYb0xzVhC6he/1Y0y7oueRMK2v8MeR4kF9jgSj9xBrMTLVqZSAgkqM0CZ34JFm3yZVf
	XaunBncaFATBXcz5gh8m+NWVo5S/rZhOdmYVgtvefH8HsdYFsYDDdleZvoAAazhWLLrm4uEMe55
	NdzMzWfY4NT+r3ZArodfHK+fNCvAhvD2hz1+DvQ4tyNi7ZPsimE9uz2+bBmkUvcDX6uEg2RDSrd
	1PSKsAFPMlsma0pJGNCdUe5FyyJqFQBjiFTj4PPKGjJuni/W+4mkqQIjOeA==
X-Received: by 2002:a05:6402:a204:10b0:6b4:9221:8932 with SMTP id
 4fb4d7f45d1cf-6b4b10d3756mr7408a12.10.1793208827782; Wed, 28 Oct 2026
 10:33:47 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-8-zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-8-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 10:33:35 -0700
X-Gm-Features: AclHuK-cshc-ua1x23QeiEhM2iv4YfYaUSv2c6vItBjWJCU_Q1Z7ZQY_OtyF72s
Message-ID: <CALMp9eRrgBXxFtNLOw0KAjFu_L9ofar_oiJA9WSJk82w75w+bw@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] KVM: x86/pmu: Expose kvm_host_pmu to vendor modules
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
> kvm_host_pmu holds the unadulterated host PMU capabilities, which
> can be used to compare against guest capabilities to determine whether
> certain MSRs should be intercepted by KVM.
>
> Exposing it directly avoids the need to introduce per-field accessors,
> which would add boilerplate without hiding any implementation detail
> worth encapsulating.
>
> Opportunistically, fix typo "Unadultered" in the comment.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
