Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706952D3225
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 02:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650020; cv=pass; b=aU8OCUoYm+RZn5lXv3FFIECp6h6WqOvm1b2fqLtJOU8YqvdWdPdV0/cS49ChAnRzMA/u0d/pKacAPrywqXyLClo2LgHOFpthaAf4ax7SuXfG7ZukUgtnqPUbfwkb6vVNMrZIRHwE9vnDGd9dnlIXCshYc2rhNonyIha7tCS9fAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650020; c=relaxed/simple;
	bh=+JMu39k8t90lMml2PTuqt/SuNIgtnLZvu803sFgpUCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgBCXCVNQzcA5OFNIOgo/vzROJ6QdjuJnBv/zIOMcZaN3eQdpTxewWR2qEAxNhhU3+R2kSqqr5dRlPCCq50O1gl9c6v5Nie338sT/yXhWuckTiUZyz+nqlR9gqZNNxiLtqzyOZnMmzgebdw9OQ+I3el7YwAQ8a0AjFOXeo5MjDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzBAyVhw; arc=pass smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzBAyVhw"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-81be5042c51so1981538a34.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 19:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790650018; cv=none;
        d=google.com; s=arc-20260327;
        b=MA4aO8TzLuN2VKAMglXrRiLAzJflRcOReSamBOs0bL8k3dZRUMun+y6/IVrqYBtBNX
         +FzZhmGCOcDWrdmn4IYCpXzSEkUunmNkb3old58qElt92CKq+8BU+OyddLX6M9mfO5Pv
         MR7VWr4tsuMkdTrla3UQNfDKf5ZOpmGFlxyKFSMyqloksTcHure6cF6kfSDkfqtTw/jS
         YwZyAv2AX1Pl7jCIFHEMssKc0ylH+mGe3lHWPwOKPgGTPOoWrkUi+Qg/R70K2JA0mWMz
         h4DvcoAQuhYfkJsVaWQMv0uY01KRNhGTo4LLvHN4G+3LvnmrKbQgOgOPkK22I3KiA43T
         3WKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0GLky+zMwV+lXLc5wxi80Ewpo+ygveBV5zL10ZyTdtk=;
        fh=Ei3plYL/rol7zNRKgUpaBmmoUjG4nMGGxRq0qQo7wzs=;
        b=jv0uuObtjPr029rk8FbRDY13V7JC55sAXDHahzaAmcrijz7m2p70wyvcWTTzv/BO1e
         rmkECaAROL2GZDsl9KSrTBPMwcSCsniccrejB7JtPdUXNPu5ipLcYFrO/8M8lelMJHTe
         VnPbawqTRDeQp4zV9bFXoGiaJG1di8Ae2wh37fro2bHglS/pv5MRzHXPmRNDmIWPAuX3
         zvxvpRXzRst7COlrcLwgCgYhUjdqS+AKuHHkAIMiiGJcDbZVYOmP9E1nyar9+bDUeE8y
         t9yXClDa5/rVHJ2V3cZFMGe3dso+plKRZs1VkbCmCad3ZQW3LwwNgr4QSUMq5qXX5CUL
         YsxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790650018; x=1791254818; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0GLky+zMwV+lXLc5wxi80Ewpo+ygveBV5zL10ZyTdtk=;
        b=VzBAyVhw9SwP1TgQ4tHJ3WPOIPefHO1HSpIIF+x2Wf0Sn4CUv2snLPi1oFw8pIrb9X
         q4nDbjtaU1h32kpL/7nNAuRnFWxc70yZmRa/PiCLgiHWe7ULKzzPfRuwh6Z0nToxYIX2
         Ks9OxCPv9tVKTsdAzMA2xczlV8u5M3rzc1SOmq4jdSHVelPt9p15CMEpm1ZenwypzO25
         v2xJcfbcf3RZIYmFwwLUz3g69AUttvKqvPV3+MgqBLMNR9XVuf9otucDLSevY/EMM1rj
         x5Uz+wzO3mW1CeqmgPzpnx4nCV8+qrV/5Euqp1Ae8VvzZcJRF8a0C7AwmIj1GdapkEGQ
         K8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790650018; x=1791254818;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0GLky+zMwV+lXLc5wxi80Ewpo+ygveBV5zL10ZyTdtk=;
        b=o2ytrQx4cyE6ISuO/EgPTsxXLgnFJER2Y3+gknV4iXM8Bq0RR3Zsficq7rDOGoItMy
         mZF9h2VyvFc8i/L4YGStrn/fPFOCfb/ulWt5CvTJOtJJCiMKAQwjDqUcZthcPVCzM02E
         YngmKcTMgl287xR9E9RXcvTvF8jXN4mtXH0zKUCj4vqLOzktf8CRRiIcnin04vW6oyOq
         GiPbVBjTVUFTSbN+YUNwD9gil1jSbCHTOFrknYJucWUqakuLc04Rh+gwnzML7TeWwfNQ
         4/QiIQgqRvBNpTAZnAX9ksBUIAi0vA8/5MdQCw1fsinj0TFTcOcBPskISjGXpXUOhEeS
         C6HQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxNAK2kHEoG6LibIJ5izcVZihVTQrL4OwXPXLIDHF7vD9OuI8KwA1BJW77V+Rjy8IYuYo=@vger.kernel.org
