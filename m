Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793366122;
	b=ADdHNJn0mPEAm7NYN1PiY1hFBKh4QGd0wfnmf5asq6y8/559VS/7k4+fiu06aavPI1gS
	 0jAaguxY2VSaBHvUagD1ORk5nEXwjT9TqXbxmh66vpmvexCNkwXW3/5Fq1GGEPMSzIpq0
	 pB1mOzgsIkzvdtk1FJUP5jIEfcGojsawbZcSUQEqSvgmxNxUc6t7TId9d/CSQYhHmcpUz
	 o5hPH8c9GW3Gs9YN2i9NPSZnDzuKiL1yMFboDqrRoOgZBNwv5jdLthNjKB0KBuKvpb31f
	 iq4zXPnRWANmMqDkbg37PuRZ2tPksOebbzrSJuBwqhC5IbUAYt9q1LcruOLWPOo2PEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793366122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=flSyLSnr13yYjOEHTPxlFf/254Itc/t+WXiaXgORDKY=;
	b=204yh/bvF87s2c41HTOIQFpwzrcZodbwoaikQkEmyK871kcCODNtqUYkq+3oEe6oDCY/
	 9veEyVXE7ufFGqaU/YCDqVvOOAUGZABoGYnZxHzUivJ7a0z2pHdvIhd782g4y1A01CeKa
	 tJoBa+PPX2qmNhi2blfnPgqQ9ryFw+F7S4DwNgBBJXpYe6lO09cmm266cU8DJhnlD5UIA
	 89/0y30N7k0l17xUHl0Hbn2Y5T1L0GnSuOxNrjQdC7m/+KWlBu3Xg1zpD3gJX7JAxDZ80
	 hhdshJnRIPSo+J41Jx/e7WxJvzrGYXGgt7s/QLHC3uSBqp291V8ssem1zrViSXC6Idg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XmP75mV3;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A117606A31F
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 13:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A117606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XmP75mV3
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-369f3e9e431so568504eec.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 06:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793366121; x=1793970921; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=flSyLSnr13yYjOEHTPxlFf/254Itc/t+WXiaXgORDKY=;
        b=XmP75mV3neSqZ22BCv35kRM/Wm3vPyca4tPolWX1a69c/hYMeB4QTg//T+7dyBId7J
         9kTrfUoQzQgh7Fv67xnr8TRo2oZ6DnGTuh0RJrQsMUJsvl5MGRki3phVoa10KhO6uLOQ
         HPKQ2Gknd8SkAtmVZJVKe1M/MiwnhMt5pB0Ot7VCXPqLwcJeMOmUv+xmLt9Ep1dhtv2F
         FTGw00XcOZC8XWJMdqeuVppo9LkVY20+uHvGckz3QFPbgS4qQzy+Nub8qDvbUaTWrdL/
         7HIe853SBAp1UF5XhHNpO4RkYDmr4a0H2fJaxobMV/Y6ZYFXSrfsl4C3O/g2dBw1yrEq
         GJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793366121; x=1793970921;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=flSyLSnr13yYjOEHTPxlFf/254Itc/t+WXiaXgORDKY=;
        b=VpagRdbdTNzgvC3ZuS8VoWxqI/UYBUVlie7kdmJo8x0jGAcSzCekC/ZfyRR3e/utJq
         kjt+YoIjrdzi+k4KyPhhbFTGVnEbJuuc5xYVVuwVq/UAbus/MoRrBWZDxOZT+Ek7pJNQ
         Mpty3HVQWnwtzzob55tN2p+WADi5vurSix80J8vZqC+jjA2/FoiLCVWQIdnVkKMMxa40
         1/BAYPpf4R3DtPH1Ghuv/o+y8d6HzB5Drnk2SZrSay8Q/rk1LCsqkR3xTZ23kWSmc0/D
         bAOw+OY2yG+CJUI5AP14bUgFw7ZnOS1irKLO03G+ZNTJtgOm24fMLuuunbYQqDXTh+sl
         fS0g==
X-Forwarded-Encrypted: i=1; AKwUvBy8efUd2i0Z/Ijjt8OpmhLslC/bqv0wMHJOQFBPD6xALYELY9Ui1M9E2tXizMBlmpHwxlI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQEyQQuRhjVEpFyURDIl2F0taAI0cIIE1CYcEEmj8u083uXlhp
	Hm0jt+5nY3lAK9doII70vA5kZYZfvf76IPSUaVK2LY3fVEgORWQqcKNQ
X-Gm-Gg: AYBFou3rCwZidvB3Flsab2auMTmoVXxFP4pzPQNRgyQHWxmt3hvlla+F1nay/6MlySP
	dpy2QSAWYedQXyWUs14RgfBeyhvcOPz0FFPGXtttGJsCMuhFtl1sq+FiSwp8lDWbnaRt92Dxf1y
	R0lp+NYw27GAMN2HpARrqRJeBamHizIh2n1pkaTUcX838totTIbJvP/+HK0/VyvwOU/bjCiPPU7
	Z4kdAUUg3ExUjOsvmvWLWiY3n3qtDYoL/34URO18lhZJII0P/xDdSppjMAcRt2UcdZD8fQPgN+E
	FObW/PNtDiDKu3FXok+q1ZnCkPNmJ75nbmF6CRYNz9EBHuX7jTWdh8n8zngxFJcqBeiwe5fEUsa
	NKwxbmLAi2b2/0v8FZC/LboVA7oer0fcGxxjQ/u07q2N7xDQz/oAMu4yFhYb3bS9S2q/fp9PEOp
	2xXWKlLS7HujRhLcVRDwyuRc1zA8glBilx/kEuA7ZCNNFm8GY+Yn/R7Yg+aNyr77Au8oGRmRoEi
	/W5YGbnHydBM5WM30nnz0JSn8cDx1oiPYrxNCOFWFQqXZ5eSXnxg164H7dHcForNVttU8sHfx5+
	AVGF2xPr6WGeh2bq9sg5tW7fA+A=
X-Received: by 2002:a05:7300:3d0a:b0:35e:2c6:d462 with SMTP id 5a478bee46e88-36a2fc203c3mr7157186eec.0.1793366121263;
        Fri, 30 Oct 2026 06:15:21 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a426681aesm10056827eec.1.2026.10.30.06.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:15:19 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/4] KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
In-Reply-To: <20261012082922.218799-3-gautam@linux.ibm.com>
Date: Fri, 30 Oct 2026 18:43:54 +0530
Message-ID: <a4nvwctp.ritesh.list@gmail.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com> <20261012082922.218799-3-gautam@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Gautam Menghani <gautam@linux.ibm.com> writes:

> In kvmppc_xive_connect_vcpu(), if any failures are encountered, the
> control flow jumps to the 'bail' label where kvmppc_xive_cleanup_vcpu()
> is called. This cleanup function exits prematurely since
> vcpu->arch.irq_type is set to KVMPPC_IRQ_DEFAULT at this point. This ends
> up resulting in wasted memory.
>
> Fix this by setting irq_type to KVMPPC_IRQ_XICS before vcpu configuration
> starts. This makes XICS initialization symmetrical to XIVE
> initialization done in kvmppc_xive_native_connect_vcpu().
>
> Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
> Cc: stable@vger.kernel.org # 4.12+
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>

Mainly fixes the error handling / cleanup routine in
kvmppc_xive_connect_cpu(). The fix looks good to me, feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

