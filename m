Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF8438479
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226076; cv=pass; b=AdoNRR750ZzeA+/XRnoHFu0EbYS4OPD/akFPR2AzWXtFcVPgMNJMjYFUHNMqfwESQapXMcE83ZjouIaNhyju4aM3vR36Jk/2uncxE686yit0jyGevI/8RhahTxlIYJpAGPndbLAbnDAjsR1hISpu8ttd9JBUQXGIvJD7r6s/L1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226076; c=relaxed/simple;
	bh=6IQSq07o/Ir+aAEjXoSKNL0RcBsdUzy6t2o10QBBevA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scOa55sJffD0BSy1OdMC0I2oqky4DwBx911d+o109YSJ66px1hS08M2l31mOmYfq3pw2yRGWR152GPQuQlt78WDGLXa9U38r5GZqaIzJyjV4gqVf4XhTyL6TzB3jgkkZzRfzGLFxEUXq+aD/ZUAL6bHqAr/rDPg+Xw/qU7pEvws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oAmnUN7l; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAmnUN7l"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-49ff971e903so621645b6e.0
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 04:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787226074; cv=none;
        d=google.com; s=arc-20260327;
        b=kz0iF8B6fkgxA4KsIaNPhQJCCUnbo1ofqWctukJSxoio4G1pr4nCEBZpHQ4Nhtw7Tj
         C4AyumyL1wTfRyBET6IUbs1bX2BIqZwGLD1PLgZ4t0JdKDGs4n3R+zdLLsamTY+3Zj3m
         wgMKR/ZPRjS4cccpbo7NbIpV2BC3kagqwqXaQVyGEPQCJ66UG8g2PdaukZRGw2Mz7vkB
         5jZrIS6giAxdm+wSEi8YmS1iw0gt9/7mLjwO7/K4gDi2GLOOgJ0W66K11HmbhKrhgjak
         fAN65uWuhr1Z3SzS+GpLE/K9CiHX+ZVjzVTWqsZI98ZQly2+tbn+kN4yWAn4BkWycuzS
         yjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Vwo1LenmOII7Z67ayqdNDGxIVSqjq55z7Fu8p8GGYM0=;
        fh=MWdmohO2IHQPH86urIAdMpzogKFbBsKdTkh7B/U/XzY=;
        b=RYnlBg6k2kN0B8xgyfYnM+eWehirxYHTLqg9zcUd/2VTCd8qgNOAsV85GvJPZw4mv+
         wNrbiJ/uSoyyb8X3KfP8e4pSiroOMMdrZ9ItXqDk5B7i9DoaHDLOtyBpR22svWJnAjpN
         SM+uAKerU2f+hAf8eeIhSPyX82T+K85QytJrX7XXC5mEyw+WwnfARVVDQkgpSjNm7Vhl
         TCXr83w5TiFsj50Iurf2yzj6u68BH0Ewdg+vG+hkaO9M5iTplUc7cXSheaNGr3GfFU3N
         oe87MK7H3VXwUa8WYlapqPbSwzE1GmFJfyYPjo8PB6Qx6OmdwRHd9/pY+TTy9dn3ao7k
         54Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787226074; x=1787830874; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vwo1LenmOII7Z67ayqdNDGxIVSqjq55z7Fu8p8GGYM0=;
        b=oAmnUN7l6rholwSzuna4R5H2UIS5cXPSnJ0QgEsbVpDToxR0NdCp8hQQPVjMNKHQt5
         12jtPP6Dg4M6NbW/DQhL73XIbsBAalmgy48ZT2Q6VUMyJLqfehq3phU4iGi2tvYC92Kw
         1dCpAHy1wYjXWCY5N2gr88tiSEgxShSn5Uf9h6pSB3wzAn2Csd6ju8gAE+d1WueX2Qq4
         2iBNuMXyvpRVgMWsJpToo/sYrBB+UJQA5Dk7XoWthxGsUpmQ7GTGJGhufMZM8G2XbRWZ
         rA73sMS8HZzMDhexc5PbLa6kRT6SCcfwtP39Khz08nt+KWLWQ6xMdKbiqfMAC+qjTSAZ
         1caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787226074; x=1787830874;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Vwo1LenmOII7Z67ayqdNDGxIVSqjq55z7Fu8p8GGYM0=;
        b=HpAFaQy2Qao89ye9i2Qmm0Gr3tSzVB+zGZoXm43G1xVn25MW80Gdj+tNdlzeTu45tp
         gc9+1cB6TmaVro+9eIOD71FnPN6CCCdSNw2P02Xq41srtSiZEBTIvQlDEoHbscCoYIUo
         xnue3nntnKclt3MiqmKCbXlgKPKjwV8jTkrqX2cjqcbQhVpw1VuH/R+L/rUYzy2gKnpF
         H40cayenEJAdpVtMcXwHDY2EP1y5HdmSH2RKaX47kyOHKiVQuXLBoA7LbIJ6TBhLsjf2
         xMbBOWs0MhiauTL/RIgE5FexY5jI4wfuLW8x9P6+XD5RQ48Zvpt9E7kC5zsICPLeY1aL
         FzGw==