X-Gm-Message-State: AFuF++mq0IEG3gl97luRyyHvOnvKD0rl4Ausbc3jzAIce5Zkz0Tjx5/0
	i33XNM549LDwvzMkkr8i9nrfRoM2mDNMJlkqYIsb39Y07AT3OtuI4bpo3/S/IXt+igw2vGcIeMZ
	DTDjwnSwiw+wrBv3Kzq6EdeQ2OJu8MMw=
X-Gm-Gg: AYBFou0WZhTIanrSWsmyDnHpq/XN02g3B0Hwbvbxf6jAVa/AGuwtG4kop8KJM6lbiq/
	zv5hYY6iiUcd3pGhcWw18RME8i7OtNF5nTfW4z8TQ86L7Py36U/0SW2z9JdNrNBG07wG2NYjimG
	2FVMvC9awiLLgN/BZiIrHElwY4SkAJI8yIdtSqR358BhZFOpyEsr6LvduOPCWrbm4BzC2I3hh6o
	AAMnLogVpjhpOHWgarYeDMp4cz1WsDW6EkNis5EcKuTwRBjF16BcVUTKV8D611UNY3W/JA7dmws
	RHLJfQOKz3qphuGlZshF2bL7axZj38SI1RellZY4oNpWY9kLQIcQN7gGlSLyzEmt6w==
X-Received: by 2002:a05:6808:1495:b0:4cb:f21c:a7a0 with SMTP id
 5614622812f47-4d72ac548c1mr17435493b6e.40.1790650018230; Mon, 28 Sep 2026
 19:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820123512.87236-1-duankeqiangcym@gmail.com> <arrwQKQJpFZtARmN@google.com>
In-Reply-To: <arrwQKQJpFZtARmN@google.com>
From: Keqiang Duan <duankeqiangcym@gmail.com>
Date: Tue, 29 Sep 2026 10:46:46 +0800
X-Gm-Features: AclHuK8mMnu4MvWcyqvFMSXacZLsQfPg_SuyLmkpDnlhsh7cHQGVbBVXMe35tyo
Message-ID: <CAMd06Xdgp3y36msuro8W+X9eLwXDR29KLADtTObN+41bRr78MA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Clear hardware HLT state when userspace
 makes a vCPU not-halted
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Qinguang Chen <chenqinguang@kuaishou.com>, 
	Zhiping Du <duzhiping@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"

> Anyways, unless someone cares enough to want to back up the claim that spurious
> wakeups are ok, I'll just drop that line when applying.  I don't see any reason
> to mention spurious wakes: the vCPU is clearly being moved out of HALTED state,
> it's on userspace not to screw up (for this particular case; there are other live
> migration issues that userspace can't solve).

You're right, I was conflating the software convention (every HLT is
inside a loop) with
an architectural guarantee.  The SDM and APM are clear on what
actually wakes HLT,
and neither mentions spurious wakeups.

Please go ahead and drop that line.  Thanks for catching it.