X-Forwarded-Encrypted: i=1; AHgh+RpGIbhWNp62xkV7GgA3vN8PXnVJeD47JTo6XQW649iUdJV85FkmTOoHtwjR3XWux+X1Zqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymQAIeNzD0iLsNHDLaMgqH/CnLDzadlrbiB1ooo6heBo7UG8wl
	en9BGS9SZhdTDZXG3TwzaFs9fPOPNwwov4lQmi7n7Y+GTmebYfJhByu/iUPvVvu/8kUPOGwVH+g
	hwivlqF65g1egf49EBDaWyr9TZK/ZtWA=
X-Gm-Gg: AR+sD12/c0Aewa80yCLQsPvqWrBbyu5bpde8I4sdYloKgRrhXu+26p2XEvNvNuaIeRU
	PUVLi5oppZaa51482ddpahQbF7WdGpZI3qU91cRZY1BtpdDRv9kfrzyzhPH4ro52kaknfgeKAhp
	8QPN7Qb6OyoXfqvy4blKlYNBsjn6G+zjXwZdznUi065ZiBZcN0PNJ5LwIiXbXy+I/bsbi2JMrZy
	qFMI4bot0P/9ZkPlIlvDqyFlYCPlxuqld0zY3CfVuVAMIHeAaPgPV0o0jfroZOj+PYkjgYG0Ndb
	SDGUgxcXy5swA1iMU6Owwh78TJXgUsmn/CmU0jlySw8A
X-Received: by 2002:a05:6808:f8b:b0:4a4:cedc:6859 with SMTP id
 5614622812f47-4b2cdb56ae5mr4743085b6e.4.1787226074349; Thu, 20 Aug 2026
 04:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819034652.98938-1-duankeqiangcym@gmail.com>
 <aoW3fOhPuFY7Whia@intel.com> <aoXJpPDqwu4IlmdX@google.com>
In-Reply-To: <aoXJpPDqwu4IlmdX@google.com>
From: keqiang duan <duankeqiangcym@gmail.com>
Date: Thu, 20 Aug 2026 19:41:01 +0800
X-Gm-Features: AcwNN1UfnbAUM-lAYdJoYYjFA1U-KlBYqSG4e-dhdBg2HrmLwz2RWuNdt-gRAwk
Message-ID: <CAMd06XcxqNassViy4hqFpJ-Qm4aV5k8dEZG1wpDOGAs_YMp2zg@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Clear GUEST_ACTIVITY_STATE when userspace makes
 a vCPU RUNNABLE
To: Sean Christopherson <seanjc@google.com>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 19, 2026, Sean Christopherson wrote:
> Thanks Chao, I knew this sounded familiar!
> As suggested in the above link, the call into vendor code should be gated on
> kvm_hlt_in_guest().  Yes, vmx_clear_hlt() already does that, but it's a cheap
> check and makes the common x86 code easier to understand.

Done in v2.

> The other difference between my suggestion and this patch is clearing HLT if and
> only if the vCPU is being made RUNNABLE, versus clearing HLT if the vCPU is being
> put into any state other than HALTED.  In practice it probably doesn't matter?
>
> AP_RESET_HOLD is unsupported for VMX, SIPI_RECEIVED is deprecated and is now just
> a variant off INIT_RECEIVED, and getting out of INIT_RECIEVED and UNINITIALIZED
> requires stuffing RUNNABLE or going through vmx_vcpu_reset(), which explicitly
> sets the activity state to GUEST_ACTIVITY_ACTIVE.
>
> But I think my vote would still be to do:
>
>     mp_state->mp_state != KVM_MP_STATE_HALTED
>
> because I can't think of any reason not to?

Agreed, and I can't think of one either.  HALTED is the only target state for
which retaining the hardware halted state is meaningful, and as you note, every
other transition either can't be reached on VMX or goes through
vmx_vcpu_reset(), which stuffs GUEST_ACTIVITY_ACTIVE anyways.

Keying off "not HALTED" also states the intent more directly, i.e. that KVM
only ever drops the hardware halted state and never installs it.

Switched to "mp_state->mp_state != KVM_MP_STATE_HALTED" in v2.

> Side topic, I think we should officially take an erratum in
> Documentation/virt/kvm/x86/errata.rst to state that KVM doesn't support save/restore
> of HLT state when HLT-exiting is disabled.  AFAIK, there's simply no sane solution
> for SVM, and that would justify why the kvm_x86_ops would be clear_hlt() as opposed
> to set_mp_state(), i.e. why KVM only handles taking vCPUs out of HLT, not putting
> them into HLT.

Agreed, documenting the limitation makes sense, and it does explain why the hook
only takes vCPUs out of HLT.

Thanks for the quick review!
